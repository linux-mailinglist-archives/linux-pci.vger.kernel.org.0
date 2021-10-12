Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5442A9CB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJLQoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhJLQoJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:44:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6E136023B;
        Tue, 12 Oct 2021 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056927;
        bh=MO9ElK6qW8fA653llwfRpuTBUH9NFIEzPdb7Xa6FnF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eotAt3cd4WtqCvgfisLLFehOxknDvWeU1PQFOA9cIsOx/J5DhXv31wI86t3Mh0Lo3
         hLbIKPO/4TlNtFa3zrl69BOowHUa7Q+G3EhFDeB6+RgO8Vt5mg/HlLWtDM7E2xnnqO
         3s08CXmya4l9AiSp2mXAGsGB9J/OwPzYpzp90bT9rE7ErtL/kvAkYKyrKCKHZ5u0eC
         RflDM1alxgxofyteoh1lMQwS56si1Oi6ts8Zm2ptDeENFFRuqjhA7ReZPT6JfKEhxf
         E8sDBWhbOTtnEoolcrVfSMPVInDSwVC9i0JCBzJ9YKl64UkHUc8aWVNtDNFGWDb10o
         rwi3qnHjm7gVg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 14/14] PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge
Date:   Tue, 12 Oct 2021 18:41:45 +0200
Message-Id: <20211012164145.14126-15-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
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
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ad31a172c5c2..5d944e57c1a6 100644
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
@@ -781,6 +782,10 @@ advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 		*value = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 		return PCI_BRIDGE_EMUL_HANDLED;
 
+	case PCI_ROM_ADDRESS1:
+		*value = advk_readl(pcie, PCIE_CORE_EXP_ROM_BAR_REG);
+		return PCI_BRIDGE_EMUL_HANDLED;
+
 	case PCI_INTERRUPT_LINE: {
 		/*
 		 * From the whole 32bit register we support reading from HW only
@@ -813,6 +818,10 @@ advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
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

