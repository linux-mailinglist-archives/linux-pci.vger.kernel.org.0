Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6060D19699D
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 22:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgC1Vv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 17:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgC1Vv0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 17:51:26 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0621B20732;
        Sat, 28 Mar 2020 21:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585432285;
        bh=8h5MsYYWkNcSL4OubFDXcc0F978HmedvepZsUALWoEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cRDvGcQ5sKmFI1wvckXef/UmsLyDz683poYpZdmP44iYJhkeapeO/gIAQdLb0AGO1
         EybQIC+BUEGOaP2uTO8s72JhRXDklLPLrUnvx2zNt0VB2JUrXe3cxXGZNnA9M4YlFR
         ew3bvM0qnp6FBoddWJ91MN1Wm1BqKELJ+X3m8nig=
Date:   Sat, 28 Mar 2020 16:51:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Message-ID: <20200328215123.GA130140@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Stuart, Lukas]

On Fri, Feb 07, 2020 at 04:59:58PM -0700, Jon Derrick wrote:
> This set adds an emulation driver for PCIe Hotplug. There may be platforms with
> specific configurations that can support hotplug but don't provide the logical
> slot hotplug hardware. For instance, the platform may use an
> electrically-tolerant interposer between the slot and the device.
> 
> This driver utilizes the pci-bridge-emul architecture to manage register reads
> and writes. The underlying functionality of the hotplug emulation driver uses
> the Data Link Layer Link Active Reporting mechanism in a polling loop, but can
> tolerate other event sources such as AER or DPC.
> 
> When enabled and a slot is managed by the driver, all port services are managed
> by the kernel. This is done to ensure that firmware hotplug and error
> architecture does not (correctly) halt/machine check the system when hotplug is
> performed on a non-hotplug slot.
> 
> The driver offers two active mode: Auto and Force.
> auto: The driver will bind to non-hotplug slots
> force: The driver will bind to all slots and overrides the slot's services
> 
> There are three kernel params:
> pciehp.pciehp_emul_mode={off, auto, force}
> pciehp.pciehp_emul_time=<msecs polling time> (def 1000, min 100, max 60000)
> pciehp.pciehp_emul_ports=<PCI [S]BDF/ID format string>
> 
> The pciehp_emul_ports kernel parameter takes a semi-colon tokenized string
> representing PCI [S]BDFs and IDs. The pciehp_emul_mode will then be applied to
> only those slots, leaving other slots unmanaged by pciehp_emul.
> 
> The string follows the pci_dev_str_match() format:
> 
>   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
>   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> 
> When using the path format, the path for the device can be obtained
> using 'lspci -t' and further specified using the upstream bridge and the
> downstream port's device-function to be more robust against bus
> renumbering.
> 
> When using the vendor-device format, a value of '0' in any field acts as
> a wildcard for that field, matching all values.
> 
> The driver is enabled with CONFIG_HOTPLUG_PCI_PCIE_EMUL=y.
> 
> The driver should be considered 'use at own risk' unless the platform/hardware
> vendor recommends this mode.

There's a lot of good work in here, and I don't claim to understand
the use case and all the benefits.

But it seems like quite a lot of additional code and complexity in an
area that's already pretty subtle, so I'm not yet convinced that it's
all worthwhile.

It seems like this would rely on Data Link Layer Link Active
Reporting.  Is that something we could add to pciehp as a generic
feature without making a separate driver for it?  I haven't looked at
this for a while, but I would assume that if we find out that a link
went down, pciehp could/should be smart enough to notice that even if
it didn't come via the usual pciehp Slot Status path.

> Jon Derrick (9):
>   PCI: pci-bridge-emul: Update PCIe register behaviors
>   PCI: pci-bridge-emul: Eliminate reserved member
>   PCI: pci-bridge-emul: Provide a helper to set behavior
>   PCI: pciehp: Indirect slot register operations
>   PCI: Add pcie_port_slot_emulated stub
>   PCI: pciehp: Expose the poll loop to other drivers
>   PCI: Move pci_dev_str_match to search.c
>   PCI: pciehp: Add hotplug slot emulation driver
>   PCI: pciehp: Wire up pcie_port_emulate_slot and pciehp_emul
> 
>  drivers/pci/hotplug/Makefile      |   4 +
>  drivers/pci/hotplug/pciehp.h      |  28 +++
>  drivers/pci/hotplug/pciehp_emul.c | 378 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/hotplug/pciehp_hpc.c  | 136 ++++++++++----
>  drivers/pci/pci-acpi.c            |   3 +
>  drivers/pci/pci-bridge-emul.c     |  95 +++++-----
>  drivers/pci/pci-bridge-emul.h     |  10 +
>  drivers/pci/pci.c                 | 163 ----------------
>  drivers/pci/pcie/Kconfig          |  14 ++
>  drivers/pci/pcie/portdrv_core.c   |  14 +-
>  drivers/pci/probe.c               |   2 +-
>  drivers/pci/search.c              | 162 ++++++++++++++++
>  include/linux/pci.h               |   8 +
>  13 files changed, 775 insertions(+), 242 deletions(-)
>  create mode 100644 drivers/pci/hotplug/pciehp_emul.c
> 
> -- 
> 1.8.3.1
> 
