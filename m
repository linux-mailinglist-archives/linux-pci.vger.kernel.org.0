Return-Path: <linux-pci+bounces-38124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6380BDCB8B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6273C8140
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 06:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D032A3019DF;
	Wed, 15 Oct 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiV1ScAz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20929D26E;
	Wed, 15 Oct 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509615; cv=none; b=TrCSKh3dMIvKe1YfD+pjfFw4Hj4PmR0HJMea0xx5qrA+dTa0ZSvgrXsc9Srxxhwu45xSwlhDbLRGVDWiO+DpqjAl9GZIwrUfrfdyfuKX9oCtoY2kl1Vr0jnkJfqeHCsHlF5hxI0LA/XNREzLJwNJAibZxAaWQIgWqeZaPsqVyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509615; c=relaxed/simple;
	bh=s2vnLEYNDminF6KyqSzh6+puX5u2MxsQYOfXIiPlDfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/FQ+XQa09WJqwFg24OharIyiC3HoXgadI5JgDI8ZB1HexaEGGE+lbje6XBCmhjq7z1j3deLOoLPZdeHBc0eSc62bHsZYdXNt/TN1h4trEUHgcOoDqiGsPHEEMCx/+CLJpx3H5e4mi0B6Zw0W6qzahBueueDSJLx96Z7Ubv2wmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiV1ScAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC493C4CEFE;
	Wed, 15 Oct 2025 06:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760509615;
	bh=s2vnLEYNDminF6KyqSzh6+puX5u2MxsQYOfXIiPlDfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiV1ScAzoGql9ZctxnOq2HXn0mF8tHyPm9iB7gU8/3znblU9EGeBMvE1zDGZ06aV+
	 Pub/mN6NfZjBfy7pcCHUtVTNkD6yAYTk1BJD4JP1Vljpd+SmbS2HxnnskGCMFOwm9q
	 CQots2D92zfZeHU7W2RHSjLu8l0XFJ+fNHacDgyRRoFnwQhRV4K3kTk4ocs4MIm8iM
	 /EPEiGfycKXLeVGxTQVjW4dMqRJU1ycwx0iTybmSE0V0SER2OaJtUBYrgLIRcmYtq6
	 BgmKoiWlaAuvYshzetXscYv9/0OLdtnW7p/V7JgNq+upnbdnBN10hUTP89/dcSmPrR
	 me2LFNle22Gpg==
Date: Wed, 15 Oct 2025 11:56:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014184905.GA896847@bhelgaas>

On Tue, Oct 14, 2025 at 01:49:05PM -0500, Bjorn Helgaas wrote:
> [+cc regressions]
> 
> On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
> > Hi Manivannan Sadhasivam,
> > 
> > I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on the
> > Rockchip RK3588(S) SoC.
> > 
> > When running Linux v6.18-rc1 or linux-next since 20250924, the kernel either
> > freezes or fails to probe M.2 Wi-Fi modules. This happens with several
> > different modules I've tested, including the Realtek RTL8852BE, MediaTek
> > MT7921E, and Intel AX210.
> > 
> > I've found that reverting the following commit (i.e., the patch I'm replying
> > to) resolves the problem:
> > commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
> 
> Thanks for the report, and sorry for the regression.
> 
> Since this affects several devices from different manufacturers and (I
> assume) different drivers, it seems likely that there's some issue
> with the Rockchip end, since ASPM probably works on these devices in
> other systems.  So we should figure out if there's something wrong
> with the way we configure ASPM, which we could potentially fix, or if
> there's a hardware issue and we need some king of quirk to prevent
> usage of ASPM on the affected platforms.
> 

I believe it is the latter. The Root Port is having trouble with ASPM.

FUKAUMI Naoki, could you please share the 'sudo lspci -vv' output so that we
know what kind of Root Port we are dealing with? You can revert the offending
patch and share the output.

Then I could supply a patch that you can test out.

- Mani

> Can you collect a complete dmesg log when booting with
> 
>   ignore_loglevel pci=earlydump dyndbg="file drivers/pci/* +p"
> 
> and the output of "sudo lspci -vv"?
> 
> When the kernel freezes, can you give us any information about where,
> e.g., a log or screenshot?
> 
> Do you know if any platforms other than Radxa ROCK 5A/5B have this
> problem?
> 
> #regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> #regzbot dup-of: https://github.com/chzigotzky/kernels/issues/17
> 
> > On 9/23/25 01:16, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > So far, the PCI subsystem has honored the ASPM and Clock PM states set by
> > > the BIOS (through LNKCTL) during device initialization, if it relies on the
> > > default state selected using:
> > > 
> > > * Kconfig: CONFIG_PCIEASPM_DEFAULT=y, or
> > > * cmdline: "pcie_aspm=off", or
> > > * FADT: ACPI_FADT_NO_ASPM
> > > 
> > > This was done conservatively to avoid issues with the buggy devices that
> > > advertise ASPM capabilities, but behave erratically if the ASPM states are
> > > enabled. So the PCI subsystem ended up trusting the BIOS to enable only the
> > > ASPM states that were known to work for the devices.
> > > 
> > > But this turned out to be a problem for devicetree platforms, especially
> > > the ARM based devicetree platforms powering Embedded and *some* Compute
> > > devices as they tend to run without any standard BIOS. So the ASPM states
> > > on these platforms were left disabled during boot and the PCI subsystem
> > > never bothered to enable them, unless the user has forcefully enabled the
> > > ASPM states through Kconfig, cmdline, and sysfs or the device drivers
> > > themselves, enabling the ASPM states through pci_enable_link_state() APIs.
> > > 
> > > This caused runtime power issues on those platforms. So a couple of
> > > approaches were tried to mitigate this BIOS dependency without user
> > > intervention by enabling the ASPM states in the PCI controller drivers
> > > after device enumeration, and overriding the ASPM/Clock PM states
> > > by the PCI controller drivers through an API before enumeration.
> > > 
> > > But it has been concluded that none of these mitigations should really be
> > > required and the PCI subsystem should enable the ASPM states advertised by
> > > the devices without relying on BIOS or the PCI controller drivers. If any
> > > device is found to be misbehaving after enabling ASPM states that they
> > > advertised, then those devices should be quirked to disable the problematic
> > > ASPM/Clock PM states.
> > > 
> > > In an effort to do so, start by overriding the ASPM and Clock PM states set
> > > by the BIOS for devicetree platforms first. Separate helper functions are
> > > introduced to override the BIOS set states by enabling all of them if
> > > of_have_populated_dt() returns true. To aid debugging, print the overridden
> > > ASPM and Clock PM states as well.
> > > 
> > > In the future, these helpers could be extended to allow other platforms
> > > like VMD, newer ACPI systems with a cutoff year etc... to follow the path.
> > > 
> > > Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
> > > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > Link: https://patch.msgid.link/20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com
> > > ---
> > >   drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 40 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 919a05b9764791c3cc469c9ada62ba5b2c405118..cda31150aec1b67b6a48b60569222ea3d1c3d41f 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -15,6 +15,7 @@
> > >   #include <linux/math.h>
> > >   #include <linux/module.h>
> > >   #include <linux/moduleparam.h>
> > > +#include <linux/of.h>
> > >   #include <linux/pci.h>
> > >   #include <linux/pci_regs.h>
> > >   #include <linux/errno.h>
> > > @@ -235,13 +236,15 @@ struct pcie_link_state {
> > >   	u32 aspm_support:7;		/* Supported ASPM state */
> > >   	u32 aspm_enabled:7;		/* Enabled ASPM state */
> > >   	u32 aspm_capable:7;		/* Capable ASPM state with latency */
> > > -	u32 aspm_default:7;		/* Default ASPM state by BIOS */
> > > +	u32 aspm_default:7;		/* Default ASPM state by BIOS or
> > > +					   override */
> > >   	u32 aspm_disable:7;		/* Disabled ASPM state */
> > >   	/* Clock PM state */
> > >   	u32 clkpm_capable:1;		/* Clock PM capable? */
> > >   	u32 clkpm_enabled:1;		/* Current Clock PM state */
> > > -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
> > > +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
> > > +					   override */
> > >   	u32 clkpm_disable:1;		/* Clock PM disabled */
> > >   };
> > > @@ -373,6 +376,18 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> > >   	pcie_set_clkpm_nocheck(link, enable);
> > >   }
> > > +static void pcie_clkpm_override_default_link_state(struct pcie_link_state *link,
> > > +						   int enabled)
> > > +{
> > > +	struct pci_dev *pdev = link->downstream;
> > > +
> > > +	/* Override the BIOS disabled Clock PM state for devicetree platforms */
> > > +	if (of_have_populated_dt() && !enabled) {
> > > +		link->clkpm_default = 1;
> > > +		pci_info(pdev, "Clock PM state overridden: ClockPM+\n");
> > > +	}
> > > +}
> > > +
> > >   static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> > >   {
> > >   	int capable = 1, enabled = 1;
> > > @@ -395,6 +410,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> > >   	}
> > >   	link->clkpm_enabled = enabled;
> > >   	link->clkpm_default = enabled;
> > > +	pcie_clkpm_override_default_link_state(link, enabled);
> > >   	link->clkpm_capable = capable;
> > >   	link->clkpm_disable = blacklist ? 1 : 0;
> > >   }
> > > @@ -788,6 +804,26 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
> > >   		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
> > >   }
> > > +static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
> > > +{
> > > +	struct pci_dev *pdev = link->downstream;
> > > +	u32 override;
> > > +
> > > +	/* Override the BIOS disabled ASPM states for devicetree platforms */
> > > +	if (of_have_populated_dt()) {
> > > +		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> > > +		override = link->aspm_default & ~link->aspm_enabled;
> > > +		if (override)
> > > +			pci_info(pdev, "ASPM states overridden: %s%s%s%s%s%s\n",
> > > +				 (override & PCIE_LINK_STATE_L0S) ? "L0s+, " : "",
> > > +				 (override & PCIE_LINK_STATE_L1) ? "L1+, " : "",
> > > +				 (override & PCIE_LINK_STATE_L1_1) ? "L1.1+, " : "",
> > > +				 (override & PCIE_LINK_STATE_L1_2) ? "L1.2+, " : "",
> > > +				 (override & PCIE_LINK_STATE_L1_1_PCIPM) ? "L1.1 PCI-PM+, " : "",
> > > +				 (override & PCIE_LINK_STATE_L1_2_PCIPM) ? "L1.2 PCI-PM+" : "");
> > > +	}
> > > +}
> > > +
> > >   static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> > >   {
> > >   	struct pci_dev *child = link->downstream, *parent = link->pdev;
> > > @@ -868,6 +904,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> > >   	/* Save default state */
> > >   	link->aspm_default = link->aspm_enabled;
> > > +	pcie_aspm_override_default_link_state(link);
> > > +
> > >   	/* Setup initial capable state. Will be updated later */
> > >   	link->aspm_capable = link->aspm_support;
> > > 
> > 
> > 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip

-- 
மணிவண்ணன் சதாசிவம்

