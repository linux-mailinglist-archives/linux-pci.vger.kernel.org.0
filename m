Return-Path: <linux-pci+bounces-38846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C05BF48EE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 06:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 760A54E294B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900332045B7;
	Tue, 21 Oct 2025 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDKslZKj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570DF8615A;
	Tue, 21 Oct 2025 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019292; cv=none; b=RIWjcJE9EUZTA2pBdxZYzv99pw7+osbekeA3aGqoChF1cSgwdbUIcxKPli3UvUWNbuoi+7sSsLXNdYIVSw/c5wipy3r+r4byZLgaq8TTraLhAWJxiRTieRbYeS9x6g32xDa7dgqME67YUY3MzLMtMnxsaYbkgAZammSj/W8I7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019292; c=relaxed/simple;
	bh=eCjhpCkDpBoDgtZEpxtO52wzVLa4g0Hym+CP1lR4QRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQjOxd9PV32T79Q6+l3Gv+uKRAOoGZV0tc6UMgsm7k7MhfBciS08DdfAnPpHadBqSRZqrrDb3GkGPuA8N/7+h3gii4iSHoEyF7IEEYZESOOq9CX5judHHFjsFe7DwRr0kT52T5Ae735C8fVZkIKJgigyxzXe0Au6mUifzCBkSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDKslZKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FD7C4CEF1;
	Tue, 21 Oct 2025 04:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761019291;
	bh=eCjhpCkDpBoDgtZEpxtO52wzVLa4g0Hym+CP1lR4QRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDKslZKj3wXmWKyTC1AchGeWsDwJ2oc9gFLucFMAnIgJdL5tHFqcEQdW8yTGPGMS+
	 0JhYF0+VbjyOd02uj0XE6jZv7BG6mtdpylWjM494zMTkrqSnIf06qVrJyWW2NVvpns
	 zLZvnLT+MwfjGE/7nb1gwPz+wCSgOvV8CVqkHPKxWgHq1XjSo4zpxyrzMfUNXFnhCe
	 7ZdM8H4Ibbdd1EybAAj8mFsP3GSfxGcRZ1mhlSz2Z88e6WxTT93IWmY+CXSRRLdPFB
	 yGVIUtbKS2BQ9zITP6pkVIo4/JtEafY0TQsZW54s8j8MS1pecSdtUs3AzkmZ5LTp5j
	 CR/l9OCzsVSkg==
Date: Tue, 21 Oct 2025 09:31:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Christian Zigotzky <chzigotzky@xenosoft.de>, FUKAUMI Naoki <naoki@radxa.com>, linux-rockchip@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <lmkrtyq6uzhzlz5ttvajnmojegrbfgaz3e3kkwej5qar2lkeof@r5gdlvesm6xl>
References: <20251020221217.1164153-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020221217.1164153-1-helgaas@kernel.org>

On Mon, Oct 20, 2025 at 05:12:07PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> platforms") enabled Clock Power Management and L1 Substates, but that
> caused regressions because these features depend on CLKREQ#, and not all
> devices and form factors support it.

I believe we haven't concluded that CLKREQ# is the cluprit here. It is probably
the best bet, but there could be the device specific issues as well.

> 
> Enable only ASPM L0s and L1, and only when both ends of the link advertise
> support for them.
> 
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/

Closes?

> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> Link: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/

Same here.

> ---
> 
> Mani, not sure what you think we should do here.  Here's a stab at it as a
> strawman and in case anybody can test it.
> 

Thanks Bjorn! I had a similar change slated to be sent post Diwali, but you beat
me to it.

> Not sure about the message log message.  Maybe OK for testing, but might be
> overly verbose ultimately.
> 

Let's have it for sometime, so we have some clue when someone reports issue with
ASPM.

> ---
>  drivers/pci/pcie/aspm.c | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7cc8281e7011..dbc74cc85bcb 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -243,8 +243,7 @@ struct pcie_link_state {
>  	/* Clock PM state */
>  	u32 clkpm_capable:1;		/* Clock PM capable? */
>  	u32 clkpm_enabled:1;		/* Current Clock PM state */
> -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
> -					   override */
> +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
>  };
>  
> @@ -376,18 +375,6 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  	pcie_set_clkpm_nocheck(link, enable);
>  }
>  
> -static void pcie_clkpm_override_default_link_state(struct pcie_link_state *link,
> -						   int enabled)
> -{
> -	struct pci_dev *pdev = link->downstream;
> -
> -	/* For devicetree platforms, enable ClockPM by default */
> -	if (of_have_populated_dt() && !enabled) {
> -		link->clkpm_default = 1;
> -		pci_info(pdev, "ASPM: DT platform, enabling ClockPM\n");
> -	}
> -}
> -
>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>  	int capable = 1, enabled = 1;
> @@ -410,7 +397,6 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  	}
>  	link->clkpm_enabled = enabled;
>  	link->clkpm_default = enabled;
> -	pcie_clkpm_override_default_link_state(link, enabled);
>  	link->clkpm_capable = capable;
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
> @@ -811,19 +797,17 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>  	struct pci_dev *pdev = link->downstream;
>  	u32 override;
>  
> -	/* For devicetree platforms, enable all ASPM states by default */
> +	/* For devicetree platforms, enable L0s and L1 by default */
>  	if (of_have_populated_dt()) {
> -		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> +		if (link->aspm_support & PCIE_LINK_STATE_L0S)
> +			link->aspm_default |= PCIE_LINK_STATE_L0S;
> +		if (link->aspm_support & PCIE_LINK_STATE_L1)
> +			link->aspm_default |= PCIE_LINK_STATE_L1;

Not sure if it is worth setting these states conditionally. Link state
enablement code should make use of the cached ASPM cap in 'link->aspm_capable'.

>  		override = link->aspm_default & ~link->aspm_enabled;
>  		if (override)
> -			pci_info(pdev, "ASPM: DT platform, enabling%s%s%s%s%s%s%s\n",
> -				 FLAG(override, L0S_UP, " L0s-up"),
> -				 FLAG(override, L0S_DW, " L0s-dw"),
> -				 FLAG(override, L1, " L1"),
> -				 FLAG(override, L1_1, " ASPM-L1.1"),
> -				 FLAG(override, L1_2, " ASPM-L1.2"),
> -				 FLAG(override, L1_1_PCIPM, " PCI-PM-L1.1"),
> -				 FLAG(override, L1_2_PCIPM, " PCI-PM-L1.2"));
> +			pci_info(pdev, "ASPM: DT platform, enabling%s%s\n",

I think you added the 'DT platform,' prefix while applying my patch earlier.
This is somewhat redundant since the print implies that the platform is based on
devicetree.

Rest LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

