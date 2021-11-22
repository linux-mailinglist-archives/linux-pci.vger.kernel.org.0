Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BF04592CC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhKVQQX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 11:16:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4137 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhKVQQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 11:16:22 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyXNx5S1Cz6GDMf;
        Tue, 23 Nov 2021 00:12:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 17:13:14 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 16:13:13 +0000
Date:   Mon, 22 Nov 2021 16:13:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 11/23] cxl/core: Document and tighten up decoder APIs
Message-ID: <20211122161312.000045b0@Huawei.com>
In-Reply-To: <20211120000250.1663391-12-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-12-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:38 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Since the code to add decoders for switches and endpoints is on the
> horizon it helps to have properly documented APIs. In addition, the
> decoder APIs will never need to support a negative count for downstream
> targets as the spec explicitly starts numbering them at 1, ie. even 0 is
> an "invalid" value which can be used as a sentinel.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> 
> This is respun from a previous incantation here:
> https://lore.kernel.org/linux-cxl/20210915155946.308339-1-ben.widawsky@intel.com/
> ---
>  drivers/cxl/core/bus.c | 33 +++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h      |  3 ++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 8e80e85350b1..1ee12a60f3f4 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -495,7 +495,20 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>  	return rc;
>  }
>  
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> +/**
> + * cxl_decoder_alloc - Allocate a new CXL decoder
> + * @port: owning port of this decoder
> + * @nr_targets: downstream targets accessible by this decoder. All upstream
> + *		ports and root ports must have at least 1 target.
> + *
> + * A port should contain one or more decoders. Each of those decoders enable
> + * some address space for CXL.mem utilization. A decoder is expected to be
> + * configured by the caller before registering.
> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + */
> +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +				      unsigned int nr_targets)
>  {
>  	struct cxl_decoder *cxld, cxld_const_init = {
>  		.nr_targets = nr_targets,
> @@ -503,7 +516,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  	struct device *dev;
>  	int rc = 0;
>  
> -	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> +	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
>  		return ERR_PTR(-EINVAL);
>  
>  	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> @@ -535,6 +548,22 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
>  
> +/**
> + * cxl_decoder_add - Add a decoder with targets
> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * Certain types of decoders may not have any targets. The main example of this
> + * is an endpoint device. A more awkward example is a hostbridge whose root
> + * ports get hot added (technically possible, though unlikely).
> + *
> + * Context: Process context. Takes and releases the cxld's device lock.
> + *
> + * Return: Negative error code if the decoder wasn't properly configured; else
> + *	   returns 0.
> + */
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  {
>  	struct cxl_port *port;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ad816fb5bdcc..b66ed8f241c6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -288,7 +288,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
> +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +				      unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
>  

