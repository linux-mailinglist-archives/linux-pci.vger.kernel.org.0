Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D78F49609F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiAUOX5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:23:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58864 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348447AbiAUOX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:23:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6906D6177B
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A536C340E4;
        Fri, 21 Jan 2022 14:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642775035;
        bh=/rRXL3o6paA/dIKr32VMbOl5DpJyeuJvD3889oiPYps=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KR+RXWiZYDGHX5zjua6l4va4rKIpi7xF1xCp2+VZeu2P1c1HVLV2hv7yxnB2zImCs
         0Fm5SVhEuC6SaRi5T8FpvPOICBGXifAQZVuO5oFrp3sUmuGoV5kCw+tWWoLEkn9+yb
         JINKalMBcvfqCsV2xJe1BU0B7fnoN99C+dDu88iGG+Y7YgfZkAXN1VfF8mSawFWFuZ
         rWt0JE5ldY52ziAVpul15MFWfNCicjfTXGVR9P2d7SiQ17iYulzjpHCZS8+atHz0xC
         YsPeW9u1yKmn4zTC4hlZLtb99/VWnGeQtjeqNWdpMIzYwR2TBj78tymDFqptW5SmCh
         o20QeXyxtqaDQ==
Received: by pali.im (Postfix)
        id 31D73857; Fri, 21 Jan 2022 15:23:55 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 3/4] lspci: Build tree based on PCI_FILL_PARENT information
Date:   Fri, 21 Jan 2022 15:22:57 +0100
Message-Id: <20220121142258.28170-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121142258.28170-1-pali@kernel.org>
References: <20220121142258.28170-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Topology reported by system (libpci provider) may be different from
topology built based on primary/secondary/subordinate numbers from PCI
bridges by lspci.

This happens for example when some non-compliant PCI-to-PCI bridge
with Type 0 header (e.g. Marvell one) is available in the system.

So add additional edges reported by libpci when building tree in lspci.
---
 ls-tree.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 lspci.c   |  2 +-
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/ls-tree.c b/ls-tree.c
index aaa1ee99d9f2..fede581156e4 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -25,6 +25,19 @@ find_bus(struct bridge *b, unsigned int domain, unsigned int n)
   return bus;
 }
 
+static struct device *
+find_device(struct pci_dev *dd)
+{
+  struct device *d;
+
+  if (!dd)
+    return NULL;
+  for (d=first_dev; d; d=d->next)
+    if (d->dev == dd)
+      break;
+  return d;
+}
+
 static struct bus *
 new_bus(struct bridge *b, unsigned int domain, unsigned int n)
 {
@@ -47,9 +60,20 @@ static void
 insert_dev(struct device *d, struct bridge *b)
 {
   struct pci_dev *p = d->dev;
-  struct bus *bus;
+  struct device *parent = NULL;
+  struct bus *bus = NULL;
+
+  if (p->known_fields & PCI_FILL_PARENT)
+    parent = find_device(p->parent);
 
-  if (! (bus = find_bus(b, p->domain, p->bus)))
+  if (parent && parent->bridge)
+    {
+      bus = parent->bridge->first_bus;
+      if (!bus)
+        bus = new_bus(parent->bridge, p->domain, p->bus);
+    }
+
+  if (!bus && ! (bus = find_bus(b, p->domain, p->bus)))
     {
       struct bridge *c;
       for (c=b->child; c; c=c->next)
@@ -113,14 +137,47 @@ grow_tree(void)
 	    b->primary, b->secondary, b->subordinate);
 	}
     }
+
+  /* Append additional bridges reported by libpci via d->parent */
+
+  for (d=first_dev; d; d=d->next)
+    {
+      struct device *parent = NULL;
+      if (d->dev->known_fields & PCI_FILL_PARENT)
+        parent = find_device(d->dev->parent);
+      if (!parent || parent->bridge)
+        continue;
+      b = xmalloc(sizeof(struct bridge));
+      b->domain = parent->dev->domain;
+      b->primary = parent->dev->bus;
+      b->secondary = d->dev->bus;
+      /* At this stage subordinate number is unknown, so set it to secondary bus number. */
+      b->subordinate = b->secondary;
+      *last_br = b;
+      last_br = &b->chain;
+      b->next = b->child = NULL;
+      b->first_bus = NULL;
+      b->last_bus = NULL;
+      b->br_dev = parent;
+      parent->bridge = b;
+      pacc->debug("Tree: bridge %04x:%02x:%02x.%d\n", b->domain,
+        parent->dev->bus, parent->dev->dev, parent->dev->func);
+    }
   *last_br = NULL;
 
   /* Create a bridge tree */
 
   for (b=&host_bridge; b; b=b->chain)
     {
-      struct bridge *c, *best;
-      best = NULL;
+      struct device *br_dev = b->br_dev;
+      struct bridge *c, *best = NULL;
+      struct device *parent = NULL;
+
+      if (br_dev && (br_dev->dev->known_fields & PCI_FILL_PARENT))
+        parent = find_device(br_dev->dev->parent);
+      if (parent)
+        best = parent->bridge;
+      if (!best)
       for (c=&host_bridge; c; c=c->chain)
 	if (c != b && (c == &host_bridge || b->domain == c->domain) &&
 	    b->primary >= c->secondary && b->primary <= c->subordinate &&
diff --git a/lspci.c b/lspci.c
index c4e6c93bc67a..b18ccba89049 100644
--- a/lspci.c
+++ b/lspci.c
@@ -143,7 +143,7 @@ scan_device(struct pci_dev *p)
 	d->config_cached += 64;
     }
   pci_setup_cache(p, d->config, d->config_cached);
-  pci_fill_info(p, PCI_FILL_IDENT | PCI_FILL_CLASS | PCI_FILL_PROGIF | PCI_FILL_REVID | PCI_FILL_SUBSYS);
+  pci_fill_info(p, PCI_FILL_IDENT | PCI_FILL_CLASS | PCI_FILL_PROGIF | PCI_FILL_REVID | PCI_FILL_SUBSYS | (need_topology ? PCI_FILL_PARENT : 0));
   return d;
 }
 
-- 
2.20.1

