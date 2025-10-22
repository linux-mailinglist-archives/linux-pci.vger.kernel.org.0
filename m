Return-Path: <linux-pci+bounces-39059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7664DBFDFAA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 21:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 310484E9CC6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2781E34D900;
	Wed, 22 Oct 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPxm6oeD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE93148DB;
	Wed, 22 Oct 2025 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160395; cv=none; b=enhsIC3L2WnL03RvKaPs29xxi/zZHTBHEBHqsxtM7M2WeLV+QSf3setGx4f7clL/Ec1Mtkup3yCyYCmcORDUfY1QK6iU78b6COEsQ050hA/3+Rcy8KvLIZxOM3gCjbD1hu4WaOhOrDRRGZNJgBfNLkGQlLsCjCfdH9/LE40zzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160395; c=relaxed/simple;
	bh=8uGN4FvBftrBvLhOTmco3a7alnRnF6eitTO3wGVcb24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TR+YSRkH+M59kwlsSdftMOEtO5CE0QXwqefoOyCp782S3PV5cQqLgPzq0gYCIfccBquRMFhhD3FtXvrg0czkHT7BLvYCimrprhPgjAvpbwLovWrFNHI21DioREtmmd7mC++LDQRdkCP1fwDdjn4E/d1VUCydwp5H60AKMKovAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPxm6oeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B31C4CEE7;
	Wed, 22 Oct 2025 19:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160394;
	bh=8uGN4FvBftrBvLhOTmco3a7alnRnF6eitTO3wGVcb24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mPxm6oeDeQTUXPncQnkBskDqKjnRisrRwYzjJg/CbY4xAjjde4Sx22mgo3jZy0r8i
	 +uWOZooEx7G0qi9mWpJQIIeaRm619EUgqnYNvW0hDImmr1Gw1vwF+6ENGHOqJ+PiWK
	 kyTulr+mkl2dzM9KQBYcMxSxuu1c3vtyxJr0pToeX5VjiRfqeauQwpY46jqzssBKdS
	 FuAdv4qeiCEtLA/jq17huLRNffdBRxQFJprJ/lX6ZXTVxLX461VJBSS9dzPFK6Z1ri
	 0bfl+Z8uf+yvTt9SCpOyunV1PMHqlDB4LL8T9cwrvGks2L8+rhUPfIyFuVwuv5C+bx
	 rQX5Zg/3wFIcA==
Date: Wed, 22 Oct 2025 14:13:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>, linux-rockchip@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <20251022191313.GA1265088@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020221217.1164153-1-helgaas@kernel.org>

Christian, Naoki, any chance you could test this patch on top of
v6.18-rc1 to see whether it resolves the problem you reported?

I'd like to verify that it works before merging it.

On Mon, Oct 20, 2025 at 05:12:07PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> platforms") enabled Clock Power Management and L1 Substates, but that
> caused regressions because these features depend on CLKREQ#, and not all
> devices and form factors support it.
> 
> Enable only ASPM L0s and L1, and only when both ends of the link advertise
> support for them.
> 
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> Link: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/
> ---
> 
> Mani, not sure what you think we should do here.  Here's a stab at it as a
> strawman and in case anybody can test it.
> 
> Not sure about the message log message.  Maybe OK for testing, but might be
> overly verbose ultimately.
> 
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
> +				 FLAG(override, L0S, " L0s"),
> +				 FLAG(override, L1, " L1"));
>  	}
>  }
>  
> -- 
> 2.43.0
> 

