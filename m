Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9C3A8A20
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOUZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 16:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFOUZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 16:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 149D7613B1;
        Tue, 15 Jun 2021 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623788604;
        bh=HnJHZDcj5EVuCXdAUWILXvtiwqyC1i/FMAkPYIYRUoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eQUYWmpINSIUsC8aX94+chc0+iSbv6oHAtRBXZCW/eMbj54fD80onQjTIBSSO03wZ
         MtaaevsTCfV+5TwLRBrjZ88McMwiGY7+Y3hB6VbaE1OTaWy+Noh5XD5KxM8Z12vwGE
         II6LmdU3bKL41jvXRw3l5Y6Ta9UcFE7Otw/jWDkrXgNW/lyTC/a735ZRPeJhq8XJCZ
         +HYe2AFLPOQ6E0jyfV04qU5oN8K7jR42tlEIMu899EJ1ihJ/JrVfJTfspin1L4/2+i
         2AdqKAX4Xyp/TK0tUCyUMNVeQzKy1Ojx+DJ9hnwIsY5J2PdSebXdAAL0Mh8PMZq671
         sw+KfYSXXhwhw==
Date:   Tue, 15 Jun 2021 15:23:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
Message-ID: <20210615202322.GA2910413@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615102555.6035-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 15, 2021 at 12:25:55PM +0200, Hans de Goede wrote:
> On some Lenovo laptops the base-addrsss of some PCI devices is left
> at 0 at boot:
> 
> [    0.283145] pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
> [    0.283217] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> [    0.285117] pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
> [    0.285189] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]

s/base-addrsss/base-address/
Timestamps aren't relevant here and can be trimmed.

It's not really an error if BIOS leaves a PCI BAR unprogrammed.

> There is a _CRS method for these devices, which simply returns the
> configured 0 address. This is causing the PCI core to not assign
> memory to these PCI devices and is causing these errors:
> 
> [    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
> [    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
> [    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
> [    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]

I'm confused.  Did you say there's a _CRS method for these *PCI*
devices (0000:00:15.0, 0000:00:15.1)?

I suspect you mean the *host bridge* has a _CRS method, since I think
acpi_pci_root_validate_resources() is looking at contents of the host
bridge _CRS.

On x86, it would likely be a BIOS defect is a host bridge _CRS had a
memory window starting at 0, but you didn't show what _CRS contained.

The dmesg at https://bugzilla.redhat.com/show_bug.cgi?id=1871793 shows
this, which looks totally normal and should be unaffected by the patch
since there's no memory window starting at 0:

  pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
  pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0x6d400000-0xbfffffff window]

The ones at https://bugzilla.redhat.com/show_bug.cgi?id=1868899 and
https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
are similar, so I can't quite connect the dots here.

> This happens specifically for the designware I2C PCI devices on these
> laptops, causing I2C-HID attached touchpads/touchscreens to not work.
> 
> Booting with nocrs on these devices results in the kernel itself
> assigning memory to these devices, fixing things:

"pci=nocrs" to help people repro this or try the same workaround
elsewhere.

> [    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
> [    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]
> 
> At least the following models are known to be affected by this (but there
> might be more):
> 
> Lenovo IdeaPad 3 15IIL05 81WE
> Lenovo IdeaPad 5 14IIL05 81YH
> 
> Add an extra check for the base-address being 0 to
> acpi_pci_root_validate_resources() and reject IOMEM resources where this
> is the case, to fix this issue.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note we could instead add the known to be affected models to the
> pci_crs_quirks table in arch/x86/pci/acpi.c, but it is likely that more
> systems are affected and a more generic fix seems better in general.

Definitely good to avoid pci_crs_quirks[] because throwing away _CRS
completely leads us into uncharted waters, especially for multi-host
bridge systems that support hotplug.

> ---
>  drivers/acpi/pci_root.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index dcd593766a64..6cd2ca551005 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -686,6 +686,13 @@ static void acpi_pci_root_validate_resources(struct device *dev,
>  		if (!(res1->flags & type))
>  			goto next;
>  
> +		if ((type & IORESOURCE_MEM) && res1->start == 0) {
> +			dev_info(dev, "host bridge window %pR (ignored, start address not set)\n",
> +				 res1);
> +			free = true;
> +			goto next;
> +		}
> +
>  		/* Exclude non-addressable range or non-addressable portion */
>  		end = min(res1->end, root->end);
>  		if (end <= res1->start) {
> -- 
> 2.31.1
> 
