Return-Path: <linux-pci+bounces-26141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769DA924F7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F893B9FC9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7F25DB1B;
	Thu, 17 Apr 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hRLFZPO0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73E2566CE;
	Thu, 17 Apr 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912568; cv=none; b=Scj61ZyLsqKM26PLVSqEWxB9bgO1ZUtE1ohPKWEoIkXGdUeU+3RgB6kTjh8S0rQj5mtdSQ4Akqmqq1YBs/lzLO03f/z0plycYDvlbQEaPiqlxPtmqbNXXfjQCTms6KgbnijBnMR8DKKieNb1m6X6YMS03AIlvg2qCG0z1A9GRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912568; c=relaxed/simple;
	bh=l6BnmTUjQxq88PIZctmVeHxUE5rsREhbGV6Zl/Vho+M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XHADKk0vAgtcja9HcJ8EWi1RCDX9S6ndqeaU4FViXKdF/mVHmZYCH3uEncI/lYaFYPXULi4Mi3F8sx6vZ3/Sg6kq3HLucgX7dPk8yyhn9mM9gIQn4MbNy5BIUDezC/ry6KUWekB64HMDO+qK9xds26edIAn9q+gtC13Rncs3dAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hRLFZPO0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1744912563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQzclTKLI3van/CH/5ZiT8li8vzwRaoxSxml69VlxEw=;
	b=hRLFZPO07cDgA65qQ6Ex8y4itgzRLJrCdRGXla7hzcdJ2bZtAl2K252nfYlMRrLC1CBaZ/
	HSzqVO6xkyyOCsDUpv0m4jK60IlPyKwjwzyqIKBHEPhZHnQ8947c4rjoXGk5ZE2WQ4nxe+
	GbdZ3O1gHH9pUyJ6WPVnblqXQhtRzE72NXorS+eLaZsWkOSUTT0NF03aPj2JKAquOFdr2M
	cCxI3paLbEDVmylA0EkDCu9ogUg8txWgEtYOg2P7fUCJbfWwW6fp2tpXCXe8FXC8Nfhytt
	SfXmXK+o/jXqiyfUY0v2ovkSGr5JDtH0wEEYYLclPWT49Y0ymKCKoj5fYW/cXQ==
Date: Thu, 17 Apr 2025 19:56:02 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy?=
 =?UTF-8?Q?=C5=84ski?= <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Shawn Lin
 <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Fix function call sequence in
 rockchip_pcie_phy_deinit
In-Reply-To: <D992W9V9ZH2J.2Z2OLK00N0FIU@cknow.org>
References: <20250417142138.1377451-1-didi.debian@cknow.org>
 <3e000468679b4371a7942a3e07d99894@manjaro.org>
 <D992W9V9ZH2J.2Z2OLK00N0FIU@cknow.org>
Message-ID: <ad4b2140f5a4bf20b199ab092f28def7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2025-04-17 19:09, Diederik de Haas wrote:
> On Thu Apr 17, 2025 at 6:20 PM CEST, Dragan Simic wrote:
>> On 2025-04-17 16:21, Diederik de Haas wrote:
>>> The documentation for the phy_power_off() function explicitly says
>>> 
>>>   Must be called before phy_exit().
>>> 
>>> So let's follow that instruction.
>>> 
>>> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host
>>> controller driver")
>>> Cc: stable@vger.kernel.org	# v5.15+
>>> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> index c624b7ebd118..4f92639650e3 100644
>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> @@ -410,8 +410,8 @@ static int rockchip_pcie_phy_init(struct
>>> rockchip_pcie *rockchip)
>>> 
>>>  static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
>>>  {
>>> -	phy_exit(rockchip->phy);
>>>  	phy_power_off(rockchip->phy);
>>> +	phy_exit(rockchip->phy);
>>>  }
>>> 
>>>  static const struct dw_pcie_ops dw_pcie_ops = {
>> 
>> Thanks for the patch, it's looking good to me.  The current state
>> of the rockchip_pcie_phy_deinit() function might actually not cause
>> issues because the rockchip_pcie_phy_deinit() function is used only
>> in the error-handling path in the rockchip_pcie_probe() function,
>> so having no runtime errors leads to no possible issues.
>> 
>> However, it doesn't mean it shouldn't be fixed, and it would actually
>> be good to dissolve the rockchip_pcie_phy_deinit() function into the
>> above-mentioned error-handling path.  It's a short, two-line function
>> local to the compile unit, used in a single place only, so dissolving
>> it is safe and would actually improve the readability of the code.
> 
> This patch came about while looking at [1] "PCI: dw-rockchip: Add 
> system
> PM support", which would be the 2nd consumer of the
> rockchip_pcie_phy_deinit() function. That patch's commit message has 
> the
> following: "tries to reuse possible exist(ing) code"
> 
> Being a fan of the DRY principle, that sounds like an excellent idea 
> :-)
> 
> So while you're right if there would only be 1 consumer, which is the
> case *right now*, given that a 2nd consumer is in the works, I think
> it's better to keep it as I've done it now.
> Let me know if you disagree (including why).
> 
> [1] 
> https://lore.kernel.org/linux-rockchip/1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com/

Ah yes, you're right, thanks for reminding me about that patch.  I saw
it before, but I totally forgot about it for a moment.

I agree that keeping the rockchip_pcie_phy_deinit() function is the way
to go.  Yes, it's a short function, but maybe we'll need to do something
more in it at some point, which would then be propagated to all of its
consumers, instead of having to change all of the "dissolved instances"
individually.

