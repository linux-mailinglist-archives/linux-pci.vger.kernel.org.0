Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824681FCACF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 12:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFQK0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 06:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgFQK0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 06:26:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1EC06174E;
        Wed, 17 Jun 2020 03:26:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so1415786wmi.2;
        Wed, 17 Jun 2020 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyOYt/hZ78qkqCuLNwBMTOzpPldqERl5tEKy1066cA8=;
        b=Y8SfbPGb9SoBtaykZrGdMYW9whurnS0uBTfB2Hb1d+WTWnCSBMksE7I/p8a03FCxCO
         4y+gasOJKxKg59IPtS67pxSb9crip6/cdn3GqcMa+fy8AIMetNndsnD5n7W1mBMQ25OJ
         bNqd/A3dhUjnSYdCC/e/5vfddaa0bZBYKouhCQAaHfgEOyhJbf8x/yX476r0k3zIywaX
         /YizuZYuJTLdbdz5en4jnIu4muyswIO9CqkexfnYb39mdNmBMQ8mVkOjjjI41uRmUudI
         IjwxZ0aX4YbX5ngxKAblwNlIMtpwcwXZLYWXiobuhD5cnYPtzpqXDmx6niTRHn0EWTNM
         mrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyOYt/hZ78qkqCuLNwBMTOzpPldqERl5tEKy1066cA8=;
        b=Cwb1Plj6OXK+Cqueuj3r7fDU7Cds7KrOZoaY+iNlaeZ+z+1Qz7OhSDQoLB0bvjSyp9
         IFHqfRbRt/M+WON+3iXk3T42wOvalwngxX/edlFT8YONy/2cr7Dod0q1UraPpRxr8Tuw
         jLhqwDJmpDKgfF2gU5fXNKVt/OSUZCY3eg9pb1bah1HO0E8E3BgYtDOd8tFa65mqnnCf
         G6jJ3dInlhZDEk4BEpZqzn8h6EbZwMzmrRs4Nda0pKqeskC9wrAZ2ZzJzkNlG3AdBZ9p
         CISAjKhHgXHaUfaZ0LDYw9Hfb2sUYp9+mlYdsgXu5h13QZI7KWRc8iOOjBxG+l23e25L
         nAZw==
X-Gm-Message-State: AOAM5325A2Bn/CdPmk+ksnCz+N8F+VQs4eOKPgsaFRznn4+Jm4NSiyjG
        G6n36/Lc2dw31/Y2qed5YKk=
X-Google-Smtp-Source: ABdhPJzGD7+wp1HQGfixVxqrd93CCeIFMGpPQ/lqC8BEzOKqVAkBnBobX5S8UgcfBAtmSle9N2njXw==
X-Received: by 2002:a05:600c:2147:: with SMTP id v7mr7818570wml.101.1592389559958;
        Wed, 17 Jun 2020 03:25:59 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id z206sm7569847wmg.30.2020.06.17.03.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 03:25:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        jiaxun.yang@flygoat.com, paulburton@kernel.org, info@metux.net,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de, jonas.gorski@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/3] mips: bmips: add PCI support
Date:   Wed, 17 Jun 2020 12:25:54 +0200
Message-Id: <20200617102556.3792821-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617102556.3792821-1-noltari@gmail.com>
References: <20200617102556.3792821-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BMIPS SoCs with PCI: BCM6358, BCM6368.
BMIPS SoCs with PCIe (gen1): BCM6328, BCM6362, BCM63268.
BMIPS SoCs with PCIe (gen2): BCM6318.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/Kconfig           |  1 +
 arch/mips/pci/Makefile      |  1 +
 arch/mips/pci/fixup-bmips.c | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 arch/mips/pci/fixup-bmips.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6fee1a133e9d..357026cb51de 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -230,6 +230,7 @@ config BMIPS_GENERIC
 	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	select ARCH_HAS_PHYS_TO_DMA
 	select BOOT_RAW
+	select HAVE_PCI
 	select NO_EXCEPT_FILL
 	select USE_OF
 	select CEVT_R4K
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 0f68d6849978..e38285c10d45 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PCI_XTALK_BRIDGE)	+= pci-xtalk-bridge.o
 # These are still pretty much in the old state, watch, go blind.
 #
 obj-$(CONFIG_ATH79)		+= fixup-ath79.o
+obj-$(CONFIG_BMIPS_GENERIC)	+= fixup-bmips.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
diff --git a/arch/mips/pci/fixup-bmips.c b/arch/mips/pci/fixup-bmips.c
new file mode 100644
index 000000000000..581cff562ead
--- /dev/null
+++ b/arch/mips/pci/fixup-bmips.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (C) 2020 Álvaro Fernández Rojas <noltari@gmail.com>
+ */
+
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return of_irq_parse_and_map_pci(dev, slot, pin);
+}
-- 
2.27.0

