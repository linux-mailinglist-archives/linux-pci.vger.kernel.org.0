Return-Path: <linux-pci+bounces-26121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EBAA922A5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E9F19E336D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A47D25335A;
	Thu, 17 Apr 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kucmAJQr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60522371B;
	Thu, 17 Apr 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907194; cv=none; b=B/0Cb4rQeaISUGiUKESVafzUbQdmLYZfPO3B8By9MHDfYY6fjMZR/lniEH4b0Jv/IoW+qhS058/uSigNSvZVRvRENcUjXmm79AKOsnegwt30zNpLzAvUU06tLFjxywJEsJMZ1zArpWl9NJIjkGhHWCayfjWSJ0mRGKHdpI42WRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907194; c=relaxed/simple;
	bh=P9TfWspJnGRbKrqwgptzUFFwYuCKwBJHpoIuQk7N6ZE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AXfbqHW2cb0drf0Lvp4XtUfbXnBVBfN49FmEPXiGLQ6k479kvceCM0Nt59t5QiREqOUR15y5UDRCfJrcmmV5xpqbYucD63f8isJTVjJ0BLxJWMYeaBVmN0sXH9wp9UiCn7fSB02p3GDXQ/7FRwEAlwjO7UynmbeVq8RibODzsqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kucmAJQr; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1744906855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jy2VD4whmMy3I5b19h40sBNvZxMXt8NVw/R9fRE1Af8=;
	b=kucmAJQrSj8aUR00+fmsRWYFWXrdis+l+pkpy7eT+bl5PW6okRBsgCADav+upAPx4S45Y1
	tYW7KOY+/bYi5K/Zum3EHUBzuo+UUY5OfhFzZYHPWbreCDulpkssrW2F97Ntm4wEtZR5TF
	TXZkPLvb5jCQpShxvhmYug0jRjCBF9uMhzRBZnX46krzzo+tV1ICtyvpzF5oWG0Zjvoi40
	kb+a4AH2paAwi9GFeL9VhedE46AbQOYl8EJLXZL6LldB154YqoCZmbfQIEWn1ci6th90EU
	JxzIVwGlVolMa57URgVAmnnXd1OKhHPXI8NVuCkalXnOScMy1wr2FM3m5LTZKg==
Date: Thu, 17 Apr 2025 18:20:54 +0200
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
In-Reply-To: <20250417142138.1377451-1-didi.debian@cknow.org>
References: <20250417142138.1377451-1-didi.debian@cknow.org>
Message-ID: <3e000468679b4371a7942a3e07d99894@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2025-04-17 16:21, Diederik de Haas wrote:
> The documentation for the phy_power_off() function explicitly says
> 
>   Must be called before phy_exit().
> 
> So let's follow that instruction.
> 
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host
> controller driver")
> Cc: stable@vger.kernel.org	# v5.15+
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c624b7ebd118..4f92639650e3 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -410,8 +410,8 @@ static int rockchip_pcie_phy_init(struct
> rockchip_pcie *rockchip)
> 
>  static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
>  {
> -	phy_exit(rockchip->phy);
>  	phy_power_off(rockchip->phy);
> +	phy_exit(rockchip->phy);
>  }
> 
>  static const struct dw_pcie_ops dw_pcie_ops = {

Thanks for the patch, it's looking good to me.  The current state
of the rockchip_pcie_phy_deinit() function might actually not cause
issues because the rockchip_pcie_phy_deinit() function is used only
in the error-handling path in the rockchip_pcie_probe() function,
so having no runtime errors leads to no possible issues.

However, it doesn't mean it shouldn't be fixed, and it would actually
be good to dissolve the rockchip_pcie_phy_deinit() function into the
above-mentioned error-handling path.  It's a short, two-line function
local to the compile unit, used in a single place only, so dissolving
it is safe and would actually improve the readability of the code.

Thus, please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

and please consider dissolving the rockchip_pcie_phy_deinit() function
in the possible v2 of this patch, as suggested above.

