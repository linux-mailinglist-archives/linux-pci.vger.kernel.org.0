Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC952792
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfFYJJ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 05:09:26 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:52627
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731233AbfFYJJ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 05:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U5VtGsbw0AYdDotxC/i5obY2a5xkxAeuVxqtrZG/bY=;
 b=nTRU25MxqlZOQ27xxkBUEjIRKAYjNgAY8imqP+JqDuPzXOoHeRiSwvSI0j/rHAhyRexftp6r6nIqfMWS+RcROoc6kcXyHcGaaSN9HU1UpUbu53/JxQAof/lS9m9MeSki4Yzfy1E1+CggRKNSSX0AZkQqhCagtHxG6U4b77veky8=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6746.eurprd04.prod.outlook.com (20.179.251.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 09:09:21 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 09:09:21 +0000
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
Subject: [PATCHv7 3/7] dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4
 controller
Thread-Topic: [PATCHv7 3/7] dt-bindings: PCI: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Index: AQHVKzWtQ7ZuF/N9a0ytONyAp9FOZA==
Date:   Tue, 25 Jun 2019 09:09:21 +0000
Message-ID: <20190625091039.18933-4-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: d754a4f5-f1eb-45ca-7194-08d6f94ccf41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6746;
x-ms-traffictypediagnostic: DB8PR04MB6746:
x-microsoft-antispam-prvs: <DB8PR04MB674671B6732E40DAEB86E11584E30@DB8PR04MB6746.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(4326008)(386003)(446003)(26005)(102836004)(3846002)(478600001)(71190400001)(186003)(11346002)(71200400001)(7416002)(6116002)(25786009)(66946007)(50226002)(110136005)(8936002)(54906003)(81166006)(8676002)(305945005)(81156014)(316002)(2201001)(5660300002)(66556008)(7736002)(66476007)(66446008)(64756008)(1076003)(66066001)(486006)(2616005)(2501003)(73956011)(68736007)(6436002)(6486002)(256004)(6512007)(86362001)(6506007)(53936002)(36756003)(14454004)(99286004)(2906002)(52116002)(476003)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6746;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oIpx0KIMHfqib4K8CZ5TFkLncCCce4LwJ6KNKwIFG6wqw53TNdDuBqqCeDFZmUmTxSsIPU41CLtJILx6tnK5QaVxUFfkfEg8OD6j3HAm4Om2rDpVnY9uJcsP5yiBtn8I9/7g/PcpfWXj59xL7Vg1yaPxYOX2ZsH7HmY3YJhVzbQH8ZcxiFRkW46XGO5CpcsBADeXUlqAXEqVdBc96UxL0oMcyr3PnHRFPoyvO1UOlODk+7ORuda3hMQVXu3AvDrgMNwG++DjbAp7ApyX2258YWsbdRePu3gVMlZmtNfkUfXiS8cM1QYC4uvUcc6PmhArQf///fgdngLkHKkcZDojcqUrjF8Opbt3sYY97KJN7q8ciN77jYPSSSxmYwgIJPRJOoWfvgmohkngDtHKZysrZaeCmL4JfeDmzrCukVHSGAo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d754a4f5-f1eb-45ca-7194-08d6f94ccf41
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 09:09:21.5334
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

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KQWRkIFBDSWUgR2Vu
NCBjb250cm9sbGVyIERUIGJpbmRpbmdzIG9mIE5YUCBMYXllcnNjYXBlIFNvQ3MuDQoNClNpZ25l
ZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQpSZXZpZXdlZC1i
eTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KVjc6DQogLSBObyBjaGFuZ2Uu
DQoNCiAuLi4vYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpZS1nZW40LnR4dCAgICAgfCA1MiAr
KysrKysrKysrKysrKysrKysrDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDggKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
bGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0DQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpZS1nZW40LnR4dCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0DQpu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5iNDBmYjVkMTVkM2QNCi0t
LSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
bGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0DQpAQCAtMCwwICsxLDUyIEBADQorTlhQIExheWVyc2Nh
cGUgUENJZSBHZW40IGNvbnRyb2xsZXINCisNCitUaGlzIFBDSWUgY29udHJvbGxlciBpcyBiYXNl
ZCBvbiB0aGUgTW9iaXZlaWwgUENJZSBJUCBhbmQgdGh1cyBpbmhlcml0cyBhbGwNCit0aGUgY29t
bW9uIHByb3BlcnRpZXMgZGVmaW5lZCBpbiBtb2JpdmVpbC1wY2llLnR4dC4NCisNCitSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KKy0gY29tcGF0aWJsZTogc2hvdWxkIGNvbnRhaW4gdGhlIHBsYXRmb3Jt
IGlkZW50aWZpZXIgc3VjaCBhczoNCisgICJmc2wsbHgyMTYwYS1wY2llIg0KKy0gcmVnOiBiYXNl
IGFkZHJlc3NlcyBhbmQgbGVuZ3RocyBvZiB0aGUgUENJZSBjb250cm9sbGVyIHJlZ2lzdGVyIGJs
b2Nrcy4NCisgICJjc3JfYXhpX3NsYXZlIjogQnJpZGdlIGNvbmZpZyByZWdpc3RlcnMNCisgICJj
b25maWdfYXhpX3NsYXZlIjogUENJZSBjb250cm9sbGVyIHJlZ2lzdGVycw0KKy0gaW50ZXJydXB0
czogQSBsaXN0IG9mIGludGVycnVwdCBvdXRwdXRzIG9mIHRoZSBjb250cm9sbGVyLiBNdXN0IGNv
bnRhaW4gYW4NCisgIGVudHJ5IGZvciBlYWNoIGVudHJ5IGluIHRoZSBpbnRlcnJ1cHQtbmFtZXMg
cHJvcGVydHkuDQorLSBpbnRlcnJ1cHQtbmFtZXM6IEl0IGNvdWxkIGluY2x1ZGUgdGhlIGZvbGxv
d2luZyBlbnRyaWVzOg0KKyAgImludHIiOiBUaGUgaW50ZXJydXB0IHRoYXQgaXMgYXNzZXJ0ZWQg
Zm9yIGNvbnRyb2xsZXIgaW50ZXJydXB0cw0KKyAgImFlciI6IEFzc2VydGVkIGZvciBhZXIgaW50
ZXJydXB0IHdoZW4gY2hpcCBzdXBwb3J0IHRoZSBhZXIgaW50ZXJydXB0IHdpdGgNCisJIG5vbmUg
TVNJL01TSS1YL0lOVHggbW9kZSxidXQgdGhlcmUgaXMgaW50ZXJydXB0IGxpbmUgZm9yIGFlci4N
CisgICJwbWUiOiBBc3NlcnRlZCBmb3IgcG1lIGludGVycnVwdCB3aGVuIGNoaXAgc3VwcG9ydCB0
aGUgcG1lIGludGVycnVwdCB3aXRoDQorCSBub25lIE1TSS9NU0ktWC9JTlR4IG1vZGUsYnV0IHRo
ZXJlIGlzIGludGVycnVwdCBsaW5lIGZvciBwbWUuDQorLSBkbWEtY29oZXJlbnQ6IEluZGljYXRl
cyB0aGF0IHRoZSBoYXJkd2FyZSBJUCBibG9jayBjYW4gZW5zdXJlIHRoZSBjb2hlcmVuY3kNCisg
IG9mIHRoZSBkYXRhIHRyYW5zZmVycmVkIGZyb20vdG8gdGhlIElQIGJsb2NrLiBUaGlzIGNhbiBh
dm9pZCB0aGUgc29mdHdhcmUNCisgIGNhY2hlIGZsdXNoL2ludmFsaWQgYWN0aW9ucywgYW5kIGlt
cHJvdmUgdGhlIHBlcmZvcm1hbmNlIHNpZ25pZmljYW50bHkuDQorLSBtc2ktcGFyZW50IDogU2Vl
IHRoZSBnZW5lcmljIE1TSSBiaW5kaW5nIGRlc2NyaWJlZCBpbg0KKyAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL21zaS50eHQuDQorDQorRXhh
bXBsZToNCisNCisJcGNpZUAzNDAwMDAwIHsNCisJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEt
cGNpZSI7DQorCQlyZWcgPSA8MHgwMCAweDAzNDAwMDAwIDB4MCAweDAwMTAwMDAwICAgLyogY29u
dHJvbGxlciByZWdpc3RlcnMgKi8NCisJCSAgICAgICAweDgwIDB4MDAwMDAwMDAgMHgwIDB4MDAw
MDEwMDA+OyAvKiBjb25maWd1cmF0aW9uIHNwYWNlICovDQorCQlyZWctbmFtZXMgPSAiY3NyX2F4
aV9zbGF2ZSIsICJjb25maWdfYXhpX3NsYXZlIjsNCisJCWludGVycnVwdHMgPSA8R0lDX1NQSSAx
MDggSVJRX1RZUEVfTEVWRUxfSElHSD4sIC8qIEFFUiBpbnRlcnJ1cHQgKi8NCisJCQkgICAgIDxH
SUNfU1BJIDEwOCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1FIGludGVycnVwdCAqLw0KKwkJ
CSAgICAgPEdJQ19TUEkgMTA4IElSUV9UWVBFX0xFVkVMX0hJR0g+OyAvKiBjb250cm9sbGVyIGlu
dGVycnVwdCAqLw0KKwkJaW50ZXJydXB0LW5hbWVzID0gImFlciIsICJwbWUiLCAiaW50ciI7DQor
CQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCisJCSNzaXplLWNlbGxzID0gPDI+Ow0KKwkJZGV2aWNl
X3R5cGUgPSAicGNpIjsNCisJCWFwaW8td2lucyA9IDw4PjsNCisJCXBwaW8td2lucyA9IDw4PjsN
CisJCWRtYS1jb2hlcmVudDsNCisJCWJ1cy1yYW5nZSA9IDwweDAgMHhmZj47DQorCQltc2ktcGFy
ZW50ID0gPCZpdHM+Ow0KKwkJcmFuZ2VzID0gPDB4ODIwMDAwMDAgMHgwIDB4NDAwMDAwMDAgMHg4
MCAweDQwMDAwMDAwIDB4MCAweDQwMDAwMDAwPjsNCisJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47
DQorCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAgNz47DQorCQlpbnRlcnJ1cHQtbWFwID0g
PDAwMDAgMCAwIDEgJmdpYyAwIDAgR0lDX1NQSSAxMDkgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQor
CQkJCTwwMDAwIDAgMCAyICZnaWMgMCAwIEdJQ19TUEkgMTEwIElSUV9UWVBFX0xFVkVMX0hJR0g+
LA0KKwkJCQk8MDAwMCAwIDAgMyAmZ2ljIDAgMCBHSUNfU1BJIDExMSBJUlFfVFlQRV9MRVZFTF9I
SUdIPiwNCisJCQkJPDAwMDAgMCAwIDQgJmdpYyAwIDAgR0lDX1NQSSAxMTIgSVJRX1RZUEVfTEVW
RUxfSElHSD47DQorCX07DQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0K
aW5kZXggMmMxY2M2NmQ2MWE5Li4wMzBhOWYzMWRhZGIgMTAwNjQ0DQotLS0gYS9NQUlOVEFJTkVS
Uw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC0xMjA5OCw2ICsxMjA5OCwxNCBAQCBMOglsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCiBTOglNYWludGFpbmVkDQogRjoJZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvKmxheWVyc2NhcGUqDQogDQorUENJIERSSVZFUiBGT1IgTlhQ
IExBWUVSU0NBUEUgR0VONCBDT05UUk9MTEVSDQorTToJSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5I
b3VAbnhwLmNvbT4NCitMOglsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQorTDoJbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQorUzoJTWFpbnRhaW5lZA0KK0Y6CURvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0DQor
RjoJZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpYmVpbC9wY2llLWxheWVyc2NhcGUtZ2VuNC5j
DQorDQogUENJIERSSVZFUiBGT1IgR0VORVJJQyBPRiBIT1NUUw0KIE06CVdpbGwgRGVhY29uIDx3
aWxsQGtlcm5lbC5vcmc+DQogTDoJbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KLS0gDQoyLjE3
LjENCg0K
