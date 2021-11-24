Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9F45C967
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347763AbhKXQD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 11:03:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347777AbhKXQDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 494206101D;
        Wed, 24 Nov 2021 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637769614;
        bh=6nh8zjZtcpIhfBiumlERVoJoZll85DpIcGq0XAKzG+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfEFrCDRvU33tenf8KxZlvtZQ+mWpSyHN94Y/yncZYyYfCGR9J0JmwkUN1giEFVBj
         oqbHJ6aYDGM6qzJxtgbtzaFU37HHwLq5MMnYzDF7W/QZ5AS587RNOolSBJi3eDiyby
         ghylm9LHFHwQTVCEEOaFs9ae10VJ+NGr24WvYdoWv3J8AAHux7M19glxcFwTxzQN36
         ur8qjGuZ8sxH34yeDYuSQauozeJG4kyJX4VYgCCLBnz4pFhs8bKk+GrxTL6k99dPsL
         nYoauRZ+K9vwalcNWVzZgzdUNrk3akvkq4h3pSWceNVHdqmuSy+Dyka8mdtWkmoJQq
         4q/X9Q94kVUqg==
Received: by pali.im (Postfix)
        id 09A8056D; Wed, 24 Nov 2021 17:00:14 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
Date:   Wed, 24 Nov 2021 16:59:41 +0100
Message-Id: <20211124155944.1290-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124155944.1290-1-pali@kernel.org>
References: <20211124155944.1290-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-bridge-emul driver already allocates buffer for capabilities up to the
PCI_EXP_SLTSTA2 register, but does not define bit access behavior for these
registers. Fix it by adding missing definitions.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Cc: stable@vger.kernel.org
---
 drivers/pci/pci-bridge-emul.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 0cbb4e3ca827..31ff7448bded 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -256,6 +256,49 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
 		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
 		.w1c = PCI_EXP_RTSTA_PME,
 	},
+
+	[PCI_EXP_DEVCAP2 / 4] = {
+		/*
+		 * Device capabilities 2 register has reserved bits [30:27].
+		 * Also bits [26:24] are reserved for non-upstream ports.
+		 */
+		.ro = BIT(31) | GENMASK(23, 0),
+	},
+
+	[PCI_EXP_DEVCTL2 / 4] = {
+		/*
+		 * Device control 2 register is RW. Bit 11 is reserved for
+		 * non-upstream ports.
+		 *
+		 * Device status 2 register is reserved.
+		 */
+		.rw = GENMASK(15, 12) | GENMASK(10, 0),
+	},
+
+	[PCI_EXP_LNKCAP2 / 4] = {
+		/* Link capabilities 2 register has reserved bits [30:25] and 0. */
+		.ro = BIT(31) | GENMASK(24, 1),
+	},
+
+	[PCI_EXP_LNKCTL2 / 4] = {
+		/*
+		 * Link control 2 register is RW.
+		 *
+		 * Link status 2 register has bits 5, 15 W1C;
+		 * bits 10, 11 reserved and others are RO.
+		 */
+		.rw = GENMASK(15, 0),
+		.w1c = (BIT(15) | BIT(5)) << 16,
+		.ro = (GENMASK(14, 12) | GENMASK(9, 6) | GENMASK(4, 0)) << 16,
+	},
+
+	[PCI_EXP_SLTCAP2 / 4] = {
+		/* Slot capabilities 2 register is reserved. */
+	},
+
+	[PCI_EXP_SLTCTL2 / 4] = {
+		/* Both Slot control 2 and Slot status 2 registers are reserved. */
+	},
 };
 
 /*
-- 
2.20.1

