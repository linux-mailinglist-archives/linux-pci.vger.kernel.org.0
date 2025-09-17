Return-Path: <linux-pci+bounces-36342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04840B7C6EB
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72A516C6C0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C24309F12;
	Wed, 17 Sep 2025 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgcKSRLa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC12641CA;
	Wed, 17 Sep 2025 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105891; cv=none; b=SpfAU8AZEHrKzAtj4/vHUxEtnZaNaXPZNPEYfJIjuUuUdmoT9/RyUf9SuWUzFuN0RiDYqiZa3Kad+kWnTzLOBcp77tpFKnesmWeBLsMTkIuCKBH7OD98s2cvogpzlrU4a/NtMiH1UskRLSQ7k4AgByGv76eY6bWD/Uyn1gEFeyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105891; c=relaxed/simple;
	bh=C4TnItmUWUIRUSK3TbcDmRi0bbtRQFSg0p42mp/7DWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX6jrbYlctv7OOJJ5tAPr1674SHiKz1C6azNqKaiQxADVBkg2Tn3kg3erCwOYAaeB1uLpdT9ldZRa+K7FsyJxA8Whq9WnjtAgaWN/OK4VeKxm1yC1Nf7npZKvuWPxVIw6op4HiKkyuSlCjglLlyu7mj0R4jElWszWcIuaSbDHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgcKSRLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDA9C4CEF0;
	Wed, 17 Sep 2025 10:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758105891;
	bh=C4TnItmUWUIRUSK3TbcDmRi0bbtRQFSg0p42mp/7DWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgcKSRLazVyMkDCnD6P3JB0NjdcDHEJq/eQ3OSd2vMP1cFo0XMNc3DijYrvI4vUil
	 zE4XLv+dvBR2LadwZ++uZ9ZbGL6rhfyd12poCU56T6DtP6j495aVgtlqCvz/ITgEDb
	 o2kTg6Eoa4YQWpAa5g5HKz4Ey9v5Yy5QB96n9/MuOX3RZxsU5KHFBCWbMB7lgUOyqn
	 cD4SLpz926wI//7h5IHHqxYUQWaU8H7abWiHuRac0lZhwzkhEMiw3WDhNJFdkSy1XT
	 ZYYam+SvE1KF286hjFHlCiEnRSkT9vFWx7KgM8UnGAR3OszVd5X0zz8IKYmdQ7G65r
	 9LlguJhoD0ptw==
Date: Wed, 17 Sep 2025 16:14:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Override the ASPM and Clock PM states set
 by BIOS for devicetree platforms
Message-ID: <frmzvhnhljy23xds7lnmo23zg35wxpzu4pvabnc6v6vz7qn2lj@gk25cglbpn3q>
References: <20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com>
 <20250916171546.GA1806498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916171546.GA1806498@bhelgaas>

On Tue, Sep 16, 2025 at 12:15:46PM GMT, Bjorn Helgaas wrote:
> On Tue, Sep 16, 2025 at 09:42:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > So far, the PCI subsystem has honored the ASPM and Clock PM states set by
> > the BIOS (through LNKCTL) during device initialization. This was done
> > conservatively to avoid issues with the buggy devices that advertise
> > ASPM capabilities, but behave erratically if the ASPM states are enabled.
> > So the PCI subsystem ended up trusting the BIOS to enable only the ASPM
> > states that were known to work for the devices.
> 
> Questions about what exactly "honoring ASPM states set by BIOS" means:
> 
>   - I *think* honoring ASPM states set by BIOS means that Linux
>     doesn't change ASPM config at boot-time, and this only applies
>     when:
> 
>     * CONFIG_PCIEASPM_DEFAULT=y, or
>     * booting with "pcie_aspm=off", or
>     * FADT has ACPI_FADT_NO_ASPM set, or
>     * platform retained control of PCIe Capability via _OSC (I'm not
>       sure we enforce this today, but I think we should)
> 
>   - IIUC we always save the pre-Linux config in link->aspm_default,
>     but when CONFIG_PCIEASPM_POWERSAVE, CONFIG_PCIEASPM_POWER_SUPERSAVE,
>     or CONFIG_PCIEASPM_PERFORMANCE are set, Linux immediately
>     reconfigures ASPM.
> 
>   - But I *think* the config option is not restrictive, and users can
>     do more aggressive ASPM configuration at run-time via sysfs, right?
>     (Assuming the platform hasn't prevented Linux from doing so)
> 
> If users can configure ASPM differently than BIOS did, we're liable to
> trip over issues later even though we claim to honor ASPM states set
> by BIOS, so I think CONFIG_PCIEASPM_DEFAULT is kind of a fig leaf that
> only defers issues.
> 

True. Similar to how we allow users to fiddle with the PCI config space through
sysfs even when a driver is bound to the device.

> I'd really like to get rid of all those CONFIG_PCIEASPM_* options
> because I don't think they have any business being build-time things,
> but I don't think that would have to be in this series.
> 
> > But this turned out to be a problem for devicetree platforms, especially
> > the ARM based devicetree platforms powering Embedded and *some* Compute
> > devices as they tend to run without any standard BIOS. So the ASPM states
> > on these platforms were left disabled during boot and the PCI subsystem
> > never bothered to enable them, unless the user has forcefully enabled the
> > ASPM states through Kconfig, cmdline, and sysfs or the device drivers
> > themselves, enabling the ASPM states through pci_enable_link_state() APIs.
> > 
> > This caused runtime power issues on those platforms. So a couple of
> > approaches were tried to mitigate this BIOS dependency without user
> > intervention by enabling the ASPM states in the PCI controller drivers
> > after device enumeration, and overriding the ASPM/Clock PM states
> > by the PCI controller drivers through an API before enumeration.
> > 
> > But it has been concluded that none of these mitigations should really be
> > required and the PCI subsystem should enable the ASPM states advertised by
> > the devices without relying on BIOS or the PCI controller drivers. If any
> > device is found to be misbehaving after enabling ASPM states that they
> > advertised, then those devices should be quirked to disable the problematic
> > ASPM/Clock PM states.
> > 
> > In an effort to do so, start by overriding the ASPM and Clock PM states set
> > by the BIOS for devicetree platforms first. Separate helper functions are
> > introduced to set the default ASPM and Clock PM states and they will
> > override the BIOS set states by enabling all of them if CONFIG_OF is
> > enabled. To aid debugging, print the overridden ASPM and Clock PM states.
> > 
> > In the future, these helpers could be extended to allow other platforms
> > like VMD, newer ACPI systems with a cutoff year etc... to follow the path.
> > 
> > Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 43 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 919a05b9764791c3cc469c9ada62ba5b2c405118..1e7218c5e9127699fdbf172c277aad3f847c43be 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -235,13 +235,15 @@ struct pcie_link_state {
> >  	u32 aspm_support:7;		/* Supported ASPM state */
> >  	u32 aspm_enabled:7;		/* Enabled ASPM state */
> >  	u32 aspm_capable:7;		/* Capable ASPM state with latency */
> > -	u32 aspm_default:7;		/* Default ASPM state by BIOS */
> > +	u32 aspm_default:7;		/* Default ASPM state by BIOS or
> > +					   override */
> >  	u32 aspm_disable:7;		/* Disabled ASPM state */
> >  
> >  	/* Clock PM state */
> >  	u32 clkpm_capable:1;		/* Clock PM capable? */
> >  	u32 clkpm_enabled:1;		/* Current Clock PM state */
> > -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
> > +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
> > +					   override */
> >  	u32 clkpm_disable:1;		/* Clock PM disabled */
> >  };
> >  
> > @@ -373,6 +375,20 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> >  	pcie_set_clkpm_nocheck(link, enable);
> >  }
> >  
> > +static void pcie_clkpm_set_default_link_state(struct pcie_link_state *link,
> > +					      int enabled)
> > +{
> > +	struct pci_dev *pdev = link->downstream;
> > +
> > +	link->clkpm_default = enabled;
> > +
> > +	/* Override the BIOS disabled Clock PM state for devicetree platforms */
> > +	if (IS_ENABLED(CONFIG_OF) && !enabled) {
> > +		link->clkpm_default = 1;
> > +		pci_info(pdev, "Clock PM state overridden\n");
> 
> It's obvious from the code that this message means we're going to
> *enable* ClockPM, but I want to know from the message itself what the
> resulting state is, not just that it was overridden.
> 
> Maybe "ClockPM+" or "ClockPM-" like lspci does?
> 

We are not disabling ClockPM here, but just enabling it. So adding 'ClockPM+'
would make sense.

> Maybe we should have a pci_dbg() for the current state?
> 

Since we are always enabling ClockPM if it was disabled, printing the current
state is redundant.

> For debuggability, I wonder if we should have a pci_dbg() at the point
> where we actually update PCI_EXP_LNKCTL, PCI_L1SS_CTL1, etc?  I could
> even argue for pci_info() since this should be a low-frequency and
> relatively high-risk event.
> 

I don't know why we should print register settings since we are explicitly
printing out what states are getting enabled.

> > +	}
> > +}
> > +
> >  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >  {
> >  	int capable = 1, enabled = 1;
> > @@ -394,7 +410,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >  			enabled = 0;
> >  	}
> >  	link->clkpm_enabled = enabled;
> > -	link->clkpm_default = enabled;
> 
> I think both the patch and the resulting code would be easier to read
> if we preserved the link->clkpm_enabled here and simply added the call
> to pcie_clkpm_set_default_link_state().
> 

Ok, in that case the helper should be renamed to
pcie_{clkpm/aspm}_override_default_link_state().

> > +	pcie_clkpm_set_default_link_state(link, enabled);
> >  	link->clkpm_capable = capable;
> >  	link->clkpm_disable = blacklist ? 1 : 0;
> >  }
> > @@ -788,6 +804,29 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
> >  		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
> >  }
> >  
> > +static void pcie_aspm_set_default_link_state(struct pcie_link_state *link)
> > +{
> > +	struct pci_dev *pdev = link->downstream;
> > +	u32 override;
> > +
> > +	/* Set BIOS enabled states as the default */
> > +	link->aspm_default = link->aspm_enabled;
> > +
> > +	/* Override the BIOS disabled ASPM states for devicetree platforms */
> > +	if (IS_ENABLED(CONFIG_OF)) {
> > +		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> > +		override = link->aspm_default & ~link->aspm_enabled;
> > +		if (override)
> > +			pci_info(pdev, "ASPM states overridden: %s%s%s%s%s%s\n",
> > +				 (override & PCIE_LINK_STATE_L0S) ? "L0s, " : "",
> > +				 (override & PCIE_LINK_STATE_L1) ? "L1, " : "",
> > +				 (override & PCIE_LINK_STATE_L1_1) ? "L1.1, " : "",
> > +				 (override & PCIE_LINK_STATE_L1_2) ? "L1.2, " : "",
> > +				 (override & PCIE_LINK_STATE_L1_1_PCIPM) ? "L1.1 PCI-PM, " : "",
> > +				 (override & PCIE_LINK_STATE_L1_2_PCIPM) ? "L1.2 PCI-PM" : "");
> 
> Same here.
> 

I will add '+' to make it clear that these states are getting enabled.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

