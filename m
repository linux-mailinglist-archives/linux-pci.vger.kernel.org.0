Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9A47D36
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfFQIfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 04:35:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:42189 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFQIfh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 04:35:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5H8ZH30015805;
        Mon, 17 Jun 2019 03:35:18 -0500
Message-ID: <bd5144fc12eeb611a85d194bbccdcac577fc6084.camel@kernel.crashing.org>
Subject: IORESOURCE_PCI_FIXES & __pci_bus_assign_resources()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-pci <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>
Date:   Mon, 17 Jun 2019 18:35:16 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi !

While working on consolidating resource assignment, I stumbled upon
something alpha does (and maybe others I haven't spotted yet):

On most platforms (not all), it uses the usual pair:

	pci_bus_size_bridges(bus);
	pci_bus_assign_resources(bus);

to reassign everything.

However, before doing so, it first calls pcibios_claim_one_bus() which,
on those platforms (ie those who don't set PCI_PROBE_ONLY), will
effectively claim only resources that have IORESOURCE_PCI_FIXED.

Now, let's leave alone for now the fact that this is will really only
work if those resources aren't behind a bridge as, to the best of my
undertanding of the code at this point, we aren't going to take them
into account when sizing & locating bridges. But that's not my point
right now :-)

From what I can tell, these days, pci_bus_assign_resources() will
already claim those fixed resources via pdev_assign_fixed_resources().

However, it does so *after* it has assigned and claimed resoures for
all the sibling devices on that bus.

That looks wrong to me. Shouldn't we claim the fixed resources first ?
IE something like:

--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1345,11 +1345,12 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 	struct pci_bus *b;
 	struct pci_dev *dev;
 
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		pdev_assign_fixed_resources(dev);
+
 	pbus_assign_resources_sorted(bus, realloc_head, fail_head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pdev_assign_fixed_resources(dev);
-
 		b = dev->subordinate;
 		if (!b)
 			continue;
?

Now, I suspect most of the time it happens to work due to the fact that
the fixed resources are generally IO resources in the legacy low ranges
( < 0x1000) and PCIBIOS_MIN_IO is *generally* set to 0x1000 but it still
sounds fishy to me.

I don't think I have HW at hand with that type of fixed stuff to test
with at the moment, so this is very much academic right now but I worry
that when I convert archs such as alpha who does that claiming before
the rest of the assignment, switching doing things the other way around
will break.

Any thoughts ?

Cheers,
Ben.
 

