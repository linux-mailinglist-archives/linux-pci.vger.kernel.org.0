Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2C73E1040
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhHEI3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 04:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234559AbhHEI3W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 04:29:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16DD260EBC;
        Thu,  5 Aug 2021 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628152149;
        bh=UrIWFc7afenUxoN8+PAqdiMMD3Kbx2IdAKavVf2zlSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5lv+kSHXKU6RGsELotrmJvaldo8hI2Thnc77w6J2D5e0vBKMHiljyJll3LtD09or
         Lxr/ku4Dbl9L2mH2I+AIHk6JTVSR6J/+Ezx8HqXGFKrio9SAavXw2QdHIK67Ge0gKe
         QZV69x0UKi5exEzw8CmigU64xljgbivOINeFjSgIyjawtx2wdyRAYqMO56qgPZTiBm
         dhYeIiRVVFQ2Jg9t6vK/YXWw4O4kV7vWJdmkZ+P2Ce+6HuNMP72btrPvraLg9Ugz9r
         aZvNXkvPSsHYemWAJX3OnjsjLPbVBfMK6QYoWCEeeIQm4/RN1q0XK2mOjaXszOtyYF
         Y4GeSXmXKijow==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBYkP-001DuV-Sg; Thu, 05 Aug 2021 10:29:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: of: Fix handling of multi-level PCI devices
Date:   Thu,  5 Aug 2021 10:28:58 +0200
Message-Id: <3365235394fe4e7f35694c95af95fce96da7c9bb.1628151761.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628151760.git.mchehab+huawei@kernel.org>
References: <cover.1628151760.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the DT schema is like:

	pcie@f4000000 {
		pcie@0,0 {
			pcie@1,0 {
			};
			pcie@5,0 {
			};
			pcie@7,0 {
			};
		};
	};

The logic under pci_set_bus_of_node() will try to setup some
buses with a NULL node, causing it to register just a small
set of devices:

	$ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
	/sys/devices/platform/soc/f4000000.pcie/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node

On such case, it needs to go to the parent node, in order to register
everything:

	$ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
	/sys/devices/platform/soc/f4000000.pcie/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/pci_bus/0000:06/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/pci_bus/0000:02/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/pci_bus/0000:05/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/pci_bus/0000:03/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node

Adding some debug prints with such change will produce the following
output:

	$ dmesg|grep of_node
	[    4.932405]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
	[    4.985916] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
	[    5.014190] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.065680] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.118754] pci_bus 0000:02: pci_set_bus_of_node: use of_node of the parent
	[    5.135279] pci_bus 0000:02: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.158921] pci 0000:02:01.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.187393] pci 0000:02:04.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.215982] pci 0000:02:05.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.244607] pci 0000:02:07.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.272825] pci 0000:02:09.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
	[    5.335258] pci_bus 0000:03: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@1,0
	[    5.367538] pci 0000:03:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@1,0
	[    5.415959] pci_bus 0000:04: pci_set_bus_of_node: use of_node of the parent
	[    5.424190] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
	[    5.438727] pci_bus 0000:05: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@5,0
	[    5.455691] pci_bus 0000:06: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@7,0
	[    5.491643] pci 0000:06:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@7,0
	[    5.526157] pci_bus 0000:07: pci_set_bus_of_node: use of_node of the parent
	[    5.534361] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a143b02b2dcd..b6fa3bd46ae6 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -41,6 +41,8 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 		node = pcibios_get_phb_of_node(bus);
 	} else {
 		node = of_node_get(bus->self->dev.of_node);
+		if (!node)
+			node = of_node_get(bus->self->dev.parent->of_node);
 		if (node && of_property_read_bool(node, "external-facing"))
 			bus->self->external_facing = true;
 	}
-- 
2.31.1

