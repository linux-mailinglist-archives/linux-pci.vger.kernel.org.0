Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22E547C54B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 18:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbhLURsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 12:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhLURsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 12:48:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5AC061574;
        Tue, 21 Dec 2021 09:48:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A8C761411;
        Tue, 21 Dec 2021 17:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7358CC36AE9;
        Tue, 21 Dec 2021 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640108890;
        bh=Et4mzk/+efM2dwP/TpKnvvWIhU8jDPgT0EfC9TuYSxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N2sPpZ0OZxgZIgHxP1V/XW+ZVEO8R60BzB2tjs8ac7kXXAWenJtle8hUhlocg9n7v
         0F7p16avvrKIIi13V+Xnzs2rr31Nq5Nb3TJvUWIo5TqcvoqS1i5uD8wo5tyDCDaooK
         uFWgvDzetxXdmcVXeVQtkbQWL8X9prYi+tQbOWBCIASe9DDrj90uQh6a5Y7zr4N3Nn
         BoJ5jjxcoeBXY/xTZ2uR56eu+EfqGZl/+Gjh66vVZUgHAznqBZOgLrhZDgZrC6GOiH
         FSsQTR8MJBW1c+09cOEudxRX3Iq/37jQlUq8Kqvs5kJVVP9nNBSXAeN9K+sRe7gdc2
         zbLuvHy1Y560g==
Date:   Tue, 21 Dec 2021 11:48:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michael Walle <michael@walle.cc>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
Message-ID: <20211221174808.GA1094860@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9303c33a8faa83597db807a8c418ef17@walle.cc>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Jesse, Tony for Intel advice;
beginning of thread: https://lore.kernel.org/all/20201230185317.30915-1-michael@walle.cc/]

On Mon, Dec 20, 2021 at 06:43:03PM +0100, Michael Walle wrote:
> ...
> ping #4
> 
> In a few days this is a year old. Please have a look at it and
> either add my quirk patch or apply your patch. This is still
> breaking i210 on my board.
> 
> TBH, this is really frustrating.

You are right to be frustrated.  I'm very sorry that I have dropped
the ball on this.  Thanks for reminding me *again*.

I think we agree that this looks like an I210 defect.  I210 should
ignore the ROM BAR contents unless PCI_ROM_ADDRESS_ENABLE is set.  It
would be great if an Intel person could confirm/deny this and supply
an erratum reference and verify the affected device IDs.

It seems that when the BARs are programmed like this:

  BAR 0: 0x40000000 (32-bit, non-prefetchable) [size=1M]
  BAR 3: 0x40200000 (32-bit, non-prefetchable) [size=16K]
  ROM:   0x40200000 (disabled) [size=1M]

networking doesn't work at all and the transmit queue times out.

Linux assigns non-overlapping address space to the ROM BAR, but
pci_std_update_resource() currently doesn't update the BAR itself
unless it is enabled.

My proposal [1] worked around the defect by always updating the BAR,
but there's no clue that this covers up the I210 issue, so it remains
as sort of a land mine.  A future change could re-expose the problem,
so I don't think this was a good approach.

Your original patch [2] makes it clear that it's an issue with I210,
but there's an implicit connection between the normal BAR update path
(which skips the actual BAR write) and the quirk that does the BAR
write:

  <enumeration resource assignment>
    ...
      pci_assign_resource
        pci_update_resource
          pci_std_update_resource
            if (ROM && ROM-disabled)
              return
            pci_write_config_dword      # ROM BAR update (skipped)

  pci_fixup_write_rom_bar               # final fixup
    pci_write_config_dword              # ROM BAR update

In the boot-time resource assignment path, this works fine, but if
pci_assign_resource() is called from pci_map_rom(), the fixup will not
happen, so we could still have problem.

If we tweaked pci_std_update_resource() to take account of this
defect, I think we could cover that path, too.

Can you try the patch below?

[1] https://lore.kernel.org/all/20210115235721.GA1862880@bjorn-Precision-5520/
[2] https://lore.kernel.org/all/20201230185317.30915-1-michael@walle.cc/


commit 021481cfa576 ("PCI: Work around Intel I210 ROM BAR overlap defect")
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
    
    Quirk these I210 devices so we always write the assigned address to the ROM
    BAR, whether or not the ROM is enabled.
    
    Link: https://lore.kernel.org/r/20201230185317.30915-1-michael@walle.cc
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=211105
    Reported-by: Michael Walle <michael@walle.cc>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..c14ddbd9146d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5857,3 +5857,13 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
+
+static void intel_i210_rom_defect(struct pci_dev *dev)
+{
+	pci_info(dev, "working around ROM BAR overlap defect\n");
+	dev->rom_bar_overlap = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1533, intel_i210_rom_defect);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1536, intel_i210_rom_defect);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1537, intel_i210_rom_defect);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1538, intel_i210_rom_defect);
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
 
