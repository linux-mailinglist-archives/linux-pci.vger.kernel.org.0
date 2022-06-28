Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61AD55E99A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbiF1PY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346891AbiF1PYy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 11:24:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDFD2E6A3;
        Tue, 28 Jun 2022 08:24:49 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXT044B79z6880d;
        Tue, 28 Jun 2022 23:24:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 17:24:47 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 16:24:47 +0100
Date:   Tue, 28 Jun 2022 16:24:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 05/46] cxl/core: Drop ->platform_res attribute for root
 decoders
Message-ID: <20220628162445.00001229@Huawei.com>
In-Reply-To: <165603873619.551046.791596854070136223.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603873619.551046.791596854070136223.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 19:45:36 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Root decoders are responsible for hosting the available host address
> space for endpoints and regions to claim. The tracking of that available
> capacity can be done in iomem_resource directly. As a result, root
> decoders no longer need to host their own resource tree. The
> current ->platform_res attribute was added prematurely.
> 
> Otherwise, ->hpa_range fills the role of conveying the current decode
> range of the decoder.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

One trivial moan inline about sneaky whitespace fixes, I'll cope if you really
don't want to move that to a separate patch though :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c      |   17 ++++++++++-------
>  drivers/cxl/core/pci.c  |    8 +-------
>  drivers/cxl/core/port.c |   30 +++++++-----------------------
>  drivers/cxl/cxl.h       |    6 +-----
>  4 files changed, 19 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 40286f5df812..951695cdb455 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -108,8 +108,10 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>  	cxld->target_type = CXL_DECODER_EXPANDER;
> -	cxld->platform_res = (struct resource)DEFINE_RES_MEM(cfmws->base_hpa,
> -							     cfmws->window_size);
> +	cxld->hpa_range = (struct range) {
> +		.start = cfmws->base_hpa,
> +		.end = cfmws->base_hpa + cfmws->window_size - 1,
> +	};
>  	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
>  	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
>  
> @@ -119,13 +121,14 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	else
>  		rc = cxl_decoder_autoremove(dev, cxld);
>  	if (rc) {
> -		dev_err(dev, "Failed to add decoder for %pr\n",
> -			&cxld->platform_res);
> +		dev_err(dev, "Failed to add decoder for [%#llx - %#llx]\n",
> +			cxld->hpa_range.start, cxld->hpa_range.end);
>  		return 0;
>  	}
> -	dev_dbg(dev, "add: %s node: %d range %pr\n", dev_name(&cxld->dev),
> -		phys_to_target_node(cxld->platform_res.start),
> -		&cxld->platform_res);
> +	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> +		dev_name(&cxld->dev),
> +		phys_to_target_node(cxld->hpa_range.start),
> +		cxld->hpa_range.start, cxld->hpa_range.end);
>  
>  	return 0;
>  }
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c4c99ff7b55e..7672789c3225 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -225,7 +225,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
>  {
>  	struct range *dev_range = arg;
>  	struct cxl_decoder *cxld;
> -	struct range root_range;
>  
>  	if (!is_root_decoder(dev))
>  		return 0;
> @@ -237,12 +236,7 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
>  	if (!(cxld->flags & CXL_DECODER_F_RAM))
>  		return 0;
>  
> -	root_range = (struct range) {
> -		.start = cxld->platform_res.start,
> -		.end = cxld->platform_res.end,
> -	};
> -
> -	return range_contains(&root_range, dev_range);
> +	return range_contains(&cxld->hpa_range, dev_range);
>  }
>  
>  static void disable_hdm(void *_cxlhdm)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 98bcbbd59a75..b51eb41aa839 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -73,29 +73,17 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> -	u64 start;
>  
> -	if (is_root_decoder(dev))
> -		start = cxld->platform_res.start;
> -	else
> -		start = cxld->hpa_range.start;
> -
> -	return sysfs_emit(buf, "%#llx\n", start);
> +	return sysfs_emit(buf, "%#llx\n", cxld->hpa_range.start);
>  }
>  static DEVICE_ATTR_ADMIN_RO(start);
>  
>  static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> -			char *buf)
> +			 char *buf)

nitpick: Unrelated change.  Ideally not in this patch.

>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> -	u64 size;
> -
> -	if (is_root_decoder(dev))
> -		size = resource_size(&cxld->platform_res);
> -	else
> -		size = range_len(&cxld->hpa_range);
>  
> -	return sysfs_emit(buf, "%#llx\n", size);
> +	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->hpa_range));
>  }
>  static DEVICE_ATTR_RO(size);
>  
> @@ -1233,7 +1221,10 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  	cxld->interleave_ways = 1;
>  	cxld->interleave_granularity = PAGE_SIZE;
>  	cxld->target_type = CXL_DECODER_EXPANDER;
> -	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
> +	cxld->hpa_range = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
>  
>  	return cxld;
>  err:
> @@ -1347,13 +1338,6 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * Platform decoder resources should show up with a reasonable name. All
> -	 * other resources are just sub ranges within the main decoder resource.
> -	 */
> -	if (is_root_decoder(dev))
> -		cxld->platform_res.name = dev_name(dev);
> -
>  	return device_add(dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8256728cea8d..35ce17872fc1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -197,7 +197,6 @@ enum cxl_decoder_type {
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
>   * @id: kernel device name id
> - * @platform_res: address space resources considered by root decoder
>   * @hpa_range: Host physical address range mapped by this decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
> @@ -210,10 +209,7 @@ enum cxl_decoder_type {
>  struct cxl_decoder {
>  	struct device dev;
>  	int id;
> -	union {
> -		struct resource platform_res;
> -		struct range hpa_range;
> -	};
> +	struct range hpa_range;
>  	int interleave_ways;
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;
> 

