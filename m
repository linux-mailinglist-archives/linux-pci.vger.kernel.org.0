Return-Path: <linux-pci+bounces-24060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5CA67AE6
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 18:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A6A19C7D55
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5105211A2B;
	Tue, 18 Mar 2025 17:24:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554A2116F7;
	Tue, 18 Mar 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318698; cv=none; b=m44P6SBFQJKLsZUsz57rDZaF6syAc57i3W9OWqLUJcDxtoi8pxzuuWWAd7nEoinuVuu1WG82KPutqPYMafvxTXoZxWBNc3wIKOHtqmgn1C/ix26w6pPnDquHBjXeRqGFPNVNa7X+CH3StuZY/cg9cLc2fQb9WKpvXFdu1+mi8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318698; c=relaxed/simple;
	bh=ucssZ3UhhMj+KmH04MIyEZkp3eejH8AJj6Bc+qwhZ14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfSWnmcPpuRf0aty/+HUIOSaPOtbh5n+Vf++2ICVYol1dDqkWBaSFSNHTVE+4vOMcZZSUVPL11iPDCCHr46J8FtMWlIigX9w63eea3DAv62FgwyK1v/K96Uf2B4KYJIzhj0F2unv70RSYgBwhAW+f3/zj9iPlZ6Db+QULpUufjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC10B113E;
	Tue, 18 Mar 2025 10:25:04 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971943F673;
	Tue, 18 Mar 2025 10:24:52 -0700 (PDT)
Message-ID: <25bd5477-a388-405f-a976-6b1a59860ef8@arm.com>
Date: Tue, 18 Mar 2025 17:24:51 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <CAMuHMdWPFnHTFeeWL2-BU8tKOL-E5K2ROOz=LLBLTJJLCK9NgA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAMuHMdWPFnHTFeeWL2-BU8tKOL-E5K2ROOz=LLBLTJJLCK9NgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Geert,

On 18/03/2025 4:37 pm, Geert Uytterhoeven wrote:
[...]
> Thanks for your patch, which is now commit bcb81ac6ae3c2ef9 ("iommu:
> Get DT/ACPI parsing into the proper probe path") in iommu/next.
> 
> This patch triggers two issues on R-Car Gen3 platforms:
> 
> 1. I am seeing a warning on Renesas Salvator-XS with R-Car M3N
> (but not on the similar board with R-Car H3), and only for SATA[1].
> Unfortunately commit 73d2f10957f517e5 ("iommu: Don't warn prematurely
> about dodgy probes") does not help:
[...]
>      Call trace:
>       __iommu_probe_device+0x208/0x38c (P)
>       iommu_probe_device+0x34/0x74
>       of_iommu_configure+0x128/0x200
>       of_dma_configure_id+0xdc/0x1d4
>       platform_dma_configure+0x48/0x6c
>       really_probe+0xf0/0x260
>       __driver_probe_device+0xec/0x104
>       driver_probe_device+0x3c/0xc0

Hurrah, this is the warning doing the correct job - something *is* off
if we're now getting here without the IOMMU configuration being done
already (for a normal device with no other funny business going on).

> 2. The IOMMU driver's iommu_ops.of_xlate() callback is called about
> three times as much as before:

That would suggest that the fwspec gets set up OK, then something later
in the __iommu_probe_device() path fails and tears it down again, so the
next attempt starts from scratch. Do you see the "Cannot attach to
IPMMU" message firing? And similarly to the Rockchip case, does the
below help?

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 074daf1aac4e..5d416262ae5f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1081,6 +1081,7 @@ static int ipmmu_probe(struct platform_device *pdev)
  		}
  	}
  
+	platform_set_drvdata(pdev, mmu);
  	/*
  	 * Register the IPMMU to the IOMMU subsystem in the following cases:
  	 * - R-Car Gen2 IPMMU (all devices registered)
@@ -1103,7 +1104,6 @@ static int ipmmu_probe(struct platform_device *pdev)
  	 * ipmmu_init() after the probe function returns.
  	 */
  
-	platform_set_drvdata(pdev, mmu);
  
  	return 0;
  }

