Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0B561E21
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiF3OhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiF3Ogz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 10:36:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452615714;
        Thu, 30 Jun 2022 07:31:55 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYgk02FNLz686H8;
        Thu, 30 Jun 2022 22:31:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 16:31:53 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 15:31:52 +0100
Date:   Thu, 30 Jun 2022 15:31:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 38/46] cxl/region: Enable the assignment of endpoint
 decoders to regions
Message-ID: <20220630153150.00006fa2@Huawei.com>
In-Reply-To: <20220624041950.559155-13-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-13-dan.j.williams@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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

On Thu, 23 Jun 2022 21:19:42 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The region provisioning process involves allocating DPA to a set of
> endpoint decoders, and HPA plus the region geometry to a region device.
> Then the decoder is assigned to the region. At this point several
> validation steps can be performed to validate that the decoder is
> suitable to participate in the region.
> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  19 ++
>  drivers/cxl/core/core.h                 |   6 +
>  drivers/cxl/core/hdm.c                  |  13 +-
>  drivers/cxl/core/port.c                 |  12 +-
>  drivers/cxl/core/region.c               | 286 +++++++++++++++++++++++-
>  drivers/cxl/cxl.h                       |  11 +
>  6 files changed, 342 insertions(+), 5 deletions(-)
> 

A few fixes seems to have ended up in wrong patch.
Other trivial typos etc inline plus what looks to be an
item left from a todo list...

...


> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a604c24ff918..4830365f3857 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -24,6 +24,7 @@
>   * but is only visible for persistent regions.
>   * 1. Interleave granularity
>   * 2. Interleave size
> + * 3. Decoder targets
>   */
>  
>  /*
> @@ -138,6 +139,8 @@ static ssize_t interleave_ways_show(struct device *dev,
>  	return rc;
>  }
>  
> +static const struct attribute_group *get_cxl_region_target_group(void);
> +
>  static ssize_t interleave_ways_store(struct device *dev,
>  				     struct device_attribute *attr,
>  				     const char *buf, size_t len)
> @@ -146,7 +149,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc, val, save;
>  	u8 iw;
>  
>  	rc = kstrtoint(buf, 0, &val);
> @@ -175,9 +178,13 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		goto out;
>  	}
>  
> +	save = p->interleave_ways;
>  	p->interleave_ways = val;
> +	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> +	if (rc)
> +		p->interleave_ways = save;
>  out:
> -	up_read(&cxl_region_rwsem);
> +	up_write(&cxl_region_rwsem);

Bug in earlier patch?

>  	if (rc)
>  		return rc;
>  	return len;
> @@ -234,7 +241,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  
>  	p->interleave_granularity = val;
>  out:
> -	up_read(&cxl_region_rwsem);
> +	up_write(&cxl_region_rwsem);

Bug in earlier patch? 

>  	if (rc)
>  		return rc;
>  	return len;
> @@ -393,9 +400,262 @@ static const struct attribute_group cxl_region_group = {
>  	.is_visible = cxl_region_visible,
>  };

...

> +/*
> + * - Check that the given endpoint is attached to a host-bridge identified
> + *   in the root interleave.

 Comment on something to fix?  Or stale comment that can be dropped?

> + */
> +static int cxl_region_attach(struct cxl_region *cxlr,
> +			     struct cxl_endpoint_decoder *cxled, int pos)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	if (cxled->mode == CXL_DECODER_DEAD) {
> +		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
> +		return -ENODEV;
> +	}
> +
> +	if (pos >= p->interleave_ways) {
> +		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
> +			p->interleave_ways);
> +		return -ENXIO;
> +	}
> +
> +	if (p->targets[pos] == cxled)
> +		return 0;
> +
> +	if (p->targets[pos]) {
> +		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
> +		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> +
> +		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
> +			pos, dev_name(&cxlmd_target->dev),
> +			dev_name(&cxled_target->cxld.dev));
> +		return -EBUSY;
> +	}
> +
> +	p->targets[pos] = cxled;
> +	cxled->pos = pos;
> +	p->nr_targets++;
> +
> +	return 0;
> +}
> +
> +static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_region *cxlr = cxled->cxld.region;
> +	struct cxl_region_params *p;
> +
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +
> +	if (!cxlr)
> +		return;
> +
> +	p = &cxlr->params;
> +	get_device(&cxlr->dev);
> +
> +	if (cxled->pos < 0 || cxled->pos >= p->interleave_ways ||
> +	    p->targets[cxled->pos] != cxled) {
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
> +		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
> +			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			      cxled->pos);
> +		goto out;
> +	}
> +
> +	p->targets[cxled->pos] = NULL;
> +	p->nr_targets--;
> +
> +	/* notify the region driver that one of its targets has deparated */

departed?

> +	up_write(&cxl_region_rwsem);
> +	device_release_driver(&cxlr->dev);
> +	down_write(&cxl_region_rwsem);
> +out:
> +	put_device(&cxlr->dev);
> +}
> +


