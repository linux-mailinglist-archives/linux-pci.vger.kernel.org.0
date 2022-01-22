Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4F4968AD
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 01:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiAVAYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 19:24:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46478 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiAVAYs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 19:24:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF7EF61A38
        for <linux-pci@vger.kernel.org>; Sat, 22 Jan 2022 00:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E957AC340E1;
        Sat, 22 Jan 2022 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642811087;
        bh=OtwHe8NFN48fZ9f3UK305gET3oENhh+TQKf/31I7P44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aqGiTU7Dmh1qgbqFD5F4IJc6iwXcaYKWpWanrmSiv9/EkFII8lDy+hoTNB6e9pmUs
         Re0zDQytAoKwUPIs18HtYJh+to145eHTuj6XQ37LP1vd2hSHFPidbMyDl+Tqaz+EKJ
         NWCUUOGbbpmwPT6YZz5icYMK+CS/PmjWoyGDR60itugGgtqIuHJezUa4l1/9ZR9oCq
         fvhb6obPLt8tVzg7FdhXM7oo1v/OCcNzM8/lZxo/RyhCr8lrX38OKDQXDu7i4wh8p/
         uuctEGEoqwFar4h8dCFymLBJws/pqk9AzChg+e8Q2eLE8+Gti2Wn9vi0LcJCUpSxm1
         FbJEtW0D3K+YA==
Date:   Fri, 21 Jan 2022 18:24:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] 527139d738d7 ("PCI/sysfs: Convert "rom" to static
 attribute")
Message-ID: <20220122002445.GA1162144@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbzMyDm+5PCer8Fj@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 17, 2021 at 07:45:44PM +0200, Ville Syrjälä wrote:
> On Fri, Dec 17, 2021 at 11:29:28AM -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 17, 2021 at 12:44:51PM +0200, Ville Syrjälä wrote:
> > > The pci sysfs "rom" file has disappeared for VGA devices.
> > > Looks to be a regression from commit 527139d738d7 ("PCI/sysfs:
> > > Convert "rom" to static attribute").
> > > 
> > > Some kind of ordering issue between the sysfs file creation 
> > > vs. pci_fixup_video() perhaps?
> > 
> > Can you attach your complete "lspci -vv" output?  Also, which is the
> > default device?  I think there's a "boot_vga" sysfs file that shows
> > this.  "find /sys -name boot_vga | xargs grep ."
> 
> All I have is Intel iGPUs so it's always 00:02.0. 
> 
> $ cat /sys/bus/pci/devices/0000\:00\:02.0/boot_vga 
> 1
> $ cat /sys/bus/pci/devices/0000\:00\:02.0/rom
> cat: '/sys/bus/pci/devices/0000:00:02.0/rom': No such file or directory
> 
> I've attached the full lspci from my IVB laptop, but the problem
> happens on every machine (with an iGPU at least).
> 
> I presume with a discrete GPU it might not happen since they
> actually have a real ROM.
> 
> > I think the relevant path is something like this:
> > 
> >   acpi_pci_root_add
> >     pci_acpi_scan_root
> >       ...
> >         pci_scan_single_device
> >           pci_device_add
> >             device_add
> >               ...
> >                 sysfs_create_groups
> >                   ...
> >                     if (grp->is_visible())
> >                       pci_dev_rom_attr_is_visible  # after 527139d738d7
> >                         if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
> >                           ...
> >     pci_bus_add_devices
> >       pci_bus_add_device
> >         pci_fixup_device(pci_fixup_final)
> >           pci_fixup_video
> >             if (vga_default_device() ...)
> >               # update PCI_ROM_RESOURCE
> >         pci_create_sysfs_dev_files
> >           if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
> >             sysfs_create_bin_file("rom")           # before 527139d738d7
> > 
> > Prior to 527139d738d7, we ran pci_fixup_video() in
> > pci_bus_add_devices().  The vga_default_device() there might depend on
> > the fact that we've discovered all the PCI devices.  
> > 
> > After 527139d738d7, we create the "rom" file in pci_device_add(),
> > which happens as we discover each device, so maybe we don't yet know
> > which device is the default VGA device.

Thanks, Ville!

I think this is happening because the iGPU has no ROM BAR,
so pci_resource_len(PCI_ROM_RESOURCE) is 0 when we run
pci_dev_rom_attr_is_visible().  Prior to 527139d738d7, we also
used pci_resource_len(PCI_ROM_RESOURCE), but pci_fixup_video() had
been run, and it filled in the ROM resource with the shadow ROM
start and size.

Can you collect the dmesg output with "pci=earlydump"?  I think
that will show zeros at PCI_ROM_ADDRESS for your 00:02.0 device.

And can you try the test patch below?  I reproduced the problem in
qemu by instrumenting to clear the VGA ROM BAR, and moving the
pci_fixup_video() quirk earlier makes it run before
pci_dev_rom_attr_is_visible(), which fixes the problem for me.

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 2edd86649468..615a76d70019 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -353,8 +353,8 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		}
 	}
 }
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
-				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
 
 
 static const struct dmi_system_id msi_k8t_dmi_table[] = {
