Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1504E3778FC
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 00:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEIWWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhEIWWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 18:22:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138AC061573
        for <linux-pci@vger.kernel.org>; Sun,  9 May 2021 15:21:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i9so13944168lfe.13
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 15:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNke3Wg2Ntk9EmsCen3APo/ovEtU9o2zaCxzSbnHEjc=;
        b=E/riOnsyi0z1LVj74roTINvavou0wy/aH+tbOcLOWKnNl52bsoqcZY0xvpiMktv/xI
         5A69KJogEoICmslVDQxGNcmoDP67ec3mVcUBA8xxRYR9REsd0Ht4iaODg/B7CGdwna+6
         /IkxbUE5wOkjx8zmltpMRmt15a1pg2TIm8XxszspCuyftJnCZZXqfIEX9ZSlwDv0KtEv
         I7U4XZjHFrW4SENTQ48qVXZKbQpRbK2aTqbRx/sw7pQBA0T0QfNwuDFBowXsY333Iwnm
         McHw7WiVLXuiB2CucJhrMN7KSHfZGqLxYtrvFHmynWnIHFP04CvJcx98CJzurvf7xFKp
         DWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNke3Wg2Ntk9EmsCen3APo/ovEtU9o2zaCxzSbnHEjc=;
        b=gQGZUxhIfdOO0fV0Xr7yBX2ZK+Ly67R1HIS6dxJTF6JbGOaROWc025cnbYcNN7EekA
         4v9iJbHa2cO3N103hqRi+KVZeJ9aMX8ltcQDJWHwPpjrPVrC9zBR1umx/r6RxP/7Q7qP
         94OVIBzMbnLVzcZtf7yMyjHXEeROUBxtTBSe3lxreqiubxlyfrbvNZfRROJSoMjgEc5P
         DylF6lgoGgX4RcUHaxY6fTk52BNDDu9x4CO8z9pvbu7U7VZF7BNXYlj7UDt4QXE8km3k
         71nIJ5Ov6TZy8prbWcvHltiYX4w+gJGoJdhT7ZbXOuNqk4ozTKp7Q4Eej8y5wgYXRmwg
         sPtw==
X-Gm-Message-State: AOAM530kYdWDP7TzhIg7am/8LSXFf2MfdgoYncXdrLr7cZQqNVUKH9lK
        unbrMSsk3sagwTxVAAlauuvTQux0J76qvg==
X-Google-Smtp-Source: ABdhPJxWl2X24W0gh7u2BYDaANrXtvvx7rcfVGg85va5f0PByl5HL9ebofT8nhpAYJ9sk+10RCHTjA==
X-Received: by 2002:a05:6512:3d0f:: with SMTP id d15mr14937066lfv.639.1620598862132;
        Sun, 09 May 2021 15:21:02 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u12sm2978012ljo.82.2021.05.09.15.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 15:21:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/4 v3] ARM/ixp4xx: Move the virtual IObases
Date:   Mon, 10 May 2021 00:20:52 +0200
Message-Id: <20210509222055.341945-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210509222055.341945-1-linus.walleij@linaro.org>
References: <20210509222055.341945-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UART1, UART2 and the expansion bus config registers
are the only registers mapped in a fixed location
when using device tree.

For device tree we also want to get rid of the custom
<mach/io.h> for IXP4xx. So we need to undefine
CONFIG_NEED_MACH_IO_H. Doing that activates the fixed
mapping of the PCI IO space to PCI_IO_VIRT_BASE which
is hardcoded to 0xFEE00000 and this would collide with
the old fixed mappings.

Move the fixed virtual IO base address from 0xFEF00000
to 0xFEC00000 in order to avoid the collision.

For the OF-only boot path let's even cut the reliance
on <mach/io.h> and just hardcode the one single virtbase
we need apart from the UART, which is hardcoded in
Kconfig.debug.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Zoltan HERPAI <wigyori@uid0.hu>
Cc: Raylynn Knight <rayknight@me.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes, resend with the rest of the patches.
ChangeLog v1->v2:
- Instead of handling the UART and expansion ports
  separately just move all peripherals from 0xfef00000
  to 0xfec00000.
- Stay out of the fixmap area, that area has special
  uses.

PCI maintainers: this patch is mostly FYI, will be
merged through ARM SoC
---
 arch/arm/Kconfig.debug                          | 4 ++--
 arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 7 ++++---
 arch/arm/mach-ixp4xx/ixp4xx-of.c                | 8 ++++++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9e0b5e7f12af..f672b23301e6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1803,8 +1803,8 @@ config DEBUG_UART_VIRT
 	default 0xfedc0000 if DEBUG_EP93XX
 	default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
-	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
-	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
+	default 0xfec00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
+	default 0xfec00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xfef36000 if DEBUG_HIGHBANK_UART
 	default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
 	default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index 708d085ce39f..f375c1c005d4 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -45,21 +45,21 @@
  * it can be used with the low-level debug code.
  */
 #define IXP4XX_PERIPHERAL_BASE_PHYS	0xC8000000
-#define IXP4XX_PERIPHERAL_BASE_VIRT	IOMEM(0xFEF00000)
+#define IXP4XX_PERIPHERAL_BASE_VIRT	IOMEM(0xFEC00000)
 #define IXP4XX_PERIPHERAL_REGION_SIZE	0x00013000
 
 /*
  * PCI Config registers
  */
 #define IXP4XX_PCI_CFG_BASE_PHYS	0xC0000000
-#define IXP4XX_PCI_CFG_BASE_VIRT	IOMEM(0xFEF13000)
+#define IXP4XX_PCI_CFG_BASE_VIRT	IOMEM(0xFEC13000)
 #define IXP4XX_PCI_CFG_REGION_SIZE	0x00001000
 
 /*
  * Expansion BUS Configuration registers
  */
 #define IXP4XX_EXP_CFG_BASE_PHYS	0xC4000000
-#define IXP4XX_EXP_CFG_BASE_VIRT	0xFEF14000
+#define IXP4XX_EXP_CFG_BASE_VIRT	0xFEC14000
 #define IXP4XX_EXP_CFG_REGION_SIZE	0x00001000
 
 #define IXP4XX_EXP_CS0_OFFSET	0x00
@@ -120,6 +120,7 @@
 #define IXP4XX_SSP_BASE_PHYS		(IXP4XX_PERIPHERAL_BASE_PHYS + 0x12000)
 
 
+/* The UART is explicitly put in the beginning of fixmap */
 #define IXP4XX_UART1_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x0000)
 #define IXP4XX_UART2_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x1000)
 #define IXP4XX_PMU_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x2000)
diff --git a/arch/arm/mach-ixp4xx/ixp4xx-of.c b/arch/arm/mach-ixp4xx/ixp4xx-of.c
index 7449b8319c8a..f9904716ec7f 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx-of.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx-of.c
@@ -9,8 +9,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
-#include <mach/ixp4xx-regs.h>
+/*
+ * These are the only fixed phys to virt mappings we ever need
+ * we put it right after the UART mapping at 0xffc80000-0xffc81fff
+ */
+#define IXP4XX_EXP_CFG_BASE_PHYS	0xC4000000
+#define IXP4XX_EXP_CFG_BASE_VIRT	0xFEC14000
 
 static struct map_desc ixp4xx_of_io_desc[] __initdata = {
 	/*
-- 
2.30.2

