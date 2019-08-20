Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCA9523E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 02:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfHTAMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 20:12:36 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:4867
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728578AbfHTAMg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 20:12:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSPCnFReE4+AJjoKyMVXs3ae+MffJ8yER09hiQSprhq8s7Z/V/ABxpb4+jpUnlc2XnVGReCbMWZ2ponFKuftkzFcbj/9FOAi7Ti1APthJBW+uoNP4kFzApfrA8EyAxqS/hSc9gGfDAkDeoMM/2IJ+eRqULJHtTb5LCOx+2ZuaKaHamrwhF6tC9qafjO7taLM6DKjRpU3o80OPh6p6cA55xJMuFAi1sHa3EsP+qyE95J/+hy3XuPhqPnSE3ZgsYGgS6U6xJX/c7ohb0xQNbQmNnMhvDwzEVsfoY0C6DENrLdBOIAKBisfVf7i52sWxhmEtPjZ7tybHWYjaumIJ/p48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h76v2Zio3XErqu3h+21ky1WoF9S/mw2he7TlAkhGg8k=;
 b=IrdtRijx++iGpW7GTN0CAnrNdRbJ5YUC9/sYXM0rdo/NLatgbloDq0plnpCs+4yxAg4afkhUtD66SZUZfB1z5+TOhf5OlGeFrUFqFUoySF+bVfalpuKXBLAXuh8WVcT1iKb0XsDAThqBtMDy/CExbQWBB+FElNGVLwABQIOX+T5GBeasJbT7AGVxZ4VEwl3Jb/66IRICfCSgkvYmXE3G8aZrcCuzOJMoppUQdTv+B8sqIRd5ujSAkQJb5u+S1ChqS7jnBdL1xLZbQ/gXmDdhepqOZ98+GsQZt7RWUkEsLtNlpZ2lkCzqQ/oe76fNUuiXbYlta2fyEZKOsca4PWX6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h76v2Zio3XErqu3h+21ky1WoF9S/mw2he7TlAkhGg8k=;
 b=L1FDURoMtL1U+A/eBT/ZOKmuRGwt7G9JcSAqHJ5fC0b5vOcofE4nz9qBbMa1EY065DG/hA1TPIsBS9kURlawvIulMAcK1XkNdNnhWvdL5kKMiBMKgo6RVNtcyb9fZZBrlSoiKPDxpioCu7V/dmrqAJSr96sVHhrRrbAePJXXxJs=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6588.eurprd04.prod.outlook.com (20.179.250.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 00:12:31 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 00:12:31 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH 3/4] ARM: dts: ls1021a: Remove num-lanes property from
 PCIe nodes
Thread-Topic: [PATCH 3/4] ARM: dts: ls1021a: Remove num-lanes property from
 PCIe nodes
Thread-Index: AQHVUMWMZFwmX+djskari+UjmO8phacC5fIAgABNL6A=
Date:   Tue, 20 Aug 2019 00:12:31 +0000
Message-ID: <DB8PR04MB6747FDA7787D986D5FB851E384AB0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-4-Zhiqiang.Hou@nxp.com>
 <20190819192440.GT253360@google.com>
In-Reply-To: <20190819192440.GT253360@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [120.244.121.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d63d174-050e-4f16-405d-08d725031819
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6588;
x-ms-traffictypediagnostic: DB8PR04MB6588:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB65881FC7C9E5D44EBAF44BC484AB0@DB8PR04MB6588.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(13464003)(55016002)(25786009)(9686003)(4326008)(66066001)(486006)(229853002)(53936002)(316002)(6436002)(6246003)(476003)(5660300002)(256004)(33656002)(14444005)(3846002)(6116002)(102836004)(99286004)(8676002)(66446008)(64756008)(66556008)(66476007)(7416002)(14454004)(7736002)(66946007)(71200400001)(71190400001)(6506007)(74316002)(53546011)(305945005)(7696005)(478600001)(76176011)(8936002)(6916009)(26005)(11346002)(86362001)(54906003)(446003)(186003)(2906002)(52536014)(76116006)(81166006)(81156014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6588;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qEfEoVJ65i93YmPOaqXBrPRqU5TdPtFlnJf/GuhfZT6L4UHmQVm126Nfk8tbiGTl6M3vyul8vsMDhhgSeskZdzKLPfYmRV0J5uLVoAxwfPWsVMVdI8LRBQ6/kaaXMYIdGb3+j7l30/4BA+IFJRFCvF1bgJl2++wP90oAaa7f69vPMsIR6TPqacqlvsq+RB3E26yGLNOnY/rbGahqFfwzb7zuJnauyZw1NbkgZfovq92OlEc0nhQ6jANE5swYv7J0hfHLJtt5TdtwlHjfrEfbfeecHi9xJtF/V43iV5Ssn/68UdAHuexi8x22Wb8H317LGT8MKekNyjYDP61KJY3/wlONDCRgcfUl6mgG+1m7ASoUIPWEo+EcUBBtAr2WlTgF1md8kM7jqOSWUVUwMueujSs8W5GLFY5ubPlT3AW8Q6c=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d63d174-050e-4f16-405d-08d725031819
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 00:12:31.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBRiE7gSiZsLTcAF9DvJqc8vprW9iTjlD/9skGEcOUe/hkUmKdrC0tfjsTPHP5nThiczdHUhKrFBV5aBToKCgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6588
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE5xOo41MIyMMjVIDM6MjUNCj4gVG86IFoucS4gSG91
IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbTsNCj4gamluZ29vaGFuMUBnbWFpbC5j
b207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4gbG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbTsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMy80XSBBUk06IGR0czogbHMxMDIxYTogUmVtb3ZlIG51bS1sYW5lcyBw
cm9wZXJ0eQ0KPiBmcm9tIFBDSWUgbm9kZXMNCj4gDQo+IE9uIE1vbiwgQXVnIDEyLCAyMDE5IGF0
IDA0OjIyOjI3QU0gKzAwMDAsIFoucS4gSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFu
ZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBPbiBGU0wgTGF5ZXJzY2FwZSBTb0Nz
LCB0aGUgbnVtYmVyIG9mIGxhbmVzIGFzc2lnbmVkIHRvIFBDSWUNCj4gPiBjb250cm9sbGVyIGlz
IG5vdCBmaXhlZCwgaXQgaXMgZGV0ZXJtaW5lZCBieSB0aGUgc2VsZWN0ZWQgU2VyRGVzDQo+ID4g
cHJvdG9jb2wgaW4gdGhlIFJDVyAoUmVzZXQgQ29uZmlndXJhdGlvbiBXb3JkKSwgYW5kIHRoZSBQ
Q0llIGxpbmsNCj4gPiB0cmFpbmluZyBpcyBjb21wbGV0ZWQgYXV0b21hdGljYWxseSBiYXNlIG9u
IHRoZSBzZWxlY3RlZCBTZXJEZXMNCj4gPiBwcm90b2NvbCwgYW5kIHRoZSBsaW5rIHdpZHRoIHNl
dC11cCBpcyB1cGRhdGVkIGJ5IGhhcmR3YXJlLiBTbyB0aGUNCj4gPiBudW0tbGFuZXMgaXMgbm90
IG5lZWRlZCB0byBzcGVjaWZ5IHRoZSBsaW5rIHdpZHRoLg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQg
bnVtLWxhbmVzIGluZGljYXRlcyB0aGUgbWF4IGxhbmVzIFBDSWUgY29udHJvbGxlciBjYW4NCj4g
PiBzdXBwb3J0IHVwIHRvLCBpbnN0ZWFkIG9mIHRoZSBsYW5lcyBhc3NpZ25lZCB0byB0aGUgUENJ
ZSBjb250cm9sbGVyLg0KPiA+IFRoaXMgY2FuIHJlc3VsdCBpbiBQQ0llIGxpbmsgdHJhaW5pbmcg
ZmFpbCBhZnRlciBob3QtcmVzZXQuIFNvIHJlbW92ZQ0KPiA+IHRoZSBudW0tbGFuZXMgdG8gYXZv
aWQgc2V0LXVwIHRvIGluY29ycmVjdCBsaW5rIHdpZHRoLg0KPiANCj4gSXQgd291bGQgYmUgdXNl
ZnVsIHRvIGV4cGxhaW4gKndoeSogIm51bS1sYW5lcyIgaW4gRFQgY2F1c2VzIGEgbGluayB0cmFp
bmluZw0KPiBmYWlsdXJlLiAgTWF5YmUgdGhlIGNvZGUgcHJvZ3JhbXMgIm51bS1sYW5lcyIgc29t
ZXdoZXJlLCBvdmVycmlkaW5nIHdoYXQNCj4gaGFyZHdhcmUgYXV0b21hdGljYWxseSBzZW5zZWQ/
ICBNYXliZSB0aGUgY29kZSB0cmllcyB0byBicmluZyB1cCBleGFjdGx5DQo+ICJudW0tbGFuZXMi
IGxhbmVzIGV2ZW4gaWYgbm90IGFsbCBhcmUgcHJlc2VudD8NCg0KV2lsbCBhZGQgaW4gdjIuDQpB
cyB0aGUgTGF5ZXJzY2FwZSBQQ0llIGNvbnRyb2xsZXIgbGluayB0cmFpbmluZyBpcyBjb21wbGV0
ZWQgYXV0b21hdGljYWxseSBkdXJpbmcNCnRoZSBwb3dlciBvbiByZXNldC4gSXQgZG9lc24ndCBu
ZWVkIHNvZnR3YXJlIHRvIGJyaW5nIHVwLiBTbyBJIHRoaW5rIGl0IHNob3VsZCBiZSB0aGUNCmZv
cm1lci4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlx
aWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2xzMTAyMWEuZHRzaSB8IDIgLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIxYS5kdHNp
DQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9sczEwMjFhLmR0c2kgaW5kZXggNDY0ZGY0MjkwZmZj
Li4yZjY5NzdhZGE0NDcNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9s
czEwMjFhLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sczEwMjFhLmR0c2kNCj4g
PiBAQCAtODc0LDcgKzg3NCw2IEBADQo+ID4gIAkJCSNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KPiA+
ICAJCQkjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiAgCQkJZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4g
PiAtCQkJbnVtLWxhbmVzID0gPDQ+Ow0KPiA+ICAJCQludW0tdmlld3BvcnQgPSA8Nj47DQo+ID4g
IAkJCWJ1cy1yYW5nZSA9IDwweDAgMHhmZj47DQo+ID4gIAkJCXJhbmdlcyA9IDwweDgxMDAwMDAw
IDB4MCAweDAwMDAwMDAwIDB4NDAgMHgwMDAxMDAwMCAweDANCj4gMHgwMDAxMDAwMCAgIC8qIGRv
d25zdHJlYW0gSS9PICovDQo+ID4gQEAgLTg5OSw3ICs4OTgsNiBAQA0KPiA+ICAJCQkjYWRkcmVz
cy1jZWxscyA9IDwzPjsNCj4gPiAgCQkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gIAkJCWRldmlj
ZV90eXBlID0gInBjaSI7DQo+ID4gLQkJCW51bS1sYW5lcyA9IDw0PjsNCj4gPiAgCQkJbnVtLXZp
ZXdwb3J0ID0gPDY+Ow0KPiA+ICAJCQlidXMtcmFuZ2UgPSA8MHgwIDB4ZmY+Ow0KPiA+ICAJCQly
YW5nZXMgPSA8MHg4MTAwMDAwMCAweDAgMHgwMDAwMDAwMCAweDQ4IDB4MDAwMTAwMDAgMHgwDQo+
IDB4MDAwMTAwMDAgICAvKiBkb3duc3RyZWFtIEkvTyAqLw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+
ID4NCg==
