Return-Path: <linux-pci+bounces-18406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BCC9F14EC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C6F285166
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1481E048B;
	Fri, 13 Dec 2024 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBCPTSI6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55100157E9F;
	Fri, 13 Dec 2024 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114527; cv=none; b=UvJI4w1sehYfkqCxOACt1yvFWmaZnoXZszUEfRkH3TNVpQQU77+aF/WCeEh3dkQCd2VpMOZ8Wyck6oiQcGA9BLG8dn5CWcxRdPXc2gGanU4T2llOhWrERcRtShZ+Unn/cGANTgLHlL/Y1gV53No47p5sSEgit+8OA2XA6WR2BXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114527; c=relaxed/simple;
	bh=LPbXhuBCznWltRrBN0dLQ2P7MlTVMKjZ0PAU60sAtzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h8u5OKFdCgcXPJVZ+KzKxXdaKcb3L+IibA8H1Fci2BfrNeXN6H8ZPYenyCc5vEZW9OIWgI9SjuKF160/BkpGFc/pf4XZan9XJhDE1o9dWiHfIys62fc3ztGgupCR9+Uh0u3+kGwaFQs9PlbBDFzq6+ZY4psba+Y1BHNi70PnQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBCPTSI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD7EC4CED0;
	Fri, 13 Dec 2024 18:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734114526;
	bh=LPbXhuBCznWltRrBN0dLQ2P7MlTVMKjZ0PAU60sAtzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SBCPTSI66ShGmbuj4OWyoEZsKbmGpeGStV1m9uJryWlugTq4GBs5QNDj6WXBoTLCF
	 WqDig1J91sZLoUOlzA/XEZ6e2qEwqyPAL0Bz3+u81opNHL4u/EelVBPt57e93lAtB4
	 i4m6AYQkfEuWofvaJp2WOeNZbemHi7TUrx4x5Nvj1m3kY3k1G7DpF4+qUh06wDU03m
	 ptQ7RLquyfmNpEGSKtvueyr+uzPoD22dJaNNVOeH8joGGtx0IZ5BfjIB2JuZaGLsOk
	 HLneRreZ6bgKK/uGqRvsqp8RWE3B4A0zsxEErGtwPpO22ll6A/s7Kyz89eONk+tCGY
	 K9FTLhEc+yRzw==
Date: Fri, 13 Dec 2024 12:28:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH v13] PCI/ASPM: Make pci_save_aspm_l1ss_state save both
 child and parent's L1SS configuration
Message-ID: <20241213182845.GA3423569@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpJ_eeHbQBtNK=0rJG-jzU-jZ=Tc1RknwrQgsFgEjr1qTqyqg@mail.gmail.com>

On Fri, Dec 13, 2024 at 12:37:24PM +0800, Jian-Hong Pan wrote:
> Bjorn Helgaas <helgaas@kernel.org> 於 2024年12月13日 週五 上午7:03寫道：
> > On Fri, Nov 15, 2024 at 03:22:02PM +0800, Jian-Hong Pan wrote:
> > > PCI devices' parameters on the VMD bus have been programmed properly
> > > originally. But, cleared after pci_reset_bus() and have not been restored
> > > correctly. This leads the link's L1.2 between PCIe Root Port and child
> > > device gets wrong configs.
> ...

> > I think the important thing here is that currently
> > pci_save_aspm_l1ss_state() saves only the child L1SS state, but
> > pci_restore_aspm_l1ss_state() restores both parent and child, and the
> > parent state is garbage.
> >
> > Obviously nothing specific to VMD or NVMe or SATA.
> >
> > > To avoid pci_restore_aspm_l1ss_state() restore wrong value to the parent's
> > > L1SS config like this example, make pci_save_aspm_l1ss_state() save the
> > > parent's L1SS config, if the PCI device has a parent.
> >
> > I tried to simplify the commit log and the patch so it's a little more
> > parallel with pci_restore_aspm_l1ss_state().  Please comment and test.
> >
> > Bjorn
> >
> > commit c93935e3ac92 ("PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()")
> > Author: Jian-Hong Pan <jhp@endlessos.org>
> > Date:   Fri Nov 15 15:22:02 2024 +0800
> >
> >     PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
> >
> >     After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> >     suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS state for
> >     "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for both
> >     "dev" and its parent.
> >
> >     The problem is that unless pci_save_state() has been used in some other
> >     path and has already saved the parent L1SS state, we will restore junk to
> >     the parent, which means the L1 Substates likely won't work correctly.
> >
> >     Save the L1SS config for both the device and its parent in
> >     pci_save_aspm_l1ss_state().  When restoring, we need both because L1SS must
> >     be enabled at the parent (the Downstream Port) before being enabled at the
> >     child (the Upstream Port).
> >
> >     Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endlessos.org
> >     Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
> >     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> >     Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >     Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> >     [bhelgaas: parallel save/restore structure, simplify commit log]
> 
> Thanks for the simplification!
> Tested on my Asus B1400CEAE. Both the "dev" (NVMe) and the parent (PCI
> bridge) keep the correct L1SS config.
> 
> Tested-by: Jian-Hong Pan <jhp@endlessos.org>

Thanks, I applied this on pci/aspm for v6.14 since this is a pretty
old problem, and AFAICT it's a power consumption issue, not something
that is functionally broken.  We might be able to make a case for
v6.13 if my understanding is incorrect.

Ilpo, David, I dropped your reviewed-by since I changed the patch
significantly; let me know if you see any issue or if you want to add
your reviewed-by.

> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 28567d457613..e0bc90597dca 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -81,24 +81,47 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
> >
> >  void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> >  {
> > +       struct pci_dev *parent = pdev->bus->self;
> >         struct pci_cap_saved_state *save_state;
> > -       u16 l1ss = pdev->l1ss;
> >         u32 *cap;
> >
> > +       /*
> > +        * If this is a Downstream Port, we never restore the L1SS state
> > +        * directly; we only restore it when we restore the state of the
> > +        * Upstream Port below it.
> > +        */
> > +       if (pcie_downstream_port(pdev) || !parent)
> > +               return;
> > +
> > +       if (!pdev->l1ss || !parent->l1ss)
> > +               return;
> > +
> >         /*
> >          * Save L1 substate configuration. The ASPM L0s/L1 configuration
> >          * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
> >          */
> > -       if (!l1ss)
> > -               return;
> > -
> >         save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
> >         if (!save_state)
> >                 return;
> >
> >         cap = &save_state->cap.data[0];
> > -       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
> > -       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> > +       pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
> > +       pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
> > +
> > +       if (parent->state_saved)
> > +               return;
> > +
> > +       /*
> > +        * Save parent's L1 substate configuration so we have it for
> > +        * pci_restore_aspm_l1ss_state(pdev) to restore.
> > +        */
> > +       save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
> > +       if (!save_state)
> > +               return;
> > +
> > +       cap = &save_state->cap.data[0];
> > +       pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++);
> > +       pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++);
> >  }
> >
> >  void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)

