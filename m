Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81608372251
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhECVRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 17:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECVRt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 17:17:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FEFC061573
        for <linux-pci@vger.kernel.org>; Mon,  3 May 2021 14:16:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z9so5671294lfu.8
        for <linux-pci@vger.kernel.org>; Mon, 03 May 2021 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeUdJecAQ1EFBmsBBl7X0ql/Ifw+M/goFR+FKShjaLo=;
        b=zhGp2kGTw3vlEVfjhYFCtNJOAqf1HfplFQw791ZqhNotLlasQ1zML9yHB3OX6lSHdA
         SFgQijLpnwaQgujXjjSDEy0yjHlVoyhUKU9RGfzr50X11f2ayWp+x6yXsoj8USsxOa+1
         B6LDXSzlCjMk6nl7iOp4FYUyoEIrvIvwh/w7dOub31UVGdUMPwK+3M2pF63buDdODSd+
         mc8BABYe5vQ+5IN12Yy01x4QKbvska26GtBpaLqnR/574p/UHUxlBaBXcBTqJvSoaj7N
         0ma1E8mneMqu1K0Bw3o+12Xo3QOv7Wh39/vvR3p98trfdXCaGLeLFtunf6ndBlVz1Hzc
         OvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeUdJecAQ1EFBmsBBl7X0ql/Ifw+M/goFR+FKShjaLo=;
        b=cN2Cb2iNYZB/3wwLETGU9BS5dbAZ8svvJYYirGpqhQRS9v+1Pyl+mdK72ZpN7J3lJX
         pZ37qvUM1iablLxw03sM7otMJ82iY7mu4iEwgcizsGfkeBioIs844XjzwsV0BLeXh9BQ
         hQ0Bf4it4TTEki1RmlvfukUad6p1A/1Jai8G6lWRwEJTzmAACzBBglBFSGytl87Zd3B8
         GnQEnI6L36KKWkwsvbrM/Wn9NLGMn74YsqqZ9WIXJA7qdgmJ3rKAuUvQZS8UXulMSvvN
         ddM8rjpdf/ewPDMiGLusNVIMhLgBR/5UDdpj3pS+Nk1+xb0fZu1JbH9S4ejsMuP+a4d7
         oCgQ==
X-Gm-Message-State: AOAM533tN655YSxTWHtyduzXU9KReXBgEbgy8wuD+reF6xqm9Y+eWdQQ
        Xc7tO7Ei6d8u71t7gD7JhvghjA==
X-Google-Smtp-Source: ABdhPJwu/vgRKVdWmCHN0xj3FO/a4qJYzBvfsyIggIl3UqTaU1H9WftAAF6bZgsrueP2qcnMOKQcnA==
X-Received: by 2002:a19:f506:: with SMTP id j6mr8705696lfb.454.1620076613759;
        Mon, 03 May 2021 14:16:53 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m12sm67676lfb.72.2021.05.03.14.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:16:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/4] ARM/ixp4xx: Move the UART and exp bus virtbases
Date:   Mon,  3 May 2021 23:16:46 +0200
Message-Id: <20210503211649.4109334-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210503211649.4109334-1-linus.walleij@linaro.org>
References: <20210503211649.4109334-1-linus.walleij@linaro.org>
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

Move the UART1 and UART2 to the beginning of the fixmap
region at 0xFFC80000-0xFFC81FFF and move the expansion
bus base to 0xFFC82000-0xFFC81FFF in order to be able to
accommodate for the fixed PCI virtual IO space.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Zoltan HERPAI <wigyori@uid0.hu>
Cc: Raylynn Knight <rayknight@me.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
PCI maintainers: this patch is mostly FYI, will be
merged through ARM SoC
---
 arch/arm/Kconfig.debug                          | 4 ++--
 arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 7 ++++---
 arch/arm/mach-ixp4xx/ixp4xx-of.c                | 8 ++++++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9e0b5e7f12af..bbe799f6bc03 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1803,8 +1803,8 @@ config DEBUG_UART_VIRT
 	default 0xfedc0000 if DEBUG_EP93XX
 	default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
-	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
-	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
+	default 0xffc80000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
+	default 0xffc80003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xfef36000 if DEBUG_HIGHBANK_UART
 	default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
 	default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index 708d085ce39f..45b0f2c3a1d6 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -59,7 +59,7 @@
  * Expansion BUS Configuration registers
  */
 #define IXP4XX_EXP_CFG_BASE_PHYS	0xC4000000
-#define IXP4XX_EXP_CFG_BASE_VIRT	0xFEF14000
+#define IXP4XX_EXP_CFG_BASE_VIRT	0xFFC82000
 #define IXP4XX_EXP_CFG_REGION_SIZE	0x00001000
 
 #define IXP4XX_EXP_CS0_OFFSET	0x00
@@ -120,8 +120,9 @@
 #define IXP4XX_SSP_BASE_PHYS		(IXP4XX_PERIPHERAL_BASE_PHYS + 0x12000)
 
 
-#define IXP4XX_UART1_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x0000)
-#define IXP4XX_UART2_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x1000)
+/* The UART is explicitly put in the beginning of fixmap */
+#define IXP4XX_UART1_BASE_VIRT		(0xFFC80000)
+#define IXP4XX_UART2_BASE_VIRT		(0xFFC81000)
 #define IXP4XX_PMU_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x2000)
 #define IXP4XX_INTC_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x3000)
 #define IXP4XX_GPIO_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x4000)
diff --git a/arch/arm/mach-ixp4xx/ixp4xx-of.c b/arch/arm/mach-ixp4xx/ixp4xx-of.c
index 7449b8319c8a..e3d823c077e8 100644
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
+#define IXP4XX_EXP_CFG_BASE_VIRT	0xFFC82000
 
 static struct map_desc ixp4xx_of_io_desc[] __initdata = {
 	/*
-- 
2.29.2

