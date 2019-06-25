Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69ADC527A2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 11:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfFYJJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 05:09:52 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:42477
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730523AbfFYJJw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 05:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVof7mN9+VhXx0zFb1xy4WAzfB7R8gs6tZegthO5fVM=;
 b=rEKOA0R+v5pAa68yUNUQttTrJpORP8Hm2wbT7BTXl37k0XYPqJ/hFy3mzwn7Fftxs8PQK9S7Ey1xATwrY39CX0armgZfZGQ2dq5CvfjJEAQCGIeyEeyU61zxgjLiof6W2pBDgSmgM1DVG0Xf29LlCHHBSs6LPPtMOQMYZx9gW7U=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6746.eurprd04.prod.outlook.com (20.179.251.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 09:09:49 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 09:09:49 +0000
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
Subject: [PATCHv7 7/7] arm64: defconfig: Enable CONFIG_PCIE_LAYERSCAPE_GEN4
Thread-Topic: [PATCHv7 7/7] arm64: defconfig: Enable
 CONFIG_PCIE_LAYERSCAPE_GEN4
Thread-Index: AQHVKzW9ybyfwIfFlkWluzaZ77mKwg==
Date:   Tue, 25 Jun 2019 09:09:49 +0000
Message-ID: <20190625091039.18933-8-Zhiqiang.Hou@nxp.com>
References: <20190625091039.18933-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190625091039.18933-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aabb7b2-51c0-47d1-2a94-08d6f94cdfa1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6746;
x-ms-traffictypediagnostic: DB8PR04MB6746:
x-microsoft-antispam-prvs: <DB8PR04MB6746980214EB24F2C04AD5ED84E30@DB8PR04MB6746.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(4326008)(386003)(446003)(26005)(102836004)(3846002)(478600001)(71190400001)(186003)(11346002)(71200400001)(7416002)(6116002)(25786009)(66946007)(50226002)(110136005)(8936002)(54906003)(81166006)(8676002)(4744005)(305945005)(81156014)(316002)(2201001)(5660300002)(66556008)(7736002)(66476007)(66446008)(64756008)(1076003)(66066001)(486006)(2616005)(2501003)(73956011)(68736007)(6436002)(6486002)(256004)(6512007)(86362001)(6506007)(53936002)(36756003)(14454004)(99286004)(2906002)(52116002)(476003)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6746;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MoGBe0HZc8mGyPD+aU761cEza5bI/kM3sttYwDiFtusPIFFPeIKFIWLNUdODcrs32qyZnKqt3OHHg550GDrDCf8PJluktGLEvgZdHaeYW9CLdEbiGLTekPFwk5QuumDl4MOtIXyr3R5o1wqbmGXTZvHZoQs0SrQCe1MeKcrNsrtbjzS9epOKKR7RuMGglThRd4u59H464dYoAIqR6lB42J7RylDLL4pAmaI8Hd4na3CI7vUdhkDDZZSNGx0/ynxhuMUM+0Ow/LZTniXjq1ZrJp4rqmweCg26d67+Xki2uw7vCGXZdjbqtc6faxcQdEw4mV5biaU4kh/aafeFndS2ElAVEf1hYBx6IelElt/bOYSNouY4E2MR7GDRcLgyP1relas1m8CoY5VjINb1ZWYa/0sYeQQlODggT6vPOtvIM/Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aabb7b2-51c0-47d1-2a94-08d6f94cdfa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 09:09:49.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6746
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KRW5hYmxlIHRoZSBQ
Q0llIEdlbjQgY29udHJvbGxlciBkcml2ZXIgZm9yIExheWVyc2NhcGUgU29Dcy4NCg0KU2lnbmVk
LW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmlld2VkLWJ5
OiBNaW5naHVhbiBMaWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQotLS0NClY3Og0KIC0gTm8g
Y2hhbmdlLg0KDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyB8IDEgKw0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdz
L2RlZmNvbmZpZyBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4IGZiYmMwNjU0
MTVkNC4uOGQ1OGRkZGQ3Zjk5IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNv
bmZpZw0KKysrIGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KQEAgLTE4Nyw2ICsxODcs
NyBAQCBDT05GSUdfUENJX0hPU1RfVEhVTkRFUl9QRU09eQ0KIENPTkZJR19QQ0lfSE9TVF9USFVO
REVSX0VDQU09eQ0KIENPTkZJR19QQ0lFX1JPQ0tDSElQX0hPU1Q9bQ0KIENPTkZJR19QQ0lfTEFZ
RVJTQ0FQRT15DQorQ09ORklHX1BDSUVfTEFZRVJTQ0FQRV9HRU40PXkNCiBDT05GSUdfUENJX0hJ
U0k9eQ0KIENPTkZJR19QQ0lFX1FDT009eQ0KIENPTkZJR19QQ0lFX0FSTUFEQV84Sz15DQotLSAN
CjIuMTcuMQ0KDQo=
