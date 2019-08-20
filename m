Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94F895868
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 09:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfHTH3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 03:29:10 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:9604
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729370AbfHTH3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 03:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZMGgW2TJf9w8CvWWjOn0dJFKTgfhsmN+WQ5AmPfVpIamqVDyZG8T7w2hL2r/cH21rtcsjhi3sB4V2Aq/eBuK3HxKoKlr8PcSFnbNbLhvH11bvqZ9s9UBe+GF6sHgVj09VMCaIB0V9nR6PDUln+e6S/WtK4DxGPKMKJCQKc1uyeKt0bhy2H10GSqYVNlYBc3SRkpiXyLHp+mfnSjDEIriKMB923BCyVKd8GWMeWZac1IfD7x52LZuEG6CN27Paxlair4ybIMosfpEoj6v2MxPijVEHCUt36MJrRmHXiCpylNU19+JwCUqHGYCt5Se/tcjUhq69uZ6K+cL9qjjDKOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itONfAUrGuB7eUoK8cPM+8Znp6POpWJtYeGelEbDSP8=;
 b=fmqDdqoNMDiqNL5y4Z2hX0pZE7C674GmpzglyJGVhazv1pmQmIPP8Sv11zY3DWc8xJ8bU2ex+eYpw2MvSGllcqYSLemasdv6Nitz2NJ6lAZOFmm78OXHNZFUB8B80aenK5I4AXpNfx7UyWG8uSBr4wnWOswm18tRWbPXW4e6+s+8ygE+qh5S2B3hCeANROcMj0OnfM1dBlZyRGar0myCbxdD7ysOf4UB/L4etIE5Yx802x+E8OHqK4GMg/fOXjqXonlzpREzA3lemn0JP7zYi0YOOkftJ5ggI70zpM448D4wp8pe/1oPK6musAFHABXOTDzkvFSD2gxy9E4ZtngCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itONfAUrGuB7eUoK8cPM+8Znp6POpWJtYeGelEbDSP8=;
 b=ZY0nVW9YjNrbpNQUi9vJ6QHAepctv3Ce3BzDPrlS94ltJnEqFG+HXOFk/VaPiP2kSuG/X/iY0s60NTEZuJqEVXgqT3zizRi6SKuh/onTd+w60dBa9R/MSV01wIUXkrMJCSHkFW4HjttYVzu4J+1/BMOcbLTMZ7rrzHuQsrPNUhc=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5627.eurprd04.prod.outlook.com (20.179.9.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 07:29:01 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 07:29:01 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 4/4] arm64: dts: fsl: Remove num-lanes property from PCIe
 nodes
Thread-Topic: [PATCHv2 4/4] arm64: dts: fsl: Remove num-lanes property from
 PCIe nodes
Thread-Index: AQHVVyjwu5SFuscGyUqNOLDq4djSqA==
Date:   Tue, 20 Aug 2019 07:29:01 +0000
Message-ID: <20190820073022.24217-5-Zhiqiang.Hou@nxp.com>
References: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c90fea8b-44b6-4ae3-1f55-08d725401268
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5627;
x-ms-traffictypediagnostic: DB8PR04MB5627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5627498D6D1078DF5C3F986084AB0@DB8PR04MB5627.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(54534003)(2616005)(4326008)(6512007)(1076003)(66446008)(66476007)(476003)(76176011)(99286004)(66066001)(6436002)(478600001)(71200400001)(81156014)(66946007)(71190400001)(52116002)(66556008)(54906003)(110136005)(81166006)(7736002)(14454004)(305945005)(8676002)(316002)(8936002)(7416002)(25786009)(3846002)(6486002)(14444005)(486006)(256004)(64756008)(53936002)(86362001)(386003)(186003)(6506007)(6116002)(2906002)(5660300002)(446003)(2501003)(102836004)(26005)(2201001)(36756003)(11346002)(50226002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5627;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7MAo5o3+oVGnbSMn/abC0N8jppA2S9Ipk7kIispRM5/BE1+bIgtQIAtU2C+RYmanuIGvNIzFUVovEHFWn3TsT6IVbSN9Ek96hA5VByE+7j36pGukyXUzxlKk46NQLUWxO4OPrMoApi4LF+c0gfze9miHbg1kRRHPXhqA+xdJVdQ+eeDYbh8uhi7QHs/wtCtqdjqg/LZXERfxgZfsHXXZnv+XfetzIGwD1331m3UM+7msigOcuhxqmfZxZahAv1SfXrAGztthPhPMbEEbt4+HNgDevkFig1s6A84+7Pvya3r/Pn33QD3WD/8s7AoPxfE34xk/8z4czmr5mxGPe+jg6NnnQXu118yBAnyOM2FE71N3bNuHUEcHn5wd+eE+7QivAemK/SK6QTnwg+jJbu8/2VkmbXX8Vapff7zvLzH8J6Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90fea8b-44b6-4ae3-1f55-08d725401268
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 07:29:01.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TWmpL61g4vsy3P0QLR5dzTsj4eJXig7hFsaIuNlNz4mqfaPQRMuM5nPuYCTlDcf1rG7TRTDeJ4oA0mBQ8vidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5627
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Remove the num-lanes to avoid the driver setting the link width.

On FSL Layerscape SoCs, the number of lanes assigned to PCIe
controller is not fixed, it is determined by the selected SerDes
protocol in the RCW (Reset Configuration Word), and the PCIe link
training is completed automatically base on the selected SerDes
protocol, and the link width set-up is updated by hardware after
power on reset. So the num-lanes is not needed for Layerscape PCIe.

The current num-lanes was added erroneously, which actually indicates
the max lanes PCIe controller can support up to, instead of the lanes
assigned to the PCIe controller. And the link width set by SerDes
protocol will be overridden by the num-lanes, hence the subsequent
re-taining will fail when the assigned lanes does not equal to
num-lanes.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V2:
 - Reworded the change log.

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ----
 5 files changed, 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1012a.dtsi
index ec6257a5b251..119c597ca867 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -486,7 +486,6 @@
 			#address-cells =3D <3>;
 			#size-cells =3D <2>;
 			device_type =3D "pci";
-			num-lanes =3D <4>;
 			num-viewport =3D <2>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   =
/* downstream I/O */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1043a.dtsi
index 71d9ed9ff985..c084c7a4b6a6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -677,7 +677,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <4>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   =
/* downstream I/O */
@@ -704,7 +703,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <2>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   =
/* downstream I/O */
@@ -731,7 +729,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <2>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   =
/* downstream I/O */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1046a.dtsi
index b0ef08b090dd..d4c1da3d4bde 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -649,7 +649,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <4>;
 			num-viewport =3D <8>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   =
/* downstream I/O */
@@ -671,7 +670,6 @@
 			reg-names =3D "regs", "addr_space";
 			num-ib-windows =3D <6>;
 			num-ob-windows =3D <8>;
-			num-lanes =3D <2>;
 			status =3D "disabled";
 		};
=20
@@ -687,7 +685,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <2>;
 			num-viewport =3D <8>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   =
/* downstream I/O */
@@ -709,7 +706,6 @@
 			reg-names =3D "regs", "addr_space";
 			num-ib-windows =3D <6>;
 			num-ob-windows =3D <8>;
-			num-lanes =3D <2>;
 			status =3D "disabled";
 		};
=20
@@ -725,7 +721,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <2>;
 			num-viewport =3D <8>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   =
/* downstream I/O */
@@ -747,7 +742,6 @@
 			reg-names =3D "regs", "addr_space";
 			num-ib-windows =3D <6>;
 			num-ob-windows =3D <8>;
-			num-lanes =3D <2>;
 			status =3D "disabled";
 		};
=20
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1088a.dtsi
index dfbead405783..76c87afeba1e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -456,7 +456,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <4>;
 			num-viewport =3D <256>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   =
/* downstream I/O */
@@ -482,7 +481,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <4>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x28 0x00010000 0x0 0x00010000   =
/* downstream I/O */
@@ -508,7 +506,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <8>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x30 0x00010000 0x0 0x00010000   =
/* downstream I/O */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls208xa.dtsi
index 64101c9962ce..7a0be8eaa84a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -639,7 +639,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <4>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			msi-parent =3D <&its>;
@@ -661,7 +660,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <4>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			msi-parent =3D <&its>;
@@ -683,7 +681,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <8>;
 			num-viewport =3D <256>;
 			bus-range =3D <0x0 0xff>;
 			msi-parent =3D <&its>;
@@ -705,7 +702,6 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			dma-coherent;
-			num-lanes =3D <4>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			msi-parent =3D <&its>;
--=20
2.17.1

