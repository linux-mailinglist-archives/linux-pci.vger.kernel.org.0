Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A2281B38
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbgJBS4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40201 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387768AbgJBS4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 68E765C0116;
        Fri,  2 Oct 2020 14:47:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=CQZmU9xTGUxwDQ0gOy1ppsdCp5HAh2PvbVp3UmWtJ68=; b=mWH6A
        3pTSkLvgYeaMsM2TIEwV+ZZUCY3QJel56HuxtcFT29/eBje+uiyPpb7WoFhHqhCj
        kxMhsIFi2Xyk3MOQxeO8ekBkUCskCmJhJuSdwna9u0uLd7RQR8rwS0Uzm2mttYYu
        osHFqWQuykMRZ5tyomurashKeRs/pSEXXYlpVhYoONdd3SW2imuq1hfSltCiCbVK
        tuO7x42WZ2RQTCXI0gCo3yqZ4UFtb/gkZPgN9w9Xo1toxHpxCCiMaRGcKM0QG9SI
        fyr3u9QBISbMbb4FKPBbxHSr3skvRAQkJXtv8PJq08I5qSUNaxGKzEe73hvVJBiQ
        +HQNer/TMjEllPugQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=CQZmU9xTGUxwDQ0gOy1ppsdCp5HAh2PvbVp3UmWtJ68=; b=ko3EYkmw
        OQBbWrm//5boStRgJ5MwHxrdBfIefg4cpE2/PCAZh+j+FG+KnSgNIUr/bC6hL3RL
        q9LnEI+fjvNVMI48IvEjh5ly2WkOJc2wciZXskuKwJ0Rcz/NIEsvPCHEEI320Yev
        LIFxgznE0reIQMjA0+cfr2heFaniTrOnC+ZsbyP6dRPq28NBtwW7yEpsRX5cFucP
        vy7TOSYg7FF3eKCcGEYpB4fhknnzSEew9xO/fHFClGbzv0Hgk8TWqqRnD7HvEDok
        CwL3PVCszBitYHPP3QpMC/15oblHxEdGlGy9MjCqurGd46t63pouSjaDIIl+8Jms
        GDib4WcAOwUl2w==
X-ME-Sender: <xms:3nV3X9uf7294dbKmUoC75tRwfiHVPn5LR25T2NihBoSF-OIkez9FPQ>
    <xme:3nV3X2fuf4LC0r13wgVJxpnn18TdIVFWgjo-t_sWxA_LAA-5NkMYvhhgG9SxDWTvh
    AqB7rhz0i8QplKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:3nV3Xwxk_ZDU9v7mEpovu0F0m2D7VWQqAyki6dzSb0OvLg0m7tLcJQ>
    <xmx:3nV3X0PNuUs2eWWupojW6AS3kerEb6w-xrPs5f4WxhkPcil34q9VfA>
    <xmx:3nV3X99bjrzLYE1gb7WycpMh8pVWJU_nUkt1B36mbNWwI0paH70wew>
    <xmx:3nV3X2PgbbuKXGfXURva8mbzJrTfHQh0RewcqlhKDBSuKwER_JYkqw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 405CB3064680;
        Fri,  2 Oct 2020 14:47:56 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 03/14] PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
Date:   Fri,  2 Oct 2020 11:47:24 -0700
Message-Id: <20201002184735.1229220-4-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Extend support for Root Complex Event Collectors by decoding and
caching the RCEC Endpoint Association Extended Capabilities when
enumerating. Use that cached information for later error source
reporting. See PCI Express Base Specification, version 5.0-1,
section 7.9.10.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h         | 17 +++++++++++
 drivers/pci/pcie/Makefile |  2 +-
 drivers/pci/pcie/rcec.c   | 59 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       |  2 ++
 include/linux/pci.h       |  4 +++
 5 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/rcec.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..0e332a218d75 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -449,6 +449,15 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 #endif	/* CONFIG_PCIEAER */
 
+#ifdef CONFIG_PCIEPORTBUS
+/* Cached RCEC Endpoint Association */
+struct rcec_ea {
+	u8		nextbusn;
+	u8		lastbusn;
+	u32		bitmap;
+};
+#endif
+
 #ifdef CONFIG_PCIE_DPC
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
@@ -461,6 +470,14 @@ static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 static inline void pci_dpc_init(struct pci_dev *pdev) {}
 #endif
 
+#ifdef CONFIG_PCIEPORTBUS
+int pci_rcec_init(struct pci_dev *dev);
+void pci_rcec_exit(struct pci_dev *dev);
+#else
+static inline int pci_rcec_init(struct pci_dev *dev) { return 0; }
+static inline void pci_rcec_exit(struct pci_dev *dev) {}
+#endif
+
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 void pci_ats_init(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 68da9280ff11..d9697892fa3e 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for PCI Express features and port driver
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
+pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
new file mode 100644
index 000000000000..da02b0af442d
--- /dev/null
+++ b/drivers/pci/pcie/rcec.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Root Complex Event Collector Support
+ *
+ * Authors:
+ *  Sean V Kelley <sean.v.kelley@intel.com>
+ *  Qiuxu Zhuo <qiuxu.zhuo@intel.com>
+ *
+ * Copyright (C) 2020 Intel Corp.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+
+#include "../pci.h"
+
+int pci_rcec_init(struct pci_dev *dev)
+{
+	struct rcec_ea *rcec_ea;
+	u32 rcec, hdr, busn;
+	u8 ver;
+
+	/* Only for Root Complex Event Collectors */
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
+		return 0;
+
+	rcec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC);
+	if (!rcec)
+		return 0;
+
+	rcec_ea = kzalloc(sizeof(*rcec_ea), GFP_KERNEL);
+	if (!rcec_ea)
+		return -ENOMEM;
+	dev->rcec_ea = rcec_ea;
+
+	pci_read_config_dword(dev, rcec + PCI_RCEC_RCIEP_BITMAP, &rcec_ea->bitmap);
+
+	/* Check whether RCEC BUSN register is present */
+	pci_read_config_dword(dev, rcec, &hdr);
+	ver = PCI_EXT_CAP_VER(hdr);
+	if (ver < PCI_RCEC_BUSN_REG_VER) {
+		/* Avoid later ver check by setting nextbusn */
+		rcec_ea->nextbusn = 0xff;
+		return 0;
+	}
+
+	pci_read_config_dword(dev, rcec + PCI_RCEC_BUSN, &busn);
+	rcec_ea->nextbusn = PCI_RCEC_BUSN_NEXT(busn);
+	rcec_ea->lastbusn = PCI_RCEC_BUSN_LAST(busn);
+
+	return 0;
+}
+
+void pci_rcec_exit(struct pci_dev *dev)
+{
+	kfree(dev->rcec_ea);
+	dev->rcec_ea = NULL;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..25f01f841f2d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2201,6 +2201,7 @@ static void pci_configure_device(struct pci_dev *dev)
 static void pci_release_capabilities(struct pci_dev *dev)
 {
 	pci_aer_exit(dev);
+	pci_rcec_exit(dev);
 	pci_vpd_release(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
@@ -2400,6 +2401,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
+	pci_rcec_init(dev);		/* Root Complex Event Collector */
 
 	pcie_report_downtraining(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..2290439e8bc0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -304,6 +304,7 @@ struct pcie_link_state;
 struct pci_vpd;
 struct pci_sriov;
 struct pci_p2pdma;
+struct rcec_ea;
 
 /* The pci_dev structure describes PCI devices */
 struct pci_dev {
@@ -326,6 +327,9 @@ struct pci_dev {
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
+#endif
+#ifdef CONFIG_PCIEPORTBUS
+	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
-- 
2.28.0

