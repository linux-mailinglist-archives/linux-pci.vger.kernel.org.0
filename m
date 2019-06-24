Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABEE50539
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfFXJOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 05:14:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:44050 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfFXJOC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 05:14:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5O9DmxQ024023;
        Mon, 24 Jun 2019 04:13:49 -0500
Message-ID: <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
Subject: Multitude of resource assignment functions
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Mon, 24 Jun 2019 19:13:48 +1000
In-Reply-To: <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
         <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
         <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So I'm staring at these three mostly at this point:

void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
void pci_assign_unassigned_bus_resources(struct pci_bus *bus)

Now we have 3 functions that fundamentally have the same purpose,
assign what was left unassigned down a PCI hierarchy, but are going
about it in quite a different manner.

Now to make things worse, there's little consistency in which one gets
called where. We have PCI controllers calling the first one sometimes,
the last one sometimes, or doing the manual:

	pci_bus_size_bridges(bus);
	pci_bus_assign_resources(bus);

Or variants with pci_bus_size_bridges sometimes missing etc...

Now I've consolidated a lot of that and removed all of those "manual"
cases in my work-in-progress branch, but I'd like to clarify and
possibly remove the 3 ones above.

Let's start with the last one, pci_assign_unassigned_bus_resources, as
it's the easiest to remove from users in drivers/pci/controller/* (and
replace with pci_assign_unassigned_root_bus_resources typically).

This leaves it used in a couple of corner cases, most of them I think
I can kill, and .... sysfs 'rescan'.

The interesting thing about that function is that it tries to avoid
resizing the bridge of the bus passed as an argument, it will only
resize subordinate bridges. From the changelog it was created for
hotplug bridges, but almost none uses it (some powerpc stuff I can
probably kill) ... and sysfs rescan.

I wonder what's the remaining purpose of it. sysfs rescan could
probably be cleaned up to use the two first... Also why avoid resizing
the bridge itself ?

That leads to the difference between
pci_assign_unassigned_root_bus_resources()
and pci_assign_unassigned_bridge_resources().

The names are misleading. The former isn't just about the root bus
resources. It's about the entire tree underneath the root bus.

The main difference that I can tell are:

 - pci_assign_unassigned_root_bus_resources() may or may not try to
realloc, depending on a combination of command line args, config
option, presence of IOV devices etc... while
pci_assign_unassigned_bridge_resources() always will

 - pci_assign_unassigned_bridge_resources() will call
pci_bridge_distribute_available_resources() to distribute resource to
child hotplug bridges, while pci_assign_unassigned_root_bus_resources()
won't.

Now, are we 100% confident we want to keep those discrepancies ?

It feels like the former function is intended for boot time resource
allocation, and the latter for hotplug, but I can't make sense of why
the resources of a device behind a hotplug bridge should be allocated
differently depending on whether that device was plugged at boot or
plugged later.

Also why not distribute available resources at boot between top level
hotplug bridges ?

I'm not even going into the question of why the resource
sizing/assignment code is so obscure/cryptic/incomprehensible, that's
another kettle of fish, but I'd like to at least clarify the usage
patterns a bit better.

Cheers,
Ben.



