Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437AC47C1FC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhLUO4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38048 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbhLUO4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2623BB81729;
        Tue, 21 Dec 2021 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C184FC36AEA;
        Tue, 21 Dec 2021 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098607;
        bh=5rM1AcOc3PS1pgnZALHKjdSUqdfRbqAmu6E9C1EEBE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhzGxqWh6aWOldNXcCKillJ/acf4fW+XGebyC4jeQS6NYKAZAYbvjP1OiT2tTDABb
         m8gMySo1+HQa65b+yZZXGCT5ygv05Fkba1DtmWwpTC3awDhsm6jmPc1zw5KtrTddbx
         8EkeJZoPS0em1h8D8jdRJveJVZPZgQ9LtA1Tfg7A4Mc0FAZ2XrfepLfWFtkVTfE54p
         +KMF6hZUmu6JxgAljueKO3HSD9J+2WdrY4DUYq3SgKpwXql1LVgziTgdZyYh0kZZlj
         k0zh0hVKG9JSTJ3b3aGOHAH7RvKZiULo7pp5Lcu3jHr02cODSfO3J47cXJ0vIy8Otb
         L7l/UqCwMOfGA==
Received: by pali.im (Postfix)
        id AB41A2AAD; Tue, 21 Dec 2021 15:18:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] PCI: mvebu: Properly initialize vendor, device and revision of emulated bridge
Date:   Tue, 21 Dec 2021 15:14:52 +0100
Message-Id: <20211221141455.30011-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this change also PCI vendor id is read from mvebu registers.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 551f55af5226..94ef00b6d697 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -712,13 +712,14 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 {
 	unsigned int bridge_flags = PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD;
 	struct pci_bridge_emul *bridge = &port->bridge;
+	u32 dev_id = mvebu_readl(port, PCIE_DEV_ID_OFF);
+	u32 dev_rev = mvebu_readl(port, PCIE_DEV_REV_OFF);
 	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP);
 	u8 pcie_cap_ver = ((pcie_cap >> 16) & PCI_EXP_FLAGS_VERS);
 
-	bridge->conf.vendor = PCI_VENDOR_ID_MARVELL;
-	bridge->conf.device = mvebu_readl(port, PCIE_DEV_ID_OFF) >> 16;
-	bridge->conf.class_revision =
-		mvebu_readl(port, PCIE_DEV_REV_OFF) & 0xff;
+	bridge->conf.vendor = cpu_to_le16(dev_id & 0xffff);
+	bridge->conf.device = cpu_to_le16(dev_id >> 16);
+	bridge->conf.class_revision = cpu_to_le32(dev_rev & 0xff);
 
 	if (mvebu_has_ioport(port)) {
 		/* We support 32 bits I/O addressing */
-- 
2.20.1

