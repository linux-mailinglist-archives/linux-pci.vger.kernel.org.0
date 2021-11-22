Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFEF4592AD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 17:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbhKVQLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 11:11:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4136 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhKVQLm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 11:11:42 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyXHY133wz67F8F;
        Tue, 23 Nov 2021 00:08:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 17:08:33 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 16:08:33 +0000
Date:   Mon, 22 Nov 2021 16:08:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 10/23] cxl/core: Convert decoder range to resource
Message-ID: <20211122160831.000035eb@Huawei.com>
In-Reply-To: <20211120000250.1663391-11-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-11-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:37 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL decoders manage address ranges in a hierarchical fashion whereby a
> leaf is a unique subregion of its parent decoder (midlevel or root). It
> therefore makes sense to use the resource API for handling this.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Changes since RFCv2
> - Switch to DEFINE_RES_MEM from NAMED variant (Dan)
> - Differentiate CFMWS resources and other decoder resources (Ben)
> - Make decoder resources be range, nor resource (Dan)
> - Set decoder name in cxl_decoder_add() (Dan)
> ---
>  drivers/cxl/acpi.c     | 16 ++++++----------
>  drivers/cxl/core/bus.c | 19 +++++++++++++++++--
>  drivers/cxl/cxl.h      |  8 ++++++--
>  3 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 7cfa8b568013..3415184a2e61 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -108,10 +108,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>  	cxld->target_type = CXL_DECODER_EXPANDER;
> -	cxld->range = (struct range){
> -		.start = cfmws->base_hpa,
> -		.end = cfmws->base_hpa + cfmws->window_size - 1,
> -	};
> +	cxld->platform_res = (struct resource)DEFINE_RES_MEM(cfmws->base_hpa,
> +							     cfmws->window_size);
>  	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
>  	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
>  
> @@ -127,8 +125,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		return 0;
>  	}
>  	dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\n",
> -		dev_name(&cxld->dev), phys_to_target_node(cxld->range.start),
> -		cfmws->base_hpa, cfmws->base_hpa + cfmws->window_size - 1);
> +		dev_name(&cxld->dev),
> +		phys_to_target_node(cxld->platform_res.start), cfmws->base_hpa,
> +		cfmws->base_hpa + cfmws->window_size - 1);
>  
>  	return 0;
>  }
> @@ -267,10 +266,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	cxld->interleave_ways = 1;
>  	cxld->interleave_granularity = PAGE_SIZE;
>  	cxld->target_type = CXL_DECODER_EXPANDER;
> -	cxld->range = (struct range) {
> -		.start = 0,
> -		.end = -1,
> -	};
> +	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
>  
>  	device_lock(&port->dev);
>  	dport = list_first_entry(&port->dports, typeof(*dport), list);
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 17a4fff029f8..8e80e85350b1 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -46,8 +46,14 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +	u64 start = 0;
>  
> -	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
> +	if (is_root_decoder(dev))
> +		start = cxld->platform_res.start;
> +	else
> +		start = cxld->decoder_range.start;
> +
> +	return sysfs_emit(buf, "%#llx\n", start);
>  }
>  static DEVICE_ATTR_RO(start);
>  
> @@ -55,8 +61,14 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  			char *buf)
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +	u64 size = 0;
>  
> -	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
> +	if (is_root_decoder(dev))
> +		size = resource_size(&cxld->platform_res);
> +	else
> +		size = range_len(&cxld->decoder_range);
> +
> +	return sysfs_emit(buf, "%#llx\n", size);
>  }
>  static DEVICE_ATTR_RO(size);
>  
> @@ -548,6 +560,9 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  	if (rc)
>  		return rc;
>  
> +	if (is_root_decoder(dev))
> +		cxld->platform_res.name = dev_name(dev);
> +
>  	return device_add(dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d39d45f4a770..ad816fb5bdcc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -179,7 +179,8 @@ enum cxl_decoder_type {
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
>   * @id: kernel device name id
> - * @range: address range considered by this decoder
> + * @platform_res: address space resources considered by root decoder
> + * @decoder_range: address space resources considered by midlevel decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> @@ -190,7 +191,10 @@ enum cxl_decoder_type {
>  struct cxl_decoder {
>  	struct device dev;
>  	int id;
> -	struct range range;
> +	union {
> +		struct resource platform_res;
> +		struct range decoder_range;
> +	};
>  	int interleave_ways;
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;

