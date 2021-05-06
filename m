Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B571375767
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhEFPfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235698AbhEFPdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50EAF61481;
        Thu,  6 May 2021 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315174;
        bh=jDjvYmJ9QZ5eFWkjBBpJHdBeKaOXh+IEdL5qMvJJIWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ngm8BGD8/2QMRyvGZYPTTe0KnFEj+I3VakCN5h9NX97TEr9LV0LzIZ9JGjnjfcu7D
         YnCNEXpvnld6/Y8lHpvxt5sJSIp7ZZouxyrTLCWDmJRvE2K+TrFYxjfOxkwlLXGGO/
         dVMsAokKeBAPHN6KL3ELgw4VnlIm3HyvVZsiE42u+605QrAwmwUSFh890Q9o9ACjX6
         BgWbgX30Ynmn6rRDqUVRO/L6gHiWg8fYQ2OL0ESL/9ynHM1fDRcZntS+2fNpRralw9
         SJy8reiyQWnBrwExdV7Ep596diKG/UDm7ujNk/hCGbqYqS1+IO5DvGFWuDJ6PFuVeQ
         SKCCuMDj1hugw==
Received: by pali.im (Postfix)
        id 081C2732; Thu,  6 May 2021 17:32:54 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 33/42] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
Date:   Thu,  6 May 2021 17:31:44 +0200
Message-Id: <20210506153153.30454-34-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
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
---
 drivers/pci/pci-bridge-emul.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 2b6ea84f25af..5f8398f8d039 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -251,6 +251,44 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
 		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
 		.w1c = PCI_EXP_RTSTA_PME,
 	},
+
+	[PCI_EXP_DEVCAP2 / 4] = {
+		/* Device capabilities 2 register has reserved bits [30:24] and [17:16]. */
+		.ro = BIT(31) | GENMASK(23, 18) | GENMASK(15, 0),
+	},
+
+	[PCI_EXP_DEVCTL2 / 4] = {
+		/*
+		 * Device control 2 register is RW but has reserved bits [12:11].
+		 *
+		 * Device status 2 register is reserved.
+		 */
+		.rw = GENMASK(15, 13) | GENMASK(10, 0),
+	},
+
+	[PCI_EXP_LNKCAP2 / 4] = {
+		/* Link capabilities 2 register has reserved bits [30:23] and 0. */
+		.ro = BIT(31) | GENMASK(22, 1),
+	},
+
+	[PCI_EXP_LNKCTL2 / 4] = {
+		/*
+		 * Link control 2 register is RW.
+		 *
+		 * Link status 2 register has bits 5, 10, 15 W1C; bit 11 reserved and others are RO.
+		 */
+		.rw = GENMASK(15, 0),
+		.w1c = (BIT(15) | BIT(10) | BIT(5)) << 16,
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

