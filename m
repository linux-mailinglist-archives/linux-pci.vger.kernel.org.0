Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1340463564
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhK3N3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbhK3N3C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:29:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2971C061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 05:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6960CB817AB
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180E8C5674A;
        Tue, 30 Nov 2021 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278741;
        bh=n5HCETooZH/CiDD+dPplikHl8cWiZOySlpjrYkny2NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+ibTXUGWN61LGZK00gA/mJQLELlcY0+zE+R1iMSRHTr53lpDUNZnDdsQdlO9IL1w
         CJ+HiCnFYORy2R8xPRPDQcKivFYj3Uj06qNk0N3gWd60hq3gMTkhx8FbvRIHX3Zao4
         qaqpe8XtiqzcEIrJbMrYnH2FCIo3OL3JGcOLd1lB42NRFJ59qqNsEJ3aqLsauwinaB
         RyQbeDOIRjOWcsoGnGiSE46oDYpgBRwkORh7UxvF0EZv+J5u13dGn8r5ZZ0oGQQ2iR
         PeatMHlCz7/mTUT2W7Lprx8EP+X6lxAlApJb3Fryx67M5zOPdbb4xcYVQXkeIZ+1ZR
         h9FOimovc8aoQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 07/11] PCI: aardvark: Mask all interrupts when unbinding driver
Date:   Tue, 30 Nov 2021 14:25:19 +0100
Message-Id: <20211130132523.28126-8-kabel@kernel.org>
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

Ensure that no interrupt can be triggered after driver unbind.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 12eae05f3d10..08b34accfe2f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1709,6 +1709,27 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	val &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 	advk_writel(pcie, val, PCIE_CORE_CMD_STATUS_REG);
 
+	/* Disable MSI */
+	val = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
+	val &= ~PCIE_CORE_CTRL2_MSI_ENABLE;
+	advk_writel(pcie, val, PCIE_CORE_CTRL2_REG);
+
+	/* Clear MSI address */
+	advk_writel(pcie, 0, PCIE_MSI_ADDR_LOW_REG);
+	advk_writel(pcie, 0, PCIE_MSI_ADDR_HIGH_REG);
+
+	/* Mask all interrupts */
+	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
+	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
+	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
+	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_MASK_REG);
+
+	/* Clear all interrupts */
+	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_STATUS_REG);
+	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
+	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
+	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
+
 	/* Remove IRQ domains */
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
-- 
2.32.0

