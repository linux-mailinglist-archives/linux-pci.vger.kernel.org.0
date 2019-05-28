Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C02BFA2
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfE1GuY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 02:50:24 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:44259
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727240AbfE1GuX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 May 2019 02:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reQXhSdzXXzSnx7OBELEvMx/Xtj2iiUXJo6auPEr6Hg=;
 b=Xnxc8SBTVFgqEGbqHCkfSS5Gi39FlyviMeqVwPGCui4mwa5UnE5IZ7KsTZyBfRBY5cHaPYrzFMg8YP+r7QUCaCaZdfuVOhST93cnLB9uoWpOPGVuNLnUhaK1LTQPRvExHF6H46s8aJ2p7v9IQ8Bj17krzuktCfxTwRdV+GbXmYI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5495.eurprd04.prod.outlook.com (20.178.93.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 06:50:20 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 06:50:19 +0000
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
Subject: [PATCHv6 3/6] dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4
 controller
Thread-Topic: [PATCHv6 3/6] dt-bindings: PCI: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Index: AQHVFSGduJV+3DUVW0q38Rx/FbLeYw==
Date:   Tue, 28 May 2019 06:50:19 +0000
Message-ID: <20190528065129.8769-4-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 0582dab8-3ac0-4741-1b47-08d6e338bfb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB5495;
x-ms-traffictypediagnostic: AM6PR04MB5495:
x-microsoft-antispam-prvs: <AM6PR04MB5495FCA984CBC68B7E70D889841E0@AM6PR04MB5495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(2501003)(6486002)(86362001)(6116002)(6436002)(66066001)(6512007)(2201001)(386003)(2906002)(53936002)(25786009)(3846002)(7416002)(4326008)(71200400001)(71190400001)(66476007)(54906003)(11346002)(81156014)(73956011)(64756008)(66556008)(50226002)(8676002)(316002)(5660300002)(81166006)(8936002)(110136005)(305945005)(76176011)(102836004)(52116002)(186003)(26005)(36756003)(68736007)(6506007)(7736002)(256004)(446003)(478600001)(486006)(1076003)(99286004)(66946007)(66446008)(2616005)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5495;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q8XszmcMJRs6bz3f8AvBXC4wXC0kwoLfFWHqr3/oOXeGvQZJZHKMD2Gxxop6BOx+w8/rmBJTEEV579yn+sosSFuvZ0ILvmWlXU6W/ZJc05xRNsyXWKG2hjDCQsC8R2f4sQ9rrKrpIEPOQHeqBX5IDCuZtYPux03ckbRRvyYOR6qzItNAc8W9L94klBZjl/0X2jfAORHp9AgLe1HrjwlTklUTGAvM/RudtUjRHz3Ugo8q+Md4sjSNTqC+lZrFi2uwwonGSlJT95kmo6lu3aWNdBUMuhDbmeGYmU4jq1NZKuoQuH2VYtHxOi2CpEHsSu0j3+TCBM9gkMMnbvY60o30lMU55bbFJ30rae4Hd4377evhGP87wnqBS7cAQX2eaftx0tRomtmhLH8yAE2E7MW5BEYehfkZIMNh8r7mhsIeAuw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0582dab8-3ac0-4741-1b47-08d6e338bfb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 06:50:19.8337
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

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KQWRkIFBDSWUgR2Vu
NCBjb250cm9sbGVyIERUIGJpbmRpbmdzIG9mIE5YUCBMYXllcnNjYXBlIFNvQ3MuDQoNClNpZ25l
ZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQpSZXZpZXdlZC1i
eTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KVjY6DQogLSBDaGFuZ2UgdGhl
IGZpbGUgbmFtZSBsYXllcnNjYXBlLXBjaS1nZW40LnR4dCB0byBsYXllcnNjYXBlLXBjaWUtZ2Vu
NC50eHQuDQoNCiAuLi4vYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpZS1nZW40LnR4dCAgICAg
fCA1MiArKysrKysrKysrKysrKysrKysrDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDggKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25z
KCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0DQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpZS1nZW40LnR4dCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQu
dHh0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5iNDBmYjVkMTVk
M2QNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0DQpAQCAtMCwwICsxLDUyIEBADQorTlhQIExh
eWVyc2NhcGUgUENJZSBHZW40IGNvbnRyb2xsZXINCisNCitUaGlzIFBDSWUgY29udHJvbGxlciBp
cyBiYXNlZCBvbiB0aGUgTW9iaXZlaWwgUENJZSBJUCBhbmQgdGh1cyBpbmhlcml0cyBhbGwNCit0
aGUgY29tbW9uIHByb3BlcnRpZXMgZGVmaW5lZCBpbiBtb2JpdmVpbC1wY2llLnR4dC4NCisNCitS
ZXF1aXJlZCBwcm9wZXJ0aWVzOg0KKy0gY29tcGF0aWJsZTogc2hvdWxkIGNvbnRhaW4gdGhlIHBs
YXRmb3JtIGlkZW50aWZpZXIgc3VjaCBhczoNCisgICJmc2wsbHgyMTYwYS1wY2llIg0KKy0gcmVn
OiBiYXNlIGFkZHJlc3NlcyBhbmQgbGVuZ3RocyBvZiB0aGUgUENJZSBjb250cm9sbGVyIHJlZ2lz
dGVyIGJsb2Nrcy4NCisgICJjc3JfYXhpX3NsYXZlIjogQnJpZGdlIGNvbmZpZyByZWdpc3RlcnMN
CisgICJjb25maWdfYXhpX3NsYXZlIjogUENJZSBjb250cm9sbGVyIHJlZ2lzdGVycw0KKy0gaW50
ZXJydXB0czogQSBsaXN0IG9mIGludGVycnVwdCBvdXRwdXRzIG9mIHRoZSBjb250cm9sbGVyLiBN
dXN0IGNvbnRhaW4gYW4NCisgIGVudHJ5IGZvciBlYWNoIGVudHJ5IGluIHRoZSBpbnRlcnJ1cHQt
bmFtZXMgcHJvcGVydHkuDQorLSBpbnRlcnJ1cHQtbmFtZXM6IEl0IGNvdWxkIGluY2x1ZGUgdGhl
IGZvbGxvd2luZyBlbnRyaWVzOg0KKyAgImludHIiOiBUaGUgaW50ZXJydXB0IHRoYXQgaXMgYXNz
ZXJ0ZWQgZm9yIGNvbnRyb2xsZXIgaW50ZXJydXB0cw0KKyAgImFlciI6IEFzc2VydGVkIGZvciBh
ZXIgaW50ZXJydXB0IHdoZW4gY2hpcCBzdXBwb3J0IHRoZSBhZXIgaW50ZXJydXB0IHdpdGgNCisJ
IG5vbmUgTVNJL01TSS1YL0lOVHggbW9kZSxidXQgdGhlcmUgaXMgaW50ZXJydXB0IGxpbmUgZm9y
IGFlci4NCisgICJwbWUiOiBBc3NlcnRlZCBmb3IgcG1lIGludGVycnVwdCB3aGVuIGNoaXAgc3Vw
cG9ydCB0aGUgcG1lIGludGVycnVwdCB3aXRoDQorCSBub25lIE1TSS9NU0ktWC9JTlR4IG1vZGUs
YnV0IHRoZXJlIGlzIGludGVycnVwdCBsaW5lIGZvciBwbWUuDQorLSBkbWEtY29oZXJlbnQ6IElu
ZGljYXRlcyB0aGF0IHRoZSBoYXJkd2FyZSBJUCBibG9jayBjYW4gZW5zdXJlIHRoZSBjb2hlcmVu
Y3kNCisgIG9mIHRoZSBkYXRhIHRyYW5zZmVycmVkIGZyb20vdG8gdGhlIElQIGJsb2NrLiBUaGlz
IGNhbiBhdm9pZCB0aGUgc29mdHdhcmUNCisgIGNhY2hlIGZsdXNoL2ludmFsaWQgYWN0aW9ucywg
YW5kIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlIHNpZ25pZmljYW50bHkuDQorLSBtc2ktcGFyZW50
IDogU2VlIHRoZSBnZW5lcmljIE1TSSBiaW5kaW5nIGRlc2NyaWJlZCBpbg0KKyAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL21zaS50eHQuDQor
DQorRXhhbXBsZToNCisNCisJcGNpZUAzNDAwMDAwIHsNCisJCWNvbXBhdGlibGUgPSAiZnNsLGx4
MjE2MGEtcGNpZSI7DQorCQlyZWcgPSA8MHgwMCAweDAzNDAwMDAwIDB4MCAweDAwMTAwMDAwICAg
LyogY29udHJvbGxlciByZWdpc3RlcnMgKi8NCisJCSAgICAgICAweDgwIDB4MDAwMDAwMDAgMHgw
IDB4MDAwMDEwMDA+OyAvKiBjb25maWd1cmF0aW9uIHNwYWNlICovDQorCQlyZWctbmFtZXMgPSAi
Y3NyX2F4aV9zbGF2ZSIsICJjb25maWdfYXhpX3NsYXZlIjsNCisJCWludGVycnVwdHMgPSA8R0lD
X1NQSSAxMDggSVJRX1RZUEVfTEVWRUxfSElHSD4sIC8qIEFFUiBpbnRlcnJ1cHQgKi8NCisJCQkg
ICAgIDxHSUNfU1BJIDEwOCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1FIGludGVycnVwdCAq
Lw0KKwkJCSAgICAgPEdJQ19TUEkgMTA4IElSUV9UWVBFX0xFVkVMX0hJR0g+OyAvKiBjb250cm9s
bGVyIGludGVycnVwdCAqLw0KKwkJaW50ZXJydXB0LW5hbWVzID0gImFlciIsICJwbWUiLCAiaW50
ciI7DQorCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCisJCSNzaXplLWNlbGxzID0gPDI+Ow0KKwkJ
ZGV2aWNlX3R5cGUgPSAicGNpIjsNCisJCWFwaW8td2lucyA9IDw4PjsNCisJCXBwaW8td2lucyA9
IDw4PjsNCisJCWRtYS1jb2hlcmVudDsNCisJCWJ1cy1yYW5nZSA9IDwweDAgMHhmZj47DQorCQlt
c2ktcGFyZW50ID0gPCZpdHM+Ow0KKwkJcmFuZ2VzID0gPDB4ODIwMDAwMDAgMHgwIDB4NDAwMDAw
MDAgMHg4MCAweDQwMDAwMDAwIDB4MCAweDQwMDAwMDAwPjsNCisJCSNpbnRlcnJ1cHQtY2VsbHMg
PSA8MT47DQorCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAgNz47DQorCQlpbnRlcnJ1cHQt
bWFwID0gPDAwMDAgMCAwIDEgJmdpYyAwIDAgR0lDX1NQSSAxMDkgSVJRX1RZUEVfTEVWRUxfSElH
SD4sDQorCQkJCTwwMDAwIDAgMCAyICZnaWMgMCAwIEdJQ19TUEkgMTEwIElSUV9UWVBFX0xFVkVM
X0hJR0g+LA0KKwkJCQk8MDAwMCAwIDAgMyAmZ2ljIDAgMCBHSUNfU1BJIDExMSBJUlFfVFlQRV9M
RVZFTF9ISUdIPiwNCisJCQkJPDAwMDAgMCAwIDQgJmdpYyAwIDAgR0lDX1NQSSAxMTIgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQorCX07DQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJ
TkVSUw0KaW5kZXggYzA2NjEyOGQ2OWVjLi43MjVhNTg5NTNlZTEgMTAwNjQ0DQotLS0gYS9NQUlO
VEFJTkVSUw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC0xMjAyMCw2ICsxMjAyMCwxNCBAQCBMOgls
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCiBTOglNYWludGFpbmVkDQogRjoJ
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvKmxheWVyc2NhcGUqDQogDQorUENJIERSSVZFUiBG
T1IgTlhQIExBWUVSU0NBUEUgR0VONCBDT05UUk9MTEVSDQorTToJSG91IFpoaXFpYW5nIDxaaGlx
aWFuZy5Ib3VAbnhwLmNvbT4NCitMOglsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQorTDoJbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQorUzoJTWFpbnRhaW5lZA0KK0Y6CURv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQu
dHh0DQorRjoJZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpYmVpbC9wY2llLWxheWVyc2NhcGUt
Z2VuNC5jDQorDQogUENJIERSSVZFUiBGT1IgR0VORVJJQyBPRiBIT1NUUw0KIE06CVdpbGwgRGVh
Y29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPg0KIEw6CWxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcN
Ci0tIA0KMi4xNy4xDQoNCg==
