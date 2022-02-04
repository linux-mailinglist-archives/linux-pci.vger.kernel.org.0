Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81FD4AA31F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 23:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbiBDWaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 17:30:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37442 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbiBDWaA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 17:30:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66EF661986;
        Fri,  4 Feb 2022 22:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568E2C004E1;
        Fri,  4 Feb 2022 22:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644013799;
        bh=784R0H5VZORiBO8gxGqC45C8yMukbkAJS6RxKN+fEUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bSUJILDumboRvfqWMmFVHugQmXDQ0ZFpv77/46xtMzqYCq39yUdpC0Q7xUs47nUAd
         aeclwhrTTiblV5oWLS3DwGdII629b57t7XCY201P+2263LhpTx62AGyRvG1bz01+Qo
         IK1ooLIPBBRPqJFOfNG4m2YPY82gJW8ECAYb7N/RU7ho5ku2+dy5u5R/r82/1Z4jWP
         zvRZTZt1j4iZSSSyaZy+wSY3VIqvgIDVpcF1Dmt6Sbv0KxxKiGtRnFP06mjWQ5ONYc
         cqL00ZEaS9PX5is6OoZn/GqnEjClctQur6RTTc+eSia3Ynh1EDzknbsHhKsZzymcot
         KIZ72w0MLB8cw==
Date:   Fri, 4 Feb 2022 16:29:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] pci: mark USB4 devices as "is_thunderbolt"
Message-ID: <20220204222956.GA220908@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204182820.130339-3-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Follow subject line capitalization conventions:

  $ git log --oneline drivers/pci/probe.c
  661c4c4f2693 PCI: Let pcibios_root_bridge_prepare() access bridge->windows
  d2c64f98c387 PCI: Use pci_find_vsec_capability() when looking for TBT devices
  fd1ae23b495b PCI: Prefer 'unsigned int' over bare 'unsigned'
  e1b0d0bb2032 PCI: Re-enable Downstream Port LTR after reset or hotplug
  7c3855c423b1 PCI: Coalesce host bridge contiguous apertures
  06dc660e6eb8 PCI: Rename pcibios_add_device() to pcibios_device_add()
  41dd40fd7179 PCI: Support populating MSI domains of root buses via bridges

On Fri, Feb 04, 2022 at 12:28:20PM -0600, Mario Limonciello wrote:

Add an intro sentence to tell us what this patch does (mark USB4
devices as 'is_thunderbolt'.  I know it's in the subject, but people
read the commit log separately and it should be complete in itself.
A title is not the first sentence of a book.

> Downstream drivers use this information to declare functional
> differences in how the drivers performed by knowing that they are
> connected to an upstream TBT/USB4 port.

s/Downstream drivers/Drivers of downstream devices/
s/performed/perform/  (I guess?)

I'm guessing this really refers to differences in how *devices*
(not drivers) perform when they are below a Thunderbolt or USB port.

I've never liked "is_thunderbolt" because it tells us nothing about
what functionality is of interest, so it's an unmaintainable mess.

Right now:

  - We assume Root Ports and Switch Ports marked "is_thunderbolt"
    support D3 (pci_bridge_d3_possible()).

  - Downstream Ports marked "is_thunderbolt" don't support native
    hotplug Command Completed events, even if they claim they do
    (pcie_init()).

  - Apparently, if *any* device in the system is marked
    "is_thunderbolt", a GPU external DP port is not fully switchable
    because ? (gmux_probe()).

  - Whether an AMD GPU is attached via Thunderbolt tells us something
    about what sort of power control and runtime power management we
    can do (amdgpu_driver_load_kms(), radeon_driver_load_kms()).

  - We don't register Thunderbolt eGPU devices with VGA switcheroo
    because ? (nouveau_vga_init(), radeon_device_init()).

  - If an AMD GPU is attached via Thunderbolt, we program different
    ASPM time values because ? (nbio_v2_3_enable_aspm()).

This is totally bonkers.

Broken things like hotplug Command Completed should be quirks.  That
one is my fault.

The ASPM thing should be integrated with the PCI core somehow.  It's
just asking for trouble to have the PCI core assuming *it* is managing
ASPM and then have drivers doing non-standard ASPM stuff behind its
back.

I have no idea about the VGA switching and power management stuff.

But it's not clear to me that these all fit under the "is_thunderbolt"
umbrella.  If they actually do correspond to Thunderbolt- or USB4-
specific features, we should include references to the pertinent
sections of the spec.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..b59f6c05e606 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1581,9 +1581,9 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  {
>  	u16 vsec;
>  
> -	/* Is the device part of a Thunderbolt controller? */
> +	/* Is the device part of a Thunderbolt or USB4 controller? */
>  	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
> -	if (vsec)
> +	if (vsec || dev->class == PCI_CLASS_SERIAL_USB_USB4)
>  		dev->is_thunderbolt = 1;

This could be rewritten as:

  if (dev->class == PCI_CLASS_SERIAL_USB_USB4 ||
      pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT))
          dev->is_thunderbolt = 1;

to avoid searching USB4 devices for a TBT capability unnecessarily.

>  }
>  
> -- 
> 2.34.1
> 
