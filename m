Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4401B2ED409
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 17:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbhAGQLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 11:11:18 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39157 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbhAGQLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 11:11:18 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210107161034epoutp011fd667964ee50c35149e7f70e77ff37b~X-w_-h4Pg1143411434epoutp01K
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 16:10:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210107161034epoutp011fd667964ee50c35149e7f70e77ff37b~X-w_-h4Pg1143411434epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610035834;
        bh=SfJ1p5PIlvjC67TEjjEzycegLmmbSbvIw52hxr22TDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccu25kNtCIwA+FYE1W8d8FhFjryhWCltlfE6SqF6IqLhxhLb3NuylMGeXABSoIH05
         69F332GUkb5O5035IyZhNQfDUrjytsP9uVbtChk6XWl0JbtQTxNvWGV3q3Xmc4gtjh
         XboctYR1VKu7V5O1IA7xx/J0xqeXLuvjKNa9ppng=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210107161034epcas5p3d40f2d1ff40fa4c5c98ea665fe7fe760~X-w_TK_zU0347603476epcas5p3J;
        Thu,  7 Jan 2021 16:10:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.0C.50652.A7237FF5; Fri,  8 Jan 2021 01:10:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210107153051epcas5p4f54210f89f8b8d2e18be016521657be0~X-OTrEJy01933919339epcas5p4I;
        Thu,  7 Jan 2021 15:30:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210107153051epsmtrp144737890d21fe5e7027514be999abc93~X-OTqP6op3139431394epsmtrp1T;
        Thu,  7 Jan 2021 15:30:51 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-25-5ff7327a5837
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.3A.08745.B2927FF5; Fri,  8 Jan 2021 00:30:51 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210107153049epsmtip20cc9b2af1606f48f42afde84cb6229fe~X-ORvLXRv2451724517epsmtip2P;
        Thu,  7 Jan 2021 15:30:49 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Shradha Todi <shradha.t@samsung.com>,
        Anvesh Salveru <anvesh.salveru@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v7 3/5] dt-bindings: PHY: P2U: Add binding for ZRX-DC PHY
 property
Date:   Thu,  7 Jan 2021 20:58:41 +0530
Message-Id: <1610033323-10560-4-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZdlhTXbfK6Hu8QftCNosfqycwW3yctpLJ
        4sLTHjaLO89vMFpc3jWHzeLsvONsFp1fZrFZPJnyiNXi6MZgi0Vbv7BbtO49wm7Re7jW4sZ6
        dotr23kd+Dx2zrrL7rFpVSebR2/zOzaPvi2rGD2O39jO5PF5k1wAWxSXTUpqTmZZapG+XQJX
        xoPpm5gLOrgr/mx5y9zAuIOzi5GTQ0LARGL9yk1MXYxcHEICuxklnn09xQKSEBL4xChx4ow1
        ROIzo8S05x3MMB3vfr1jg0jsYpSYdLebFcJpYZJ4NOEaI0gVm4CWROPXLrAOEYEoiZnbW8GK
        mAWuMkl8ObkFLCEsECKxcckbJhCbRUBVomNDCzuIzSvgKjGr6QsrxDo5iZvnOsHqOQXcJL5N
        Wwc2SEKgkUPi27dvbBBFLhI3e1YwQtjCEq+Ob2GHsKUkXva3Qdn5ElMvPAV6jgPIrpBY3lMH
        EbaXOHBlDliYWUBTYv0ufYiwrMTUU+vATmMW4JPo/f2ECSLOK7FjHoytLPHl7x4WCFtSYt6x
        y1Ane0jMmHiYBRIoMxkltl5bzT6BUW4WwooFjIyrGCVTC4pz01OLTQuM8lLL9YoTc4tL89L1
        kvNzNzGCU4uW1w7Ghw8+6B1iZOJgPMQowcGsJMJrcexLvBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHeHQYP4oUE0hNLUrNTUwtSi2CyTBycUg1MouWO3ZMcRQ4duBrQKnBz38pvClPu2WqbBMfF
        5Aq8fsYtGSpw+smd3PeC9l8f3v/+bYf9bbuNro4Nwk9ediq8Tme4cbD4gUrJTIVljzzO+b5v
        t7knp//IUPH1PQ4+126fPIFX0+tOGc3vlyto52UR5bC5+G7DXkn2oE/Ln7HNWGKmeuCGdoOu
        TOcnjQ0v6sJjlj8RizPfYqafXRMb/CXX4EHWhU22Dg/3nni6xcrSvqZWdn4p/xLBW3MXmX5l
        dtnvtoJ3RZpgycfVS8LdxCRnS62paSnVWpvEoWe9fuGlRVIX9vBdTDugqD6vtzyl41Dk3x1N
        /7PPTOzyeDW/csu2N9Pn86zZuPLl5LC5d0s0lViKMxINtZiLihMB5TcdsJwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvK625vd4g2t/DSx+rJ7AbPFx2kom
        iwtPe9gs7jy/wWhxedccNouz846zWXR+mcVm8WTKI1aLoxuDLRZt/cJu0br3CLtF7+Faixvr
        2S2ubed14PPYOesuu8emVZ1sHr3N79g8+rasYvQ4fmM7k8fnTXIBbFFcNimpOZllqUX6dglc
        GQ+mb2Iu6OCu+LPlLXMD4w7OLkZODgkBE4l3v96xdTFycQgJ7GCUuPvkMSNEQlLi88V1TBC2
        sMTKf8/ZIYqamCQW/TkEVsQmoCXR+LWLGcQWEYiRWP/vJitIEbPAQyaJld8PgxUJCwRJnO2+
        zw5iswioSnRsaAGzeQVcJWY1fWGF2CAncfNcJ9ggTgE3iW/T1gHFOYC2uUo8/BQygZFvASPD
        KkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4PDV0trBuGfVB71DjEwcjIcYJTiYlUR4
        LY59iRfiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBac5H
        /nSPYJW10ZyrNVdaO+4Tni9SyrQx9MqppqU278oq+x+99vhWYcJ5MGzeH+Wj80IcF7xe/DjA
        x0wr8qGmyLmo9MSMVuYdVaLxO2TsSrZrHjr9efv+voAz7u8mcj676Vs2xVZ04oQ7S7driU8p
        MfnJu4HbsFnm/ZTXvHmzJkQtSprAcONI5wndeeEix9LeVV/W/Ppjbb780ZcLIi8yTphyr0fS
        +su/R2tFTzZt+jZj8vbXD1dsZDFq07l1ca7uLpYlwhun+JQ/+fn4Ps+fm2nvrGZznm/yki38
        qXUzf3X01/PbK12f1pdeFfmSGiPx45yPca9Q5Zk+Ie134Zff/711umvzS5aEO+w/t6/L9Puj
        xFKckWioxVxUnAgARFvAg84CAAA=
X-CMS-MailID: 20210107153051epcas5p4f54210f89f8b8d2e18be016521657be0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210107153051epcas5p4f54210f89f8b8d2e18be016521657be0
References: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
        <CGME20210107153051epcas5p4f54210f89f8b8d2e18be016521657be0@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for ZRX-DC compliant PHYs. If PHY is not compliant to ZRX-DC
specification, then after every 100ms link should transition to recovery
state during the low power states which increases power consumption.

Platforms with ZRX-DC compliant PHY can use "phy-zrxdc-compliant" property
in PCIe PHY DT node.

Signed-off-by: Anvesh Salveru <anvesh.salveru@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
---
 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
index d23ff90..73f2fa0 100644
--- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
+++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
@@ -15,6 +15,10 @@ Required properties:
 Required properties for PHY port node:
 - #phy-cells: Defined by generic PHY bindings.  Must be 0.
 
+Optional properties for other PHY features:
+- phy-zrxdc-compliant: This property is needed if phy complies with the
+		       ZRX-DC specification.
+
 Refer to phy/phy-bindings.txt for the generic PHY binding properties.
 
 Example:
-- 
2.7.4

