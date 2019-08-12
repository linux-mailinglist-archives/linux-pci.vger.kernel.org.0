Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C548A8960E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 06:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHLEWd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 00:22:33 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:13314
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbfHLEWa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 00:22:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBGfAQxPdqZ+qFu1Ht+3zS8sRoGxL/0JDZsB6hY9FtuTQKshOAyGAZjue4JCe8rTSB0Sa1YbFtZi/C/f3b+tPQ3hIAiHHoym+BWnJsYszf5iavwmAk6dXLwMyoDanmkFZjWhoEuJxst8mPtZgCff9veovNHrPkQzdHAJhY6SzZczid4XUSGb+jQj5kGiWwhEyTmAFZwezOR7sUJVDcS8NJmoBedZYzhXujm3gDYSix8k4vsxup3FOPQHf/1COyMMqLnVcgAbhEOQPdZGk7R74Oey6hicYm734LCEUzXa+WCDjQGZuxmKp0k+fGKROTsavo7ror9XPYOrMibHyVzLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlsvvGeC0t2U8knoO4OapukZYA+UnLsvvJuxHIgblvg=;
 b=dovUMCdT/NjgHXN3wNCux5yaTTpLrffrNKgpFNgK3hRwbEywXedY+wRxiGue8Oavbu+H5Zp91nz+0m/omT9PpJ0Y83xtYH0D+juD4rJwioxz+4NLpMJ1API61WvmC90yJUNQ3M/gjl2vr3X8Sg8hhDFF7QWwobhvoV0O9J++qWG5haQELLO8POclLp3jbEoQOzC1vN4QMVm56HxFWK8QAPKp1Jf/bQnZ/tB7KeKpKCTrtbV+nFrlwKH4494dJrYQNESoSZ3xLqWBCJKYaBxWidR6ElxqVbXdaiAgp6exeNc/TN02JnpYP5TTNIruJ5qvwP0Rp5/Kr+8eQl2UUpPSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlsvvGeC0t2U8knoO4OapukZYA+UnLsvvJuxHIgblvg=;
 b=fSYnsV2a9ddXriAJ1+Z/2FNrlW0RSuWNyR9te+ynm7jhm2AKPsybC0K5XQJWvBqUDGHFnapm8ihBLifyPs699UFipSxHJb4gJB66hJTIr37Ej+cQ4Q+VwwdcshyY4YQE508e+txB8h2v1hJN2la2Uc35XzkByraxlykmt6Tkxs4=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5931.eurprd04.prod.outlook.com (20.179.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Mon, 12 Aug 2019 04:22:28 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Mon, 12 Aug 2019
 04:22:28 +0000
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
Subject: [PATCH 3/4] ARM: dts: ls1021a: Remove num-lanes property from PCIe
 nodes
Thread-Topic: [PATCH 3/4] ARM: dts: ls1021a: Remove num-lanes property from
 PCIe nodes
Thread-Index: AQHVUMWMZFwmX+djskari+UjmO8phQ==
Date:   Mon, 12 Aug 2019 04:22:27 +0000
Message-ID: <20190812042435.25102-4-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: f6120ed1-5f45-4a36-acf5-08d71edcaf3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5931;
x-ms-traffictypediagnostic: DB8PR04MB5931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB59310832980D706C849B8CE784D30@DB8PR04MB5931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(6436002)(256004)(25786009)(66476007)(66556008)(66946007)(50226002)(2616005)(476003)(64756008)(186003)(11346002)(446003)(486006)(6486002)(66066001)(66446008)(53936002)(7416002)(71190400001)(6512007)(71200400001)(2501003)(8936002)(4326008)(8676002)(6116002)(3846002)(76176011)(52116002)(110136005)(54906003)(305945005)(7736002)(1076003)(81166006)(81156014)(86362001)(5660300002)(14454004)(26005)(478600001)(36756003)(2201001)(2906002)(386003)(6506007)(102836004)(99286004)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5931;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 84ZGIlDtgggiLlHjtCbZHUAcTdm/ALZLYTPfb+U6z2gMUycQMOzFv6C41Y/iQW5BImRlfWuE3Q1OxXLN7z5fWi4Lgt8hFrCoxh8jiSSoZSe4MntPyp159Ab1hkRl01IY5XcQDovbszG7jChfZKpHQal3M3/lRAumYwG1kAHQbRDZnxXOSW9NAWNTKsE88Xm+Cx8BliCMnJjW0GkmIbMAy9YcfJr3GqJK8tdjqP8OuFTXqV+Tiegn1y1mm8HEcMAmU1UbeKI2nij85PCU9CWM7U+28A3dAgnS4gwQ1UBfX2IMELg43NJVnLVhm0E3MLwdf9QU+dvB1QuoOHEpJW84t+UwQNFOG3ww+Kl7kqOXzHzgWGn67dXnoaIEyszBUyzAasUpQFJWSwolt/6hWq6CUpAJW1tJZaLa/XbCtKl1Lsg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6120ed1-5f45-4a36-acf5-08d71edcaf3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 04:22:27.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YE+GaB51KNIVKKIiE7FMwazgRHCCWxWnBG6AYdBBRQb9/4dcYcDnCQL7r0DKNdeVMqYuVTLjnQ5e2bRpo6dCA==
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
 arch/arm/boot/dts/ls1021a.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dts=
i
index 464df4290ffc..2f6977ada447 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -874,7 +874,6 @@
 			#address-cells =3D <3>;
 			#size-cells =3D <2>;
 			device_type =3D "pci";
-			num-lanes =3D <4>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   =
/* downstream I/O */
@@ -899,7 +898,6 @@
 			#address-cells =3D <3>;
 			#size-cells =3D <2>;
 			device_type =3D "pci";
-			num-lanes =3D <4>;
 			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   =
/* downstream I/O */
--=20
2.17.1

