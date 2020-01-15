Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA513C900
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgAOQRW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 11:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgAOQRW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 11:17:22 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 617A6222C3;
        Wed, 15 Jan 2020 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579105041;
        bh=ukrQNfklcHgQLcXCXuNtN53CWWqys1txNDvrg263c4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyuW482lUGZB2PULa3IQt7cUjuRCEQEVx2g3VQ4GXNPaKyQojamqURrbldP4Ev0Wh
         SPzO+PCTcua153EUkXezNqb0c41e+W10ZK+DHfcoFD2dUxDSwI3nk111kPYmcMzWYU
         lJM9yUOkJu2WkDpF+kKpoe0IhAp1tOWD3ho1Y08Y=
Date:   Wed, 15 Jan 2020 16:17:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        robin.murphy@arm.com
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        lorenzo.pieralisi@arm.com, eric.auger@redhat.com,
        linux-pci@vger.kernel.org, joro@8bytes.org, sudeep.holla@arm.com,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        jonathan.cameron@huawei.com, guohanjun@huawei.com,
        bhelgaas@google.com, zhangfei.gao@linaro.org,
        linux-arm-kernel@lists.infradead.org, lenb@kernel.org
Subject: Re: [PATCH v4 11/13] iommu/arm-smmu-v3: Improve add_device() error
 handling
Message-ID: <20200115161714.GA30746@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-12-jean-philippe@linaro.org>
 <20200114152538.GB2579@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114152538.GB2579@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 03:25:39PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 05:30:31PM +0100, Jean-Philippe Brucker wrote:
> > Let add_device() clean up after itself. The iommu_bus_init() function
> > does call remove_device() on error, but other sites (e.g. of_iommu) do
> > not.
> > 
> > Don't free level-2 stream tables because we'd have to track if we
> > allocated each of them or if they are used by other endpoints. It's not
> > worth the hassle since they are managed resources.
> > 
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> I think this is alright, with one caveat relating to:
> 
> 
> 	/*
> 	 * We _can_ actually withstand dodgy bus code re-calling add_device()
> 	 * without an intervening remove_device()/of_xlate() sequence, but
> 	 * we're not going to do so quietly...
> 	 */
> 	if (WARN_ON_ONCE(fwspec->iommu_priv)) {
> 		master = fwspec->iommu_priv;
> 		smmu = master->smmu;
> 	} ...
> 
> 
> which may be on shakey ground if the subsequent add_device() call can fail
> and free stuff that the first one allocated. At least, I don't know what
> we're trying to support with this, so it's hard to tell whether or not it
> still works as intended after your change.
> 
> How is this supposed to work? I don't recall ever seeing that WARN fire,
> so can we just remove this and bail instead? Robin?
> 
> Something like below before your changes...

FWIW, I've written this as a patch locally, since I'd like to apply it
on top of v5 of your series.

Will

--->8

From 6029102f406d4db5e7a465da5fd2e08a5b12c532 Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Wed, 15 Jan 2020 15:35:16 +0000
Subject: [PATCH] iommu/arm-smmu-v3: Return -EBUSY when trying to re-add a
 device

Although we WARN in arm_smmu_add_device() if the device being added has
been added already without a subsequent call to arm_smmu_remove_device(),
we still continue half-heartedly, initialising the stream-table for any
new StreamIDs that may have magically appeared and re-establishing device
links that should still be there from last time.

Given that calling ->add_device() twice without removing the device in the
meantime is indicative of an error in the caller, just return -EBUSY after
warning.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean Philippe-Brucker <jean-philippe@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index efa326601308..cc26e1323da3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2841,28 +2841,23 @@ static int arm_smmu_add_device(struct device *dev)
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return -ENODEV;
-	/*
-	 * We _can_ actually withstand dodgy bus code re-calling add_device()
-	 * without an intervening remove_device()/of_xlate() sequence, but
-	 * we're not going to do so quietly...
-	 */
-	if (WARN_ON_ONCE(fwspec->iommu_priv)) {
-		master = fwspec->iommu_priv;
-		smmu = master->smmu;
-	} else {
-		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
-		if (!smmu)
-			return -ENODEV;
-		master = kzalloc(sizeof(*master), GFP_KERNEL);
-		if (!master)
-			return -ENOMEM;
 
-		master->dev = dev;
-		master->smmu = smmu;
-		master->sids = fwspec->ids;
-		master->num_sids = fwspec->num_ids;
-		fwspec->iommu_priv = master;
-	}
+	if (WARN_ON_ONCE(fwspec->iommu_priv))
+		return -EBUSY;
+
+	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+	if (!smmu)
+		return -ENODEV;
+
+	master = kzalloc(sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	master->dev = dev;
+	master->smmu = smmu;
+	master->sids = fwspec->ids;
+	master->num_sids = fwspec->num_ids;
+	fwspec->iommu_priv = master;
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
 	for (i = 0; i < master->num_sids; i++) {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

