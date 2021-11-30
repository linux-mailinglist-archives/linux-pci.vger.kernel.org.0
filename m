Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE295463CD4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbhK3Rcu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbhK3Rct (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4531AC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 09:29:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90E65CE1A93
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF35C53FCF;
        Tue, 30 Nov 2021 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293366;
        bh=QKgxp5XP0fXOrZg15UE5s0Lac1xd4BuKA0mGlYPKvX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTsF6tQ/zt82rb//SHOjk5ZWHFCSG0i7bf71TQSnrE1pMq+UIxkg1TOSCVWdlxyX4
         sNU9+xOGjxxSPFsDh5ByTSuGYTLC4VEPVyp3wA9f9yRwftFqS+YIj1ocwmaEny/Ho3
         z/xDIxNk7/g5PyfGwliCkM2Ppvp4ldYJvUJsKSzfS5VSbp+fGH4SOAkF6td4eIj1Ip
         gWuZEs4plbIh/dkK5ljvo4AArLtVnBX/s2dA0TL6n+A+kBAbAyj5Wz9GLb6XRh0suP
         JsU+lguFFLG1I47oFEMdXj9cW3SnZYbVouO9EEstlre5qbHb61o1i6b5yj1TxXQDNK
         BEk1yk4cLM/IA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 06/11] PCI: aardvark: Disable bus mastering when unbinding driver
Date:   Tue, 30 Nov 2021 18:29:08 +0100
Message-Id: <20211130172913.9727-7-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130172913.9727-1-kabel@kernel.org>
References: <20211130172913.9727-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Ensure that after driver unbind PCIe cards are not able to forward
memory and I/O requests in the upstream direction.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 6348584c33be..12eae05f3d10 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1695,6 +1695,7 @@ static int advk_pcie_remove(struct platform_device *pdev)
 {
 	struct advk_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	u32 val;
 	int i;
 
 	/* Remove PCI bus with all devices */
@@ -1703,6 +1704,11 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(bridge->bus);
 	pci_unlock_rescan_remove();
 
+	/* Disable Root Bridge I/O space, memory space and bus mastering */
+	val = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
+	val &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+	advk_writel(pcie, val, PCIE_CORE_CMD_STATUS_REG);
+
 	/* Remove IRQ domains */
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
-- 
2.32.0

