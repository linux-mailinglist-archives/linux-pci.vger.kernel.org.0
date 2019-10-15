Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E670D71E5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfJOJOQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 05:14:16 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:35141
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfJOJOP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 05:14:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8llyKrigxtpwoPU6szcW+dFgKPWv1o5xOBnOzXLtpEZR0dQXeUV8dU2WDS/Nw3FJAuICFE1l6eKneTeZQWFWHMpUyo4yjH6qK4AeQQKU2I30AK4usLdv4Abaz09FfKAYNo1m/5EoGMF7GTEAvupTSfv+nI8Z10P2n0Fl8uQ72q3nPe/+u5jSWPSiZbAj4RjwxQLxPiRvxZF/rU35qOX92IzczXOyXyrlaDUiv3+bx/CfLU5g7UG1T8v6I3anbNpZnVSOXHuGG705sUprQ3Zwx5bZdFnLYtqCGgwuyqn1v16BxO1GwAPXllF8jEXU5j3xihWmNhEbowI5gSKPGvJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7diOODyDLLCvXdUbZjajPUBx99qde7c4gtZ7fYKMDU=;
 b=dOvxV2rMqUCcenJjf/o2oFsmXqbq1q0f9Qu508iWsI36uRTXLSyUUBQqjZzoSL49vjgZ6id1wvSOFq2fiJ2AT1JvIqmGpf5vAlfzDM6XWQKINMpSL2oLHQAvCq/73OrV7vAwzO+R2PrWR/qtd4yGqTpHEpXH9bidXS4dgfjxg9rl2DDfo04ccV6TFJk9U5JpCW8RrJTF+oD44choFvcR7TVMb8aHr3IWqdwnOf1IbLHRcAA9zhOxMdyx0ImmryjT7daPbE9mcp91kmOYkCeK+AMjW9QXPLRt+1XC7Bic8sIvdaDPngWdBnLX3+0GZVaBFHKAiSAWOxX4o1CHV4Yplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7diOODyDLLCvXdUbZjajPUBx99qde7c4gtZ7fYKMDU=;
 b=cR9j9B2NrjkWL9tfRpGiTqBDiwntA0Pllt+ZSCryPr1VerH7IXyoEoudOLPKqCooK4y7pFmIBiGYvcZNegKck7F//0JnKmcjcnrfygWQGoyNy2dj6WaI/zQA0XbXkcFktMJG5CIAW/Zd/RGx+/KffGtKPiPsfq9PuHRWfVAyXU4=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3156.eurprd04.prod.outlook.com (10.173.255.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Tue, 15 Oct 2019 09:14:00 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::204a:79f8:1bb8:f8a8]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::204a:79f8:1bb8:f8a8%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 09:14:00 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] PCI: mobiveil: Add PCIe Gen4 EP driver for NXP
 Layerscape SoCs
Thread-Topic: [PATCH 3/6] PCI: mobiveil: Add PCIe Gen4 EP driver for NXP
 Layerscape SoCs
Thread-Index: AQHVbDZtqeLEBl0DgU6fWdIbRL3PHKc7FKkAgCBrt/CAABdDAIAAAIug
Date:   Tue, 15 Oct 2019 09:14:00 +0000
Message-ID: <AM5PR04MB3299919E5C4C8A764DB3A656F5930@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
 <20190916021742.22844-4-xiaowei.bao@nxp.com>
 <20190924163850.GY25745@shell.armlinux.org.uk>
 <AM5PR04MB32991D0D69769CE29E0F8DAEF5930@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <20191015090756.GS25745@shell.armlinux.org.uk>
In-Reply-To: <20191015090756.GS25745@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 126c07ce-f4e8-46dc-f761-08d751500404
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM5PR04MB3156:|AM5PR04MB3156:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB3156E0AB96973C8D71D8DE8BF5930@AM5PR04MB3156.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(13464003)(189003)(199004)(476003)(256004)(45080400002)(76116006)(55016002)(6306002)(5660300002)(66476007)(6506007)(66556008)(64756008)(66446008)(25786009)(99286004)(14454004)(6436002)(66946007)(33656002)(7696005)(6246003)(7736002)(9686003)(76176011)(4326008)(478600001)(966005)(71190400001)(71200400001)(305945005)(486006)(44832011)(74316002)(52536014)(6916009)(11346002)(446003)(8936002)(8676002)(81156014)(81166006)(229853002)(66066001)(316002)(7416002)(26005)(86362001)(102836004)(54906003)(53546011)(186003)(6116002)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3156;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6Z0id/n9VEm5iy8b/vDqgVI0spLG6Tz8VDVNzqWkc2bhgYqmizHWg9ApbnJ22wc46TWgEImPW9PGhVQaocWRYV3NsrifJx7T7CkLUcIs3mrfgh+mRM2STLX3Ptbxyu9X/E9bOdao0kT/9InxKIatHJOUt429XFZ2P+YU8F9Vuwxn6MkepmAR9hQ/cLEDWIRSkE7n8l6eMv+yIhzu7pUVz1xtnV4SZWwsno8tGL81byjfWuW0V+rhxeH/PLR5EKp1WQBGrN+NH7Pzruxwl42OmHtd5xG3qy9pjRgS4uieAVWzlCC6Cad97uqM4zFFpRQVB6HDRFd2EHtNSM7jbvLeNhcc8TmhUHVa9vRevhr/fO8pLl+l2lPGlOpeAXdYoZlSSj77vnLPoO4X6DokItjEmUYmPLizKBS2jB893DG7FA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126c07ce-f4e8-46dc-f761-08d751500404
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 09:14:00.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGjxQb95wGGbH6U0WfuUwQGFtddGbw3A4CivYEuD+32E8pnsnMkJSONTr8kkFNyZPSzs7HSKWObO9xNsutbu1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3156
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUnVzc2VsbCBLaW5nIC0g
QVJNIExpbnV4IGFkbWluIDxsaW51eEBhcm1saW51eC5vcmcudWs+DQo+IFNlbnQ6IDIwMTnlubQx
MOaciDE15pelIDE3OjA4DQo+IFRvOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4N
Cj4gQ2M6IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5j
b207DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IExlbyBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29tPjsga2lzaG9uQHRpLmNv
bTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgTS5oLiBMaWFuDQo+IDxtaW5naHVhbi5saWFu
QG54cC5jb20+OyBhbmRyZXcubXVycmF5QGFybS5jb207IE1pbmdrYWkgSHUNCj4gPG1pbmdrYWku
aHVAbnhwLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzZdIFBD
STogbW9iaXZlaWw6IEFkZCBQQ0llIEdlbjQgRVAgZHJpdmVyIGZvciBOWFANCj4gTGF5ZXJzY2Fw
ZSBTb0NzDQo+IA0KPiBPbiBUdWUsIE9jdCAxNSwgMjAxOSBhdCAwNzo0NjoxMkFNICswMDAwLCBY
aWFvd2VpIEJhbyB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IGFkbWluIDxsaW51eEBh
cm1saW51eC5vcmcudWs+DQo+ID4gPiBTZW50OiAyMDE55bm0OeaciDI15pelIDA6MzkNCj4gPiA+
IFRvOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gPiA+IENjOiBaLnEuIEhv
dSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gcm9i
aCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9y
ZzsgTGVvDQo+ID4gPiByb2JoK0xpDQo+ID4gPiA8bGVveWFuZy5saUBueHAuY29tPjsga2lzaG9u
QHRpLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgTS5oLg0KPiA+ID4gTGlhbiA8bWlu
Z2h1YW4ubGlhbkBueHAuY29tPjsgYW5kcmV3Lm11cnJheUBhcm0uY29tOyBNaW5na2FpIEh1DQo+
ID4gPiA8bWluZ2thaS5odUBueHAuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4g
PiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIDMvNl0gUENJOiBtb2JpdmVpbDogQWRkIFBDSWUgR2VuNCBFUCBk
cml2ZXIgZm9yDQo+ID4gPiBOWFAgTGF5ZXJzY2FwZSBTb0NzDQo+ID4gPg0KPiA+ID4gT24gTW9u
LCBTZXAgMTYsIDIwMTkgYXQgMTA6MTc6MzlBTSArMDgwMCwgWGlhb3dlaSBCYW8gd3JvdGU6DQo+
ID4gPiA+IFRoaXMgUENJZSBjb250cm9sbGVyIGlzIGJhc2VkIG9uIHRoZSBNb2JpdmVpbCBHUEVY
IElQLCBpdCB3b3JrIGluDQo+ID4gPiA+IEVQIG1vZGUgaWYgc2VsZWN0IHRoaXMgY29uZmlnIG9w
dGVyYXRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgQmFvIDx4
aWFvd2VpLmJhb0BueHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyDQo+ICsNCj4gPiA+ID4g
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZpZyAgICAgICAgICAgIHwgIDE3
ICsrLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9NYWtlZmlsZSAg
ICAgICAgICAgfCAgIDEgKw0KPiA+ID4gPiAgLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1s
YXllcnNjYXBlLWdlbjQtZXAuYyAgfCAxNTYNCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE3MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKSAgY3JlYXRlIG1vZGUNCj4gPiA+ID4gMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1sYXllcnNjYXBlLWdlbjQtZXAuYw0KPiA+ID4gPg0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleCBiOTk3MDU2Li4wODU4YjU0
DQo+ID4gPiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ID4gPiArKysg
Yi9NQUlOVEFJTkVSUw0KPiA+ID4gPiBAQCAtMTIzNjMsMTEgKzEyMzYzLDEzIEBAIEY6DQo+ID4g
PiAJZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvKmxheWVyc2NhcGUqDQo+ID4gPiA+DQo+ID4g
PiA+ICBQQ0kgRFJJVkVSIEZPUiBOWFAgTEFZRVJTQ0FQRSBHRU40IENPTlRST0xMRVINCj4gPiA+
ID4gIE06CUhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gPiA+ICtNOglY
aWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gPiA+ID4gIEw6CWxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gIEw6CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiA+ID4gPiAgUzoJTWFpbnRhaW5lZA0KPiA+ID4gPiAgRjoJRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaWUtZ2VuNC50eHQNCj4gPiA+
ID4gIEY6CWRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaWJlaWwvcGNpZS1sYXllcnNjYXBlLWdl
bjQuYw0KPiA+ID4gPiArRjoJZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLWxh
eWVyc2NhcGUtZ2VuNC1lcC5jDQo+ID4gPiA+DQo+ID4gPiA+ICBQQ0kgRFJJVkVSIEZPUiBHRU5F
UklDIE9GIEhPU1RTDQo+ID4gPiA+ICBNOglXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPg0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29u
ZmlnDQo+ID4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmlnDQo+
ID4gPiA+IGluZGV4IDIwNTQ5NTAuLjA2OTZiNmUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZpZw0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL21vYml2ZWlsL0tjb25maWcNCj4gPiA+ID4gQEAgLTI3LDEzICsyNywy
NCBAQCBjb25maWcgUENJRV9NT0JJVkVJTF9QTEFUDQo+ID4gPiA+ICAJICBmb3IgYWRkcmVzcyB0
cmFuc2xhdGlvbiBhbmQgaXQgaXMgYSBQQ0llIEdlbjQgSVAuDQo+ID4gPiA+DQo+ID4gPiA+ICBj
b25maWcgUENJRV9MQVlFUlNDQVBFX0dFTjQNCj4gPiA+ID4gLQlib29sICJGcmVlc2NhbGUgTGF5
ZXJzY2FwZSBQQ0llIEdlbjQgY29udHJvbGxlciINCj4gPiA+ID4gKwlib29sICJGcmVlc2NhbGUg
TGF5ZXJzY3BlIFBDSWUgR2VuNCBjb250cm9sbGVyIGluIFJDIG1vZGUiDQo+ID4gPiA+ICAJZGVw
ZW5kcyBvbiBQQ0kNCj4gPiA+ID4gIAlkZXBlbmRzIG9uIE9GICYmIChBUk02NCB8fCBBUkNIX0xB
WUVSU0NBUEUpDQo+ID4gPiA+ICAJZGVwZW5kcyBvbiBQQ0lfTVNJX0lSUV9ET01BSU4NCj4gPiA+
ID4gIAlzZWxlY3QgUENJRV9NT0JJVkVJTF9IT1NUDQo+ID4gPiA+ICAJaGVscA0KPiA+ID4gPiAg
CSAgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCBQQ0llIEdlbjQgY29udHJvbGxlciBzdXBwb3J0IG9u
DQo+ID4gPiA+IC0JICBMYXllcnNjYXBlIFNvQ3MuIFRoZSBQQ0llIGNvbnRyb2xsZXIgY2FuIHdv
cmsgaW4gUkMgb3INCj4gPiA+ID4gLQkgIEVQIG1vZGUgYWNjb3JkaW5nIHRvIFJDV1tIT1NUX0FH
VF9QRVhdIHNldHRpbmcuDQo+ID4gPiA+ICsJICBMYXllcnNjYXBlIFNvQ3MuIEFuZCB0aGUgUENJ
ZSBjb250cm9sbGVyIHdvcmsgaW4gUkMgbW9kZQ0KPiA+ID4gPiArCSAgYnkgc2V0dGluZyB0aGUg
UkNXW0hPU1RfQUdUX1BFWF0gdG8gMC4NCj4gPiA+ID4gKw0KPiA+ID4gPiArY29uZmlnIFBDSUVf
TEFZRVJTQ0FQRV9HRU40X0VQDQo+ID4gPiA+ICsJYm9vbCAiRnJlZXNjYWxlIExheWVyc2NwZSBQ
Q0llIEdlbjQgY29udHJvbGxlciBpbiBFUCBtb2RlIg0KPiA+ID4gPiArCWRlcGVuZHMgb24gUENJ
DQo+ID4gPiA+ICsJZGVwZW5kcyBvbiBPRiAmJiAoQVJNNjQgfHwgQVJDSF9MQVlFUlNDQVBFKQ0K
PiA+ID4gPiArCWRlcGVuZHMgb24gUENJX0VORFBPSU5UDQo+ID4gPiA+ICsJc2VsZWN0IFBDSUVf
TU9CSVZFSUxfRVANCj4gPiA+ID4gKwloZWxwDQo+ID4gPiA+ICsJICBTYXkgWSBoZXJlIGlmIHlv
dSB3YW50IFBDSWUgR2VuNCBjb250cm9sbGVyIHN1cHBvcnQgb24NCj4gPiA+ID4gKwkgIExheWVy
c2NhcGUgU29Dcy4gQW5kIHRoZSBQQ0llIGNvbnRyb2xsZXIgd29yayBpbiBFUCBtb2RlDQo+ID4g
PiA+ICsJICBieSBzZXR0aW5nIHRoZSBSQ1dbSE9TVF9BR1RfUEVYXSB0byAxLg0KPiA+ID4gPiAg
ZW5kbWVudQ0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2Jp
dmVpbC9NYWtlZmlsZQ0KPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwv
TWFrZWZpbGUNCj4gPiA+ID4gaW5kZXggNjg2ZDQxZi4uNmY1NDg1NiAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9NYWtlZmlsZQ0KPiA+ID4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01ha2VmaWxlDQo+ID4gPiA+IEBA
IC00LDMgKzQsNCBAQCBvYmotJChDT05GSUdfUENJRV9NT0JJVkVJTF9IT1NUKSArPQ0KPiA+ID4g
PiBwY2llLW1vYml2ZWlsLWhvc3Qubw0KPiA+ID4gPiAgb2JqLSQoQ09ORklHX1BDSUVfTU9CSVZF
SUxfRVApICs9IHBjaWUtbW9iaXZlaWwtZXAubw0KPiA+ID4gPiAgb2JqLSQoQ09ORklHX1BDSUVf
TU9CSVZFSUxfUExBVCkgKz0gcGNpZS1tb2JpdmVpbC1wbGF0Lm8NCj4gPiA+ID4gIG9iai0kKENP
TkZJR19QQ0lFX0xBWUVSU0NBUEVfR0VONCkgKz0gcGNpZS1sYXllcnNjYXBlLWdlbjQubw0KPiA+
ID4gPiArb2JqLSQoQ09ORklHX1BDSUVfTEFZRVJTQ0FQRV9HRU40X0VQKSArPQ0KPiA+ID4gcGNp
ZS1sYXllcnNjYXBlLWdlbjQtZXAubw0KPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLWxheWVyc2NhcGUtZ2VuNC1lcC5jDQo+
ID4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLWxheWVyc2NhcGUt
Z2VuNC1lcC5jDQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IGluZGV4IDAw
MDAwMDAuLjdiZmVjNTENCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LWVwLmMNCj4g
PiA+ID4gQEAgLTAsMCArMSwxNTYgQEANCj4gPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogUENJZSBjb250cm9sbGVyIEVQ
IGRyaXZlciBmb3IgRnJlZXNjYWxlIExheWVyc2NhcGUgU29Dcw0KPiA+ID4gPiArICoNCj4gPiA+
ID4gKyAqIENvcHlyaWdodCAoQykgMjAxOSBOWFAgU2VtaWNvbmR1Y3Rvci4NCj4gPiA+ID4gKyAq
DQo+ID4gPiA+ICsgKiBBdXRob3I6IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPiAg
Ki8NCj4gPiA+ID4gKw0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+ID4g
PiArI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9w
Y2kuaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+ID4gPiAr
I2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9w
Y2kuaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4gI2luY2x1
ZGUgPGxpbnV4L3Jlc291cmNlLmg+DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNpbmNsdWRlICJwY2ll
LW1vYml2ZWlsLmgiDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNkZWZpbmUgUENJRV9MWDJfQkFSX05V
TQk0DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNkZWZpbmUgdG9fbHNfcGNpZV9nNF9lcCh4KQlkZXZf
Z2V0X2RydmRhdGEoKHgpLT5kZXYpDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0cnVjdCBsc19wY2ll
X2c0X2VwIHsNCj4gPiA+ID4gKwlzdHJ1Y3QgbW9iaXZlaWxfcGNpZQkJKm12X3BjaTsNCj4gPiA+
ID4gK307DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIGxzX3BjaWVfZzRfZXBfb2ZfbWF0Y2hbXSA9IHsNCj4gPiA+ID4gKwl7IC5jb21wYXRpYmxl
ID0gImZzbCxseDIxNjBhLXBjaWUtZXAiLH0sDQo+ID4gPiA+ICsJeyB9LA0KPiA+ID4gPiArfTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1cmVz
IGxzX3BjaWVfZzRfZXBjX2ZlYXR1cmVzID0gew0KPiA+ID4gPiArCS5saW5rdXBfbm90aWZpZXIg
PSBmYWxzZSwNCj4gPiA+ID4gKwkubXNpX2NhcGFibGUgPSB0cnVlLA0KPiA+ID4gPiArCS5tc2l4
X2NhcGFibGUgPSB0cnVlLA0KPiA+ID4gPiArCS5yZXNlcnZlZF9iYXIgPSAoMSA8PCBCQVJfNCkg
fCAoMSA8PCBCQVJfNSksDQo+ID4gPg0KPiA+ID4gCQkJQklUKEJBUl80KSB8IEJJVChCQVJfNSkg
Pw0KPiA+DQo+ID4gSSB0aGluayB1c2UgLnJlc2VydmVkX2JhciA9ICgxIDw8IEJBUl80KSB8ICgx
IDw8IEJBUl81KSwgaXMgYmV0dGVyLA0KPiA+IGJlY2F1c2UgQkFSXzQgaXMgbm90IGEgYml0IG9m
IHJlZ2lzdGVyLg0KPiANCj4gV2h5IGlzIHdoZXRoZXIgaXQncyBhIHJlZ2lzdGVyIG9yIG5vdCBy
ZWxldmVudD8NCg0KTXkgdW5kZXJzdGFuZCBpcyB0aGF0IHRoZSBCSVQgaXMgdXNlZCB0byByZWdp
c3RlciwgcmVmZXIgdG8gb3RoZXIgRVAgZHJpdmVyIGZpbGVzLA0KaXQgYWxzbyB1c2UgMSA8PCBC
QVJfNCBtZXRob2QuDQoNCltiYW94d0B0aXRhbiBjb250cm9sbGVyXSQgZ3JlcCAtciAicmVzZXJ2
ZWRfYmFyIiAqDQpkd2MvcGNpLWtleXN0b25lLmM6ICAgICAucmVzZXJ2ZWRfYmFyID0gMSA8PCBC
QVJfMCB8IDEgPDwgQkFSXzEsDQptb2JpdmVpbC9wY2llLWxheWVyc2NhcGUtZ2VuNC1lcC5jOiAg
ICAgLnJlc2VydmVkX2JhciA9ICgxIDw8IEJBUl80KSB8ICgxIDw8IEJBUl81KSwNCg0KVGhhbmtz
DQpYaWFvd2VpDQoNCj4gDQo+IC0tDQo+IFJNSydzIFBhdGNoIHN5c3RlbToNCj4gaHR0cHM6Ly9l
dXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
d3d3Lg0KPiBhcm1saW51eC5vcmcudWslMkZkZXZlbG9wZXIlMkZwYXRjaGVzJTJGJmFtcDtkYXRh
PTAyJTdDMDElN0N4aWFvDQo+IHdlaS5iYW8lNDBueHAuY29tJTdDMzkyMGQ0NTFmMjhiNDc0ZmY2
NzMwOGQ3NTE0ZjMzNjQlN0M2ODZlYTFkMw0KPiBiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0Mw
JTdDMCU3QzYzNzA2NzI3MjkzNTU2NDM0NyZhbXA7c2RhDQo+IHRhPW13JTJGeUN5SiUyRnBqQzU5
WFdnWWpMazczellRVWR5eTR6WGpKMUIxYlN0Wk9jJTNEJmFtcDtyZXNlcg0KPiB2ZWQ9MA0KPiBG
VFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5lIGluIHN1YnVyYmlhOiBzeW5jIGF0IDEyLjFN
YnBzIGRvd24gNjIya2Jwcw0KPiB1cCBBY2NvcmRpbmcgdG8gc3BlZWR0ZXN0Lm5ldDogMTEuOU1i
cHMgZG93biA1MDBrYnBzIHVwDQo=
