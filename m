Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA46137D475
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbhELSX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 14:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352007AbhELSCR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 May 2021 14:02:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C15661412;
        Wed, 12 May 2021 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620842468;
        bh=GutPSzuUf6F85g4iftkRTz0U4z28x4+3K52tl2pDK/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sHJz6gzysBU6/hYTO0WuppkT6XPlm0wa2L9py3HCEbH+SsO658KQEOZQcXKdWLmFZ
         2YYvFRSRmplKx38tb4UqF0y8wq3uKgB+Qu9KRHMNVJwEEHpxiTpi2t/VLiLFSvNVTK
         sGLow4yMqA6FwGqeTjYxQLSPE+NnOxus1qyh/naZ4uK3jEBCsXYSYG+nD1Sz90LDUT
         8PwFxS7zRWAvb9OUTx3ipNPlRu7Z9op/ZDelLj/PmeR9EP0sXR3nMuYSwwPy0ncbn2
         CVb/z/4T20jM7BwQLM5mnU+MyY4C2u+ITMnXJ8MU+POUSjYZCSQlOuw4uQ/hk+25m2
         MzSCJ9rUrzAGw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Robert Richter <rric@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.12 02/37] PCI: thunder: Fix compile testing
Date:   Wed, 12 May 2021 14:00:29 -0400
Message-Id: <20210512180104.664121-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512180104.664121-1-sashal@kernel.org>
References: <20210512180104.664121-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 16f7ae5906dfbeff54f74ec75d0563bb3a87ab0b ]

Compile-testing these drivers is currently broken. Enabling it causes a
couple of build failures though:

  drivers/pci/controller/pci-thunder-ecam.c:119:30: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
  drivers/pci/controller/pci-thunder-pem.c:54:2: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
  drivers/pci/controller/pci-thunder-pem.c:392:8: error: implicit declaration of function 'acpi_get_rc_resources' [-Werror,-Wimplicit-function-declaration]

Fix them with the obvious one-line changes.

Link: https://lore.kernel.org/r/20210308152501.2135937-2-arnd@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Robert Richter <rric@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-thunder-ecam.c |  2 +-
 drivers/pci/controller/pci-thunder-pem.c  | 13 +++++++------
 drivers/pci/pci.h                         |  6 ++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index f964fd26f7e0..ffd84656544f 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -116,7 +116,7 @@ static int thunder_ecam_p2_config_read(struct pci_bus *bus, unsigned int devfn,
 	 * the config space access window.  Since we are working with
 	 * the high-order 32 bits, shift everything down by 32 bits.
 	 */
-	node_bits = (cfg->res.start >> 32) & (1 << 12);
+	node_bits = upper_32_bits(cfg->res.start) & (1 << 12);
 
 	v |= node_bits;
 	set_val(v, where, size, val);
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 1a3f70ac61fc..0660b9da204f 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -12,6 +12,7 @@
 #include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include "../pci.h"
 
 #if defined(CONFIG_PCI_HOST_THUNDER_PEM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
@@ -324,9 +325,9 @@ static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg,
 	 * structure here for the BAR.
 	 */
 	bar4_start = res_pem->start + 0xf00000;
-	pem_pci->ea_entry[0] = (u32)bar4_start | 2;
-	pem_pci->ea_entry[1] = (u32)(res_pem->end - bar4_start) & ~3u;
-	pem_pci->ea_entry[2] = (u32)(bar4_start >> 32);
+	pem_pci->ea_entry[0] = lower_32_bits(bar4_start) | 2;
+	pem_pci->ea_entry[1] = lower_32_bits(res_pem->end - bar4_start) & ~3u;
+	pem_pci->ea_entry[2] = upper_32_bits(bar4_start);
 
 	cfg->priv = pem_pci;
 	return 0;
@@ -334,9 +335,9 @@ static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg,
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 
-#define PEM_RES_BASE		0x87e0c0000000UL
-#define PEM_NODE_MASK		GENMASK(45, 44)
-#define PEM_INDX_MASK		GENMASK(26, 24)
+#define PEM_RES_BASE		0x87e0c0000000ULL
+#define PEM_NODE_MASK		GENMASK_ULL(45, 44)
+#define PEM_INDX_MASK		GENMASK_ULL(26, 24)
 #define PEM_MIN_DOM_IN_NODE	4
 #define PEM_MAX_DOM_IN_NODE	10
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ef7c4661314f..9684b468267f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -624,6 +624,12 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
+#else
+static inline int acpi_get_rc_resources(struct device *dev, const char *hid,
+					u16 segment, struct resource *res)
+{
+	return -ENODEV;
+}
 #endif
 
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
-- 
2.30.2

