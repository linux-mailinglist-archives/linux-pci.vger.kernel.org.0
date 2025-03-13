Return-Path: <linux-pci+bounces-23603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52A7A5F1BD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 12:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3842D3AD237
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915FA26389F;
	Thu, 13 Mar 2025 11:01:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F661EDA17;
	Thu, 13 Mar 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863702; cv=none; b=nu0w+C1zMK4Av52TTrCN+All5roBil9U6UaphAKv1zzyCqJAcTL6t8Di606B62myCxfj0uIjI44hPlFd5fm/P1Z16ZL3XRDZ3rKXxtbdD7Vs5dkM2yqZ5Jo5mXeU0DdF6PXHCk7fjFzi6nLLce98Jj3IS67DQimqW6DUb7nq9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863702; c=relaxed/simple;
	bh=XefTSzn/nQqjD6JMR5JYpIY4KIl/yqcRheoDY2b+ilE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWJggU+BI5x5FzF8dySMseJiNiSdVvnBDWWisLiGCKxzdIh5wZEut4gIvHGD2eRo5qsqHDSpr0RT60EO/iecNHSQdZ3G78lxBtAzFissZYg6aqnraswrels4schCNLx664w/WD3DUpZcFw7QSCS14hJOZxg7TGaXsARMLWeJlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D5E1516;
	Thu, 13 Mar 2025 04:01:50 -0700 (PDT)
Received: from [10.57.40.246] (unknown [10.57.40.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C60353F673;
	Thu, 13 Mar 2025 04:01:35 -0700 (PDT)
Message-ID: <417d6f59-0d78-4e81-ad0b-e06846f786b0@arm.com>
Date: Thu, 13 Mar 2025 11:01:33 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <CGME20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd@eucas1p2.samsung.com>
 <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-03-13 9:56 am, Marek Szyprowski wrote:
[...]
> This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
> ("iommu: Get DT/ACPI parsing into the proper probe path"). In my tests I
> found it breaks booting of ARM64 RK3568-based Odroid-M1 board
> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
> relevant kernel log:

...and the bug-flushing-out begins!

> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000000003e8
> Mem abort info:
>     ESR = 0x0000000096000004
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x04: level 0 translation fault
> Data abort info:
>     ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [00000000000003e8] user address but active_mm is swapper
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
> Hardware name: Hardkernel ODROID-M1 (DT)
> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : devm_kmalloc+0x2c/0x114
> lr : rk_iommu_of_xlate+0x30/0x90
> ...
> Call trace:
>    devm_kmalloc+0x2c/0x114 (P)
>    rk_iommu_of_xlate+0x30/0x90

Yeah, looks like this is doing something a bit questionable which can't
work properly. TBH the whole dma_dev thing could probably be cleaned up
now that we have proper instances, but for now does this work?

(annoyingly none of my Rockchip boards are set up for testing right now, 
but I might have time to dig one out later)

Thanks,
Robin.

----->8-----

Subject: [PATCH] iommu/rockchip: Allocate per-device data sensibly

Now that DT-based probing is finally happening in the right order again,
it reveals an issue in Rockchip's of_xlate, which can now be called
during registration, but is using the global dma_dev which is only
assigned later. However, this makes little sense when we're already
looking up the correct IOMMU device, who should logically be the owner
of the devm allocation anyway.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe 
path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/rockchip-iommu.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 323cc665c357..48826d1ccfd8 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1148,12 +1148,12 @@ static int rk_iommu_of_xlate(struct device *dev,
  	struct platform_device *iommu_dev;
  	struct rk_iommudata *data;

-	data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
+	iommu_dev = of_find_device_by_node(args->np);
+
+	data = devm_kzalloc(&iommu_dev->dev, sizeof(*data), GFP_KERNEL);
  	if (!data)
  		return -ENOMEM;

-	iommu_dev = of_find_device_by_node(args->np);
-
  	data->iommu = platform_get_drvdata(iommu_dev);
  	data->iommu->domain = &rk_identity_domain;
  	dev_iommu_priv_set(dev, data);
-- 
2.39.2.101.g768bb238c484.dirty



