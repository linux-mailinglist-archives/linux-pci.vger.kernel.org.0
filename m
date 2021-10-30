Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB544093D
	for <lists+linux-pci@lfdr.de>; Sat, 30 Oct 2021 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhJ3OAF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Oct 2021 10:00:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15318 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhJ3OAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Oct 2021 10:00:03 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HhLTD680qz90PZ;
        Sat, 30 Oct 2021 21:57:20 +0800 (CST)
Received: from SZX1000464847.huawei.com (10.21.59.169) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Sat, 30 Oct 2021 21:57:26 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <hch@infradead.org>, <kw@linux.com>,
        <logang@deltatee.com>, <leon@kernel.org>,
        <linux-pci@vger.kernel.org>, <rajur@chelsio.com>,
        <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH V11 2/8] PCI: Cache Device Capabilities 2 Register
Date:   Sat, 30 Oct 2021 21:53:42 +0800
Message-ID: <20211030135348.61364-3-liudongdong3@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20211030135348.61364-1-liudongdong3@huawei.com>
References: <20211030135348.61364-1-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.21.59.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new member called devcap2 in struct pci_dev for caching the PCIe
Device Capabilities 2 register to avoid reading PCI_EXP_DEVCAP2 multiple
times.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |  4 +---
 drivers/pci/pci.c                               |  8 +++-----
 drivers/pci/probe.c                             | 10 ++++------
 include/linux/pci.h                             |  1 +
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 0d9cda4ab303..ae0b6def994b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -6304,7 +6304,6 @@ static int cxgb4_iov_configure(struct pci_dev *pdev, int num_vfs)
 		struct pci_dev *pbridge;
 		struct port_info *pi;
 		char name[IFNAMSIZ];
-		u32 devcap2;
 		u16 flags;
 
 		/* If we want to instantiate Virtual Functions, then our
@@ -6314,10 +6313,9 @@ static int cxgb4_iov_configure(struct pci_dev *pdev, int num_vfs)
 		 */
 		pbridge = pdev->bus->self;
 		pcie_capability_read_word(pbridge, PCI_EXP_FLAGS, &flags);
-		pcie_capability_read_dword(pbridge, PCI_EXP_DEVCAP2, &devcap2);
 
 		if ((flags & PCI_EXP_FLAGS_VERS) < 2 ||
-		    !(devcap2 & PCI_EXP_DEVCAP2_ARI)) {
+		    !(pbridge->devcap2 & PCI_EXP_DEVCAP2_ARI)) {
 			/* Our parent bridge does not support ARI so issue a
 			 * warning and skip instantiating the VFs.  They
 			 * won't be reachable.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..64138a83b0f7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3717,7 +3717,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
 	struct pci_bus *bus = dev->bus;
 	struct pci_dev *bridge;
-	u32 cap, ctl2;
+	u32 ctl2;
 
 	if (!pci_is_pcie(dev))
 		return -EINVAL;
@@ -3741,19 +3741,17 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	while (bus->parent) {
 		bridge = bus->self;
 
-		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
-
 		switch (pci_pcie_type(bridge)) {
 		/* Ensure switch ports support AtomicOp routing */
 		case PCI_EXP_TYPE_UPSTREAM:
 		case PCI_EXP_TYPE_DOWNSTREAM:
-			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
+			if (!(bridge->devcap2 & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
 				return -EINVAL;
 			break;
 
 		/* Ensure root port supports all the sizes we care about */
 		case PCI_EXP_TYPE_ROOT_PORT:
-			if ((cap & cap_mask) != cap_mask)
+			if ((bridge->devcap2 & cap_mask) != cap_mask)
 				return -EINVAL;
 			break;
 		}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 96ecdf34f931..7259ad774ac8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1509,6 +1509,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_flags_reg = reg16;
 	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
 	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
+	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP2, &pdev->devcap2);
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
@@ -2129,7 +2130,7 @@ static void pci_configure_ltr(struct pci_dev *dev)
 #ifdef CONFIG_PCIEASPM
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	struct pci_dev *bridge;
-	u32 cap, ctl;
+	u32 ctl;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -2137,8 +2138,7 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	/* Read L1 PM substate capabilities */
 	dev->l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_LTR))
+	if (!(dev->devcap2 & PCI_EXP_DEVCAP2_LTR))
 		return;
 
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
@@ -2178,13 +2178,11 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 #ifdef CONFIG_PCI_PASID
 	struct pci_dev *bridge;
 	int pcie_type;
-	u32 cap;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
+	if (!(dev->devcap2 & PCI_EXP_DEVCAP2_EE_PREFIX))
 		return;
 
 	pcie_type = pci_pcie_type(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..286d89e22738 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -333,6 +333,7 @@ struct pci_dev {
 	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
 	u32		devcap;		/* PCIe Device Capabilities */
+	u32		devcap2;	/* PCIe Device Capabilities 2 */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
-- 
2.22.0

