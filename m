Return-Path: <linux-pci+bounces-3797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0285CA4E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 23:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AB71C21014
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 22:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840D152E04;
	Tue, 20 Feb 2024 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TebnZ0Od"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6307152DFF;
	Tue, 20 Feb 2024 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466562; cv=none; b=KEToXokXdkq5l9JiCmqG/d6VeCyj0uOKBjSTC9Jx/cW6Ptd10z84Wv3zbuD0ZIyiKCp6UBtLGJBZNtzP05Zr0n9+f1ZoFUpqLaVhMdzSORK24yU/ZW6elpk3+2Hf3Sr3CAYhwZd48oFwvAofQx2aE/TH3l21I3VeOT91/8xn+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466562; c=relaxed/simple;
	bh=oJby7EduJlcAAHFPkg3SVRpnuGfP2qzVNHnuUtdsF7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l6iqHz3A3c2P6e2zLet80hwBDsbne1g+wGhhR0BXIj8f9O8Kg4bkf6L/gPJ++1c1GVvhCadRkxyeMNfzToi4FXCicovOrk4IZT5StQBr3dOI9lUFaYAUQFQFMNaIEY75kqNM6Y1vQvy+Tj7ouUFF8axAeDVpYlL+6I7tBNKnVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TebnZ0Od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8454C43390;
	Tue, 20 Feb 2024 22:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708466562;
	bh=oJby7EduJlcAAHFPkg3SVRpnuGfP2qzVNHnuUtdsF7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TebnZ0OdLnRIHR9anB+uo/sSFYhpPL09Ix4MZBBBbuKbHoWF300KlOgVLXvm9yUi8
	 ojZZxxzAYO+Bkb3YGky8d7wDQsuzAU08t3SlvVdoKzlUEjOsgU2/25odXLaQTvr5ap
	 h6D+jQtr0K4AkK/lgmx6cw5xqGYbGI6GixqbTBk0pgIkWDEYezegzdI/ktF9WWcOwK
	 QAlbarZIIbc3x4riY0tan0fcCTe/TOzKiJGUziEgZCvmewFL6tDvbJ6wnbzY1i7D2G
	 qkukkzfMfPS4DSD43MYdX/Y7Wf/eNb+kijNlOj0BWG2IX95DcMPURdgjBv90lwWwxT
	 CEaX2hKQ43+4g==
Date: Tue, 20 Feb 2024 16:02:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240220220240.GA1507934@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org>

On Wed, Feb 14, 2024 at 05:16:09PM +0530, Manivannan Sadhasivam wrote:
> Currently, PCI core will enable D3 support for PCI bridges only when the
> following conditions are met:

Whenever I read "D3", I first have to figure out whether we're talking
about D3hot or D3cold.  Please save me the effort :)

> 1. Platform is ACPI based
> 2. Thunderbolt controller is used
> 3. pcie_port_pm=force passed in cmdline

Are these joined by "AND" or "OR"?  I guess probably "OR"?

"... all the following conditions are met" or "... one of the
following conditions is met" would clarify this.

> While options 1 and 2 do not apply to most of the DT based platforms,
> option 3 will make the life harder for distro maintainers. Due to this,
> runtime PM is also not getting enabled for the bridges.
> 
> To fix this, let's make use of the "supports-d3" property [1] in the bridge
> DT nodes to enable D3 support for the capable bridges. This will also allow
> the capable bridges to support runtime PM, thereby conserving power.

Looks like "supports-d3" was added by
https://github.com/devicetree-org/dt-schema/commit/4548397d7522.
The commit log mentions "platform specific ways", which suggests maybe
this is D3cold, since D3hot should be supported via PMCSR without any
help from the platform.

So I *guess* this really means "platform provides some non-architected
way to put devices in D3cold and bring them back to D0"?

> Ideally, D3 support should be enabled by default for the more recent PCI
> bridges, but we do not have a sane way to detect them.
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-pci-bridge.yaml#L31

This link won't remain accurate as lines are added/removed.  The
kernel.org cgit allows specific commits
(https://git.kernel.org/linus/0dd3ee311255) or line references at
specific commits or tags
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.0#n94)

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> This patch is tested on Qcom SM8450 based development board with an out-of-tree
> DT patch.
> 
> NOTE: I will submit the DT patches adding this property for applicable bridges
> in Qcom SoCs separately.
> 
> Changes in v3:
> - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org
> 
> Changes in v2:
> - Switched to DT based approach as suggested by Lukas.
> - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
> ---
>  drivers/pci/of.c  | 12 ++++++++++++
>  drivers/pci/pci.c |  3 +++
>  drivers/pci/pci.h |  6 ++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 51e3dd0ea5ab..24b0107802af 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -786,3 +786,15 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>  	return slot_power_limit_mw;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> +
> +/**
> + * of_pci_bridge_d3 - Check if the bridge is supporting D3 states or not
> + *
> + * @node: device tree node of the bridge
> + *
> + * Return: %true if the bridge is supporting D3 states, %false otherwise.
> + */
> +bool of_pci_bridge_d3(struct device_node *node)
> +{
> +	return of_property_present(node, "supports-d3");
> +}
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8f11a078924..8678fba092bb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	if (pci_use_mid_pm())
>  		return false;
>  
> +	if (dev_of_node(&dev->dev))
> +		return of_pci_bridge_d3(dev->dev.of_node);
> +
>  	return acpi_pci_bridge_d3(dev);
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2336a8d1edab..10387461b1fe 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -635,6 +635,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
>  u32 of_pci_get_slot_power_limit(struct device_node *node,
>  				u8 *slot_power_limit_value,
>  				u8 *slot_power_limit_scale);
> +bool of_pci_bridge_d3(struct device_node *node);
>  int pci_set_of_node(struct pci_dev *dev);
>  void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
> @@ -673,6 +674,11 @@ of_pci_get_slot_power_limit(struct device_node *node,
>  	return 0;
>  }
>  
> +static inline bool of_pci_bridge_d3(struct device_node *node)
> +{
> +	return false;
> +}
> +
>  static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> 
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240131-pcie-qcom-bridge-b6802a9770a3
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

