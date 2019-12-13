Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3C11E3D3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 13:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLMMsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 07:48:03 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:33169 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfLMMsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 07:48:02 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191213124759epoutp0470c6803085d20192350110567c05b272~f7xeMZZIA2826528265epoutp041
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2019 12:47:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191213124759epoutp0470c6803085d20192350110567c05b272~f7xeMZZIA2826528265epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576241279;
        bh=dF+joeRXr35w+KD/l41FVim/VsNsTXNOaCTaNQOGVFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akI56QVWu6ta9fk/XapZnx4fk5JSYdCDcc4bdMZsAL6gLr7PIEuRMq5MQ7QMbIL2x
         XVzWg4CC3Di97pfICctKDXq2Z94uwePy4zYDC0UYkjq7K7eByoaKQZWqWBZ0LbQNvd
         t3HB1UoUudVQm6l2YHb+Gmj0EDMgJxaJLUSpexUc=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191213124758epcas5p325b8c0b96bc9adf40f3586d711c941b6~f7xdvrJmU1050310503epcas5p35;
        Fri, 13 Dec 2019 12:47:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.17.19629.E7883FD5; Fri, 13 Dec 2019 21:47:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191213124758epcas5p1dd57ce8a5940b81ec6988228e0db8cb9~f7xdeQjES3254632546epcas5p1i;
        Fri, 13 Dec 2019 12:47:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191213124758epsmtrp2d5dd8aee37da48ad51454feb3e40e19b~f7xddmP-p2430824308epsmtrp2I;
        Fri, 13 Dec 2019 12:47:58 +0000 (GMT)
X-AuditID: b6c32a4b-32dff70000014cad-17-5df3887ee951
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.BC.10238.E7883FD5; Fri, 13 Dec 2019 21:47:58 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213124756epsmtip2826c13f340ef5e2ddc8639a257fef612~f7xbtC3rk0678306783epsmtip27;
        Fri, 13 Dec 2019 12:47:56 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kishon@ti.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        bhelgaas@google.com, pankaj.dubey@samsung.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v5 1/2] phy: core: add phy_property_present method
Date:   Fri, 13 Dec 2019 18:17:42 +0530
Message-Id: <1576241263-23817-2-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576241263-23817-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHeXa3e6/D5dMUOhkZjkJUnIkJFxSNMLhQ9PItSqmbXpykc2xq
        ahFmqVdJKR3idJiagi1fcJkvs5H40uqDpmmY0Kgo6QUTdcMwy+p2J337/f/nnOd/ODw0oRYU
        wXSmPpc36rksDamU94+FR0RdEzypB18KIcyN3wMKZtLRomDaSnSMwy1QTIfXQjHTi7dIZtZh
        JZnJJhfJLG1+ppj2+RkZ0/rISzGlznHqsD/b2dSJ2KEGN8U22/NYu62CZKv7bIjte+JBrOv1
        gIz12ENO0WeVCel8VmY+b4xOvKDUmb+rDUJggXdZW4zeBFQiPxrwIZh9aCErkZJW42EE5vUa
        mSTWEDTP2X1iHUHvSAfaHvnS0oKkghPBnQnBJ27KoLV2TiZ2kTgSNiaclMhBOB7GyvtIkQm8
        heCDtUDkQHwEnj5e/evTtBwfgHrLSdFW4WSwvbP6wkJgYaqCENkPH4XxHz0KMQvwPAmDL2oV
        UlMy/OoWfBwIX119lMTB4Fl2khLnQJW73edfBbNb8AUkwcicVS7uQOBw6HFES2vugKrNjzLR
        BqwCoUwtoQbKLFekQYB7dxcIiVl4vjxDSFeoRzD2wEPeRnsb/j/ajJAN7eYNpuwM3hRniNXz
        l7UmLtuUp8/QpuVk29G//xFxbBDZp46PIkwjjb+qg1tLVSu4fFNh9igCmtAEqfhIT6palc4V
        FvHGnPPGvCzeNIr20HLNLlWN4lWKGmdwufwlnjfwxu2qjPYLLkZEXX/vGSEiKar0k80eu9i6
        n1qKWd4IOJ3SVVmGcPxEVTU/5Xl2zmXoDo3rWVhxDDliw7pSrp9YLDd6O904sbZ/iWval9Ay
        bJXba7rikrEneTU0YUlbkvStIK1ttWnF/L5xZ93P6tQwR7xOUdTueuscL1+bzr/fELR1Mbyu
        USM36biYCMJo4v4AkOZW0hsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvG5dx+dYg6m/uCya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DKmPJdqKBDuOLLO70Gxjv8XYycHBICJhIvFy5kBLGFBHYzSjz9lgURl5D4svcrG4QtLLHy
        33P2LkYuoJomJond05ewgCTYBLQlfh7dyw5iiwjYStx/NJkVpIhZoItJ4syv+8wgCWEBJ4lj
        ez4CTeLgYBFQlZgx0x8kzCvgIrHqwRxGiAVyEjfPdYKVcwq4Shz5tZ4V4iAXiWftL9knMPIt
        YGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHLxamjsYLy+JP8QowMGoxMPLkPIp
        Vog1say4MvcQowQHs5IIb6r251gh3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRm
        p6YWpBbBZJk4OKUaGLXb0juymP/dss4V2BPmeDdky68dtbVrlHrzxK087Je3XGrVWMJzbJ3Z
        PxdlhkDh2jivb7qd1QobdCYHvruZ976ORc94aZRj3pzCgz4vizi+rJzhfYjt/22Feetj16eK
        9Pyz2qtc+ezNoenOuo2f/nttYdf9qcz2JIlZV11eWGXF+hOm9fv2KLEUZyQaajEXFScCAIcs
        jidaAgAA
X-CMS-MailID: 20191213124758epcas5p1dd57ce8a5940b81ec6988228e0db8cb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191213124758epcas5p1dd57ce8a5940b81ec6988228e0db8cb9
References: <1576241263-23817-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191213124758epcas5p1dd57ce8a5940b81ec6988228e0db8cb9@epcas5p1.samsung.com>
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
Changes w.r.t v4:
 - Addressed review comments from Andrew Murray

 drivers/phy/phy-core.c  | 17 +++++++++++++++++
 include/linux/phy/phy.h |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b04f4fe..f3ec28f 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -420,6 +420,23 @@ int phy_calibrate(struct phy *phy)
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

