Return-Path: <linux-pci+bounces-45070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348BD379F4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 18:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7573026AE3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF653090C9;
	Fri, 16 Jan 2026 17:24:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB87155757;
	Fri, 16 Jan 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584294; cv=none; b=l/duFHXUgSVpReX5YS9jY+Ux1huSOJbWdcUx0u0v3EGih7MOHfHkfrTadlnf0sWs3tkSLEyvbicbJpM0yLjk5LziYfr/ZrjqQObxIR9a0y6rgKcKEYK3L1AFaEupsRsoaEuvRaxKdtz0A5cV2Zf4fwalw5hbIzSldn/de0vF8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584294; c=relaxed/simple;
	bh=JAS6eKKYV7sDFHlsH109WcdIrJVmwu4Wc7dgojhn554=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUlypVE2MnBZvbw3tnIAaL3a5IAhH1CBD0SiOsIIZrheliOsxowlgPZMk0peRpeDRnlaa4/8dKLkIZ9drHh4arUR/gC9rX5GBw2EmPSUne7MQzpXPYzDBTkcRW1Kisv4CV5Fhpxyvv7xONy/hLbCXOYi2cCDzhxjbWaOCB99NhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E51CA1515;
	Fri, 16 Jan 2026 09:24:44 -0800 (PST)
Received: from [10.57.49.133] (unknown [10.57.49.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 416DE3F59E;
	Fri, 16 Jan 2026 09:24:49 -0800 (PST)
Message-ID: <4da29d46-9a80-4ec4-b6b8-6c9457eed481@arm.com>
Date: Fri, 16 Jan 2026 17:24:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: imx8 PCI regression since "iommu: Get DT/ACPI
 parsing into the proper probe path"
To: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <jroedel@suse.de>,
 regressions@lists.linux.dev
References: <a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr>
 <eb94b379-6e0b-4beb-aaa7-413a4e7f04b9@green-communications.fr>
 <3780eb61-68e2-42ce-939e-7458cd3a63cb@green-communications.fr>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <3780eb61-68e2-42ce-939e-7458cd3a63cb@green-communications.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-01-16 4:52 pm, Nicolas Cavallari wrote:
> +cc regressions ML
> 
> Le 13/01/2026 à 10:17, Nicolas Cavallari a écrit :
>> +cc patch author & reviewers
>>
>> On 1/9/26 17:22, Nicolas Cavallari wrote:
>>> When upgrading from 6.12 to a 6.18 kernel, I noticed that a PCI
>>> Ethernet adapter (Microchip LAN7430) would hang under load and not
>>> recover.  When that happens, some of its registers indicate it is
>>> failing to do DMA reads, so cannot reclaim entries on its ring buffer.
>>>
>>> I bisected the problem into this commit:
>>>
>>> commit bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
>>> Author: Robin Murphy <robin.murphy@arm.com>
>>> Date:   Fri Feb 28 15:46:33 2025 +0000
>>>
>>>       iommu: Get DT/ACPI parsing into the proper probe path
>>>
>>> The problem still exists on 6.19-rc1, on pci/next (29a77b4897f1) and on
>>> iommu/master (360e85353769) trees.  Reverting the commit fixes the 
>>> issue.
> 
> The problem persists on 6.19-rc5
> 
>>> The system is a Gateworks GW7200, which is a i.MX 8 Mini connected to a
>>> Pericom
>>> PI7C9X2G404 4-port switch connected to the LAN7430 chip.
>>>
>>> -[0000:00]---00.0-[01-ff]----00.0-[02-05]--+-01.0-[03]----00.0
>>>                                              +-02.0-[04]--
>>>                                              \-03.0-[05]----00.0
>>>
>>> The problem only occurs when there is at least another PCI device in use
>>> on the
>>> switch.  It does not happen if the LAN7430 is the only PCI device, or if
>>> the
>>> other devices are not actively used.  For example i can reproduce it
>>> with an
>>> ath9k wireless network adapter when it is up and running, but not when
>>> it is
>>> down or its driver is not loaded.
>>>
>>> I suspect that other PCI devices have similar issues, but the LAN7430 is
>>> the
>>> easiest one to diagnose, as it hangs within seconds with an iperf3 --
>>> bidir -u
>>> -b 200M and its register map are public.
>>>
>>> I couldn't find an way to dump the PCI address translation mapping from
>>> userspace.
>>> I would be happy to provide more information or test patches.
> 
> I debugged it further, it seems to be mostly a PCI issue since the 
> system does not actually have an IOMMU.

Indeed, I was figuring this had to be another case of a switch with 
wonky ACS - do Mani's patches adjusting ACS enablement make any difference?

https://lore.kernel.org/all/20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com/

Although in this case I guess the issue is arguably more that we're 
requesting ACS at all, before we know that there's actually an IOMMU 
present to warrant it. Clearly the best option would be to figure out if 
the switch behaviour itself can be fixed somehow, but perhaps something 
like this might help paper over the issue for now (but I'd have to test 
it to make sure it doesn't break IOMMUs again...)

----->8-----
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6b989a62def2..837cc0b5ace4 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -141,10 +141,12 @@ int of_iommu_configure(struct device *dev, struct 
device_node *master_np,
  			.np = master_np,
  		};

-		pci_request_acs();
  		err = pci_for_each_dma_alias(to_pci_dev(dev),
  					     of_pci_iommu_init, &info);
-		of_pci_check_device_ats(dev, master_np);
+		if (!err) {
+			pci_request_acs();
+			of_pci_check_device_ats(dev, master_np);
+		}
  	} else {
  		err = of_iommu_configure_device(master_np, dev, id);
  	}
-----8<-----

Thanks,
Robin.

