Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8D55E7E3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347617AbiF1PRY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347786AbiF1PRW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 11:17:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4600432057;
        Tue, 28 Jun 2022 08:17:20 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXSqR26PMz67xX3;
        Tue, 28 Jun 2022 23:16:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 17:17:18 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 16:17:17 +0100
Date:   Tue, 28 Jun 2022 16:17:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 04/46] cxl/core: Rename ->decoder_range ->hpa_range
Message-ID: <20220628161716.00004c55@Huawei.com>
In-Reply-To: <165603872867.551046.2170426227407458814.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603872867.551046.2170426227407458814.stgit@dwillia2-xfh>
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

On Thu, 23 Jun 2022 19:45:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for growing a ->dpa_range attribute for endpoint
> decoders, rename the current ->decoder_range to the more descriptive
> ->hpa_range.  
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Make sense
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

