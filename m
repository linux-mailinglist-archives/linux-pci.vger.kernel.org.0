Return-Path: <linux-pci+bounces-33388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0DB1AA05
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD35017FE64
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382341DE2BF;
	Mon,  4 Aug 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NtZ7vfTs"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535B1A0BFD
	for <linux-pci@vger.kernel.org>; Mon,  4 Aug 2025 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754338845; cv=none; b=qdi3uxDrE79qrm4CYAvDwyJtV57Jcqu35WHTVLgqnc2IDHu/NfK9WsmhVvAi7MUGFPmYle9vQDPxZQNS0EqJ4TEZehG98h/HDjQNodkfHTUEGYRc3g8JcAgAf7jrYlR+9ZgHnPpvW4TMPxA3fTuqVKqb7b785b3tyIhrL1wgzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754338845; c=relaxed/simple;
	bh=YjQbVGZ10/wVMGdirj9GuSTwQwkGNi1tq7XMtOnjfac=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ueC6fFotuPnYnA+zhTSWeDW7lT/adtOHXiJbD+w7dKFa8a34bPVjf7fv530X92qttP5Msacjtut7IpLghHgG5FUFFvkNN0UynMKeftJ7u5lIasWbIz9blR63de5j3aVbHp2mQFYdN5iPrDhpJ2tDKg59ZRq9RGizV3/kSIe0bvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NtZ7vfTs; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8df3b328-0e6e-4117-9707-de0e39f74d2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754338831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0i+xPHurVHWx/5i/nPmO2IbGaJdwKMLJnL0X+J3opIM=;
	b=NtZ7vfTsMnVhi5pZZn2gfy2FUt1IAXghcC4Zk5QcBWKrSXmi+6wzArReak2Fq8Oc6mkbNa
	9kgB0dmRvyblbKMVfSkRq3eltMtH5lffNMG+tEckQ7g2mQqYhNqsvyhJxpZ5PiefJH5jLo
	bNlkOxDtcnO5uB1NskZhksMBlbNLeW0=
Date: Mon, 4 Aug 2025 16:20:26 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] pci: nwl: Unhandled AER correctable error
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <53f6d267-62af-4dad-8fa7-a2a497b22636@linux.dev>
Content-Language: en-US
In-Reply-To: <53f6d267-62af-4dad-8fa7-a2a497b22636@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/1/25 13:43, Sean Anderson wrote:
> Hi,
> 
> AER correctable errors are pretty rare. I only saw one once before and
> came up with commit 78457cae24cb ("PCI: xilinx-nwl: Rate-limit misc
> interrupt messages") in response. I saw another today and,
> unfortunately, clearing the correctable AER bit in MSGF_MISC_STATUS is
> not sufficient to handle the IRQ. It gets immediately re-raised,
> preventing the system from making any other progress. I suspect that it
> needs to be cleared in PCI_ERR_ROOT_STATUS. But since the AER IRQ never
> gets delivered to aer_irq, those registers never get tickled.
> 
> The underlying problem is that pcieport thinks that the IRQ is going to
> be one of the MSIs or a legacy interrupt, but it's actually a native
> interrupt:
> 
>            CPU0       CPU1       CPU2       CPU3       
>  42:          0          0          0          0     GICv2 150 Level     nwl_pcie:misc
>  45:          0          0          0          0  nwl_pcie:legacy   0 Level     PCIe PME, aerdrv
>  46:         25          0          0          0  nwl_pcie:msi 524288 Edge      nvme0q0
>  47:          0          0          0          0  nwl_pcie:msi 524289 Edge      nvme0q1
>  48:          0          0          0          0  nwl_pcie:msi 524290 Edge      nvme0q2
>  49:         46          0          0          0  nwl_pcie:msi 524291 Edge      nvme0q3
>  50:          0          0          0          0  nwl_pcie:msi 524292 Edge      nvme0q4
> 
> In the above example, AER errors will trigger interrupt 42, not 45.
> Actually, there are a bunch of different interrupts in MSGF_MISC_STATUS,
> so maybe nwl_pcie_misc_handler should be an interrupt controller
> instead? But even then pcie_port_enable_irq_vec() won't figure out the
> correct IRQ. Any ideas on how to fix this?

OK, so as a first pass, maybe something like

	if (misc_stat & (MSGF_MISC_SR_FATAL_AER | MSGF_MISC_SR_NON_FATAL_AER
			 MSGF_MISC_SR_CORR_AER))
		generic_handle_domain_irq(pcie->legacy_irq_domain, 0);

to simulate the correct IRQ. I have no idea whether it's safe to call
generic_handle_domain_irq in this context. It wasn't OK for AER (see
commit 9ae052253785 ("PCI/AER: Fix the broken interrupt injection")),
but maybe it's OK for us since the legacy irqchip doesn't support
affinity? I CC'd Thomas and maybe he can comment.

Otherwise, maybe the best thing is to just add an API to manually trigger AER.

> Additionally, any tips on actually triggering AER/PME stuff in a
> consistent way? Are there any off-the-shelf cards for sending weird PCIe
> stuff over a link for testing? Right now all I have 

But I still don't know how to test this. I can inject a misc interrupt
since the GIC supports irq_set_irqchip_state, but that won't really
simulate an AER interrupt since MSGF_MISC_STATUS won't have the right
bit set. Maybe I can wiggle a card around in its slot? Maybe PME or link
bandwidth notification could trigger this as well?

--Sean

