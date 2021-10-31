Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC2441010
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 19:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhJaSPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 14:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhJaSPR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 14:15:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC552610A0;
        Sun, 31 Oct 2021 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635703965;
        bh=BNLhJywoeFLXl5q+k6L7aZxoFEFa6oZ2PA7HV2xNlwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ew8K373UsAAzGRCvYNiqhmIbuOcfEqbsO3LuU4ri88UdV8gJ58DEwHXHiEvjc6GbA
         HsqjhJWXMzXyr7bc+AIQnBYGgdL50035Q8STUI8DAGXuSBfcGOZYSTuMebVrrEguRl
         08M3MRdcWNYeSuq0T4OgqNAEhSUYzj6xlFVFHdZJyHkyEpbJZUyNuLa3mPqq+N7BJJ
         QnU/Tdwrg6me/Y2mssJ2XWo2ECgJTpWT9YV6DjlShrxKsfAnElSeNe33k981oas7bf
         mP0ly3Dy93OlxlYAgOXTKekt9ly0BOCHNX6uZ3tePWtQizt9Yw2VMdVCjWzWc/5d8+
         qHp3EUYlmLSyA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 7/7] PCI: aardvark: Reset PCIe card and disable PHY at driver unbind
Date:   Sun, 31 Oct 2021 19:12:33 +0100
Message-Id: <20211031181233.9976-8-kabel@kernel.org>
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

When unbinding driver, assert PERST# signal which prepares PCIe card for
power down. Then disable link training and PHY.

Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b3d89cb449b6..2a82c4652c28 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1737,10 +1737,22 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	/* Free config space for emulated root bridge */
 	pci_bridge_emul_cleanup(&pcie->bridge);
 
+	/* Assert PERST# signal which prepares PCIe card for power down */
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	/* Disable link training */
+	val = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	val &= ~LINK_TRAINING_EN;
+	advk_writel(pcie, val, PCIE_CORE_CTRL0_REG);
+
 	/* Disable outbound address windows mapping */
 	for (i = 0; i < OB_WIN_COUNT; i++)
 		advk_pcie_disable_ob_win(pcie, i);
 
+	/* Disable phy */
+	advk_pcie_disable_phy(pcie);
+
 	return 0;
 }
 
-- 
2.32.0

