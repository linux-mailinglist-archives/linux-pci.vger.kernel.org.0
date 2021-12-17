Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC24792D7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 18:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhLQR3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 12:29:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39500 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhLQR3d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Dec 2021 12:29:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 81210CE25E1
        for <linux-pci@vger.kernel.org>; Fri, 17 Dec 2021 17:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEFDC36AE7;
        Fri, 17 Dec 2021 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639762169;
        bh=5UgUv3ZKbWRgCKIzs4PbIjUBwYiBBZhTXk6bKY1Nyzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Fd65czAhwyeieHpml/fsCPADEP6c1VwBsdoNE0AXEJJdbljSbPLd69vfvlgSmcuaU
         SD/qEyq5s+3sabafCzBAJpE1Bd+bjTUo3nLkkbPMBrgbXHEKO4Xp9Xg+e8oegICtdw
         Zd5ndMcCwp15/yAT+oO7kliH1zs/6vm6HEMl7qa1uVgPWvnnhJBZ0ef4fCEKNDPFtn
         ZNMqt+ep2uNxNvjpjVQUW/RD4IupsbauS6/rbNyHByBI4TV4b0AWtGQpi0zuUcRZLb
         M6AMu0GRUUbqfAxfGpmFkWzY7t112fGNJz9G8+w2Xnz00oxaK1BTxz3pLeUX8CYUN3
         ohayBYhRL7Fvw==
Date:   Fri, 17 Dec 2021 11:29:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] 527139d738d7 ("PCI/sysfs: Convert "rom" to static
 attribute")
Message-ID: <20211217172928.GA900484@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbxqIyrkv3GhZVxx@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ville,

Thanks for the report!

On Fri, Dec 17, 2021 at 12:44:51PM +0200, Ville Syrjälä wrote:
> Hi,
> 
> The pci sysfs "rom" file has disappeared for VGA devices.
> Looks to be a regression from commit 527139d738d7 ("PCI/sysfs:
> Convert "rom" to static attribute").
> 
> Some kind of ordering issue between the sysfs file creation 
> vs. pci_fixup_video() perhaps?

Can you attach your complete "lspci -vv" output?  Also, which is the
default device?  I think there's a "boot_vga" sysfs file that shows
this.  "find /sys -name boot_vga | xargs grep ."

I think the relevant path is something like this:

  acpi_pci_root_add
    pci_acpi_scan_root
      ...
        pci_scan_single_device
          pci_device_add
            device_add
              ...
                sysfs_create_groups
                  ...
                    if (grp->is_visible())
                      pci_dev_rom_attr_is_visible  # after 527139d738d7
                        if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
                          ...
    pci_bus_add_devices
      pci_bus_add_device
        pci_fixup_device(pci_fixup_final)
          pci_fixup_video
            if (vga_default_device() ...)
              # update PCI_ROM_RESOURCE
        pci_create_sysfs_dev_files
          if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
            sysfs_create_bin_file("rom")           # before 527139d738d7

Prior to 527139d738d7, we ran pci_fixup_video() in
pci_bus_add_devices().  The vga_default_device() there might depend on
the fact that we've discovered all the PCI devices.  

After 527139d738d7, we create the "rom" file in pci_device_add(),
which happens as we discover each device, so maybe we don't yet know
which device is the default VGA device.

Bjorn
