Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7689585A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfHTH2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 03:28:41 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:17027
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729047AbfHTH2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 03:28:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EttpRLP/oKC8L5LBZbmewVX022KdkwxjpHzYzwKGBeluFVe7RYGPKx+QSWfvVtrh6WpjCzlB88Pv7p8kxDh76By+85IOD3/6fPM6choBMBKVNd2XVJ9RB47eWAn9JGVBJcx8gYrroB/d1rdqLq9LNFPD9nzE+NNzSKyYCkRW1garvC5vcyAqLRZrwokT7YCSLXbZXz4/x68yjfmDrUfIblABB1/fP7VTvBDS6jY3v64QxqNkHH/8rKbgPz5GEcQCzM4HEgsOytQIHLHRtcjpa5W1ZCkFLcUxHfqJ7xNXvZ+aEDhJmS99gu5D7VMN8Zdwu4eUFcZ9KLqFq2xU+lfx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBWVe7f1hdWwNB5lZ1CM4/0WFLgnoVFsRXTUKHkGc1c=;
 b=Yuvqb1Ip73+SAInUknAgHpuMgbV6Qm38/PtvWBdAhlbfFv5g34oQ4pw/grZvFnWo6GfMCSwo1SGIijxUb4glNTrFapsV3wmR/YjwTZvLPgHZ8+93OELJGCfU2g8pT1mkw3h5k2OWe6LSfb/3o1kt/NwYP6V6mlDWOcA8l0atv11ZeuK61c6cufP69ahgyk9tVRLjF8aZ5f1i+kUHU8Ym5Kh7W3VMwBwRyy5xpXue5DhJBB28jXCTeEOBOG1vwYB3xj5UnGXzd8/Sg9YR3auvdAb+kcEpuhQQX8GKo3trzXluwIKLnC4V1/2yOv6Sweg+rLVaPjvR7TCOQbgl2C4uOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBWVe7f1hdWwNB5lZ1CM4/0WFLgnoVFsRXTUKHkGc1c=;
 b=R8kLNZGbzzg6ug4uZvFVdvq1dJ1UjevL0kOitChp78uCx1a0LamuhugVvyO6GOAm5hlqXrYJ5OyIpEF+8eR/ER5RcGBPJ+svsnrQftBpSLuzKb7shid+Glz6Sh/i4OlTJFXtRhvFW4oK2BXUHCA90yzLHHxGV8o1lhMYUwSNKVQ=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5627.eurprd04.prod.outlook.com (20.179.9.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 07:28:37 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 07:28:37 +0000
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
Subject: [PATCHv2 0/4] Layerscape: Remove num-lanes property from PCIe nodes
Thread-Topic: [PATCHv2 0/4] Layerscape: Remove num-lanes property from PCIe
 nodes
Thread-Index: AQHVVyjhmu2LPC3sb0qsw8uoz54tEA==
Date:   Tue, 20 Aug 2019 07:28:37 +0000
Message-ID: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 04e405a3-012b-4fa4-f271-08d7254003f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5627;
x-ms-traffictypediagnostic: DB8PR04MB5627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB562775748020ADB051B4C40584AB0@DB8PR04MB5627.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(2616005)(4326008)(6512007)(1076003)(66446008)(66476007)(476003)(99286004)(66066001)(6436002)(478600001)(71200400001)(81156014)(66946007)(71190400001)(52116002)(66556008)(54906003)(110136005)(81166006)(7736002)(14454004)(305945005)(8676002)(316002)(8936002)(7416002)(25786009)(3846002)(6486002)(486006)(256004)(64756008)(53936002)(86362001)(386003)(186003)(6506007)(6116002)(2906002)(5660300002)(2501003)(102836004)(26005)(2201001)(36756003)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5627;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5hgh0R8tpv+OnQGXVVfVPZqAon/7Xboiu2wOOgql+LdAeS+EgoamdWHAlOYcdGLNRQiE9GazVHGmDAH2V+0jcKUpiltqGfPSSNqylLYqu9kUW9ob+sSTLN9NaZq2v9VFFg1xEo3opj1ti8WYV8hZPejeJ/QweCsI/xhY6fAd9n4RkmS9QpZ+9bETcznbjcadHZx9j88Ia2TuTk/976ZdsGAz+MmDU5StWnTeFc1dlSgKH2+4XLg8OQ9pzZ5+RSDvaV7dc5FAsuGphLBgc3tWkAj3xwIwjBTSiGjYgdHoBZZyc4jioUF43R60AmRs/p8oXpAZSeuo+5e/OBJew/nyhqwblm4bNmU0IyAKQOLEE32eVaeSlOLRyWhkhoZiSKfxYaCetWK+A2SBb13B8U6s7b+q9lel4qh3eJkV5Og+MB8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e405a3-012b-4fa4-f271-08d7254003f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 07:28:37.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USiXkc+N0Z27fyTsoY+DUNCBFjRf3fMTBf38fPyGW4xq+x6msn9EtBRPl7KfCacmW9feQs0KV2osDy0g0Qs2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5627
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

On FSL Layerscape SoCs, the number of lanes assigned to PCIe
controller is not fixed, it is determined by the selected
SerDes protocol. The current num-lanes indicates the max lanes
PCIe controller can support up to, instead of the lanes assigned
to the PCIe controller. This can result in PCIe link training fail
after hot-reset.

Hou Zhiqiang (4):
  dt-bindings: PCI: designware: Remove the num-lanes from Required
    properties
  PCI: dwc: Return directly when num-lanes is not found
  ARM: dts: ls1021a: Remove num-lanes property from PCIe nodes
  arm64: dts: fsl: Remove num-lanes property from PCIe nodes

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 1 -
 arch/arm/boot/dts/ls1021a.dtsi                            | 2 --
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi            | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi            | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi            | 6 ------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi            | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi            | 4 ----
 drivers/pci/controller/dwc/pcie-designware.c              | 6 ++++--
 8 files changed, 4 insertions(+), 22 deletions(-)

--=20
2.17.1

