Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0501413AD95
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 16:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANPZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 10:25:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANPZq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 10:25:46 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945E02072B;
        Tue, 14 Jan 2020 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579015545;
        bh=lCzT2r10t8tKjNMq10HvvXZufirJmV3nQEiebEYP3gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkN7x9BHeMRrLPT+H/Vs2eAvyxwdMCtxWZmirmotOXrXKM50Xkbz2VUrqG8FcVImK
         P8szE3NrMlFvQuC5m4VfQX6pJmIKvCFzay0rFPkLwzHVZLgYMzftKk7hUjTc4jYYru
         GRgHe2lPXAh9kwyaBFQssQ72gTeD94bIFnjasRYo=
Date:   Tue, 14 Jan 2020 15:25:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        robin.murphy@arm.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 11/13] iommu/arm-smmu-v3: Improve add_device() error
 handling
Message-ID: <20200114152538.GB2579@willie-the-truck>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-12-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219163033.2608177-12-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 19, 2019 at 05:30:31PM +0100, Jean-Philippe Brucker wrote:
> Let add_device() clean up after itself. The iommu_bus_init() function
> does call remove_device() on error, but other sites (e.g. of_iommu) do
> not.
> 
> Don't free level-2 stream tables because we'd have to track if we
> allocated each of them or if they are used by other endpoints. It's not
> worth the hassle since they are managed resources.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

I think this is alright, with one caveat relating to:


	/*
	 * We _can_ actually withstand dodgy bus code re-calling add_device()
	 * without an intervening remove_device()/of_xlate() sequence, but
	 * we're not going to do so quietly...
	 */
	if (WARN_ON_ONCE(fwspec->iommu_priv)) {
		master = fwspec->iommu_priv;
		smmu = master->smmu;
	} ...


which may be on shakey ground if the subsequent add_device() call can fail
and free stuff that the first one allocated. At least, I don't know what
we're trying to support with this, so it's hard to tell whether or not it
still works as intended after your change.

How is this supposed to work? I don't recall ever seeing that WARN fire,
so can we just remove this and bail instead? Robin?

Something like below before your changes...

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..6ae3df2f3495 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2534,28 +2534,23 @@ static int arm_smmu_add_device(struct device *dev)
 
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
