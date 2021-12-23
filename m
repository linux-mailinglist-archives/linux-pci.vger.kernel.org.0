Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6999C47E678
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349265AbhLWQh5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 11:37:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40824 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbhLWQh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 11:37:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B4761DEB;
        Thu, 23 Dec 2021 16:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE709C36AE9;
        Thu, 23 Dec 2021 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640277476;
        bh=I9a8MK1bhxraYlvGnDhWvhoRW/AU+35GD1j/Ku3yvJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D0sa+/eqq0bqcZINEkvF4aGoeNYXBZwW2h6cio461cdRY0uWRcqAE6o7Hd1PdLlkw
         BzLxuIFaOJ2O2gCtWuuBk45VnicC+wjU7JWhfciRTWJQGaSvSzhAjoXMZ+CVvBOJOR
         Cya3TNlSdW/GSyevnMB4aGVJiDI4HI6YGjjqA/8thS8A1K1k0yRbiWUdqcKU5Tuieo
         J3/62yRBJuzfzWd/9d++bIiCS2zpa3sMY3NiUZGvRGA4TGR02F9QmfNDN4vEDgDE6D
         xufritCx5bj+Fmsrby/BdVhzT4G+w3zNtE5EKb6fYYDedc8rN1P6kM0X3vVxFSks6I
         Fvrpgjt4G1MwA==
Date:   Thu, 23 Dec 2021 10:37:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
Message-ID: <20211223163754.GA1267351@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ecedffaf8e2ee931379de7e2f7924f@walle.cc>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 23, 2021 at 10:27:15AM +0100, Michael Walle wrote:
> Am 2021-12-21 18:48, schrieb Bjorn Helgaas:
> > [+to Jesse, Tony for Intel advice;
> > beginning of thread:
> > https://lore.kernel.org/all/20201230185317.30915-1-michael@walle.cc/]
> > 
> > On Mon, Dec 20, 2021 at 06:43:03PM +0100, Michael Walle wrote:
> > > ...
> > > ping #4
> > > 
> > > In a few days this is a year old. Please have a look at it and
> > > either add my quirk patch or apply your patch. This is still
> > > breaking i210 on my board.
> > > 
> > > TBH, this is really frustrating.
> > 
> > You are right to be frustrated.  I'm very sorry that I have dropped
> > the ball on this.  Thanks for reminding me *again*.
> > 
> > I think we agree that this looks like an I210 defect.  I210 should
> > ignore the ROM BAR contents unless PCI_ROM_ADDRESS_ENABLE is set.  It
> > would be great if an Intel person could confirm/deny this and supply
> > an erratum reference and verify the affected device IDs.
> > 
> > It seems that when the BARs are programmed like this:
> > 
> >   BAR 0: 0x40000000 (32-bit, non-prefetchable) [size=1M]
> >   BAR 3: 0x40200000 (32-bit, non-prefetchable) [size=16K]
> >   ROM:   0x40200000 (disabled) [size=1M]
> > 
> > networking doesn't work at all and the transmit queue times out.
> > 
> > Linux assigns non-overlapping address space to the ROM BAR, but
> > pci_std_update_resource() currently doesn't update the BAR itself
> > unless it is enabled.
> > 
> > My proposal [1] worked around the defect by always updating the BAR,
> > but there's no clue that this covers up the I210 issue, so it remains
> > as sort of a land mine.  A future change could re-expose the problem,
> > so I don't think this was a good approach.
> > 
> > Your original patch [2] makes it clear that it's an issue with I210,
> > but there's an implicit connection between the normal BAR update path
> > (which skips the actual BAR write) and the quirk that does the BAR
> > write:
> > 
> >   <enumeration resource assignment>
> >     ...
> >       pci_assign_resource
> >         pci_update_resource
> >           pci_std_update_resource
> >             if (ROM && ROM-disabled)
> >               return
> >             pci_write_config_dword      # ROM BAR update (skipped)
> > 
> >   pci_fixup_write_rom_bar               # final fixup
> >     pci_write_config_dword              # ROM BAR update
> > 
> > In the boot-time resource assignment path, this works fine, but if
> > pci_assign_resource() is called from pci_map_rom(), the fixup will not
> > happen, so we could still have problem.
> 
> I'm not sure I follow. pci_map_rom() should work fine. That was also
> the workaround IIRC, that is, enable the rom via sysfs. pci_map_rom()
> will call pci_enable_rom(), which should be the same as the fixup.
> If memory serves correctly, that is where I shamelessly copied the
> code from ;)

Ah, you're right, I missed the fact that pci_enable_rom() would do the
write.

> btw. the problem is not in pci_assign_resource() which assigns the
> correct offsets, but that they are not written to the PCI card.
> Eg. see lspci:
> 
> # lspci -s 2:1:0 -v
> 0002:01:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> Connection (rev 03)
> 	Subsystem: Hewlett-Packard Company Ethernet I210-T1 GbE NIC
> 	Flags: bus master, fast devsel, latency 0, IRQ 34, IOMMU group 8
> 	Memory at 8840000000 (32-bit, non-prefetchable) [size=1M]
> 	Memory at 8840200000 (32-bit, non-prefetchable) [size=16K]
> 	Expansion ROM at 8840100000 [disabled] [size=1M]
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
> 	Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
> 	Capabilities: [a0] Express Endpoint, MSI 00
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [140] Device Serial Number 00-de-ad-ff-ff-be-ef-04
> 	Capabilities: [1a0] Transaction Processing Hints
> 	Kernel driver in use: igb
> lspci: Unable to load libkmod resources: error -2
> 
> # lspci -s 2:1:0 -xx
> 0002:01:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> Connection (rev 03)
> 00: 86 80 33 15 06 04 10 00 03 00 00 02 08 00 00 00
> 10: 00 00 00 40 00 00 00 00 00 00 00 00 00 00 20 40
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 03 00
> 30: 00 00 20 40 40 00 00 00 00 00 00 00 22 01 00 00
> 
> Note the difference between "Expansion ROM at 8840100000" (assigned
> by pci_assign_resource() I guess) and the actual value at offset
> 0x30: 0x40200000. The latter will be updated either by pci_enable_rom()
> or my pci fixup quirk.

Yes, I understand that.  I think it's better to do the update in
pci_std_update_resource() instead of relying on a future fixup or
pci_enable_rom().  There's no explicit connection between the
assignment and the BAR write, so it's fragile.

> > Can you try the patch below?
> 
> I tried, but it doesn't work because the fixup function is called
> after pci_std_update_resource(), thus dev->rom_bar_overlap is still
> 0.

I intended to change the quirk from FINAL to EARLY, but obviously
forgot.  Here's the updated version:

commit bb5639b73a2d ("PCI: Work around Intel I210 ROM BAR overlap defect")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Dec 21 10:45:07 2021 -0600

    PCI: Work around Intel I210 ROM BAR overlap defect
    
    Per PCIe r5, sec 7.5.1.2.4, a device must not claim accesses to its
    Expansion ROM unless both the Memory Space Enable and the Expansion ROM
    Enable bit are set.  But apparently some Intel I210 NICs don't work
    correctly if the ROM BAR overlaps another BAR, even if the Expansion ROM is
    disabled.
    
    Michael reported that on a Kontron SMARC-sAL28 ARM64 system with U-Boot
    v2021.01-rc3, the ROM BAR overlaps BAR 3, and networking doesn't work at
    all:
    
      BAR 0: 0x40000000 (32-bit, non-prefetchable) [size=1M]
      BAR 3: 0x40200000 (32-bit, non-prefetchable) [size=16K]
      ROM:   0x40200000 (disabled) [size=1M]
    
      NETDEV WATCHDOG: enP2p1s0 (igb): transmit queue 0 timed out
      Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
      igb 0002:01:00.0 enP2p1s0: Reset adapter
    
    Previously, pci_std_update_resource() wrote the assigned ROM address to the
    BAR only when the ROM was enabled.  This meant that the I210 ROM BAR could
    be left with an address assigned by firmware, which might overlap with
    other BARs.
    
    Quirk these I210 devices so pci_std_update_resource() always writes the
    assigned address to the ROM BAR, whether or not the ROM is enabled.
    
    Link: https://lore.kernel.org/r/20201230185317.30915-1-michael@walle.cc
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=211105
    Reported-by: Michael Walle <michael@walle.cc>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..46ff04091fa3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5857,3 +5857,13 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
+
+static void rom_bar_overlap_defect(struct pci_dev *dev)
+{
+	pci_info(dev, "working around ROM BAR overlap defect\n");
+	dev->rom_bar_overlap = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 7f1acb3918d0..439ac5f5907a 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -75,12 +75,16 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		 * as zero when disabled, so don't update ROM BARs unless
 		 * they're enabled.  See
 		 * https://lore.kernel.org/r/43147B3D.1030309@vc.cvut.cz/
+		 * But we must update ROM BAR for buggy devices where even a
+		 * disabled ROM can conflict with other BARs.
 		 */
-		if (!(res->flags & IORESOURCE_ROM_ENABLE))
+		if (!(res->flags & IORESOURCE_ROM_ENABLE) &&
+		    !dev->rom_bar_overlap)
 			return;
 
 		reg = dev->rom_base_reg;
-		new |= PCI_ROM_ADDRESS_ENABLE;
+		if (res->flags & IORESOURCE_ROM_ENABLE)
+			new |= PCI_ROM_ADDRESS_ENABLE;
 	} else
 		return;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..51c4a063f489 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -455,6 +455,7 @@ struct pci_dev {
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
+	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
