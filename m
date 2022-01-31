Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865F34A49B7
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiAaO4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 09:56:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4565 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiAaO4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 09:56:21 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnWH43Kzcz686d6;
        Mon, 31 Jan 2022 22:51:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 15:56:19 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 14:56:18 +0000
Date:   Mon, 31 Jan 2022 14:56:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 13/40] cxl/core/port: Make passthrough decoder init
 implicit
Message-ID: <20220131145613.00001893@Huawei.com>
In-Reply-To: <164298418778.3018233.13573986275832546547.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298418778.3018233.13573986275832546547.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 Jan 2022 16:29:47 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Unused CXL decoders, or ports which use a passthrough decoder (no HDM
> decoder registers) are expected to be initialized in a specific way.
> Since upcoming drivers will want the same initialization, and it was
> already a requirement to have consumers of the API configure the decoder
> specific to their needs, initialize to this passthrough state by
> default.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Make sense to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c      |    5 -----
>  drivers/cxl/core/port.c |    9 ++++++++-
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 0b267eabb15e..4e8086525edc 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -264,11 +264,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	if (IS_ERR(cxld))
>  		return PTR_ERR(cxld);
>  
> -	cxld->interleave_ways = 1;
> -	cxld->interleave_granularity = PAGE_SIZE;
> -	cxld->target_type = CXL_DECODER_EXPANDER;
> -	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
> -
>  	device_lock(&port->dev);
>  	dport = list_first_entry(&port->dports, typeof(*dport), list);
>  	device_unlock(&port->dev);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2910c36a0e58..826b300ba950 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -505,7 +505,8 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>   * some address space for CXL.mem utilization. A decoder is expected to be
>   * configured by the caller before registering.
>   *
> - * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + * Return: A new cxl decoder to be registered by cxl_decoder_add(). The decoder
> + *	   is initialized to be a "passthrough" decoder.
>   */
>  static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  					     unsigned int nr_targets)
> @@ -537,6 +538,12 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  	else
>  		cxld->dev.type = &cxl_decoder_switch_type;
>  
> +	/* Pre initialize an "empty" decoder */
> +	cxld->interleave_ways = 1;
> +	cxld->interleave_granularity = PAGE_SIZE;
> +	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
> +
>  	return cxld;
>  err:
>  	kfree(cxld);
> 

