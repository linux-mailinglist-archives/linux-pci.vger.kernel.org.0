Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9F63DB654
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbhG3Juh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238294AbhG3Juc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BED161077;
        Fri, 30 Jul 2021 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627638627;
        bh=ukoqfl26CBpwVmmOL/beytBaSmonlOp5+JYrCjwnr8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXCYNp/1RKhqOwir2CSkGYmc1UA2AIdMV3a0/cRNZ8PnEoCE7JeMqZOtBvo4hYr88
         Xh4SdaQgXolCsvgM3Ey/91CL5JMiiIn2UjjP0jgcdi3ILCzd3tsFHHkNW4QpuzkvxZ
         5ekP8utrwzIvkxDKBYkgf53diREomSE44b6oFuhD/5HV9z1nMamVY7JCZEV5xrtMss
         ksjo9Q3TITTk3a/w7M8ikcQcZq/V9KjYQ/HqcyB3v56jM6C/QO3ZGBZviSeuRhY8kX
         Bn7GnJTSmPvmJdH9J/VUnP2G5Cc8NzqUvvpVZsJT0m8Rq1uwqjxNQc+OmvZ5DvTaq7
         PhY9ijsmjniwA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9P9t-006s4U-Jf; Fri, 30 Jul 2021 11:50:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v8 10/11] PCI: kirin: fix poweroff sequence
Date:   Fri, 30 Jul 2021 11:50:13 +0200
Message-Id: <00de31f5b43974cfa870a0eed67f7ae821475bc9.1627637745.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627637745.git.mchehab+huawei@kernel.org>
References: <cover.1627637745.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver currently doesn't call dw_pcie_host_deinit()
at the .remove() callback. This can cause an OOPS if the driver
is unbound.

While here, add a poweroff function, in order to abstract
between the internal and external PHY logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 30 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 58a993a998f3..bdf45d29cdc3 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -683,6 +683,23 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
 	.host_init = kirin_pcie_host_init,
 };
 
+static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
+{
+	int i;
+
+	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
+		return hi3660_pcie_phy_power_off(kirin_pcie);
+
+	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
+		gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
+	}
+
+	phy_power_off(kirin_pcie->phy);
+	phy_exit(kirin_pcie->phy);
+
+	return 0;
+}
+
 static int kirin_pcie_power_on(struct platform_device *pdev,
 			       struct kirin_pcie *kirin_pcie)
 {
@@ -728,12 +745,7 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 
 	return 0;
 err:
-	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY) {
-		hi3660_pcie_phy_power_off(kirin_pcie);
-	} else {
-		phy_power_off(kirin_pcie->phy);
-		phy_exit(kirin_pcie->phy);
-	}
+	kirin_pcie_power_off(kirin_pcie);
 
 	return ret;
 }
@@ -742,11 +754,9 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
 {
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
-	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
-		return hi3660_pcie_phy_power_off(kirin_pcie);
+	dw_pcie_host_deinit(&kirin_pcie->pci->pp);
 
-	phy_power_off(kirin_pcie->phy);
-	phy_exit(kirin_pcie->phy);
+	kirin_pcie_power_off(kirin_pcie);
 
 	return 0;
 }
-- 
2.31.1

