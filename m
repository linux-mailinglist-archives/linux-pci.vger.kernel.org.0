Return-Path: <linux-pci+bounces-18509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7219F3305
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DDB16B57A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF649207A06;
	Mon, 16 Dec 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7MYIZNk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA860206295
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358669; cv=none; b=ELRSOYAafClFMcL2pb/b5u/tz5yQZEU3TQoSmdymXkXK3ML3rCPyCBuLdVq03lkwiE8JWYtv2eYFaLGxuGXTXy4BsXcl2V0/MS/ipPcXEsQa7Pd8tT1rdSueEXr3eIQ2qlDUwDo2rFdiBpq4qKUgMWFn1bhFaoxRpPmsxxupuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358669; c=relaxed/simple;
	bh=VVMcA0zaoa5Q68EBEIQKVp9T5MBh6Ejh4BrJ+t0bDLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfsMts/nnaAucWM/7JXU3dB+WP8CnmbsuKbQbks/iyxCloUoFMM4imf3pr/+D8RhPpKq4YFzGkm80Fne37VipYGkSLzK+MtDU9S1a+d6QBnomnL7qGfV4BFVbtcoqWUq/rNPIx4P7YtTy3tH71LpczSVFLwUytVj9FJADbQhv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7MYIZNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C224C4CED0;
	Mon, 16 Dec 2024 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734358669;
	bh=VVMcA0zaoa5Q68EBEIQKVp9T5MBh6Ejh4BrJ+t0bDLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F7MYIZNkzZZu3d9EC70Tg4W+/s0HRfD/UKjwYYFvLxz7/dUvHubRERBT9086fLzAR
	 AenWqI4LQA5MxXdKgSP/QaSvToW43wOlHVzPEiBZNcxciquNEwIInHf8WUf7GeY3gb
	 hFcXU/cmFzb8sIMK6kLhcEyBkAwiB++5wIHI52Kh+T8AhhBTZlSEFyen+yqCNl1K28
	 Ga07tlyzWT0uvw8c9KC74tXUU83F4HdIRWtSNlD8oJRHfKCP8BJ74yGgd6MY1Q60r1
	 FKntqmpjhMogfmfWoB58VEfiF7Fgj8mXAawsMyxygR8CfFwpvt6+ScnY6vwn8r+CHi
	 3e7LxP7VDUwUw==
Message-ID: <6fafbc61-730d-45f9-a31e-d5bac5d8bce1@kernel.org>
Date: Mon, 16 Dec 2024 08:17:46 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-linus v2 1/3] PCI: Assume 2.5 GT/s if Max Link Speed
 is undefined
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <cover.1734257330.git.lukas@wunner.de>
 <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/2024 04:20, Lukas Wunner wrote:
> Broken PCIe devices may not set any of the bits in the Link Capabilities
> Register's "Max Link Speed" field.  Assume 2.5 GT/s in such a case,
> which is the lowest possible PCIe speed.  It must be supported by every
> device per PCIe r6.2 sec 8.2.1.
> 
> Emit a message informing about the malformed field.  Use KERN_INFO
> severity to minimize annoyance.  This will help silicon validation
> engineers take note of the issue so that regular users hopefully never
> see it.
> 
> There is currently no known affected product, but a subsequent commit
> will honor the Max Link Speed field when determining supported speeds
> and depends on the field being well-formed.  (It uses the Max Link Speed
> as highest bit in a GENMASK(highest, lowest) macro and if the field is
> zero, that would result in GENMASK(0, lowest).)
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   drivers/pci/pci.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35dc9f249b86..ab0ef7b6c798 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6233,6 +6233,13 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>   	u32 lnkcap2, lnkcap;
>   	u8 speeds;
>   
> +	/* A device must support 2.5 GT/s (PCIe r6.2 sec 8.2.1) */
> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +	if (!(lnkcap & PCI_EXP_LNKCAP_SLS)) {
> +		pci_info(dev, "Undefined Max Link Speed; assume 2.5 GT/s\n");

As it's just theoretical, shouldn't it be noisier?  I'm thinking at 
least pci_warn().  Otherwise if this goes in and stays at pci_info() 
it's going to be a lot easier to miss.

Whereas at least messages that are warn or err get a more thorough look 
at during hardware bring up.

> +		return PCI_EXP_LNKCAP2_SLS_2_5GB;
> +	}
> +
>   	/*
>   	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
>   	 * Speeds Vector to allow using SLS Vector bit defines directly.
> @@ -6244,8 +6251,6 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>   	if (speeds)
>   		return speeds;
>   
> -	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> -
>   	/* Synthesize from the Max Link Speed field */
>   	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
>   		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;


