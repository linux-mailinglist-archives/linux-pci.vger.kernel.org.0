Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35C52ED40C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbhAGQL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 11:11:27 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:18897 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbhAGQL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 11:11:27 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210107161044epoutp02fb92e90296c7ecd40451039799f141ce~X-xHtxTsu0998709987epoutp02-
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 16:10:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210107161044epoutp02fb92e90296c7ecd40451039799f141ce~X-xHtxTsu0998709987epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610035844;
        bh=/IBdByyl5N7ynEc7XKNOt7QVin5U01igQAur9/h1UNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7SuqvMY3h4tXVi7LAx3SCH8XqEdv/IdnaWG3/TW1O8soDp7AnUZ4ETC5cqoou+Jg
         tjqXmIR/HGsaKbux+d+lISGZC9fRCbLh3xgu1W4YgrK0++L5kLvWxJL+mT4h03FF1/
         Rb3v/TnP5MZn6LaIkHu3zJwitFSq5WGmgmA16Dcw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210107161043epcas5p1db0c9dbf30e2d604540f1d113af5a6e3~X-xG7i6ev1468214682epcas5p1o;
        Thu,  7 Jan 2021 16:10:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.BE.15682.38237FF5; Fri,  8 Jan 2021 01:10:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210107153116epcas5p3510286e503e690537d5b2eb7486fa7ab~X-Oqa3N5E2366523665epcas5p3J;
        Thu,  7 Jan 2021 15:31:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210107153116epsmtrp2941a89ea87bef08e3eddc4f3b2627efb~X-OqaCrDD0458504585epsmtrp2D;
        Thu,  7 Jan 2021 15:31:16 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-96-5ff732836832
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.04.13470.44927FF5; Fri,  8 Jan 2021 00:31:16 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210107153114epsmtip225d77c13628f28c9d28f6a71d0fbe820~X-OojB6b02044620446epsmtip2e;
        Thu,  7 Jan 2021 15:31:14 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Shradha Todi <shradha.t@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v7 5/5] arm64: tegra: Add support for ZRX DC PHY property
Date:   Thu,  7 Jan 2021 20:58:43 +0530
Message-Id: <1610033323-10560-6-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZdlhTU7fZ6Hu8wf/9ohYfp61ksmiZtYjF
        4s7zG4wWl3fNYbM4O+84m0Xnl1lsFk+mPGK1OLox2GLR1i/sFq17j7Bb9B6utbixnt3i5655
        LBbXtvM68HnsnHWX3WPTqk42j97md2wefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAldH8bAZT
        wWeZivsX/7E0ME4W7WLk5JAQMJHYufIAYxcjF4eQwG5GiRmdE9ghnE+MErvPbWaFcL4xSsxe
        +hbI4QBrebPbECK+l1Gi891dFginhUniz/cbzCBz2QS0JBq/doHZIgJREjO3t4JNYha4yiSx
        e9Y2dpCEsICnxOup18CmsgioSiz/6wwS5hVwlXje28sOcZ+cxM1znWBzOAXcJL5NWwc2R0Lg
        J7vE2lu32SCKXCR6JuxkhrCFJV4d3wLVLCXx+d1eqJp8iakXnrJAfFAhsbynDiJsL3Hgyhyw
        MLOApsT6XfoQYVmJqafWMYHYzAJ8Er2/nzBBxHkldsyDsZUlvvzdwwJhS0rMO3aZFcL2kLj+
        fw8zJExmMkrM2raGfQKj3CyEFQsYGVcxSqYWFOempxabFhjmpZbrFSfmFpfmpesl5+duYgSn
        Ey3PHYx3H3zQO8TIxMF4iFGCg1lJhNfi2Jd4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rw7DB7E
        CwmkJ5akZqemFqQWwWSZODilGpg4vdiVHCfKGL2W17IufvKt+Vvr4aYTu++xvK91exwqtiV5
        cvLV28VNT3W+Cuio2t0sCTH7pr5pY3hIb0mdvluJWP5W3qmsdi/8nRtWNgptNa5/trRc6GyE
        9e75Oye1T9IN/iy1S231Tg6zXQ0pf/98nPavOrsxL1EiU81Jp7vnpLiuu2Bm6K4TdXMz3wjP
        v7vlpMv1XRwNm9csl/3MdGxB0K+Fj5K4LrNldtWf0LTt3cwR+TpyRfvWMus383fNtl5u4Cpr
        dHfq1Wj/mK/C5YW8AW+rhDPnJZdPVbs6IfYsY2f+3/Lwrc/npLk/c3qRZrJtcXNv1jY3z9J6
        52BJnmDxYom/E3pDGSTua33drcRSnJFoqMVcVJwIAEVehaeWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvK6L5vd4g019whYfp61ksmiZtYjF
        4s7zG4wWl3fNYbM4O+84m0Xnl1lsFk+mPGK1OLox2GLR1i/sFq17j7Bb9B6utbixnt3i5655
        LBbXtvM68HnsnHWX3WPTqk42j97md2wefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAldH8bAZT
        wWeZivsX/7E0ME4W7WLk4JAQMJF4s9uwi5GLQ0hgN6PEymuL2boYOYHikhKfL65jgrCFJVb+
        e84OUdTEJLH77mlWkASbgJZE49cuZhBbRCBGYv2/m2BxZoGHTBKLN2qA2MICnhKvp15jBVnG
        IqAqsfyvM0iYV8BV4nlvLzvEfDmJm+c6wcZwCrhJfJu2DqxcCKjm4aeQCYx8CxgZVjFKphYU
        56bnFhsWGOallusVJ+YWl+al6yXn525iBIerluYOxu2rPugdYmTiYDzEKMHBrCTCa3HsS7wQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTGa3YuZ/K66+
        HrI9/dZLTkObJsGVxpuE+VbmVkX/becUuHI9QsndvzG/RWfZJK9PfTtyIrYpbjo4b0GK77lo
        1SAmLvZpEqG9DJ+UJC7ZnJK3nlHj+3tK7s2iid37/XnsXzmx/9XYdf/vxU0tla+59be8nOJx
        i73JatK8VSy2W6f9Ug9J+beBKyV9fcbujk+S6zhuT/PryV90/Z2akJHulNVym/5vEbhivete
        6sO9szlP3fTz2fdq7Z8n/26df9v26tpNsyiW7H3LatbnOalafSo//fUb6185h2N7N+ZJPtC4
        uWLiOruObz8adt2S8HoSxpRiPn/O/6zLXeZHr0WyXtuY3P3h+Y1KnXYN042KnsFKLMUZiYZa
        zEXFiQBjRz7exgIAAA==
X-CMS-MailID: 20210107153116epcas5p3510286e503e690537d5b2eb7486fa7ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210107153116epcas5p3510286e503e690537d5b2eb7486fa7ab
References: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
        <CGME20210107153116epcas5p3510286e503e690537d5b2eb7486fa7ab@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare controller driver provides the support to handle the PHYs which
are compliant to ZRX-DC specification based on "phy-zrxdc-compliant" DT
property. So, add "phy-zrxdc-compliant" property in tegra PCIe PHY DT
nodes.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
To: devicetree@vger.kernel.org
To: linux-tegra@vger.kernel.org
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 25f36d6..9d91006 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1006,6 +1006,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_1: phy@3e20000 {
@@ -1014,6 +1015,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_2: phy@3e30000 {
@@ -1022,6 +1024,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_3: phy@3e40000 {
@@ -1030,6 +1033,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_4: phy@3e50000 {
@@ -1038,6 +1042,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_5: phy@3e60000 {
@@ -1046,6 +1051,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_6: phy@3e70000 {
@@ -1054,6 +1060,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_7: phy@3e80000 {
@@ -1062,6 +1069,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_8: phy@3e90000 {
@@ -1070,6 +1078,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_9: phy@3ea0000 {
@@ -1078,6 +1087,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_nvhs_0: phy@3eb0000 {
@@ -1086,6 +1096,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_nvhs_1: phy@3ec0000 {
@@ -1094,6 +1105,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_nvhs_2: phy@3ed0000 {
@@ -1102,6 +1114,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_nvhs_3: phy@3ee0000 {
@@ -1110,6 +1123,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_nvhs_4: phy@3ef0000 {
@@ -1118,6 +1132,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_nvhs_5: phy@3f00000 {
@@ -1126,6 +1141,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_nvhs_6: phy@3f10000 {
@@ -1134,6 +1150,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_nvhs_7: phy@3f20000 {
@@ -1142,6 +1159,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_10: phy@3f30000 {
@@ -1150,6 +1168,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		p2u_hsio_11: phy@3f40000 {
@@ -1158,6 +1177,7 @@
 			reg-names = "ctl";
 
 			#phy-cells = <0>;
+			phy-zrxdc-compliant;
 		};
 
 		hsp_aon: hsp@c150000 {
-- 
2.7.4

