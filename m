Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E61754228
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjGNSDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbjGNSCi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 14:02:38 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B8358C;
        Fri, 14 Jul 2023 11:01:59 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-66869feb7d1so1541777b3a.3;
        Fri, 14 Jul 2023 11:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357655; x=1691949655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBtCJ1Wj7uyT3akzTe+POqH017QGVk7t8G9DBPGwg8k=;
        b=TUeZaO75Vv4v/tepCTDNeIblEJPzFCNrxe0bptYKSJaMywz9GDBsVfYj0/s8Rd9mrB
         h9J/gi8wVmoDXAoeo9PxlGAvpBbxKCSqqd9EK74yJGPwfmwHXKZ1YLY5QlYO4s+QRG8A
         BIXLQCv7GRmpQQqNgLv+gZAB2MormbFrCvWz/h9zWkWBBldEx8v9wQcX3XrpDCEZ5TDS
         EvRvYs+EP20XG3K3mEd/orKkbQhlXwgQ1hurSSGWe4JeeGN3YmhHVUFiz6YDxa8hg2b2
         NEgNMF/ny8HVbzoXnfA3rg2jTuH8C5ZeSBV+JRPkbIqs58PIcCGZQMnXyr0KPWyzNGmS
         JZlg==
X-Gm-Message-State: ABy/qLauDdni5rLQc80zKOTD650W7EoZY171bUA3Vtutf2vntO8bT7kx
        FFrXZoirryMOGVACZbLZqACfxJYXVSjR
X-Google-Smtp-Source: APBJJlF8/H7PmCypetZ49vRz8/piqGg71JXmwKFXt4Fz7m/Z/JPp9nESxuf4M6YPl/KXPamXOPxMZw==
X-Received: by 2002:a6b:a04:0:b0:776:fd07:3c96 with SMTP id z4-20020a6b0a04000000b00776fd073c96mr5721801ioi.7.1689356924343;
        Fri, 14 Jul 2023 10:48:44 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u14-20020a6be30e000000b00786f5990435sm2843368ioc.7.2023.07.14.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:48:43 -0700 (PDT)
Received: (nullmailer pid 4061709 invoked by uid 1000);
        Fri, 14 Jul 2023 17:48:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Chuanhua Lei <lchuanhua@maxlinear.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:48:25 -0600
Message-Id: <20230714174827.4061572-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/cadence/pci-j721e.c           | 2 +-
 drivers/pci/controller/cadence/pcie-cadence-plat.c   | 3 +--
 drivers/pci/controller/cadence/pcie-cadence.c        | 1 +
 drivers/pci/controller/dwc/pci-dra7xx.c              | 2 +-
 drivers/pci/controller/dwc/pci-exynos.c              | 2 +-
 drivers/pci/controller/dwc/pci-imx6.c                | 2 +-
 drivers/pci/controller/dwc/pci-keystone.c            | 1 -
 drivers/pci/controller/dwc/pci-meson.c               | 2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c            | 2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c    | 2 +-
 drivers/pci/controller/dwc/pcie-designware.c         | 2 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c        | 2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c           | 2 ++
 drivers/pci/controller/dwc/pcie-kirin.c              | 3 +--
 drivers/pci/controller/dwc/pcie-qcom.c               | 2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c           | 1 -
 drivers/pci/controller/dwc/pcie-uniphier-ep.c        | 2 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 3 ---
 drivers/pci/controller/pci-ftpci100.c                | 3 +--
 drivers/pci/controller/pci-host-common.c             | 2 +-
 drivers/pci/controller/pci-ixp4xx.c                  | 3 +--
 drivers/pci/controller/pci-loongson.c                | 2 +-
 drivers/pci/controller/pci-v3-semi.c                 | 3 +--
 drivers/pci/controller/pcie-altera.c                 | 5 ++---
 drivers/pci/controller/pcie-rockchip-host.c          | 4 +---
 drivers/pci/controller/pcie-rockchip.c               | 1 +
 drivers/pci/endpoint/pci-epc-core.c                  | 1 -
 drivers/pci/probe.c                                  | 1 -
 28 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index e70213c9060a..2c87e7728a65 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -14,8 +14,8 @@
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index bac0541317c1..371ffc1f00f8 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -6,11 +6,10 @@
  * Author: Tom Joseph <tjoseph@cadence.com>
  */
 #include <linux/kernel.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/of_device.h>
 #include "pcie-cadence.h"
 
 #define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 13c4032ca379..4251fac5e310 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -4,6 +4,7 @@
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
 #include <linux/kernel.h>
+#include <linux/of.h>
 
 #include "pcie-cadence.h"
 
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4ae807e7cf79..b445ffe95e3f 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -16,7 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index ec5611005566..6319082301d6 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -14,11 +14,11 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 
 #include "pcie-designware.h"
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 27aaa2a6bf39..d123797a06a2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -17,8 +17,8 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
-#include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 78818853af9e..49aea6ce3e87 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -19,7 +19,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/msi.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index c1527693bed9..973b0fc81315 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -9,7 +9,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -17,6 +16,7 @@
 #include <linux/resource.h>
 #include <linux/types.h>
 #include <linux/phy/phy.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 
 #include "pcie-designware.h"
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 98102079e26d..9b572a2b2c9a 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -10,7 +10,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 1fcfb840f238..b625841e98aa 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -12,7 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c87848cd8686..2459f2a61b9b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -16,7 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c1e7653e508e..2fe42c70097f 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -14,7 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 9c7caed9e706..c9c93524e01d 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -9,9 +9,11 @@
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pci_regs.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 
 #include "../../pci.h"
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d09507f822a7..d93bc2906950 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -16,8 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7a87a47eb7ed..cee4e400a695 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -19,7 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e1db909f53ec..383ba71d1e8f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 4d0a587c0ba5..cba3c88fcf39 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -11,7 +11,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 31a7bdebe540..45b97a4b14db 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -17,9 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/msi.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 6e7981d2ed5e..ffdeed25e961 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -15,8 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d3924a44db02..6be3266cd7b5 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -9,8 +9,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
index e44252db6085..acb85e0d5675 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -19,8 +19,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index fe0f732f6e43..d45e7b8dc530 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
  */
 
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index ca44b0c83d1b..0917f571bb6d 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -20,8 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index c95a29fff8bf..a9536dc4bf96 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -9,11 +9,10 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 2438bc9b3a1a..afbbdccd195d 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -24,10 +24,8 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
-#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/phy/phy.h>
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 1aa84035a8bc..0ef2e622d36e 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
+#include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c54fa5684d2..5a4a8b0be626 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -9,7 +9,6 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8bac3ce02609..31fb02fbb2cc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
-#include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
-- 
2.40.1

