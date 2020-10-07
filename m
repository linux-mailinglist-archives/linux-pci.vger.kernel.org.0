Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B1F28657C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJGRK1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 13:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgJGRK1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 13:10:27 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CADE321707;
        Wed,  7 Oct 2020 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602090626;
        bh=dws2CpzEWU0JT8f0BWVwWDLwOmd1rKbKq0cKE+yRI+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PxaVnUlf9ix7pnsdYskq35CddMgFV5OeK/e12Xlifv00IgAI81Hxzg65V/nJ7tLpa
         k9Muw+CcNoe/uiGpRR99VVFpSpXpRNVYQBLNRQN4Cy8386l81mD7MAsKx2PrXRCYtd
         n68DUWpTZ/fnEm5oHdgY12bgKFlapV047nnW892I=
Date:   Wed, 7 Oct 2020 12:10:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable PTM during suspend on Intel PCI bridges
Message-ID: <20201007171024.GA3252529@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gRph3UMffWqUVqTnDE149Ai-SbzmhjzZU1x=QOzAZeZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 06:53:16PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 7, 2020 at 6:49 PM David E. Box <david.e.box@linux.intel.com> wrote:
> >
> > On Intel Platform Controller Hubs (PCH) since Cannon Lake, the Precision
> > Time Measurement (PTM) capability can prevent PCIe root ports from power
> > gating during suspend-to-idle, causing increased power consumption on
> > systems that suspend using Low Power S0 Idle [1]. The issue is yet to be
> > root caused but believed to be coming from a race condition in the suspend
> > flow as the incidence rate varies for different platforms on Linux but the
> > issue does not occur at all in other operating systems. For now, disable
> > the feature on suspend on all Intel root ports and enable again on resume.
> 
> IMV it should also be noted that there is no particular reason why PTM
> would need to be enabled while the whole system is suspended.  At
> least it doesn't seem to be particularly useful in that state.

Is this a hardware erratum?  If not, and this is working as designed,
it sounds like we'd need to apply this quirk to every device that
supports PTM.  That's not really practical.

The bugzilla says "there is no erratum as this does not affect
Windows," but that doesn't answer the question.  What I want to know
is whether this is a *hardware* defect and whether it will be fixed in
future hardware.

If it's a "wont-fix" hardware issue, we can just disable PTM
completely on Intel hardware and we won't have to worry about it
during suspend.

> > Link: https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
> > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=209361
> > Tested-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/pci/quirks.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index bdf9b52567e0..e82b1f60c7a1 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5632,3 +5632,60 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
> >  }
> >  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> >                                PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> > +
> > +#ifdef CONFIG_PCIE_PTM
> > +/*
> > + * On Intel Platform Controller Hubs (PCH) since Cannon Lake, the Precision
> > + * Time Measurement (PTM) capability can prevent the PCIe root port from
> > + * power gating during suspend-to-idle, causing increased power consumption.
> > + * So disable the feature on suspend on all Intel root ports and enable
> > + * again on resume.
> > + */
> > +static void quirk_intel_ptm_disable_suspend(struct pci_dev *dev)
> > +{
> > +       int pos;
> > +       u32 ctrl;
> > +
> > +       if (!(dev->ptm_enabled && dev->ptm_root))
> > +               return;
> > +
> > +       pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> > +       if (!pos)
> > +               return;
> > +
> > +       pci_dbg(dev, "quirk: disabling PTM\n");
> > +
> > +       dev->ptm_enabled = 0;
> > +       dev->ptm_root = 0;
> > +
> > +       pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
> > +       ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> > +       pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
> > +}
> > +
> > +static void quirk_intel_ptm_enable_resume(struct pci_dev *dev)
> > +{
> > +       int pos;
> > +       u32 ctrl;
> > +
> > +       pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> > +       if (!pos)
> > +               return;
> > +
> > +       pci_dbg(dev, "quirk: re-enabling PTM\n");
> > +
> > +       pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
> > +       ctrl |= PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;
> > +       pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
> > +
> > +       dev->ptm_enabled = 1;
> > +       dev->ptm_root = 1;
> > +}
> > +
> > +DECLARE_PCI_FIXUP_CLASS_SUSPEND(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > +                               PCI_CLASS_BRIDGE_PCI, 8,
> > +                               quirk_intel_ptm_disable_suspend)
> > +DECLARE_PCI_FIXUP_CLASS_RESUME(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > +                              PCI_CLASS_BRIDGE_PCI, 8,
> > +                              quirk_intel_ptm_enable_resume)
> > +#endif
> > --
> > 2.20.1
> >
