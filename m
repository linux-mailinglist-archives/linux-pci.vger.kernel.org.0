Return-Path: <linux-pci+bounces-664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F8809F45
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0989AB20C07
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640F7125A6;
	Fri,  8 Dec 2023 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="u8Ydd0LG";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Tkvx93RI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8498E172D
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 49437C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027145; bh=VaBG1eoDne5ppfbxM8kSBEppntuhKQgnMBl1lri2pzQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=u8Ydd0LGsS36B6lUcaa6+BqNVPPocRveVT4PJMA+SLtedxnlFh6vzgEd/4IhurxgN
	 XSOqa63Fhxw8Pgfq80V+ugv8Z0DZiqHMph2c7lEvzgQ9zJtxvGYXo2wOuV6zo2Us+Q
	 fKpaQd09xsWAtjXgaUKa1pdrNrehTtNz4kS03aEnxePdXJvnhnjh4vR+TCoV51IDPk
	 JIBLLZ4wmtn/W/AhvPVKCNU9+CAVYwSXrfjh3CiUZdjC1tt6prdWOG6mXeOkktClJU
	 MayGt0ehV/G4HEV2ceBh4BLZFC1/TU5ELkmZk3z649VsW9W7fbkjjYDZ3/9C8JS8yt
	 Gvbug1PpNXFZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027145; bh=VaBG1eoDne5ppfbxM8kSBEppntuhKQgnMBl1lri2pzQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Tkvx93RIW+G/LwA+9x97mCU+qvZgo3Sn6j7thH9aOMXFwMdNRezMDWM5BsAnQCdRX
	 IhZDIhgzLTThIvwuZEP3CmeeKWtpfKAlWV+q6FPCbTlcH3zmOUlUFAIKaLJp4lBClM
	 o9Ci3Bm3m1nYATZXXmglgx2+YmIM8aXLR9GgKhZJhgQTAvCdlD+gRHeEYqGoKDxSfF
	 ZqhBP5Iiq5GF0P8JphvH3H5lpYxUtIJaWIpagy1755TioPFmgx1+4ORshIHPGurHt3
	 5k79Ek1MDjZPGhQGJsAK8c81cBVmrm6Cn5fkaeJBdwK7hPFutPhqLiPyqfS8CPzYO4
	 do/RlYiR/BjTw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 04/15] pciutils-pcilmr: Add functions for device checking and preparations before main margining processes
Date: Fri, 8 Dec 2023 12:17:23 +0300
Message-ID: <20231208091734.12225-5-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091734.12225-1-n.proshkin@yadro.com>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Follow the checklist from the section 4.2.13.3 "Receiver Margin Testing
Requirements" of the 5.0 spec:
* Verify the Link is at 16 GT/s or higher data rate, in DO PM state;
* Verify that Margining Ready bit of the device is set;
* Disable the ASPM and Autonomous Speed/Width features for the duration
  of the test.

Also verify that Upstream Port of the Link is Function 0 of a Device,
according to spec,only it must implement margining registers.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 Makefile            |  5 ++-
 lmr_lib/Makefile    | 10 ++++++
 lmr_lib/margin_hw.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 lmr_lib/margin_hw.h | 39 +++++++++++++++++++++
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 lmr_lib/Makefile
 create mode 100644 lmr_lib/margin_hw.c
 create mode 100644 lmr_lib/margin_hw.h

diff --git a/Makefile b/Makefile
index 228cb56..bd636bd 100644
--- a/Makefile
+++ b/Makefile
@@ -67,11 +67,14 @@ PCIINC_INS=lib/config.h lib/header.h lib/pci.h lib/types.h
 
 export
 
-all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS)
+all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS) lmr_lib/liblmr.a
 
 lib/$(PCIIMPLIB): $(PCIINC) force
 	$(MAKE) -C lib all
 
+lmr_lib/liblmr.a: $(PCIINC) force
+	$(MAKE) -C lmr_lib all
+
 force:
 
 lib/config.h lib/config.mk:
diff --git a/lmr_lib/Makefile b/lmr_lib/Makefile
new file mode 100644
index 0000000..4f85a17
--- /dev/null
+++ b/lmr_lib/Makefile
@@ -0,0 +1,10 @@
+OBJS=margin_hw
+INCL=$(addsuffix .h,$(OBJS)) $(addprefix ../,$(PCIINC))
+
+$(addsuffix .o, $(OBJS)): %.o: %.c $(INCL)
+
+all: liblmr.a
+
+liblmr.a: $(addsuffix .o, $(OBJS))
+	rm -f $@
+	$(AR) rcs $@ $^
diff --git a/lmr_lib/margin_hw.c b/lmr_lib/margin_hw.c
new file mode 100644
index 0000000..dcc6593
--- /dev/null
+++ b/lmr_lib/margin_hw.c
@@ -0,0 +1,85 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "margin_hw.h"
+
+bool margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port)
+{
+  struct pci_cap *cap = pci_find_cap(down_port, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  if (!cap)
+    return false;
+  if ((pci_read_word(down_port, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED) < 4)
+    return false;
+  if ((pci_read_word(down_port, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED) > 5)
+    return false;
+
+  uint8_t down_type = pci_read_byte(down_port, PCI_HEADER_TYPE) & 0x7F;
+  uint8_t down_sec = pci_read_byte(down_port, PCI_SECONDARY_BUS);
+  uint8_t down_dir = (pci_read_word(down_port, cap->addr + PCI_EXP_FLAGS) & PCI_EXP_FLAGS_TYPE) >> 4;
+
+  // Verify that devices are linked, down_port is Root Port or Downstream Port of Switch,
+  // up_port is Function 0 of a Device
+  if (!(down_sec == up_port->bus && down_type == 1 
+      && (down_dir == 4 || down_dir == 6) && up_port->func == 0))
+    return false;
+
+  struct pci_cap *pm = pci_find_cap(up_port, PCI_CAP_ID_PM, PCI_CAP_NORMAL);
+  return !(pci_read_word(up_port, pm->addr + PCI_PM_CTRL) & PCI_PM_CTRL_STATE_MASK); // D0
+}
+
+bool margin_check_ready_bit(struct pci_dev *dev)
+{
+  struct pci_cap *lmr = pci_find_cap(dev, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED);
+  return lmr && (pci_read_word(dev, lmr->addr + PCI_LMR_PORT_STS) & PCI_LMR_PORT_STS_READY);
+}
+
+struct margin_dev margin_fill_wrapper(struct pci_dev *dev)
+{
+  struct pci_cap *cap = pci_find_cap(dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  struct margin_dev res = {
+      .dev = dev,
+      .lmr_cap_addr = pci_find_cap(dev, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED)->addr,
+      .width = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_WIDTH) >> 4,
+      .retimers_n = ((pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_RETIMER) > 0) +
+                    ((pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_2RETIMERS) > 0),
+      .link_speed = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED)};
+  return res;
+}
+
+bool margin_prep_dev(struct margin_dev *dev)
+{
+  struct pci_cap *pcie = pci_find_cap(dev->dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+
+  uint16_t lnk_ctl = pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL);
+  dev->aspm = lnk_ctl & PCI_EXP_LNKCTL_ASPM;
+  dev->hawd = lnk_ctl & PCI_EXP_LNKCTL_HWAUTWD;
+  lnk_ctl &= ~PCI_EXP_LNKCTL_ASPM;
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL, lnk_ctl);
+  if (pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM)
+    return false;
+
+  lnk_ctl |= PCI_EXP_LNKCTL_HWAUTWD;
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL, lnk_ctl);
+
+  uint16_t lnk_ctl2 = pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL2);
+  dev->hasd = lnk_ctl2 & PCI_EXP_LNKCTL2_SPEED_DIS;
+  lnk_ctl2 |= PCI_EXP_LNKCTL2_SPEED_DIS;
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL2, lnk_ctl2);
+
+  return true;
+}
+
+void margin_restore_dev(struct margin_dev *dev)
+{
+  struct pci_cap *pcie = pci_find_cap(dev->dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+
+  uint16_t lnk_ctl = pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL);
+  lnk_ctl |= dev->aspm;
+  lnk_ctl &= (~PCI_EXP_LNKCTL_HWAUTWD | dev->hawd);
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL, lnk_ctl);
+
+  uint16_t lnk_ctl2 = pci_read_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL2);
+  lnk_ctl2 &= (~PCI_EXP_LNKCTL2_SPEED_DIS | dev->hasd);
+  pci_write_word(dev->dev, pcie->addr + PCI_EXP_LNKCTL2, lnk_ctl2);
+}
diff --git a/lmr_lib/margin_hw.h b/lmr_lib/margin_hw.h
new file mode 100644
index 0000000..a436d4b
--- /dev/null
+++ b/lmr_lib/margin_hw.h
@@ -0,0 +1,39 @@
+#ifndef _MARGIN_HW_H
+#define _MARGIN_HW_H
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#include "../lib/pci.h"
+
+/*PCI Device wrapper for margining functions*/
+struct margin_dev
+{
+  struct pci_dev *dev;
+  int lmr_cap_addr;
+  uint8_t width;
+  uint8_t retimers_n;
+  uint8_t link_speed;
+
+  /*Saved Device settings to restore after margining*/
+  uint16_t aspm;
+  uint16_t hasd; /*Hardware Autonomous Speed Disable*/
+  uint16_t hawd; /*Hardware Autonomous Width Disable*/
+};
+
+/*Verify that devices form the link at Gen 4 speed or higher*/
+bool margin_verify_link(struct pci_dev *down_port, struct pci_dev *up_port);
+
+/*Check Margining Ready bit from Margining Port Status Register*/
+bool margin_check_ready_bit(struct pci_dev *dev);
+
+/*Awaits device at Gen 4 or higher*/
+struct margin_dev margin_fill_wrapper(struct pci_dev *dev);
+
+/*Disable ASPM, set Hardware Autonomous Speed/Width Disable bits*/
+bool margin_prep_dev(struct margin_dev *dev);
+
+/*Restore Device ASPM, Hardware Autonomous Speed/Width settings*/
+void margin_restore_dev(struct margin_dev *dev);
+
+#endif
-- 
2.34.1


