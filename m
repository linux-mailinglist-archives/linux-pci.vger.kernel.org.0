Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A646346F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbhK3Mj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhK3Mj6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:39:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B8BC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 04:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAE4BCE199E
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AABC53FD0;
        Tue, 30 Nov 2021 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275796;
        bh=QKgxp5XP0fXOrZg15UE5s0Lac1xd4BuKA0mGlYPKvX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/go8dDMpmhSCR0SSBrV6xvsjnoA47QoPru8+H5WoDhfilnBtVw+BTwMFygk5ac+n
         4x3jAk6kBxryjhPT+Sdx/B2EWJvVpYoQyzGF247LxlgxecHm6ZHIWIq9JvugcYLyVU
         ja2aEyHG0bqBgJq1kIYYTMDGbhW9eeIdGsxivMwVWGyfhOAWWiEaADkIwgYWPjo8Cx
         Ds0hvUvc0YC67NgC37j49IvUCH8a3Tem8r9iaxU6i0rLUtjRCRfZ5qHsXV19s9qM4W
         /2Y7SvzNdJeHDcohQHjejgF0EGYYGurgGuqLiY2iJtWoYMD3bXMcV/5dT+vN7OltzZ
         dZQwT3TSiU9UA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 06/11] PCI: aardvark: Disable bus mastering when unbinding driver
Date:   Tue, 30 Nov 2021 13:36:16 +0100
Message-Id: <20211130123621.23062-7-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130123621.23062-1-kabel@kernel.org>
References: <20211130123621.23062-1-kabel@kernel.org>
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

