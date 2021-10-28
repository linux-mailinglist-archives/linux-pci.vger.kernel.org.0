Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D737243E8B7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhJ1S7j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhJ1S7i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:59:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 922B1610CA;
        Thu, 28 Oct 2021 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635447431;
        bh=0v5e9CTnatZ5QZIboPa/3Ck7k53KXq9StP9XVz31j04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7GKA/xeq39IC1dUy9IaJ6VtyrvLseUzuCcTf1UAgjnrEtryvbVEOKyv+yoWAne8e
         XGH2uGGrdcG0lHkO1F5vOdrTqU+dVy8oTjDKAAxbdTgoNDOrWAVGdi52x8gEKvVxT6
         cRluGM5XHa4xHxC3bkBgCvDG9sTRPoGn5RVTLP8jr8Feq1bMZt7LumZFOGs1wYuqnR
         kEvu2PYjx5dGDPR+C1sfcz4UbsIJVM276aiwPrYOsrSpxleb2aOyBvMhHEoBFwGPkU
         ulgNQyROi1n5TtdqoK3w8YYaZOW5NsRUrSNxPsB4w+ZqxnUxs3QUiDnkcLTqcQjb/K
         p96sI7kgxx9+A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 7/7] PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge
Date:   Thu, 28 Oct 2021 20:56:59 +0200
Message-Id: <20211028185659.20329-8-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211028185659.20329-1-kabel@kernel.org>
References: <20211028185659.20329-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

This register is exported at address offset 0x30.

Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index c3b725afa11f..c5300d49807a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -32,6 +32,7 @@
 #define PCIE_CORE_DEV_ID_REG					0x0
 #define PCIE_CORE_CMD_STATUS_REG				0x4
 #define PCIE_CORE_DEV_REV_REG					0x8
+#define PCIE_CORE_EXP_ROM_BAR_REG				0x30
 #define PCIE_CORE_PCIEXP_CAP					0xc0
 #define PCIE_CORE_ERR_CAPCTL_REG				0x118
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
@@ -773,6 +774,10 @@ advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 		*value = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 		return PCI_BRIDGE_EMUL_HANDLED;
 
+	case PCI_ROM_ADDRESS1:
+		*value = advk_readl(pcie, PCIE_CORE_EXP_ROM_BAR_REG);
+		return PCI_BRIDGE_EMUL_HANDLED;
+
 	case PCI_INTERRUPT_LINE: {
 		/*
 		 * From the whole 32bit register we support reading from HW only
@@ -805,6 +810,10 @@ advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		advk_writel(pcie, new, PCIE_CORE_CMD_STATUS_REG);
 		break;
 
+	case PCI_ROM_ADDRESS1:
+		advk_writel(pcie, new, PCIE_CORE_EXP_ROM_BAR_REG);
+		break;
+
 	case PCI_INTERRUPT_LINE:
 		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
 			u32 val = advk_readl(pcie, PCIE_CORE_CTRL1_REG);
-- 
2.32.0

