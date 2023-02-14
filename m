Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445EF6966B5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjBNO0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjBNO0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:26:13 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577E298EC
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:26:04 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230214140654epoutp01132afc84126f55f25fbaef74f2031e96~DtgQDJgyM1360813608epoutp01q
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:06:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230214140654epoutp01132afc84126f55f25fbaef74f2031e96~DtgQDJgyM1360813608epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383614;
        bh=eIcDirgtV8qN9plFXoUeyRc8NT+nYHD885KzjKd3kiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmVrxAvRM8IV9Aa/eFj71ap8TRaD0nJW4w99RG2QwFfflER3aJLM+Rz0sd3Slt2Ez
         Yl0N5yAX9fGr2le+5ZfEU/1jtOJdqMUJ6HuPHqKpTZYrwCbIQeFBiPL7zs+H1BDQCm
         hAagOQ7jq6W0m/Jodj4TZILDhOt12c//vOFtIMeY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230214140653epcas5p336439875d989277525e840b13f6ed354~DtgOvzvS41731617316epcas5p3r;
        Tue, 14 Feb 2023 14:06:53 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PGNLN0yDwz4x9Pt; Tue, 14 Feb
        2023 14:06:52 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.49.10528.B759BE36; Tue, 14 Feb 2023 23:06:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230214121411epcas5p25efd5d4242c512f21165df0c2e81b8bc~Dr91oEM8l3058930589epcas5p2v;
        Tue, 14 Feb 2023 12:14:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214121411epsmtrp27d1f81be0cb57b3819da1c28ef1ef5ee~Dr91nIUZM1888418884epsmtrp2G;
        Tue, 14 Feb 2023 12:14:11 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-85-63eb957b0683
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.7E.05839.31B7BE36; Tue, 14 Feb 2023 21:14:11 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121408epsmtip142a0a642b57491c7daf7930f59068986~Dr9yns0Kx1886618866epsmtip1d;
        Tue, 14 Feb 2023 12:14:08 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com,
        Sergey.Semin@baikalelectronics.ru, lukas.bulwahn@gmail.com,
        hongxing.zhu@nxp.com, tglx@linutronix.de, m.szyprowski@samsung.com,
        jh80.chung@samsung.co, pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 02/16] PCI: exynos: Rename Exynos PCIe driver to Samsung
 PCIe
Date:   Tue, 14 Feb 2023 17:43:19 +0530
Message-Id: <20230214121333.1837-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfVBUVRjG59x7uXexYG4LTEdCpIUsmYDd3MWDSeVEcEVHECudsoHrcttF
        9uO2u1iwYy4OjImuU8wwECGhUq00WCzEgMFGiDIQUQIxLLoMTJKYtfIl4QDS7l6s/37neZ53
        3vOeDxEudpChohydiTPoWI2EXEc0X9n8XIy57K5SOlyagMarm0lUe1yNPu/q90OVzWcBmlnq
        J5Bt/lMKnZmawJHl9JIfsv8+7IcGL1eR6OfqbhJV/OLAUNFyEYGKrp4gUH2Xi0Lnv5un0Gpb
        C4WWy6cJZL1yFDXay/BXgpm/7P9QTGuli2Jq7HmMve4kydwcbiMZd38/xdwaKseYxtpjTIO7
        BWPOW2ZI5kxTHWDm7OHpj7+Vu13NsdmcIYLTKfXZOTpVomTXvsxXMxXxUlmMLAFtlUToWC2X
        KEnanR6TnKPxjCmJOMJq8jxSOms0SuJe2m7Q55m4CLXeaEqUcHy2hpfzsUZWa8zTqWJ1nGmb
        TCp9QeEJZuWqZ1dHcX7K9EFJdStmAZZDJcBfBGk5vP3FCFUC1onE9PcAHl9xE15DTM8C+HD1
        acFYALC5fNJjiHwVi71aQW8HcHDaRgqLYgwW9tVQ3mqSjoaF90twrxFMj2LwztyErwdO9wLY
        MdXuSwXRadB234l5maCfgZesD/28LQLoBNh3jhf2txF+/W0H7mV/ehssKrbjgn5TBI87OIGT
        4GztAilwEPyzu4kSOBTOudvXdBW82FixVquBC421mMAvw46hKt9kOL0ZfnM5TpA3wLLeS74I
        TgdC69KttXgAbKl+xJFwfqWNEHg9rL426CcwA1v/GAbCKVoB/Pvqux+D8Mr/O9QAUAfWc7xR
        q+KMCl6m497/786Ueq0d+B5y9M4W4Bqfju0EmAh0AijCJcEBQZNTSnFANptfwBn0mYY8DWfs
        BArP6X2Ch4Yo9Z6foDNlyuQJUnl8fLw8YUu8TPJkwLOJPUoxrWJNXC7H8ZzhUR0m8g+1YAWj
        BRlhW4qj6k6ZeYKn6iPjlupHMrN69tsuRuUUvxOSH+6SfsjnRm8qvVs5MNawOwSrqmEjnG8u
        9yz22lzYQWvage6398o2bL3umH/D2TtzIX9fjO2osn/89Z3RTs2pwrHE0lXHD7O3w1Q3XjQ8
        n3akIUXx48RirfXAQM5TD248SO52+XccSr5HONSp8qATZeKo9/oytGyS5rGusZXPLvQ4Lb9u
        hG2lVV86a1p+O4wtrFTVj0Te2TN09hyetWugcCImZe8xPvZeltqddvDa/j2bGP6kwh3WNJka
        aE7ZsaOpwixr1i5oRoJSUq+zT3z10WFzxmtmLdlXwohmuZ8CG/wLJYRRzcqicYOR/RfoUfZv
        UQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnK5w9etkg4bH6hYP5m1js1jSlGEx
        /8g5VotZ2+YyWnz8fY7FYsWXmewWfS8eMls09Pxmtdj0+BqrxeVdc9gszs47zmYx4/w+JouW
        Py0sFi1H21ks1h65y26xaOsXdov/e3awW/yZ/oHFovdwrcXmTVOZHUQ83mz6zu6xc9Zddo8F
        m0o9Nq3qZPO4c20Pm8e7c+fYPZ5cmc7ksXlJvcfGdzuYPBY1fGTz6NuyitHj8ya5AJ4oLpuU
        1JzMstQifbsEroxP/28xF7woqeiat5OpgbEhqYuRg0NCwETix6ncLkYuDiGB3YwS7Te2MXUx
        cgLFJSU+X1wHZQtLrPz3nB3EFhJoZpKYeascxGYT0JJo/NrFDNIsIvCKSeLwnhlgDrPABUaJ
        Wwe7wTqEBXwlrv/rZwWxWQRUJdb1/mMF2cwrYClxZmEBxAJ5idUbDjCD2JwCVhItrZuYIZZZ
        Ssz6tYpxAiPfAkaGVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwVGjpbmDcfuqD3qH
        GJk4GA8xSnAwK4nwCj99kSzEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC
        1CKYLBMHp1QDk8G+4CM2+mv7VvcLb57N75O+68UCj8fTjK4ta34ofMvtY3aa1D7vkBsTP0j3
        LQit1La8dPTU5miX/sYnxqfetv8uvqhS23aIjVmx8UKYy9cDE5WNY6X9+TLyUzZILk6tO798
        7/+X9nmvTkZ/mVnNUXcvaMOeK3sNuHquM95beknz8dYjBUtuHBXjmWnw+F3Du08SYb3Ju0UU
        7AKTUzcJ+TNd+Tvvr3xX5y8V66I9Pb/VmxfvyZivIPi/2KBSOtLi7fel958qX81cVrTD1Epw
        xoS3ymu4KvOOb+lwdjSXPl+nI9k0M6jtzIoPqSaWy36fq/7W7fvmZ+my1etOyRdPichRzFnL
        teKRvMfqbSdfL1BiKc5INNRiLipOBACp5VU4CQMAAA==
X-CMS-MailID: 20230214121411epcas5p25efd5d4242c512f21165df0c2e81b8bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121411epcas5p25efd5d4242c512f21165df0c2e81b8bc
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121411epcas5p25efd5d4242c512f21165df0c2e81b8bc@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current PCIe controller driver is being used for Exynos5433
SoC only. In order to extend this driver for all SoCs manufactured
by Samsung using DWC PCIe controller, rename this driver and make
it Samsung specific instead of any Samsung SoC name.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 MAINTAINERS                              |   4 +-
 drivers/pci/controller/dwc/Kconfig       |   6 +-
 drivers/pci/controller/dwc/Makefile      |   2 +-
 drivers/pci/controller/dwc/pci-samsung.c | 443 +++++++++++++++++++++++
 4 files changed, 449 insertions(+), 6 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pci-samsung.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a9d38274bd4d..e61374adf193 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16084,13 +16084,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/*rcar*
 F:	drivers/pci/controller/*rcar*
 
-PCI DRIVER FOR SAMSUNG EXYNOS
+PCI DRIVER FOR SAMSUNG
 M:	Jingoo Han <jingoohan1@gmail.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/controller/dwc/pci-exynos.c
+F:	drivers/pci/controller/dwc/pci-samsung.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 434f6a4f4041..837c7693ac6e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -80,13 +80,13 @@ config PCIE_DW_PLAT_EP
 	  order to enable device-specific features PCI_DW_PLAT_EP must be
 	  selected.
 
-config PCI_EXYNOS
-	tristate "Samsung Exynos PCIe controller"
+config PCI_SAMSUNG
+	tristate "Samsung PCIe controller"
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
-	  Enables support for the PCIe controller in the Samsung Exynos SoCs
+	  Enables support for the PCIe controller in the Samsung SoCs
 	  to work in host mode. The PCI controller is based on the DesignWare
 	  hardware and therefore the driver re-uses the DesignWare core
 	  functions to implement the driver.
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index bf5c311875a1..9daf9643342d 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
-obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
+obj-$(CONFIG_PCI_SAMSUNG) += pci-samsung.o
 obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
new file mode 100644
index 000000000000..cc562a8694fb
--- /dev/null
+++ b/drivers/pci/controller/dwc/pci-samsung.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Samsung SoCs
+ *
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *		https://www.samsung.com
+ *
+ * Author: Jingoo Han <jg1.han@samsung.com>
+ *	   Jaehoon Chung <jh80.chung@samsung.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regulator/consumer.h>
+#include <linux/module.h>
+
+#include "pcie-designware.h"
+
+#define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
+
+/* PCIe ELBI registers */
+#define PCIE_IRQ_PULSE			0x000
+#define IRQ_INTA_ASSERT			BIT(0)
+#define IRQ_INTB_ASSERT			BIT(2)
+#define IRQ_INTC_ASSERT			BIT(4)
+#define IRQ_INTD_ASSERT			BIT(6)
+#define PCIE_IRQ_LEVEL			0x004
+#define PCIE_IRQ_SPECIAL		0x008
+#define PCIE_IRQ_EN_PULSE		0x00c
+#define PCIE_IRQ_EN_LEVEL		0x010
+#define PCIE_IRQ_EN_SPECIAL		0x014
+#define PCIE_SW_WAKE			0x018
+#define PCIE_BUS_EN			BIT(1)
+#define PCIE_CORE_RESET			0x01c
+#define PCIE_CORE_RESET_ENABLE		BIT(0)
+#define PCIE_STICKY_RESET		0x020
+#define PCIE_NONSTICKY_RESET		0x024
+#define PCIE_APP_INIT_RESET		0x028
+#define PCIE_APP_LTSSM_ENABLE		0x02c
+#define PCIE_ELBI_RDLH_LINKUP		0x074
+#define PCIE_ELBI_XMLH_LINKUP		BIT(4)
+#define PCIE_ELBI_LTSSM_ENABLE		0x1
+#define PCIE_ELBI_SLV_AWMISC		0x11c
+#define PCIE_ELBI_SLV_ARMISC		0x120
+#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
+
+struct exynos_pcie {
+	struct dw_pcie			pci;
+	void __iomem			*elbi_base;
+	struct clk			*clk;
+	struct clk			*bus_clk;
+	struct phy			*phy;
+	struct regulator_bulk_data	supplies[2];
+};
+
+static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
+{
+	struct device *dev = ep->pci.dev;
+	int ret;
+
+	ret = clk_prepare_enable(ep->clk);
+	if (ret) {
+		dev_err(dev, "cannot enable pcie rc clock");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(ep->bus_clk);
+	if (ret) {
+		dev_err(dev, "cannot enable pcie bus clock");
+		goto err_bus_clk;
+	}
+
+	return 0;
+
+err_bus_clk:
+	clk_disable_unprepare(ep->clk);
+
+	return ret;
+}
+
+static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
+{
+	clk_disable_unprepare(ep->bus_clk);
+	clk_disable_unprepare(ep->clk);
+}
+
+static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
+{
+	writel(val, base + reg);
+}
+
+static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
+{
+	return readl(base + reg);
+}
+
+static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
+{
+	u32 val;
+
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
+	if (on)
+		val |= PCIE_ELBI_SLV_DBI_ENABLE;
+	else
+		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
+}
+
+static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
+{
+	u32 val;
+
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
+	if (on)
+		val |= PCIE_ELBI_SLV_DBI_ENABLE;
+	else
+		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
+}
+
+static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
+{
+	u32 val;
+
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
+	val &= ~PCIE_CORE_RESET_ENABLE;
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_NONSTICKY_RESET);
+}
+
+static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
+{
+	u32 val;
+
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
+	val |= PCIE_CORE_RESET_ENABLE;
+
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_APP_INIT_RESET);
+}
+
+static int exynos_pcie_start_link(struct dw_pcie *pci)
+{
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	u32 val;
+
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_SW_WAKE);
+	val &= ~PCIE_BUS_EN;
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_SW_WAKE);
+
+	/* assert LTSSM enable */
+	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
+			  PCIE_APP_LTSSM_ENABLE);
+	return 0;
+}
+
+static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
+{
+	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
+
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
+}
+
+static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
+{
+	struct exynos_pcie *ep = arg;
+
+	exynos_pcie_clear_irq_pulse(ep);
+	return IRQ_HANDLED;
+}
+
+static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
+{
+	u32 val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
+		  IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
+
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_PULSE);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_LEVEL);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_SPECIAL);
+}
+
+static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size)
+{
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	u32 val;
+
+	exynos_pcie_sideband_dbi_r_mode(ep, true);
+	dw_pcie_read(base + reg, size, &val);
+	exynos_pcie_sideband_dbi_r_mode(ep, false);
+	return val;
+}
+
+static void exynos_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+				  u32 reg, size_t size, u32 val)
+{
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+
+	exynos_pcie_sideband_dbi_w_mode(ep, true);
+	dw_pcie_write(base + reg, size, val);
+	exynos_pcie_sideband_dbi_w_mode(ep, false);
+}
+
+static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 *val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+
+	if (PCI_SLOT(devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	*val = dw_pcie_read_dbi(pci, where, size);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int exynos_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+
+	if (PCI_SLOT(devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dw_pcie_write_dbi(pci, where, size, val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops exynos_pci_ops = {
+	.read = exynos_pcie_rd_own_conf,
+	.write = exynos_pcie_wr_own_conf,
+};
+
+static int exynos_pcie_link_up(struct dw_pcie *pci)
+{
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
+
+	return (val & PCIE_ELBI_XMLH_LINKUP);
+}
+
+static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+
+	pp->bridge->ops = &exynos_pci_ops;
+
+	exynos_pcie_assert_core_reset(ep);
+
+	phy_init(ep->phy);
+	phy_power_on(ep->phy);
+
+	exynos_pcie_deassert_core_reset(ep);
+	exynos_pcie_enable_irq_pulse(ep);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
+	.host_init = exynos_pcie_host_init,
+};
+
+static int exynos_add_pcie_port(struct exynos_pcie *ep,
+				       struct platform_device *pdev)
+{
+	struct dw_pcie *pci = &ep->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pp->irq = platform_get_irq(pdev, 0);
+	if (pp->irq < 0)
+		return pp->irq;
+
+	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
+			       IRQF_SHARED, "exynos-pcie", ep);
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		return ret;
+	}
+
+	pp->ops = &exynos_pcie_host_ops;
+	pp->msi_irq[0] = -ENODEV;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.read_dbi = exynos_pcie_read_dbi,
+	.write_dbi = exynos_pcie_write_dbi,
+	.link_up = exynos_pcie_link_up,
+	.start_link = exynos_pcie_start_link,
+};
+
+static int exynos_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct exynos_pcie *ep;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	ep->pci.dev = dev;
+	ep->pci.ops = &dw_pcie_ops;
+
+	ep->phy = devm_of_phy_get(dev, np, NULL);
+	if (IS_ERR(ep->phy))
+		return PTR_ERR(ep->phy);
+
+	/* External Local Bus interface (ELBI) registers */
+	ep->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
+	if (IS_ERR(ep->elbi_base))
+		return PTR_ERR(ep->elbi_base);
+
+	ep->clk = devm_clk_get(dev, "pcie");
+	if (IS_ERR(ep->clk)) {
+		dev_err(dev, "Failed to get pcie rc clock\n");
+		return PTR_ERR(ep->clk);
+	}
+
+	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
+	if (IS_ERR(ep->bus_clk)) {
+		dev_err(dev, "Failed to get pcie bus clock\n");
+		return PTR_ERR(ep->bus_clk);
+	}
+
+	ep->supplies[0].supply = "vdd18";
+	ep->supplies[1].supply = "vdd10";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ep->supplies),
+				      ep->supplies);
+	if (ret)
+		return ret;
+
+	ret = exynos_pcie_init_clk_resources(ep);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, ep);
+
+	ret = exynos_add_pcie_port(ep, pdev);
+	if (ret < 0)
+		goto fail_probe;
+
+	return 0;
+
+fail_probe:
+	phy_exit(ep->phy);
+	exynos_pcie_deinit_clk_resources(ep);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+
+	return ret;
+}
+
+static int __exit exynos_pcie_remove(struct platform_device *pdev)
+{
+	struct exynos_pcie *ep = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&ep->pci.pp);
+	exynos_pcie_assert_core_reset(ep);
+	phy_power_off(ep->phy);
+	phy_exit(ep->phy);
+	exynos_pcie_deinit_clk_resources(ep);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+
+	return 0;
+}
+
+static int exynos_pcie_suspend_noirq(struct device *dev)
+{
+	struct exynos_pcie *ep = dev_get_drvdata(dev);
+
+	exynos_pcie_assert_core_reset(ep);
+	phy_power_off(ep->phy);
+	phy_exit(ep->phy);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+
+	return 0;
+}
+
+static int exynos_pcie_resume_noirq(struct device *dev)
+{
+	struct exynos_pcie *ep = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ep->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	if (ret)
+		return ret;
+
+	/* exynos_pcie_host_init controls ep->phy */
+	exynos_pcie_host_init(pp);
+	dw_pcie_setup_rc(pp);
+	exynos_pcie_start_link(pci);
+	return dw_pcie_wait_for_link(pci);
+}
+
+static const struct dev_pm_ops exynos_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(exynos_pcie_suspend_noirq,
+				  exynos_pcie_resume_noirq)
+};
+
+static const struct of_device_id exynos_pcie_of_match[] = {
+	{ .compatible = "samsung,exynos5433-pcie", },
+	{ },
+};
+
+static struct platform_driver exynos_pcie_driver = {
+	.probe		= exynos_pcie_probe,
+	.remove		= __exit_p(exynos_pcie_remove),
+	.driver = {
+		.name	= "exynos-pcie",
+		.of_match_table = exynos_pcie_of_match,
+		.pm		= &exynos_pcie_pm_ops,
+	},
+};
+module_platform_driver(exynos_pcie_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, exynos_pcie_of_match);
-- 
2.17.1

