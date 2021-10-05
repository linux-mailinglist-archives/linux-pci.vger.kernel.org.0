Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D32422FB8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhJESMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhJESME (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:12:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07FD56115B;
        Tue,  5 Oct 2021 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457414;
        bh=MKv4tXXNdeny4NQDwvD4qXZLGuW2646NI/sw0NRXWB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgWggcrE/I+hxv/OfyditxLkcvLxzFlu5NxJgy2QqwK0+XSGqeF2IZ6Dt/cqiAaWY
         UZ7I8IonZwD5LdtOQqv5BPH9ATIMIzqTyuDfQeSejCsqRJzu6MVsqDiefCj4+qFg3y
         TcQbvATRGG8pLBR3jLWVUvS+cQ0Hp/SjOO693NLYpX5fmTY1H7bw+n0LXqajkQoNHM
         EIty9LC/mV7q/hHDWoYaa+AEY1WKohF2jBe4+8nBVRU6CXblKiQ3BljZ4RdjT35a61
         XsbRBzaCjLVhdLl5+GofPavaLVgnm7Tu23ZYgGeXqhRjGeUZp9AeXhaZoSplNQUq7P
         lZJgNy/v5vyMQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 13/13] PCI: aardvark: Fix reporting Data Link Layer Link Active
Date:   Tue,  5 Oct 2021 20:09:52 +0200
Message-Id: <20211005180952.6812-14-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Add support for reporting PCI_EXP_LNKSTA_DLLLA bit in Link Control register
on emulated bridge via current LTSSM state. Also correctly indicate DLLLA
capability via PCI_EXP_LNKCAP_DLLLARC bit in Link Control Capability
register.

Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index f831f7d197bd..10476c00b312 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -317,6 +317,20 @@ static inline bool advk_pcie_link_up(struct advk_pcie *pcie)
 	return ltssm_state >= LTSSM_L0 && ltssm_state < LTSSM_DISABLED;
 }
 
+static inline bool advk_pcie_link_active(struct advk_pcie *pcie)
+{
+	/*
+	 * According to PCIe Base specification 3.0, Table 4-14: Link
+	 * Status Mapped to the LTSSM, and 4.2.6.3.6 Configuration.Idle
+	 * is Link Up mapped to LTSSM Configuration.Idle, Recovery, L0,
+	 * L0s, L1 and L2 states. And according to 3.2.1. Data Link
+	 * Control and Management State Machine Rules is DL Up status
+	 * reported in DL Active state.
+	 */
+	u8 ltssm_state = advk_pcie_ltssm_state(pcie);
+	return ltssm_state >= LTSSM_CONFIG_IDLE && ltssm_state < LTSSM_DISABLED;
+}
+
 static inline bool advk_pcie_link_training(struct advk_pcie *pcie)
 {
 	/*
@@ -766,12 +780,26 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
+	case PCI_EXP_LNKCAP: {
+		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
+		/*
+		 * PCI_EXP_LNKCAP_DLLLARC bit is hardwired in aardvark HW to 0.
+		 * But support for PCI_EXP_LNKSTA_DLLLA is emulated via ltssm
+		 * state so explicitly enable PCI_EXP_LNKCAP_DLLLARC flag.
+		 */
+		val |= PCI_EXP_LNKCAP_DLLLARC;
+		*value = val;
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
 	case PCI_EXP_LNKCTL: {
 		/* u32 contains both PCI_EXP_LNKCTL and PCI_EXP_LNKSTA */
 		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) &
 			~(PCI_EXP_LNKSTA_LT << 16);
 		if (advk_pcie_link_training(pcie))
 			val |= (PCI_EXP_LNKSTA_LT << 16);
+		if (advk_pcie_link_active(pcie))
+			val |= (PCI_EXP_LNKSTA_DLLLA << 16);
 		*value = val;
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
@@ -779,7 +807,6 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_CAP_LIST_ID:
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:
-	case PCI_EXP_LNKCAP:
 		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
 		return PCI_BRIDGE_EMUL_HANDLED;
 	default:
-- 
2.32.0

