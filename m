Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC08393EBB
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhE1I1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 04:27:45 -0400
Received: from fgw22-4.mail.saunalahti.fi ([62.142.5.109]:62726 "EHLO
        fgw22-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236389AbhE1I1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 04:27:42 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 04:27:42 EDT
Received: from darkstar.musicnaut.iki.fi (85-76-82-161-nat.elisa-mobile.fi [85.76.82.161])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 1822b824-bf8c-11eb-88cb-005056bdf889;
        Fri, 28 May 2021 11:10:01 +0300 (EEST)
Date:   Fri, 28 May 2021 11:09:58 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, catalin.marinas@arm.com,
        joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org,
        yi.l.liu@intel.com, Jonathan.Cameron@huawei.com,
        zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v4 21/26] iommu/arm-smmu-v3: Ratelimit event dump
Message-ID: <20210528080958.GA60351@darkstar.musicnaut.iki.fi>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-22-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224182401.353359-22-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Feb 24, 2020 at 07:23:56PM +0100, Jean-Philippe Brucker wrote:
> When a device or driver misbehaves, it is possible to receive events
> much faster than we can print them out. Ratelimit the printing of
> events.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>

> During the SVA tests when the device driver didn't properly stop DMA
> before unbinding, the event queue thread would almost lock-up the server
> with a flood of event 0xa. This patch helped recover from the error.

I was just debugging a similar case, and this patch was required to
prevent system from locking up.

Could you please resend this patch independently from the other patches
in the series, as it seems it's a worthwhile fix and still relevent for
current kernels. Thanks,

A.

> ---
>  drivers/iommu/arm-smmu-v3.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 28f8583cd47b..6a5987cce03f 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2243,17 +2243,20 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  	struct arm_smmu_device *smmu = dev;
>  	struct arm_smmu_queue *q = &smmu->evtq.q;
>  	struct arm_smmu_ll_queue *llq = &q->llq;
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
>  	u64 evt[EVTQ_ENT_DWORDS];
>  
>  	do {
>  		while (!queue_remove_raw(q, evt)) {
>  			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
>  
> -			dev_info(smmu->dev, "event 0x%02x received:\n", id);
> -			for (i = 0; i < ARRAY_SIZE(evt); ++i)
> -				dev_info(smmu->dev, "\t0x%016llx\n",
> -					 (unsigned long long)evt[i]);
> -
> +			if (__ratelimit(&rs)) {
> +				dev_info(smmu->dev, "event 0x%02x received:\n", id);
> +				for (i = 0; i < ARRAY_SIZE(evt); ++i)
> +					dev_info(smmu->dev, "\t0x%016llx\n",
> +						 (unsigned long long)evt[i]);
> +			}
>  		}
>  
>  		/*
