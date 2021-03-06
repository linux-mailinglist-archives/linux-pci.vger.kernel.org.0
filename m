Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5142339C8A
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 08:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhCMHYc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 02:24:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:14326 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMHYK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Mar 2021 02:24:10 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DyDdy4Rx6z8ww8;
        Sat, 13 Mar 2021 15:22:14 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 15:23:56 +0800
From:   Chiqijun <chiqijun@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex.williamson@redhat.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>,
        <zengweiliang.zengweiliang@huawei.com>, <chenlizhong@huawei.com>
Subject: [v4] PCI: Add reset quirk for Huawei Intelligent NIC virtual function
Date:   Sat, 13 Mar 2021 15:29:33 +0800
Message-ID: <20210313072933.2052-1-chiqijun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When multiple VFs do FLR at the same time, the firmware is
processed serially, resulting in some VF FLRs being delayed more
than 100ms, when the virtual machine restarts and the device
driver is loaded, the firmware is doing the corresponding VF
FLR, causing the driver to fail to load.

To solve this problem, add host and firmware status synchronization
during FLR.

Signed-off-by: Chiqijun <chiqijun@huawei.com>
---
v4:
 - Addressed Bjorn's review comments

v3:
 - The MSE bit in the VF configuration space is hardwired to zero,
   remove the setting of PCI_COMMAND_MEMORY bit. Add comment for
   set PCI_COMMAND register.

v2:
 - Update comments
 - Use the HINIC_VF_FLR_CAP_BIT_SHIFT and HINIC_VF_FLR_PROC_BIT_SHIFT
   macro instead of the magic number
---
 drivers/pci/quirks.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..4623125098e0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3913,6 +3913,73 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+#define PCI_DEVICE_ID_HINIC_VF      0x375E
+#define HINIC_VF_FLR_TYPE           0x1000
+#define HINIC_VF_FLR_CAP_BIT_SHIFT  30
+#define HINIC_VF_OP                 0xE80
+#define HINIC_VF_FLR_PROC_BIT_SHIFT 18
+#define HINIC_OPERATION_TIMEOUT     15000	/* 15 seconds */
+
+/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
+static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
+{
+	unsigned long timeout;
+	void __iomem *bar;
+	u32 val;
+
+	if (probe)
+		return 0;
+
+	bar = pci_iomap(pdev, 0, 0);
+	if (!bar)
+		return -ENOTTY;
+
+	/* Get and check firmware capabilities. */
+	val = be32_to_cpu(readl(bar + HINIC_VF_FLR_TYPE));
+	if (!(val & (1UL << HINIC_VF_FLR_CAP_BIT_SHIFT))) {
+		pci_iounmap(pdev, bar);
+		return -ENOTTY;
+	}
+
+	/*
+	 * Set the processing bit for the start of FLR, which will be cleared
+	 * by the firmware after FLR is completed.
+	 */
+	val = be32_to_cpu(readl(bar + HINIC_VF_OP));
+	val = val | (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT);
+	writel(cpu_to_be32(val), bar + HINIC_VF_OP);
+
+	/* Perform the actual device function reset */
+	pcie_flr(pdev);
+
+	/*
+	 * The device must learn BDF after FLR in order to respond to BAR's
+	 * read request, therefore, we issue a configure write request to let
+	 * the device capture BDF.
+	 */
+	pci_write_config_word(pdev, PCI_VENDOR_ID, 0);
+
+	/* Waiting for device reset complete */
+	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);
+	do {
+		val = be32_to_cpu(readl(bar + HINIC_VF_OP));
+		if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
+			goto reset_complete;
+		msleep(20);
+	} while (time_before(jiffies, timeout));
+
+	val = be32_to_cpu(readl(bar + HINIC_VF_OP));
+	if (!(val & (1UL << HINIC_VF_FLR_PROC_BIT_SHIFT)))
+		goto reset_complete;
+
+	pci_warn(pdev, "Reset dev timeout, flr ack reg: %#010x\n", val);
+
+reset_complete:
+	pci_iounmap(pdev, bar);
+
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -3924,6 +3991,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
+	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
+		reset_hinic_vf_dev },
 	{ 0 }
 };
 
-- 
2.17.1

