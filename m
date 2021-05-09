Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0A3778FD
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 00:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhEIWWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 18:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhEIWWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 18:22:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA24C061573
        for <linux-pci@vger.kernel.org>; Sun,  9 May 2021 15:21:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c3so20502850lfs.7
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zf+S7hvXyl8k4/OTCUtnv5DVgW50Qe9kDD2QLo75Eic=;
        b=N5ug85ebB91Ju07EvncOpKAYdBT1sOVqmHUdsUsgsrOoJuEvxnJRiIDNV/Y8s9Bvm5
         VVL7HRX+537AbZ6w1RAzREwmyBTh8rYUbL2f1MJ44NmBGHU9DjVjljIL96et25XIxj67
         u9fH4cX3Fb5h8DOSSXPBYvx0YNewx5q6wA8sD7/Y0lYTEmO7/G0lyoDI4RNqdgBfCYdw
         1H6Z5G3MfB8HgOh6ztH2tD0gLHwD0rV/RUL96YWPCdwdIbeQnzNo2KNzVYgmiLQRKzDN
         HIXjQic8B9MMn6rMnBqwuAcK4JVQI7AO3HvTQvhAUmG5pELC4Ey8LUVmcyCBXomxfhFr
         s8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zf+S7hvXyl8k4/OTCUtnv5DVgW50Qe9kDD2QLo75Eic=;
        b=ODkBlC9ARXGLWzrsUK1q2U9tZ9H2C/HXiG79lJBZ52kvH4qRKj9opOFobqwCpRPOUb
         eKdvxZkdIGlXPB4G52PuARuquLtUEj6v8t8NfF3THjDlNLymO6bz2rqeOMwJEORe/Obj
         8HZZVM2+wtP4Z9GDxKV/YMq9MEENiq2AZEyK9/IT25u/i/71pIJPXJWDM6JwhR/ODrYl
         Z1NXdsdC3+u4DDwW1pGadU1t7WsWlF3SR6UEaDPi8UkJslm5iWUu5MD0jEJaivZ4NnhC
         kjMNYK6//ettPbJ86awcZ0AHov6klD8m8WNLULagoF7h7jA11bPydSOEUoQ/IlC0YSZg
         k8kA==
X-Gm-Message-State: AOAM531uOKv/GEXmQTZdvjGDPQlBFdnU9sLW7eTB83j24nvy2gr/SzWN
        JrgK6jV6FZipJKPniX0yjkT50g==
X-Google-Smtp-Source: ABdhPJygLiDXDZtYmq8f0GFbVIJ8L9U7adTeiB5wUhFzMFYjEzXyvieC46iqA5iRNgU8NEkBfFOpfw==
X-Received: by 2002:a05:6512:12d0:: with SMTP id p16mr14832876lfg.232.1620598863857;
        Sun, 09 May 2021 15:21:03 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u12sm2978012ljo.82.2021.05.09.15.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 15:21:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4 v3] ARM/ixp4xx: Make NEED_MACH_IO_H optional
Date:   Mon, 10 May 2021 00:20:53 +0200
Message-Id: <20210509222055.341945-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210509222055.341945-1-linus.walleij@linaro.org>
References: <20210509222055.341945-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to create a proper PCI driver for the IXP4xx
we need to make the old PCI driver and its reliance
on <mach/io.h> optional.

Create a new Kconfig symbol for the legacy PCI driver
IXP4XX_PCI_LEGACY and only activate NEED_MACH_IO_H
for this driver.

A few files need to be adjusted to explicitly include
the <mach/hardware.h> and <mach/cpu.h> headers that
they previously obtained implicitly using <linux/io.h>
that would include <mach/io.h> and in turn include
these two headers.

This breaks our reliance on the old PCI and indirect
PCI support so we can reimplement a proper purely
DT-based driver in the PCI subsystem.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Zoltan HERPAI <wigyori@uid0.hu>
Cc: Raylynn Knight <rayknight@me.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes, resend with the rest of the patches.

PCI maintainers: this patch is mostly FYI, will be
merged through ARM SoC
---
 arch/arm/Kconfig                         |  3 ++-
 arch/arm/mach-ixp4xx/Kconfig             | 33 +++++++++++++++---------
 arch/arm/mach-ixp4xx/common.c            |  1 -
 arch/arm/mach-ixp4xx/fsg-setup.c         |  1 +
 arch/arm/mach-ixp4xx/nas100d-setup.c     |  1 +
 arch/arm/mach-ixp4xx/nslu2-setup.c       |  1 +
 drivers/ata/pata_ixp4xx_cf.c             |  1 +
 drivers/net/ethernet/xscale/ixp4xx_eth.c |  1 +
 drivers/soc/ixp4xx/ixp4xx-npe.c          |  2 ++
 drivers/soc/ixp4xx/ixp4xx-qmgr.c         |  2 ++
 10 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 853aab5ab327..4ca2ab19d265 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -394,7 +394,8 @@ config ARCH_IXP4XX
 	select HAVE_PCI
 	select IXP4XX_IRQ
 	select IXP4XX_TIMER
-	select NEED_MACH_IO_H
+	# With the new PCI driver this is not needed
+	select NEED_MACH_IO_H if PCI_IXP4XX_LEGACY
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	help
diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 165c184801e1..cabb37232704 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -20,7 +20,7 @@ config MACH_IXP4XX_OF
 config MACH_NSLU2
 	bool
 	prompt "Linksys NSLU2"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support Linksys's
 	  NSLU2 NAS device. For more information on this platform,
@@ -28,7 +28,7 @@ config MACH_NSLU2
 
 config MACH_AVILA
 	bool "Avila"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support the Gateworks
 	  Avila Network Platform. For more information on this platform,
@@ -44,7 +44,7 @@ config MACH_LOFT
 
 config ARCH_ADI_COYOTE
 	bool "Coyote"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support the ADI 
 	  Engineering Coyote Gateway Reference Platform. For more
@@ -52,7 +52,7 @@ config ARCH_ADI_COYOTE
 
 config MACH_GATEWAY7001
 	bool "Gateway 7001"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support Gateway's
 	  7001 Access Point. For more information on this platform,
@@ -60,7 +60,7 @@ config MACH_GATEWAY7001
 
 config MACH_WG302V2
 	bool "Netgear WG302 v2 / WAG302 v2"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support Netgear's
 	  WG302 v2 or WAG302 v2 Access Points. For more information
@@ -68,6 +68,7 @@ config MACH_WG302V2
 
 config ARCH_IXDP425
 	bool "IXDP425"
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support Intel's 
 	  IXDP425 Development Platform (Also known as Richfield).  
@@ -75,6 +76,7 @@ config ARCH_IXDP425
 
 config MACH_IXDPG425
 	bool "IXDPG425"
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support Intel's
 	  IXDPG425 Development Platform (Also known as Montajade).
@@ -120,7 +122,7 @@ config ARCH_PRPMC1100
 config MACH_NAS100D
 	bool
 	prompt "NAS100D"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support Iomega's
 	  NAS 100d device. For more information on this platform,
@@ -129,7 +131,7 @@ config MACH_NAS100D
 config MACH_DSMG600
 	bool
 	prompt "D-Link DSM-G600 RevA"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support D-Link's
 	  DSM-G600 RevA device. For more information on this platform,
@@ -143,7 +145,7 @@ config	ARCH_IXDP4XX
 config MACH_FSG
 	bool
 	prompt "Freecom FSG-3"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support Freecom's
 	  FSG-3 device. For more information on this platform,
@@ -152,7 +154,7 @@ config MACH_FSG
 config MACH_ARCOM_VULCAN
 	bool
 	prompt "Arcom/Eurotech Vulcan"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support Arcom's
 	  Vulcan board.
@@ -173,7 +175,7 @@ config CPU_IXP43X
 config MACH_GTWX5715
 	bool "Gemtek WX5715 (Linksys WRV54G)"
 	depends on ARCH_IXP4XX
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 		This board is currently inside the Linksys WRV54G Gateways.
 
@@ -196,7 +198,7 @@ config MACH_DEVIXP
 
 config MACH_MICCPT
 	bool "Omicron MICCPT"
-	select FORCE_PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
 	  Say 'Y' here if you want your kernel to support the MICCPT
 	  board from OMICRON electronics GmbH.
@@ -209,9 +211,16 @@ config MACH_MIC256
 
 comment "IXP4xx Options"
 
+config IXP4XX_PCI_LEGACY
+	bool "IXP4xx legacy PCI driver support"
+	depends on PCI
+	help
+	  Selects legacy PCI driver.
+	  Not recommended for new development.
+
 config IXP4XX_INDIRECT_PCI
 	bool "Use indirect PCI memory access"
-	depends on PCI
+	depends on IXP4XX_PCI_LEGACY
 	help
           IXP4xx provides two methods of accessing PCI memory space:
 
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 000f672a94c9..431da1b4f6bd 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -32,7 +32,6 @@
 #include <linux/dma-map-ops.h>
 #include <mach/udc.h>
 #include <mach/hardware.h>
-#include <mach/io.h>
 #include <linux/uaccess.h>
 #include <asm/page.h>
 #include <asm/exception.h>
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 507ee3878769..844329c5610d 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -28,6 +28,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
+#include <mach/hardware.h>
 
 #include "irqs.h"
 
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 6959ad2e3aec..6133cf01cbe4 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -33,6 +33,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
+#include <mach/hardware.h>
 
 #include "irqs.h"
 
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index a428bb918703..8526a70e401b 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -31,6 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/time.h>
+#include <mach/hardware.h>
 
 #include "irqs.h"
 
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index d1644a8ef9fa..9929d0150141 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <scsi/scsi_host.h>
+#include <mach/hardware.h>
 
 #define DRV_NAME	"pata_ixp4xx_cf"
 #define DRV_VERSION	"0.2"
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 0152f1e70783..88ad1639a7da 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -36,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/soc/ixp4xx/npe.h>
 #include <linux/soc/ixp4xx/qmgr.h>
+#include <mach/hardware.h>
 
 #include "ixp46x_ts.h"
 
diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index ec90b44fa0cd..0a16ac46ab59 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -20,6 +20,8 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/soc/ixp4xx/npe.h>
+#include <mach/hardware.h>
+#include <mach/cpu.h>
 
 #define DEBUG_MSG			0
 #define DEBUG_FW			0
diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 8c968382cea7..1b1631ac0438 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -12,6 +12,8 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/soc/ixp4xx/qmgr.h>
+#include <mach/hardware.h>
+#include <mach/cpu.h>
 
 static struct qmgr_regs __iomem *qmgr_regs;
 static int qmgr_irq_1;
-- 
2.30.2

