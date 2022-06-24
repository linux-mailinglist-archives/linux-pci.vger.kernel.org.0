Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C38558F33
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 05:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiFXDkY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 23:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiFXDkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 23:40:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BBDAE4A;
        Thu, 23 Jun 2022 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656042021; x=1687578021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hLuuVrvT/gcLOKjZymIz7r4f9D3WtNXD/Bpa2frDEp8=;
  b=KpYnYdzE4hJoiAQXDvonxIWvsnyCQI948M8354JsnvwnsdhaJr94qO2r
   GjnZz6VJKAcXwxOcZn94twnwezyo53U6258Wxdu3NM69PG9hGmzlZSPmN
   psnM4u4RD7supYX6zmqnN1fGaWoXi2FVwDYwMO3yrO544DGSckJ0CFw9h
   DkYA52OJTXz1MmkO93qrzD2f6GutgnLPwIOfpb1Sp/gqiL59rTrlK35/z
   2Jf2EjIQzROQ46jxskOB/3/ZvHPbkZjkcL5nUYlzWCmCBKjlJzbLM/BOQ
   kNCRbarIeSap29dRFJ6zjYY2yl+JUEkWbWD2zGp1Vc0LXi2aooiATx3si
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="278461928"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="278461928"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:40:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="645080810"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:40:20 -0700
Date:   Thu, 23 Jun 2022 20:39:44 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 04/46] cxl/core: Rename ->decoder_range ->hpa_range
Message-ID: <20220624033944.GC1558591@alison-desk>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603872867.551046.2170426227407458814.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165603872867.551046.2170426227407458814.stgit@dwillia2-xfh>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:28PM -0700, Dan Williams wrote:
> In preparation for growing a ->dpa_range attribute for endpoint
> decoders, rename the current ->decoder_range to the more descriptive
> ->hpa_range.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/hdm.c       |    2 +-
>  drivers/cxl/core/port.c      |    4 ++--
>  drivers/cxl/cxl.h            |    4 ++--
>  tools/testing/cxl/test/cxl.c |    2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ba3d2d959c71..5c070c93b07f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -172,7 +172,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		return -ENXIO;
>  	}
>  
> -	cxld->decoder_range = (struct range) {
> +	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + size - 1,
>  	};
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7810d1a8369b..98bcbbd59a75 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -78,7 +78,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
>  	if (is_root_decoder(dev))
>  		start = cxld->platform_res.start;
>  	else
> -		start = cxld->decoder_range.start;
> +		start = cxld->hpa_range.start;
>  
>  	return sysfs_emit(buf, "%#llx\n", start);
>  }
> @@ -93,7 +93,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  	if (is_root_decoder(dev))
>  		size = resource_size(&cxld->platform_res);
>  	else
> -		size = range_len(&cxld->decoder_range);
> +		size = range_len(&cxld->hpa_range);
>  
>  	return sysfs_emit(buf, "%#llx\n", size);
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6799b27c7db2..8256728cea8d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -198,7 +198,7 @@ enum cxl_decoder_type {
>   * @dev: this decoder's device
>   * @id: kernel device name id
>   * @platform_res: address space resources considered by root decoder
> - * @decoder_range: address space resources considered by midlevel decoder
> + * @hpa_range: Host physical address range mapped by this decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> @@ -212,7 +212,7 @@ struct cxl_decoder {
>  	int id;
>  	union {
>  		struct resource platform_res;
> -		struct range decoder_range;
> +		struct range hpa_range;
>  	};
>  	int interleave_ways;
>  	int interleave_granularity;
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 431f2bddf6c8..7a08b025f2de 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -461,7 +461,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  			return PTR_ERR(cxld);
>  		}
>  
> -		cxld->decoder_range = (struct range) {
> +		cxld->hpa_range = (struct range) {
>  			.start = 0,
>  			.end = -1,
>  		};
> 
