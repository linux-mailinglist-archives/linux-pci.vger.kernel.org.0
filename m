Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B7711E463
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLMNNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 08:13:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53103 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLMNNu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 08:13:50 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191213131348epoutp01bc0ce86f0a133b56c8ed1426a8f00436~f8IBLBtFj1038910389epoutp01d
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2019 13:13:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191213131348epoutp01bc0ce86f0a133b56c8ed1426a8f00436~f8IBLBtFj1038910389epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576242828;
        bh=B6Kmh7y04e+S6+DClRE6v8swoNuYo9Ua7KXRiyoL7qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h20rhKprLyTEvYbUg9b/pgk9yt8Pb3tVnfQD7AH6ftXgW72UVEdawrqZIqGC7TPX8
         qUGY3DGVmadoCYvZbR/xNNJR304n+5UZMFGBQS++TdWOntsaoLpRArKgl5kpYDrXyK
         aMp+MrXGNpUg6bDilMqDAI05TtLA7i4/4d3mH5fs=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191213131347epcas5p2c0237c4c13ef258ebdcfb8b3ebb04e0d~f8IAQH6_01070910709epcas5p2h;
        Fri, 13 Dec 2019 13:13:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.BB.20197.B8E83FD5; Fri, 13 Dec 2019 22:13:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191213131346epcas5p25cb64137229edda4411131576a017a67~f8H-ShRge0792807928epcas5p20;
        Fri, 13 Dec 2019 13:13:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191213131346epsmtrp2fec5764eb4119e8b7a351720620bd97f~f8H-R01ri0346703467epsmtrp2I;
        Fri, 13 Dec 2019 13:13:46 +0000 (GMT)
X-AuditID: b6c32a4a-769ff70000014ee5-a3-5df38e8bacc5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.5F.06569.A8E83FD5; Fri, 13 Dec 2019 22:13:46 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213131344epsmtip2565d3da335b9d9a1f14672f2a3eaa95a~f8H9tYP2U1657516575epsmtip2u;
        Fri, 13 Dec 2019 13:13:44 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kishon@ti.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        bhelgaas@google.com, pankaj.dubey@samsung.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v6 1/2] phy: core: add phy_property_present method
Date:   Fri, 13 Dec 2019 18:43:19 +0530
Message-Id: <1576242800-23969-2-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576242800-23969-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZdlhTU7e773OswemDIhbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uPC0h83i8q45bBZn5x1ns3jz+wW7xdLrF5ksFm39wm7RuvcIuwOP
        x5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXps2f+Z0eP4je1MHp83yQVwRHHZpKTmZJalFunb
        JXBlPDx2mbFgrnDF4v+XmRsYn/N3MXJySAiYSLx/sp+9i5GLQ0hgN6NEw4srjBDOJ0aJy1+P
        QTnfGCVePF/KBNNyY9cfZojEXkaJWV82soAkhARamCSWTfMEsdkEtCV+Ht3LDmKLCFhLHG7f
        wgZiMwv8Y5R4PKcCxBYWcJL4vuATWC+LgKrErFPtzCA2r4CLRNeNUywQy+Qkbp7rBItzCrhK
        7Hy0AGyxhMBtNomz3+6wQRS5SNzsu8oKYQtLvDq+hR3ClpL4/G4vVE2+RO/dpVDxGokpdzsY
        IWx7iQNX5gAt4wA6TlNi/S59iDv5JHp/P2ECCUsI8Ep0tAlBmEoSbTOrIRolJBbPv8kMYXtI
        zNgwhxUSJDMYJf5u2co8gVF2FsLQBYyMqxglUwuKc9NTi00LjPJSy/WKE3OLS/PS9ZLzczcx
        glOIltcOxmXnfA4xCnAwKvHwMqR8ihViTSwrrsw9xCjBwawkwpuq/TlWiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO8k1qsxQgLpiSWp2ampBalFMFkmDk6pBkbXM9/rDE47WU48W3Zt5b+4aVbL
        A68zfvrX5V4+q3WXbObtJ3t2R6eLO/4/kOlptZAn4Vx5xY2Jf8NCVFhm3Wa9l7XClSu3u29P
        qu2q5pP3Dtt9jvdpDVP/UfRrf8LtB7ITvp+Yk+egE/dH9XDm2SXK3Cv+H4ySa/vntochJ6rq
        ao645x1X70AlluKMREMt5qLiRAAO9QctHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvG5X3+dYg0M7hS2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DKeHjsMmPBXOGKxf8vMzcwPufvYuTkkBAwkbix6w9zFyMXh5DAbkaJ/VtamCASEhJf9n5l
        g7CFJVb+e84OUdTEJNE5bQ1Ygk1AW+Ln0b3sILaIgK3E/UeTWUGKmAW6mCTO/LrPDJIQFnCS
        +L7gEwuIzSKgKjHrVDtYnFfARaLrxikWiA1yEjfPdYLFOQVcJXY+WgBmCwHVLFh6g3UCI98C
        RoZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBQayltYPxxIn4Q4wCHIxKPLwrEj/F
        CrEmlhVX5h5ilOBgVhLhTdX+HCvEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2
        ampBahFMlomDU6qB0efK1jszg2cbs95LZd8ikHwmXdD7c7zYiVPfdzPPas7OXvcpfOaUoM97
        i/uvnF+042XLyhvmEhypV99eian2OBKmsuSO//eG9XxHFs1asoWrvnnNup6vjE9LnwSttDd/
        yaieuM7scM3eExHvc75K7zuoaB3Nsdvsb7LmIs2r225rH3Dx01RN26/EUpyRaKjFXFScCAC/
        zUPpXgIAAA==
X-CMS-MailID: 20191213131346epcas5p25cb64137229edda4411131576a017a67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191213131346epcas5p25cb64137229edda4411131576a017a67
References: <1576242800-23969-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191213131346epcas5p25cb64137229edda4411131576a017a67@epcas5p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In some platforms, we need information of phy properties in
the controller drivers. This patch adds a new phy_property_present()
method which can be used to check if some property exists in PHY
or not.

In case of DesignWare PCIe controller, we need to write into controller
register to specify about ZRX-DC compliance property of the PHY, which
reduces the power consumption during lower power states.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
Changes w.r.t v5:
 - Added check for NULL pointer

 drivers/phy/phy-core.c  | 20 ++++++++++++++++++++
 include/linux/phy/phy.h |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b04f4fe..16b19aa 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -420,6 +420,26 @@ int phy_calibrate(struct phy *phy)
 EXPORT_SYMBOL_GPL(phy_calibrate);
 
 /**
+ * phy_property_present() - checks if the property is present in PHY
+ * @phy: the phy returned by phy_get()
+ * @property: name of the property to check
+ *
+ * Used to check if the given property is present in PHY.
+ * Searches for the given property in the phy device tree
+ * node.
+ *
+ * Returns: true if property exists, false otherwise
+ */
+bool phy_property_present(struct phy *phy, const char *property)
+{
+	if (!phy)
+		return false;
+
+	return of_property_read_bool(phy->dev.of_node, property);
+}
+EXPORT_SYMBOL_GPL(phy_property_present);
+
+/**
  * phy_configure() - Changes the phy parameters
  * @phy: the phy returned by phy_get()
  * @opts: New configuration to apply
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 56d3a10..9d8240d 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -218,6 +218,7 @@ static inline enum phy_mode phy_get_mode(struct phy *phy)
 }
 int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
+bool phy_property_present(struct phy *phy, const char *property);
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return phy->attrs.bus_width;
@@ -355,6 +356,11 @@ static inline int phy_calibrate(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline bool phy_property_present(struct phy *phy, const char *property)
+{
+	return false;
+}
+
 static inline int phy_configure(struct phy *phy,
 				union phy_configure_opts *opts)
 {
-- 
2.7.4

