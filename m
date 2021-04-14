Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F8E35F41A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhDNMku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 08:40:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2854 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhDNMiu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 08:38:50 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FL21x1tzBz68B6P;
        Wed, 14 Apr 2021 20:33:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 14 Apr 2021 14:38:26 +0200
Received: from localhost (10.52.122.47) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 14 Apr
 2021 13:38:25 +0100
Date:   Wed, 14 Apr 2021 13:36:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mem: Add media provisioning required commands
Message-ID: <20210414133658.00004b79@Huawei.com>
In-Reply-To: <20210413140907.534404-1-ben.widawsky@intel.com>
References: <20210413140907.534404-1-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.47]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 13 Apr 2021 07:09:07 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Some of the commands have already been defined for the support of RAW
> commands (to be blocked). Unlike their usage in the RAW interface, when
> used through the supported interface, they will be coordinated and
> marshalled along with other commands being issued by userspace and the
> driver itself. That coordination will be added later.
> 
> The list of commands was determined based on the learnings from
> libnvdimm and this list is provided directly from Dan.
> 
> Recommended-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Checked all the numbers (not much else in this one ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

You could give more info on why this particular list, but to my
mind it's all fairly obvious so perhaps not worth bothering.

> ---
>  drivers/cxl/mem.c            | 19 +++++++++++++++++++
>  include/uapi/linux/cxl_mem.h | 12 ++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index e915e3743b76..e3306aa560cf 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -50,7 +50,14 @@ enum opcode {
>  	CXL_MBOX_OP_GET_LSA		= 0x4102,
>  	CXL_MBOX_OP_SET_LSA		= 0x4103,
>  	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
> +	CXL_MBOX_OP_GET_ALERT_CONFIG	= 0x4201,
> +	CXL_MBOX_OP_SET_ALERT_CONFIG	= 0x4202,
> +	CXL_MBOX_OP_GET_SHUTDOWN_STATE	= 0x4203,
>  	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
> +	CXL_MBOX_OP_GET_POISON		= 0x4300,
> +	CXL_MBOX_OP_INJECT_POISON	= 0x4301,
> +	CXL_MBOX_OP_CLEAR_POISON	= 0x4302,
> +	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>  	CXL_MBOX_OP_MAX			= 0x10000
> @@ -158,6 +165,18 @@ static struct cxl_mem_command mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_LSA, 0x8, ~0, 0),
>  	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
>  	CXL_CMD(GET_LOG, 0x18, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
> +	CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
> +	CXL_CMD(SET_LSA, ~0, 0, 0),
> +	CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
> +	CXL_CMD(SET_ALERT_CONFIG, 0xc, 0, 0),
> +	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
> +	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> +	CXL_CMD(GET_POISON, 0x10, ~0, 0),
> +	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
> +	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
> +	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> +	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> +	CXL_CMD(GET_SCAN_MEDIA, 0, ~0, 0),
>  };
>  
>  /*
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 3155382dfc9b..f6e8a005b113 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -29,6 +29,18 @@
>  	___C(GET_LSA, "Get Label Storage Area"),                          \
>  	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
>  	___C(GET_LOG, "Get Log"),                                         \
> +	___C(SET_PARTITION_INFO, "Set Partition Information"),            \
> +	___C(SET_LSA, "Set Label Storage Area"),                          \
> +	___C(GET_ALERT_CONFIG, "Get Alert Configuration"),                \
> +	___C(SET_ALERT_CONFIG, "Set Alert Configuration"),                \
> +	___C(GET_SHUTDOWN_STATE, "Get Shutdown State"),                   \
> +	___C(SET_SHUTDOWN_STATE, "Set Shutdown State"),                   \
> +	___C(GET_POISON, "Get Poison List"),                              \
> +	___C(INJECT_POISON, "Inject Poison"),                             \
> +	___C(CLEAR_POISON, "Clear Poison"),                               \
> +	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
> +	___C(SCAN_MEDIA, "Scan Media"),                                   \
> +	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

