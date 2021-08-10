Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A643E579B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 11:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbhHJJ4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 05:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239292AbhHJJ4K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C29D61163;
        Tue, 10 Aug 2021 09:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628589349;
        bh=sV+bbSB/ojGgth+jvILzvzxrJl5qHKm76Hwybjb+ZWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goRCDJKOwPnTUeJZEGOin6pq5ASpAvbfWsjKUhK6GTi6y9iM8f8hZ2A/ntLbImFdS
         2tPhIE0lmpDf9amN+EzxOep+WfIlE+PoNNV7JWI6fD6yBWr0AUiIqzgy8KGLIb1oSv
         kxOfQBL78lRpqt1WV/8SdaWVq/GP8y14E7Gby270GiLXywYHJPndiqBEyitHYS0c2D
         2CXTkOJCD9wPbxv8MzvgOWZ3EmcX9D9LgxYiQprlHqSsOgmo12X+i3ndMsX/oPX/v/
         6kChbf4VKMO09r9V1+JrqRTlSN6Yb1VekIo8cY2IYv2kZNcGNgTdv1dahz84ZYbWnV
         PJ+uEnalduqJg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mDOU6-00AcGB-3M; Tue, 10 Aug 2021 11:55:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v10 10/11] PCI: kirin: fix poweroff sequence
Date:   Tue, 10 Aug 2021 11:55:41 +0200
Message-Id: <f00ba179a59c308bb608cbce7e2e89522d8dd1c4.1628589155.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628589155.git.mchehab+huawei@kernel.org>
References: <cover.1628589155.git.mchehab+huawei@kernel.org>
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
index 21453d21ebad..5535605ab1e7 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -678,6 +678,23 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
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
@@ -723,12 +740,7 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 
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
@@ -737,11 +749,9 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
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

