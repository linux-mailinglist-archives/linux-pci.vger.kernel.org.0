Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C2463562
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbhK3N3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:29:00 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59364 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbhK3N3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:29:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5D45CE177F
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7C9C53FD0;
        Tue, 30 Nov 2021 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278738;
        bh=vViYlN52EqJfxR0NJjT0cQXo6zwIpZwfs3rrB0XD+ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRv3yORkU87iKp90ENAvNcr/xQq5eCV7juCYrqcsh7aXgsX3fKwLWS757Wl13AOzn
         BLGELGhjEPZd7yMr97e/VVLaJtQbo27v3WxlG8rTL2cSGJZfmxCHDuQ5kyQfe6YrTl
         cBFkKXGb9qHl1rGwrYWB5w9T27oKBpVQ4Pk1AFDRfL1KjBbelMoWQs2JGPcDWca84q
         Hb7CriTO+kCwz7DYhWL8k7K+bWZiZN+ZSEVk3CBB9KgvBTFYLmb/y4sZYsnEX+A/Y2
         39a4yb4o71fdDiefb4qM5VCbrPttYZL032LFS/Ug1DBvZCU805dxVXLPxLOeJO8Fap
         8jeqD+taZzBow==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 05/11] PCI: aardvark: Comment actions in driver remove method
Date:   Tue, 30 Nov 2021 14:25:17 +0100
Message-Id: <20211130132523.28126-6-kabel@kernel.org>
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

Add two more comments into the advk_pcie_remove() method.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 71ce9f02d596..6348584c33be 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1697,11 +1697,13 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int i;
 
+	/* Remove PCI bus with all devices */
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
 	pci_unlock_rescan_remove();
 
+	/* Remove IRQ domains */
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
-- 
2.32.0

