Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6798E44100A
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 19:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhJaSPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 14:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhJaSPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 14:15:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EEC760FD9;
        Sun, 31 Oct 2021 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635703959;
        bh=xeJkfWErmROj9EmP/rG5eXcTOcFyWTWYURdeAcOO5mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYBsrKO3gNRsETbrpzlZjC7xlWFVLctNImvmi46DqkIEAdBXiYb37V80cxaKTm3py
         oRHVK28+pygQIzwAp23ygthMi6ePqGiDXYy8k0o7OjuSCy6DJINbWU/uQh6MElqqex
         iyVqvIpMDAgMJ0gS/2eNP0XWaQGFWTGNbj97fXc0hatA9DP/AcV2UVjTcPHmLFQldS
         +1hG5lvSq868goKRr/oZKw01UxaEP4gD1HZCl75mo0lDF77P7d/dvZFlVee7zE7wk/
         XyWLP3KYP7fmCxbVlZznRwDsiZDQKEyDLMx0leyERhO2uBZ2jutk7jmDEX7dca9aK0
         UL70CpSml5Dig==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 2/7] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
Date:   Sun, 31 Oct 2021 19:12:28 +0100
Message-Id: <20211031181233.9976-3-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211031181233.9976-1-kabel@kernel.org>
References: <20211031181233.9976-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

pci-bridge-emul driver already allocates buffer for capabilities up to the
PCI_EXP_SLTSTA2 register, but does not define bit access behavior for these
registers. Add these missing definitions.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/pci-bridge-emul.c | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index a4af1a533d71..aa3320e3c469 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -251,6 +251,45 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
 		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
 		.w1c = PCI_EXP_RTSTA_PME,
 	},
+
+	[PCI_EXP_DEVCAP2 / 4] = {
+		/* Device capabilities 2 register has reserved bits [30:27]. */
+		.ro = BIT(31) | GENMASK(26, 0),
+	},
+
+	[PCI_EXP_DEVCTL2 / 4] = {
+		/*
+		 * Device control 2 register is RW.
+		 *
+		 * Device status 2 register is reserved.
+		 */
+		.rw = GENMASK(15, 0),
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
2.32.0

