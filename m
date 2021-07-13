Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69AC3C6BCC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhGMIA3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 04:00:29 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:54928
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234095AbhGMIA2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 04:00:28 -0400
Received: from localhost (1-171-212-202.dynamic-ip.hinet.net [1.171.212.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A070B405D1;
        Tue, 13 Jul 2021 07:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626163052;
        bh=WPje9vrVmS99FC+unZc7wcKC587CWYl1y9jKTIL5LQU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=JATzEs8vt9+9Bh2lS13jP9f0fbZKMqtfFNmzoqO9sfetF9moqEfy7slJf4zBFVYDo
         1xlPPHw/W4EGQm55qsbteuJmJEiw+c7YmaUMlwAglD7z1TR/uM6LBnnUBqHJsuLbVL
         gFnsIeP4+nq5NWCa2mN05P8o1sWWNhcyHfkLhS/v60AzMJJXXeFfYXU2+SyUq/j6/N
         Jq0SBublcw7oPBp8seDGrcQfUsyw6VpXMTKVFqfnmCr4gjABEZKpkvzd9gwk4ll76/
         SnjY4B8cr1ShjQ1aJG5XXeuJXiBFFBKjEDwZACWQrgJ/fDXpNs4OSmhzEgBuIvC8CC
         EZuS4EY5gDSfQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] PCI: Coalesce host bridge contiguous apertures without sorting
Date:   Tue, 13 Jul 2021 15:57:25 +0800
Message-Id: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 65db04053efe ("PCI: Coalesce host bridge contiguous apertures")
sorts the resources by address so the resources can be swapped.

Before:
PCI host bridge to bus 0002:00
pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])

And after:
PCI host bridge to bus 0002:00
pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])

However, the sorted resources make NVMe stops working on QEMU ppc:sam460ex.

Resources in the original issue are already in ascending order:
pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]

So remove the sorting part to resolve the issue.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 65db04053efe ("PCI: Coalesce host bridge contiguous apertures")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/probe.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880..5de157600466 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -877,11 +877,11 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
-	struct resource_entry *window, *n;
+	struct resource_entry *window, *next, *n;
 	struct pci_bus *bus, *b;
-	resource_size_t offset;
+	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
-	struct resource *res;
+	struct resource *res, *next_res;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -961,11 +961,34 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Coalesce contiguous windows */
+	resource_list_for_each_entry_safe(window, n, &resources) {
+		if (list_is_last(&window->node, &resources))
+			break;
+
+		next = list_next_entry(window, node);
+		offset = window->offset;
+		res = window->res;
+		next_offset = next->offset;
+		next_res = next->res;
+
+		if (res->flags != next_res->flags || offset != next_offset)
+			continue;
+
+		if (res->end + 1 == next_res->start) {
+			next_res->start = res->start;
+			res->flags = res->start = res->end = 0;
+		}
+	}
+
 	/* Add initial resources to the bus */
 	resource_list_for_each_entry_safe(window, n, &resources) {
-		list_move_tail(&window->node, &bridge->windows);
 		offset = window->offset;
 		res = window->res;
+		if (!res->end)
+			continue;
+
+		list_move_tail(&window->node, &bridge->windows);
 
 		if (res->flags & IORESOURCE_BUS)
 			pci_bus_insert_busn_res(bus, bus->number, res->end);
-- 
2.31.1

