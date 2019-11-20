Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5574C103246
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfKTDq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:46:56 -0500
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:59038
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727775AbfKTDq4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:46:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fymBHp9MNxntN5rq0JXZAlx6t6Azktz6+FZGXiVbVBVBEdHIjQy+EWmYQPRIBiqviReXkblHr8PDdG3AaNWLh8njEjxKKjjAzZU1r++m2khaAij3gzhcQe9MF2U5+1LQKNvyWs6zHpY5299Ze5ToRj6tNhv1+Ipw8mdb75n7A9skCb4FRjIXTfD2wjFc3YmbEHJcQO/caKr94AMgvJ0boyR6PZebGx/JUSqbkg6DJ3EBw2Zquav8m9f7yzijoUUFfQKtLgoLJc0oMwmLJ04/yOo+r7fS8IvMLwr1RnD5NfKgkEkXP+H4rmvtrT4VIfwrRNOUzC6zXxGf9LkfUIQM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0mjx19NgO286EYD9pZuECGeaYfKbACi6tzX5IycmE0=;
 b=gtRyHlEaF3nQNaJPmp81fibAvWA/Klge/Tan+Yi+EK41hofJp4a4EP4acQmszlMwCCKobP7/+Jzak/+ThbEvkz/MNTNV8UvpytoH3hczUg9H++B0a9Wf5Tr0xY/RDUN3uhEIAff9mtXOLtDFDgG6ZdJPuFeL2QOFJCdm/a6QvGP7R43/AOzjY5m20F4MrZjaGlnG8ojSFTD6GI2Vhvzn+uja06MkjTOvZEqSXuH2O4BqW2jRjhvPXk2jhWer7UXjyksgeMhyCgtYMfM+snJzesC8UDtyG5UQ6shv1hMxfURZzB32ClvF+yIJiN/5cyvYJg0HSChD3c9QqiK3eDe+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0mjx19NgO286EYD9pZuECGeaYfKbACi6tzX5IycmE0=;
 b=p0dGVVhJi7ofssdsh4jqbTUb6N5bCCQv0Wm8jIWWSGiGslvLNJAen/gzz72Ry6k8anWpyV5VwY6gVkS9UJog6Sf/QJdCiBA+3e7nsy2CdUfczoUx52zU2AHCvusUIKGhCKLayQdTSoGjklPhBZ4a+vnhPPFd3ycIXzTahn0oj7I=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5657.eurprd04.prod.outlook.com (20.179.9.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 03:46:30 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:46:30 +0000
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
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv9 11/12] arm64: dts: lx2160a: Add PCIe controller DT nodes
Thread-Topic: [PATCHv9 11/12] arm64: dts: lx2160a: Add PCIe controller DT
 nodes
Thread-Index: AQHVn1UYDQkfgGGqqkmEYNH22EQ5Lg==
Date:   Wed, 20 Nov 2019 03:46:30 +0000
Message-ID: <20191120034451.30102-12-Zhiqiang.Hou@nxp.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a795dc53-c36e-4e9c-f577-08d76d6c3a8a
x-ms-traffictypediagnostic: DB8PR04MB5657:|DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5657C6AE0B909A07840650E5844F0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(54906003)(86362001)(36756003)(256004)(7736002)(305945005)(6116002)(66066001)(3846002)(110136005)(316002)(71190400001)(7416002)(1076003)(71200400001)(14444005)(52116002)(2501003)(4326008)(5660300002)(66476007)(476003)(64756008)(66556008)(11346002)(446003)(76176011)(2616005)(66946007)(6512007)(66446008)(8676002)(386003)(6506007)(2906002)(99286004)(102836004)(6486002)(81166006)(81156014)(8936002)(50226002)(186003)(26005)(478600001)(14454004)(486006)(6436002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5657;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KyHdloW+bWNEtTCZJCrGn6pbPrdMlpp3snZYa4vUjlENTeFpo1dDg6G/6/McANKtaEZI4f5kvEXvCB5rwTd5IT/2x+ZxWsxOFNQ0cj96Z18rqb8ZGcN0HBkc141Y6d/PRNuh1OJE5PKa5PlsTWsLVrjkWhyui3kgpqqGNWZgahwQhL1d7JtiA7OyYZQelfhuVqfTCVT7yMK1k487aEbCMFG+6d+f/gwe4FyczliTFCzjv7kRg8NXLTS5x6wMsBOMPpFursOkZH3ErR+pDfB2ztJ7lT0RPdXCdvatbNZf26L275JHlmMpTU/hf0lEia0iHfA+FTPKYD+mEGgmyQsbIO4te9OWJ139n36WikCF1o6L2Rafn4UIk5B9HrxZ/tOS95t6VuW6FWqgifBNT8JIgFEdp5pyBgnAdMKVY3cUMxaMA5FXC6dMN7r6Y9+MWEh1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a795dc53-c36e-4e9c-f577-08d76d6c3a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:46:30.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRD0anonCAHxyKz1riK7YEBQMFIIpIlY641D7sWlqiaShPyxvX/qxGBZLAidhzP2R8Xd1S1GBE0FfwlWKt6Ifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LX2160A integrated 6 PCIe Gen4 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V9:
 - No change

 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index e883fe0fc1b7..ecc5bd90aa5d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1055,5 +1055,168 @@
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

