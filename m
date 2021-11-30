Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C5E463566
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbhK3N3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhK3N3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:29:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E1C061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 05:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18081CE198C
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31444C53FD5;
        Tue, 30 Nov 2021 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278744;
        bh=TfTi0hXpg38k3rRmwzOE2Jq1Mv1AbNIgyBJe+EvewW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=INLf11PeIATajohTwFXR8bY4/d7ga+lvCAGfqVDhQbIfv4W0xg6C71vxUyIsMnzhj
         FlcSqGsErJYXwDCo3Dl5RjtwxQDf3MI6RJK+pPL4NXMK6V9EazFX6RaUthfKL6DZWg
         UMlxzAmFciry/TL6NrILPMr7CwZ1cK1/c3O3b1TqpMsVD8bDL3D3lQAWFw6mbAMNGF
         ldg7IUYVtz5mmZupGTpC1s1Yg4lp/nHyTQtaA9u4iyEty0+xt1LG2G2Vx61TOjGJz+
         UHzsgPSAcpYjRpRGjchG2oAsbXmd6kq0wGru7GPm6W4QZRmcD6+fKc1k59pE73JCPK
         pC5HcS0fIi3DA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 09/11] PCI: aardvark: Assert PERST# when unbinding driver
Date:   Tue, 30 Nov 2021 14:25:21 +0100
Message-Id: <20211130132523.28126-10-kabel@kernel.org>
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

Put the PCIe card into reset by asserting PERST# signal when unbinding
driver.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b3d89cb449b6..271ebecee965 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1737,6 +1737,10 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	/* Free config space for emulated root bridge */
 	pci_bridge_emul_cleanup(&pcie->bridge);
 
+	/* Assert PERST# signal which prepares PCIe card for power down */
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
 	/* Disable outbound address windows mapping */
 	for (i = 0; i < OB_WIN_COUNT; i++)
 		advk_pcie_disable_ob_win(pcie, i);
-- 
2.32.0

