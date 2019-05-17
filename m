Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04A21A3F
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfEQPD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 11:03:26 -0400
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:29406
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728935AbfEQPD0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 May 2019 11:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNsFE7PAtvgqcnEtVfF85OrfLmcAwGRn7cKRhvWbV/4=;
 b=HQYwjFfKyTK7TuRB3GM7dWx3DzkSOnBhULeJirc2jBpYLKTk+71X0G/+wqTKHDFQIdLAUo1M9+NwN8No9GbJ2PPXWFHRX4hTHkRcz+HaNmrseA+Xtb9t6Zm7ZMazh93xL8Fnyk8mxtXWHmyViXZIdB9tz78lHSkn2SU226zaaEU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6296.eurprd04.prod.outlook.com (20.179.18.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 15:03:19 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::6491:59e7:6b25:2993%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 15:03:19 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Karthikeyan M <m.karthikeyan@mobiveil.co.in>
CC:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH 1/1] PCI: mobiveil: Update maintainers list
Thread-Topic: [PATCH 1/1] PCI: mobiveil: Update maintainers list
Thread-Index: AQHVBzcF8JsFww2OMEuvH6tu4ID8QqZkjm2AgArj3QA=
Date:   Fri, 17 May 2019 15:03:19 +0000
Message-ID: <AM6PR04MB57818B273DB942376CBE5E72840B0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20190510134811.GG235064@google.com> <20190510163551.GH235064@google.com>
In-Reply-To: <20190510163551.GH235064@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d4346ef-a1ee-4d20-1f63-08d6dad8cc31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6296;
x-ms-traffictypediagnostic: AM6PR04MB6296:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR04MB6296A064E0489EA35688F0A5840B0@AM6PR04MB6296.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(13464003)(53936002)(486006)(476003)(11346002)(6436002)(8936002)(14454004)(446003)(81166006)(81156014)(86362001)(8676002)(6246003)(66066001)(186003)(66946007)(110136005)(9686003)(54906003)(15650500001)(316002)(73956011)(6306002)(66476007)(76116006)(71200400001)(71190400001)(99286004)(102836004)(66446008)(256004)(68736007)(55016002)(33656002)(4326008)(53546011)(6506007)(2906002)(5660300002)(7696005)(478600001)(64756008)(14444005)(52536014)(76176011)(305945005)(25786009)(6116002)(3846002)(66556008)(26005)(7736002)(229853002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6296;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7fQb5IMslNpAf80UxLvM2gOAo9ttIig9sU10GQZqcjgIz9fKYrWGgxlua8hWd/NPuXnc3EH6yk40VwOhqaJFYVak/Uohg3whGV/N62B5vau57ABi3a+fDFisuUD0kMQxUvrKkRcfSpw4Qn1YrTmtENYK/A2fyNFCPCYsiTBsdRKa+0zc0TIhtnrE0HqZ3OZRKxOPoNNAYIktTNyUVqEeJ6eWALCmcp3vi7Ktjwjurh9UMFdQn7MWym09/ocYbN/E68qQSAATXZqYWXnfLpAwCeDYHp19H97PY483sGYDZjLdn7C0Z+U6zTfTFADqWeZqpaiFjNH23bWkmb4hNLXv2B3NfvXG1aAItQy2pbZIuZM0bHvO8CA0Cx/Tjbn/HoIhj7Z8hEu/tzKdUyDd8T7SyO5vq29LBTbP9xV6l1e77gg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4346ef-a1ee-4d20-1f63-08d6dad8cc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 15:03:19.2056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6296
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvcm4g
SGVsZ2FhcyBbbWFpbHRvOmhlbGdhYXNAa2VybmVsLm9yZ10NCj4gU2VudDogMjAxOcTqNdTCMTHI
1SAwOjM2DQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBLYXJ0aGlrZXlh
biBNDQo+IDxtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluPg0KPiBDYzogU3VicmFobWFueWEg
TGluZ2FwcGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+Ow0KPiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8xXSBQQ0k6IG1vYml2ZWlsOiBVcGRhdGUgbWFpbnRhaW5lcnMgbGlzdA0KPiANCj4g
T24gRnJpLCBNYXkgMTAsIDIwMTkgYXQgMDg6NDg6MTFBTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3
cm90ZToNCj4gPiBPbiBUdWUsIE1heSAwNywgMjAxOSBhdCAwNzo0NToxNkFNIC0wNDAwLCBTdWJy
YWhtYW55YSBMaW5nYXBwYSB3cm90ZToNCj4gPiA+IEFkZCBLYXJ0aGlrZXlhbiBNIGFuZCBaLlEu
IEhvdSBhcyBuZXcgbWFpbnRhaW5lcnMgb2YgTW9iaXZlaWwNCj4gPiA+IGNvbnRyb2xsZXIgZHJp
dmVyLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxs
LnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0KPiA+DQo+ID4gSSdkIGxpa2UgdG8gaW5jbHVk
ZSB0aGlzIEFTQVAgc28gcGF0Y2hlcyBnZXQgc2VudCB0byB0aGUgcmlnaHQgcGxhY2UsDQo+ID4g
YW5kIEkgd2FudCB0byBtYWtlIHN1cmUgd2Ugc3BlbGwgdGhlIG5hbWVzIGFuZCBlbWFpbCBhZGRy
ZXNzZXMNCj4gPiBjb3JyZWN0bHkuDQo+ID4NCj4gPiBaaGlxaWFuZywgeW91IGNvbnNpc3RlbnRs
eSB1c2UgIkhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+Ig0KPiA+IGZvciBzaWdu
LW9mZnMgWzFdIChleGNlcHQgZm9yICJaLnEuIEhvdSIgaW4gZW1haWwgaGVhZGVycykuICBDYW4g
eW91DQo+ID4gYWNrIHRoYXQgdGhlIHVwZGF0ZWQgcGF0Y2ggYmVsb3cgaXMgY29ycmVjdCBmb3Ig
eW91Pw0KPiA+DQo+ID4gS2FydGhpa2V5YW4sIEkgZG9uJ3Qgc2VlIGFueSBlbWFpbCBvciBjb21t
aXRzIGZyb20geW91IHlldCwgc28gSSdkDQo+ID4gcmVhbGx5IGxpa2UgeW91ciBhY2sgYWxvbmcg
d2l0aCB0aGUgY2Fub25pY2FsIG5hbWUvZW1haWwgYWRkcmVzcyB5b3UgcHJlZmVyLg0KPiA+IFRo
ZXJlIGlzIGFub3RoZXIgS2FydGhpa2V5YW4gYWxyZWFkeSBpbiBNQUlOVEFJTkVSUywgc28gaG9w
ZWZ1bGx5IHdlDQo+ID4gY2FuIGF2b2lkIGFueSBjb25mdXNpb24uDQo+ID4NCj4gPiBbMV0gZ2l0
IGxvZyAtLWZvcm1hdD0iJWFuIDwlYWU+IiAtLWF1dGhvcj1bWnpdaGlxaWFuZw0KPiANCj4gSSB3
ZW50IGFoZWFkIGFuZCBhcHBsaWVkIHRoZSBwYXRjaCBiZWxvdyBmb3IgdjUuMiwgYnV0IGlmIHlv
dSB3YW50IHRvIHR3ZWFrDQo+IHRoZSBuYW1lcy9hZGRyZXNzZXMsIEkgY2FuIHVwZGF0ZSB0aGVt
IGlmIHlvdSB0ZWxsIG1lIHNvb24uDQo+DQoNClNvcnJ5IGZvciBteSBkZWxheSByZXBseSwgSSdt
IG9uIHBhdGVybml0eSBsZWF2ZS4NCkl0J3MgT0sgZm9yIG1lLg0KIA0KPiA+IGNvbW1pdCBkMjYw
ZmY4ZDMzNTMNCj4gPiBBdXRob3I6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1hbnlh
QG1vYml2ZWlsLmNvLmluPg0KPiA+IERhdGU6ICAgVHVlIE1heSA3IDA3OjQ1OjE2IDIwMTkgLTA0
MDANCj4gPg0KPiA+ICAgICBNQUlOVEFJTkVSUzogQWRkIEthcnRoaWtleWFuIE0gYW5kIEhvdSBa
aGlxaWFuZyBmb3IgTW9iaXZlaWwgUENJDQo+ID4NCj4gPiAgICAgQWRkIEthcnRoaWtleWFuIE0g
YW5kIEhvdSBaaGlxaWFuZyBhcyBuZXcgbWFpbnRhaW5lcnMgb2YgTW9iaXZlaWwNCj4gPiAgICAg
Y29udHJvbGxlciBkcml2ZXIuDQo+ID4NCj4gPiAgICAgTGluazoNCj4gaHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5r
ZQ0KPiBybmVsLm9yZyUyRmxpbnV4LXBjaSUyRjE1NTcyMjk1MTYtNjg3MC0xLWdpdC1zZW5kLWVt
YWlsLWwuc3VicmFobWFueWElDQo+IDQwbW9iaXZlaWwuY28uaW4mYW1wO2RhdGE9MDIlN0MwMSU3
Q3poaXFpYW5nLmhvdSU0MG54cC5jb20lN0M1YTQ2DQo+IDIzMjlkZDQzNDZiNjRlMzIwOGQ2ZDU2
NTkzM2UlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzDQo+IDUlN0MwJTdDMCU3QzYz
NjkzMTAyOTU3MjI3NTc0MSZhbXA7c2RhdGE9Njg1S09mZkF1Qzd3JTJGVzNCDQo+IE1xZDR6VkFT
ck5zMTVNWHpnOHlCWktsTzJiNCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ICAgICBTaWduZWQtb2Zm
LWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYQ0KPiA8bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5p
bj4NCj4gPiAgICAgW2JoZWxnYWFzOiB1cGRhdGUgbmFtZXMvZW1haWwgYWRkcmVzc2VzIHRvIG1h
dGNoIHVzYWdlIGluIGdpdA0KPiBoaXN0b3J5XQ0KPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBCam9y
biBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL01B
SU5UQUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXgNCj4gPiBlMTdlYmY3MGI1NDguLjQyZDdmNDRj
YzBlMSAxMDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJT
DQo+ID4gQEAgLTExODgwLDcgKzExODgwLDggQEAgRjoJaW5jbHVkZS9saW51eC9zd2l0Y2h0ZWMu
aA0KPiA+ICBGOglkcml2ZXJzL250Yi9ody9tc2NjLw0KPiA+DQo+ID4gIFBDSSBEUklWRVIgRk9S
IE1PQklWRUlMIFBDSUUgSVANCj4gPiAtTToJU3VicmFobWFueWEgTGluZ2FwcGEgPGwuc3VicmFo
bWFueWFAbW9iaXZlaWwuY28uaW4+DQo+ID4gK006CUthcnRoaWtleWFuIE0gPG0ua2FydGhpa2V5
YW5AbW9iaXZlaWwuY28uaW4+DQo+ID4gK006CUhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54
cC5jb20+DQo+ID4gIEw6CWxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAgUzoJU3VwcG9y
dGVkDQo+ID4gIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9iaXZl
aWwtcGNpZS50eHQNCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==
