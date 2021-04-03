Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A569353346
	for <lists+linux-pci@lfdr.de>; Sat,  3 Apr 2021 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhDCJQ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Apr 2021 05:16:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15476 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhDCJQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Apr 2021 05:16:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FCB7X1jbpzyNlj;
        Sat,  3 Apr 2021 17:14:16 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 3 Apr 2021 17:16:18 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 2/4] PCI: Enable 10-Bit tag support for PCIe Endpoint devices
Date:   Sat, 3 Apr 2021 16:54:17 +0800
Message-ID: <1617440059-2478-3-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
References: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

10-Bit Tag capability, introduced in PCIe-4.0 increases the total Tag
field size from 8 bits to 10 bits.

For platforms where the RC supports 10-Bit Tag Completer capability,
it is highly recommended for platform firmware or operating software
that configures PCIe hierarchies to Set the 10-Bit Tag Requester Enable
bit automatically in Endpoints with 10-Bit Tag Requester capability. This
enables the important class of 10-Bit Tag capable adapters that send
Memory Read Requests only to host memory.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/probe.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15a..3efe1cc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2051,6 +2051,44 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	return 0;
 }
 
+static void pci_configure_10bit_tags(struct pci_dev *dev)
+{
+	u32 cap;
+	int ret;
+	struct pci_dev *bridge;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (ret)
+		return;
+
+	if (!(cap & PCI_EXP_DEVCAP2_10BIT_TAG_COMP))
+		return;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		dev->ext_10bit_tag_comp_path = 1;
+		return;
+	}
+
+	bridge = pci_upstream_bridge(dev);
+	if (bridge && bridge->ext_10bit_tag_comp_path)
+		dev->ext_10bit_tag_comp_path = 1;
+
+	/* 10-Bit Tag Requester Enable in Device Control 2 Register is RsvdP for VF */
+	if (dev->is_virtfn)
+		return;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT &&
+	    dev->ext_10bit_tag_comp_path == 1 &&
+	    (cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ)) {
+		pci_info(dev, "enabling 10-Bit Tag Requester\n");
+		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
+					PCI_EXP_DEVCTL2_10BIT_TAG_REQ_EN);
+	}
+}
+
 /**
  * pcie_relaxed_ordering_enabled - Probe for PCIe relaxed ordering enable
  * @dev: PCI device to query
@@ -2190,6 +2228,7 @@ static void pci_configure_device(struct pci_dev *dev)
 {
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
+	pci_configure_10bit_tags(dev);
 	pci_configure_relaxed_ordering(dev);
 	pci_configure_ltr(dev);
 	pci_configure_eetlp_prefix(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c..1cd0ee0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -390,6 +390,7 @@ struct pci_dev {
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
+	unsigned int	ext_10bit_tag_comp_path:1; /* 10-Bit Tag Completer Supported from root to here */
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
 
-- 
1.9.1

