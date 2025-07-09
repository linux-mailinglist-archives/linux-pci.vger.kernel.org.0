Return-Path: <linux-pci+bounces-31795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D2AFEDF4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 17:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84857AB443
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3F2DC352;
	Wed,  9 Jul 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JNcE7I16"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93C2D5C7B;
	Wed,  9 Jul 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075777; cv=none; b=rcxd4OO80n4UfrsJC55fL7A0NHbVnVSohowfquDY9vJkRV9iXPJz+g1Bq2Qr5FdoAU4eeqLLAvmXfNsH4JNy88hgrt0VdOkHDzOGLYGTNwsKahxPwhFbaezMacwwjWkUC/FPrcK5CZDyMyJDMNzLWzwHqxT2n+hKuQ+uuMydrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075777; c=relaxed/simple;
	bh=tUEYMrVXndgMbev/l8QfdyPcYHnAm9fF4NNVyeRWRRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hhYe8u+16coY2XlAfsoDZ5FU6U0QpRe/oOboNE3HPYL/lhkjnstO0A5FxW36t/e0TfmoO6d8xR2i/wDCpiciNar5utBJVxuVLBXBj/NsLJ23Vsq0IBz8ypCDIpM+Q7cNo1Ae/doVoLmqkj1CFwF1NPpOsV3wkkuWGX9rKYPFMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JNcE7I16; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752075767;
	bh=tUEYMrVXndgMbev/l8QfdyPcYHnAm9fF4NNVyeRWRRc=;
	h=From:Date:Subject:To:Cc:From;
	b=JNcE7I16XmWlqSqMqSItbdJ2z3/LDIwnBiZPhwkbiQqnXbIbeH3E2XgX0QEacmHWw
	 cry0B7YQ9iUkK8hgmqMd9K/a9MjtrNeasr4YQiyvg2A54BE0kQgFCphjCWtDX7qydY
	 GsHM44P3aU4FXXMsIZtvTPN+It2ol3msQzXmxIMltGaLgnfYH3iBS2TMGXRNys/Waz
	 Fk5SRzmDzYNuWfRcm7gEIMBBpL2Aqf+8I5e+V3eb39XUCSMRv287fSaPz114+iT2Jt
	 traFVtDvhsrqn7wWb1bAAqX/OGl0FKxVzP+4DfaCi08/Tfwq9a7V2dAwm4fC3dK+YS
	 kkZSKDnYCuKOA==
Received: from yukiji.home (lfbn-idf1-1-2269-27.w92-151.abo.wanadoo.fr [92.151.67.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 753A017E0F43;
	Wed,  9 Jul 2025 17:42:46 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 09 Jul 2025 17:42:21 +0200
Subject: [PATCH] PCI: mediatek-gen3: Assert MAC Reset only for a delay
 during PM suspend sequence
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-mtk8395-fix-pcie-suspend-v1-1-0c7d6416f1a3@collabora.com>
X-B4-Tracking: v=1; b=H4sIANyNbmgC/zWNwQqDMBBEfyXsuQupxRj9leLBxE27lMQ0iUUQ/
 72h0uMbZubtkCkxZRjEDok+nHkJFa4XAfY5hQchz5WhkU0rO6nRl5e+9S063jBaJsxrjhRmdL3
 plFbGKWugzmOi2vld38eTE73XaihnCGbKhHbxnssgAm0F/xYYj+MLWpPQ85sAAAA=
X-Change-ID: 20250708-mtk8395-fix-pcie-suspend-f9b7686bf6cb
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752075766; l=6432;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=tUEYMrVXndgMbev/l8QfdyPcYHnAm9fF4NNVyeRWRRc=;
 b=wd3uaU3xrbWaq9DcHXh8m/nfNUol9F8/Y3zrMTRIvtyN+9s4TbaIBFx8opj7GB/aLpEFkFkx4
 VLbLrWFgAYVCfpmohDnjI2RQcG0mi5hermUds7Yh6p3dr+1XMJZxVEo
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In the pcie-mediatek-gen3 driver, the PM suspend callback function
powers down the PCIE link to stop the clocks and PHY and also assert
the MAC and PHY resets.

On MT8195 SoC, asserting the MAC reset for PCIe port 0 during suspend
sequence and letting it asserted leads the system to hang during resume
sequence because the PCIE link remains down after powering it up:
```
mtk-pcie-gen3 112f0000.pcie: PCIe link down, current LTSSM state:
  detect.quiet (0x0)
mtk-pcie-gen3 112f0000.pcie: PM: dpm_run_callback(): genpd_resume_noirq
  returns -110
mtk-pcie-gen3 112f0000.pcie: PM: failed to resume noirq: error -110
```
Deasserting it before suspend sequence is completed, allows the system
to resume properly.

So, add in the mtk_pcie_power_down function a flag parameter to say if the
device is being suspended and in this case, make the MAC reset be
deasserted after PCIE_MTK_RESET_TIME_US (=10us) delay.

Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
This patch fixes a hang issue during a suspend/resume sequence that
occurs on Mediatek Genio 1200 EVK board at least with commands such as
`systemctl suspend` or `echo mem > /sys/power/state` with the
following error (with no_console_suspend kernel parameter):
```
PM: suspend entry (deep)
Filesystems sync: 0.044 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.001 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
queueing ieee80211 work while going to suspend
dwmac-mediatek 11021000.ethernet end0: Link is Down
Disabling non-boot CPUs ...
psci: CPU7 killed (polled 0 ms)
psci: CPU6 killed (polled 0 ms)
psci: CPU5 killed (polled 4 ms)
psci: CPU4 killed (polled 0 ms)
psci: CPU3 killed (polled 0 ms)
psci: CPU2 killed (polled 0 ms)
psci: CPU1 killed (polled 4 ms)
Enabling non-boot CPUs ...
Detected VIPT I-cache on CPU1
GICv3: CPU1: found redistributor 100 region 0:0x000000000c060000
CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
CPU1 is up
Detected VIPT I-cache on CPU2
GICv3: CPU2: found redistributor 200 region 0:0x000000000c080000
CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
CPU2 is up
Detected VIPT I-cache on CPU3
GICv3: CPU3: found redistributor 300 region 0:0x000000000c0a0000
CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
CPU3 is up
Detected PIPT I-cache on CPU4
GICv3: CPU4: found redistributor 400 region 0:0x000000000c0c0000
CPU4: Booted secondary processor 0x0000000400 [0x411fd410]
CPU4 is up
Detected PIPT I-cache on CPU5
GICv3: CPU5: found redistributor 500 region 0:0x000000000c0e0000
CPU5: Booted secondary processor 0x0000000500 [0x411fd410]
CPU5 is up
Detected PIPT I-cache on CPU6
GICv3: CPU6: found redistributor 600 region 0:0x000000000c100000
CPU6: Booted secondary processor 0x0000000600 [0x411fd410]
CPU6 is up
Detected PIPT I-cache on CPU7
GICv3: CPU7: found redistributor 700 region 0:0x000000000c120000
CPU7: Booted secondary processor 0x0000000700 [0x411fd410]
CPU7 is up
mtk-pcie-gen3 112f0000.pcie: PCIe link down, current LTSSM state:
  detect.quiet (0x0)
mtk-pcie-gen3 112f0000.pcie: PM: dpm_run_callback(): genpd_resume_noirq
  returns -110
mtk-pcie-gen3 112f0000.pcie: PM: failed to resume noirq: error -110
dwmac4: Master AXI performs any burst length
dwmac-mediatek 11021000.ethernet end0: Enabling Safety Features
dwmac-mediatek 11021000.ethernet end0: IEEE 1588-2008 Advanced 
  Timestamp supported
dwmac-mediatek 11021000.ethernet end0: configuring for phy/rgmii-rxid
  link mode
SVSB_GPU_LOW: svs_init02_isr_handler: VOP74~30:0x1e1f1f20~0x21222324,
  DC:0x00000000
```

Tested on Mediatek Genio 1200-EVK board with a kernel based
on linux-next (tag: 20250708).
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 5464b4ae5c20c6c167b172dba598a77af70c6ad2..e4c33275abfae20f0652d136d5cc4b21237ac4e9 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1107,13 +1107,18 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 	return err;
 }
 
-static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
+static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie, bool is_suspend)
 {
 	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
 	pm_runtime_put_sync(pcie->dev);
 	pm_runtime_disable(pcie->dev);
 	reset_control_assert(pcie->mac_reset);
+	if (is_suspend) {
+		/* deassert after a delay to avoid hang issue at resume time */
+		usleep_range(PCIE_MTK_RESET_TIME_US, 2 * PCIE_MTK_RESET_TIME_US);
+		reset_control_deassert(pcie->mac_reset);
+	}
 
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
@@ -1179,7 +1184,7 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	return 0;
 
 err_setup:
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, false);
 
 	return err;
 }
@@ -1211,7 +1216,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	err = pci_host_probe(host);
 	if (err) {
 		mtk_pcie_irq_teardown(pcie);
-		mtk_pcie_power_down(pcie);
+		mtk_pcie_power_down(pcie, false);
 		return err;
 	}
 
@@ -1229,7 +1234,7 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_unlock_rescan_remove();
 
 	mtk_pcie_irq_teardown(pcie);
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, false);
 }
 
 static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
@@ -1306,7 +1311,7 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 	dev_dbg(pcie->dev, "entered L2 states successfully");
 
 	mtk_pcie_irq_save(pcie);
-	mtk_pcie_power_down(pcie);
+	mtk_pcie_power_down(pcie, true);
 
 	return 0;
 }
@@ -1322,7 +1327,7 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 
 	err = mtk_pcie_startup_port(pcie);
 	if (err) {
-		mtk_pcie_power_down(pcie);
+		mtk_pcie_power_down(pcie, false);
 		return err;
 	}
 

---
base-commit: 82c74bc3880ee6bd6c1bcb9ad5c4695eb1fb7cb7
change-id: 20250708-mtk8395-fix-pcie-suspend-f9b7686bf6cb

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


