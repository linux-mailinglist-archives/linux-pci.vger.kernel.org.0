Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808F8560494
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiF2P2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiF2P2Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 11:28:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D057411A16;
        Wed, 29 Jun 2022 08:28:12 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY51R6kcwz689NG;
        Wed, 29 Jun 2022 23:27:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 17:28:09 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 16:28:09 +0100
Date:   Wed, 29 Jun 2022 16:28:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 16/46] cxl/hdm: Add 'mode' attribute to decoder objects
Message-ID: <20220629162807.00007bb7@Huawei.com>
In-Reply-To: <165603881967.551046.6007594190951596439.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603881967.551046.6007594190951596439.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
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

On Thu, 23 Jun 2022 19:46:59 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Recall that the Device Physical Address (DPA) space of a CXL Memory
> Expander is potentially partitioned into a volatile and persistent
> portion. A decoder maps a Host Physical Address (HPA) range to a DPA
> range and that translation depends on the value of all previous (lower
> instance number) decoders before the current one.
> 
> In preparation for allowing dynamic provisioning of regions, decoders
> need an ABI to indicate which DPA partition a decoder targets. This ABI
> needs to be prepared for the possibility that some other agent committed
> and locked a decoder that spans the partition boundary.
> 
> Add 'decoderX.Y/mode' to endpoint decoders that indicates which
> partition 'ram' / 'pmem' the decoder targets, or 'mixed' if the decoder
> currently spans the partition boundary.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few trivial things inline though I'm not super keen on it being
introduced RO for just 2 patches...  You could pull forwards
the outline of the store() to avoid that slight oddity, but
I'm not that bothered if it is a pain to do.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   16 ++++++++++++++++
>  drivers/cxl/core/hdm.c                  |   10 ++++++++++
>  drivers/cxl/core/port.c                 |   20 ++++++++++++++++++++
>  drivers/cxl/cxl.h                       |    9 +++++++++
>  4 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 1fd5984b6158..091459216e11 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -164,3 +164,19 @@ Description:
>  		expander memory (type-3). The 'target_type' attribute indicates
>  		the current setting which may dynamically change based on what
>  		memory regions are activated in this decode hierarchy.
> +
> +

Single blank line used for previous entries. Note this carries to other
later patches.


> +What:		/sys/bus/cxl/devices/decoderX.Y/mode
> +Date:		May, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> +		translates from a host physical address range, to a device local
> +		address range. Device-local address ranges are further split
> +		into a 'ram' (volatile memory) range and 'pmem' (persistent
> +		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> +		'mixed', or 'none'. The 'mixed' indication is for error cases
> +		when a decoder straddles the volatile/persistent partition
> +		boundary, and 'none' indicates the decoder is not actively
> +		decoding, or no DPA allocation policy has been set.
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index daae6e533146..3f929231b822 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -204,6 +204,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	cxled->dpa_res = res;
>  	cxled->skip = skip;
>  
> +	if (resource_contains(&cxlds->pmem_res, res))
> +		cxled->mode = CXL_DECODER_PMEM;
> +	else if (resource_contains(&cxlds->ram_res, res))
> +		cxled->mode = CXL_DECODER_RAM;
> +	else {
> +		dev_dbg(dev, "decoder%d.%d: %pr mixed\n", port->id,
> +			cxled->cxld.id, cxled->dpa_res);

Why debug for one case and not the the others?

> +		cxled->mode = CXL_DECODER_MIXED;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b5f5fb9aa4b7..9d632c8c580b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -171,6 +171,25 @@ static ssize_t target_list_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(target_list);
>  
> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +
> +	switch (cxled->mode) {
> +	case CXL_DECODER_RAM:
> +		return sysfs_emit(buf, "ram\n");
> +	case CXL_DECODER_PMEM:
> +		return sysfs_emit(buf, "pmem\n");
> +	case CXL_DECODER_NONE:
> +		return sysfs_emit(buf, "none\n");
> +	case CXL_DECODER_MIXED:
> +	default:
> +		return sysfs_emit(buf, "mixed\n");
> +	}
> +}
> +static DEVICE_ATTR_RO(mode);
> +
>  static struct attribute *cxl_decoder_base_attrs[] = {
>  	&dev_attr_start.attr,
>  	&dev_attr_size.attr,
> @@ -221,6 +240,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>  
>  static struct attribute *cxl_decoder_endpoint_attrs[] = {
>  	&dev_attr_target_type.attr,
> +	&dev_attr_mode.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6832d6d70548..aa223166f7ef 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -241,16 +241,25 @@ struct cxl_decoder {
>  	unsigned long flags;
>  };
>  
> +enum cxl_decoder_mode {
> +	CXL_DECODER_NONE,
> +	CXL_DECODER_RAM,
> +	CXL_DECODER_PMEM,
> +	CXL_DECODER_MIXED,
> +};
> +
>  /**
>   * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
>   * @cxld: base cxl_decoder_object
>   * @dpa_res: actively claimed DPA span of this decoder
>   * @skip: offset into @dpa_res where @cxld.hpa_range maps
> + * @mode: which memory type / access-mode-partition this decoder targets
>   */
>  struct cxl_endpoint_decoder {
>  	struct cxl_decoder cxld;
>  	struct resource *dpa_res;
>  	resource_size_t skip;
> +	enum cxl_decoder_mode mode;
>  };
>  
>  /**
> 

