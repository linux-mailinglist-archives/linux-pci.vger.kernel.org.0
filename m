Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66D6A880
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 14:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfGPMOP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 08:14:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34194 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfGPMOP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 08:14:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so19712477ljg.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2019 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XXA3i8+Nc6F/Ijie1Lvzcra/IzyQeUusqyU7AWZrmic=;
        b=SnzFMNbrCkCgyi7qiZrKJbQD7kxkafz7qVBqXwa3s2K5NaF+UBfriTKd9tB4VhJ2/C
         X5CmnMdMO4afbUKB05GWYgdEu2hM+tjuiIr7G2uAuIrQOC2tEdqOk+10/D3QDanE/C6T
         QPerD+d6kTFgz/IJkGUEzgFxzMoehzvHTDxxG6n8p+TtxH44ugoQVEUd5C9sTKn5SxrU
         BAPxAQMSwDL6snPJgCmidB5UMxr0o/2BuQNQBXkqJJvYRkvLqeWNBhOOqekwj9iqUWQK
         ttOAsgIWYu06QXHZXvYsY9bh0TCNxqKO2Ci9kZ5iopWAMR8Mq1otqVP5xDw32o/DB4Rn
         YrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XXA3i8+Nc6F/Ijie1Lvzcra/IzyQeUusqyU7AWZrmic=;
        b=GUG5f6eZX2CaVJj78ymrwBkIH/DGdwiU6w60U+zn45xHMdemS5C34NFtaKmSnxv0X+
         uds8QsXiHog27tQ4tyPGX8SkfGO3U57whF6/Y0Y2G+a2//Kn/zQRET5cG4ryUwecad9D
         0Q8RK43dms9Zp8yUVhNsgf8JKUXj2BzGYYWk2QrFkFu8tIMwBTQQF9Ry8ngD4zTrsiUT
         xNvCIlzRfKpweBusIxxijPBxHA5M3Ev6F64ctdNohhbbVV+6bM9HwNxzbUPTaQTwqBEj
         RNL0U3GlzyhkECigh+lKr5Jh/2JEnki+21lU2/2GbLHY3SW59JDH4qE8ab1NmCeiugJl
         xKZQ==
X-Gm-Message-State: APjAAAVhgK2IbqXqHrD+IBAawP69HUKXWllojTQlDcJJ/1d9aqavXSCH
        ZRTBkl9UdK+mBHJXPB529X0=
X-Google-Smtp-Source: APXvYqz3kEdGglwdQalP8h2GzG09cx7pJtIcmUim+oLC17V/ZWIPIL11UHTy6oMPn8jzp+uogPIkhw==
X-Received: by 2002:a2e:868e:: with SMTP id l14mr16996805lji.16.1563279253437;
        Tue, 16 Jul 2019 05:14:13 -0700 (PDT)
Received: from gilgamesh.semihalf.com (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id z17sm3702233ljc.37.2019.07.16.05.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 05:14:12 -0700 (PDT)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [PATCH v2] PCI: pci-bridge-emul: fix big-endian support
Date:   Tue, 16 Jul 2019 14:13:46 +0200
Message-Id: <1563279226-30804-1-git-send-email-jaz@semihalf.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Perform conversion to little-endian before every write to configuration
space and converse back to cpu endianness during read. Additionally
initialise every not-byte wide fields of config space with proper
cpu_to_le* macro.

This is required since the structure describing config space of emulated
bridge assumes little-endian convention.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
v1->v2
- use __le32 and __le16 for config fields
- add missing cpu_to_le16 for pcie_conf.cap assignment
- use __le32 for cfgspace pointer
Issues with endianness were detected by Sparse tool recommended by Russell King.

 drivers/pci/pci-bridge-emul.c | 25 +++++++-------
 drivers/pci/pci-bridge-emul.h | 78 +++++++++++++++++++++----------------------
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 83fb077..cfae566 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -270,10 +270,10 @@ const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 			 unsigned int flags)
 {
-	bridge->conf.class_revision |= PCI_CLASS_BRIDGE_PCI << 16;
+	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
 	bridge->conf.cache_line_size = 0x10;
-	bridge->conf.status = PCI_STATUS_CAP_LIST;
+	bridge->conf.status = cpu_to_le16(PCI_STATUS_CAP_LIST);
 	bridge->pci_regs_behavior = kmemdup(pci_regs_behavior,
 					    sizeof(pci_regs_behavior),
 					    GFP_KERNEL);
@@ -284,8 +284,9 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
 		bridge->pcie_conf.cap_id = PCI_CAP_ID_EXP;
 		/* Set PCIe v2, root port, slot support */
-		bridge->pcie_conf.cap = PCI_EXP_TYPE_ROOT_PORT << 4 | 2 |
-			PCI_EXP_FLAGS_SLOT;
+		bridge->pcie_conf.cap =
+			cpu_to_le16(PCI_EXP_TYPE_ROOT_PORT << 4 | 2 |
+				    PCI_EXP_FLAGS_SLOT);
 		bridge->pcie_cap_regs_behavior =
 			kmemdup(pcie_cap_regs_behavior,
 				sizeof(pcie_cap_regs_behavior),
@@ -327,7 +328,7 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 	int reg = where & ~3;
 	pci_bridge_emul_read_status_t (*read_op)(struct pci_bridge_emul *bridge,
 						 int reg, u32 *value);
-	u32 *cfgspace;
+	__le32 *cfgspace;
 	const struct pci_bridge_reg_behavior *behavior;
 
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_END) {
@@ -343,11 +344,11 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
 		reg -= PCI_CAP_PCIE_START;
 		read_op = bridge->ops->read_pcie;
-		cfgspace = (u32 *) &bridge->pcie_conf;
+		cfgspace = (__le32 *) &bridge->pcie_conf;
 		behavior = bridge->pcie_cap_regs_behavior;
 	} else {
 		read_op = bridge->ops->read_base;
-		cfgspace = (u32 *) &bridge->conf;
+		cfgspace = (__le32 *) &bridge->conf;
 		behavior = bridge->pci_regs_behavior;
 	}
 
@@ -357,7 +358,7 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 		ret = PCI_BRIDGE_EMUL_NOT_HANDLED;
 
 	if (ret == PCI_BRIDGE_EMUL_NOT_HANDLED)
-		*value = cfgspace[reg / 4];
+		*value = le32_to_cpu(cfgspace[reg / 4]);
 
 	/*
 	 * Make sure we never return any reserved bit with a value
@@ -387,7 +388,7 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	int mask, ret, old, new, shift;
 	void (*write_op)(struct pci_bridge_emul *bridge, int reg,
 			 u32 old, u32 new, u32 mask);
-	u32 *cfgspace;
+	__le32 *cfgspace;
 	const struct pci_bridge_reg_behavior *behavior;
 
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_END)
@@ -414,11 +415,11 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
 		reg -= PCI_CAP_PCIE_START;
 		write_op = bridge->ops->write_pcie;
-		cfgspace = (u32 *) &bridge->pcie_conf;
+		cfgspace = (__le32 *) &bridge->pcie_conf;
 		behavior = bridge->pcie_cap_regs_behavior;
 	} else {
 		write_op = bridge->ops->write_base;
-		cfgspace = (u32 *) &bridge->conf;
+		cfgspace = (__le32 *) &bridge->conf;
 		behavior = bridge->pci_regs_behavior;
 	}
 
@@ -431,7 +432,7 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	/* Clear the W1C bits */
 	new &= ~((value << shift) & (behavior[reg / 4].w1c & mask));
 
-	cfgspace[reg / 4] = new;
+	cfgspace[reg / 4] = cpu_to_le32(new);
 
 	if (write_op)
 		write_op(bridge, reg, old, new, mask);
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index e65b1b7..b318830 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -6,65 +6,65 @@
 
 /* PCI configuration space of a PCI-to-PCI bridge. */
 struct pci_bridge_emul_conf {
-	u16 vendor;
-	u16 device;
-	u16 command;
-	u16 status;
-	u32 class_revision;
+	__le16 vendor;
+	__le16 device;
+	__le16 command;
+	__le16 status;
+	__le32 class_revision;
 	u8 cache_line_size;
 	u8 latency_timer;
 	u8 header_type;
 	u8 bist;
-	u32 bar[2];
+	__le32 bar[2];
 	u8 primary_bus;
 	u8 secondary_bus;
 	u8 subordinate_bus;
 	u8 secondary_latency_timer;
 	u8 iobase;
 	u8 iolimit;
-	u16 secondary_status;
-	u16 membase;
-	u16 memlimit;
-	u16 pref_mem_base;
-	u16 pref_mem_limit;
-	u32 prefbaseupper;
-	u32 preflimitupper;
-	u16 iobaseupper;
-	u16 iolimitupper;
+	__le16 secondary_status;
+	__le16 membase;
+	__le16 memlimit;
+	__le16 pref_mem_base;
+	__le16 pref_mem_limit;
+	__le32 prefbaseupper;
+	__le32 preflimitupper;
+	__le16 iobaseupper;
+	__le16 iolimitupper;
 	u8 capabilities_pointer;
 	u8 reserve[3];
-	u32 romaddr;
+	__le32 romaddr;
 	u8 intline;
 	u8 intpin;
-	u16 bridgectrl;
+	__le16 bridgectrl;
 };
 
 /* PCI configuration space of the PCIe capabilities */
 struct pci_bridge_emul_pcie_conf {
 	u8 cap_id;
 	u8 next;
-	u16 cap;
-	u32 devcap;
-	u16 devctl;
-	u16 devsta;
-	u32 lnkcap;
-	u16 lnkctl;
-	u16 lnksta;
-	u32 slotcap;
-	u16 slotctl;
-	u16 slotsta;
-	u16 rootctl;
-	u16 rsvd;
-	u32 rootsta;
-	u32 devcap2;
-	u16 devctl2;
-	u16 devsta2;
-	u32 lnkcap2;
-	u16 lnkctl2;
-	u16 lnksta2;
-	u32 slotcap2;
-	u16 slotctl2;
-	u16 slotsta2;
+	__le16 cap;
+	__le32 devcap;
+	__le16 devctl;
+	__le16 devsta;
+	__le32 lnkcap;
+	__le16 lnkctl;
+	__le16 lnksta;
+	__le32 slotcap;
+	__le16 slotctl;
+	__le16 slotsta;
+	__le16 rootctl;
+	__le16 rsvd;
+	__le32 rootsta;
+	__le32 devcap2;
+	__le16 devctl2;
+	__le16 devsta2;
+	__le32 lnkcap2;
+	__le16 lnkctl2;
+	__le16 lnksta2;
+	__le32 slotcap2;
+	__le16 slotctl2;
+	__le16 slotsta2;
 };
 
 struct pci_bridge_emul;
-- 
2.7.4

