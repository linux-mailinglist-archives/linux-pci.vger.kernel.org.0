Return-Path: <linux-pci+bounces-25340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0FA7CE31
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 15:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821A27A4131
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056A2185BC;
	Sun,  6 Apr 2025 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cf6DvJu9"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1DF9EC;
	Sun,  6 Apr 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743947085; cv=none; b=ai3XfzMXAUz5IZm3K4KzvVkPKkyc0eU14tzy8Ic6mHOzZJ8bLWSCdk+sOOQQq3NF/uaEm0vljsA0TXVNJxj6d7+rKlkOC0boW1pCS/q8CSsj9xSocesWOasUnk8nIxA88N/2U53WtIx5ZaLrCZpLwZ5zWzfUkLPaxCRVBlYp/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743947085; c=relaxed/simple;
	bh=Jqu2AMMFksA7iOOfXNFCAeMLrm2e8NyBp0965KZXbPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=btWOftLttVaR5jjP2nDyrWTQcIbjbt2A+VJuHc2BWqr/v6xnSPugIN6VUH3sukfg0QFauLsZxeWl2VOR7ZJ15HDFGx668KMpv42+IaXKLY0T+PpJyR7RNgeL/rr1q+/XjChUIAJ7yBuBIUaWCYDO7mfJOhQVNrhB0T6jnyhvBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cf6DvJu9; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=p4Mez
	4mArlhOpLu4nWrQ/y8UYYPW3F3qmF7a7hBMrc0=; b=Cf6DvJu9BNElPw1+UA6KE
	6f5W+pLcXX9x5wzzh02PcRWTVedSXCdqLSCySFTWmRRIEASEz9XdbCZ76WDu3n+R
	A2fOfQHHHkc1ukjyZr2J0QEdeW+E7A/Bpqny11at+LHAmk+h9SIL2owSFstoJACb
	T4tpe5pgU5zTzhuYks7JM8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBn7yMdhfJnJvpbBg--.43663S2;
	Sun, 06 Apr 2025 21:43:58 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: christophe.jaillet@wanadoo.fr,
	manivannan.sadhasivam@linaro.org,
	thierry.reding@gmail.com,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jonathanh@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v2] PCI: tegra194: Fix debugfs directory creation when CONFIG_PCIEASPM is disabled
Date: Sun,  6 Apr 2025 21:43:55 +0800
Message-Id: <20250406134355.49036-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBn7yMdhfJnJvpbBg--.43663S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1furWkZF4xurW8tFyrJFb_yoW5CFWxpa
	y5GayYkw18Aa1fWrZrAa1DZr1SyrZak3s7J34fuw1vvF4DCry5JFyrKFyYqF97CrZ7tr1U
	AF4jkF1DCr4UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziIzuJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwIno2fyfGToqwAAsH

Previously, the debugfs directory was unconditionally created in
tegra_pcie_config_rp() regardless of the CONFIG_PCIEASPM setting.
This led to unnecessary directory creation when ASPM support was disabled.

Move the debugfs directory creation into init_debugfs() which is
conditionally compiled based on CONFIG_PCIEASPM. This ensures:
- The directory is only created when ASPM-related debugfs entries are
  needed.
- Proper error handling for directory creation failures.
- Avoids cluttering debugfs with empty directories when ASPM is disabled.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v1:
https://lore.kernel.org/linux-pci/20250405145459.26800-1-18255117159@163.com

- The first version was committed incorrectly because the judgment
  parameter in "debugfs_remove_recursive" was not noticed.
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 27 +++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5103995cd6c7..f048b2342af4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -711,16 +711,27 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
 
-static void init_debugfs(struct tegra_pcie_dw *pcie)
+static int init_debugfs(struct tegra_pcie_dw *pcie)
 {
-	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
+	struct device *dev = pcie->dev;
+	char *name;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
+	if (!name)
+		return -ENOMEM;
+
+	pcie->debugfs = debugfs_create_dir(name, NULL);
+
+	debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
 				    aspm_state_cnt);
+
+	return 0;
 }
 #else
 static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
 static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
-static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
+static inline int init_debugfs(struct tegra_pcie_dw *pcie) { return 0; }
 #endif
 
 static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
@@ -1634,7 +1645,6 @@ static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 {
 	struct device *dev = pcie->dev;
-	char *name;
 	int ret;
 
 	pm_runtime_enable(dev);
@@ -1664,14 +1674,9 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_host_init;
 	}
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
-	if (!name) {
-		ret = -ENOMEM;
+	ret = init_debugfs(pcie);
+	if (ret < 0)
 		goto fail_host_init;
-	}
-
-	pcie->debugfs = debugfs_create_dir(name, NULL);
-	init_debugfs(pcie);
 
 	return ret;
 

base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963
-- 
2.25.1


