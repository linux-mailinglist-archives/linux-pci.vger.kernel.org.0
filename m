Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1318E4C553D
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 11:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiBZKrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Feb 2022 05:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBZKrs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 05:47:48 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E070129C46F
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 02:47:13 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 78EC392009C; Sat, 26 Feb 2022 11:47:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6B9CA92009B;
        Sat, 26 Feb 2022 10:47:10 +0000 (GMT)
Date:   Sat, 26 Feb 2022 10:47:10 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Avoid handing out address 0 to devices
Message-ID: <alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have numerous platforms that permit assigning addresses from 0 to PCI 
devices, both in the memory and the I/O bus space, and we happily do so 
if there is no conflict, e.g.:

pci 0000:07:00.0: BAR 0: assigned [io  0x0000-0x0007]
pci 0000:07:00.1: BAR 0: assigned [io  0x0008-0x000f]
pci 0000:06:01.0: PCI bridge to [bus 07]
pci 0000:06:01.0:   bridge window [io  0x0000-0x0fff]

(with the SiFive HiFive Unmatched RISC-V board and a dual serial port 
option card based on the OxSemi OXPCIe952 device wired for the legacy 
UART mode).

Address 0 is treated specially however in many places, for example in 
`pci_iomap_range' and `pci_iomap_wc_range' we require that the start 
address is non-zero, and even if we let such an address through, then 
individual device drivers could reject a request to handle a device at 
such an address, such as in `uart_configure_port'.  Consequently given
devices configured as shown above only one is actually usable:

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial 0000:07:00.0: enabling device (0000 -> 0001)
serial: probe of 0000:07:00.0 failed with error -12
serial 0000:07:00.1: enabling device (0000 -> 0001)
serial 0000:07:00.1: detected caps 00000700 should be 00000500
0000:07:00.1: ttyS0 at I/O 0x8 (irq = 39, base_baud = 15625000) is a 16C950/954

Especially I/O space ranges are particularly valuable, because bridges 
only decode bits from 12 up and consequently where 16-bit addressing is 
in effect, as few as 16 separate ranges can be assigned to individual 
buses only.

Therefore avoid handing out address 0, however rather than bumping the 
lowest address available to PCI via PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM, 
or doing an equivalent arrangement in `__pci_assign_resource', let the 
whole range assigned to a bus start from that address and instead only 
avoid it for actual devices.  Do it in `pci_bus_alloc_from_region' then 
observing that bridge resources will have the IORESOURCE_STARTALIGN flag 
set rather than IORESOURCE_SIZEALIGN and by making the least significant 
bit decoded 1 according to the resource type, either memory or I/O.

With this in place the system in question we have:

pci 0000:07:00.0: BAR 0: assigned [io  0x0008-0x000f]
pci 0000:07:00.1: BAR 0: assigned [io  0x0010-0x0017]
pci 0000:06:01.0: PCI bridge to [bus 07]
pci 0000:06:01.0:   bridge window [io  0x0000-0x0fff]

and then devices work correctly:

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial 0000:07:00.0: enabling device (0000 -> 0001)
serial 0000:07:00.0: detected caps 00000700 should be 00000500
0000:07:00.0: ttyS0 at I/O 0x8 (irq = 38, base_baud = 15625000) is a 16C950/954
serial 0000:07:00.1: enabling device (0000 -> 0001)
serial 0000:07:00.1: detected caps 00000700 should be 00000500
0000:07:00.1: ttyS1 at I/O 0x10 (irq = 39, base_baud = 15625000) is a 16C950/954

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Hi,

 NB I have an OxSemi OXPCIe952 based card that can be wired to either the 
native or the legacy mode via a jumper block and I am so glad that I have 
checked whether it works in the legacy mode as well.  I guess there are so 
few legacy-free platforms still for nobody else to notice this issue yet.

 I think I've chosen the right solution, but I'll be happy to hear any 
suggestions for an alternative one.  Otherwise please apply.

  Maciej
---
 drivers/pci/bus.c |    9 +++++++++
 1 file changed, 9 insertions(+)

linux-pci-bus-alloc-from-region-min.diff
Index: linux-macro/drivers/pci/bus.c
===================================================================
--- linux-macro.orig/drivers/pci/bus.c
+++ linux-macro/drivers/pci/bus.c
@@ -194,6 +194,15 @@ static int pci_bus_alloc_from_region(str
 		 */
 		if (avail.start)
 			min_used = avail.start;
+		/*
+		 * For non-bridge resources avoid assigning address 0 as
+		 * we assume that to mean no assignment in many places,
+		 * starting from `pci_iomap_range'.
+		 */
+		if (min_used == 0 && (res->flags & IORESOURCE_SIZEALIGN))
+			min_used = res->flags & IORESOURCE_IO ?
+				   ~PCI_BASE_ADDRESS_IO_MASK + 1 :
+				   ~PCI_BASE_ADDRESS_MEM_MASK + 1;
 
 		max = avail.end;
 
