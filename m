Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED446346D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhK3Mj4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhK3Mj4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:39:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04FC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 04:36:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7E46B81916
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2E2C5831B;
        Tue, 30 Nov 2021 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275794;
        bh=vViYlN52EqJfxR0NJjT0cQXo6zwIpZwfs3rrB0XD+ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r60aU1pGG85CuCoHEy/ZAJpOTLliIeAal04P1cYgrWP1Ezkw+4qr5Wb/4Hu0jrd2T
         ukOXWTtTaDZwhPHt/VgZOGd+jj/AYRzFQU5YPzGMJXZbBFsJAFVuQJPvmF7/h0kWuo
         1zEzorU8/GQtYuHftbfC2CdSotlCTC7+F2OK2M++qO7PaHuldX5umEoax+DWVmbbEJ
         +AuqIrFeWcc3O/lKiBbp6WnMiFufbJtlfnqoP8aLu+9IDKmgQioVbpwGr5ETe6bonq
         aURF+KWuOD88w6nXlQOM7LrhMNEsWO63tIqoCJl60dfSYrxuMhQGlk4AD4TJAKrn6U
         Z1TUtcbbW6beg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 05/11] PCI: aardvark: Comment actions in driver remove method
Date:   Tue, 30 Nov 2021 13:36:15 +0100
Message-Id: <20211130123621.23062-6-kabel@kernel.org>
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

