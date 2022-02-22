Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB224BFD86
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiBVPwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 10:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiBVPwK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 10:52:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ECA2AE17;
        Tue, 22 Feb 2022 07:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B02DEB81B37;
        Tue, 22 Feb 2022 15:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392CBC340EB;
        Tue, 22 Feb 2022 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645545100;
        bh=bs4sKA1maaqaqniK3RdXMmapJ3D0NuaCLXrdJTmaiaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slrw8s8pkXgN++rHQZQWx6+CqEAGEu28keg9VijmEnZFPz1fcma0IoQtSNvNU1UZk
         9EQNEXXRswvbSn4L4geX0zHP4OKcEdi8RUWoUBt/M2VqltCEqF4O3lRBEXzJqyp03h
         zMrbORmdjV6bULaY2OueKCXBpgUBWZ/hJYpTRJIwTlfseXXFuesQXoyUF58U/jkHMF
         aXDBbMLLtjxwXD7jAuvDDE27qwz7e3jE/e1H+INoAfeQhiFynN2FEZsBosy18fq8iQ
         sF1ZZGgbgwNP9gh0lJsCZHEwOjBtL8zs/GMJJodzej39QshkQqRGVqFbLuw/fbQny2
         pfkGnJhdHYw9w==
Received: by pali.im (Postfix)
        id E30E0FDB; Tue, 22 Feb 2022 16:51:39 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 06/12] PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge
Date:   Tue, 22 Feb 2022 16:50:24 +0100
Message-Id: <20220222155030.988-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222155030.988-1-pali@kernel.org>
References: <20220222155030.988-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Register with Subsystem Device/Vendor ID is at offset 0x2c. Export is via
emulated bridge.

After this change Subsystem ID is visible in lspci output at line:

  Capabilities: [40] Subsystem

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index d0a75c3b78c3..566d8382afe6 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -32,6 +32,7 @@
 #define PCIE_DEV_REV_OFF	0x0008
 #define PCIE_BAR_LO_OFF(n)	(0x0010 + ((n) << 3))
 #define PCIE_BAR_HI_OFF(n)	(0x0014 + ((n) << 3))
+#define PCIE_SSDEV_ID_OFF	0x002c
 #define PCIE_CAP_PCIEXP		0x0060
 #define PCIE_HEADER_LOG_4_OFF	0x0128
 #define PCIE_BAR_CTRL_OFF(n)	(0x1804 + (((n) - 1) * 4))
@@ -731,6 +732,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	struct pci_bridge_emul *bridge = &port->bridge;
 	u32 dev_id = mvebu_readl(port, PCIE_DEV_ID_OFF);
 	u32 dev_rev = mvebu_readl(port, PCIE_DEV_REV_OFF);
+	u32 ssdev_id = mvebu_readl(port, PCIE_SSDEV_ID_OFF);
 	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP);
 	u8 pcie_cap_ver = ((pcie_cap >> 16) & PCI_EXP_FLAGS_VERS);
 
@@ -752,6 +754,8 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	 */
 	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver);
 
+	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
+	bridge->subsystem_id = ssdev_id >> 16;
 	bridge->has_pcie = true;
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
-- 
2.20.1

