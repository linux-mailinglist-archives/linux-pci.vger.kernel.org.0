Return-Path: <linux-pci+bounces-25323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408CFA7C9C6
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE653BA2D4
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B721DD88E;
	Sat,  5 Apr 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dowsKjXY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E1D19F495;
	Sat,  5 Apr 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743864949; cv=none; b=oESouPuOAR5qUa5JJ/LiChek/obMt6iivQ/6170bhxwmp0/k5TF7Z5+sVvJjhCqan/TLy0CFWpnSq5kOwcTkJ53JdWSFFBrpMh0/lF/NGv4C4ybfev9c6W5d4KmANp4Zh4ov9aY17h+65eeLKrfWIdTHTzN6xkuVWjqVUqnxpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743864949; c=relaxed/simple;
	bh=/GjtInTCch7d5NxppHPedqVptXogneqaqqWeKaunG9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=egJnwbXg7erWGiOx6bqavO08MVt+dWBHYtdkYYxpDDazj/L3V8o9Li752fCOGZrJr5UKXB2s5zoxB7M5fgTvug+vZXpJDGLI7kL74H963mBFRZ5kCxHYWNOn8H818dN8klZuGceF7Tee/qVOkgEZAiLdcxrpMJp0If6PjkLlmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dowsKjXY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Vo0bu
	L7Qftd1Y/xHSGSRWoItUidHgPXW0u87rQlDK1g=; b=dowsKjXY0ZVH+D9jKBYas
	65fTtu0cOH7kedicd66xkeOG1+TsNCfffOJ2fx4MRgi/W0UfUmEWf5rt5UgpJipp
	8smk1bndKcUUInXZqfeQdK22NJNRcEM8oyo1EWQdF3sndl6FrwXUgtoYHLoMgEBj
	Osb2nvVgrmkGdfoZIk4Guc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXovlFRPFnYnFlEQ--.24006S2;
	Sat, 05 Apr 2025 22:55:01 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: manivannan.sadhasivam@linaro.org,
	thierry.reding@gmail.com,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jonathanh@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
Date: Sat,  5 Apr 2025 22:54:59 +0800
Message-Id: <20250405145459.26800-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXovlFRPFnYnFlEQ--.24006S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urykCr13Zw4fKFyftr4rGrg_yoW5JFy8pa
	yUG3yYkw1DAFyYgFW3Aan8Zr1SyrZav34xJ3s3uwn2vFs8Gry5XFyDKFWFqFyfJrWkKF17
	Ar4YkFnrGr43JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNfOwUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxYmo2fxO-u5uAAAsf

When CONFIG_PCIEASPM is disabled, debugfs entries are not created, but
tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() unconditionally call
debugfs_remove_recursive(), leading to potential NULL pointer operations.

Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), which is
stubbed for !CONFIG_PCIEASPM. Use this function during removal/shutdown to
ensure debugfs cleanup only occurs when entries were initialized.

This prevents kernel warnings and instability when ASPM support is
disabled.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5103995cd6c7..d762e733c2d8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -716,11 +716,20 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
 	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
 				    aspm_state_cnt);
 }
+
+static void deinit_debugfs(struct tegra_pcie_dw *pcie)
+{
+	if (!pcie->debugfs)
+		return;
+
+	debugfs_remove_recursive(pcie->debugfs);
+}
 #else
 static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
 static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
+static inline void deinit_debugfs(struct tegra_pcie_dw *pcie) { return; }
 #endif
 
 static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
@@ -2289,7 +2298,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 		if (!pcie->link_state)
 			return;
 
-		debugfs_remove_recursive(pcie->debugfs);
+		deinit_debugfs(pcie->debugfs);
 		tegra_pcie_deinit_controller(pcie);
 		pm_runtime_put_sync(pcie->dev);
 	} else {
@@ -2408,7 +2417,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		if (!pcie->link_state)
 			return;
 
-		debugfs_remove_recursive(pcie->debugfs);
+		deinit_debugfs(pcie->debugfs);
 		tegra_pcie_downstream_dev_to_D0(pcie);
 
 		disable_irq(pcie->pci.pp.irq);

base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963
-- 
2.25.1


