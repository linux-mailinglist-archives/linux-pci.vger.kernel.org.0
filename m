Return-Path: <linux-pci+bounces-36284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4ECB59F07
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 19:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48671B28AE9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420022D7B0;
	Tue, 16 Sep 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0lmxE5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87459221DB6;
	Tue, 16 Sep 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042948; cv=none; b=B15A4nVYZV4UfrAp/R1enehazQMw6cK7YpDeQHfBt93hxYvn3zXzdZ8+/EJNGCNqCElNHKI/oUR7ZrL/sfC2KyQ8UOFv5E4UmN60f7OVUMEfJCkU1TiKH/cvhl4gvDtfdGRkxV2Xc6hEWxEh+bLdJl9xT5okHfTWJ65A9JHnuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042948; c=relaxed/simple;
	bh=vRy+su+VX+xtMWbSqAx0H8SSt8pZJJ5h/1raCm0MN5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pYISXH3lLSkGyIa9RjZ3ABRWzIf8g4xvK64ZUplcJnE51FpjVBjwhnr2t7vTMBh1mqY0Su8wtU2Bsk0kF4vMVTIv4H2EKZoyMPKK4Jqom6vTh82acxMWstkF49mbi/zEhNQxPWenMPvNAHh31lexoGkb/0WueUFJBPPkDfbe2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0lmxE5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342C7C4CEEB;
	Tue, 16 Sep 2025 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758042948;
	bh=vRy+su+VX+xtMWbSqAx0H8SSt8pZJJ5h/1raCm0MN5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R0lmxE5OwNjMUtQvS/iKpZ5fatU2z/4PTZKaiUVZJWv6oIbJbIiBfraJrVWYwbNtU
	 MFVDG1M5Ofiph9nEY9lGxLegQZW1OBTjWsW5hTGXL3tlyNs1Kv1PHGgwY8nYoLApNV
	 fL6ofII02pjI93hV03hSHYtDmDrRFSO01qmbq1u2dSuZBGwEXiyO235y6izRRJ7wRo
	 nYzBIvwfsfVp+3FFQfQBRoeBytuxxb5mvx4zoyhCB++KtwfmS2uRUajDQf1ovTttRx
	 dOr3oaz8fne+JjYjvY3ZnZqrWZ1B5oKKe/v7XI6tzj+IgZYc4MpiwyZcPOfnTwEHWJ
	 RWr0qLo9XSI3w==
Date: Tue, 16 Sep 2025 12:15:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Override the ASPM and Clock PM states set
 by BIOS for devicetree platforms
Message-ID: <20250916171546.GA1806498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com>

On Tue, Sep 16, 2025 at 09:42:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> So far, the PCI subsystem has honored the ASPM and Clock PM states set by
> the BIOS (through LNKCTL) during device initialization. This was done
> conservatively to avoid issues with the buggy devices that advertise
> ASPM capabilities, but behave erratically if the ASPM states are enabled.
> So the PCI subsystem ended up trusting the BIOS to enable only the ASPM
> states that were known to work for the devices.

Questions about what exactly "honoring ASPM states set by BIOS" means:

  - I *think* honoring ASPM states set by BIOS means that Linux
    doesn't change ASPM config at boot-time, and this only applies
    when:

    * CONFIG_PCIEASPM_DEFAULT=y, or
    * booting with "pcie_aspm=off", or
    * FADT has ACPI_FADT_NO_ASPM set, or
    * platform retained control of PCIe Capability via _OSC (I'm not
      sure we enforce this today, but I think we should)

  - IIUC we always save the pre-Linux config in link->aspm_default,
    but when CONFIG_PCIEASPM_POWERSAVE, CONFIG_PCIEASPM_POWER_SUPERSAVE,
    or CONFIG_PCIEASPM_PERFORMANCE are set, Linux immediately
    reconfigures ASPM.

  - But I *think* the config option is not restrictive, and users can
    do more aggressive ASPM configuration at run-time via sysfs, right?
    (Assuming the platform hasn't prevented Linux from doing so)

If users can configure ASPM differently than BIOS did, we're liable to
trip over issues later even though we claim to honor ASPM states set
by BIOS, so I think CONFIG_PCIEASPM_DEFAULT is kind of a fig leaf that
only defers issues.

I'd really like to get rid of all those CONFIG_PCIEASPM_* options
because I don't think they have any business being build-time things,
but I don't think that would have to be in this series.

> But this turned out to be a problem for devicetree platforms, especially
> the ARM based devicetree platforms powering Embedded and *some* Compute
> devices as they tend to run without any standard BIOS. So the ASPM states
> on these platforms were left disabled during boot and the PCI subsystem
> never bothered to enable them, unless the user has forcefully enabled the
> ASPM states through Kconfig, cmdline, and sysfs or the device drivers
> themselves, enabling the ASPM states through pci_enable_link_state() APIs.
> 
> This caused runtime power issues on those platforms. So a couple of
> approaches were tried to mitigate this BIOS dependency without user
> intervention by enabling the ASPM states in the PCI controller drivers
> after device enumeration, and overriding the ASPM/Clock PM states
> by the PCI controller drivers through an API before enumeration.
> 
> But it has been concluded that none of these mitigations should really be
> required and the PCI subsystem should enable the ASPM states advertised by
> the devices without relying on BIOS or the PCI controller drivers. If any
> device is found to be misbehaving after enabling ASPM states that they
> advertised, then those devices should be quirked to disable the problematic
> ASPM/Clock PM states.
> 
> In an effort to do so, start by overriding the ASPM and Clock PM states set
> by the BIOS for devicetree platforms first. Separate helper functions are
> introduced to set the default ASPM and Clock PM states and they will
> override the BIOS set states by enabling all of them if CONFIG_OF is
> enabled. To aid debugging, print the overridden ASPM and Clock PM states.
> 
> In the future, these helpers could be extended to allow other platforms
> like VMD, newer ACPI systems with a cutoff year etc... to follow the path.
> 
> Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pcie/aspm.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 919a05b9764791c3cc469c9ada62ba5b2c405118..1e7218c5e9127699fdbf172c277aad3f847c43be 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -235,13 +235,15 @@ struct pcie_link_state {
>  	u32 aspm_support:7;		/* Supported ASPM state */
>  	u32 aspm_enabled:7;		/* Enabled ASPM state */
>  	u32 aspm_capable:7;		/* Capable ASPM state with latency */
> -	u32 aspm_default:7;		/* Default ASPM state by BIOS */
> +	u32 aspm_default:7;		/* Default ASPM state by BIOS or
> +					   override */
>  	u32 aspm_disable:7;		/* Disabled ASPM state */
>  
>  	/* Clock PM state */
>  	u32 clkpm_capable:1;		/* Clock PM capable? */
>  	u32 clkpm_enabled:1;		/* Current Clock PM state */
> -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
> +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
> +					   override */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
>  };
>  
> @@ -373,6 +375,20 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  	pcie_set_clkpm_nocheck(link, enable);
>  }
>  
> +static void pcie_clkpm_set_default_link_state(struct pcie_link_state *link,
> +					      int enabled)
> +{
> +	struct pci_dev *pdev = link->downstream;
> +
> +	link->clkpm_default = enabled;
> +
> +	/* Override the BIOS disabled Clock PM state for devicetree platforms */
> +	if (IS_ENABLED(CONFIG_OF) && !enabled) {
> +		link->clkpm_default = 1;
> +		pci_info(pdev, "Clock PM state overridden\n");

It's obvious from the code that this message means we're going to
*enable* ClockPM, but I want to know from the message itself what the
resulting state is, not just that it was overridden.

Maybe "ClockPM+" or "ClockPM-" like lspci does?

Maybe we should have a pci_dbg() for the current state?

For debuggability, I wonder if we should have a pci_dbg() at the point
where we actually update PCI_EXP_LNKCTL, PCI_L1SS_CTL1, etc?  I could
even argue for pci_info() since this should be a low-frequency and
relatively high-risk event.

> +	}
> +}
> +
>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>  	int capable = 1, enabled = 1;
> @@ -394,7 +410,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  			enabled = 0;
>  	}
>  	link->clkpm_enabled = enabled;
> -	link->clkpm_default = enabled;

I think both the patch and the resulting code would be easier to read
if we preserved the link->clkpm_enabled here and simply added the call
to pcie_clkpm_set_default_link_state().

> +	pcie_clkpm_set_default_link_state(link, enabled);
>  	link->clkpm_capable = capable;
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
> @@ -788,6 +804,29 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
>  		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
>  }
>  
> +static void pcie_aspm_set_default_link_state(struct pcie_link_state *link)
> +{
> +	struct pci_dev *pdev = link->downstream;
> +	u32 override;
> +
> +	/* Set BIOS enabled states as the default */
> +	link->aspm_default = link->aspm_enabled;
> +
> +	/* Override the BIOS disabled ASPM states for devicetree platforms */
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> +		override = link->aspm_default & ~link->aspm_enabled;
> +		if (override)
> +			pci_info(pdev, "ASPM states overridden: %s%s%s%s%s%s\n",
> +				 (override & PCIE_LINK_STATE_L0S) ? "L0s, " : "",
> +				 (override & PCIE_LINK_STATE_L1) ? "L1, " : "",
> +				 (override & PCIE_LINK_STATE_L1_1) ? "L1.1, " : "",
> +				 (override & PCIE_LINK_STATE_L1_2) ? "L1.2, " : "",
> +				 (override & PCIE_LINK_STATE_L1_1_PCIPM) ? "L1.1 PCI-PM, " : "",
> +				 (override & PCIE_LINK_STATE_L1_2_PCIPM) ? "L1.2 PCI-PM" : "");

Same here.

> +	}
> +}
> +
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
> @@ -865,8 +904,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
>  	}
>  
> -	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;

Same here.

> +	pcie_aspm_set_default_link_state(link);
>  
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
> 
> -- 
> 2.45.2
> 
> 

