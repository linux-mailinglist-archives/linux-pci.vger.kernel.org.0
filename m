Return-Path: <linux-pci+bounces-2818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4696842AE3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDEE1F26029
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558421292DC;
	Tue, 30 Jan 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvoKLUts"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278901292D0;
	Tue, 30 Jan 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635684; cv=none; b=i7EC29L3CdsisaWliKNA37ZGxkpzo0YPoWit/u7eE91Khq80PYjwrQhXTE6yK9g6dv0xFp/7JDJoJlKx59Wpwn25X01FNgTHOUQbQ16PTsLYF6heto28HiUvHeOWJqzfSuBkukUm1nIzhoFPwRTys7JE+5IuHWQeBJF16+WrhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635684; c=relaxed/simple;
	bh=28S1L4bBFK8hBbbAvq3VNr8X9WWe5HGCxwCf29i8V1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Nyop9XKyGxI83TEBX/awvhPxoLUUsw4tXDezLRVvJUKQzFJoaw2eiP/DSosqIBP+J1NbTE5dAj2YXaLyEL0E9ic6mampMD7rHc1/pkFNYukvQ4QlJj7MR4o5dPBG3bL3QfCUSAkp6bOuakJn9jU8h1X8XoFza9q+BhEKDZf3jvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvoKLUts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B2EC433C7;
	Tue, 30 Jan 2024 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635683;
	bh=28S1L4bBFK8hBbbAvq3VNr8X9WWe5HGCxwCf29i8V1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KvoKLUtsIhLo2iMrs/tk4Fs3ck6VQ5kxNc+ZJ1x4OAoe+Xu+1Xp9EI6O7jz6m4POn
	 0EpF+zc2ffFd6iFqslbBTpCRtfKvng58DEEix/QDAPO7LFy1u5jiDnHS85U5E6PrMg
	 54HPIQfzeLPLPzfxwnCtR+V13T600V2YKsnk22rqiGbEJ6JhJ0qalSUUOgjl5rQ9oU
	 +1DF1ZJI0x3l+BpE/9x431FqlOaxvqt91LahCdbmAARYTkK5IhNrrkIixVYvThYnWk
	 dro5+5Ob8zwzJM1sqhSSUrAdUT++UeofSTsHiAxj+Xum7b0zcbjk+tyTXIUrVehb+a
	 LGZNtqVALhhOw==
Date: Tue, 30 Jan 2024 11:28:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: enable PCI PM's L1 substates of remapped
 PCIe port and NVMe
Message-ID: <20240130172801.GA525128@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130163519.GA521777@bhelgaas>

[+cc Johan since qcom has similar code]

On Tue, Jan 30, 2024 at 10:35:19AM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 30, 2024 at 06:00:51PM +0800, Jian-Hong Pan wrote:
> > The remmapped PCIe port and NVMe have PCI PM L1 substates capability on
> > ASUS B1400CEAE, but they are disabled originally:
> >
> > Capabilities: [900 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
> >                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                    T_CommonMode=0us LTR1.2_Threshold=0ns
> >         L1SubCtl2: T_PwrOn=10us
> > 
> > Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
> > Substates by following "Section 5.5.4 of PCIe Base Spec Revision 5.0
> > Version 0.1". Then, PCI PM's L1 substates control are enabled
> > accordingly.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> >  drivers/pci/controller/vmd.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 87b7856f375a..b1bbe8e6075a 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -738,6 +738,12 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> >  	vmd_bridge->native_dpc = root_bridge->native_dpc;
> >  }
> >  
> > +static int vmd_power_on_pci_device(struct pci_dev *pdev, void *userdata)
> > +{
> > +	pci_set_power_state(pdev, PCI_D0);
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> >   */
> > @@ -928,6 +934,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  	vmd_acpi_begin();
> >  
> >  	pci_scan_child_bus(vmd->bus);
> > +
> > +	/*
> > +	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
> > +	 * Section 5.5.4 of PCIe Base Spec Revision 5.0 Version 0.1
> > +	 */
> > +	pci_walk_bus(vmd->bus, vmd_power_on_pci_device, NULL);
> 
> Sec 5.5.4 indeed says "If setting either or both of the enable bits
> for PCI-PM L1 PM Substates, both ports must be configured ... while in
> D0."
> 
> This applies to *all* PCIe devices, not just those below a VMD bridge,
> so I'm not sure this is the right place to do this.  Is there anything
> that prevents a similar issue for non-VMD hierarchies?
> 
> I guess the bridges (Root Ports and Switch Ports) must already be in
> D0, or we wouldn't be able to enumerate anything below them, right?
> 
> It would be nice to connect this more closely with the L1 PM Substates
> configuration.  I don't quite see the connection here.  The only path
> I see for L1SS configuration is this:
> 
>   pci_scan_slot
>     pcie_aspm_init_link_state
>       pcie_aspm_cap_init
> 	aspm_l1ss_init
> 
> which of course is inside pci_scan_child_bus(), which happens *before*
> this patch puts the devices in D0.  Where does the L1SS configuration
> happen after this vmd_power_on_pci_device()?

I think I found it; a more complete call tree is like this, where the
L1SS configuration is inside the pci_enable_link_state_locked() done
by the vmd_pm_enable_quirk() bus walk:

  vmd_enable_domain
    pci_scan_child_bus
      ...
        pci_scan_slot
          pcie_aspm_init_link_state
            pcie_aspm_cap_init
              aspm_l1ss_init
+   pci_walk_bus(vmd->bus, vmd_power_on_pci_device, NULL)
    ...
    pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features)
      vmd_pm_enable_quirk
        pci_enable_link_state_locked(PCIE_LINK_STATE_ALL)
          __pci_enable_link_state
            link->aspm_default |= ...
            pcie_config_aspm_link
              pcie_config_aspm_l1ss
                pci_clear_and_set_config_dword(PCI_L1SS_CTL1)  # <--
              pcie_config_aspm_dev
                pcie_capability_clear_and_set_word(PCI_EXP_LNKCTL)

qcom_pcie_enable_aspm() does a similar pci_set_power_state(PCI_D0)
before calling pci_enable_link_state_locked().  I would prefer to
avoid the D0 precondition, but at the very least, I think we should
add a note to the pci_enable_link_state_locked() kernel-doc saying the
caller must ensure the device is in D0.

I think vmd_pm_enable_quirk() is also problematic because it
configures the LTR Capability *after* calling
pci_enable_link_state_locked(PCIE_LINK_STATE_ALL).

The pci_enable_link_state_locked() will enable ASPM L1.2, but sec
5.5.4 says LTR_L1.2_THRESHOLD must be programmed *before* ASPM L1.2
Enable is set.

Bjorn

