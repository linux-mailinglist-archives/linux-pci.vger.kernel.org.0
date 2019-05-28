Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98B2BFAC
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 08:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfE1Gun (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 02:50:43 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:37024
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727240AbfE1Gum (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 May 2019 02:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS5icHrVv/qGYgpDLm4H+9mtPX0kSqaAKfEM+M5Ym0c=;
 b=qjkM5jMxCoB1PO07w/gkZV/rYqbPgtwp+TmsFiOHy9Nh2clIOxfAZTTnIUhnYQIBneX1VUeyEDtjADW3Ysqi5/kyM7jwu15/S8em+RBvH86bKDcaNssu7Of76AH4R5L/MsZNauPQ6wcXyMKo2AUKRl2fsDvwYjVxQAR1iV6nq/Q=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5495.eurprd04.prod.outlook.com (20.178.93.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 06:50:39 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 06:50:39 +0000
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
Subject: [PATCHv6 6/6] arm64: defconfig: Enable CONFIG_PCIE_LAYERSCAPE_GEN4
Thread-Topic: [PATCHv6 6/6] arm64: defconfig: Enable
 CONFIG_PCIE_LAYERSCAPE_GEN4
Thread-Index: AQHVFSGp2QR6dzWWkESm0e713eBNIw==
Date:   Tue, 28 May 2019 06:50:39 +0000
Message-ID: <20190528065129.8769-7-Zhiqiang.Hou@nxp.com>
References: <20190528065129.8769-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190528065129.8769-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e829d709-5a04-4b82-0206-08d6e338cb78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB5495;
x-ms-traffictypediagnostic: AM6PR04MB5495:
x-microsoft-antispam-prvs: <AM6PR04MB549532C638A2BF77B395A454841E0@AM6PR04MB5495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(2501003)(6486002)(86362001)(6116002)(6436002)(66066001)(6512007)(2201001)(386003)(2906002)(53936002)(25786009)(3846002)(7416002)(4326008)(71200400001)(71190400001)(66476007)(54906003)(11346002)(81156014)(73956011)(64756008)(66556008)(50226002)(8676002)(316002)(5660300002)(81166006)(8936002)(110136005)(305945005)(76176011)(102836004)(52116002)(186003)(26005)(36756003)(68736007)(6506007)(7736002)(256004)(446003)(478600001)(486006)(1076003)(99286004)(66946007)(4744005)(66446008)(2616005)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5495;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XYWZvjG8dHgiNqZXqyzB4S+TVSC3jAHBRixq4Dgd1wyofo2aXwZUZzEK5BriKyVYAAfW9YwwtAukMdvStnfhm/VbYTb8XJwV1DGhgiTZieBnGD9Z2hJQWF4qssFiTo8ESC/dTZMXj4+YT/fX5L4H035ANxbYaPJt0UPtFLJFO3WkaJ15+iIJc5ekSpjBF25EM26j02M5BtxEeN6EVhbFmw8Oq1BfOcV98RxwwmriVo/pNiCQkRoCp5rw82x1wYUnKEk6ZDiXEqD0auqeOjDBnL24x6zaIutaTLLN9ZnGSavZuFb6BRXHCRngNI/BqmRdpDJcHMo8mnA4XSG6y10qmNcNoHKbQWc+c0VD+dvOSd1c7NQkFN/qOGUpbj4hncbXWpJy+aDuE3zAVj+saQq3F3+EF7CLW3NLR6FAnWAAFzU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e829d709-5a04-4b82-0206-08d6e338cb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 06:50:39.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5495
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KRW5hYmxlIHRoZSBQ
Q0llIEdlbjQgY29udHJvbGxlciBkcml2ZXIgZm9yIExheWVyc2NhcGUgU29Dcy4NCg0KU2lnbmVk
LW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmlld2VkLWJ5
OiBNaW5naHVhbiBMaWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQotLS0NClY2Og0KIC0gQ2hh
bmdlIHRoZSBtYWNybyBuYW1lIHRvIENPTkZJR19QQ0lFX0xBWUVSU0NBUEVfR0VONC4NCg0KIGFy
Y2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgYi9h
cmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQppbmRleCBlMWE4NGRiMmJkN2IuLjY4MjE0NTJh
MTVmOSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCisrKyBiL2Fy
Y2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCkBAIC0xOTEsNiArMTkxLDcgQEAgQ09ORklHX1BD
SV9IT1NUX1RIVU5ERVJfUEVNPXkNCiBDT05GSUdfUENJX0hPU1RfVEhVTkRFUl9FQ0FNPXkNCiBD
T05GSUdfUENJRV9ST0NLQ0hJUF9IT1NUPW0NCiBDT05GSUdfUENJX0xBWUVSU0NBUEU9eQ0KK0NP
TkZJR19QQ0lFX0xBWUVSU0NBUEVfR0VOND15DQogQ09ORklHX1BDSV9ISVNJPXkNCiBDT05GSUdf
UENJRV9RQ09NPXkNCiBDT05GSUdfUENJRV9BUk1BREFfOEs9eQ0KLS0gDQoyLjE3LjENCg0K
