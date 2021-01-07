Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003972ED404
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbhAGQLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 11:11:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:49367 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbhAGQLG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 11:11:06 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210107161022epoutp045818d5d10d76144538bcf79d497fb19f~X-wzQurXD2391723917epoutp04J
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 16:10:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210107161022epoutp045818d5d10d76144538bcf79d497fb19f~X-wzQurXD2391723917epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610035822;
        bh=GHrxWzjNq+WBPx404+TbgCs2tA0hCKSMho/LiimfpuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCNHcsyAyEss8LASwcTSiS5R5quq8nc9fg8m54XTaV/bsOcKTngef+UOlHQRFKpBJ
         2TaF4F9RmVjEMakuyGXJb5uL2UnHS6y+1SjSbJkerKaMIduvvvskA5Qs/qfWjZDiEN
         CaKkYdAjAvGR7ECSXCMDZK14z098fQz+a3CKfoFs=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210107161021epcas5p4e993bf605cb33b60c3ebac688cb19ac2~X-wyf_tzp1957119571epcas5p4Y;
        Thu,  7 Jan 2021 16:10:21 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.AE.15682.D6237FF5; Fri,  8 Jan 2021 01:10:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210107153013epcas5p27700f30e341d7f1fb457035a690490c6~X-NvctQD92347223472epcas5p2r;
        Thu,  7 Jan 2021 15:30:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210107153013epsmtrp14014498c1239563402002bee1f1e6bed~X-NvbD-yG2999429994epsmtrp1E;
        Thu,  7 Jan 2021 15:30:13 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-64-5ff7326d2e77
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.F3.13470.40927FF5; Fri,  8 Jan 2021 00:30:12 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210107153011epsmtip2866ddeedca2aea915f7b2fa686e089c7~X-Ntk70bI2046620466epsmtip2R;
        Thu,  7 Jan 2021 15:30:10 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Anvesh Salveru <anvesh.salveru@gmail.com>,
        Shradha Todi <shradha.t@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v7 1/5] phy: core: add phy_property_present method
Date:   Thu,  7 Jan 2021 20:58:39 +0530
Message-Id: <1610033323-10560-2-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+845247S6jSN3matWuat0rLbEbpK2iwrYYSggo06WEy3tXkp
        RbOb5rxCTtDETKV0paJZ07QyLZWsMNdlptYIo+yCpXOTzC7zJP33e573+Z4XXj4SF/wihORR
        RSyjVsiixVxH4la7p/vqGF9b5BrtWxd64loeTn8vqMLonvdZXHrggwnRxtvFXPpJSSeXzrAU
        cemh/Hcc+mGdlC67aeHR2e3JtKmWRzcNdOHb+ZKmokGepF6fwZXkNOiRpNNkwCRj9aIQTpjj
        5sNM9NF4Ru2z9aDjkbqcEUJ1yfn4VJ8RT0VmSoscSKDWgzbrC0+LHEkB1Ywg+7QVsWIUwfkf
        +QQrrAiqM59xZ570VQ79S91BUDlWjbHiLAaTny3InuJSXnBqXIvb2ZkKg0LDOY49hFN1GHQM
        9RL2gRPlD+kGG8fOBLUCOobP/GWS5FMBYEpXs9tE0Pc0Y7rHgQoEa0ENh/W/8qChScryTjC0
        ZuIsO8GnzgYey0IYzk37x0rQ9bwn7PVAHYerWSmsvQ1anxdP2zjlCbW3fVh7Mege1WB2xqk5
        kD05hLE+HxpLZng5WKZaCJYXQkmHkcO2S2DSupK9SCGC8mYdlodERf83lCKkRwsZlSYmitFs
        UK1VMAneGlmMJk4R5X1IGVOPpr+IV1AjGjR/825DGInaEJC42JlPd1giBfzDshOJjFoZqY6L
        ZjRtyIUkxAv4jWvMkQIqShbLyBlGxahnphjpIEzFyht0L5fN3pQuLbt+R+ZWE++3N2U0oTtk
        t0P5Ba/MpUHbcubFeyRUKG2/sCSiJTFvZJ28h4MH9cu/Dy5qLt4iWtI+Eeo07Po7XOh25l1G
        ph+ySWuKfPZLZ3nICxTiN2PiuxWd47ETVKItKzf5cSnT3SsLGHfedyo4SY+3eq4qbZlvsEbc
        4+3aM35fY7oYtkAkffBDHre7qjl3oto1VhVkRStDK68Eq8KrQvTutf5pFXlTL0KPDacMmpls
        11dJHiURP1/7B3d/PBvRf/lAvW7OKJlsrKanjO1LAoXhlK8uII28gd34EG809859q3yREOgN
        Gwa6dpRtPHQ+3OWkYH+pmNAcka31wtUa2R+J+8oYkQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvC6L5vd4g5WLLCx+rJ7AbPFx2kom
        iwtPe9gs7jy/wWhxedccNouz846zWXR+mcVm8WTKI1aLoxuDLRZt/cJu0Xu41uLGenaLnXdO
        MDvweuycdZfdY9OqTjaPvi2rGD2O39jO5PF5k1wAaxSXTUpqTmZZapG+XQJXxsa+9ywF80Uq
        /t68zNzA+ECgi5GTQ0LAROLmiieMXYxcHEICuxklzm+YywSRkJT4fHEdlC0ssfLfc3aIoiYm
        ia3b1jOCJNgEtCQav3Yxg9giAjES6//dZAWxmQV2M0lcb1EFsYUFnCTat38Hi7MIqEoce9kM
        ZHNw8Aq4StxoL4KYLydx81wn2BhOATeJb9PWgZUIAZU8/BQygZFvASPDKkbJ1ILi3PTcYsMC
        w7zUcr3ixNzi0rx0veT83E2M4EDV0tzBuH3VB71DjEwcjIcYJTiYlUR4LY59iRfiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBaUvxx3MlvxZr8KdsKu5x
        Cv30Q2DhbJ9HDg9eGr5pK5sell+cceViAsOyX8nTrlR2V01Z94nF/iFD1B/dgst/f0+3tEvl
        dfrz72AtE4/8/VOno2R/Bs/KTLNbv29eYkvO50XTXs+wEOFo6LHMPnJLiM+sjscgxV58wf6k
        UHOXa4EMui8+bcpKfMotEbJ8UUHD4mO2p40zP5Xv9Xc/9Ksu66hT41vFui2nbyxy2m52ZN1H
        yeUr7s2aWf/y3ps9R7kEruhPneKgsfLL0wd+GxY+5C38XnFrr617s7I0S3hNDe+8859il771
        CFhlIsR00mdLZbCaRWLhrZy86StXq/s8tog4b+PVapQ72/AG347L25RYijMSDbWYi4oTAb6G
        PmvDAgAA
X-CMS-MailID: 20210107153013epcas5p27700f30e341d7f1fb457035a690490c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210107153013epcas5p27700f30e341d7f1fb457035a690490c6
References: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
        <CGME20210107153013epcas5p27700f30e341d7f1fb457035a690490c6@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

In some platforms, we need information of phy properties in the controller
drivers. This patch adds a new phy_property_present() method which can be
used to check if some property exists in PHY or not.

In case of DesignWare PCIe controller, we need to write into controller
register to specify about ZRX-DC compliance property of the PHY, which
reduces the power consumption during lower power states.

Signed-off-by: Anvesh Salveru <anvesh.salveru@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/phy-core.c  | 20 ++++++++++++++++++++
 include/linux/phy/phy.h |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 71cb108..e4ecd41 100644
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
index e435bdb..cdecb07 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -225,6 +225,7 @@ static inline enum phy_mode phy_get_mode(struct phy *phy)
 }
 int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
+bool phy_property_present(struct phy *phy, const char *property);
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return phy->attrs.bus_width;
@@ -363,6 +364,11 @@ static inline int phy_calibrate(struct phy *phy)
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

