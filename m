Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427AE2EC69A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 00:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbhAFXMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 18:12:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAFXMV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 18:12:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 631FD225AC;
        Wed,  6 Jan 2021 23:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609974700;
        bh=C4lkCxq3GgpIZnzJfvMgGcqHjmU2Xc7PbSpPSnKU/7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MPCGJRH+rxnFAiLtgNX43diPJzGYKtNVmdsQNqc7ITnYe7s1YxYF4b5m23Xm0xgiJ
         owZ/vBZYJmDsixuBNrON2YUAMPMV3ks+B+pAPxj79/plkwvRe/4pdB79mLHgqLCROZ
         opbYJnAMrW/htY19T+KTSsGKVhdBiZyQ/TecMneAsH+uH+y97OdNkcPu5Rj131ZrGt
         y+kw6ft6WCt6a689lqrt2lpUW4Ay7nJAZijjPEo0vgfGDBrMPbgRWacXVSoKtZP+Ds
         kLjRgmeg5EU/faSdPi5YwVlX3RvTgcKbMRb+S471if/hTECfxAReQxyxe1UAOyNSfk
         KpLjyA2RguIlQ==
Date:   Wed, 6 Jan 2021 17:11:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] PCI: brcmstb: Add panic/die handler to RC driver
Message-ID: <20210106231139.GA1350432@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBt7C+EhcpbgYdreK=xvQuOzEaDm+us-6P+PtoEfCny2Vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 06, 2021 at 02:57:19PM -0500, Jim Quinlan wrote:
> On Wed, Jan 6, 2021 at 2:42 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> >
> > ---------- Forwarded message ---------
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Date: Wed, Jan 6, 2021 at 2:19 PM
> > Subject: Re: [PATCH v2 5/6] PCI: brcmstb: Add panic/die handler to RC driver
> > To: Jim Quinlan <james.quinlan@broadcom.com>
> > Cc: <linux-pci@vger.kernel.org>, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de>, <broonie@kernel.org>,
> > <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn
> > Helgaas <bhelgaas@google.com>, Florian Fainelli
> > <f.fainelli@gmail.com>, moderated list:BROADCOM BCM2711/BCM2835 ARM
> > ARCHITECTURE <linux-rpi-kernel@lists.infradead.org>, moderated
> > list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
> > <linux-arm-kernel@lists.infradead.org>, open list
> > <linux-kernel@vger.kernel.org>
> >
> >
> > On Mon, Nov 30, 2020 at 04:11:42PM -0500, Jim Quinlan wrote:
> > > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> > > by default Broadcom's STB PCIe controller effects an abort.  This simple
> > > handler determines if the PCIe controller was the cause of the abort and if
> > > so, prints out diagnostic info.
> > >
> > > Example output:
> > >   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
> > >   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
> >
> > What does this mean for all the other PCI core code that expects
> > 0xffffffff data returns?  Does it work?  Does it break differently on
> > STB than on other platforms?
> Hi Bjorn,
> 
> Our PCIe HW causes a CPU abort when this happens.  Occasionally a
> customer will have a fault handler try to fix up the abort and
> continue on, but we recommend solving the root problem.  This commit
> just gives us a chance to glean info about the problem.  Our newer
> SOCs have a mode that doesn't abort and instead returns 0xffffffff.
> 
> BTW, can you point me to example files where "PCI core code that
> expects  0xffffffff data returns" [on bad accesses]?

The most important case is during enumeration.  A config read to a
device that doesn't exist normally terminates as an Unsupported
Request, and pci_bus_generic_read_dev_vendor_id() depends on reading
0xffffffff in that case.  I assume this particular case does work that
way for brcm-pcie, because I assume enumeration does work.

pci_cfg_space_size_ext() is similar.  I assume this also works for
brcm-pcie for the same reason.

pci_raw_set_power_state() looks for ~0, which it may see if it does a
config read to a device in D3cold.  pci_dev_wait(), dpc_irq(),
pcie_pme_work_fn(), pcie_pme_irq() are all similar.

Yes, this is ugly and we should check for these more consistently.

The above are all for config reads.  The PCI core doesn't do MMIO
accesses except for a few cases like MSI-X.  But drivers do, and if
they check for PCIe errors on MMIO reads, they do it by looking for
0xffffffff, e.g., pci_mmio_enabled() (in hfi1),
qib_pci_mmio_enabled(), bnx2x_get_hwinfo(), etc.

Bjorn
