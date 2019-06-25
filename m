Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA85278B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfFYJJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 05:09:07 -0400
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:7803
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbfFYJJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 05:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlLVxgr8QxhhZ8nKTKQ05I9xcg95k4yjkZX5MSXXDwM=;
 b=cAP0W/kh424i+FTruRWNb1AXR1hiURvOruKbgwuwfHGeZF9kj7BrG3A180J2RpFcuhocmfkvP4u3AcAAti3HVFIHqbK0/y/YrUjgnXMcn5eurNy7uD6ieAmRtzopF7AABypSl9PcygP5Xw0pVaHqDwzN9rkAwP4sPRKyALMlkdQ=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6746.eurprd04.prod.outlook.com (20.179.251.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 09:09:00 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 09:09:00 +0000
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
Subject: [PATCHv7 0/7] PCI: refactor Mobiveil driver and add PCIe Gen4 driver
 for NXP Layerscape SoCs
Thread-Topic: [PATCHv7 0/7] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHVKzWgSC0Msk8kWUykwlf/hqMpwA==
Date:   Tue, 25 Jun 2019 09:09:00 +0000
Message-ID: <20190625091039.18933-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2f259297-b51a-48e3-3b8a-08d6f94cc268
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6746;
x-ms-traffictypediagnostic: DB8PR04MB6746:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR04MB67463EADF78C80B036DC35DC84E30@DB8PR04MB6746.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(4326008)(386003)(26005)(102836004)(3846002)(478600001)(71190400001)(186003)(71200400001)(7416002)(6116002)(25786009)(66946007)(50226002)(110136005)(8936002)(54906003)(81166006)(8676002)(305945005)(81156014)(316002)(2201001)(5660300002)(66556008)(7736002)(66476007)(66446008)(64756008)(1076003)(66066001)(486006)(2616005)(2501003)(6306002)(73956011)(68736007)(6436002)(6486002)(256004)(6512007)(86362001)(6506007)(53936002)(36756003)(14454004)(966005)(99286004)(2906002)(52116002)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6746;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YVjenagjo4zMI1Qo/OvYw5J9pRQInrkRinAnKJRh02FtUub9LvvksS3p0hHbZjXom6YTI5FU28oACaKEF8kwCda2dBSCfO2uWSa8qh49h3HvpgRu7A/oe+O1sIhdY4R5WCQY4E1dAFuFeyyeXFyYZqg8pSAapH0KLtS9wueABD9DqC3Bj3UfGEhW8mWzUlyoBX2RxspLeOcLEXF/laTvFgqPsAtFLcSIrkJChmLF5SeIlzL7f2z1laJJyWeGhuFZnQonqN4vbOLbXRW2GHIly7YM/Dvh48E6l2H+xGBla0Ocb4RSwv5Jv17Hfwb+1JT9uYMv92AVC2/cQXtiQKXaroqzGCAtmQ5H5RCzYsJbF5+AOJxwosVttn8F7MoqiI02HzM8p6YBBbtEtluvZ9fi0tBN5Ud3sM9m1Z9PPC93v08=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36761CBE2B24B547B457C5081DEB949C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f259297-b51a-48e3-3b8a-08d6f94cc268
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 09:09:00.6558
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

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBz
dXBwb3J0IGZvciBOWFAgTGF5ZXJzY2FwZSBzZXJpZXMgU29DcyBpbnRlZ3JhdGVkIE1vYml2ZWls
J3MNClBDSWUgR2VuNCBjb250cm9sbGVyLg0KDQpUaGlzIHBhdGNoIHNldCBkZXBlbmRzIG9uOg0K
aHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtcGNpL2xpc3QvP3Nlcmll
cz0xMDIzNzgNCg0KSG91IFpoaXFpYW5nICg3KToNCiAgUENJOiBtb2JpdmVpbDogUmVmYWN0b3Ig
TW9iaXZlaWwgUENJZSBIb3N0IEJyaWRnZSBJUCBkcml2ZXINCiAgUENJOiBtb2JpdmVpbDogTWFr
ZSBtb2JpdmVpbF9ob3N0X2luaXQoKSBjYW4gYmUgdXNlZCB0byByZS1pbml0IGhvc3QNCiAgZHQt
YmluZGluZ3M6IFBDSTogQWRkIE5YUCBMYXllcnNjYXBlIFNvQ3MgUENJZSBHZW40IGNvbnRyb2xs
ZXINCiAgUENJOiBtb2JpdmVpbDogQWRkIDgtYml0IGFuZCAxNi1iaXQgQ1NSIHJlZ2lzdGVyIGFj
Y2Vzc29ycw0KICBQQ0k6IG1vYml2ZWlsOiBBZGQgUENJZSBHZW40IFJDIGRyaXZlciBmb3IgTlhQ
IExheWVyc2NhcGUgU29Dcw0KICBhcm02NDogZHRzOiBseDIxNjBhOiBBZGQgUENJZSBjb250cm9s
bGVyIERUIG5vZGVzDQogIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBDT05GSUdfUENJRV9MQVlF
UlNDQVBFX0dFTjQNCg0KIC4uLi9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0
ICAgICB8ICA1MiArKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxMCArLQ0KIC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEu
ZHRzaSB8IDE2MyArKysrKw0KIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAg
ICAgICAgICB8ICAgMSArDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAg
ICAgICAgIHwgIDExICstDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSAgICAgICAg
ICAgICAgIHwgICAyICstDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmln
ICAgICAgIHwgIDM0ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01ha2VmaWxl
ICAgICAgfCAgIDUgKw0KIC4uLi9tb2JpdmVpbC9wY2llLWxheWVyc2NhcGUtZ2VuNC5jICAgICAg
ICAgICB8IDI1NSArKysrKysrKw0KIC4uLi9wY2llLW1vYml2ZWlsLWhvc3QuY30gICAgICAgICAg
ICAgICAgICAgICB8IDU4OCArKysrLS0tLS0tLS0tLS0tLS0NCiAuLi4vY29udHJvbGxlci9tb2Jp
dmVpbC9wY2llLW1vYml2ZWlsLXBsYXQuYyAgfCAgNTkgKysNCiAuLi4vcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5jICAgfCAyNDggKysrKysrKysNCiAuLi4vcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oICAgfCAyMjUgKysrKysrKw0KIDEzIGZpbGVz
IGNoYW5nZWQsIDExNjAgaW5zZXJ0aW9ucygrKSwgNDkzIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2Nh
cGUtcGNpZS1nZW40LnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL21vYml2ZWlsL0tjb25maWcNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29u
dHJvbGxlci9tb2JpdmVpbC9NYWtlZmlsZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMNCiByZW5hbWUgZHJp
dmVycy9wY2kvY29udHJvbGxlci97cGNpZS1tb2JpdmVpbC5jID0+IG1vYml2ZWlsL3BjaWUtbW9i
aXZlaWwtaG9zdC5jfSAoNTElKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxhdC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5jDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVp
bC5oDQoNCi0tIA0KMi4xNy4xDQoNCg==
