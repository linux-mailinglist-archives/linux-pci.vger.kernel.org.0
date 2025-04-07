Return-Path: <linux-pci+bounces-25372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CADEA7DE00
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3E31887270
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39F52459C2;
	Mon,  7 Apr 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ECbq8sd2"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270822CBF6;
	Mon,  7 Apr 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029847; cv=none; b=PDvkzPZY6c64/9/SPVCqHPlb3qXxC+pvGTtVczroGtdRMkiGd/rRLhnneyeuG122aidxIV+/ZI7YE2b7A7YpFLhqrwVtomxWsgwWSebfMq7wXy0LJHsh1MDLYavK+mORr3h3D2FpriA5fm0p4iI1F1g4GZhDfXnRNzxeeilpHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029847; c=relaxed/simple;
	bh=vqjWZuPQlIOFlSltHzsekIKSiLr4Qp8Wgn5s0hWzFFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tZB04KsO4ZesKz9tJ98K/K5DunAPa1eElQB8bQq6l9YjkBpI/DqtrDFTXGoCbpEn44dtp1E9FDlWNuZWS65xOpEOkire+8Nr3V2yELgNOQz+2JL7uVeArYQYk8oj/KdbxPcWnOw63uoZTqcXW2CmruKvUSXay+dF9xCUZHE9+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ECbq8sd2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dHe9y
	qn4Y0WIUpRuMWGYKVK2uUqqPhweadp6diItowU=; b=ECbq8sd26lexrWpr38c91
	eDK9rfQtgGV7IurdL2zBZOA4rcNIfR1hFLuEoYQoTEU/H/nHZ2PRgx75hLmpsEK0
	hiECOA4xIH6wD2eXffRF5PlX1z3Q0DHEeVXhIsoQmKLtorkrh6Zcv7059yDDF1kK
	JqqD3jc6tA6c1H9KDiARkY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXovl1yPNnuhoaEw--.58685S2;
	Mon, 07 Apr 2025 20:43:35 +0800 (CST)
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
Subject: [v3] PCI: tegra194: Fix debugfs directory creation when CONFIG_PCIEASPM is disabled
Date: Mon,  7 Apr 2025 20:43:31 +0800
Message-Id: <20250407124331.69459-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXovl1yPNnuhoaEw--.58685S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1furWkWr47XFy3uFykKrg_yoW5Xryfpa
	95GFWYkr4kAa1fXrsrZa1UZr1SyrZayrZ7J34fuw1Ivr4DCr98tFy8KFyYqFy7CrWDtw1U
	ZF4rt3Wqkr45JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_EfOUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx0oo2fzxwYbfQABs-

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
Changes since v2:
https://lore.kernel.org/linux-pci/20250406134355.49036-1-18255117159@163.com/

- Maintainer recommends ignoring the devm_kasprintf return value. The
  module should still work correctly. So just a return;

Changes since v1:
https://lore.kernel.org/linux-pci/20250405145459.26800-1-18255117159@163.com/

- The first version was committed incorrectly because the judgment
  parameter in "debugfs_remove_recursive" was not noticed.
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5103995cd6c7..bc419688527a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -713,7 +713,16 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
 static void init_debugfs(struct tegra_pcie_dw *pcie)
 {
-	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
+	struct device *dev = pcie->dev;
+	char *name;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
+	if (!name)
+		return;
+
+	pcie->debugfs = debugfs_create_dir(name, NULL);
+
+	debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
 				    aspm_state_cnt);
 }
 #else
@@ -1634,7 +1643,6 @@ static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 {
 	struct device *dev = pcie->dev;
-	char *name;
 	int ret;
 
 	pm_runtime_enable(dev);
@@ -1664,13 +1672,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_host_init;
 	}
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
-	if (!name) {
-		ret = -ENOMEM;
-		goto fail_host_init;
-	}
-
-	pcie->debugfs = debugfs_create_dir(name, NULL);
 	init_debugfs(pcie);
 
 	return ret;

base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963
-- 
2.25.1


