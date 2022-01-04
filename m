Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07F4844C9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiADPi3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36470 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiADPi1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF0A614CF;
        Tue,  4 Jan 2022 15:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41E7C36AE9;
        Tue,  4 Jan 2022 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310706;
        bh=D10rA3MjwxR7qTzv97luAxovzVKA6suYoqpXAFLKS9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzpgEAElAyWzz/0nZBUIsCwel/q7ZhFrboYFoIwxEBG1KcxMn9yKT8fho2XQuWHwx
         pXR6qU4doQhumTzzA5CntyeowzznY73QsLxrxvpf3r6zDAQnYK8xf62hwzvrtIGRjE
         +kdl/z3udLQxOP1hupaWtVIs2hyRbtzCGtiPr4pz9+axBiCkCsWSimwHyGjtbhdmdb
         F46aJ+ZGMIB9lsfEy+Ub0pcyEYLFjZO6zXUxWWVc9khmVSOmRRCwC6RV8a8B4kJLpo
         gYeW3/PDnOvX/B8lyIwRzgjyoLdwRdU5wga8xfMpmt34b/gXXLWug8n+DLjWTxzeu4
         vRSEhEIbGS76Q==
Received: by pali.im (Postfix)
        id ABA8F284E; Tue,  4 Jan 2022 16:38:24 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] PCI: pci-bridge-emul: Rename PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR to PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
Date:   Tue,  4 Jan 2022 16:35:21 +0100
Message-Id: <20220104153529.31647-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This flag describe whether PCI bridge supports forwarding of prefetchable
memory requests in given range between primary and secondary buses. It does
not specify if bridge has support for prefetchable memory BAR (moreover
this pci-bridge-emul.c driver does not provide support for BARs).

So change name of this flag to be less misleading and add comment.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v2:
* Add comment into code.
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 drivers/pci/pci-bridge-emul.c      | 2 +-
 drivers/pci/pci-bridge-emul.h      | 6 +++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 2ecc1ab12249..2e10ade660a1 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -747,7 +747,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
 
-	return pci_bridge_emul_init(bridge, PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR);
+	return pci_bridge_emul_init(bridge, PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD);
 }
 
 static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 79b947528455..432b1bec2e22 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -373,7 +373,7 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 			~(BIT(10) << 16);
 	}
 
-	if (flags & PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR) {
+	if (flags & PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD) {
 		bridge->pci_regs_behavior[PCI_PREF_MEMORY_BASE / 4].ro = ~0;
 		bridge->pci_regs_behavior[PCI_PREF_MEMORY_BASE / 4].rw = 0;
 	}
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index 0690b6369755..087b5fa01bcf 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -120,7 +120,11 @@ struct pci_bridge_emul {
 };
 
 enum {
-	PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR = BIT(0),
+	/*
+	 * PCI bridge does not support forwarding of prefetchable memory
+	 * requests between primary and secondary buses.
+	 */
+	PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD = BIT(0),
 };
 
 int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
-- 
2.20.1

