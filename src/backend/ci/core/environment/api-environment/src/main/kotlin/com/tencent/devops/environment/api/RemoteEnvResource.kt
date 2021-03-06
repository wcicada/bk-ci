package com.tencent.devops.environment.api

import com.tencent.devops.common.api.pojo.Page
import com.tencent.devops.common.api.pojo.Result
import com.tencent.devops.environment.pojo.EnvWithPermission
import io.swagger.annotations.Api
import io.swagger.annotations.ApiOperation
import io.swagger.annotations.ApiParam
import javax.ws.rs.Consumes
import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.PathParam
import javax.ws.rs.Produces
import javax.ws.rs.QueryParam
import javax.ws.rs.core.MediaType

@Api(tags = ["SERVICE_ENVIRONMENT_AUTH"], description = "服务-环境服务-权限中心")
@Path("/service/environment/auth")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
interface RemoteEnvResource {

    @ApiOperation("分页获取环境列表")
    @GET
    @Path("/projects/{projectId}/list/")
    fun listEnvForAuth(
        @ApiParam("项目ID", required = true)
        @PathParam("projectId")
        projectId: String,
        @ApiParam("起始位置", required = false)
        @QueryParam("offset")
        offset: Int? = null,
        @ApiParam("步长", required = false)
        @QueryParam("limit")
        limit: Int? = null
    ): Result<Page<EnvWithPermission>>

    @ApiOperation("获取环境信息")
    @GET
    @Path("/infos")
    fun getEnvInfos(
        @ApiParam("节点Id串", required = true)
        @QueryParam("envIds")
        envIds: List<String>
    ): Result<List<EnvWithPermission>>

    @ApiOperation("分页获取环境列表(名称模糊匹配)")
    @GET
    @Path("/projects/{projectId}/searchByName/")
    fun searchByName(
        @ApiParam("项目ID", required = true)
        @PathParam("projectId")
        projectId: String,
        @ApiParam("起始位置", required = false)
        @QueryParam("offset")
        offset: Int? = null,
        @ApiParam("步长", required = false)
        @QueryParam("limit")
        limit: Int? = null,
        @ApiParam("环境名称", required = true)
        @QueryParam("envName")
        envName: String
    ): Result<Page<EnvWithPermission>>
}