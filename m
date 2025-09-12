Return-Path: <linux-pci+bounces-35974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A091B54070
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 04:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9711A07530
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A11D54E3;
	Fri, 12 Sep 2025 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgpnkbfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00661EB195
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644602; cv=none; b=emmCdD9IzgnqeSxPSyWvYyxmoF0lw/MOd46Rk3OkNtatzjRy9KVVd2qQS/OgX6Y9bP9F+gYPoCS+GvFem0Y0B6oJf5DACcVdBEr6JoKsdg7RPYDjsR12VmJvPSZjyzGlIDwkYK4nVdGlpSyi/0XMf0T76wOJBV9rndV0Z3ub/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644602; c=relaxed/simple;
	bh=gHiK/LLPXy0hxGPdrfSvDKKD7w4OAyZkKFkBi/ooJf0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QAamE5B2mN7GHrOknOxXZotIc4dallj15e2RSqfZnjQMcA0Gv07vSXsu3r2UvhKSlbfD2Eo8qrbUw3E59MiFNBueA0jXGGw3mmrDCrM7yLEAGJi/jLNNOMvt07hKAGKbVZAgr6vs6pkfjdCNfyjhDNPJ2ILoLsVY9TWeao1D9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgpnkbfn; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-746da717f35so713446a34.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644599; x=1758249399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggltpTc0D00UKxi4gG99EmSzD1bwb+Ulvy+/Q1NlhRc=;
        b=DgpnkbfnFUoV2DH6o5KGuXEOvsxcTgSx+0XtfPHQW+MddvH3ddJG5uN1IH4ksWi16u
         xGRRe838N2yh+GRknb88blb9gY9bzGdFNKtWhq9001b/xZHawIOjNaqFuNUWL5W9BKcH
         upA7YicHecjxaKoLQtB8rMguzNwIic45pR+KtjJoleBKGk/0Xvyw8PigJLkFk/MPks0t
         wFycC/iqxWOZujEqDSDoyOCg6JLSaCAc970W18x2euJ0GpeySeYFV2pGIMuiISBG2b9u
         lkUES440B/GBPDKBsHRDsAN1pDz/T3tZ+PPJG1qgHVAm6aZElBXITN6N/cjntEhX47VP
         jn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644599; x=1758249399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggltpTc0D00UKxi4gG99EmSzD1bwb+Ulvy+/Q1NlhRc=;
        b=fOJaKSEoRTSA1Tb1L9x8RdVEYJ0dLNYj74o2w662XCjJgq+fBz4HmqpDYEEbY+UoGu
         hs+ePZrJpkjyHSF0Z2rYVQ1lKkh7Z4hEUzg4GEXESFvZPWfTWUthjni1KFE4MIJu2RHs
         QK7j+iLzVnZcUZ9/olVW7/3QJBz4LAx14Zj01asqWql8MM4nH6lRT07Z4zQkC21xf6wn
         GkHpZWpTcPwWWZxIH9VS5ABeoqv3/Gz9b1LiMGeR/87hdXfQ5BVmp+qhwaLIL69YdJII
         RKxYNrKiE3XwgrqAGebrygW6EZYF/TM+S4XD9432rg548nej4zGmg2u7TgPSzQWxbW5P
         hBTg==
X-Forwarded-Encrypted: i=1; AJvYcCX9dPYZRSGqkNqwnHOdR0YBKFWS/yfXX6N+/4ofq3rAnYo9cQuZgUHyXAFUrP8YJCZPPGZVhwXuBsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRyqXUrxsLmrMvPWvQhbqk2Pd5VK9BXNDGUcL3Ywiqh7pWqKv
	ooHzbtUyuze/I4nM5RJGW0u4jyqRZZJq/SpG+2x+xF8fm381rGm4bic7
X-Gm-Gg: ASbGncuTOyK4lAAdveCGr1yHZWSpW8fQD+DUVLGMAULGqE0+rZb1KsNzpW1rzFSZpcT
	DRshDnC+pq18b6/+0hMHOTq9OzdGpS7Q3BChCQamZLd58xZqshxIzHxZMmZ26VrcIBtausbptoa
	NHl845w9XXGNcOwgkjiwKMezcf+odMFijX6c4M3wLmzQQCFPUG7qFze1451B0WC7l+CI2eB8emu
	WENwEVl7lMVq9Bx7CABtDP59gDS+wuI2bLYwgb2zHWPlWA6YsQ9uD/oa3YIL2PhL+v7/PmKMvck
	3lXL/AIpgoYCfyJvU/r3cUgZFZ89z5dj/7GyZs6kHtPgcEa9UbFLEKIqAjvvGmwc4e8uFfDzvX8
	sIBYAcZz8uk98MM3lUGnuL2A/KGnEKTIK
X-Google-Smtp-Source: AGHT+IFT8EKRFDpgNVFde0rDbnWyS6vNtP7dHpbjXsQb+tjyelQnUQR1SGs7F/2QHfYBGudTg1wi/g==
X-Received: by 2002:a05:6808:1994:b0:43b:7b7f:d26d with SMTP id 5614622812f47-43b8d9fd706mr472672b6e.24.1757644599414;
        Thu, 11 Sep 2025 19:36:39 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524bd835f0sm746972a34.33.2025.09.11.19.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:36:39 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: kwilczynski@kernel.org,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	arnd@arndb.de,
	bwawrzyn@cisco.com,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	18255117159@163.com,
	inochiama@gmail.com,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	tglx@linutronix.de,
	thomas.richard@bootlin.com,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	rabenda.cn@gmail.com,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com,
	jeffbai@aosc.io
Subject: [PATCH v3 3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Date: Fri, 12 Sep 2025 10:36:31 +0800
Message-Id: <01b0a57cd9dba8bed7c1f2d52997046c2c6f042b.1757643388.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757643388.git.unicorn_wang@outlook.com>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add support for PCIe controller in SG2042 SoC. The controller
uses the Cadence PCIe core programmed by pcie-cadence*.c. The
PCIe controller will work in host mode only, supporting data
rate (16 GT/s) and lanes (x16 or x8).

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pci/controller/cadence/Kconfig       |  10 ++
 drivers/pci/controller/cadence/Makefile      |   1 +
 drivers/pci/controller/cadence/pcie-sg2042.c | 138 +++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 666e16b6367f..02a639e55fd8 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -42,6 +42,15 @@ config PCIE_CADENCE_PLAT_EP
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
+config PCIE_SG2042_HOST
+	tristate "Sophgo SG2042 PCIe controller (host mode)"
+	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
+	select PCIE_CADENCE_HOST
+	help
+	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
+	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
+	  PCIe core.
+
 config PCI_J721E
 	tristate
 	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
@@ -67,4 +76,5 @@ config PCI_J721E_EP
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
 	  core.
+
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 9bac5fb2f13d..5e23f8539ecc 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
new file mode 100644
index 000000000000..db91c37790b7
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
+ *
+ * Copyright (C) 2025 Sophgo Technology Inc.
+ * Copyright (C) 2025 Chen Wang <unicorn_wang@outlook.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include "pcie-cadence.h"
+
+/*
+ * SG2042 only supports 4-byte aligned access, so for the rootbus (i.e. to
+ * read/write the Root Port itself, read32/write32 is required. For
+ * non-rootbus (i.e. to read/write the PCIe peripheral registers, supports
+ * 1/2/4 byte aligned access, so directly using read/write should be fine.
+ */
+
+static struct pci_ops sg2042_pcie_root_ops = {
+	.map_bus	= cdns_pci_map_bus,
+	.read		= pci_generic_config_read32,
+	.write		= pci_generic_config_write32,
+};
+
+static struct pci_ops sg2042_pcie_child_ops = {
+	.map_bus	= cdns_pci_map_bus,
+	.read		= pci_generic_config_read,
+	.write		= pci_generic_config_write,
+};
+
+static int sg2042_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct cdns_pcie *pcie;
+	struct cdns_pcie_rc *rc;
+	int ret;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	if (!bridge) {
+		dev_err_probe(dev, -ENOMEM, "Failed to alloc host bridge!\n");
+		return -ENOMEM;
+	}
+
+	bridge->ops = &sg2042_pcie_root_ops;
+	bridge->child_ops = &sg2042_pcie_child_ops;
+
+	rc = pci_host_bridge_priv(bridge);
+	pcie = &rc->pcie;
+	pcie->dev = dev;
+
+	platform_set_drvdata(pdev, pcie);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_no_callbacks(dev);
+	devm_pm_runtime_enable(dev);
+
+	ret = cdns_pcie_init_phy(dev, pcie);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to init phy!\n");
+		return ret;
+	}
+
+	ret = cdns_pcie_host_setup(rc);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to setup host!\n");
+		cdns_pcie_disable_phy(pcie);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void sg2042_pcie_remove(struct platform_device *pdev)
+{
+	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct cdns_pcie_rc *rc;
+
+	rc = container_of(pcie, struct cdns_pcie_rc, pcie);
+	cdns_pcie_host_disable(rc);
+
+	cdns_pcie_disable_phy(pcie);
+
+	pm_runtime_disable(dev);
+}
+
+static int sg2042_pcie_suspend_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+
+	cdns_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int sg2042_pcie_resume_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cdns_pcie_enable_phy(pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable PHY\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(sg2042_pcie_pm_ops,
+			       sg2042_pcie_suspend_noirq,
+			       sg2042_pcie_resume_noirq);
+
+static const struct of_device_id sg2042_pcie_of_match[] = {
+	{ .compatible = "sophgo,sg2042-pcie-host" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sg2042_pcie_of_match);
+
+static struct platform_driver sg2042_pcie_driver = {
+	.driver = {
+		.name		= "sg2042-pcie",
+		.of_match_table	= sg2042_pcie_of_match,
+		.pm		= pm_sleep_ptr(&sg2042_pcie_pm_ops),
+	},
+	.probe		= sg2042_pcie_probe,
+	.remove		= sg2042_pcie_remove,
+};
+module_platform_driver(sg2042_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe controller driver for SG2042 SoCs");
+MODULE_AUTHOR("Chen Wang <unicorn_wang@outlook.com>");
-- 
2.34.1


