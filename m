Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E263847B403
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 20:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhLTTzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 14:55:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52230 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhLTTy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 14:54:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36DEDB8108E
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 19:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CCCC36AE2;
        Mon, 20 Dec 2021 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640030094;
        bh=EMaM0ApemCfwkgpUFdNlja/TwJ5ENAYRrxLTlkI3xOM=;
        h=From:To:Subject:Date:From;
        b=Dhjxf1dFIOt2d2NAchFyrccXQUq/ACe8q23/JbVHkD02CNKXQR8UeIGhkCUM05EAX
         L95/SmF6u2DY4gAoJ4Dl+JDH4BR1YJwzSjJ76HvCCHVCY67UTxrijWNezpgb9cMNPQ
         +Ull5Dn552ju3kAp+tJxYuZDjQ+/1MLu43Q558X071WkipAoaGKZzsq76hpnSps1Zq
         2gZCZO0eny8VJ/AnvfbkGbjkwlqX1dPTRs5WWsPED4+rnvzEEXONHuflkqoKRQ36e+
         7GEWhiK+NeKffwPu0bL4kw+KB4D+GuNuVGf5Vn716VHy7KEg58VRdQnU/tyG3NNf6Y
         OFGtn4j9lFzuA==
Received: by pali.im (Postfix)
        id 65B5787B; Mon, 20 Dec 2021 20:54:51 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils] lspci: Print buses of multibus PCI domain in ascending order
Date:   Mon, 20 Dec 2021 20:53:49 +0100
Message-Id: <20211220195349.16316-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently PCI domains are printed in ascending order. Devices on each PCI
bus are also printed in ascending order. PCI buses behind PCI-to-PCI
bridges are also printed in ascending order.

But buses of PCI domain are currently printed in descending order because
function new_bus() puts newly created bus at the beginning of linked list.

In most cases PCI domain contains only one (top level) bus, so in most
cases it is not visible this inconsistency.

Multibus PCI domains (where PCI domain contains more independent top level
PCI buses) are available on ARM devices.

This change fixes print order of multibus PCI domains, so also top level
PCI buses are printed in ascending order, like PCI buses behind PCI-to-PCI
bridges.
---
 ls-tree.c | 10 +++++++---
 lspci.h   |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/ls-tree.c b/ls-tree.c
index aeb40870865e..17a95307b3fa 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -12,7 +12,7 @@
 
 #include "lspci.h"
 
-struct bridge host_bridge = { NULL, NULL, NULL, NULL, 0, ~0, 0, ~0, NULL };
+struct bridge host_bridge = { NULL, NULL, NULL, NULL, NULL, 0, ~0, 0, ~0, NULL };
 
 static struct bus *
 find_bus(struct bridge *b, unsigned int domain, unsigned int n)
@@ -31,11 +31,14 @@ new_bus(struct bridge *b, unsigned int domain, unsigned int n)
   struct bus *bus = xmalloc(sizeof(struct bus));
   bus->domain = domain;
   bus->number = n;
-  bus->sibling = b->first_bus;
   bus->first_dev = NULL;
   bus->last_dev = &bus->first_dev;
   bus->parent_bridge = b;
-  b->first_bus = bus;
+  if (b->last_bus)
+    b->last_bus->sibling = bus;
+  b->last_bus = bus;
+  if (!b->first_bus)
+    b->first_bus = bus;
   return bus;
 }
 
@@ -101,6 +104,7 @@ grow_tree(void)
 	  last_br = &b->chain;
 	  b->next = b->child = NULL;
 	  b->first_bus = NULL;
+	  b->last_bus = NULL;
 	  b->br_dev = d;
 	  d->bridge = b;
 	  pacc->debug("Tree: bridge %04x:%02x:%02x.%d: %02x -> %02x-%02x\n",
diff --git a/lspci.h b/lspci.h
index fefee5256423..352177fcce7b 100644
--- a/lspci.h
+++ b/lspci.h
@@ -90,7 +90,7 @@ void show_kernel_cleanup(void);
 struct bridge {
   struct bridge *chain;			/* Single-linked list of bridges */
   struct bridge *next, *child;		/* Tree of bridges */
-  struct bus *first_bus;		/* List of buses connected to this bridge */
+  struct bus *first_bus, *last_bus;	/* List of buses connected to this bridge */
   unsigned int domain;
   unsigned int primary, secondary, subordinate;	/* Bus numbers */
   struct device *br_dev;
-- 
2.20.1

