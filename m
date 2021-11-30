Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2870F46355F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhK3N2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:28:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60104 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhK3N2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:28:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3EEBB819DC
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FC6C53FCD;
        Tue, 30 Nov 2021 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278733;
        bh=hCMvjw7+86olvLyyB9MzuYiqNGz70CBKEjK+jLFNK8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7PWIjlacgyLjGVDrByxL6yNv+akSYUBs4VQ1jqzs8ZX+1SdaiTMxOnJJiatBxeO1
         /n+EdaOua3sB3MEKpsyIy2bHPgrsIA3hhmymgtU1jw2vO+0S+zXDTR+QQ96JODUvHj
         nZF04ieExh1FM+gzQvwkX+8rIVAze+j+O5tuVNRkcXE+t0RlawsKtHRUTWqTplDSbg
         Z4YhosXdKMs9MwRyuwUwNrCmKapRTK88Md/jGKDWvf3blsQfkfe1D5E+M47wUAgD3E
         uyEuBMdyWpQO4mRHJ2j/7xU/sl7SL9P4RNbmr3V5QNlbIGXTnuTHwo17Mv9LsqG7gh
         jmQQ85rP3RTXg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 02/11] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
Date:   Tue, 30 Nov 2021 14:25:14 +0100
Message-Id: <20211130132523.28126-3-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130132523.28126-1-kabel@kernel.org>
References: <20211130132523.28126-1-kabel@kernel.org>
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
Changes since v2:
- updated definitions of registers PCI_EXP_DEVCAP2 and PCI_EXP_DEVCTL2
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

