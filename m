Return-Path: <linux-pci+bounces-35783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2836B50ACA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1555E1D9C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4D232395;
	Wed, 10 Sep 2025 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXXUIRVs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962A1F463C;
	Wed, 10 Sep 2025 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470131; cv=none; b=DMKVgE8e5CgMiSJ0ZE2jE6pECR+2KOMla8a5xTWyVyHyaGdRwU/eShnirwyZY/VjRVPpFl16Od+FrT9o4bMgyzkv6o0pYx625lMAc/Z+cX8NjXL5GFsADDR+dWiEB/KBxR4L0qS6rAaiHzQNZewPWsWlyOtK1mzy+yfpoW5/B1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470131; c=relaxed/simple;
	bh=khIEoJhgTqQOec4hXOVd9L/mM09/lGczpz+2cb8Mj1c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqtvqMlYEr658fzo9aLMdjCTcCwsGwe721ZHGcJdOhgLJg3zqLmfEhvo8lEve1j0dXEndSbDv9L8CTR+GK4iYmxrXn0f9e0xf4RHP1kCqlDrb93kD+Kc5ScMjfSPTnduzg2paJ1E6uzs98nMiRklfKmBKmozrpsZLg9p9n3hU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXXUIRVs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-722e079fa1aso68459216d6.3;
        Tue, 09 Sep 2025 19:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470128; x=1758074928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1kKuKImv7GctF9OqERXtoZe8KO1bpSjPCvzB+6cOlo=;
        b=JXXUIRVsRVO87gdYgEhvnIUHUzG5ovOg56BwKke/nN46n/wUanFJQWtKk9XnaQnuRP
         STK7AZo64NKtQUt5M+aE4rnnSqaQspiZzzYBzGkn3SwGU9Bc5WyPyn8tzANBzXz+JxGt
         bbz+LUtPFzADnekjdJIRX+19RIkmSVaqeZ/6x3tpcPrRNKNWco+vzRQM2+m+S7EaaWCZ
         7fqO8nZg5pr0q8zVP2mvLGz72ynYfte9rmvnHSjnXZVsOZeXJSCzOPYticG2+EX81lwx
         1Z77fs3g2Ds5lvWTVZNNucXjme2PB0yzmGrATY4MRjSr4SGZkAo8rfxQjDzdCUk3/+c/
         1vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470128; x=1758074928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1kKuKImv7GctF9OqERXtoZe8KO1bpSjPCvzB+6cOlo=;
        b=MFtkuAjzdItJD6It+6vMOm5R8bLTweVs7+PIx6u7qDr1Zsmj4puPLhvbb7hHiG+iMj
         QPTo6WrGmgEi1bm7XfEOC8nOMIW4RuMkPI90YI2dG/gUE6vOVsg/o5wISzaNlW17oZXT
         +a2AHBiKnGIJvrJL4zveptXOlEXjh0tTuD3jOYp18Vnm+gg5PNRrphLJpIKO2+uaFmH7
         676g3j5smB1D9XomqIszo9ydBYS7wR4Z+N2Z/aXlI0CG26PJMRTFZEgmesASIwtc0Vqg
         l/PQBSWP2c1tW4HAqxCCbxA+8jv9S/jZJ3ZT/qwlS+HWs28Dm/S3WakSaxdWwo+vVlR9
         76WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgr6vfgluj1lXJUr6kRYonPEY+w0b5Jr2QaAw0mIYRip3xud6AqxEj07ksjTpLDQ7gYMz27PMPijbR@vger.kernel.org, AJvYcCV3ooJtIU8/t0gVgOzjjT1y+uRLTdYZwwWec7u+6PahGe6CfYWYdEHnkk3ZNiVPReV/nZDcqg/Hq5rwIola@vger.kernel.org, AJvYcCVKrbuJw63MLCBaslEdBmJjIOaXMc0K03VcroQo5AtIKpvXISRsWVrZwq/O6t6mzQRXbED8rSdVcXuc@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6C6lRHoXeC7WBcWGfOHCh/3ajdW8nnulIA3I93omJUgSp+2e
	TDpAQS71eHTCNE4o/YxOTNPwwT0N/GGbxQPQFJP+wjXMGSFrPr2uLGiO
X-Gm-Gg: ASbGncsiIemmTd0Y3RInLqNFGKBYV+GfE0F/h0HWd2ZmEbOf7ccfsE8m2pRSw6wVf0q
	wg0M1XNtkpjHgyK1uylWTzgeelN0GVtW0uUZHj2Zh73wbMIhQ5YFjm+9Gsi07Vy2/ROtIUfiq6w
	fnDfFslEeIxl8GHvcxgoOVTKwlXVuWUakBNRxfH7A34Jg49cX7LZ2nnkVDB83NmYGO1yy2rnQjA
	LghtZbxWag0YA2rbs2OCaf4Tn9U8uYCP93T4zRB78woV7mvHMNLir/aI7esdYrE0goiuf5ifNhG
	ykuU6RCjMquvpDCyr6skOdZ5Jj8wPadTJ7yKI/RzK7B4ezc08S1qjnNuKhNXLkRVNrLP9GmY2Su
	c1TqSytplvqqnYgqW7Nj3A9tjb2mx0lKO
X-Google-Smtp-Source: AGHT+IEP0LcAhoihnbV2d1OBh2Z6NJtDjWlEEi8NwAlfZHgJtJ8a8yODK14yeBgI516xZ4vfhQNFaQ==
X-Received: by 2002:a05:6214:2421:b0:720:e5a:fe3b with SMTP id 6a1803df08f44-7394425a27dmr153957196d6.58.1757470128096;
        Tue, 09 Sep 2025 19:08:48 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-725dda254d4sm132429776d6.8.2025.09.09.19.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:08:47 -0700 (PDT)
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
	fengchun.li@sophgo.com
Subject: [PATCH v2 3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Date: Wed, 10 Sep 2025 10:08:39 +0800
Message-Id: <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757467895.git.unicorn_wang@outlook.com>
References: <cover.1757467895.git.unicorn_wang@outlook.com>
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
rate(gen4) and lanes(x16 or x8).

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pci/controller/cadence/Kconfig       |  10 ++
 drivers/pci/controller/cadence/Makefile      |   1 +
 drivers/pci/controller/cadence/pcie-sg2042.c | 104 +++++++++++++++++++
 3 files changed, 115 insertions(+)
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
index 000000000000..c026e1ca5d6e
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -0,0 +1,104 @@
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
+
+	cdns_pcie_disable_phy(pcie);
+}
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
+		.pm		= &cdns_pcie_pm_ops,
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


