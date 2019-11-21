Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1969104922
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 04:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfKUDUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 22:20:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59279 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfKUDUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 22:20:44 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191121032042epoutp03a667af14527c783579015201cd13aa21~ZD146nKbf1711717117epoutp03G
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 03:20:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191121032042epoutp03a667af14527c783579015201cd13aa21~ZD146nKbf1711717117epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574306442;
        bh=KCs1uvI97PpS5Asra3/xeMU8NeStzT9VkGskDOx2tBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGr9z48Z1nIK2qa7PHil19dVQwiqsLpzDdCEB67R+xcLnB0y3/R6d6HKuYZy2uGYe
         npQjxD7BwPa0jh3lGnJPAOoVGrS5cx7dKqS31K5n5jXCWS5/94sMCkcqqrYmM8GvHO
         OmQx+ygiwwNARsdvS63ME3Icye1540PUdWpGwzYo=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191121032041epcas5p33c52f9aa3e046f3bc9af469bfbdc2bad~ZD14SKwze0576405764epcas5p3-;
        Thu, 21 Nov 2019 03:20:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.9F.04403.98206DD5; Thu, 21 Nov 2019 12:20:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20191121032041epcas5p433066ebc6a07b73a1949da26e55e9b2f~ZD13_kzQ20459004590epcas5p4i;
        Thu, 21 Nov 2019 03:20:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191121032041epsmtrp2c9a877fe4c7526a4b0d55f5190b92cfa~ZD139xxl91130011300epsmtrp2Q;
        Thu, 21 Nov 2019 03:20:41 +0000 (GMT)
X-AuditID: b6c32a4a-3b3ff70000001133-67-5dd60289765d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.CE.03814.88206DD5; Thu, 21 Nov 2019 12:20:41 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191121032039epsmtip28cdd1dc39af89a4660c7300bb6a97ae6~ZD12Tw9m82815928159epsmtip2D;
        Thu, 21 Nov 2019 03:20:39 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        pankaj.dubey@samsung.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v4 2/2] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Date:   Thu, 21 Nov 2019 08:50:08 +0530
Message-Id: <1574306408-4360-3-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574306408-4360-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZdlhTU7eT6VqswecdEhbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uPC0h83i8q45bBZn5x1ns3jz+wW7xdLrF5ksFm39wm7RuvcIuwOP
        x5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXps2f+Z0eP4je1MHp83yQVwRHHZpKTmZJalFunb
        JXBlHOydy1jQJ1Sx4Vt1A+Nm/i5GDg4JAROJptMZXYxcHEICuxkl7vx9wAjhfGKU6F7dxwzh
        fGOUOLrmJRNMx9zfORDxvYwSG95uYO1i5ARyWpgkOn9agNhsAtoSP4/uZQexRQSsJQ63b2ED
        aWAW+McocfXLPEaQhLCAv8T5vrVsIDaLgKrEhTXbwOK8As4Srw9MBotLCMhJ3DzXyQxicwq4
        SDTd2s4EMkhC4DqbxKpnnVBFLhIHVs6HsoUlXh3fwg5hS0l8frcXKp4v0Xt3KVS8RmLK3Q5G
        CNte4sCVOSwgnzELaEqs36UPEmYW4JPo/f0E6mFeiY42IQhTSaJtZjVEo4TE4vk3mSFsD4l/
        W2ZAw2o6o8SrmSdYJzDKzkIYuoCRcRWjZGpBcW56arFpgVFearlecWJucWleul5yfu4mRnD6
        0PLawbjsnM8hRgEORiUe3gyNq7FCrIllxZW5hxglOJiVRHj3XL8SK8SbklhZlVqUH19UmpNa
        fIhRmoNFSZx3EuvVGCGB9MSS1OzU1ILUIpgsEwenVAPjhPNyiaH8Qnc+vP/su83Q6JljsXvx
        +dSE0t2/bQ5kJV49fzxVLHKhq+pS2/vhTDy/Y2yuOlqH8jm8Xij6qb4j2WraY+v2Kr03LHfn
        u9j+Ug14VfnzscjhBjZ3Li2fZ0HqHakakfM6Kowz2i4uZ5izvSIpZMJW5Sniu6d/Fs6VDTK4
        +lQwwlaJpTgj0VCLuag4EQDe6bCxGwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvG4n07VYg42nmSya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DKONg7l7GgT6hiw7fqBsbN/F2MHBwSAiYSc3/ndDFycQgJ7GaUWLr0AnsXIydQXELiy96v
        bBC2sMTKf8/ZIYqamCRubLsElmAT0Jb4eXQvWIOIgK3E/UeTWUGKmAW6mCTWnt4ClhAW8JWY
        faqPBcRmEVCVuLBmGyOIzSvgLPH6wGSoDXISN891MoPYnAIuEk23tjOB2EJANbuv3GSdwMi3
        gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcABrae1gPHEi/hCjAAejEg9vhsbV
        WCHWxLLiytxDjBIczEoivHuuX4kV4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1
        OzW1ILUIJsvEwSnVwGjZsu3f5SC/6SLqCR11edLP+pRWvKlhCedd+fLUu4n9BxV3L5yYILuI
        JSatICr8/zW+1XvOPd7wyuHg08cT1/AZxHz9ZKpwKbWncLeAWUKLWCbffE6LwlKHerWWFoMe
        01o/rWX2fupGH//ztB7YzrO4IIP7NMPhVd4FGYHpCkGL3ft9bZ4JKbEUZyQaajEXFScCANJD
        jUxcAgAA
X-CMS-MailID: 20191121032041epcas5p433066ebc6a07b73a1949da26e55e9b2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191121032041epcas5p433066ebc6a07b73a1949da26e55e9b2f
References: <1574306408-4360-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191121032041epcas5p433066ebc6a07b73a1949da26e55e9b2f@epcas5p4.samsung.com>
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
index 5a18e94..f43f986 100644
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

