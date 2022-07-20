Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44DD57BC95
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 19:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbiGTR0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbiGTR0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 13:26:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFEB2DF4;
        Wed, 20 Jul 2022 10:26:06 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lp2Zj3vwVz67TPf;
        Thu, 21 Jul 2022 01:22:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 19:26:04 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 18:26:03 +0100
Date:   Wed, 20 Jul 2022 18:26:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@lst.de>, <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 21/28] cxl/region: Enable the assignment of endpoint
 decoders to regions
Message-ID: <20220720182601.00001307@Huawei.com>
In-Reply-To: <165784336184.1758207.16403282029203949622.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
        <165784336184.1758207.16403282029203949622.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.121]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 17:02:41 -0700
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

I think you've lost some planned changes here as typos from v1 review
still here as is the stale comment.

With those fixed
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b1e847827c6b..871bfdbb9bc8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

> +/*
> + * - Check that the given endpoint is attached to a host-bridge identified
> + *   in the root interleave.

In reply to v1 review I think you said you had dropped this comment as stale?

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
typo still here.

> +	up_write(&cxl_region_rwsem);
> +	device_release_driver(&cxlr->dev);
> +	down_write(&cxl_region_rwsem);
> +out:
> +	put_device(&cxlr->dev);
> +}


