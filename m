Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5640247C202
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhLUO44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbhLUO4w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD9AC061574;
        Tue, 21 Dec 2021 06:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC886B8171C;
        Tue, 21 Dec 2021 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C20AC36AF8;
        Tue, 21 Dec 2021 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098608;
        bh=JtEZRkg2SAAc4D3UAOmtCOS7Vb63QZjN6gULYttb+eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4GjjhHppEj0/3o4n9w43Kb+FxOrJnc96/qoZoZrd0Sy+P9/K+w8rx2216ax6WUeB
         Ef7gu+sI00xV00V9wMjCAepI1BTloSMxfLRzSIcw4Nud/B0aMjLATIpJCOlPTj2bB1
         4oQKnJSUrlDmkI8nTnYPg1gh0SnJGIHDu9jDwdd8zfaLE6ihLQiDU7UYkTONMsI5ro
         56JQw55A6z6wpkZ8o1IRyi5nP9fRn0kWnsczsP6NT/R1y0GNnQLFjENX1LjyIVAyVH
         wRlXxCoXXHId8fILqFrtapXu+apIrJTXY663toSB8ODBKRn4FMH9jpR5gKmHlhyF4I
         3fiN951ufB9Gg==
Received: by pali.im (Postfix)
        id 330152857; Tue, 21 Dec 2021 15:18:13 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] PCI: pci-bridge-emul: Rename PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR to PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
Date:   Tue, 21 Dec 2021 15:14:47 +0100
Message-Id: <20211221141455.30011-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
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

So change name of this flag to be less misleading.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 drivers/pci/pci-bridge-emul.c      | 2 +-
 drivers/pci/pci-bridge-emul.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
index 0690b6369755..88877ebefbac 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -120,7 +120,7 @@ struct pci_bridge_emul {
 };
 
 enum {
-	PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR = BIT(0),
+	PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD = BIT(0),
 };
 
 int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
-- 
2.20.1

