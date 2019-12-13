Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B711E3D5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 13:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLMMsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 07:48:08 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:60482 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfLMMsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 07:48:07 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191213124803epoutp026e5da09809d16bd27d56ef5c149cf992~f7xiT-PCJ1107011070epoutp02x
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2019 12:48:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191213124803epoutp026e5da09809d16bd27d56ef5c149cf992~f7xiT-PCJ1107011070epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576241283;
        bh=RNA3KLbV3xAQuuRXK+GO3FWHFeIoltREm9OQRlPazpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/+Qj9Sc30nU6Xlbq7wj+aEsG6fkxtgRpnVqJo0HxMLq6pRr2BxpbgU1ulghmd1vG
         mCEwEW5iGpNQt9Var1Wg3FQbp/9E7gRYuotl8eVrAm418IWbEaj+zj6N74SCXuoqDS
         Ui1D+th68N9dwxfJne3oo+oZMF54+Swj9MZBEEu8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191213124802epcas5p3a960d11294ed9efe430de0595341d499~f7xhqvxnk1068210682epcas5p31;
        Fri, 13 Dec 2019 12:48:02 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.99.20197.28883FD5; Fri, 13 Dec 2019 21:48:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20191213124801epcas5p43782d720da90a107f75574620cbc5232~f7xg7J9dG2398623986epcas5p4n;
        Fri, 13 Dec 2019 12:48:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213124801epsmtrp18cd07b670d5711a88f266898e111986a~f7xg6XkLZ2978729787epsmtrp1Y;
        Fri, 13 Dec 2019 12:48:01 +0000 (GMT)
X-AuditID: b6c32a4a-781ff70000014ee5-b1-5df38882afe6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.BC.10238.18883FD5; Fri, 13 Dec 2019 21:48:01 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213124800epsmtip24f40401cfbedf84cd6ac4ec26307f06d~f7xfPq2Dy0892508925epsmtip2d;
        Fri, 13 Dec 2019 12:48:00 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kishon@ti.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        bhelgaas@google.com, pankaj.dubey@samsung.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v5 2/2] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Date:   Fri, 13 Dec 2019 18:17:43 +0530
Message-Id: <1576241263-23817-3-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576241263-23817-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZdlhTU7ep43Oswc8+TYvm/9tZLc7uWshq
        saQpw2LX3Q52ixVfZrJbXHjaw2ZxedccNouz846zWbz5/YLdYun1i0wWi7Z+Ybdo3XuE3YHH
        Y828NYweO2fdZfdYsKnUY9OqTjaPvi2rGD227P/M6HH8xnYmj8+b5AI4orhsUlJzMstSi/Tt
        ErgyGi9sZSxYI1TxaWcfWwPjcf4uRk4OCQETid8H+1m6GLk4hAR2M0rcO9TKCuF8YpS4ceM2
        M4TzjVHix731LDAtp69NZIdI7GWUOPN+DZTTwiTx6sI9NpAqNgFtiZ9H97KD2CIC1hKH27eA
        xZkF/jFKPJ5TAWILC/hLzNg4AWwqi4CqxLoH/YwgNq+Ai8TJveeYILbJSdw818kMYnMKuEoc
        +bUe7D4JgetsEtP3X2GFKHKR6J72iRnCFpZ4dXwLO4QtJfGyvw3KzpfovbsUyq6RmHK3gxHC
        tpc4cGUO0BEcQMdpSqzfpQ9xJ59E7+8nTCBhCQFeiY42IQhTSaJtZjVEo4TE4vk3mSHCHhIt
        l+NBTCGBGYwS8xQnMMrOQpi4gJFxFaNkakFxbnpqsWmBUV5quV5xYm5xaV66XnJ+7iZGcPrQ
        8trBuOyczyFGAQ5GJR5ehpRPsUKsiWXFlbmHGCU4mJVEeFO1P8cK8aYkVlalFuXHF5XmpBYf
        YpTmYFES553EejVGSCA9sSQ1OzW1ILUIJsvEwSnVwGhl8pRrVv+TqJlh7fe6XklpHetSU89f
        GNTKaiVkKCq1dp/0V81z9aKaienL9d/c5mIKfiR569GM/ZyfF72eU5awxJjrzOxPlsrvUjfv
        bXC9ldJlZaxRld/zbFd9xi2Nw8ohkr1SvSVh0zU0fHaE1sjMP96x23KunPKCJboh0+QZVO+q
        1P4sVGIpzkg01GIuKk4EAOqFJvUbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvG5jx+dYg82LjSya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DKaLywlbFgjVDFp519bA2Mx/m7GDk5JARMJE5fm8jexcjFISSwm1Fi2+QnbBAJCYkve79C
        2cISK/89hypqYpK4e2ATM0iCTUBb4ufRvewgtoiArcT9R5NZQYqYBbqYJM78ug9WJCzgK3Hk
        01ImEJtFQFVi3YN+RhCbV8BF4uTec0wQG+Qkbp7rBKvnFHCVOPJrPSuILQRU86z9JfsERr4F
        jAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCg1hLcwfj5SXxhxgFOBiVeHgZUj7F
        CrEmlhVX5h5ilOBgVhLhTdX+HCvEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs
        1NSC1CKYLBMHp1QDo9C3D5Wy2z5vMeZcw8i1s62AcdF5kUdMPZPl1ipnzWFfLxqrmx66uEx/
        koyvq3RVR4KB8noeOyaFm//9zJcmChsy6BSurA4QOnRyruCMILPlxup/Fn9b0fnz2/zuFe5n
        hXpDNNy3OXw44xV9RUBW28O2/6+UjG3cI1O3+6zr/3AzeXG57ZFUYinOSDTUYi4qTgQAQgx5
        J14CAAA=
X-CMS-MailID: 20191213124801epcas5p43782d720da90a107f75574620cbc5232
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191213124801epcas5p43782d720da90a107f75574620cbc5232
References: <1576241263-23817-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191213124801epcas5p43782d720da90a107f75574620cbc5232@epcas5p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Many platforms use DesignWare controller but the PHY can be different in
different platforms. If the PHY is compliant is to ZRX-DC specification
it helps in low power consumption during power states.

If current data rate is 8.0 GT/s or higher and PHY is not compliant to
ZRX-DC specification, then after every 100ms link should transition to
recovery state during the low power states.

DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.

Platforms with ZRX-DC compliant PHY can set phy_zrxdc_compliant variable
to specify this property to the controller.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
Changes w.r.t v4:
 - None

 drivers/pci/controller/dwc/pcie-designware.c | 6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 820488d..36a01b7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -556,4 +556,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
+
+	if (pci->phy_zrxdc_compliant) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5accdd6..36f7579 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -60,6 +60,9 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_GEN3_RELATED		0x890
+#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL	BIT(0)
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
@@ -249,6 +252,7 @@ struct dw_pcie {
 	void __iomem		*atu_base;
 	u32			num_viewport;
 	u8			iatu_unroll_enabled;
+	bool			phy_zrxdc_compliant;
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
-- 
2.7.4

