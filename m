Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243D741A9C8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbhI1HgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 03:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239341AbhI1HgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 03:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 798C061262;
        Tue, 28 Sep 2021 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632814466;
        bh=ZR153dlsffpuvbTBi41fuDDqLuxRSHu2PWaUvSPkF4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmFH6pKHHiVCuIdHpsTFq3hOqogHtHLKwztlsIcvi2SqdtWkaVuDC9BlPFah1dlmh
         s3K/hAnNaBecn1Ax8qgzIzJYbFI2stFquHy1SZdOsm69lm9l3e+Dwx+pkSITreEGGe
         sVrFxciWo7TlB6Ef47XyaQ9FvPc1PeUKwafM5NG8XhJZQDnWV3z7mbkfvjSlstikzQ
         bb7nPpPc9f1jGrTocvC3Dc6z32IXm73aVSM21PhMgxS6D0alI1H/sv0bBJU16BGOQN
         byuIDTQchQ1kOSD73qaAzLtm6FtPKlJB8lg4x5VdwgAb4M5U110gk1DGjlGNjENntO
         or2NcVBvsYybQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mV7dA-000RQB-PA; Tue, 28 Sep 2021 09:34:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v12 10/11] PCI: kirin: fix poweroff sequence
Date:   Tue, 28 Sep 2021 09:34:20 +0200
Message-Id: <45076a6d1934590a6434a37346cb5d2b938014ed.1632814194.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632814194.git.mchehab+huawei@kernel.org>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
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

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v12 00/11] at: https://lore.kernel.org/all/cover.1632814194.git.mchehab+huawei@kernel.org/

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

