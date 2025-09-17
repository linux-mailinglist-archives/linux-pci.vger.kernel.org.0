Return-Path: <linux-pci+bounces-36357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98AB7F9C7
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BBA18936FD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8E1B424F;
	Wed, 17 Sep 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UcKiHouV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75E233140;
	Wed, 17 Sep 2025 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116670; cv=none; b=klhjhyFc6KWcQXu6DNMvCZSXdhG9ByCxbzxa3GdJTO1zqDUnEsznJUUgi4RAY58fEabpfExpXDV/p9MxLv4J02BY1I13JEcL67emtmjWyq59ypRPPkxbkfErZ44WyhzZ4srQHHtIeQ6ecUBvKoiMO6NATQiBvq/CLb9/j76nxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116670; c=relaxed/simple;
	bh=u90Fk5cPBbawK5fK7gzSnozL1IIQ7AgT4sUYW+7MSC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPCqvUYi0Yp7Z7CQh7YhsjuqjNnaTjADOsBZemmOUwwk5ynvnnvpJ5GIgWYFwour1f4CuMk5T2R3zqmwPFaz/bNmpDDbgNWVd6ioiS1Welc0U0s+5NjvBej4FhOMkG3sv2BVvm41hX6NPnXP0L2J4xqCoFpugjfgZiENIXz6ZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UcKiHouV; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cRg3l0V4Lz9tK1;
	Wed, 17 Sep 2025 15:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758116659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urDXGyEsj1r/aJXZk5lMxgMwOCYoe0BVA9dDdk/rdpU=;
	b=UcKiHouV+A8jmB7/LKNJtMjIN0Jx/qBupdrfggZnpDsME3ImnILP5VJkpj3m27ODrqk0Ih
	tBN33C6MGi+R62WpEjjO4SkXZHG0KSjuZ3Y/Ftl1dDBpdJCZmM2+uYAR48FnxuY450dh15
	xeKHjFIBZXFlcOesTKSgh+H6EamLKAJuLKWGsKP43D9tDfIzTsXQSaRjA31rBKZ4Xxm3wf
	jBwBpldOLukXdxsZyY+hRmLvGSv9NmuVAMjOL2M2rpnaw6NKz3UiYKOHYamGhrILXH140N
	dcLOV1S8R01Xh7nVUBSll9AaL81mo0DtAdxO+dGmwyx86tCa3lxhx1kxcmiPGg==
Message-ID: <bf385367-bec7-432c-af2b-1c1bd269547e@mailbox.org>
Date: Wed, 17 Sep 2025 15:44:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY
 initialization
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250916181558.GA1810654@bhelgaas>
 <643c9b19-dda4-43c5-bb6d-aa0705053d43@mailbox.org>
 <CAMuHMdXh0rxpLXW+3yCP7hZNwacVcuc3Wp5t8CiDJ2HE=P+OiQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdXh0rxpLXW+3yCP7hZNwacVcuc3Wp5t8CiDJ2HE=P+OiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 75b0886a497c68c846f
X-MBO-RS-META: dczkuht97h9yh5n3egsxea9qkhkii97i

On 9/17/25 10:00 AM, Geert Uytterhoeven wrote:

Hello Geert,

>> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
>> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
>> @@ -688,12 +688,14 @@ static int cpg_mssr_reset(struct
>> reset_controller_dev *rcdev,
>>
>>          /* Reset module */
>>          writel(bitmask, priv->pub.base0 + priv->reset_regs[reg]);
>> +       readl(priv->pub.base0 + priv->reset_regs[reg]);
>>
>>          /* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
>>          udelay(35);
>>
>>          /* Release module from reset state */
>>          writel(bitmask, priv->pub.base0 + priv->reset_clear_regs[reg]);
>> +       readl(priv->pub.base0 + priv->reset_clear_regs[reg]);
>>
>>          return 0;
>>    }
>> @@ -708,6 +710,7 @@ static int cpg_mssr_assert(struct
>> reset_controller_dev *rcdev, unsigned long id)
>>          dev_dbg(priv->dev, "assert %u%02u\n", reg, bit);
>>
>>          writel(bitmask, priv->pub.base0 + priv->reset_regs[reg]);
>> +       readl(priv->pub.base0 + priv->reset_regs[reg]);
>>          return 0;
>>    }
>>
>> @@ -722,6 +725,7 @@ static int cpg_mssr_deassert(struct
>> reset_controller_dev *rcdev,
>>          dev_dbg(priv->dev, "deassert %u%02u\n", reg, bit);
>>
>>          writel(bitmask, priv->pub.base0 + priv->reset_clear_regs[reg]);
>> +       readl(priv->pub.base0 + priv->reset_clear_regs[reg]);
>>          return 0;
>>    }
>>
> 
> Yes, reading the reset registers after writing works, too.
> 
> I just noticed the module reset operation in the R-Car V4H Hardware
> User's Manual has changed from R-Car Gen2/Gen3, and is now more complex,
> with three different reset types, depending on the module to be reset
> (see Section 9.3 "Operation" subsection (2) "Software Reset").
> The most striking difference is that there is no more mention of
> a single delay of 1 RCLK cycle (cfr. the udelay(35) above), but of
> much longer delays of 1 ms.
> 
> As drivers/pci/controller/dwc/pcie-rcar-gen4.c does not call the
> combined reset_control_reset() , but uses separate
> reset_control_assert() and reset_control_deassert() calls, the PCIe
> driver itself is responsible for enforcing this 1 ms delay.

Shouldn't we patch the reset driver and insert unconditional 1ms delay 
into reset_assert() callback ?

> Which is exactly what your introduction of mdelay(1) (just after the
> out-of-context call to reset_control_deassert()) does, so I believe
> we're all set?

No, I do not think so. Figure 9.3.2 Software Reset flow (B) on page 585 
does NOT describe 1ms delay after write into SRSTCLR register. It does 
describe 1ms delay after write into SRCR register. That means, we need 
1ms delay after reset_control_assert(), but it does NOT mean we need 1ms 
delay after reset_control_deassert() . That means the issue remains 
unexplained ?

