Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E918B628
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfHMLEH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 07:04:07 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:15278
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfHMLEG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 07:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiHZT9Havqbz6zSgAH4GYj4Dl1oALb0Bix95sQk9+ZDuQohFFrXMfEalRnCS0bgmFJybLSgW5Mnpg8sI7MrQMdwaSt5Lnz0V9ZBxbIt0VkYSCpJjBI2/nzLQhOuZrAsDw5I+sdXWgS/h4uRVJnKsh61+edokuXRwRTLh3PZlA7Xmrxv4/R84XGsXoO+UG7dhcErrEldRvX7RNrVRkUmjBqmGsBGjYSC8VQ8cyMPgo8JixCCZyfAjmi54+ATsCHSwvFlFKb3DuDL4vNvhsnlUzHhk16njEIXf1mutAfEaHQou3qsiJt8qStKcRoPTecP0Xv7gNi615AQQAcFCXUJtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGhzlyqr6MtqehMhjE1QfN0NB3hi1B4TkoBBqTFyADU=;
 b=mkCUOC4OhiiSyO5jSatlSstwZZYaYnSysVLPDbHmmlGMcHZXJNZwt5aSwgcBsu8LBpl3y1E9RX3o8Ryh3xsFMYQJVxgS03XQ0W6DmxJ5lCEzHlJ2uAW8jGMPeZcYaGIkBguAEbjrxl2WTVyOWCFjKDkbPYz9h0/29dfIQvEbmoKPFYD9Z7zDc3rxeySmgUdnUixjfvj1GLXTogtgATBC/uUFiRIXrfdQeT8bwvVNOwSSJ6scTU/hJ7tiZrjlD5Snj8ngtRavOg3fC6odbtUta5mfa/WdLjkD3gUB4QQSlnbUn34mOCqQodMbuKaBI9DZleTAU8wSKshCpPc49kiFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGhzlyqr6MtqehMhjE1QfN0NB3hi1B4TkoBBqTFyADU=;
 b=q1RMRmhh7ZzZ462r1PJnqxCtU5/mp+yuf6/atYNTQzh+usARyfJvparOkGzKxHwa1WyD0PXVMxB4n948tbHMv4yKJr58wQjSIMsMB7EtmFFp+0JsII430o6QAPS+HI2E6i/xLXVMalZ6PKgAqzBHIX1hqsD06BFPlrrF+/EjcFk=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7035.eurprd04.prod.outlook.com (52.135.61.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Tue, 13 Aug 2019 11:03:50 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Tue, 13 Aug 2019
 11:03:50 +0000
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
Subject: [PATCHv8 0/7] PCI: refactor Mobiveil driver and add PCIe Gen4 driver
 for NXP Layerscape SoCs
Thread-Topic: [PATCHv8 0/7] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHVUcbJ5capTJ/u1EuWlo1+5KWo6Q==
Date:   Tue, 13 Aug 2019 11:03:50 +0000
Message-ID: <20190813110557.45643-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5be5874f-95b4-4438-a5ec-08d71fddebec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB7035;
x-ms-traffictypediagnostic: DB8PR04MB7035:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB70352E2CF50437F70DF9584784D20@DB8PR04MB7035.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(14454004)(36756003)(66446008)(5660300002)(81156014)(966005)(6512007)(6306002)(3846002)(7416002)(25786009)(6116002)(81166006)(102836004)(478600001)(6436002)(2201001)(2616005)(476003)(8676002)(8936002)(99286004)(2906002)(86362001)(66946007)(66556008)(186003)(64756008)(1076003)(66066001)(50226002)(256004)(4326008)(316002)(53936002)(486006)(2501003)(305945005)(52116002)(54906003)(26005)(6486002)(71190400001)(386003)(6506007)(110136005)(66476007)(7736002)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7035;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y8Igjs1xLxL/1RnX0P1XWm9myP37uuP9/INYux6n30H+aD7eFNl1Jt9aDZZIZLV0a0BlB9wBHtM6bJ1Gh9/JqROqsTog2df0GZH0bapRJjZYO+akCGHVrbccJty/GStyzhtSUGgDw/FZFDrw/bZPf7j6NZGy2+ZNW2vLiz/uW2WlKGD8eZNonVCFg+CJQogYKMT0SOoP/CeISyWDYlDBKl1Pcw02YYZpdXELxZEY9jQB6JtnVmwrr/BukLls14ATMDAzV4orQNuNDc6IGns1ReIGww/+Pzw6OLLJlXsyAhSxUxLGfNjUCsAwLO1KdjqQxlMweV3QJ8FOqjIQKVFL/9wiZHNd65MZuaR6ci6Xsn3dQHop9qux10kcqli3UHavX6wBuvCUIUTJ3MfuQmeiI0Yw3qeUq8fHzB6Vv0QulAQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE2EEE528A575247960F28F6A8D1026A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be5874f-95b4-4438-a5ec-08d71fddebec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 11:03:50.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyvllMcwW08KqYheiCkxn1MCWEnmR9RItGo5HSx8Yk8nftZYAYrnufE9tXf00RcCjgHWgdfTPnOt/N8TvwiYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBz
dXBwb3J0IGZvciBOWFAgTGF5ZXJzY2FwZSBzZXJpZXMgU29DcyBpbnRlZ3JhdGVkIE1vYml2ZWls
J3MNClBDSWUgR2VuNCBjb250cm9sbGVyLg0KDQpUaGlzIHBhdGNoIHNldCBkZXBlbmRzIG9uOg0K
aHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzExMzE2MjQvDQoNCkhvdSBaaGlxaWFu
ZyAoNyk6DQogIFBDSTogbW9iaXZlaWw6IFJlZmFjdG9yIE1vYml2ZWlsIFBDSWUgSG9zdCBCcmlk
Z2UgSVAgZHJpdmVyDQogIFBDSTogbW9iaXZlaWw6IE1ha2UgbW9iaXZlaWxfaG9zdF9pbml0KCkg
Y2FuIGJlIHVzZWQgdG8gcmUtaW5pdCBob3N0DQogIGR0LWJpbmRpbmdzOiBQQ0k6IEFkZCBOWFAg
TGF5ZXJzY2FwZSBTb0NzIFBDSWUgR2VuNCBjb250cm9sbGVyDQogIFBDSTogbW9iaXZlaWw6IEFk
ZCA4LWJpdCBhbmQgMTYtYml0IENTUiByZWdpc3RlciBhY2Nlc3NvcnMNCiAgUENJOiBtb2JpdmVp
bDogQWRkIFBDSWUgR2VuNCBSQyBkcml2ZXIgZm9yIE5YUCBMYXllcnNjYXBlIFNvQ3MNCiAgYXJt
NjQ6IGR0czogbHgyMTYwYTogQWRkIFBDSWUgY29udHJvbGxlciBEVCBub2Rlcw0KICBhcm02NDog
ZGVmY29uZmlnOiBFbmFibGUgQ09ORklHX1BDSUVfTEFZRVJTQ0FQRV9HRU40DQoNCiBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCiAuLi4vYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgfCAxNjMgKysrKysNCiBhcmNo
L2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAxMSArLQ0KIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMiArLQ0KIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZpZyAgICAgICB8ICAzNCArKw0KIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvTWFrZWZpbGUgICAgICB8ICAgNSArDQogLi4uL21v
Yml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMgICAgICAgICAgIHwgMjc0ICsrKysrKysrKw0K
IC4uLi9wY2llLW1vYml2ZWlsLWhvc3QuY30gICAgICAgICAgICAgICAgICAgICB8IDU2NiArKysr
LS0tLS0tLS0tLS0tLS0NCiAuLi4vY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLXBs
YXQuYyAgfCAgNTkgKysNCiAuLi4vcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVp
bC5jICAgfCAyMjcgKysrKysrKw0KIC4uLi9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1v
Yml2ZWlsLmggICB8IDIyMiArKysrKysrDQogMTIgZmlsZXMgY2hhbmdlZCwgMTEwMyBpbnNlcnRp
b25zKCspLCA0NzEgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZpZw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01ha2VmaWxlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1sYXllcnNjYXBlLWdlbjQuYw0KIHJl
bmFtZSBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3twY2llLW1vYml2ZWlsLmMgPT4gbW9iaXZlaWwv
cGNpZS1tb2JpdmVpbC1ob3N0LmN9ICg1MiUpDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1wbGF0LmMNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmMN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2ll
LW1vYml2ZWlsLmgNCg0KLS0gDQoyLjE3LjENCg0K
