Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918872BF9F
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfE1GuS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 02:50:18 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:2909
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727240AbfE1GuR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 May 2019 02:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zATrfxR2Kmu5qtNNWHEcttgEhfMnLDPBFRVbL6TPC+Q=;
 b=iRjtAL5OgT5VzYzrbr9W8zShk99SKxKJHg5/dna5ZxEfiQVmgMjT1YHARSNvVDpq2r9JAtgB02uptBwnX8AEEPQj0Xde9AvuGwI7JttLu5f8hVKb4aAciz4Q7E+x8BlcUB5nW2KWzfj0h/UqBP4QVpr+vbGx8zMWdaLjq8rfXZc=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5495.eurprd04.prod.outlook.com (20.178.93.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 06:50:12 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 06:50:12 +0000
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
Subject: [PATCHv6 2/6] PCI: mobiveil: Make mobiveil_host_init() can be used to
 re-init host
Thread-Topic: [PATCHv6 2/6] PCI: mobiveil: Make mobiveil_host_init() can be
 used to re-init host
Thread-Index: AQHVFSGZDtYLTsp2jkq4RgNgM5Wy0Q==
Date:   Tue, 28 May 2019 06:50:12 +0000
Message-ID: <20190528065129.8769-3-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 4fe185ca-0e86-45f5-718a-08d6e338bb68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB5495;
x-ms-traffictypediagnostic: AM6PR04MB5495:
x-microsoft-antispam-prvs: <AM6PR04MB549518E2838A54CFD3E6F4D3841E0@AM6PR04MB5495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(2501003)(6486002)(86362001)(6116002)(6436002)(66066001)(6512007)(2201001)(386003)(2906002)(53936002)(25786009)(3846002)(7416002)(4326008)(71200400001)(71190400001)(66476007)(54906003)(11346002)(81156014)(73956011)(64756008)(66556008)(50226002)(8676002)(316002)(5660300002)(81166006)(8936002)(110136005)(305945005)(76176011)(102836004)(52116002)(14444005)(186003)(26005)(36756003)(68736007)(6506007)(7736002)(256004)(446003)(478600001)(486006)(1076003)(99286004)(66946007)(66446008)(2616005)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5495;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yBiR+elnfGclYjyzxaphZIemQJpgNWtIkoCkUSAHKMOHVmtnnvxLKAepZmrADEBz4Ig092X7Xu0yeoHrjMsOICKRVur3zv0QhVHAafWbQ3o/oso/CG8YtMcudjzW8Ln67IoYDAPGDxeB8g8Hai4/yOgg3s2J7O/AMMRb4278O92BazbXeX8CzswC/AiLcv5v01W0wmoF+DviR+PC6AqeezyWt46IxT2Tzs97FjbSlUjk66qzsqDpFmRUFkc8M9NyPZGLREimVWubp8T+9oBnK5wh6F73LGwySD2TrWM/e69sBoZU7qBqa9ZZi3Esxr0oFXk5gddcBcIB0nlrmX+3vKAY69zcjr7fqSKCZbgamH7gJFq16DjfeaVuAUmRZv+vNeI/SLNF2J3BUmbt/Tmo4T26w/sa8KkhMgSM2nDdcmg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe185ca-0e86-45f5-718a-08d6e338bb68
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 06:50:12.5149
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

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KTWFrZSB0aGUgbW9i
aXZlaWxfaG9zdF9pbml0KCkgZnVuY3Rpb24gY2FuIGJlIHVzZWQgdG8gcmUtaW5pdA0KaG9zdCBj
b250cm9sbGVyJ3MgUEFCIGFuZCBHUEVYIENTUiByZWdpc3RlciBibG9jaywgYXMgTlhQDQppbnRl
Z3JhdGVkIE1vYml2ZWlsIElQIGhhcyB0byByZXNldCBhbmQgdGhlbiByZS1pbml0IHRoZSBQQUIN
CmFuZCBHUEVYIENTUiByZWdpc3RlcnMgdXBvbiBob3QtcmVzZXQuDQoNClNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQpSZXZpZXdlZC1ieTogU3VicmFo
bWFueWEgTGluZ2FwcGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQotLS0NClY2Og0K
IC0gTm8gY2hhbmdlLg0KDQogLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1o
b3N0LmMgIHwgNDEgKysrKysrKysrKy0tLS0tLS0tLQ0KIC4uLi9wY2kvY29udHJvbGxlci9tb2Jp
dmVpbC9wY2llLW1vYml2ZWlsLmggICB8ICAzICstDQogMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNl
cnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5jDQppbmRleCBjNGI5OGEzMWQ0MjYu
LmZjNDAxYWYwMzBkZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZl
aWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMNCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9i
aXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMNCkBAIC0yMTksNyArMjE5LDcgQEAgc3RhdGljIHZv
aWQgbW9iaXZlaWxfcGNpZV9lbmFibGVfbXNpKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKQ0K
IAl3cml0ZWxfcmVsYXhlZCgxLCBwY2llLT5hcGJfY3NyX2Jhc2UgKyBNU0lfRU5BQkxFX09GRlNF
VCk7DQogfQ0KIA0KLXN0YXRpYyBpbnQgbW9iaXZlaWxfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVp
bF9wY2llICpwY2llKQ0KK2ludCBtb2JpdmVpbF9ob3N0X2luaXQoc3RydWN0IG1vYml2ZWlsX3Bj
aWUgKnBjaWUsIGJvb2wgcmVpbml0KQ0KIHsNCiAJdTMyIHZhbHVlLCBwYWJfY3RybCwgdHlwZTsN
CiAJc3RydWN0IHJlc291cmNlX2VudHJ5ICp3aW47DQpAQCAtMjMxLDExICsyMzEsMTYgQEAgc3Rh
dGljIGludCBtb2JpdmVpbF9ob3N0X2luaXQoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQog
CWZvciAoaSA9IDA7IGkgPCBwY2llLT5wcGlvX3dpbnM7IGkrKykNCiAJCW1vYml2ZWlsX3BjaWVf
ZGlzYWJsZV9pYl93aW4ocGNpZSwgaSk7DQogDQotCS8qIHNldHVwIGJ1cyBudW1iZXJzICovDQot
CXZhbHVlID0gY3NyX3JlYWRsKHBjaWUsIFBDSV9QUklNQVJZX0JVUyk7DQotCXZhbHVlICY9IDB4
ZmYwMDAwMDA7DQotCXZhbHVlIHw9IDB4MDBmZjAxMDA7DQotCWNzcl93cml0ZWwocGNpZSwgdmFs
dWUsIFBDSV9QUklNQVJZX0JVUyk7DQorCXBjaWUtPmliX3dpbnNfY29uZmlndXJlZCA9IDA7DQor
CXBjaWUtPm9iX3dpbnNfY29uZmlndXJlZCA9IDA7DQorDQorCWlmICghcmVpbml0KSB7DQorCQkv
KiBzZXR1cCBidXMgbnVtYmVycyAqLw0KKwkJdmFsdWUgPSBjc3JfcmVhZGwocGNpZSwgUENJX1BS
SU1BUllfQlVTKTsNCisJCXZhbHVlICY9IDB4ZmYwMDAwMDA7DQorCQl2YWx1ZSB8PSAweDAwZmYw
MTAwOw0KKwkJY3NyX3dyaXRlbChwY2llLCB2YWx1ZSwgUENJX1BSSU1BUllfQlVTKTsNCisJfQ0K
IA0KIAkvKg0KIAkgKiBwcm9ncmFtIEJ1cyBNYXN0ZXIgRW5hYmxlIEJpdCBpbiBDb21tYW5kIFJl
Z2lzdGVyIGluIFBBQiBDb25maWcNCkBAIC0yODEsNyArMjg2LDcgQEAgc3RhdGljIGludCBtb2Jp
dmVpbF9ob3N0X2luaXQoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQogCXByb2dyYW1faWJf
d2luZG93cyhwY2llLCBXSU5fTlVNXzAsIDAsIDAsIE1FTV9XSU5ET1dfVFlQRSwgSUJfV0lOX1NJ
WkUpOw0KIA0KIAkvKiBHZXQgdGhlIEkvTyBhbmQgbWVtb3J5IHJhbmdlcyBmcm9tIERUICovDQot
CXJlc291cmNlX2xpc3RfZm9yX2VhY2hfZW50cnkod2luLCAmcGNpZS0+cmVzb3VyY2VzKSB7DQor
CXJlc291cmNlX2xpc3RfZm9yX2VhY2hfZW50cnkod2luLCBwY2llLT5yZXNvdXJjZXMpIHsNCiAJ
CWlmIChyZXNvdXJjZV90eXBlKHdpbi0+cmVzKSA9PSBJT1JFU09VUkNFX01FTSkgew0KIAkJCXR5
cGUgPSBNRU1fV0lORE9XX1RZUEU7DQogCQl9IGVsc2UgaWYgKHJlc291cmNlX3R5cGUod2luLT5y
ZXMpID09IElPUkVTT1VSQ0VfSU8pIHsNCkBAIC01NTIsOCArNTU3LDYgQEAgaW50IG1vYml2ZWls
X3BjaWVfaG9zdF9wcm9iZShzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiAJcmVzb3VyY2Vf
c2l6ZV90IGlvYmFzZTsNCiAJaW50IHJldDsNCiANCi0JSU5JVF9MSVNUX0hFQUQoJnBjaWUtPnJl
c291cmNlcyk7DQotDQogCXJldCA9IG1vYml2ZWlsX3BjaWVfcGFyc2VfZHQocGNpZSk7DQogCWlm
IChyZXQpIHsNCiAJCWRldl9lcnIoZGV2LCAiUGFyc2luZyBEVCBmYWlsZWQsIHJldDogJXhcbiIs
IHJldCk7DQpAQCAtNTYyLDM0ICs1NjUsMzUgQEAgaW50IG1vYml2ZWlsX3BjaWVfaG9zdF9wcm9i
ZShzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiANCiAJLyogcGFyc2UgdGhlIGhvc3QgYnJp
ZGdlIGJhc2UgYWRkcmVzc2VzIGZyb20gdGhlIGRldmljZSB0cmVlIGZpbGUgKi8NCiAJcmV0ID0g
ZGV2bV9vZl9wY2lfZ2V0X2hvc3RfYnJpZGdlX3Jlc291cmNlcyhkZXYsIDAsIDB4ZmYsDQotCQkJ
CQkJICAgICZwY2llLT5yZXNvdXJjZXMsICZpb2Jhc2UpOw0KKwkJCQkJCSAgICAmYnJpZGdlLT53
aW5kb3dzLCAmaW9iYXNlKTsNCiAJaWYgKHJldCkgew0KIAkJZGV2X2VycihkZXYsICJHZXR0aW5n
IGJyaWRnZSByZXNvdXJjZXMgZmFpbGVkXG4iKTsNCiAJCXJldHVybiByZXQ7DQogCX0NCiANCisJ
cGNpZS0+cmVzb3VyY2VzID0gJmJyaWRnZS0+d2luZG93czsNCisNCiAJLyoNCiAJICogY29uZmln
dXJlIGFsbCBpbmJvdW5kIGFuZCBvdXRib3VuZCB3aW5kb3dzIGFuZCBwcmVwYXJlIHRoZSBSQyBm
b3INCiAJICogY29uZmlnIGFjY2Vzcw0KIAkgKi8NCi0JcmV0ID0gbW9iaXZlaWxfaG9zdF9pbml0
KHBjaWUpOw0KKwlyZXQgPSBtb2JpdmVpbF9ob3N0X2luaXQocGNpZSwgZmFsc2UpOw0KIAlpZiAo
cmV0KSB7DQogCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBpbml0aWFsaXplIGhvc3RcbiIpOw0K
LQkJZ290byBlcnJvcjsNCisJCXJldHVybiByZXQ7DQogCX0NCiANCiAJcmV0ID0gbW9iaXZlaWxf
cGNpZV9pbnRlcnJ1cHRfaW5pdChwY2llKTsNCiAJaWYgKHJldCkgew0KIAkJZGV2X2VycihkZXYs
ICJJbnRlcnJ1cHQgaW5pdCBmYWlsZWRcbiIpOw0KLQkJZ290byBlcnJvcjsNCisJCXJldHVybiBy
ZXQ7DQogCX0NCiANCi0JcmV0ID0gZGV2bV9yZXF1ZXN0X3BjaV9idXNfcmVzb3VyY2VzKGRldiwg
JnBjaWUtPnJlc291cmNlcyk7DQorCXJldCA9IGRldm1fcmVxdWVzdF9wY2lfYnVzX3Jlc291cmNl
cyhkZXYsIHBjaWUtPnJlc291cmNlcyk7DQogCWlmIChyZXQpDQotCQlnb3RvIGVycm9yOw0KKwkJ
cmV0dXJuIHJldDsNCiANCiAJLyogSW5pdGlhbGl6ZSBicmlkZ2UgKi8NCi0JbGlzdF9zcGxpY2Vf
aW5pdCgmcGNpZS0+cmVzb3VyY2VzLCAmYnJpZGdlLT53aW5kb3dzKTsNCiAJYnJpZGdlLT5kZXYu
cGFyZW50ID0gZGV2Ow0KIAlicmlkZ2UtPnN5c2RhdGEgPSBwY2llOw0KIAlicmlkZ2UtPmJ1c25y
ID0gcGNpZS0+cnAucm9vdF9idXNfbnI7DQpAQCAtNjA0LDcgKzYwOCw3IEBAIGludCBtb2JpdmVp
bF9wY2llX2hvc3RfcHJvYmUoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQogCS8qIHNldHVw
IHRoZSBrZXJuZWwgcmVzb3VyY2VzIGZvciB0aGUgbmV3bHkgYWRkZWQgUENJZSByb290IGJ1cyAq
Lw0KIAlyZXQgPSBwY2lfc2Nhbl9yb290X2J1c19icmlkZ2UoYnJpZGdlKTsNCiAJaWYgKHJldCkN
Ci0JCWdvdG8gZXJyb3I7DQorCQlyZXR1cm4gcmV0Ow0KIA0KIAlidXMgPSBicmlkZ2UtPmJ1czsN
CiANCkBAIC02MTQsNyArNjE4LDQgQEAgaW50IG1vYml2ZWlsX3BjaWVfaG9zdF9wcm9iZShzdHJ1
Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiAJcGNpX2J1c19hZGRfZGV2aWNlcyhidXMpOw0KIA0K
IAlyZXR1cm4gMDsNCi1lcnJvcjoNCi0JcGNpX2ZyZWVfcmVzb3VyY2VfbGlzdCgmcGNpZS0+cmVz
b3VyY2VzKTsNCi0JcmV0dXJuIHJldDsNCiB9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KaW5kZXggZGNlNzg3MTc2MWUxLi5hNzI5YTRmODc5
ZmUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9i
aXZlaWwuaA0KKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2
ZWlsLmgNCkBAIC0xNTQsNyArMTU0LDcgQEAgc3RydWN0IG1vYml2ZWlsX3BhYl9vcHMgew0KIA0K
IHN0cnVjdCBtb2JpdmVpbF9wY2llIHsNCiAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsN
Ci0Jc3RydWN0IGxpc3RfaGVhZCByZXNvdXJjZXM7DQorCXN0cnVjdCBsaXN0X2hlYWQgKnJlc291
cmNlczsNCiAJdm9pZCBfX2lvbWVtICpjc3JfYXhpX3NsYXZlX2Jhc2U7CS8qIFBBQiByZWdpc3Rl
cnMgYmFzZSAqLw0KIAlwaHlzX2FkZHJfdCBwY2llX3JlZ19iYXNlOwkvKiBQaHlzaWNhbCBQQ0ll
IENvbnRyb2xsZXIgQmFzZSAqLw0KIAl2b2lkIF9faW9tZW0gKmFwYl9jc3JfYmFzZTsJLyogTVNJ
IHJlZ2lzdGVyIGJhc2UgKi8NCkBAIC0xNjgsNiArMTY4LDcgQEAgc3RydWN0IG1vYml2ZWlsX3Bj
aWUgew0KIH07DQogDQogaW50IG1vYml2ZWlsX3BjaWVfaG9zdF9wcm9iZShzdHJ1Y3QgbW9iaXZl
aWxfcGNpZSAqcGNpZSk7DQoraW50IG1vYml2ZWlsX2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxf
cGNpZSAqcGNpZSwgYm9vbCByZWluaXQpOw0KIGJvb2wgbW9iaXZlaWxfcGNpZV9saW5rX3VwKHN0
cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKTsNCiBpbnQgbW9iaXZlaWxfYnJpbmd1cF9saW5rKHN0
cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKTsNCiB2b2lkIHByb2dyYW1fb2Jfd2luZG93cyhzdHJ1
Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgaW50IHdpbl9udW0sIHU2NCBjcHVfYWRkciwNCi0tIA0K
Mi4xNy4xDQoNCg==
