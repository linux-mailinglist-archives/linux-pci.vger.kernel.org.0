Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36BEA95863
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 09:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfHTH27 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 03:28:59 -0400
Received: from mail-eopbgr50040.outbound.protection.outlook.com ([40.107.5.40]:43843
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729370AbfHTH27 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 03:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePAi7OyXEUY6Hp/jzEVIdPFEFTruFyViFBRvp8DdkA/wA3PpJigFK13l8CU8Ep6mYVpjG9g0tGyOr+HVWpIWgWyxpPn4jhxLopoHk5zFCy5KvzPxNAuDFBLFQd8YRiU9bPyKt8u0ZzVuwr+enr3etzFI3vmMaBnwkeowLxB+WHrOXGhtgkKB7Y9bm+5tPg20zyvNVdDmA/DBCMz4g/M2ivOgLzdoWnh2uwcyTlaxQenFJEGgBy/ZOJ3U5NubpUk2P8ER9hoPJGK24BVIfPdiTwDuMGak6E1ODZa8gvWDUYKpuIbnLylzCcgRbmoX5k0y4AYi3TbFOqyuFbA3eeKTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMTQ1bL7iTonEYzHTx0G5mW/k6ZqwOW6nis5+Qpxzuw=;
 b=aYDWmE8S0m+Dy0fsN6+K12YcLOoyz0Bjn4NCtk7RwIe69rhXW6kF1lVSgoKTdB/OAuaFEcvCl+m474KwKQjFvrAQYQL3QY3M5lnUWXuNhH6dPpCpiOdT2tX2a2PJTychICM4L4Pv6LUtLdGhnmX3xFiVESYTJCZJoSUR0TMNLe5/SKxv/Xc4IAnVSBzsUwmGA4IKGoSP90Sr5TcxB5ClCegYQpe7A/L2qk5RyF/xmhjVGA5YS0Z18Y5k2vrVCPNbU4SP36Xw7vH2D9CnTlF1X/dQsARl/JA9+CGEW+0690oLbFfaBrUJPUt5SYB3ypwyQrZjjInK0wJgKqdAprlpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMTQ1bL7iTonEYzHTx0G5mW/k6ZqwOW6nis5+Qpxzuw=;
 b=VSH8jpMcwh7Mwj8foibvQSpytVui/SaABabUqfkV3pV5RufTD+kHnMHOjQM+otkPKOjdU1lZF43BSemmpKRp/Lojj/mf8xAgNVjAgFsIcU+0S6t3VwkZygLEzjWlcfR7wPtV7fFAJ3t6PtL304BNGXjWryZ7/BJSh8bzXHnLCu4=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5627.eurprd04.prod.outlook.com (20.179.9.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 07:28:55 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 07:28:55 +0000
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
Subject: [PATCHv2 3/4] ARM: dts: ls1021a: Remove num-lanes property from PCIe
 nodes
Thread-Topic: [PATCHv2 3/4] ARM: dts: ls1021a: Remove num-lanes property from
 PCIe nodes
Thread-Index: AQHVVyjsUiZYcs6/dkaNMcnf6FMNwg==
Date:   Tue, 20 Aug 2019 07:28:55 +0000
Message-ID: <20190820073022.24217-4-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: da113cee-ba47-4834-48ca-08d725400ed3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5627;
x-ms-traffictypediagnostic: DB8PR04MB5627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB56277328651C74557B80125E84AB0@DB8PR04MB5627.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(54534003)(2616005)(4326008)(6512007)(1076003)(66446008)(66476007)(476003)(76176011)(99286004)(66066001)(6436002)(478600001)(71200400001)(81156014)(66946007)(71190400001)(52116002)(66556008)(54906003)(110136005)(81166006)(7736002)(14454004)(305945005)(8676002)(316002)(8936002)(7416002)(25786009)(3846002)(6486002)(486006)(256004)(64756008)(53936002)(86362001)(386003)(186003)(6506007)(6116002)(2906002)(5660300002)(446003)(2501003)(102836004)(26005)(2201001)(36756003)(11346002)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5627;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MXSwWuxYL9Vp0YR+XP0k6Uur/AyAUnHpriLlZEKQ4B3vlljhu75v0kCoUN61w7OslyuF6PM000OVxhd+Q0C1nE91bBUfKZdw+9TlVaASL7oCk4P7+R2I9u/9dZaxbNZ5wwAbN5StKD6BgR+CSrZe93Ewchx7ykD3CQcbM9il+xMUz0J6fnm8EYoyTemP/aVJsuNXwfSlbsloHfaWSqfssOvOP+51Qe6JE0MTRJ/h+IHyucC6clkBiXkxnTrbO/okimMCIsOsgyUGMmQhNhPwG3r4rh51AgyOdVoNIVhfqPR/j6k9wVRpr8+OqxZelxIynt1NlHz5Ob345aSYB3jw14Rkv7QuNSDvlsqdeX7i7WCDNs05LhqX85QTfK+ERc2Gr0AY/5/jGZWSPq6UenRmLmsUfdNJf73lZOsawFhPzH0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da113cee-ba47-4834-48ca-08d725400ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 07:28:55.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1e0TSz5RyGHYB+KkOJi2ATbrp1L+b37eSao7pGRaDQ49zHpY5Ltuj93o16jezt4bA0XpOPHTkD6cwhh0yguXw==
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

