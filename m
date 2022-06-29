Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EDF56037A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiF2OoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiF2OoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:44:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82271C92F;
        Wed, 29 Jun 2022 07:44:03 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY42W5g0Qz689g8;
        Wed, 29 Jun 2022 22:43:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 16:44:01 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 15:44:01 +0100
Date:   Wed, 29 Jun 2022 15:43:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 14/46] cxl/hdm: Enumerate allocated DPA
Message-ID: <20220629154359.000021cc@Huawei.com>
In-Reply-To: <165603880411.551046.9204694225111844300.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603880411.551046.9204694225111844300.stgit@dwillia2-xfh>
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

On Thu, 23 Jun 2022 19:46:44 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for provisioining CXL regions, add accounting for the DPA
> space consumed by existing regions / decoders. Recall, a CXL region is a
> memory range comrpised from one or more endpoint devices contributing a
> mapping of their DPA into HPA space through a decoder.
> 
> Record the DPA ranges covered by committed decoders at initial probe of
> endpoint ports relative to a per-device resource tree of the DPA type
> (pmem or volaltile-ram).
> 
> The cxl_dpa_rwsem semaphore is introduced to globally synchronize DPA
> state across all endpoints and their decoders at once. The vast majority
> of DPA operations are reads as region creation is expected to be as rare
> as disk partitioning and volume creation. The device_lock() for this
> synchronization is specifically avoided for concern of entangling with
> sysfs attribute removal.
> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c |  148 ++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/cxl.h      |    2 +
>  drivers/cxl/cxlmem.h   |   13 ++++
>  3 files changed, 152 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c940a4911fee..daae6e533146 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -7,6 +7,8 @@
>  #include "cxlmem.h"
>  #include "core.h"
>  
> +static DECLARE_RWSEM(cxl_dpa_rwsem);

I've not checked many files, but pci.c has equivalent static defines after
the DOC: entry so for consistency move this below that?


> +
>  /**
>   * DOC: cxl core hdm
>   *
> @@ -128,10 +130,108 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
>  
> +/*
> + * Must be called in a context that synchronizes against this decoder's
> + * port ->remove() callback (like an endpoint decoder sysfs attribute)
> + */
> +static void cxl_dpa_release(void *cxled);
> +static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled, bool remove_action)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct resource *res = cxled->dpa_res;
> +
> +	lockdep_assert_held_write(&cxl_dpa_rwsem);
> +
> +	if (remove_action)
> +		devm_remove_action(&port->dev, cxl_dpa_release, cxled);

This code organization is more surprising than I'd like. Why not move this to
a wrapper that is like devm_kfree() and similar which do the free now and
remove from the devm list?

static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
{
	struct cxl_port *port = cxled_to_port(cxled);
	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
	struct cxl_dev_state *cxlds = cxlmd->cxlds;
	struct resource *res = cxled->dpa_res;

	if (cxled->skip)
		__release_region(&cxlds->dpa_res, res->start - cxled->skip,
				 cxled->skip);
	cxled->skip = 0;
	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
	cxled->dpa_res = NULL;
}

/* possibly add some underscores to this name to indicate it's special
   in when you can safely call it */
static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
{
	struct cxl_port *port = cxled_to_port(cxled);
	lockdep_assert_held_write(&cxl_dpa_rwsem);
	devm_remove_action(&port->dev, cxl_dpa_release, cxled);
	__cxl_dpa_release(cxled);
}

static void cxl_dpa_release(void *cxled)
{
	down_write(&cxl_dpa_rwsem);
	__cxl_dpa_release(cxled, false);
	up_write(&cxl_dpa_rwsem);
}

> +
> +	if (cxled->skip)
> +		__release_region(&cxlds->dpa_res, res->start - cxled->skip,
> +				 cxled->skip);
> +	cxled->skip = 0;
> +	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> +	cxled->dpa_res = NULL;
> +}
> +
> +static void cxl_dpa_release(void *cxled)
> +{
> +	down_write(&cxl_dpa_rwsem);
> +	__cxl_dpa_release(cxled, false);
> +	up_write(&cxl_dpa_rwsem);
> +}
> +
> +static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> +			     resource_size_t base, resource_size_t len,
> +			     resource_size_t skip)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct device *dev = &port->dev;
> +	struct resource *res;
> +
> +	lockdep_assert_held_write(&cxl_dpa_rwsem);
> +
> +	if (!len)
> +		return 0;
> +
> +	if (cxled->dpa_res) {
> +		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
> +			port->id, cxled->cxld.id, cxled->dpa_res);
> +		return -EBUSY;
> +	}
> +
> +	if (skip) {
> +		res = __request_region(&cxlds->dpa_res, base - skip, skip,
> +				       dev_name(dev), 0);


Interface that uses a backwards definition of skip as what to skip before
the base parameter is a little odd can we rename base parameter to something
like 'current_top' then have base = current_top + skip?  current_top naming
not great though...



> +		if (!res) {
> +			dev_dbg(dev,
> +				"decoder%d.%d: failed to reserve skip space\n",
> +				port->id, cxled->cxld.id);
> +			return -EBUSY;
> +		}
> +	}
> +	res = __request_region(&cxlds->dpa_res, base, len, dev_name(dev), 0);
> +	if (!res) {
> +		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
> +			port->id, cxled->cxld.id);
> +		if (skip)
> +			__release_region(&cxlds->dpa_res, base - skip, skip);
> +		return -EBUSY;
> +	}
> +	cxled->dpa_res = res;
> +	cxled->skip = skip;
> +
> +	return 0;
> +}
> +

...

