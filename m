Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F830104933
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 04:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKUDUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 22:20:41 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:18898 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfKUDUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 22:20:40 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191121032037epoutp024d8ceb166ae8837f5126b41136c4d501~ZD10zmBX61527615276epoutp02K
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 03:20:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191121032037epoutp024d8ceb166ae8837f5126b41136c4d501~ZD10zmBX61527615276epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574306437;
        bh=2YYXgjCg4OpFQwaAFuEh8nJn991F2oDFmVnHATA+nac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEB9UpPFZhYng4mlH7+JmmA4+9WAEmATwrm1V9uar9+YkEP/iDEr5/X6K40TTKrOG
         IpMtyEGGVpryE2CSjytC59DN1dtTfAM0gSYjmrgxv6n4GyVDMr+79qg9ZcYpCGcs5d
         13mMnzq1yvBTGcEpjFoUQuDp0VBYNQA72sgDiBzo=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191121032037epcas5p28c24613dedc01675ea87f0c899e8b5fb~ZD10ZQUaC0606906069epcas5p2p;
        Thu, 21 Nov 2019 03:20:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.9F.04403.58206DD5; Thu, 21 Nov 2019 12:20:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191121032036epcas5p1ec12cabed1104c131a3cab202a180c21~ZD1z1c92w2857128571epcas5p1J;
        Thu, 21 Nov 2019 03:20:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191121032036epsmtrp1a6336e44477a887e1a22d9c76edaada5~ZD1z0sUHs0943209432epsmtrp1C;
        Thu, 21 Nov 2019 03:20:36 +0000 (GMT)
X-AuditID: b6c32a4a-3cbff70000001133-5c-5dd60285df84
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.1C.03654.48206DD5; Thu, 21 Nov 2019 12:20:36 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191121032034epsmtip25a429275ad648a37efb20d8c671e49c8~ZD1yLlJ3H2680226802epsmtip2X;
        Thu, 21 Nov 2019 03:20:34 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        pankaj.dubey@samsung.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v4 1/2] phy: core: add phy_property_present method
Date:   Thu, 21 Nov 2019 08:50:07 +0530
Message-Id: <1574306408-4360-2-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574306408-4360-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZdlhTQ7eV6Vqswb7lfBbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uPC0h83i8q45bBZn5x1ns3jz+wW7xdLrF5ksFm39wm7RuvcIuwOP
        x5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXps2f+Z0eP4je1MHp83yQVwRHHZpKTmZJalFunb
        JXBl/L93lbHgiETFgnnaDYzdIl2MHBwSAiYSax9pdjFycQgJ7GaUeL72EyOE84lR4lfbT3YI
        5xujRNfZ2cxdjJxgHW/OvGGCSOxllGj5thzKaWGS+LW4lRGkik1AW+Ln0b3sILaIgLXE4fYt
        bCBFzAL/GCWufpkHViQs4CTxfd4isLEsAqoSp79PYAKxeQWcJXYcXccOsU5O4ua5TrAaTgEX
        iaZb28G2SQhcZ5O49fooG0SRi8Tuib9YIWxhiVfHt0A1S0m87G+DsvMleu8uhbJrJKbc7WCE
        sO0lDlyZwwIKDWYBTYn1u/RBwswCfBK9v58wQQKJV6KjTQjCVJJom1kN0SghsXj+TWigeEhc
        OfebGRIO0xklTr56wDqBUXYWwtAFjIyrGCVTC4pz01OLTQuM8lLL9YoTc4tL89L1kvNzNzGC
        U4iW1w7GZed8DjEKcDAq8fBmaFyNFWJNLCuuzD3EKMHBrCTCu+f6lVgh3pTEyqrUovz4otKc
        1OJDjNIcLErivJNYr8YICaQnlqRmp6YWpBbBZJk4OKUaGLeK6vMzyMxqr+bozD/QFjx7Xav+
        k23x2uZqZYnNHbs2pVRHm5c1z+yMUitlCEt62vpS3Xm982GBosvWB38WNE1bMv2l25ymyT57
        L+2NdTi1wviIi2sf98lfckqsjW8sHRIs1QzecT+9uYJX+tjxZTcnpLc+T3n6uvzAsr2im7Yo
        i5W8XD3zthJLcUaioRZzUXEiAI+ob8UdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvG4L07VYg5ufVCya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DK+H/vKmPBEYmKBfO0Gxi7RboYOTkkBEwk3px5w9TFyMUhJLCbUeLYnUWMEAkJiS97v7JB
        2MISK/89Z4coamKS+LJgIhNIgk1AW+Ln0b3sILaIgK3E/UeTWUGKmAW6mCTWnt4ClhAWcJL4
        Pm8RM4jNIqAqcfr7BLBmXgFniR1H17FDbJCTuHmuE6yGU8BFounWdrAaIaCa3Vdusk5g5FvA
        yLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4hLU0dzBeXhJ/iFGAg1GJhzdD42qs
        EGtiWXFl7iFGCQ5mJRHePdevxArxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7
        NbUgtQgmy8TBKdXAKPE0atG+vUq2HXO+xbJeUrjkYHc2Nedm776oLguhT56xjzkqdVTnWe9I
        NWuXLFm26JLcrqVHb67l8ZDtYDjw4Pe0D2f+R2b9NBFSZjf4yfyqVrN6T+tR5l9MXdZnJ1tw
        7Gg+GPIv/+O1U5/nCVSKs805H/1g9dbJcd85e0N17rvqTNY86VlYqMRSnJFoqMVcVJwIAFhr
        3ihdAgAA
X-CMS-MailID: 20191121032036epcas5p1ec12cabed1104c131a3cab202a180c21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191121032036epcas5p1ec12cabed1104c131a3cab202a180c21
References: <1574306408-4360-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191121032036epcas5p1ec12cabed1104c131a3cab202a180c21@epcas5p1.samsung.com>
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
 drivers/phy/phy-core.c  | 26 ++++++++++++++++++++++++++
 include/linux/phy/phy.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b04f4fe..0a62eca 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -420,6 +420,32 @@ int phy_calibrate(struct phy *phy)
 EXPORT_SYMBOL_GPL(phy_calibrate);
 
 /**
+ * phy_property_present() - checks if the property is present in PHY
+ * @phy: the phy returned by phy_get()
+ * @property: name of the property to check
+ *
+ * Used to check if the given property is present in PHY. PHY drivers
+ * can implement this callback function to expose PHY properties to
+ * controller drivers.
+ *
+ * Returns: true if property exists, false otherwise
+ */
+bool phy_property_present(struct phy *phy, const char *property)
+{
+	bool ret;
+
+	if (!phy || !phy->ops->property_present)
+		return false;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->property_present(phy, property);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_property_present);
+
+/**
  * phy_configure() - Changes the phy parameters
  * @phy: the phy returned by phy_get()
  * @opts: New configuration to apply
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 15032f14..3dd8f3c 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -61,6 +61,7 @@ union phy_configure_opts {
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
  * @release: ops to be performed while the consumer relinquishes the PHY
+ * @property_present: check if some property is present in PHY
  * @owner: the module owner containing the ops
  */
 struct phy_ops {
@@ -103,6 +104,7 @@ struct phy_ops {
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
 	void	(*release)(struct phy *phy);
+	bool	(*property_present)(struct phy *phy, const char *property);
 	struct module *owner;
 };
 
@@ -217,6 +219,7 @@ static inline enum phy_mode phy_get_mode(struct phy *phy)
 }
 int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
+bool phy_property_present(struct phy *phy, const char *property);
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return phy->attrs.bus_width;
@@ -354,6 +357,11 @@ static inline int phy_calibrate(struct phy *phy)
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

