Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5B5E8AB9
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 11:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiIXJYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 05:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiIXJYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 05:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8854D13943C;
        Sat, 24 Sep 2022 02:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24BFD60DED;
        Sat, 24 Sep 2022 09:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F4EC433D7;
        Sat, 24 Sep 2022 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664011461;
        bh=0Fp5N+iuPZzD55S6xZwszO0M3jKrv7PY7Rm1eU+7P/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbM0PyTK/gMt2I+LcMA2scxDkGfXA2p1sqxnfd+fvtl4n6LErlBWm9qYvjh75kAUg
         jaL574qzcen/zHqZrC8pOlRltL/0mhRKSRNIgjRMGlEVx6xAT/IsKthij5P/515W+k
         ySlLDPVvU4Eg5ZnGLGzcJQoxiRk4GZkXT8xRpI0iYOadAY/lX3BlDrqPTja/yJqoJd
         m1JM9tB4vwan4EQ9PJVzNy6ob0RJQgT2E/7dNHmpVI5bWRoXE1ZcvZu046iAoObx8/
         9NbBCYmmkbzWCZxv22dqYG9r4LkNUx4nzWSyL/t030ehuH/dIFaIMisvRiHLsC6Sot
         MhltOqndg/U+A==
Received: by pali.im (Postfix)
        id CDB93127C; Sat, 24 Sep 2022 11:24:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro
Date:   Sat, 24 Sep 2022 11:24:04 +0200
Message-Id: <20220924092404.31776-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220924092404.31776-1-pali@kernel.org>
References: <20220924092404.31776-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify pcie-mt7621.c driver code and use new PCI_CONF1_EXT_ADDRESS()
macro for accessing PCIe config space.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pcie-mt7621.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 33eb37a2225c..4bd1abf26008 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -30,6 +30,8 @@
 #include <linux/reset.h>
 #include <linux/sys_soc.h>
 
+#include "../pci.h"
+
 /* MediaTek-specific configuration registers */
 #define PCIE_FTS_NUM			0x70c
 #define PCIE_FTS_NUM_MASK		GENMASK(15, 8)
@@ -120,19 +122,12 @@ static inline void pcie_port_write(struct mt7621_pcie_port *port,
 	writel_relaxed(val, port->base + reg);
 }
 
-static inline u32 mt7621_pcie_get_cfgaddr(unsigned int bus, unsigned int slot,
-					 unsigned int func, unsigned int where)
-{
-	return (((where & 0xf00) >> 8) << 24) | (bus << 16) | (slot << 11) |
-		(func << 8) | (where & 0xfc) | 0x80000000;
-}
-
 static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
 					 unsigned int devfn, int where)
 {
 	struct mt7621_pcie *pcie = bus->sysdata;
-	u32 address = mt7621_pcie_get_cfgaddr(bus->number, PCI_SLOT(devfn),
-					     PCI_FUNC(devfn), where);
+	u32 address = PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn),
+					    PCI_FUNC(devfn), where);
 
 	writel_relaxed(address, pcie->base + RALINK_PCI_CONFIG_ADDR);
 
@@ -147,7 +142,7 @@ static struct pci_ops mt7621_pcie_ops = {
 
 static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 reg)
 {
-	u32 address = mt7621_pcie_get_cfgaddr(0, dev, 0, reg);
+	u32 address = PCI_CONF1_EXT_ADDRESS(0, dev, 0, reg);
 
 	pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
 	return pcie_read(pcie, RALINK_PCI_CONFIG_DATA);
@@ -156,7 +151,7 @@ static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 reg)
 static void write_config(struct mt7621_pcie *pcie, unsigned int dev,
 			 u32 reg, u32 val)
 {
-	u32 address = mt7621_pcie_get_cfgaddr(0, dev, 0, reg);
+	u32 address = PCI_CONF1_EXT_ADDRESS(0, dev, 0, reg);
 
 	pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
 	pcie_write(pcie, val, RALINK_PCI_CONFIG_DATA);
-- 
2.20.1

