Return-Path: <linux-pci+bounces-38927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7052BF7A61
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 18:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7C964FFD14
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C6342C95;
	Tue, 21 Oct 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JMxyIVof"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFB2EA17D
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063997; cv=none; b=GssREX9YqNVcigqMIMMdtJJa8SZnSAiKpk6i1lz1HFR/f9vGrnxbGlGCALleCsSRxoA9ILrdt+oPlaDhITuSVwROmrobE2bRiSgRuw3dn5tV83Grc8A07eyFAtZXk02gep3iPzFJKiV4xNxqEFojgl1sS8p+P1WqkiXkJTsOrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063997; c=relaxed/simple;
	bh=Y9uArkbxQyzc0TIdD5BfoEeySwmE1AUt4gzJ6clkMxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYEgp6J9p3MDm8jlJayaiDLJqkjWEZPuCIuujF5rN4kOYmxpQ8dlSmYCwvTVcX3dJT7HjSRqiOV59OPof3YmUzfYtAP5OwwDAUGj8IGc1C0eynK3T2N84L4qT4JASE+rTGWKuskd77Z1kmRoDeSTHvsfNtP6l5mnLCIDCwrpV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JMxyIVof; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d8525e6e-7098-4bc3-abb1-4c0540b71c61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761063993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MAEZH4E6BNbsRtXMjmFy7O3WOW7pDTf1V5DEPeMKGM=;
	b=JMxyIVofzEWQ7ZDQYQRwdMpKqJJE88IVyHX6sRI79hemiOVvGIVyg+RQO/nDvHa4K9ubVX
	uG2LfYfbrEsFnODad/gG+kCqZQrZ/66rvIdw5cANUL1c+hNb7kcvqksH6R5ngK8FjtRKZ/
	1XmfohqFdFJXRmC6Jb6XfPGEfQfp42I=
Date: Tue, 21 Oct 2025 12:26:30 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ
 handling
To: Bjorn Helgaas <helgaas@kernel.org>,
 Stefan Roese <stefan.roese@mailbox.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Ravi Kumar Bandi <ravib@amazon.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Michal Simek <michal.simek@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251021155347.GA1191808@bhelgaas>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20251021155347.GA1191808@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/21/25 11:53, Bjorn Helgaas wrote:
> On Tue, Oct 21, 2025 at 05:43:22PM +0200, Stefan Roese wrote:
>> While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
>> on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
>> the NVMe interrupts are not delivered to the host CPU resulting in
>> timeouts while probing.
>> 
>> Debugging has shown, that the hwirq numbers passed to this device driver
>> (1...4, 1=INTA etc) need to get adjusted to match the numbers in the
>> controller registers bits (0...3).
>> 
>> This patch now adds pci_irqd_intx_xlate to the INTx IRQ domain ops,
>> handling this IRQ number translation correctly.
> 
> s/pcie-xilinx-dma-pl:/xilinx-xdma:/  # in subject
> s/has shown, that/has shown that/
> s/This patch now adds/Add/
> s/pci_irqd_intx_xlate/pci_irqd_intx_xlate()/
> 
> We'll do this when applying, no need to repost for this.
> 
> I wonder how many other drivers have this issue.
> pci_irqd_intx_xlate() is used only by:
> 
>   dwc/pci-dra7xx.c
>   pcie-altera.c
>   pcie-xilinx-nwl.c
>   pcie-xilinx.c
>   pcie-xilinx-dma-pl.c   # this patch
> 
> Is there something different about these drivers that means they need
> it when all the others don't?

I think many PCI controllers just don't differentiate between legacy
interrupts. e.g. I looked at NXP's LS1046 which is based on DWC and it
does

#interrupt-cells = <1>;
interrupt-map-mask = <0 0 0 7>;
interrupt-map = <0000 0 0 1 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
		<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
		<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
		<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;

which I believe maps all root port legacy interrupts to a single shared
GIC interrupt. Which sort of defeats the purpose of swizzling, but most
stuff uses MSI(-X) now so I guess they figured a status register wasn't
worth the verification.

And yes, I don't think legacy interrupts are tested very much these
days.

--Sean

