Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB711E465
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLMNNy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 08:13:54 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:10922 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLMNNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 08:13:54 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191213131352epoutp022a92d397534f18742cbe5c245e4a07a8~f8IEkoj2m2468724687epoutp02N
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2019 13:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191213131352epoutp022a92d397534f18742cbe5c245e4a07a8~f8IEkoj2m2468724687epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576242832;
        bh=kndy2Y5LGVy0vs5kAh24/QnBy9l7iubosPTnmQtJ/LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jif3WHqZjzngnhr0uBR5LQw/BvWaLgd7QGZNebkh15FE17cNdgkUfzQtlv58V6Inc
         NVC+tzOvZNGMuxqZOcfD3AH6cfio5/uJwLR70LdvIvmGal0hrYW5/SGuXde2wD8mp1
         HQ/fLxKjN4tVOgkyYodQPCKwMMe2OGNedj0Y+tHE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191213131351epcas5p47065a6338b617bb51be7136d2081ef93~f8IDxfR222192921929epcas5p4K;
        Fri, 13 Dec 2019 13:13:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.CB.20197.F8E83FD5; Fri, 13 Dec 2019 22:13:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191213131350epcas5p3c90ec8981639f488b65d8e09b098fa2b~f8IDBogw22448124481epcas5p3K;
        Fri, 13 Dec 2019 13:13:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213131350epsmtrp18222a1603e849d5f02f08789c7a0d0dd~f8IDA6Jzp0753107531epsmtrp1Q;
        Fri, 13 Dec 2019 13:13:50 +0000 (GMT)
X-AuditID: b6c32a4a-781ff70000014ee5-aa-5df38e8fd7a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.5F.06569.E8E83FD5; Fri, 13 Dec 2019 22:13:50 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213131348epsmtip25761b5a380b91a36dfe14d8ef0a0cec5~f8IBYiI-01371613716epsmtip2-;
        Fri, 13 Dec 2019 13:13:48 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kishon@ti.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        bhelgaas@google.com, pankaj.dubey@samsung.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v6 2/2] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Date:   Fri, 13 Dec 2019 18:43:20 +0530
Message-Id: <1576242800-23969-3-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576242800-23969-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZdlhTS7e/73OsQeNTDovm/9tZLc7uWshq
        saQpw2LX3Q52ixVfZrJbXHjaw2ZxedccNouz846zWbz5/YLdYun1i0wWi7Z+Ybdo3XuE3YHH
        Y828NYweO2fdZfdYsKnUY9OqTjaPvi2rGD227P/M6HH8xnYmj8+b5AI4orhsUlJzMstSi/Tt
        ErgyHk5bzVKwRqjiwKTLzA2Mx/m7GDk5JARMJA5sPMDcxcjFISSwm1Fi94tvLCAJIYFPjBJH
        dilAJL4xSjQ0TGGG6bh65hQbRNFeRokJc0QhilqYJD7NPcYOkmAT0Jb4eXQvmC0iYC1xuH0L
        WAOzwD9GicdzKroYOTiEBfwlzi4Bm8kioCpxZNMjsHJeAReJNZt3skDskpO4ea4TrIZTwFVi
        56MFYJdKCNxmk7ix5Q/UQS4Sr/9NY4SwhSVeHd/CDmFLSbzsb4Oy8yV67y6FsmskptztgKq3
        lzhwZQ4LyD3MApoS63fpQ5zJJ9H7+wkTSFhCgFeio00IwlSSaJtZDdEoIbF4/k2oAzwkPjb1
        skFCYQYw2H6uZJnAKDsLYegCRsZVjJKpBcW56anFpgVGeanlesWJucWleel6yfm5mxjB6UPL
        awfjsnM+hxgFOBiVeHgZUj7FCrEmlhVX5h5ilOBgVhLhTdX+HCvEm5JYWZValB9fVJqTWnyI
        UZqDRUmcdxLr1RghgfTEktTs1NSC1CKYLBMHp1QDY6XOWY3qN6Wb7FfFHD7VrCzpZfhqjUpr
        5+ymdCXbU3m2c7c3CBY+azm5eTf/c4F5zBoMc+J7f3VNXu1i6PjiuGf22jxfs5Lveyw8X8X1
        hFtdelqVVCtinBggXWv/7cKkuN6Vz7ebKwjuM1XfxHHFJGVtx0GpwDero5Jqvzj3cDw76GUe
        HeugxFKckWioxVxUnAgA5RbjghsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvG5f3+dYg7+XBCya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DKeDhtNUvBGqGKA5MuMzcwHufvYuTkkBAwkbh65hRbFyMXh5DAbkaJjpfTmSESEhJf9n5l
        g7CFJVb+e84OYgsJNDFJLGmIBbHZBLQlfh7dCxYXEbCVuP9oMivIIGaBLiaJM7/ugw0SFvCV
        uDn5NxOIzSKgKnFk0yOwBl4BF4k1m3eyQCyQk7h5rhOsnlPAVWLnowXMEMtcJBYsvcE6gZFv
        ASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4BDW0trBeOJE/CFGAQ5GJR7eFYmf
        YoVYE8uKK3MPMUpwMCuJ8KZqf44V4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1
        OzW1ILUIJsvEwSnVwNi86YaOHPvnO6uePVosHbVVuzPpdfkNzws2sYwfpG6sXL/5jnj6Jt/v
        bh//heWJin2avnNJ8L6DPL/LHW463ts24aGAeVwru+rDznOKTdYdn9805DZJna2vzD1395i/
        Ve/CW4kP1U813BO6J5W3ZoHAg8M+M5/OyrPTUz56aRtbZ7JT8b2eDfxKLMUZiYZazEXFiQAy
        IuEPXQIAAA==
X-CMS-MailID: 20191213131350epcas5p3c90ec8981639f488b65d8e09b098fa2b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191213131350epcas5p3c90ec8981639f488b65d8e09b098fa2b
References: <1576242800-23969-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191213131350epcas5p3c90ec8981639f488b65d8e09b098fa2b@epcas5p3.samsung.com>
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
Changes w.r.t v5:
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

