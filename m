Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346532BF96
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 08:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfE1GuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 02:50:01 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:50436
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfE1GuB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 May 2019 02:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSIMUbGAasKFx6LQ0iw1MGA3Rs2utlSGPk2XxF2GGk8=;
 b=al1wVnhwV+Vkh/JW5zvmQGRGKJsUP6oAbFZxs/ZXMJR1lw5Z+65Rx7+xG1fEqn+Fg10gP/YNbwpme/sEUzGnUs7AvwfKm6LUUuaLfvtKJ6vjxpCEep1fGlOVAksdM8Dxp9WqwaQnJrn5Eb9YhbYMnsC6ICQpPJ1Kxcarz9Dcp+Q=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5495.eurprd04.prod.outlook.com (20.178.93.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 06:49:57 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 06:49:57 +0000
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
Subject: [PATCHv6 0/6] PCI: refactor Mobiveil driver and add PCIe Gen4 driver
 for NXP Layerscape SoCs
Thread-Topic: [PATCHv6 0/6] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHVFSGPu5nAfglMjU69RH0Kn4DS/A==
Date:   Tue, 28 May 2019 06:49:56 +0000
Message-ID: <20190528065129.8769-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: ed6f9738-4ddf-4324-0e96-08d6e338b1fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB5495;
x-ms-traffictypediagnostic: AM6PR04MB5495:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR04MB549593C9785CBFAB66812939841E0@AM6PR04MB5495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(2501003)(6486002)(86362001)(6116002)(6436002)(66066001)(6306002)(6512007)(2201001)(386003)(2906002)(53936002)(25786009)(3846002)(7416002)(4326008)(71200400001)(71190400001)(66476007)(54906003)(81156014)(73956011)(64756008)(66556008)(966005)(50226002)(8676002)(316002)(5660300002)(81166006)(8936002)(110136005)(305945005)(102836004)(52116002)(186003)(26005)(36756003)(68736007)(6506007)(7736002)(256004)(478600001)(486006)(1076003)(99286004)(66946007)(66446008)(2616005)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5495;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m3TIdjqMZeBvk5fsm7Gt3xOZ0ShyZyq7nt8EiAVOO8raLjBBhibcOl8THUTKuBhzJkmLPKi9Hr11d4eoZUhmetBY27tOgCOlsLQiJ0rBQSKWF2oykzSFrn9kjTX+7kOaBTuPrl/Ef2w9QPS8suEQwOFsojMtvs6mRL5e3vgzSp+e6wz5AHujzhfrAzLHvd07mZ5Mpk3s+DIKDO474twL06fF6v3wyA+ztPXamaluHREuhUn/2HuYLXBqjOYT643Nn0xlfPtvM944Kr3xvhRT0nctSwq/GFlr1BCNQWX5RR425Ek3OwjY2k131UyTZB08hnaLB1o5FxYEmz1KHmH3GVSNAWOAhzco4r9n79Lk6qdWZ1gZw67nkgQY0Xd07K1GsQVCT0nvH9vMed4XEoHfbG8PhrTYA5LBXKF9473/R6A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F58DBE0F145D784D9B14E2DF418B7DB6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6f9738-4ddf-4324-0e96-08d6e338b1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 06:49:56.8999
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

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBz
dXBwb3J0IGZvciBOWFAgTGF5ZXJzY2FwZSBzZXJpZXMgU29DcyBpbnRlZ3JhdGVkIE1vYml2ZWls
J3MNClBDSWUgR2VuNCBjb250cm9sbGVyLg0KDQpUaGlzIHBhdGNoIHNldCBkZXBlbmRzIG9uOg0K
aHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtcGNpL2xpc3QvP3Nlcmll
cz0xMDIzNzgNCg0KSG91IFpoaXFpYW5nICg2KToNCiAgUENJOiBtb2JpdmVpbDogUmVmYWN0b3Ig
TW9iaXZlaWwgUENJZSBIb3N0IEJyaWRnZSBJUCBkcml2ZXINCiAgUENJOiBtb2JpdmVpbDogTWFr
ZSBtb2JpdmVpbF9ob3N0X2luaXQoKSBjYW4gYmUgdXNlZCB0byByZS1pbml0IGhvc3QNCiAgZHQt
YmluZGluZ3M6IFBDSTogQWRkIE5YUCBMYXllcnNjYXBlIFNvQ3MgUENJZSBHZW40IGNvbnRyb2xs
ZXINCiAgUENJOiBtb2JpdmVpbDogQWRkIFBDSWUgR2VuNCBSQyBkcml2ZXIgZm9yIE5YUCBMYXll
cnNjYXBlIFNvQ3MNCiAgYXJtNjQ6IGR0czogbHgyMTYwYTogQWRkIFBDSWUgY29udHJvbGxlciBE
VCBub2Rlcw0KICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgQ09ORklHX1BDSUVfTEFZRVJTQ0FQ
RV9HRU40DQoNCiAuLi4vYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpZS1nZW40LnR4dCAgICAg
fCAgNTIgKysNCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMTAgKy0NCiAuLi4vYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kg
fCAxNjMgKysrKysNCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICAg
ICB8ICAxMSArLQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUgICAgICAgICAgICAg
ICB8ICAgMiArLQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZpZyAgICAg
ICB8ICAzNCArDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9NYWtlZmlsZSAgICAg
IHwgICA1ICsNCiAuLi4vbW9iaXZlaWwvcGNpZS1sYXllcnNjYXBlLWdlbjQuYyAgICAgICAgICAg
fCAyNTUgKysrKysrKysNCiAuLi4vcGNpZS1tb2JpdmVpbC1ob3N0LmN9ICAgICAgICAgICAgICAg
ICAgICAgfCA2MDggKysrLS0tLS0tLS0tLS0tLS0tDQogLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwv
cGNpZS1tb2JpdmVpbC1wbGF0LmMgIHwgIDU5ICsrDQogLi4uL3BjaS9jb250cm9sbGVyL21vYml2
ZWlsL3BjaWUtbW9iaXZlaWwuYyAgIHwgMjQ4ICsrKysrKysNCiAuLi4vcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oICAgfCAyMjUgKysrKysrKw0KIDEzIGZpbGVzIGNoYW5n
ZWQsIDExNjAgaW5zZXJ0aW9ucygrKSwgNTEzIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNp
ZS1nZW40LnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21v
Yml2ZWlsL0tjb25maWcNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9tb2JpdmVpbC9NYWtlZmlsZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMNCiByZW5hbWUgZHJpdmVycy9w
Y2kvY29udHJvbGxlci97cGNpZS1tb2JpdmVpbC5jID0+IG1vYml2ZWlsL3BjaWUtbW9iaXZlaWwt
aG9zdC5jfSAoNTElKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxhdC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5jDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQoN
Ci0tIA0KMi4xNy4xDQoNCg==
