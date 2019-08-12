Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7B89613
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 06:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfHLEWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 00:22:38 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:15436
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfHLEWh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 00:22:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoDAdPlfeA7j6Z10FBc3rUZntnY5d9CH7DKmY8w0e6n3wxJy8SOxVUO4VXocrkBcpZEUsCcDydeW744XeH4QlbH0YnaBiRwSIW3QV/Ak+XnBj6+CmZJJc0owEPvHi/xQc8kbA4WoGPLmcBYYNqvXnK4V3o/uOQTB5mxNGOX6YJwkT8n/KJ8RM6gfoElBrta4B83NWoKwEFU+81m5ZsJqoS2P1Y05uKFhJBFlsiMBM0FHtjFc9K0PJOhR0ujJsQNFnPFl7YmZRTvfT5ted5MiMfJKZ71ZYPWSL/CIvS52E++rrkWoh1X5ZALjGz94lZc0m+suEppG9W6+WuiEU7yMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIXsOqPz424V2pYO6OHn9ImT4VL1Xd2sF5UJOiAHijk=;
 b=e12yV56G8susTfM4JbABxi+REVGzQCUL1OxmhHRCar+hO9hKqfLj3vsLREP+pV08TubHtCYfyNPwBfzs0QV+U1DotHI6UKVSfoXy2vgWUXvB+p5fuegXBuSZnOy1rCZ2B6f9H7nSfqJhE3O133PR/mN7eFdhlz/rzXkqx6QF1AwEsaJNjBXfrrALRhpEGEnrq8DGIghgAInMJs00KVkUua3OjvhOhKmD7to/pnvQrsmkej6UC3HiiyBj/1YWMsxg4WyR6se2wBC8NeoZEEtFYnvIqrhRdNZA4WvKrkBArNKlVw2U9RF/utqhUJy0IAb2LCKbgFG85/GllAcEzh36CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIXsOqPz424V2pYO6OHn9ImT4VL1Xd2sF5UJOiAHijk=;
 b=S91QHO6Xd+SGnoFxD0KrhLCGaSyYTT7izNLugrTeuXjZKP5vobypanvmOUO2WYiEblqQQMwtIE01hY2/c09vEjLo5QNjEA46rUMdZYj50f4LRLQH7K3+nw3na9DZ2u/nPHIWVyAnKLK0ACrMU6CAaaZp8TNSToK1vrrmPQa/lCc=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5931.eurprd04.prod.outlook.com (20.179.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Mon, 12 Aug 2019 04:22:33 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Mon, 12 Aug 2019
 04:22:33 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 4/4] arm64: dts: fsl: Remove num-lanes property from PCIe
 nodes
Thread-Topic: [PATCH 4/4] arm64: dts: fsl: Remove num-lanes property from PCIe
 nodes
Thread-Index: AQHVUMWQPzBEI52VGku2HzYmow0ewA==
Date:   Mon, 12 Aug 2019 04:22:33 +0000
Message-ID: <20190812042435.25102-5-Zhiqiang.Hou@nxp.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:203:52::24) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96a2a906-eea2-41ab-5ade-08d71edcb263
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5931;
x-ms-traffictypediagnostic: DB8PR04MB5931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5931B53A3D934AE75852C00B84D30@DB8PR04MB5931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(6436002)(256004)(25786009)(14444005)(66476007)(66556008)(66946007)(50226002)(2616005)(476003)(64756008)(186003)(11346002)(446003)(486006)(6486002)(66066001)(66446008)(53936002)(7416002)(71190400001)(6512007)(71200400001)(2501003)(8936002)(4326008)(8676002)(6116002)(3846002)(76176011)(52116002)(110136005)(54906003)(305945005)(7736002)(1076003)(81166006)(81156014)(86362001)(5660300002)(14454004)(26005)(478600001)(36756003)(2201001)(2906002)(386003)(6506007)(102836004)(99286004)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5931;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1WhzR79aG9J+pFa5WE592cE4qaJ4a26AZ9oVYAgfuAPRmWLyWwGHJcwMDKDliqe/ld2h104in5zyBAvKe2iitJ9HZisZzjkVK7O38nY/A+g2YzAd3NQZvq15oa9gDeFXk19N4LpV+T0KjViUvFOr+SoJSQXAb/Zl/DNK3GLE9/PXtduHWc6KNHhFwCV8IcTAAnRLSxwGetDlzRKxGQH9vZvQ9hGsNcNdWBAaGAa0x0umMxlbsrdVJzmaC5cEQRNwRoGtNtYA2bJPgTqXZtk7K9rsfDoVK6fXHqL/uIWBDUNWexXfcSfjSepF3WvfWEPEiH2K6nUFm2lH6DN5JiGQxH7OrK5W/4/DBjiCqFPE5tnDRCpQp7prD9+P2jip5I1NOcjXqc/xqXG9sVosTF8J3d2jureyGOdCHw0+SemFyVU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a2a906-eea2-41ab-5ade-08d71edcb263
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 04:22:33.3806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxxaul0mRZtXK+zkVuUgt6cMd0Gm3JeogzPBqPuyXuW2weNevw/5iOQEkyNmt39Idmlm6loXxne3sut/CWDiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5931
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

On FSL Layerscape SoCs, the number of lanes assigned to PCIe
controller is not fixed, it is determined by the selected
SerDes protocol in the RCW (Reset Configuration Word), and
the PCIe link training is completed automatically base on
the selected SerDes protocol, and the link width set-up is
updated by hardware. So the num-lanes is not needed to
specify the link width.

The current num-lanes indicates the max lanes PCIe controller
can support up to, instead of the lanes assigned to the PCIe
controller. This can result in PCIe link training fail after
hot-reset. So remove the num-lanes to avoid set-up to incorrect
link width.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
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

