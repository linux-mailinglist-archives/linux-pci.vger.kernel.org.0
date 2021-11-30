Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA13463563
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbhK3N3B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:29:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60190 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhK3N3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:29:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA23EB817AB
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823BFC53FC1;
        Tue, 30 Nov 2021 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278739;
        bh=QKgxp5XP0fXOrZg15UE5s0Lac1xd4BuKA0mGlYPKvX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wi9H68rgolEm3L6hg0YYNPsG6IUSBe3gSN9RaY5QP1XzGlwbDCGkgGAqodzJdztAo
         GLbWz0OVhFlvxvQxhmsl7ljCi1pvzFZLKVUNTS2RAiEHEM6mH6wWVoETiCLNW/QrvV
         k5AHfu1kujklAV6co+QmX1b9zXtNh3qzu+OpAe+Z76eKi7vVE0NUdiDoQ9GOkRMCjg
         yVmqLAqhhGPh4twjISAeh2F295+NdXgQUitJDlFpnOTcjofQEhbOl//ExYOhjyOMKH
         CZ9pHph959ou8/oJeGvopPdUq1puBzsQAUCj9WrD3DnFg0+bYDUFeAvM3F0sti7igW
         00uZ98YB0UzHA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 06/11] PCI: aardvark: Disable bus mastering when unbinding driver
Date:   Tue, 30 Nov 2021 14:25:18 +0100
Message-Id: <20211130132523.28126-7-kabel@kernel.org>
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

