Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71EFF114045
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 12:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfLELpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 06:45:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729017AbfLELpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Dec 2019 06:45:13 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CEAE47D68C66BE4C2628;
        Thu,  5 Dec 2019 19:45:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Dec 2019 19:45:03 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>
CC:     <wangxiongfeng2@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <huawei.libin@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH] PCI: Add quirk to disable unused BAR for hisilicon NP devices 5896
Date:   Thu, 5 Dec 2019 19:40:41 +0800
Message-ID: <1575546041-50907-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci quirk for hisilicon PCI Network Processor devices 5896.
The size of the unused BAR3 is set as 265T wrongly. This patch disalbes
this bar.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/quirks.c    | 29 +++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a08..7dfb272 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5431,3 +5431,32 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
+
+static void quirk_hisi_fixup_np_class(struct pci_dev *pdev)
+{
+	u32 class = pdev->class;
+
+	pdev->class = PCI_BASE_CLASS_NETWORK << 8;
+	pci_info(pdev, "PCI class overriden (%#08x -> %#08x)\n",
+		 class, pdev->class);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
+			quirk_hisi_fixup_np_class);
+
+/*
+ * Hisilicon NP devices 5896 BAR3 size is misreported as 256T. Actually, this
+ * BAR is unused, so let's disable it.
+ */
+#define HISI_5896_WRONG_BAR 3
+static void quirk_hisi_fixup_np_bar(struct pci_dev *pdev)
+{
+	struct resource *r = &pdev->resource[HISI_5896_WRONG_BAR];
+
+	r->start = 0;
+	r->end = 0;
+	r->flags = 0;
+
+	pci_info(pdev, "disable BAR %d\n", HISI_5896_WRONG_BAR);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
+			 quirk_hisi_fixup_np_bar);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2302d133..56e2b91 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2558,6 +2558,7 @@
 #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
 
 #define PCI_VENDOR_ID_HUAWEI		0x19e5
+#define PCI_DEVICE_ID_HISI_5896        0x5896 /* Hisilicon NP devices 5896 */
 
 #define PCI_VENDOR_ID_NETRONOME		0x19ee
 #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
-- 
1.7.12.4

