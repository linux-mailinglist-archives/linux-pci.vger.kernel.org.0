Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22A42F5864
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 04:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbhANCSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 21:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbhAMVE0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Jan 2021 16:04:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7D4521D95;
        Wed, 13 Jan 2021 20:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610571276;
        bh=kJuETQaVMNcw8dbfJHqaFfpm2JkbaqeCXrQ+kZZ8lOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dkzE6zbnUkZwTPhDe65zzJcarln1ss0SZgbyCpBpSamUw56a/LPjGlvFlOXQL7MDl
         YWgNWyN3gSuHa3WcCjVrd0fcNt1Z/c6q22wHPBv5j/Nwwh/WyWkOrmol60Ah1OgxLj
         JjN8XBEGP9tQi09R4knorUPXRc4lIuQ1y+o9FPuIElVeXRMX86UvW+vu7rXbw3xktM
         jlQHmrXNkCZwh52RIe9fRRLDLb2zWiKa4ubUVBjgPFAKnk89g7SNTDAxz2SUMD76tF
         APU/F8L+LZarG6mWGFLDSPNaGBrvOz+JdZKjDUkcBvsza7ZIDsEqiiGSETcTvy8AQA
         Kx7lZHDd9NJiA==
Date:   Wed, 13 Jan 2021 14:54:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Victor Ding <victording@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, Alex Levin <levinale@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Disable ASPM until its LTR and L1ss state
 is restored
Message-ID: <20210113205434.GA1926338@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANqTbdb4gZYQUAZzatwymy-S9Ajb=PhfP53_D2TYLJp0zw4HxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 13, 2021 at 01:16:05PM +1100, Victor Ding wrote:
> On Wed, Jan 13, 2021 at 9:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 12, 2021 at 04:02:04AM +0000, Victor Ding wrote:
> > > Right after powering up, the device may have ASPM enabled; however,
> > > its LTR and/or L1ss controls may not be in the desired states; hence,
> > > the device may enter L1.2 undesirably and cause resume performance
> > > penalty. This is especially problematic if ASPM related control
> > > registers are modified before a suspension.
> >
> > s/L1ss/L1SS/ (several occurrences) to match existing usage.
> >
> I'll update it in the next version.
> >
> > > Therefore, ASPM should disabled until its LTR and L1ss states are
> > > fully restored.
> > >
> > > Signed-off-by: Victor Ding <victording@google.com>
> > > ---
> > >
> > >  drivers/pci/pci.c       | 11 +++++++++++
> > >  drivers/pci/pci.h       |  2 ++
> > >  drivers/pci/pcie/aspm.c |  2 +-
> > >  3 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index eb323af34f1e..428de433f2e6 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1660,6 +1660,17 @@ void pci_restore_state(struct pci_dev *dev)
> > >       if (!dev->state_saved)
> > >               return;
> > >
> > > +     /*
> > > +      * Right after powering up, the device may have ASPM enabled;
> >
> > I think this could be stated more precisely.  "Right after powering
> > up," ASPM should be *disabled* because ASPM Control in the Link
> > Control register powers up as zero (disabled).
> >
> Good suggestion; I'll reword in the next version.
> However, ASPM should be *disabled* for the opposite reason - ASPM Control
> in the Link Control register *may* power as non-zero (enabled).
> (More answered in the next section)
> >
> > > +      * however, its LTR and/or L1ss controls may not be in the desired
> > > +      * states; as a result, the device may enter L1.2 undesirably and
> > > +      * cause resume performance penalty.
> > > +      * Therefore, ASPM is disabled until its LTR and L1ss states are
> > > +      * fully restored.
> > > +      * (enabling ASPM is part of pci_restore_pcie_state)
> >
> > If we're enabling L1.2 before LTR has been configured, that's
> > definitely a bug.  But I don't see how that happens.  The current code
> > looks like:
> >
> >   pci_restore_state
> >     pci_restore_ltr_state
> >       pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++)
> >       pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++)
> >     pci_restore_aspm_l1ss_state
> >       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++)
> >     pci_restore_pcie_state
> >       pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++])
> >
> > We *do* restore PCI_L1SS_CTL1, which contains "ASPM L1.2 Enable",
> > before we restore PCI_EXP_LNKCTL, which contains "ASPM Control", but I
> > don't think "ASPM L1.2 Enable" by itself should be enough to allow
> > hardware to enter L1.2.
> >
> > Reading PCIe r5.0, sec 5.5.1, it seems like hardware should ignore the
> > PCI_L1SS_CTL1 bits unless ASPM L1 entry is enabled in PCI_EXP_LNKCTL.
> >
> > What am I missing?
> >
> Correct; however, PCI_EXP_LNKCTL may power up as non-zero, i.e. has
> ASPM Control enabled. BIOS may set PCI_EXP_LNKCTL (and
> PCI_L1SS_CTL1) before Kernel takes control. When BIOS does so, there
> is a brief period between powering up and Kernel restoring LTR state
> that L1.2 is enabled but LTR isn't configured.

IIUC you're saying that ASPM Control powers up as zero, but BIOS
enables ASPM before transferring control to the OS.  That makes sense,
but I wouldn't describe that as "the device powering up with ASPM
enabled."

If BIOS enables L1SS (specifically, if it enables L1.2) when LTR
hasn't been configured, that sounds like a BIOS defect.
