Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 351925005B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 05:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfFXDsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jun 2019 23:48:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:56983 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfFXDsw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jun 2019 23:48:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5O3meqs011853;
        Sun, 23 Jun 2019 22:48:41 -0500
Message-ID: <5e8f3ba58390f0c8df8724eccc68c4ba5b4ebc57.camel@kernel.crashing.org>
Subject: pci-hyperv.c and pci_bus_assign_resources()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Dexuan Cui <decui@microsoft.com>,
        Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Date:   Mon, 24 Jun 2019 13:48:40 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Folks !

As part of my consolidation of the PCI resource survey, pci-hyperv is
getting a bit in the way, I need help understanding what exactly it
needs here when it calls pci_bus_assign_resources().

As you can see at:

https://git.kernel.org/pub/scm/linux/kernel/git/benh/pci.git/

I have removed all call sites of pci_bus_assign_resources() except that
one.

So far, as far as I understand and provided I didn't screw up, they
were all either part of a pair doing:

	pci_bus_size_bridges(bus);
	pci_bus_assign_resources(bus);

or trying to assign a single added device, or buggy controller code who
did pci_bus_assign_resources() without doing pci_bus_size_bridges()
first.

pci-hyperv is a bit of a mystery however. The call to
pci_bus_assign_resources() alone will try to assign resources to
devices but will not assign anything to bridges. So any bridge will be
left as-is. Now on x86, pcibios_fixup_bus() will call
pci_read_bridge_bases(), so any such bridge will at least get its
resources read from the hw, but not allocated (parent won't be set).

So it all a bit odd ...

What is the context here ? What may be hanging off that bus when it's
added ? Should it be calling pci_assign_unassigned_bridge_resources()
instead like other hotplug drivers do ? Something else ?

Thanks !

Cheers,
Ben.


