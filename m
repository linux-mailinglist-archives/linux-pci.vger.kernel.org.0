Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CAAEA4A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2019 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391846AbfIJMZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Sep 2019 08:25:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17335 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfIJMZS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Sep 2019 08:25:18 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190910122515epoutp02f290ca027d250cf3611581939e19f5ee~DE0y7zwKd0068000680epoutp02h
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2019 12:25:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190910122515epoutp02f290ca027d250cf3611581939e19f5ee~DE0y7zwKd0068000680epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568118315;
        bh=sQF95YLtKl5rVaHTr3Uy0/3EKF880fnDcvOaP01+qt0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oYktEStVc5P4UzIOEg7/AUEuX8JhREBUrvWSynBIX50dBmcazq4KBRLs9Lo5d+crb
         VeN6LCrXpuZwU8/LdSqw0Bwv5BpanVcgiINOC5LDzrdJckqPXo7UUmnoL8yztbtxTQ
         u1ZF9J8TynDOSAG2f1KOJTD5OZBZiG3C6zNRCW60=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20190910122515epcas5p152f64e1f15250afc22a1815603e12790~DE0yfknFt3249032490epcas5p1B;
        Tue, 10 Sep 2019 12:25:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.F1.04429.A26977D5; Tue, 10 Sep 2019 21:25:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f~DE0yGlI5T2388523885epcas5p4g;
        Tue, 10 Sep 2019 12:25:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190910122514epsmtrp1252b912ff7ce89f6c0f53d30f5a9afd8~DE0yF0WIu1251612516epsmtrp1J;
        Tue, 10 Sep 2019 12:25:14 +0000 (GMT)
X-AuditID: b6c32a4a-655ff7000000114d-eb-5d77962abc28
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.B6.03706.A26977D5; Tue, 10 Sep 2019 21:25:14 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190910122513epsmtip2cee3ff68d6694ff80315d5f5f7355488~DE0w1qlZA0913509135epsmtip2K;
        Tue, 10 Sep 2019 12:25:13 +0000 (GMT)
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        Anvesh Salveru <anvesh.s@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 1/2] PCI: dwc: Add support to disable GEN3 equalization
Date:   Tue, 10 Sep 2019 17:55:01 +0530
Message-Id: <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCmhq7WtPJYgwuzrC3O7lrIarGkKcNi
        190OdosVX2ayW1zeNYfN4uy842wWb36/YLdYtPULuwOHx5p5axg9ds66y+6xYFOpR9+WVYwe
        W/Z/ZvT4vEkugC2KyyYlNSezLLVI3y6BK2PeT8GCQ8IVlxdNZmlgvCHQxcjJISFgIjG77xNb
        FyMXh5DAbkaJBSfmskI4nxglDm3cwwThfGOUeDnvOhtMy9beaWC2kMBeRonGR1YQRS1MEl9b
        /zGDJNgEdCWevJ8LZosIWEs0vFoFNpYZZMe/iZeBHA4OYQF3iVtfKkBqWARUJQ7f/MwEEuYV
        8JDoWuYIsUtO4ua5TmYIewKbxKcThiAlEgIuEh82mECEhSVeHd/CDmFLSbzsb4Oy8yV+LJ7E
        DLJVQqCFUWLycZDPQBL2EgeuzGEBmcMsoCmxfpc+SJhZgE+i9/cTJojxvBIdbUIQ1WoS35+f
        gbpARuJh81ImCNtD4v6uqcyQUIiVmLz5PfsERplZCEMXMDKuYpRMLSjOTU8tNi0wykst1ytO
        zC0uzUvXS87P3cQIjnQtrx2My875HGIU4GBU4uF90FYeK8SaWFZcmXuIUYKDWUmE93pfaawQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3kmsV2OEBNITS1KzU1MLUotgskwcnFINjCX71Vq7eHve
        rfy0sDU2OyD3iSNTnpn8/0cLpx5eHB50tPuPCF+F0lM9lXtfbi2Jurrq8RWdmuTlMou5+BxT
        pwWLzKhifZCqM2f/2curgqcYGqnKPTIT7tgX8KKr7I+05UZW5t2ZBVEFgqG+m14oLTU04mRe
        OcGgRvHoZo3+R5XHOHfXV1r+UWIpzkg01GIuKk4EAEqYAdDwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSvK7WtPJYg8aVihZndy1ktVjSlGGx
        624Hu8WKLzPZLS7vmsNmcXbecTaLN79fsFss2vqF3YHDY828NYweO2fdZfdYsKnUo2/LKkaP
        Lfs/M3p83iQXwBbFZZOSmpNZllqkb5fAlTHvp2DBIeGKy4smszQw3hDoYuTkkBAwkdjaO42t
        i5GLQ0hgN6PEjvb5zBAJGYnJq1ewQtjCEiv/PWeHKGpikvjd3sUEkmAT0JV48n4uWIOIgK1E
        w98OZpAiZoGDjBJXlu4DKuLgEBZwl7j1pQKkhkVAVeLwzc9gYV4BD4muZY4Q8+Ukbp7rZJ7A
        yLOAkWEVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwSGlp7mC8vCT+EKMAB6MSD++D
        tvJYIdbEsuLK3EOMEhzMSiK81/tKY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5Y
        kpqdmlqQWgSTZeLglGpgLJDr3e5wW7Z927E9xtNeydocnWArcs1cI2zN7R1LVijP9jNRydgm
        GCiZm3JDuXE3/7X2b3qdnzpWq1/3y738uFTl1Hnji+uVS0Lvdkxu5WM/orfqj8Zz49f3crPt
        i9lM30bP2ZBoMaFn9xY7D5bA20fWWqR/e9m+xmsb56EGlyxpoUqBy/eClViKMxINtZiLihMB
        57g6VCUCAAA=
X-CMS-MailID: 20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f
References: <CGME20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f@epcas5p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Anvesh Salveru <anvesh.s@samsung.com>

In some platforms, PCIe PHY may have issues which will prevent linkup
to happen in GEN3 or high speed. In case equalization fails, link will
fallback to GEN1.

Designware controller has support for disabling GEN3 equalization if
required. This patch enables the designware driver to disable the PCIe
GEN3 equalization by writing into PCIE_PORT_GEN3_RELATED.

Platform drivers can disable equalization by setting the dwc_pci_quirk
flag DWC_EQUALIZATION_DISABLE.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7d25102..bf82091 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -466,4 +466,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		break;
 	}
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+
+	if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
+		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
+
+	dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ffed084..a1453c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -29,6 +29,9 @@
 #define LINK_WAIT_MAX_IATU_RETRIES	5
 #define LINK_WAIT_IATU			9
 
+/* Parameters for PCIe Quirks */
+#define DWC_EQUALIZATION_DISABLE	0x1
+
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
@@ -60,6 +63,9 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_GEN3_RELATED		0x890
+#define PORT_LOGIC_GEN3_EQ_DISABLE	BIT(16)
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
@@ -244,6 +250,7 @@ struct dw_pcie {
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
 	unsigned int		version;
+	unsigned int		dwc_pci_quirk;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.7.4

