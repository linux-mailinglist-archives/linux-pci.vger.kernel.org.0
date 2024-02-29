Return-Path: <linux-pci+bounces-4231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA7C86C4FA
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0B31F26DE5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB25CDF3;
	Thu, 29 Feb 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FE6Hx8J8"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D245CDEC;
	Thu, 29 Feb 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198698; cv=none; b=uJo8FpM/wi01vJP0nCdslIBEFwfuFsjFr+nSX6RrA2VwRJTGmXLDVZjlYNiuvRnv3QcNTesq3tMXX7q8nEqkzR0jDcArq+/XwUBxdlVMv9zlngb5uV4Z8vWbvaeESQvd89cfyzRpnuTgeubIjLfx5UKB92EsFPCyaE0n3rugMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198698; c=relaxed/simple;
	bh=XZJdntqJVNSHehc3tw3MJZhLBZVBynJltmGB3n7U+yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNF7p88p4ui09DlQU81zBzPYKK5lRwukBnLyfqNuG1bqolKA00LPV86y1D9dtAfZVDj/c92xLGSxYDJ8nJDGdDBHF4ijmHvENUe73fhCd9PLJLM2vWVEB/quAHgA3eaksjRRlb2KvkU2GT+GzmbB/iofCpu3mCDz9Vj+70gkTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FE6Hx8J8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709198695;
	bh=XZJdntqJVNSHehc3tw3MJZhLBZVBynJltmGB3n7U+yE=;
	h=From:To:Cc:Subject:Date:From;
	b=FE6Hx8J82488o8NSMy1bbp1JLM8R52Ko3p7GNni4bCB77xmEPIgk44wLbS6SwVxv6
	 8+Y0yrSKNWONxg70YavAoO2hCvpM7HBGnwl0pr9RuwWu5uP7Eu/a5ivZsWLDvHgNRQ
	 X+5GQYWRjzAfEoax51YxfNJIjfe7GIo6ZF5fS3GnGLiLvTKpwE2HeI2kyVP2oGdT2a
	 yGJolz2Uy13th8ImVnm+qQOSaWBthYiwdIN1UbC34CFltTH9AQnYMS/PboDgb5q3TN
	 HDruuLr+Uwrgl46Da1blP6ukhCQojMinmmKGstfNDEtc32ddVV21KO19xHMSsbJX3f
	 7lvPlVLP7Iw/w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 53A923781FE3;
	Thu, 29 Feb 2024 09:24:54 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	nfraprado@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY reset also present
Date: Thu, 29 Feb 2024 10:24:49 +0100
Message-ID: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SoCs have two PCI-Express controllers: in the case of MT8195,
one of them is using a dedicated PHY, but the other uses a combo PHY
that is shared with USB and in that case the PHY cannot be reset
from the PCIe driver, or USB functionality will be unable to resume.

Resetting the PCIe MAC without also resetting the PHY will result in
a full system lockup at PCIe resume time and the only option to
resume operation is to hard reboot the system (with a PMIC cut-off).

To resolve this issue, check if we've got both a PHY and a MAC reset
and, if not, never assert resets at PM suspend time: in that case,
the link is still getting powered down as both the clocks and the
power domains will go down anyway.

Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v2:
 - Rebased over next-20240229

 drivers/pci/controller/pcie-mediatek-gen3.c | 25 ++++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 975b3024fb08..99b5d7a49be1 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -874,17 +874,26 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 	return err;
 }
 
-static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
+static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie, bool is_suspend)
 {
+	bool suspend_reset_supported = pcie->mac_reset && pcie->phy_reset;
+
 	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
 	pm_runtime_put_sync(pcie->dev);
 	pm_runtime_disable(pcie->dev);
-	reset_control_assert(pcie->mac_reset);
+
+	/*
+	 * Assert MAC reset only if we also got a PHY reset, otherwise
+	 * the system will lockup at PM resume time.
+	 */
+	if (is_suspend && suspend_reset_supported)
+		reset_control_assert(pcie->mac_reset);
 
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
-	reset_control_assert(pcie->phy_reset);
+	if (is_suspend && suspend_reset_supported)
+		reset_control_assert(pcie->phy_reset);
 }
 
 static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
@@ -920,7 +929,7 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	return 0;
 
 err_setup:
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, false);
 
 	return err;
 }
@@ -951,7 +960,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	err = pci_host_probe(host);
 	if (err) {
 		mtk_pcie_irq_teardown(pcie);
-		mtk_pcie_power_down(pcie);
+		mtk_pcie_power_down(pcie, false);
 		return err;
 	}
 
@@ -969,7 +978,7 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_unlock_rescan_remove();
 
 	mtk_pcie_irq_teardown(pcie);
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, false);
 }
 
 static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
@@ -1044,7 +1053,7 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 	dev_dbg(pcie->dev, "entered L2 states successfully");
 
 	mtk_pcie_irq_save(pcie);
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, true);
 
 	return 0;
 }
@@ -1060,7 +1069,7 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 
 	err = mtk_pcie_startup_port(pcie);
 	if (err) {
-		mtk_pcie_power_down(pcie);
+		mtk_pcie_power_down(pcie, false);
 		return err;
 	}
 
-- 
2.44.0


