Return-Path: <linux-pci+bounces-18975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FAC9FB308
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C309C164B58
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B31B4139;
	Mon, 23 Dec 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NuT6L0tk"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F91AF0B4;
	Mon, 23 Dec 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971757; cv=none; b=qjhQUkkfzRl39xuaucvxNolZpUz85kS+EsWcyy1VMuyANItJFvZPGS+5VFxnHqb1SF6XmO/fcwxBIrbaGKbdzLRyzc+llKrG/Rh8alIQT5ddFsEHAi/7lQAMOwZw53e2KSGAyx0FNV7QXCb/Ki2+sQg5kCKTT1SWKtWb81qr0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971757; c=relaxed/simple;
	bh=2LpGnCh13IE5nAVYp9h6TBX2ay5C5BHnYyLrnbg7fe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASBFETKyRchDrGqvKzF+oMxmBIKp90AYqp3owoWDpb0e2JY+RihdSFRa4Tw+rdckhj0j48gMA18fVJpdmeJdLrYS4EhFfjbkejmr9JJDuRypaJaB82j9sCwywZqM1LkPWVUkf9zL8hq41MLnW1W/N2bXW1JwBmmXuvMXkKXO444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NuT6L0tk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C00F3C0002;
	Mon, 23 Dec 2024 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734971746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy3/Aj5G5XKlSOGuvuIp4d0+mFT8WB0dvmaCLkjMxr4=;
	b=NuT6L0tkVKLCJ8BKcPhxuTOoiTzvuwVakfuU3d7T8Z/oDRQ3IUOeB9NWuiutvisPHuhz5U
	jbOoDLGuBn3S8cn5dqIdsOxmOp6PB3oFHnc18NVgUqcG1UUfup0ns4ElSrB9xrTSZJJAWz
	VFv5O+NOk7d0dMBkTIdl9tZkqJKckcUwEFKv9yvUzjuhE7IvN+Ze8pBWTKs2tsU37Ltm6u
	8QY666Wj4lRhVaND0oGDS6gdsu0EEC4VP8Fka/jPFGcstGIeAizpVi8cUVwLXM/HYtbkot
	BxZ67xvtd0KDslthfFHjtOqHk1YLKR2L/N/Neh9nwAzsrpRCHoa2XYg+CqDecw==
Message-ID: <9b7161a7-2682-4824-8af0-39477b0938d8@bootlin.com>
Date: Mon, 23 Dec 2024 17:35:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Add PCIe support for bcm2712
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241025124515.14066-1-svarbanov@suse.de>
Content-Language: en-US
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
In-Reply-To: <20241025124515.14066-1-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: olivier.benjamin@bootlin.com

On 10/25/24 14:45, Stanimir Varbanov wrote:
> Here is v4 of the series which aims to add support for PCIe on bcm2712 SoC
> used by RPi5. Previous v3 can be found at [1].
> 
Hello Stanimir,

Thank you for you work on this!

> v3 -> v4 changes include:
>   - Addressed comments on the interrupt-controller driver (Thomas)
>   - Moved "Reuse config structure" patch earlier in the series (Bjorn)
>   - Merged "Avoid turn off of bridge reset" into "Add bcm2712 support" (Bjorn)
>   - Fixed DTB warnings on broadcom/bcm2712-rpi-5-b.dtb
> 
> For more detailed info check patches.
> 
I would simply like to report that I have (rather succintly) tested this 
series.
I have built a 6.13.0-rc4-v8 vanilla kernel and deployed it to a 
Raspberry Pi 5 equipped with a "Raspberry Pi SSD" NVMe Drive on an M.2 
Hat+ connected to the main board using PCIe.
This of course did not work, and I could not see my drive.
I then applied this series on top, rebuilt and deployed the kernel, and 
I could see the /dev/nvme0 device and mount the ext4 fs on the 1st 
partition.

> Comments are welcome!
> ~Stan
	
If you find it helpful, feel free to collect my Tested-By tag.

I'll be happy to do the same for future versions of the series and can 
do some additional testing if you want an extra pair of eyes.

Olivier
> 
> [1] https://patchwork.kernel.org/project/linux-pci/list/?series=898891
> 
> Stanimir Varbanov (10):
>    dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
>    dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
>    irqchip: Add Broadcom bcm2712 MSI-X interrupt controller
>    PCI: brcmstb: Reuse config structure
>    PCI: brcmstb: Expand inbound window size up to 64GB
>    PCI: brcmstb: Enable external MSI-X if available
>    PCI: brcmstb: Add bcm2712 support
>    PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
>    arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
>    arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes
> 
>   .../brcm,bcm2712-msix.yaml                    |  60 ++++
>   .../bindings/pci/brcm,stb-pcie.yaml           |  21 ++
>   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 162 +++++++++
>   drivers/irqchip/Kconfig                       |  16 +
>   drivers/irqchip/Makefile                      |   1 +
>   drivers/irqchip/irq-bcm2712-mip.c             | 310 ++++++++++++++++++
>   drivers/pci/controller/pcie-brcmstb.c         | 204 +++++++++---
>   8 files changed, 735 insertions(+), 47 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>   create mode 100644 drivers/irqchip/irq-bcm2712-mip.c
> 

-- 
Olivier Benjamin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


