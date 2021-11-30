Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55E463CD2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244734AbhK3Rcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:32:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36740 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbhK3Rcq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AE53B819D9
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B26FC53FC1;
        Tue, 30 Nov 2021 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293365;
        bh=vViYlN52EqJfxR0NJjT0cQXo6zwIpZwfs3rrB0XD+ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGiZf+PFf59bmvnBydViUHRCKH5dLZSurpIfn7M1Ikqyc2igjdikJWoWMsM3n/pR1
         fRHYTtyDNWc9DV5w1HwO/CiFWo4WIin6O/URAJ3V1sooFDRNJCwiRZjujYVqIJmPJ3
         Y98oUFwIMbh9EokQxFYE9OVySrzz3TiQdJ+Va1qmMEOI8tOmmaUjpzMkOuLDP4S20o
         W7cWGjtR/gTGCr4aFP0gzi834+vgBhXALE5TY+DNlTgV2nwZ90kQLlBqKFSYv4jyJG
         XnNmsrb75BY7/tC7SVWfHxdD7xgTy+XDPQBUHbndi7ssZc1EQpHdEqGKP4t0fHi/KT
         xRBXw4/JaJ+zQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 05/11] PCI: aardvark: Comment actions in driver remove method
Date:   Tue, 30 Nov 2021 18:29:07 +0100
Message-Id: <20211130172913.9727-6-kabel@kernel.org>
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

