Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA76325196
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhBYOiQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 09:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhBYOiP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 09:38:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95E4964EC3;
        Thu, 25 Feb 2021 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614263854;
        bh=6Tt0YqzUup5G9sN7wbK/5I0h/g6iUR4Ib3aa4YlxGT8=;
        h=From:To:Cc:Subject:Date:From;
        b=rg089cuRZBVrAMbFXXK10J1eg57n1JeI/pb6iTygD7mke7oN3IVQL3elleAP2qgHb
         pC2aF2tPCPx9lC242d+AY3ofSr4/JTmw1KL1gJupzcCnWgTuuevpWiv2+RxfdTickz
         rKt9QLXUVulZOh5rzqiCbKay1E+eNKPPWuNKSVRzd4AViPeBrSRrBgIpxx+QBHiVhR
         Ou+H8BfM/+BSyPYkfUfyTVhSODBbkRiW5rH8pgXNfLQ/Aiu8XC2HnLCkoKH604SEkj
         rN4Y/+VU8c1AXjBcz0bneE6ePVLS3YoJZ8xG8uPFh0GRiLanVYYWMZfvOfKzto8JsI
         kFaLYfQHBqYMg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Richter <rric@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: controller: thunder: fix compile testing
Date:   Thu, 25 Feb 2021 15:37:09 +0100
Message-Id: <20210225143727.3912204-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing these drivers is currently broken. Enabling
it causes a couple of build failures though:

drivers/pci/controller/pci-thunder-ecam.c:119:30: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
drivers/pci/controller/pci-thunder-pem.c:54:2: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
drivers/pci/controller/pci-thunder-pem.c:392:8: error: implicit declaration of function 'acpi_get_rc_resources' [-Werror,-Wimplicit-function-declaration]

Fix them with the obvious one-line changes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
index 0a2b6d993fe1..022c2f433676 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -625,6 +625,12 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
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
2.29.2

