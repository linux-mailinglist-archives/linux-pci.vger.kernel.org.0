Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D863E712D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 13:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbfJ1MSC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 08:18:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50736 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389006AbfJ1MSC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 08:18:02 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191028121800epoutp04982ace1edd9ae41d88d432607b8f7a7a~RzsKo3i4H1123811238epoutp04z
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:18:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191028121800epoutp04982ace1edd9ae41d88d432607b8f7a7a~RzsKo3i4H1123811238epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572265080;
        bh=0LFmfyIwGTeUHxbQOwSG3EtppNsBrL7xPrgGbm4gJ3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HraHgELTectkUt24BWos4igHtbDeAGUPYEe9aO1zu7YuF2BlSSvkd9XjONgWgnERW
         oWHukiKIubdyEe9QV192yy56PqE6zXn2hQPCoJ2S0H3TeGHyzZPiQaT204Wteq/TmV
         e+dMxyCHDGXi3DWgFDt38UAFSAUEtX7pw/vwHADY=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191028121759epcas5p24cdfa929093897d184248c0411080847~RzsJe6nDJ1905819058epcas5p29;
        Mon, 28 Oct 2019 12:17:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.CD.20245.77CD6BD5; Mon, 28 Oct 2019 21:17:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191028121758epcas5p2dda6d0842be32bcab2e6025fac1f3e78~RzsI_jMAw1905819058epcas5p28;
        Mon, 28 Oct 2019 12:17:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191028121758epsmtrp25c2fed104ab163f2955307216c65aa6e~RzsI924o51489714897epsmtrp2f;
        Mon, 28 Oct 2019 12:17:58 +0000 (GMT)
X-AuditID: b6c32a4b-fa1ff70000014f15-b7-5db6dc77cfc9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.89.24756.67CD6BD5; Mon, 28 Oct 2019 21:17:58 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191028121756epsmtip155a5e7347bd6cdbf346af49bf49b989c~RzsHZtJH72323023230epsmtip1W;
        Mon, 28 Oct 2019 12:17:56 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, pankaj.dubey@samsung.com,
        Anvesh Salveru <anvesh.s@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH v2 2/2] PCI: dwc: Add support to handle ZRX-DC Compliant
 PHYs
Date:   Mon, 28 Oct 2019 17:46:28 +0530
Message-Id: <1572264988-17455-3-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHeXeuzpaHKfhk6IehhIZamXSgMimDkUGFn4osRx5UmtvYdGpG
        SJY5aSYaoqbO7rrMYpqZ4m2pq3ALnRLi7GZlidZSsXRKNc+kb7////k/F15eGhP/wgPoNEUG
        p1bI5BJSiLc+Dw0Nz3K0Jm7rasbY/D9PCdbafpNg71xMZQ19NoJtnyik2PqFSoq1t1eTrLXW
        QrIzrq8Ue+vJAhUrlDbWNiLps6oJSlpnypQWtxiRtKV7HknnTUFHyRPCPcmcPE3LqSNjkoSp
        Nb39AtWgOHvu2k+Uh/KZIuRFA7MT9DNDZBES0mKmA4F1shjjxRyCweU6j1hEYP9RT663vPk4
        4il0InCUmxAvLglgpqIFuVMksxWW+jupIkTTfsxxsOQR7gzGfEMwPmsj3Blf5gh0X5laY5wJ
        gTqbGXeziImDlQanZ1sQjNl0mJu9mIPgshrXjgWmjYRxyw2cD8XBbF+Zh31h2tJC8RwA8987
        PYOUoJ+46/HPw/WJQsTzPugZqcbdh2JMKDxqj3TbGLMR9K5PArcNjAgKC8Q8SqCgMpdvBLht
        GMN4lkKNYZjgn6ECwe8P5WQJCqz6P7QOISPaxKk06SmcJloVpeCyIjSydE2mIiXijDLdhNa+
        Q1h8GzLZDpsRQyPJBlGJvTVRTMi0mpx0MwIak/iJhgb/WaJkWc45Tq08rc6Ucxoz2kzjEn9R
        KTF6UsykyDK4sxyn4tTrVQHtFZCHyqhdPkpqsQkTiQq7wwNXUx4v08PNS00vvLPjO4yG+2OO
        steE7EFT76rqgs8pXe3xpsCrjuD9PrFbFvZG9VwewHu/vMOnX4Ycs/q/1UU5lVPCV95yY/lA
        aXxSjK4qdyVx2nXvkLOhK/pAQvLD8NH3I58NO+yTAq0+2Lk7IkGrkOCaVNn2MEytkf0F6PY/
        PAoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnG7ZnW2xBhtmSVs0/9/OanF210JW
        iyVNGRbzj5xjtdh1t4PdYsWXmewWl3fNYbM4O+84m8Wb3y/YLRZt/cLuwOWxZt4aRo+ds+6y
        eyzYVOrRt2UVo8eW/Z8ZPT5vkgtgi+KySUnNySxLLdK3S+DKmHvwKFPBGaGKT/0fGRsYmwW6
        GDk5JARMJK4/usLcxcjFISSwm1Fi1bUzjBAJCYkve7+yQdjCEiv/PWcHsYUEmpgkHm0KBrHZ
        BLQlfh7dCxTn4BARiJbY8EoIZA6zwHtGiZmXn4DNERbwlZi34TfYHBYBVYkF5w6xgNi8Ai4S
        f1Z+gJovJ3HzXCcziM0p4Crx++wqNohdLhIrzu5gncDIt4CRYRWjZGpBcW56brFhgWFearle
        cWJucWleul5yfu4mRnBgamnuYLy8JP4QowAHoxIP74ur22KFWBPLiitzDzFKcDArifBePAMU
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvs071ikkEB6YklqdmpqQWoRTJaJg1OqgbFcn4EtcGF0
        Bm/X7BwmWVm33QVbPVPbtzZpPeNNOtb+/z7zoy69J/qvr3Ym3io70JwjnNbSuV4oXn3usXe2
        tuJeFt7n5RRMJuyuOLHx2qvJa/RXPpx++jCXyto4mU2zPNb+WsRb0rgs+NFn7XThWQHv+WZY
        8jjEWinmMSo0lC47syblz7nTOkosxRmJhlrMRcWJALwWJz1IAgAA
X-CMS-MailID: 20191028121758epcas5p2dda6d0842be32bcab2e6025fac1f3e78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191028121758epcas5p2dda6d0842be32bcab2e6025fac1f3e78
References: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191028121758epcas5p2dda6d0842be32bcab2e6025fac1f3e78@epcas5p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Many platforms use DesignWare controller but the PHY can be different in
different platforms. If the PHY is compliant to the ZRX-DC specification
it helps lower power consumption during power states.

If current data rate is 8.0 GT/s or higher and PHY is not compliant to
ZRX-DC specification, then after every 100ms link should transition to
recovery state during the low power states.

DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.

Platforms with ZRX-DC compliant PHY can set "snps,phy-zrxdc-compliant"
property in controller DT node to specify this property to the controller.

CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change in v2:
 - trivial change in patch description

 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 820488dfeaed..6560d9f765d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -556,4 +556,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
+
+	if (of_property_read_bool(np, "snps,phy-zrxdc-compliant")) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
+		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
+	}
+
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5a18e94e52c8..427a55ec43c6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -60,6 +60,9 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_GEN3_RELATED		0x890
+#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL		BIT(0)
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
-- 
2.17.1

