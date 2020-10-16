Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A82828FBFD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389200AbgJPAM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:26 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55105 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733120AbgJPAMV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DC662AEE;
        Thu, 15 Oct 2020 20:12:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=ay3Rr4jBa6G05VEXyC69g8OPO+9GMOwVLqt93DkjY4Q=; b=QV3yN
        UQqxbMzDrIohmKHbOy8MqGFBOVdSUABeoTNnazRJoAATx1FRrYfK6TnzHoorOH9K
        pzmZZtnFVYsgjpJQHnofU3sS0xOG6zISxqsexUy/YOrR1mYU76SOOplSnlgLJ//3
        FNzcYju8n5/IjSNGSfGqQ5OcpWufJDxmZbj5R32R8wwl3pxWv9WcVDwUJKyI6W1M
        YN9TOhwLT7kigjJKmfNe3w2qQy0WEPteftU3ptSX44a4+QfHbJ7TECQoP6X+DxtP
        tTRIjDbFa/FlaL7kwYf2ChfMqsVTFU4DFeaxaUzaX21O4g8HS67yh9a8iugxEpMV
        zZ+eFUh6rmQ3w3WjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ay3Rr4jBa6G05VEXyC69g8OPO+9GMOwVLqt93DkjY4Q=; b=lvdfzlJ5
        cMkT6of+STXyrCKxF49DyGq8aXLLPWbFLevJ1t3Y62zAPKqIRpcYXAcyRpSYmIt1
        zOuONHqDD2uAiVbdp+DMAugt28oATx9GNttqP7T2zD9vyF/Lna1Wr0zjW4TPc9NR
        QqnGwrarDjUqobaVVFI37uw6KjvjAnwQb9PVkL+gv1x6uJ5wH4kRZnURPBlp0try
        33VkgHc+hnwM4kDsfo2hu1tcjkOh4j3K7H1S0Ru5UUGQGNbH1nhWDn+dJZdPtl8O
        o3racDHTu5BIpXytCIsqGNmXwe2qcgSjMWi5TcRxZFl0aAoRKTtjEi7dVn/Gyglx
        hsPHB7iJhouXJQ==
X-ME-Sender: <xms:Y-WIX3GD-8rhobaWDOZPkkTrSKY9Oz_ODu94HfKl1PydDzfDW0FOAw>
    <xme:Y-WIX0WZUNfrbFDePozd-bwi6VlgtJ1WcwnAoGVvCie1VJSrPGfNizL91GIuKE4p8
    5chy8rXpHzelWs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:Y-WIX5KYATCwvo0ibldyGdVvzMB97af0G9UcRlpRQewKHU_vCR2Cmg>
    <xmx:Y-WIX1GOPGe46RMMjkaXW6eq0klgVoiw81G_U4RhRJDsKAUzjXmFLA>
    <xmx:Y-WIX9UilQmXzyVvEQQsZpQpc3jMrCSemn-8Grc2hPuVh4qdtUqYmg>
    <xmx:Y-WIX8H-VpIIz_qNfciY-xt_23JUrC7_ipBdvZduWX4RojlsZhMrIA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E5703064684;
        Thu, 15 Oct 2020 20:12:17 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 03/15] PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
Date:   Thu, 15 Oct 2020 17:11:01 -0700
Message-Id: <20201016001113.2301761-4-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Extend support for Root Complex Event Collectors by decoding and caching
the RCEC Endpoint Association Extended Capabilities when enumerating. Use
that cached information for later error source reporting. See PCIe r5.0,
sec 7.9.10.

[bhelgaas: make pci_rcec_init() void, set dev->rcec_ea after filling it]
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-4-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
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
index fa12f7cbc1a0..af98b7d2134b 100644
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
+void pci_rcec_init(struct pci_dev *dev);
+void pci_rcec_exit(struct pci_dev *dev);
+#else
+static inline void pci_rcec_init(struct pci_dev *dev) {}
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
index 000000000000..038e9d706d5f
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
+void pci_rcec_init(struct pci_dev *dev)
+{
+	struct rcec_ea *rcec_ea;
+	u32 rcec, hdr, busn;
+	u8 ver;
+
+	/* Only for Root Complex Event Collectors */
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
+		return;
+
+	rcec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC);
+	if (!rcec)
+		return;
+
+	rcec_ea = kzalloc(sizeof(*rcec_ea), GFP_KERNEL);
+	if (!rcec_ea)
+		return;
+
+	pci_read_config_dword(dev, rcec + PCI_RCEC_RCIEP_BITMAP,
+			      &rcec_ea->bitmap);
+
+	/* Check whether RCEC BUSN register is present */
+	pci_read_config_dword(dev, rcec, &hdr);
+	ver = PCI_EXT_CAP_VER(hdr);
+	if (ver >= PCI_RCEC_BUSN_REG_VER) {
+		pci_read_config_dword(dev, rcec + PCI_RCEC_BUSN, &busn);
+		rcec_ea->nextbusn = PCI_RCEC_BUSN_NEXT(busn);
+		rcec_ea->lastbusn = PCI_RCEC_BUSN_LAST(busn);
+	} else {
+		/* Avoid later ver check by setting nextbusn */
+		rcec_ea->nextbusn = 0xff;
+		rcec_ea->lastbusn = 0x00;
+	}
+
+	dev->rcec_ea = rcec_ea;
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

