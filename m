Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F946346B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhK3Mjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:39:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44428 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhK3Mjv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:39:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 354CACE18FA
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF16C53FC7;
        Tue, 30 Nov 2021 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275789;
        bh=dtN3HkPg9muD4NSst+bR1T01bHdCkAPKNB1bc5rpn+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9G5fbc72CoVNK2mq4tec16KXs5ZUOh8aDzqE91OY7ES6GOmzNlkdlwXcmXA4+2uq
         4D9ZRdeFNM7A6VnVqUx0J8bC1kQKnXcLIbdNfkIK8+8cuenC+EhInl6qjMPTd4KgLF
         tjmqYLmOmV9UPhZ7q5y/CJJ0zeL1wbAT+YtbyyZ3SKAm8DfH+s3MCSgRDnmrEQkTNL
         CY5i7M3uglNXnLPPEYKCIIXv01NLlwPMPvNK7c67MmQxRYxw8/nakYgZOHqBqnKQaL
         eYVHi9TuoEAxT4m1Hv17wr2/PHbF8cV/H11+6Ddw1dSjMyuW6g8wci1i6UpEp9OQHJ
         MHy3yAGFUsOJg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 02/11] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
Date:   Tue, 30 Nov 2021 13:36:12 +0100
Message-Id: <20211130123621.23062-3-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130123621.23062-1-kabel@kernel.org>
References: <20211130123621.23062-1-kabel@kernel.org>
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

