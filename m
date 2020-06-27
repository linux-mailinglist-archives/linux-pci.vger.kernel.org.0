Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F320C0B8
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jun 2020 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgF0KbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Jun 2020 06:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF0KbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Jun 2020 06:31:12 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEA7C03E979;
        Sat, 27 Jun 2020 03:31:12 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7F30EBC140;
        Sat, 27 Jun 2020 10:31:02 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     bhelgaas@google.com, corbet@lwn.net, robh+dt@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: PCI
Date:   Sat, 27 Jun 2020 12:30:50 +0200
Message-Id: <20200627103050.71712-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 Documentation/PCI/pci.rst                     |  4 ++--
 Documentation/devicetree/bindings/pci/pci.txt |  4 ++--
 arch/x86/pci/fixup.c                          |  4 ++--
 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c         |  2 +-
 drivers/pci/controller/dwc/pci-keystone.c     |  2 +-
 drivers/pci/controller/dwc/pcie-kirin.c       |  2 +-
 drivers/pci/pci-label.c                       |  2 +-
 drivers/pci/pcie/Kconfig                      |  2 +-
 drivers/pci/pcie/aer_inject.c                 |  2 +-
 drivers/pci/quirks.c                          | 10 +++++-----
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 8c016d8c9862..8abac7d5244b 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -17,7 +17,7 @@ PCI device drivers.
 A more complete resource is the third edition of "Linux Device Drivers"
 by Jonathan Corbet, Alessandro Rubini, and Greg Kroah-Hartman.
 LDD3 is available for free (under Creative Commons License) from:
-http://lwn.net/Kernel/LDD3/.
+https://lwn.net/Kernel/LDD3/.
 
 However, keep in mind that all documents are subject to "bit rot".
 Refer to the source code if things are not working as described here.
@@ -514,7 +514,7 @@ your driver if they're helpful, or just use plain hex constants.
 The device IDs are arbitrary hex numbers (vendor controlled) and normally used
 only in a single location, the pci_device_id table.
 
-Please DO submit new vendor/device IDs to http://pci-ids.ucw.cz/.
+Please DO submit new vendor/device IDs to https://pci-ids.ucw.cz/.
 There are mirrors of the pci.ids file at http://pciids.sourceforge.net/
 and https://github.com/pciutils/pciids.
 
diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 29bcbd88f457..6a8f2874a24d 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -1,12 +1,12 @@
 PCI bus bridges have standardized Device Tree bindings:
 
 PCI Bus Binding to: IEEE Std 1275-1994
-http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
+https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
 
 And for the interrupt mapping part:
 
 Open Firmware Recommended Practice: Interrupt Mapping
-http://www.devicetree.org/open-firmware/practice/imap/imap0_9d.pdf
+https://www.devicetree.org/open-firmware/practice/imap/imap0_9d.pdf
 
 Additionally to the properties specified in the above standards a host bridge
 driver implementation may support the following properties:
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 0c67a5a94de3..b8c9a5b87f37 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -557,12 +557,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_z
  * Device [8086:2fc0]
  * Erratum HSE43
  * CONFIG_TDP_NOMINAL CSR Implemented at Incorrect Offset
- * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
+ * https://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
  *
  * Devices [8086:6f60,6fa0,6fc0]
  * Erratum BDF2
  * PCI BARs in the Home Agent Will Return Non-Zero Values During Enumeration
- * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
+ * https://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
  */
 static void pci_invalid_bar(struct pci_dev *dev)
 {
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 6184ebc9392d..1b2e6e6fb818 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -2,7 +2,7 @@
 /*
  * pcie-dra7xx - PCIe controller driver for TI DRA7xx SoCs
  *
- * Copyright (C) 2013-2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2013-2014 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Kishon Vijay Abraham I <kishon@ti.com>
  */
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8f08ae53f53e..4e5c379ae418 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -3,7 +3,7 @@
  * PCIe host controller driver for Freescale i.MX6 SoCs
  *
  * Copyright (C) 2013 Kosagi
- *		http://www.kosagi.com
+ *		https://www.kosagi.com
  *
  * Author: Sean Cross <xobs@kosagi.com>
  */
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 790679fdfa48..5191cad906ca 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -3,7 +3,7 @@
  * PCIe host controller driver for Texas Instruments Keystone SoCs
  *
  * Copyright (C) 2013-2014 Texas Instruments., Ltd.
- *		http://www.ti.com
+ *		https://www.ti.com
  *
  * Author: Murali Karicheri <m-karicheri2@ti.com>
  * Implementation based on pci-exynos.c and pcie-designware.c
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index c19617a912bd..7b86c1608b04 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -3,7 +3,7 @@
  * PCIe host controller driver for Kirin Phone SoCs
  *
  * Copyright (C) 2017 HiSilicon Electronics Co., Ltd.
- *		http://www.huawei.com
+ *		https://www.huawei.com
  *
  * Author: Xiaowei Song <songxiaowei@huawei.com>
  */
diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 707dd9808676..781e45cf60d1 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -18,7 +18,7 @@
  * the instance number and string from the type 41 record and exports
  * it to sysfs.
  *
- * Please see http://linux.dell.com/files/biosdevname/ for more
+ * Please see https://linux.dell.com/files/biosdevname/ for more
  * information.
  */
 
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 9cd31331aee9..3946555a6042 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -43,7 +43,7 @@ config PCIEAER_INJECT
 	  error injection can fake almost all kinds of errors with the
 	  help of a user space helper tool aer-inject, which can be
 	  gotten from:
-	     http://www.kernel.org/pub/linux/utils/pci/aer-inject/
+	     https://www.kernel.org/pub/linux/utils/pci/aer-inject/
 
 #
 # PCI Express ECRC
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 21cc3d3387f7..c2cbf425afc5 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -6,7 +6,7 @@
  * trigger various real hardware errors. Software based error
  * injection can fake almost all kinds of errors with the help of a
  * user space helper tool aer-inject, which can be gotten from:
- *   http://www.kernel.org/pub/linux/utils/pci/aer-inject/
+ *   https://www.kernel.org/pub/linux/utils/pci/aer-inject/
  *
  * Copyright 2009 Intel Corporation.
  *     Huang Ying <ying.huang@intel.com>
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 812bfc32ecb8..54ebbef850be 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4620,11 +4620,11 @@ static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
  *
  * 0x9d10-0x9d1b PCI Express Root port #{1-12}
  *
- * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
- * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
- * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
- * [4] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-spec-update.html
- * [5] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-datasheet-vol-1.html
+ * [1] https://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
+ * [2] https://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
+ * [3] https://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
+ * [4] https://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-spec-update.html
+ * [5] https://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-datasheet-vol-1.html
  * [6] https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-u-y-processor-lines-i-o-spec-update.html
  * [7] https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-u-y-processor-lines-i-o-datasheet-vol-1.html
  */
-- 
2.27.0

