Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73253E0528
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhHDQD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhHDQDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 12:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B343610FD;
        Wed,  4 Aug 2021 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628092990;
        bh=UYZhcF8SdCV22LVBIEl5MSwPHs1EOM8F4GeLieaMtJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0xnPWFHD1M/eiVF9Gd/mCtDzFyz2Kmi57uKNc5BeEgoaedbeOX2m23tEFE+V1Pq3
         gBDxw+TDxOvUQu7lk3zZO/6dI/wrqeI70gJdbBvdvoNHt+XCsN/n7pA8JIJAf/3oF+
         hJNIIdgPfHon4E/JCJ7TF6J+79NWcL907YUUFcvGmSuLF2IOhc/JoI0ZNYYLEzznuX
         Zl5O13AGALhn1OCW2XyVlk3gxhplo3mzIkhP2YDYh1Byzmr6gciEhfdEvzLCTKRayA
         +UTIkKl2s+9Ub7O5QtfpFVg/pR/h+rYsHhPe7R5u/RaOo23/1863owYn7bR0oJ5/aq
         JqAsHPcilaUaQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBJMK-000Pzw-Q3; Wed, 04 Aug 2021 18:03:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v9 10/11] PCI: kirin: fix poweroff sequence
Date:   Wed,  4 Aug 2021 18:03:06 +0200
Message-Id: <2703565f2227d161bc568e63cebf706e0c3be10c.1628092716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628092716.git.mchehab+huawei@kernel.org>
References: <cover.1628092716.git.mchehab+huawei@kernel.org>
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
index b7cc0c6701e4..81fcd46d1346 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -682,6 +682,23 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
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
@@ -727,12 +744,7 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 
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
@@ -741,11 +753,9 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
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

