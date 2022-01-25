Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16B49BBA2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 19:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiAYS42 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 13:56:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:28303 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233782AbiAYS4T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jan 2022 13:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643136979; x=1674672979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZCUrpJmkA1RP99UUe0/NF9HezTpFuh09zVkkBmfC5vg=;
  b=kzl7Wb1MFLLJ793ru/mAMoAxkDGoavl9x56Tk7ZWhn/E5pns5eHm1X+2
   j/DCsdthgXnbhNTT/MdifYmTRMguSxexv0T56ncuE8qETUnp/e9ofy/it
   38EUby1VbO0K8W2vz1t3ZNsjCSkjC839cTaH2+zAU1mshG0pwv/CZF8Fr
   aoJEN+TGU5i3cZsmUGEMsTERipXIA7tjHXVQcY/SrNEq5uV8S6iA+Sz6k
   oIGFqc4OnvWcvj1NAhFafOqUent9psEp8J8cvtuJF6v3xYQX3fV869YhT
   8uLEPfxbnoE/xkZikvFQBI2tiv8apt1IzhmV+m/dBOucoZfPKCELFRyqN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="243983910"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="243983910"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 10:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="674098995"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.147])
  by fmsmga001.fm.intel.com with SMTP; 25 Jan 2022 10:56:15 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 25 Jan 2022 20:56:14 +0200
Date:   Tue, 25 Jan 2022 20:56:14 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] 527139d738d7 ("PCI/sysfs: Convert "rom" to static
 attribute")
Message-ID: <YfBHzo4kNGgd2jTd@intel.com>
References: <YbzMyDm+5PCer8Fj@intel.com>
 <20220122002445.GA1162144@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220122002445.GA1162144@bhelgaas>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 21, 2022 at 06:24:45PM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 17, 2021 at 07:45:44PM +0200, Ville Syrjälä wrote:
> > On Fri, Dec 17, 2021 at 11:29:28AM -0600, Bjorn Helgaas wrote:
> > > On Fri, Dec 17, 2021 at 12:44:51PM +0200, Ville Syrjälä wrote:
> > > > The pci sysfs "rom" file has disappeared for VGA devices.
> > > > Looks to be a regression from commit 527139d738d7 ("PCI/sysfs:
> > > > Convert "rom" to static attribute").
> > > > 
> > > > Some kind of ordering issue between the sysfs file creation 
> > > > vs. pci_fixup_video() perhaps?
> > > 
> > > Can you attach your complete "lspci -vv" output?  Also, which is the
> > > default device?  I think there's a "boot_vga" sysfs file that shows
> > > this.  "find /sys -name boot_vga | xargs grep ."
> > 
> > All I have is Intel iGPUs so it's always 00:02.0. 
> > 
> > $ cat /sys/bus/pci/devices/0000\:00\:02.0/boot_vga 
> > 1
> > $ cat /sys/bus/pci/devices/0000\:00\:02.0/rom
> > cat: '/sys/bus/pci/devices/0000:00:02.0/rom': No such file or directory
> > 
> > I've attached the full lspci from my IVB laptop, but the problem
> > happens on every machine (with an iGPU at least).
> > 
> > I presume with a discrete GPU it might not happen since they
> > actually have a real ROM.
> > 
> > > I think the relevant path is something like this:
> > > 
> > >   acpi_pci_root_add
> > >     pci_acpi_scan_root
> > >       ...
> > >         pci_scan_single_device
> > >           pci_device_add
> > >             device_add
> > >               ...
> > >                 sysfs_create_groups
> > >                   ...
> > >                     if (grp->is_visible())
> > >                       pci_dev_rom_attr_is_visible  # after 527139d738d7
> > >                         if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
> > >                           ...
> > >     pci_bus_add_devices
> > >       pci_bus_add_device
> > >         pci_fixup_device(pci_fixup_final)
> > >           pci_fixup_video
> > >             if (vga_default_device() ...)
> > >               # update PCI_ROM_RESOURCE
> > >         pci_create_sysfs_dev_files
> > >           if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
> > >             sysfs_create_bin_file("rom")           # before 527139d738d7
> > > 
> > > Prior to 527139d738d7, we ran pci_fixup_video() in
> > > pci_bus_add_devices().  The vga_default_device() there might depend on
> > > the fact that we've discovered all the PCI devices.  
> > > 
> > > After 527139d738d7, we create the "rom" file in pci_device_add(),
> > > which happens as we discover each device, so maybe we don't yet know
> > > which device is the default VGA device.
> 
> Thanks, Ville!
> 
> I think this is happening because the iGPU has no ROM BAR,
> so pci_resource_len(PCI_ROM_RESOURCE) is 0 when we run
> pci_dev_rom_attr_is_visible().  Prior to 527139d738d7, we also
> used pci_resource_len(PCI_ROM_RESOURCE), but pci_fixup_video() had
> been run, and it filled in the ROM resource with the shadow ROM
> start and size.
> 
> Can you collect the dmesg output with "pci=earlydump"?  I think
> that will show zeros at PCI_ROM_ADDRESS for your 00:02.0 device.

Yeah no real ROM on these:
 pci 0000:00:02.0: config space:
 00000000: 86 80 26 01 07 00 90 00 09 00 00 03 00 00 00 00
 00000010: 04 00 00 f0 00 00 00 00 0c 00 00 e0 00 00 00 00
 00000020: 01 50 00 00 00 00 00 00 00 00 00 00 aa 17 da 21
 00000030: 00 00 00 00 90 00 00 00 00 00 00 00 0b 01 00 00
 00000040: 09 00 0c 01 9e 61 00 e2 90 00 08 14 00 00 00 00
 00000050: 11 02 00 00 11 00 00 00 00 00 00 00 01 00 a0 db
 00000060: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 00000090: 05 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 000000a0: 00 00 00 00 13 00 06 03 00 00 00 00 00 00 00 00
 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 000000d0: 01 a4 22 00 00 00 00 00 00 00 00 00 00 00 00 00
 000000e0: 00 00 00 00 00 00 00 00 00 80 00 00 00 00 00 00
 000000f0: 00 00 00 00 00 00 00 00 00 00 06 00 18 60 ef da
 pci 0000:00:02.0: [8086:0126] type 00 class 0x030000
 pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fffff 64bit]
 pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
 pci 0000:00:02.0: reg 0x20: [io  0x5000-0x503f]

> 
> And can you try the test patch below?  I reproduced the problem in
> qemu by instrumenting to clear the VGA ROM BAR, and moving the
> pci_fixup_video() quirk earlier makes it run before
> pci_dev_rom_attr_is_visible(), which fixes the problem for me.
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 2edd86649468..615a76d70019 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -353,8 +353,8 @@ static void pci_fixup_video(struct pci_dev *pdev)
>  		}
>  	}
>  }
> -DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> -				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> +			       PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
>  
>  
>  static const struct dmi_system_id msi_k8t_dmi_table[] = {

pci=earlydump now reports:
 pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
and poking it via sysfs works fine.

Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

-- 
Ville Syrjälä
Intel
