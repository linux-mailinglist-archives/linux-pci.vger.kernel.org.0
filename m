Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5DEB1BA1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfIMKkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 06:40:21 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:28436 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIMKkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Sep 2019 06:40:21 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190913104018epoutp02bdd8a9a62485e0668acdbfcb7f45bb8e~D_VBlW_uL1730517305epoutp02f
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2019 10:40:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190913104018epoutp02bdd8a9a62485e0668acdbfcb7f45bb8e~D_VBlW_uL1730517305epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568371218;
        bh=DaqFVHqqq+39Xb6OSxP8lkdEdNuIyb9xA6SxMHprNPo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rTIDpfzj3d9khTiSRU2MqIZb1xvaKt+PysqwwlRgYVGOE4wXnwrLFHt8jt01jGMD5
         teUd4Sc9bsfVPyqJAdIJkLbr87ZKGXfGBmJ+gmiAjlx0IMWC5917hsZA/eBV4xP8l2
         agcQXB6phdMLsE+xRtnSocJPwbEPRyDbTEzSraxU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190913104018epcas5p3cb1ed17c5fe032f2c4e3e26470135355~D_VBHN2LK0185201852epcas5p3J;
        Fri, 13 Sep 2019 10:40:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.0A.04150.2127B7D5; Fri, 13 Sep 2019 19:40:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14~D_VAxS0uW2920129201epcas5p3s;
        Fri, 13 Sep 2019 10:40:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190913104018epsmtrp216ee617e787345738d8f4eee2c2de12a~D_VAwgcCx1733817338epsmtrp2N;
        Fri, 13 Sep 2019 10:40:18 +0000 (GMT)
X-AuditID: b6c32a49-a43ff70000001036-32-5d7b7212820a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.69.03638.1127B7D5; Fri, 13 Sep 2019 19:40:18 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190913104016epsmtip2f4dc255c9c6faf1a335100156a558ccd~D_U-caFvs1704417044epsmtip2W;
        Fri, 13 Sep 2019 10:40:16 +0000 (GMT)
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        andrew.murray@arm.com, Anvesh Salveru <anvesh.s@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2] PCI: dwc: Add support to add GEN3 related equalization
 quirks
Date:   Fri, 13 Sep 2019 16:09:50 +0530
Message-Id: <1568371190-14590-1-git-send-email-pankaj.dubey@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7bCmuq5QUXWswaNFkhbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uLxrDpvF2XnH2Sze/H7BbrFo6xd2B06PNfPWMHrsnHWX3WPBplKP
        vi2rGD227P/M6PF5k1wAWxSXTUpqTmZZapG+XQJXxp7nnWwFKyUrvnbcYmxgPCDaxcjJISFg
        IrH53hXGLkYuDiGB3YwS3zt/QTmfGCXWvlzOBOF8Y5SYuvIvO0xLx68f7BCJvYwSq04fZQJJ
        CAm0MEk8PmEMYrMJ6Eo8eT+XGcQWEbCWaHi1ihWkgVngCqPEouf3WUESwgLBEtsOr2IEsVkE
        VCU2HZ/AAmLzCnhI7N/0mA1im5zEzXOdzCDNEgJz2CQuL37MCJFwkfh79gQrhC0s8er4Fqjz
        pCQ+v9sL1Zwv8WPxJKjmFkaJycfnQjXYSxy4MgdoGwfQSZoS63fpg4SZBfgken8/YQIJSwjw
        SnS0CUFUq0l8f36GGcKWkXjYvJQJwvaQmLLxISvE87ESj/qOsExglJmFMHQBI+MqRsnUguLc
        9NRi0wLDvNRyveLE3OLSvHS95PzcTYzg6Nfy3ME465zPIUYBDkYlHl4LnapYIdbEsuLK3EOM
        EhzMSiK8Pm8qY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzTmK9GiMkkJ5YkpqdmlqQWgSTZeLg
        lGpgtLoaXFdy3KGXSSyw3jKTe6fKkke6xfstaqwW33m01O+80/a7r3gO/T7eris+LdDz1sJV
        v35NbMp6GLXErMhGXS328qZXgpwFhVIP7u5+/0Y62H/FutC3pwJYHBbG1Eaeqr9zeoPI0xXO
        5vFa8o1lFp3i/lPefJyq9F+nM5z/B1/lucr0f09XK7EUZyQaajEXFScCAMHD8Er6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSvK5QUXWswcVuRovm/9tZLc7uWshq
        saQpw2LX3Q52ixVfZrJbXN41h83i7LzjbBZvfr9gt1i09Qu7A6fHmnlrGD12zrrL7rFgU6lH
        35ZVjB5b9n9m9Pi8SS6ALYrLJiU1J7MstUjfLoErY8/zTraClZIVXztuMTYwHhDtYuTkkBAw
        kej49YO9i5GLQ0hgN6PEw+lXWCASMhKTV69ghbCFJVb+ew5V1MQk8f/WL0aQBJuArsST93OZ
        QWwRAVuJhr8dzCBFzAK3GCXez1gJ1i0sEChxa9EpNhCbRUBVYtPxCWAbeAU8JPZveswGsUFO
        4ua5TuYJjDwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEh5iW1g7GEyfiDzEK
        cDAq8fA+0KyKFWJNLCuuzD3EKMHBrCTC6/OmMlaINyWxsiq1KD++qDQntfgQozQHi5I4r3z+
        sUghgfTEktTs1NSC1CKYLBMHp1QD47rj67gfL61s3mi2+PbM7IywubxTb9YcPC3/TCs24fDL
        PgHzvVqOnN67p/Y38YnkKT5pWPyVQei/nlbpty0vl17UyZq6rOT8a9VXm+b/K9eZeP2z8vqD
        B/4GTdgptrY6ZLp3p1jBftv1GSW9P9zmKB22SP16lV9zTfZshgs/jeo9lwptZrX9fEmJpTgj
        0VCLuag4EQCn3ApILQIAAA==
X-CMS-MailID: 20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14
References: <CGME20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14@epcas5p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Anvesh Salveru <anvesh.s@samsung.com>

In some platforms, PCIe PHY may have issues which will prevent linkup
to happen in GEN3 or higher speed. In case equalization fails, link will
fallback to GEN1.

DesignWare controller gives flexibility to disable GEN3 equalization
completely or only phase 2 and 3 of equalization.

This patch enables the DesignWare driver to disable the PCIe GEN3
equalization by enabling one of the following quirks:
 - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all phases
 - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2 & 3

Platform drivers can set these quirks via "quirk" variable of "dw_pcie"
struct.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
Patchset v1 can be found at:
 - 1/2: https://lkml.org/lkml/2019/9/10/443
 - 2/2: https://lkml.org/lkml/2019/9/10/444

Changes w.r.t v1:
 - Squashed two patches from v1 into one as suggested by Gustavo
 - Addressed review comments from Andrew

 drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7d25102..97fb18d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -466,4 +466,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		break;
 	}
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
+	if (pci->quirk & DWC_EQUALIZATION_DISABLE) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
+
+	if (pci->quirk & DWC_EQ_PHASE_2_3_DISABLE) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ffed084..e428b62 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -29,6 +29,10 @@
 #define LINK_WAIT_MAX_IATU_RETRIES	5
 #define LINK_WAIT_IATU			9
 
+/* Parameters for GEN3 related quirks */
+#define DWC_EQUALIZATION_DISABLE	BIT(1)
+#define DWC_EQ_PHASE_2_3_DISABLE	BIT(2)
+
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
@@ -60,6 +64,10 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_GEN3_RELATED		0x890
+#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
+#define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
@@ -244,6 +252,7 @@ struct dw_pcie {
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
 	unsigned int		version;
+	unsigned int		quirk;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.7.4

