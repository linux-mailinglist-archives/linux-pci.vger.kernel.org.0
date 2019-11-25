Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85034108C39
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 11:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKYKrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 05:47:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfKYKrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:15 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3dF4vDKz9sRd; Mon, 25 Nov 2019 21:47:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9d72dcef891030545f39ad386a30cf91df517fb2
In-Reply-To: <20191118065553.30362-1-oohall@gmail.com>
To:     Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-pci@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH v2] powerpc/powernv: Disable native PCIe port management
Message-Id: <47M3dF4vDKz9sRd@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:13 +1100 (AEDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-11-18 at 06:55:53 UTC, Oliver O'Halloran wrote:
> On PowerNV the PCIe topology is (currently) managed by the powernv platform
> code in Linux in cooperation with the platform firmware. Linux's native
> PCIe port service drivers operate independently of both and this can cause
> problems.
> 
> The main issue is that the portbus driver will conflict with the platform
> specific hotplug driver (pnv_php) over ownership of the MSI used to notify
> the host when a hotplug event occurs. The portbus driver claims this MSI on
> behalf of the individual port services because the same interrupt is used
> for hotplug events, PMEs (on root ports), and link bandwidth change
> notifications. The portbus driver will always claim the interrupt even if
> the individual port service drivers, such as pciehp, are compiled out.
> 
> The second, bigger, problem is that the hotplug port service driver
> fundamentally does not work on PowerNV. The platform assumes that all
> PCI devices have a corresponding arch-specific handle derived from the DT
> node for the device (pci_dn) and without one the platform will not allow
> a PCI device to be enabled. This problem is largely due to historical
> baggage, but it can't be resolved without significant re-factoring of the
> platform PCI support.
> 
> We can fix these problems in the interim by setting the
> "pcie_ports_disabled" flag during platform initialisation. The flag
> indicates the platform owns the PCIe ports which stops the portbus driver
> from being registered.
> 
> This does have the side effect of disabling all port services drivers
> that is: AER, PME, BW notifications, hotplug, and DPC. However, this is
> not a huge disadvantage on PowerNV since these services are either unused
> or handled through other means.
> 
> Cc: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9d72dcef891030545f39ad386a30cf91df517fb2

cheers
