Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF882895BA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbgJIT5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 15:57:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38540 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389523AbgJITxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 15:53:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so10098107ota.5
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 12:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RuJMRkm/6mOfAA06cZuhfs1T0jl6aR1m0eqVuTh18Xg=;
        b=OpRx27J+Tz+68Rkazo5bLukNQL3yPQNt2LTtfucAMdIb0i5tANt1dG+09rGajSobkk
         k9+PTbZTkyGhh0ke8NJPhPR1i/3m2XWQw2zIsiBHzJ5rv2OI+deOtA4DW7B3RJQmVsb0
         nUwVspvS9RY3NaVsrNmef1iZaOdYoz9ujrFosbFJljEVHY6HeUvaUAkIIXzbyxFPncdN
         o1zWCcCo2tiMj5g3Fiie8D6XUXi1Datg6VkSWDlentVNSqrdlkoXFJjOKhnN0gJadRpY
         kaGhAK20OGT9YCXvr0LRmMfb2mfOgbAQ2KxKurXhDP3vVq84NbUJO3Hmx0QLGeCK0AGx
         JIow==
X-Gm-Message-State: AOAM5302zPuppUTjbnYG7dtAN7MQ+6uTMCrJlj7fSfEeeMCURO1uaili
        UhfNZcnwPjrt9XxwhBDzKvaofZ4GV1n6
X-Google-Smtp-Source: ABdhPJwi1Nt0bUQebv1yfgeFfw3DTpd+okHMVMA/kAzJwhWYLHi73v6K/4pHkplIlP85ycCMJBtTgA==
X-Received: by 2002:a9d:638d:: with SMTP id w13mr9789206otk.32.1602273212011;
        Fri, 09 Oct 2020 12:53:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t20sm8316526oot.22.2020.10.09.12.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 12:53:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: Move Rockchip driver to Cadence directory
Date:   Fri,  9 Oct 2020 14:53:30 -0500
Message-Id: <20201009195330.396775-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Rockchip PCIe host controller is in fact a Cadence based PCIe host.
This is most evident by comparing the address translation registers.

As a first step to merge the Rockchip driver into the Cadence driver,
let's just move the Rockchip driver into the Cadence directoy. This at
least makes the relationship obvious.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tom Joseph <tjoseph@cadence.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
This is going to conflict at least with 'PCI: rockchip: Fix bus checks 
in rockchip_pcie_valid_device()' and the common ECAM defines. 

 drivers/pci/controller/Kconfig                | 28 -------------------
 drivers/pci/controller/Makefile               |  3 --
 drivers/pci/controller/cadence/Kconfig        | 28 +++++++++++++++++++
 drivers/pci/controller/cadence/Makefile       |  3 ++
 .../{ => cadence}/pcie-rockchip-ep.c          |  0
 .../{ => cadence}/pcie-rockchip-host.c        |  2 +-
 .../controller/{ => cadence}/pcie-rockchip.c  |  2 +-
 .../controller/{ => cadence}/pcie-rockchip.h  |  0
 8 files changed, 33 insertions(+), 33 deletions(-)
 rename drivers/pci/controller/{ => cadence}/pcie-rockchip-ep.c (100%)
 rename drivers/pci/controller/{ => cadence}/pcie-rockchip-host.c (99%)
 rename drivers/pci/controller/{ => cadence}/pcie-rockchip.c (99%)
 rename drivers/pci/controller/{ => cadence}/pcie-rockchip.h (100%)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index f18c3725ef80..3ffc4ad01a33 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -202,34 +202,6 @@ config PCI_HOST_THUNDER_ECAM
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
 
-config PCIE_ROCKCHIP
-	bool
-	depends on PCI
-
-config PCIE_ROCKCHIP_HOST
-	tristate "Rockchip PCIe host controller"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
-	select MFD_SYSCON
-	select PCIE_ROCKCHIP
-	help
-	  Say Y here if you want internal PCI support on Rockchip SoC.
-	  There is 1 internal PCIe port available to support GEN2 with
-	  4 slots.
-
-config PCIE_ROCKCHIP_EP
-	bool "Rockchip PCIe endpoint controller"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
-	depends on PCI_ENDPOINT
-	select MFD_SYSCON
-	select PCIE_ROCKCHIP
-	help
-	  Say Y here if you want to support Rockchip PCIe controller in
-	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
-	  available to support GEN2 with 4 slots.
-
 config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index bcdbf49ab1e4..1c03d1178df0 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -23,9 +23,6 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
-obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
-obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
-obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 5d30564190e1..2bdf6eb03ed8 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -65,4 +65,32 @@ config PCI_J721E_EP
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
 	  core.
+
+config PCIE_ROCKCHIP
+	bool
+
+config PCIE_ROCKCHIP_HOST
+	tristate "Rockchip PCIe host controller"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on OF
+	depends on PCI_MSI_IRQ_DOMAIN
+	select MFD_SYSCON
+	select PCIE_ROCKCHIP
+	help
+	  Say Y here if you want internal PCI support on Rockchip SoC.
+	  There is 1 internal PCIe port available to support GEN2 with
+	  4 slots.
+
+config PCIE_ROCKCHIP_EP
+	bool "Rockchip PCIe endpoint controller"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on OF
+	depends on PCI_ENDPOINT
+	select MFD_SYSCON
+	select PCIE_ROCKCHIP
+	help
+	  Say Y here if you want to support Rockchip PCIe controller in
+	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
+	  available to support GEN2 with 4 slots.
+
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 9bac5fb2f13d..eb1aeae6c52b 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -4,3 +4,6 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
+obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
+obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/cadence/pcie-rockchip-ep.c
similarity index 100%
rename from drivers/pci/controller/pcie-rockchip-ep.c
rename to drivers/pci/controller/cadence/pcie-rockchip-ep.c
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/cadence/pcie-rockchip-host.c
similarity index 99%
rename from drivers/pci/controller/pcie-rockchip-host.c
rename to drivers/pci/controller/cadence/pcie-rockchip-host.c
index 0bb2fb3e8a0b..1ee409d7b7e5 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/cadence/pcie-rockchip-host.c
@@ -36,7 +36,7 @@
 #include <linux/reset.h>
 #include <linux/regmap.h>
 
-#include "../pci.h"
+#include "../../pci.h"
 #include "pcie-rockchip.h"
 
 static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/cadence/pcie-rockchip.c
similarity index 99%
rename from drivers/pci/controller/pcie-rockchip.c
rename to drivers/pci/controller/cadence/pcie-rockchip.c
index 904dec0d3a88..72ba71bab8e9 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/cadence/pcie-rockchip.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
-#include "../pci.h"
+#include "../../pci.h"
 #include "pcie-rockchip.h"
 
 int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/cadence/pcie-rockchip.h
similarity index 100%
rename from drivers/pci/controller/pcie-rockchip.h
rename to drivers/pci/controller/cadence/pcie-rockchip.h
-- 
2.25.1

