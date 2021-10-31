Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E958044100B
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 19:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhJaSPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 14:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhJaSPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 14:15:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB9366008E;
        Sun, 31 Oct 2021 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635703960;
        bh=9dM76M9XEIIztu5mu1NSelGDvR5GAnVYzI3VNuO0YD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hfrb1md5lGUnjPW0rjOQWbKCWcKPAHunRrqOE3eVYDtlXuqWKNphK+DrNM84KPdE9
         zF+QzW6/dXouk3j3+JjjRZDkMF8Dp/vJctAdbFBlRGEsBp5/bYLiiLT3VthKzK4l/d
         EycIhQCSRYTJrNdLYRr40Df6XH7L2LVENgfh1e0lJ/E6sACtbGeUGoCd2yAxImoTpa
         Q7OaxJQFaXaxoauyjRl0uP/yHmTuzVe3l0Qo2zCoZuBr9U55OJMXA/iJxX/+w4x1Pd
         tPoJQsOmfaEfclQjRT6LoO9BZ/aog14FeafJmlawAFZw+TzZ46iqNMz/NQR66RU5Ng
         va0gUslAaW2sw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 3/7] PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2 registers on emulated bridge
Date:   Sun, 31 Oct 2021 19:12:29 +0100
Message-Id: <20211031181233.9976-4-kabel@kernel.org>
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

PCI aardvark hardware supports access to DEVCAP2, DEVCTL2, LNKCAP2 and
LNKCTL2 configuration registers of PCIe core via PCIE_CORE_PCIEXP_CAP.
Export them via emulated software root bridge.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index c5300d49807a..25af189a1052 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -884,8 +884,13 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_CAP_LIST_ID:
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:
+	case PCI_EXP_DEVCAP2:
+	case PCI_EXP_DEVCTL2:
+	case PCI_EXP_LNKCAP2:
+	case PCI_EXP_LNKCTL2:
 		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
 		return PCI_BRIDGE_EMUL_HANDLED;
+
 	default:
 		return PCI_BRIDGE_EMUL_NOT_HANDLED;
 	}
@@ -899,10 +904,6 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	struct advk_pcie *pcie = bridge->data;
 
 	switch (reg) {
-	case PCI_EXP_DEVCTL:
-		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
-		break;
-
 	case PCI_EXP_LNKCTL:
 		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
 		if (new & PCI_EXP_LNKCTL_RL)
@@ -924,6 +925,12 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		advk_writel(pcie, new, PCIE_ISR0_REG);
 		break;
 
+	case PCI_EXP_DEVCTL:
+	case PCI_EXP_DEVCTL2:
+	case PCI_EXP_LNKCTL2:
+		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
+		break;
+
 	default:
 		break;
 	}
-- 
2.32.0

