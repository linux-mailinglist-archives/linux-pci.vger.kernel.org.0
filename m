Return-Path: <linux-pci+bounces-34960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56DB39198
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 04:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F5F365DD9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 02:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EAE248883;
	Thu, 28 Aug 2025 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvuVSQdq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC5199931;
	Thu, 28 Aug 2025 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347471; cv=none; b=RUKAqoRBzUVP70TBpatPYGOBzrnk/8rVnBtCbsBZ5iFxTAiimAZCd4z7CtfKLmD1mD1YWa1ZmNaHzkJEySzleaOzQn0PZZlGW3zw60WuRCbtXZUXs6cLrKfAGY3apGZiqGm5rCYEBw5LsKNtkbJz2nmwtc+LDux/waU55rGEcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347471; c=relaxed/simple;
	bh=jsp3ZxCFIwxUfMwp0GyT+wPOde8wDXy/DnjM645DC7A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJ09MYwFA7L4qDnRERgwfxs164tZMJJ+0Xh1cbZqoS1tK7G814OXSpVGqB2ouudUE3RiIpvG97dqYSNwXaPr+xtEo9hqmnbppF4V92aj0ccVnBR7fPsGTfi7I5qahaeKNwUan+8oHhq7dEvzV7phKJxIXrEn/38I17OpWBPLGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvuVSQdq; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-31597d3b410so160589fac.1;
        Wed, 27 Aug 2025 19:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756347469; x=1756952269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1J0WFYBhSOi86+35mD2mRHFDAZtuR1uDJv4Cz+MRN0=;
        b=GvuVSQdqJyOm7l6rUnxPE9PAx/+wINJkyBp00RVn9ilkAwWEZ2r8ngJvq3XFNI3Vdc
         WK5M/MPkmpgNQU9viDrqtpWvW3Vnfjbyb5CFwosHC4vQJWFK+PzhtFlC6j3KTitx697Q
         +1Peo8yP3dyTecgsLv59Z+YVE2MtVdiD55J9u7BMqr/ZLpaxch/MkfYebXC2ntzy4Z86
         ruqorZ0VBYWa6BlYpa9HQCeBFGRbW+IZfqrHDeNJOQdnOl576tEcDYUB3ImAeT2Fekeg
         4o0WKehBtGeCItDG/aPypH+7nbt+Y9KXmzzNdDBu4yhBUpvfWQD8Ec2RZbRwE1eBra8q
         6Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347469; x=1756952269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1J0WFYBhSOi86+35mD2mRHFDAZtuR1uDJv4Cz+MRN0=;
        b=ANNSSHHcKnHKsxjZZOWfJT+1UkQp2byl4y+VAsiOkMz0sHIpSf8m33r388n7h05/N3
         imKOMr5AwfYX4UtC9pb7Jyoifz4m52PPeKHx2mWw+z3Dnzk574fz213MuEdRd7igQGnS
         InR52p8hDLaQpz2/3lbIb3DiVce263iKBCrQUVlId9rAnKIBZGvVF3Ce/PpnA8W/ZgCm
         /0MPzN1pMxAXhyfwdmOxQLNbg/ps10mIapiPPxP5uwysLZvk1F+tPEno7Fs5zDuUoYqD
         D83qTF7m5kjIabEk28s1KC6xq1NC/jFBud9EINXQr45p7jMMdZiIkb1/qXU6vW2oGBjy
         M3ow==
X-Forwarded-Encrypted: i=1; AJvYcCU5SMq9A2ScWNK5x8ustlpjGDZST2h69uU3/6fyTVVPdt8PLkrh/RXMb0pDqaEnZUGL5vcFMVugxS3dcbh0@vger.kernel.org, AJvYcCVlLUQiJxDtYYjFuPzFW1r3lkCMjsU5CgCqVEpLF3SBc4D0ul3RUKvyMUAMyG19+OxvFiu7caMnaUjb@vger.kernel.org, AJvYcCWD5JjIZEM5+y+npAsYy4ugT4TQ3dbiuN3HyCxSQjO0JWadUPzcEKcodE3w8DSeevYKw90tn0qzAh5K@vger.kernel.org
X-Gm-Message-State: AOJu0YzclEdZbXjs1Qsh+nujbB0OGsOlBb3zOm7l3lv2XSh+8ZyMYJjT
	3XVHEHjt4LIwup8U1xEL7Bm29dISxM0l8G+vsfy+ouDhnSsAPpCCHS17
X-Gm-Gg: ASbGncu6v9+zPK2mCO+G+MlffsiCYt3c/K2TcmBZKtihBw5OaMYmuBzWmnjOdtki1ro
	L1iaF54EfbJuvUs8j4L4fhoY0xiWEnpSy5vIHDQPHATFHVEmXuzszHiNVlpuAjYk6K0NNVVCBcx
	K4vlKWA9UCHLC6pAEIDdLBBzN9/hlVY9nmoVhGLBZ6MQO26pALXUovudWU5gwWUFFDCzlQdZVIl
	0XP9CbPovo1I4w07V+oFLQfUNbzt5KL7J4raE7kBx5R7Z2onhx6q6K07GAntOgUoKbqhGYvj8IC
	o8vmQH5mWJyOZjl/FNLmDEBWTlrGuAgRpCvDy0AQr5ja6/YeIPwSysDeg4TPUNcoTW2Q4doD9Ei
	qu9ypVjkGt2xG4tPXxaYS2AMSBwFtaVhBjrYHOUVoxhk=
X-Google-Smtp-Source: AGHT+IHsxuJu7jkWvWsps1igHiY/UUiFcSFtA/FN5HQqjKuBeXruePrLDEHJj7TO/JjdqRVkSNwrvw==
X-Received: by 2002:a05:6871:e387:b0:315:8a2a:3f59 with SMTP id 586e51a60fabf-3158a2a4cf7mr1544247fac.21.1756347469269;
        Wed, 27 Aug 2025 19:17:49 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7a2dc16sm3674563fac.12.2025.08.27.19.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 19:17:47 -0700 (PDT)
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
Subject: [PATCH 3/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Date: Thu, 28 Aug 2025 10:17:40 +0800
Message-Id: <1df25b33f0ea90a81c34c18cadedd38526a30f01.1756344464.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756344464.git.unicorn_wang@outlook.com>
References: <cover.1756344464.git.unicorn_wang@outlook.com>
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
PCIe controller will work in host mode only.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pci/controller/cadence/Kconfig       |  12 ++
 drivers/pci/controller/cadence/Makefile      |   1 +
 drivers/pci/controller/cadence/pcie-sg2042.c | 134 +++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 666e16b6367f..b1f1941d5208 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -42,6 +42,17 @@ config PCIE_CADENCE_PLAT_EP
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
+config PCIE_SG2042
+	bool "Sophgo SG2042 PCIe controller (host mode)"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on OF
+	depends on PCI_MSI
+	select PCIE_CADENCE_HOST
+	help
+	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
+	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
+	  PCIe core.
+
 config PCI_J721E
 	tristate
 	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
@@ -67,4 +78,5 @@ config PCI_J721E_EP
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
 	  core.
+
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 9bac5fb2f13d..4df4456d9539 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCIE_SG2042) += pcie-sg2042.o
diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
new file mode 100644
index 000000000000..fe434dc2967e
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
+ *
+ * Copyright (C) 2025 Sophgo Technology Inc.
+ * Copyright (C) 2025 Chen Wang <unicorn_wang@outlook.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include "pcie-cadence.h"
+
+/*
+ * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
+ * the Root Port itself, read32 is required. For non-rootbus (i.e. to read
+ * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
+ * directly using read should be fine.
+ *
+ * The same is true for write.
+ */
+static int sg2042_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 *value)
+{
+	if (pci_is_root_bus(bus))
+		return pci_generic_config_read32(bus, devfn, where, size,
+						 value);
+
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int sg2042_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 value)
+{
+	if (pci_is_root_bus(bus))
+		return pci_generic_config_write32(bus, devfn, where, size,
+						  value);
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static struct pci_ops sg2042_pcie_host_ops = {
+	.map_bus	= cdns_pci_map_bus,
+	.read		= sg2042_pcie_config_read,
+	.write		= sg2042_pcie_config_write,
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
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	if (!bridge) {
+		dev_err(dev, "Failed to alloc host bridge!\n");
+		return -ENOMEM;
+	}
+
+	bridge->ops = &sg2042_pcie_host_ops;
+
+	rc = pci_host_bridge_priv(bridge);
+	pcie = &rc->pcie;
+	pcie->dev = dev;
+
+	platform_set_drvdata(pdev, pcie);
+
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		goto err_get_sync;
+	}
+
+	ret = cdns_pcie_init_phy(dev, pcie);
+	if (ret) {
+		dev_err(dev, "Failed to init phy!\n");
+		goto err_get_sync;
+	}
+
+	ret = cdns_pcie_host_setup(rc);
+	if (ret < 0) {
+		dev_err(dev, "Failed to setup host!\n");
+		goto err_host_setup;
+	}
+
+	return 0;
+
+err_host_setup:
+	cdns_pcie_disable_phy(pcie);
+
+err_get_sync:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static void sg2042_pcie_shutdown(struct platform_device *pdev)
+{
+	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	cdns_pcie_disable_phy(pcie);
+
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+}
+
+static const struct of_device_id sg2042_pcie_of_match[] = {
+	{ .compatible = "sophgo,sg2042-pcie-host" },
+	{},
+};
+
+static struct platform_driver sg2042_pcie_driver = {
+	.driver = {
+		.name		= "sg2042-pcie",
+		.of_match_table	= sg2042_pcie_of_match,
+		.pm		= &cdns_pcie_pm_ops,
+	},
+	.probe		= sg2042_pcie_probe,
+	.shutdown	= sg2042_pcie_shutdown,
+};
+builtin_platform_driver(sg2042_pcie_driver);
-- 
2.34.1


