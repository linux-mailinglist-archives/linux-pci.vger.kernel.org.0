Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF946F536
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhLIUvP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhLIUvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:51:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68B2C061746;
        Thu,  9 Dec 2021 12:47:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o14so4795621plg.5;
        Thu, 09 Dec 2021 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zh0X5+rVgNsWbf9uxd460lDDPYN1b2Kyfl4DxVYiro0=;
        b=B4mGNT0i3LJgDjcIEuVnUtMDlUTWtYRdIMmmPHQX+ghy0u4CuacLdLz1LJUVo0ucW6
         eL5db02PewN4T1jlFQuLLZN8won/olk1ZLL2yTskSBNZhqrvJBHeboMX2xf5LnmCwkGF
         0lObZEV/RPkva30LCfK6wZjtvYxU7B+WPEguu4mlB9uSJMILaU8x1/2t2V+Av/HPYIbg
         ArETlIVAvKfJM1EhCF0MIc9GAezFkuodukeX4Omc45BQWPOxNjGqQbx67CI3+/SeW+VH
         tbLHyduloKvowL9BzW2q+OOH5uStdESZ1Gwk5Ekzjquy93Z48QUKXZ7G6HrWgCX8R9DE
         JpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zh0X5+rVgNsWbf9uxd460lDDPYN1b2Kyfl4DxVYiro0=;
        b=pEmE+kMxQDlt9zngd5lotkyynLvHiYF7nQF10VUBmXYiEbSUDzf9T1t4vNL9VKaUWj
         GbCuYFvzb30CumPVMKV/4DaiqI1MB7Kshhx0pN1CiTfL2mkGKCw2xMvtgOOxHMP4iY2o
         jr38DpNASHL535EPn7kenWhzieUAQQPW0+0CHmebAKePVWsZSc15/h/TaAsAJtwylB/1
         CnNzvebmflii4nHhZJTIRQ+pXpyPzaCV9BSf7er7dQ276X757sORbIkaABipPLbX06Xd
         TUPZUCp+hfeLWTEZa4t2d87bAkGMNJKT6XQbX5J3gaJO8ZeZreXtvDIp9gVeO1sDRsPc
         sHKA==
X-Gm-Message-State: AOAM532HLBBGOZBh6t2xmZegAqW0OQGAvWtcFBfjT2FP9brJo9cEL4Kh
        vvkOulrkN1u9jpa841G4ULZze2mbeyc=
X-Google-Smtp-Source: ABdhPJxV+54u3TmwobTLLCKay5/om3X8SoSfUagk5GfYhW1OX6yAo4/vFta7aRJq28EZVKxkpH8Gpg==
X-Received: by 2002:a17:902:ced0:b0:142:189a:4284 with SMTP id d16-20020a170902ced000b00142189a4284mr71467470plg.79.1639082860096;
        Thu, 09 Dec 2021 12:47:40 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id f185sm568370pfg.39.2021.12.09.12.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:47:39 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 3/4] MIPS: bmips: Remove obsolete DMA mapping support
Date:   Thu,  9 Dec 2021 15:47:24 -0500
Message-Id: <20211209204726.6676-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209204726.6676-1-jim2101024@gmail.com>
References: <20211209204726.6676-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The code in 'arch/mips/bmips/dma.c' performed DMA mapping for inbound
regions.  This mapping was and is required for the Broadcom STB PCIe
controller HW.  This code is removed as the current 'struct device' has a
@dma_range_map field which performs the same functionality by processing
the "dma-ranges" DT property.

Subsequently, ARCH_HAS_PHYS_TO_DMA is now unset since the dma_to_phys()
and phys_to_dma() functions are removed.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/Kconfig     |   1 -
 arch/mips/bmips/dma.c | 106 +-----------------------------------------
 2 files changed, 2 insertions(+), 105 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0215dc1529e9..eb1184a7254b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -264,7 +264,6 @@ config BMIPS_GENERIC
 	bool "Broadcom Generic BMIPS kernel"
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
-	select ARCH_HAS_PHYS_TO_DMA
 	select BOOT_RAW
 	select NO_EXCEPT_FILL
 	select USE_OF
diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 915ce4b189c1..c535f9cb75ec 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -1,68 +1,8 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2014 Kevin Cernekee <cernekee@gmail.com>
- */
+// SPDX-License-Identifier: GPL-2.0+
 
-#define pr_fmt(fmt)		"bmips-dma: " fmt
-
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-direct.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/printk.h>
-#include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/bmips.h>
-
-/*
- * BCM338x has configurable address translation windows which allow the
- * peripherals' DMA addresses to be different from the Zephyr-visible
- * physical addresses.  e.g. usb_dma_addr = zephyr_pa ^ 0x08000000
- *
- * If the "brcm,ubus" node has a "dma-ranges" property we will enable this
- * translation globally using the provided information.  This implements a
- * very limited subset of "dma-ranges" support and it will probably be
- * replaced by a more generic version later.
- */
-
-struct bmips_dma_range {
-	u32			child_addr;
-	u32			parent_addr;
-	u32			size;
-};
-
-static struct bmips_dma_range *bmips_dma_ranges;
-
-#define FLUSH_RAC		0x100
-
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t pa)
-{
-	struct bmips_dma_range *r;
-
-	for (r = bmips_dma_ranges; r && r->size; r++) {
-		if (pa >= r->child_addr &&
-		    pa < (r->child_addr + r->size))
-			return pa - r->child_addr + r->parent_addr;
-	}
-	return pa;
-}
-
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
-{
-	struct bmips_dma_range *r;
-
-	for (r = bmips_dma_ranges; r && r->size; r++) {
-		if (dma_addr >= r->parent_addr &&
-		    dma_addr < (r->parent_addr + r->size))
-			return dma_addr - r->parent_addr + r->child_addr;
-	}
-	return dma_addr;
-}
+#include <asm/io.h>
 
 void arch_sync_dma_for_cpu_all(void)
 {
@@ -79,45 +19,3 @@ void arch_sync_dma_for_cpu_all(void)
 	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
 	__raw_readl(cbr + BMIPS_RAC_CONFIG);
 }
-
-static int __init bmips_init_dma_ranges(void)
-{
-	struct device_node *np =
-		of_find_compatible_node(NULL, NULL, "brcm,ubus");
-	const __be32 *data;
-	struct bmips_dma_range *r;
-	int len;
-
-	if (!np)
-		return 0;
-
-	data = of_get_property(np, "dma-ranges", &len);
-	if (!data)
-		goto out_good;
-
-	len /= sizeof(*data) * 3;
-	if (!len)
-		goto out_bad;
-
-	/* add a dummy (zero) entry at the end as a sentinel */
-	bmips_dma_ranges = kcalloc(len + 1, sizeof(struct bmips_dma_range),
-				   GFP_KERNEL);
-	if (!bmips_dma_ranges)
-		goto out_bad;
-
-	for (r = bmips_dma_ranges; len; len--, r++) {
-		r->child_addr = be32_to_cpup(data++);
-		r->parent_addr = be32_to_cpup(data++);
-		r->size = be32_to_cpup(data++);
-	}
-
-out_good:
-	of_node_put(np);
-	return 0;
-
-out_bad:
-	pr_err("error parsing dma-ranges property\n");
-	of_node_put(np);
-	return -EINVAL;
-}
-arch_initcall(bmips_init_dma_ranges);
-- 
2.17.1

