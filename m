Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17478B641
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfHMLEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 07:04:42 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:17616
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728755AbfHMLEl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 07:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJR6mOwAOhtCFs4LUl2U87CM9FKJd0wYFPckFuACjIDVuf5qVEO6FP1ar5AdqxHKNdCVG54i45t7EYXbblcq9zbCrnKBiAEJN/UbkNAVmiyTsTjdzdCCo64jJlFjve9n8mUZ33WpMVW1Z5Q2OEK80qO04IMCZuWdnhIdIOCSuNwd/GsP96xfIRgkCy65q7Ha7HdKHQh+4X7Rvg13rkPG50KY7skX8s4nw04Mfi43tuLV4WmpcBv0o2iLYZXIxDp3eg8goZMtxl5S2piixzD8tKjydQoCryJh3lUrqMDGrtlzGhc+/Klwxr5niKcNAes0QLDLfQjowo9QOU7ElJI39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtBcMvUIM1r+atFZ0Y/zTOzkeqojgFRp3EwqwXTeWFU=;
 b=j1lFtqJynyiD55T3gbNySMo1z/eSU595Ol1MlsZS+kptmFUtDMsfMr6neoSKL49vKMIMJFT8+qzL9Y+VCsVg2mU853UeeZYRjGaJL1/JzGRysBuOUU/krxHAShobcwDiSKbZrk5Bymvn/ytW8vFbU6GQ6Gy/hRio4cbW10YiWtJuqqQlCiD3H5kAv4oKif0eBiBBTLiI8aozxCMCX3b5AGooMtsCPhUmIBGRaC3NsFQ1nKrNnL3Pg0CiNafIsqdimcvQULEk8Sv6CYVrwjfpNo2FGEdrn34RZkfqachuFAQHtDJP2YZSBkB0AgD4hrznmFvckjB7RPzronsamIRlQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtBcMvUIM1r+atFZ0Y/zTOzkeqojgFRp3EwqwXTeWFU=;
 b=V5Q2lSjrxy0wfroEZyOX9SBt2kAMiD7NCAfHCglL464RVo8t+x0ZmAY5o+TBl6Up5k4PZ/gt+WcCF4HI8b3qBEKawgf7kVS6k1YjDY4msblqr0eQBmA56NeGYJzop8X+WdL5pJmgwwGtbsSImYPNB/BQdGAPXEpVDdqbWCVJ114=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7035.eurprd04.prod.outlook.com (52.135.61.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Tue, 13 Aug 2019 11:04:33 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Tue, 13 Aug 2019
 11:04:33 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv8 6/7] arm64: dts: lx2160a: Add PCIe controller DT nodes
Thread-Topic: [PATCHv8 6/7] arm64: dts: lx2160a: Add PCIe controller DT nodes
Thread-Index: AQHVUcbiclK4Xh0kSE+qaqj34nPcmA==
Date:   Tue, 13 Aug 2019 11:04:33 +0000
Message-ID: <20190813110557.45643-7-Zhiqiang.Hou@nxp.com>
References: <20190813110557.45643-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190813110557.45643-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e93736b-281d-4ea1-1d2a-08d71fde0555
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB7035;
x-ms-traffictypediagnostic: DB8PR04MB7035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB703575995BD43AE0B027D52784D20@DB8PR04MB7035.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(256004)(14444005)(66066001)(50226002)(316002)(4326008)(66556008)(66946007)(1076003)(186003)(64756008)(66476007)(386003)(71190400001)(6486002)(6506007)(26005)(7736002)(71200400001)(110136005)(486006)(305945005)(2501003)(53936002)(54906003)(52116002)(81166006)(6116002)(7416002)(3846002)(25786009)(478600001)(102836004)(36756003)(66446008)(76176011)(5660300002)(14454004)(6512007)(81156014)(446003)(99286004)(11346002)(8936002)(86362001)(2906002)(6436002)(2616005)(2201001)(8676002)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7035;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7+Z+vGhOPDreU2aA4R9NuZ4GrjK2J2Vd4t9jHYQzueeUqEfjq2UDPdhfpzx2dJIJ632j1NDa+yHct4y1rYt6fFjnm49y/i/xd9Hy3QdPVtHFotac7vDQtMBQrEj9mMq/KxEWkiEgSO1lGbhJUFFvyzq+Ckw3XN9Ue6spSsEYX2ut+c+47KjGNk33qxEmIbKPXwgascdgJ4qumkCr3v8wUXmmHynK7opgXUZ/EG27FjvsOrBW25IYAGIK5MNGBrumk0txNXNq09AUL4yxxaymsevINScX24YmW9ZlGouPVmGguNXeAuUz/870xEbifZah12ADcumHHSaHydTTXt1IoAt/OyXqhzkCKqBzoWLHYqrlGHtDhBud1Gz3TC4wRqN29wLV7PqodMyzb8v+odKjwL4EEQRfmXKP6it9kJCk93M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e93736b-281d-4ea1-1d2a-08d71fde0555
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 11:04:33.0898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HKdt+XFOR5gNT9+dgLpmdDmLs/SyOryNxaFpzuGeAM9+3WrvPYwT8EJ/UeUWajQokTMAdNVl27Dhx9tqpH6Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LX2160A integrated 6 PCIe Gen4 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V8:
 - No change.

 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index 4720a8e7304c..1856b0691e0b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -977,5 +977,168 @@
 				};
 			};
 		};
+
+		pcie@3400000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3500000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x88 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3600000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+			       0x90 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <256>;
+			ppio-wins =3D <24>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3700000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03700000 0x0 0x00100000   /* controller registers */
+			       0x98 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3800000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03800000 0x0 0x00100000   /* controller registers */
+			       0xa0 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <256>;
+			ppio-wins =3D <24>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3900000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03900000 0x0 0x00100000   /* controller registers */
+			       0xa8 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
 	};
 };
--=20
2.17.1

