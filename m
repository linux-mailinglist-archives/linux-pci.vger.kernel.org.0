Return-Path: <linux-pci+bounces-1420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4534A81EDDE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD8DB2239F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E6B2C68E;
	Wed, 27 Dec 2023 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="rS2gEy54";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="QuyBHjR5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74922C680
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 85CF3C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670368; bh=K1q0r4daYcjwSfUXX+zXBzWyzsX+BJADPAIW1bb5nK4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rS2gEy54njf5px1RGyznH59Oqa4Ba8Sz/1Y/sn3n4CwCl/zctF8oU0eMEK5fxX+6A
	 NXbf5XPCp84z0wVBHV0aBe3Hm+k7RF+y14tn9Ah0C6s8Aeaj/YL5SztdLNVKLvEmki
	 9lzuhN9FGhydeLXtACEyJPS5JBD2XNVXkAa2cXaXsSJOHAj3noWepdTXtlmecPrRJj
	 TldXXSeWEK888osKwCCvcKIsatdF1NG8DoU+LGelIuk9iONbjPRyDhnUhzpLHJyny6
	 p1VwaRFuiWb+7/sNbBPX9XHjv1YFGylEl0PdrryIaaK1oAJJNsbp1ST6WVBNwifUPh
	 K4vA+6nLnQJow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670368; bh=K1q0r4daYcjwSfUXX+zXBzWyzsX+BJADPAIW1bb5nK4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QuyBHjR5qhwsbVnfWdgXo+BXZf3LKQyZK1V1rnc6I6wZYEQUrnYkA5QZLFZ8bGrqP
	 eHfhuZmzjpVnZ/rMGhBzJ6mSXJSRaq9zhHi1QtqaYWROmM68gu3dGtmN90KzmW3Axw
	 JKA2sCq/txDmVaruczJp+9pJ5pC4bAgDgbxgXvEd7eG20jwV/1bGakCfrO+BvifEui
	 C/ZkYc/Lc0htkQh6+sjs3oqUbVWd7Fco0N43Kb49vSRWzQcntk/ZE3RE9RLif8+sTy
	 3zBpYqFoIuxMLeIewPw84QREEvywh4ypvQvTEZy2wPf4HiyDZ5KdRbFABqEo3f7JnH
	 arPjq3EEBPptQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 05/15] pciutils-pcilmr: Add functions for device checking and preparations before main margining processes
Date: Wed, 27 Dec 2023 14:44:54 +0500
Message-ID: <20231227094504.32257-6-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Follow the checklist from PCIe Base Spec Rev 5.0 section 4.2.13.3
"Receiver Margin Testing Requirements":
* Verify the Link is at 16 GT/s or higher data rate, in DO PM state;
* Verify that Margining Ready bit of the device is set;
* Disable the ASPM and Autonomous Speed/Width features for the duration
  of the test.

Also verify that Upstream Port of the Link is Function 0 of a Device,
according to spec, only it must implement margining registers.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h       |  55 +++++++++++++++++++
 lmr/margin_hw.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+)
 create mode 100644 lmr/lmr.h
 create mode 100644 lmr/margin_hw.c

diff --git a/lmr/lmr.h b/lmr/lmr.h
new file mode 100644
index 0000000..67fe0b0
--- /dev/null
+++ b/lmr/lmr.h
@@ -0,0 +1,55 @@
+/*
+ *	The PCI Utilities -- Margining utility main header
+ *
+ *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL v2+.
+ *
+ *	SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _LMR_H
+#define _LMR_H
+
+#include <stdbool.h>
+
+#include "pciutils.h"
+
+/* PCI Device wrapper for margining functions */
+struct margin_dev {
+  struct pci_dev *dev;
+  int lmr_cap_addr;
+  u8 width;
+  u8 retimers_n;
+  u8 link_speed;
+
+  /* Saved Device settings to restore after margining */
+  u8 aspm;
+  bool hasd; // Hardware Autonomous Speed Disable
+  bool hawd; // Hardware Autonomous Width Disable
+};
+
+struct margin_link {
+  struct margin_dev down_port;
+  struct margin_dev up_port;
+};
+
+/* margin_hw */
+
+/* Verify that devices form the link with 16 GT/s or 32 GT/s data rate */
+bool margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port);
+
+/* Check Margining Ready bit from Margining Port Status Register */
+bool margin_check_ready_bit(struct pci_dev *dev);
+
+/* Verify link and fill wrappers */
+bool margin_fill_link(struct pci_dev *down_port, struct pci_dev *up_port,
+                      struct margin_link *wrappers);
+
+/* Disable ASPM, set Hardware Autonomous Speed/Width Disable bits */
+bool margin_prep_link(struct margin_link *link);
+
+/* Restore ASPM, Hardware Autonomous Speed/Width settings */
+void margin_restore_link(struct margin_link *link);
+
+#endif
diff --git a/lmr/margin_hw.c b/lmr/margin_hw.c
new file mode 100644
index 0000000..c000132
--- /dev/null
+++ b/lmr/margin_hw.c
@@ -0,0 +1,138 @@
+/*
+ *	The PCI Utilities -- Verify and prepare devices before margining
+ *
+ *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL v2+.
+ *
+ *	SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "lmr.h"
+
+bool
+margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port)
+{
+  struct pci_cap *cap = pci_find_cap(down_port, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  if (!cap)
+    return false;
+  if ((pci_read_word(down_port, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED) < 4)
+    return false;
+  if ((pci_read_word(down_port, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED) > 5)
+    return false;
+
+  u8 down_type = pci_read_byte(down_port, PCI_HEADER_TYPE) & 0x7F;
+  u8 down_sec = pci_read_byte(down_port, PCI_SECONDARY_BUS);
+  u8 down_dir
+    = GET_REG_MASK(pci_read_word(down_port, cap->addr + PCI_EXP_FLAGS), PCI_EXP_FLAGS_TYPE);
+
+  // Verify that devices are linked, down_port is Root Port or Downstream Port of Switch,
+  // up_port is Function 0 of a Device
+  if (!(down_sec == up_port->bus && down_type == PCI_HEADER_TYPE_BRIDGE
+        && (down_dir == PCI_EXP_TYPE_ROOT_PORT || down_dir == PCI_EXP_TYPE_DOWNSTREAM)
+        && up_port->func == 0))
+    return false;
+
+  struct pci_cap *pm = pci_find_cap(up_port, PCI_CAP_ID_PM, PCI_CAP_NORMAL);
+  return pm && !(pci_read_word(up_port, pm->addr + PCI_PM_CTRL) & PCI_PM_CTRL_STATE_MASK); // D0
+}
+
+bool
+margin_check_ready_bit(struct pci_dev *dev)
+{
+  struct pci_cap *lmr = pci_find_cap(dev, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED);
+  return lmr && (pci_read_word(dev, lmr->addr + PCI_LMR_PORT_STS) & PCI_LMR_PORT_STS_READY);
+}
+
+/* Awaits device at 16 GT/s or higher */
+static struct margin_dev
+fill_dev_wrapper(struct pci_dev *dev)
+{
+  struct pci_cap *cap = pci_find_cap(dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  struct margin_dev res
+    = { .dev = dev,
+        .lmr_cap_addr = pci_find_cap(dev, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED)->addr,
+        .width = GET_REG_MASK(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA), PCI_EXP_LNKSTA_WIDTH),
+        .retimers_n
+        = (!!(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_RETIMER))
+          + (!!(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_2RETIMERS)),
+        .link_speed = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED) };
+  return res;
+}
+
+bool
+margin_fill_link(struct pci_dev *down_port, struct pci_dev *up_port, struct margin_link *wrappers)
+{
+  if (!margin_verify_link(down_port, up_port))
+    return false;
+  wrappers->down_port = fill_dev_wrapper(down_port);
+  wrappers->up_port = fill_dev_wrapper(up_port);
+  return true;
+}
+
+/* Disable ASPM, set Hardware Autonomous Speed/Width Disable bits */
+static bool
+margin_prep_dev(struct margin_dev *dev)
+{
+  struct pci_cap *pcie = pci_find_cap(dev->dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  if (!pcie)
+    return false;
+
+  u16 lnk_ctl = pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL);
+  dev->aspm = lnk_ctl & PCI_EXP_LNKCTL_ASPM;
+  dev->hawd = !!(lnk_ctl & PCI_EXP_LNKCTL_HWAUTWD);
+  lnk_ctl &= ~PCI_EXP_LNKCTL_ASPM;
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL, lnk_ctl);
+  if (pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM)
+    return false;
+
+  lnk_ctl |= PCI_EXP_LNKCTL_HWAUTWD;
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL, lnk_ctl);
+
+  u16 lnk_ctl2 = pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL2);
+  dev->hasd = !!(lnk_ctl2 & PCI_EXP_LNKCTL2_SPEED_DIS);
+  lnk_ctl2 |= PCI_EXP_LNKCTL2_SPEED_DIS;
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL2, lnk_ctl2);
+
+  return true;
+}
+
+/* Restore Device ASPM, Hardware Autonomous Speed/Width settings */
+static void
+margin_restore_dev(struct margin_dev *dev)
+{
+  struct pci_cap *pcie = pci_find_cap(dev->dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  if (!pcie)
+    return;
+
+  u16 lnk_ctl = pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL);
+  lnk_ctl = SET_REG_MASK(lnk_ctl, PCI_EXP_LNKCAP_ASPM, dev->aspm);
+  lnk_ctl = SET_REG_MASK(lnk_ctl, PCI_EXP_LNKCTL_HWAUTWD, dev->hawd);
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL, lnk_ctl);
+
+  u16 lnk_ctl2 = pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL2);
+  lnk_ctl2 = SET_REG_MASK(lnk_ctl2, PCI_EXP_LNKCTL2_SPEED_DIS, dev->hasd);
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL2, lnk_ctl2);
+}
+
+bool
+margin_prep_link(struct margin_link *link)
+{
+  if (!link)
+    return false;
+  if (!margin_prep_dev(&link->down_port))
+    return false;
+  if (!margin_prep_dev(&link->up_port))
+    {
+      margin_restore_dev(&link->down_port);
+      return false;
+    }
+  return true;
+}
+
+void
+margin_restore_link(struct margin_link *link)
+{
+  margin_restore_dev(&link->down_port);
+  margin_restore_dev(&link->up_port);
+}
-- 
2.34.1


