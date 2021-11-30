Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB9463560
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbhK3N25 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:28:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59346 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhK3N25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:28:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9FACCE16B4
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73E9C53FC7;
        Tue, 30 Nov 2021 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278735;
        bh=Zom8OJtYEZV8oJ9yPxDBKMP/73UFTt2PWS5ADcIzuzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmsJCuL016XRklQH6gUTseH83ZOboQLAitvZd5ZM8I+WsCNH5Uhi2MFxe4En47HOP
         ggbRTMIsh2S5xvsCS1fj2Xt+lcS4BbBNIu0XhwwlTgeFjEfTWeFX9U57o5vXwV7sef
         KhCBAE5Sm+PYYceJDTDbWV7yIiqjRQSM1f8fd77hCI0CksWNpJIt3nIl3CURmyJl36
         uNgYpMhvrg6sqV1skNun1LryxlqUVK44aGs4atvkKIiRYlSg5hZRiZYbSgRVc288l9
         YtNyJg6t6D/ynXPQmLF3MuKg+VnmnsA5DvfE+1kxjHxldc3TkBKqSOl016+dL49d9S
         1JoQFKqNYdY4Q==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 03/11] PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2 registers on emulated bridge
Date:   Tue, 30 Nov 2021 14:25:15 +0100
Message-Id: <20211130132523.28126-4-kabel@kernel.org>
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

PCI aardvark hardware supports access to DEVCAP2, DEVCTL2, LNKCAP2 and
LNKCTL2 configuration registers of PCIe core via PCIE_CORE_PCIEXP_CAP.
Export them via emulated software root bridge.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
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

