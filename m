Return-Path: <linux-pci+bounces-40604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD90C41C8E
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 22:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4D024E2E18
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 21:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7930F7FE;
	Fri,  7 Nov 2025 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUJjnVDj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18FF221299;
	Fri,  7 Nov 2025 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552508; cv=none; b=KskY79MPEr76+BDnBzRzFL9DDe/HDImO0g98p2kALxCFeON0rLyx96/aSs/MfT8b0fce/WnhqS4l6wSqbsZjbSmxhJSQKbvYh/19B0zPnUxwyA3z0IJIIbzJX70drhppbGG6kMN0xDPNuL86hwIEy4M1riDlxgyEd8w8ylibuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552508; c=relaxed/simple;
	bh=bzXzOIrmU2vJW/viY2NN2SWyXWmWO2JsboNDeNZlPRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YFlbBjkS+0543q2AlWY8m8/D5hnQqggKbR6ZIuk3oOs07gZOgga4Kqh8khhod/654l+8ANLTc3joBXTq69roslp9i855tyu8iW74oya7VwoL1arXHM9B6JEWmAm+LigFpF1lMX+aODLHpOHbCKvjvQ55g4rtFnGb9CWHV3dmqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUJjnVDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58099C19421;
	Fri,  7 Nov 2025 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762552507;
	bh=bzXzOIrmU2vJW/viY2NN2SWyXWmWO2JsboNDeNZlPRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aUJjnVDjDdkeP2qaJRg2Kuo0S2Z73RKmtJH2ubSo5KjynyjWcGldUVnPG8hijsbnr
	 K69F0NuEHhSMsi+vDqF0KRrOdEymZWDhqwfTttcoZDT9rWqJYdL7a166x6hN1HjSjk
	 Qn7zjttAwzDJUZAW7GZLlCuubm/USgiN0Vbgc0aql4mFj92gJhUfEdQaTAPLTpA492
	 NwgmE0HNKlOgXIzp/3hbjLDQjFODEZ8R1TzyMgbpuq/cBQxRjCUSCR8oefoPcvBlxw
	 PlYPJeC8LXFF1WDinXBdexU5vy1O1ZxyM2UphM1S99298KVjXhpdKkAKZsWTK0s7b5
	 UTsJzxoZEHMIA==
Date: Fri, 7 Nov 2025 15:55:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
Message-ID: <20251107215506.GA1998504@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ogkty663ld7fe3qmbxyil47pudidenqeikol5prk7n3qexpteq@h77qi3sg5xo4>

On Fri, Nov 07, 2025 at 11:39:50AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 06, 2025 at 12:36:39PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Christian reported that f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and
> > ASPM states for devicetree platforms") broke booting on the A-EON X5000.
> > 
> > Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> > Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms"
> > )
> > Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> > Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/quirks.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..44e780718953 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >   */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> >  
> > +/*
> > + * Remove ASPM L0s and L1 support from cached copy of Link Capabilities so
> > + * aspm.c won't try to enable them.
> > + */
> > +static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
> > +{
> > +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> > +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L1;
> > +	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
> 
> From the commit message of the earlier version [1] you shared:
> 
>     Removing advertised features prevents aspm.c from enabling them, even if
>     users try to enable them via sysfs or by building the kernel with
>     CONFIG_PCIEASPM_POWERSAVE or CONFIG_PCIEASPM_POWER_SUPERSAVE.
> 
> Going by this reasoning, shouldn't we be doing this for the other
> quirks (quirk_disable_aspm_l0s_l1/quirk_disable_aspm_l0s) as well?

Yes, probably so.  I was thinking that could be done later to limit
the scope of v6.18 changes, but since we're enabling L0s/L1 when we
didn't before, we should probably update those quirks too.

I was hesitant because quirk_disable_aspm_l0s_l1_cap() isn't quite the
same as quirk_disable_aspm_l0s_l1() because pci_disable_link_state()
turns off states that are currently enabled and also prevents them
from being enabled in the future, but quirk_disable_aspm_l0s_l1_cap()
essentially just clears Link Capability bits.

But if we clear a Link Capability bit for a state that was already
enabled by firmware:

  - If POLICY_DEFAULT or POLICY_PERFORMANCE, I think we'll disable the
    state during enumeration:

      pci_scan_slot
	pcie_aspm_init_link_state
	  pcie_aspm_init_link_state
	    if (POLICY_DEFAULT || POLICY_PERFORMANCE)
	      pcie_config_aspm_path

  - If POLICY_POWERSAVE or POLICY_POWER_SUPERSAVE, I think we'll
    disable it in pci_enable_device():

      pci_enable_device
	do_pci_enable_device
	  pcie_aspm_powersave_config_link
	    if (POLICY_POWERSAVE || POLICY_POWER_SUPERSAVE)
	      pcie_config_aspm_path

If firmware enabled the state, it must at least be safe enough to
boot, and we should eventually disable it regardless of how the kernel
was built.

Bjorn

