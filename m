Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02B3EA01F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 10:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhHLIDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 04:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234960AbhHLIC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 04:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A314E610CC;
        Thu, 12 Aug 2021 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628755345;
        bh=RPX+4jqm8/pHsXXIYMlEzx5E+IcposR5Ik7+q1oB6l8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJGgoKtKyz1Pp/wi6muR+nMyErT6HUaXGSwG8S5qKdT3WvWwOswPcClDkbcqoX/2E
         ZJC6PPrJAoRvSkV9yIEbZTcuGe4v5o5A1WCauKP7snoMv4xx0lHAUuHJIzCK9LaW09
         K6JHwiWD0LHrXuYZ3g8eI40U/NYenzv15bBLRgtwL8ol5EHgi4wwm3f+BMZz43KGiG
         TEI28xhSYzh4/063tfNGhdxZ/c99odtqNXcFYfVjMAjbzBaSdeDCJSruC66n1h6KrS
         2LRx4v6eWjpuMoFQFRvh44SUCeK+ga6U8aLM1RKI9QjDKkKFecG8JJ5214cNsEiMoi
         H0qCpGagUUfKw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5fT-00DZDJ-Vf; Thu, 12 Aug 2021 10:02:23 +0200
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
Subject: [PATCH v11 10/11] PCI: kirin: fix poweroff sequence
Date:   Thu, 12 Aug 2021 10:02:21 +0200
Message-Id: <26c586a5116a94099c3817b18cc859ce6d951967.1628755058.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628755058.git.mchehab+huawei@kernel.org>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
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
index b17a194cf78d..ffc63d12f8ed 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -680,6 +680,23 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
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
@@ -725,12 +742,7 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 
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
@@ -739,11 +751,9 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
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

