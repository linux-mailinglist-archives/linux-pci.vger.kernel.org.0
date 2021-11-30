Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF612463CCF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhK3Rcm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbhK3Rcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C1EC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 09:29:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEEF4B81B16
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8709BC53FCF;
        Tue, 30 Nov 2021 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293360;
        bh=JIaOkragFbq+DbFogoWBStY5o3hFY6NzgpCpzH3ttY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QD0TFyoHFLzt1FRNBqUnDHx0FPLN/lc5kOQNGZJZ9e34LnSpRFDmf5093LO3GqDlp
         Uk0KtvSuYoluMohSBdPpSE9nkwSzRiQe11dA2vMPifskQbluZr3J7Cs9HSZylPYYUi
         UEj8MZL6FNu66avavPNpASvPxikU+nMwfOOB0i5LgxY86kzWUDdnZkixiYSKfFMtJN
         sl8DKfKk+n4gBHktN9tJzNOWsr8qRzp6m5x6D1aYfyIdYVUlTSywtWTjCv05A7NIKm
         ZEnnMN0/qw1FJ3kDOaW80o+dj8rf+ZDB8OLm5IM+voaqbVK1aN/5qgI16B36T8JBT/
         FziNMInojZKlQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 02/11] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
Date:   Tue, 30 Nov 2021 18:29:04 +0100
Message-Id: <20211130172913.9727-3-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130172913.9727-1-kabel@kernel.org>
References: <20211130172913.9727-1-kabel@kernel.org>
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
---
 drivers/pci/pci-bridge-emul.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index a4af1a533d71..0d1177e52a43 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -251,6 +251,49 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
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
2.32.0

