Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21D912039E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 12:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLPLSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 06:18:55 -0500
Received: from mail.sysgo.com ([176.9.12.79]:57480 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfLPLSz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 06:18:55 -0500
From:   David Engraf <david.engraf@sysgo.com>
To:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Engraf <david.engraf@sysgo.com>
Subject: [PATCH v2] PCI: tegra: Fix return value check of pm_runtime_get_sync
Date:   Mon, 16 Dec 2019 12:18:25 +0100
Message-Id: <20191216111825.28136-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216102208.GO24359@e119886-lin.cambridge.arm.com>
References: <20191216102208.GO24359@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pm_runtime_get_sync() returns the device's usage counter. This might
be >0 if the device is already powered up or CONFIG_PM is disabled.

Abort probe function on real error only.

Fixes: da76ba50963b ("PCI: tegra: Add power management support")
Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 673a1725ef38..090b632965e2 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2798,7 +2798,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
-	if (err) {
+	if (err < 0) {
 		dev_err(dev, "fail to enable pcie controller: %d\n", err);
 		goto teardown_msi;
 	}
-- 
2.17.1

