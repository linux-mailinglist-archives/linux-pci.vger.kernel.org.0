Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B0AD5C2B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfJNHSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 03:18:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44107 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730132AbfJNHSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 03:18:43 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191014071840epoutp04390c780bdde121b228eeddd8f183fa2a~Nck0bodug2399623996epoutp04_
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2019 07:18:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191014071840epoutp04390c780bdde121b228eeddd8f183fa2a~Nck0bodug2399623996epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571037520;
        bh=70p8clwBJRo2VRjh+IGIX8nmmtwD5MjLFQuDV0QZp5s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VHRjOlCddbYuUIpLRTkhPNsF8QzZHSufJ2Sh8NI5X+ry9Lhog8aacseea1D6Utirg
         9ui429ysZCuanJt3IbWFwhxf+jDdlw7LIU0kfSQpYHbfP4zpbGU4wsCbUk8Yicf45v
         Svut7ZrBl+F5M+13QvO0Fn4Xkbu4wIfw4NKXZmXA=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191014071839epcas5p2a34d3c8731f8787b954ff672cc2e2017~Nckz13Ga41122211222epcas5p2N;
        Mon, 14 Oct 2019 07:18:39 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.FB.04660.F4124AD5; Mon, 14 Oct 2019 16:18:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191014071838epcas5p2901e45c978e5a9d6dfbdde2dadea6d9d~Ncky9ZKX52493324933epcas5p2E;
        Mon, 14 Oct 2019 07:18:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191014071838epsmtrp16278063aaaac544dd27c81e379535559~Ncky8mMmM0123701237epsmtrp18;
        Mon, 14 Oct 2019 07:18:38 +0000 (GMT)
X-AuditID: b6c32a4a-5f7ff70000001234-59-5da4214fe6f8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.7C.03889.E4124AD5; Mon, 14 Oct 2019 16:18:38 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191014071837epsmtip252086bfc3e64bde5f3eb68942e36db34~Nckxc148H1930319303epsmtip21;
        Mon, 14 Oct 2019 07:18:37 +0000 (GMT)
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, vidyas@nvidia.com,
        Anvesh Salveru <anvesh.s@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2] PCI: dwc: Add support to add GEN3 related equalization
 quirks
Date:   Mon, 14 Oct 2019 12:48:29 +0530
Message-Id: <1571037509-20284-1-git-send-email-pankaj.dubey@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCmlq6/4pJYgx1fDSya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mclucXnXHDaLs/OOs1m8+f2C3WLR1i/sFte28zpweayZt4bRY+esu+we
        CzaVevQ2v2Pz6NuyitFjy/7PjB6fN8kFsEdx2aSk5mSWpRbp2yVwZVx5Mp+t4IRkxafWfWwN
        jI9Fuxg5OCQETCQ23vLtYuTiEBLYzShx7O1jdgjnE6NE47ejjBDON0aJpqYtTDAdTxqsIOJ7
        GSWaZ0xhgXBamCTmT1/J2sXIycEmoCvx5P1cZhBbRMBaouHVKlaQImaB54wSV/dfZQRJCAsE
        S2w7vArMZhFQlXi77zIbiM0r4CHx6mwTWLOEgJzEzXOdUPYKNokZPxUhrnCROL69BiIsLPHq
        +BZ2CFtK4mV/G5SdL/Fj8SRmkL0SAi2MEpOPz2WFSNhLHLgyhwVkDrOApsT6XfogYWYBPone
        30+gnuSV6GgTgqhWk/j+/AzUBTISD5uXMkHYHhIPvjeygNhCArESrxb/Z5nAKDMLYegCRsZV
        jJKpBcW56anFpgVGeanlesWJucWleel6yfm5mxjBiUDLawfjsnM+hxgFOBiVeHgV0hbHCrEm
        lhVX5h5ilOBgVhLhZZiwIFaINyWxsiq1KD++qDQntfgQozQHi5I47yTWqzFCAumJJanZqakF
        qUUwWSYOTqkGxv2PEt1OVroHfNS/uLrsW0vs/ZR2F2fWDczzmktfGX6s0t/A/rnl3+PQ7LUt
        m/mKOI7/j73i6DT19enaT/M/dVeprD7ddUnGWcxbsGjLhHcmV6ODuuyXZKX7Zk43WmZbqc0Z
        lcjJsLXHc1Ebf/G50vd1kvq7rzbc/quy4dK2miKpY4ffyJaKKLEUZyQaajEXFScCAFb7PdYA
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSvK6f4pJYg+53JhbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uLxrDpvF2XnH2Sze/H7BbrFo6xd2i2vbeR24PNbMW8PosXPWXXaP
        BZtKPXqb37F59G1ZxeixZf9nRo/Pm+QC2KO4bFJSczLLUov07RK4Mq48mc9WcEKy4lPrPrYG
        xseiXYwcHBICJhJPGqy6GDk5hAR2M0osX8EIYksIyEhMXr2CFcIWllj57zl7FyMXUE0Tk8TD
        /dfBitgEdCWevJ/LDGKLCNhKNPztYAYpYhZ4zygxf8MVsCJhgUCJW4tOsYHYLAKqEm/3XQaz
        eQU8JF6dbWKG2CAncfNcJ/MERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC
        A05LawfjiRPxhxgFOBiVeHhPJC+OFWJNLCuuzD3EKMHBrCTCyzBhQawQb0piZVVqUX58UWlO
        avEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkGRpuH7UIJz34GSQm+n5jQ/jhcertZ
        n8DujapHT52ydGkUSJvvaqP6XDvy66/AvW1Tr3nMY2A6wv1pTkb4g6At4n82MG7e69Rm92+a
        T+vs6vzbIWahbY5zHCyEhWOlPvvOLbsiWL5FcnK15FONc2aBNQm8XmJW1pINRVvevGpRMit6
        Kd94oUlQiaU4I9FQi7moOBEAiYoU7jQCAAA=
X-CMS-MailID: 20191014071838epcas5p2901e45c978e5a9d6dfbdde2dadea6d9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191014071838epcas5p2901e45c978e5a9d6dfbdde2dadea6d9d
References: <CGME20191014071838epcas5p2901e45c978e5a9d6dfbdde2dadea6d9d@epcas5p2.samsung.com>
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
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes w.r.t v1:
 - Rebased on latest linus/master
 - Added Reviewed-by and Acked-by

 drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 820488d..e247d6d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -556,4 +556,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
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
index 5a18e94..7d3fe6f 100644
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
@@ -253,6 +261,7 @@ struct dw_pcie {
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
 	unsigned int		version;
+	unsigned int		quirk;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.7.4

