Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78D52796
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 11:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfFYJJb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 05:09:31 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:56134
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731294AbfFYJJb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 05:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNzkn/a0IqunK1Yi9Xo6xRbN57iI7q+LcT+L41q2PKE=;
 b=KzABVjnxVn6ypctwJSGEPMqX+qUN1ultl40IRdfT2qbWUIRmk9eS0JY8ZXQA56J0EVvOLz8ezxwD7be2D18fnWvJ9ZOFrXjUShIprysUnM0x2aVwdtgrzMsBQroMFTA4zhGTpDE0aDTuKvP9p0p9tLimyoW4Id0NG9JwWM8F9dk=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6746.eurprd04.prod.outlook.com (20.179.251.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 09:09:28 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 09:09:28 +0000
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
Subject: [PATCHv7 4/7] PCI: mobiveil: Add 8-bit and 16-bit CSR register
 accessors
Thread-Topic: [PATCHv7 4/7] PCI: mobiveil: Add 8-bit and 16-bit CSR register
 accessors
Thread-Index: AQHVKzWxDgZokwi9zUOCFYG14230nQ==
Date:   Tue, 25 Jun 2019 09:09:28 +0000
Message-ID: <20190625091039.18933-5-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: eefafff2-85f6-4280-4ac3-08d6f94cd374
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6746;
x-ms-traffictypediagnostic: DB8PR04MB6746:
x-microsoft-antispam-prvs: <DB8PR04MB6746D132B4579F63EF4BBDF584E30@DB8PR04MB6746.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(4326008)(386003)(446003)(26005)(102836004)(3846002)(478600001)(71190400001)(186003)(11346002)(71200400001)(7416002)(6116002)(25786009)(66946007)(50226002)(110136005)(8936002)(54906003)(81166006)(8676002)(305945005)(81156014)(316002)(2201001)(5660300002)(66556008)(7736002)(66476007)(66446008)(64756008)(1076003)(66066001)(486006)(2616005)(2501003)(73956011)(68736007)(6436002)(6486002)(256004)(6512007)(86362001)(6506007)(53936002)(36756003)(14454004)(99286004)(2906002)(52116002)(476003)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6746;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gt2Am9JVtGIsu0SPXF0hdh22vv5J+/2Er/5zoVrRzAP4AwLCf+EbHbu8Vc3aQ6VmVBtwaWba5aU4iBz0WoQVKx6dxfd42xAKOPSW/QnNhHVE7vdxYDWP3WL6D0Hx2VPaSw85jhETqGaMLsXoIisoYfoL7JGu1G0uVZ3uO3Ta/hdZaD2TPy0bNcTSmil6i+HNQnX9ReiGFh74lRAi16iDz8n7fXB9o/Ahlv1WJ3OXxnEFurinHEGuueDW0eICrWSVDYiIK6+bQvc3REpOKOp1Akj8P5iVg48vyaA6CXIGc3jo4e2pEJiZwteJVpvhMPgegOFzKcAAPL4tVBuhDpm4joRVnTTvNhn0iuJBY+zhbk38cIzYhqR1pG73Kqh3Sks1CWhxK3AGtDjl22Q/6XRYX4N5VWQnWBPrT2iUO5mQg6w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefafff2-85f6-4280-4ac3-08d6f94cd374
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 09:09:28.3646
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

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhlcmUgYXJlIHNv
bWUgOC1iaXQgYW5kIDE2LWJpdCByZWdpc3RlcnMgaW4gUENJZSBjb25maWd1cmF0aW9uDQpzcGFj
ZSwgc28gYWRkIHRoZXNlIGFjY2Vzc29ycyBhY2NvcmRpbmdseS4NCg0KU2lnbmVkLW9mZi1ieTog
SG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBNaW5naHVh
biBMaWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQpSZXZpZXdlZC1ieTogU3VicmFobWFueWEg
TGluZ2FwcGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQotLS0NClY3Og0KIC0gTmV3
IHBhdGNoIG1vdmVkIGZyb20gdGhlIGZpeGVzIHNlcmllcy4NCg0KIC4uLi9wY2kvY29udHJvbGxl
ci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggICB8IDIwICsrKysrKysrKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KaW5kZXggMTU5YjAxNDJhMmJjLi5hNzI5
YTRmODc5ZmUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3Bj
aWUtbW9iaXZlaWwuaA0KKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2ll
LW1vYml2ZWlsLmgNCkBAIC0xODUsOSArMTg1LDI5IEBAIHN0YXRpYyBpbmxpbmUgdTMyIGNzcl9y
ZWFkbChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMyIG9mZikNCiAJcmV0dXJuIGNzcl9y
ZWFkKHBjaWUsIG9mZiwgMHg0KTsNCiB9DQogDQorc3RhdGljIGlubGluZSB1MzIgY3NyX3JlYWR3
KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llLCB1MzIgb2ZmKQ0KK3sNCisJcmV0dXJuIGNzcl9y
ZWFkKHBjaWUsIG9mZiwgMHgyKTsNCit9DQorDQorc3RhdGljIGlubGluZSB1MzIgY3NyX3JlYWRi
KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llLCB1MzIgb2ZmKQ0KK3sNCisJcmV0dXJuIGNzcl9y
ZWFkKHBjaWUsIG9mZiwgMHgxKTsNCit9DQorDQogc3RhdGljIGlubGluZSB2b2lkIGNzcl93cml0
ZWwoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUsIHUzMiB2YWwsIHUzMiBvZmYpDQogew0KIAlj
c3Jfd3JpdGUocGNpZSwgdmFsLCBvZmYsIDB4NCk7DQogfQ0KIA0KK3N0YXRpYyBpbmxpbmUgdm9p
ZCBjc3Jfd3JpdGV3KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llLCB1MzIgdmFsLCB1MzIgb2Zm
KQ0KK3sNCisJY3NyX3dyaXRlKHBjaWUsIHZhbCwgb2ZmLCAweDIpOw0KK30NCisNCitzdGF0aWMg
aW5saW5lIHZvaWQgY3NyX3dyaXRlYihzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMyIHZh
bCwgdTMyIG9mZikNCit7DQorCWNzcl93cml0ZShwY2llLCB2YWwsIG9mZiwgMHgxKTsNCit9DQor
DQogI2VuZGlmIC8qIF9QQ0lFX01PQklWRUlMX0ggKi8NCi0tIA0KMi4xNy4xDQoNCg==
