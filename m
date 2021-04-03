Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067D0353348
	for <lists+linux-pci@lfdr.de>; Sat,  3 Apr 2021 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhDCJQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Apr 2021 05:16:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15475 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbhDCJQ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Apr 2021 05:16:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FCB7X1WQ5zyNkG;
        Sat,  3 Apr 2021 17:14:16 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 3 Apr 2021 17:16:18 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 4/4] PCI: Enable 10-Bit tag support for PCIe RP devices
Date:   Sat, 3 Apr 2021 16:54:19 +0800
Message-ID: <1617440059-2478-5-git-send-email-liudongdong3@huawei.com>
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

PCIe spec 5.0r1.0 section 2.2.6.2 implementation note, In configurations
where a Requester with 10-Bit Tag Requester capability needs to target
multiple Completers, one needs to ensure that the Requester sends 10-Bit
Tag Requests only to Completers that have 10-Bit Tag Completer capability.
So we enable 10-Bit Tag Requester for root port only when the devices
under the root port support 10-Bit Tag Completer.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/pci.h              |  2 +
 drivers/pci/pcie/portdrv_pci.c |  3 ++
 drivers/pci/probe.c            | 86 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ef7c466..056b73d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -459,6 +459,7 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
 void pcie_walk_rcec(struct pci_dev *rcec,
 		    int (*cb)(struct pci_dev *, void *),
 		    void *userdata);
+void pci_configure_rp_10bit_tag(struct pci_dev *dev);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) {}
 static inline void pci_rcec_exit(struct pci_dev *dev) {}
@@ -466,6 +467,7 @@ static inline void pcie_link_rcec(struct pci_dev *rcec) {}
 static inline void pcie_walk_rcec(struct pci_dev *rcec,
 				  int (*cb)(struct pci_dev *, void *),
 				  void *userdata) {}
+static inline void pci_configure_rp_10bit_tag(struct pci_dev *dev) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index c7ff1ee..3af4733 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -111,6 +111,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	     (type != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
+	if (type == PCI_EXP_TYPE_ROOT_PORT)
+		pci_configure_rp_10bit_tag(dev);
+
 	if (type == PCI_EXP_TYPE_RC_EC)
 		pcie_link_rcec(dev);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3efe1cc..73105c3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2051,6 +2051,92 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	return 0;
 }
 
+static int pci_10bit_tag_comp_support(struct pci_dev *dev, void *data)
+{
+	u8 *support = data;
+	int ret;
+	u32 cap;
+
+	if (*support == 0)
+		return 0;
+
+	if (!pci_is_pcie(dev)) {
+		*support = 0;
+		return 0;
+	}
+
+	/*
+	 * PCIe spec 5.0r1.0 section 2.2.6.2 implementation note
+	 * For configurations where a Requester with 10-Bit Tag Requester capability
+	 * targets Completers where some do and some do not have 10-Bit Tag
+	 * Completer capability, how the Requester determines which NPRs include
+	 * 10-Bit Tags is outside the scope of this specification.  So we do not consider
+	 * hotplug scenario.
+	 */
+	if (dev->is_hotplug_bridge) {
+		*support = 0;
+		return 0;
+	}
+
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (ret) {
+		*support = 0;
+		return 0;
+	}
+
+	if (!(cap & PCI_EXP_DEVCAP2_10BIT_TAG_COMP)) {
+		*support = 0;
+		return 0;
+	}
+
+
+	return 0;
+}
+
+void pci_configure_rp_10bit_tag(struct pci_dev *dev)
+{
+	u8 support = 1;
+	u32 cap;
+	int ret;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return;
+
+	if (dev->subordinate == NULL)
+		return;
+
+	pci_10bit_tag_comp_support(dev, &support);
+	if (!support)
+		return;
+
+	/*
+	 * PCIe spec 5.0r1.0 section 2.2.6.2 implementation note
+	 * In configurations where a Requester with 10-Bit Tag Requester capability
+	 * needs to target multiple Completers, one needs to ensure that the
+	 * Requester sends 10-Bit Tag Requests only to Completers that have 10-Bit
+	 * Tag Completer capability. So we enable 10-Bit Tag Requester for root port
+	 * only when the devices under the root port support 10-Bit Tag Completer.
+	 */
+	pci_walk_bus(dev->subordinate, pci_10bit_tag_comp_support, &support);
+	if (!support)
+		return;
+
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (ret)
+		return;
+
+	if (!(cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ))
+		return;
+
+	pci_info(dev, "enabling 10-Bit Tag Requester\n");
+	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
+				 PCI_EXP_DEVCTL2_10BIT_TAG_REQ_EN);
+}
+
+
 static void pci_configure_10bit_tags(struct pci_dev *dev)
 {
 	u32 cap;
-- 
1.9.1

