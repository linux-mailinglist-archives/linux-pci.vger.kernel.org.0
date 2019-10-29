Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665B0E874C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 12:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfJ2Li2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 07:38:28 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:15045
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfJ2Li2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 07:38:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3n02fkZwmZS8QbXM3M/gJXetZ3N7fEbDl30mFVNOOjfVnoQpSQVC659HBQKWNfkqQwXDSYGV6r01XE1ui1hELlflJLqrWsrqHD81bZpPL55ri4qFk59lnx5/z31AwlFVUGzglfimFjZ7WxEuV3UpHheSp7FcxzwvLdqSHZwFXDRl7SbIAn6QwOOBLlETMbbe4hY0nmLm869SqrkccIGx+VrOnKr+NvZm0cJpH+nnHQ8WObgyzU5W+JfQY6lqXkU82zRz+UPLR+1iTWaRELsoD4bd0BoJ5hWINLihNaz4/aZPvLWI2gHQfDmbdnw7pVWI7G0hrXctm6z1wRZejKuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umu+H05qPNmF5LXZsLaFuNkd9fe/JwJzfRUVH5xM0rI=;
 b=fJoVBaMKvKIt42BicDTWxi3CgOUHssErGR1v118xpik3VOy+AOq9H9YIy0YfrfuCLm/oXz5WAuxaxHnQc5cxofjQ+AKp/vsRpi4pnsNz9JkUl09PSRyvVeZHIAQ8551ZDZA/IFObmDMWA7vtpwZtRcrKpW1DNlab6Enk5bi5u0VRQoki9AuF4C3gYQCmj+lQ2qQeQxmsKsf6A2oi37P6NxLFGmSdbBLafB0rIa5Ali9TThQzy7rMh6sZ+NVHP7ZLYYsI7UUk3ysS2osO7Bt06/SkznVyAWunQEi0Fm3S8289467TPrJCKjPZgzyE/k0o4OPHEdVlInuZ5p1Bayboug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umu+H05qPNmF5LXZsLaFuNkd9fe/JwJzfRUVH5xM0rI=;
 b=jPrsDVV53eEmcYVgN9A9vQSS74D/mWSbNKQ+6JgqkHiIeRQmr4/BKjzGn9YqDW1jqJM43ZuOfMoufKUw+P74ItxJXvCkDjMRkNx29H9Vwkwrax7pOBBWLoqyfBTRqMjOb5zMtErQkjjSwT295TzQK3y010HjbeqCx/XjmT2jw70=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6971.eurprd04.prod.outlook.com (52.133.240.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Tue, 29 Oct 2019 11:38:22 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::f54f:12e3:3d7c:167b]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::f54f:12e3:3d7c:167b%3]) with mapi id 15.20.2367.031; Tue, 29 Oct 2019
 11:38:22 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Mobiveil legacy IRQ binding erroneous interrupt-map
Thread-Topic: Mobiveil legacy IRQ binding erroneous interrupt-map
Thread-Index: AQHVhAzztyV80rOdUEeX01X1c1IXDqdxj21w
Date:   Tue, 29 Oct 2019 11:38:22 +0000
Message-ID: <DB8PR04MB67470C5AD54BC91BA5E2294F84610@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191016103156.GC22848@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191016103156.GC22848@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d7e4dc8-1c20-4fed-d168-08d75c648119
x-ms-traffictypediagnostic: DB8PR04MB6971:
x-microsoft-antispam-prvs: <DB8PR04MB697148EE409EF1F85DB7481D84610@DB8PR04MB6971.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(13464003)(99286004)(7696005)(86362001)(6506007)(53546011)(102836004)(71190400001)(256004)(14444005)(71200400001)(498600001)(8676002)(186003)(110136005)(8936002)(81156014)(81166006)(486006)(26005)(476003)(446003)(11346002)(4326008)(6246003)(55016002)(66066001)(9686003)(66476007)(66556008)(64756008)(33656002)(52536014)(66446008)(6436002)(229853002)(2906002)(7736002)(25786009)(76176011)(305945005)(74316002)(3846002)(76116006)(5660300002)(14454004)(6116002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6971;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0Shi7SU4ehBw2F+2DjqOIr62te3NEdAYSVWo4Cov2qZua7E0ZYEkASxsYK/heMV/6/m84hsF1ZDxviGqLSvXVIZZCNMx67TS7ZPfQlfQP796p/Mxck8GvkvMAK+e0a2CzytCupjCejqGob7OpUV38uUyCJt46AfwR8AkiqtEq3aPm6H/rxbrwksP1I676XQJbAfu0rmBhnHBcdJEDe09pZLm+XEvdv1LY6NIDNvAKubt87NyIx4QUxLdZsViLpmhxvoQ9GT45+UkRYeBQebl86WOdiU9P26CsFm6mcT+sn9Eu9E/g7B9nPUdzJYyD0MXuCYFUuEdAS+mX1Mvxic8Gs/pAW3hw/DZYphJd+CC5HGfoIcVCYN6Udr7Gdoo1B/Tsod+kKOrl6zX3pooGc426qj0816V0V07JwAEjpxJdKyWIvqOKc2cZSut/dVT19T
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7e4dc8-1c20-4fed-d168-08d75c648119
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:38:22.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyCT3QFUvdShEv8mK2J0oIJNGT/XiOj/k1Vr8yQmRQFxvOiaA528icDzMpNQLe/PPtmi9QEO0N5ixBTrEIW4YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhlIE1vYml2ZWlsIElOVHggY29udHJvbGxlciBpcyBub3QgdXNlZCBv
biBOWFAncyBwbGF0Zm9ybSwgc28gSSBjYW5ub3QgdmVyaWZ5IHRoaXMgZmVhdHVyZS4gDQoNCkth
cnRoaWtleWFuLCBwbGVhc2UgaGF2ZSBhIGxvb2sgb24gdGhpcyBpc3N1ZS4NCg0KVGhhbmtzLA0K
WmhpcWlhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jlbnpv
IFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAxOcTqMTDU
wjE2yNUgMTg6MzINCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IEthcnRo
aWtleWFuIE1pdHJhbg0KPiA8bS5rYXJ0aGlrZXlhbkBtb2JpdmVpbC5jby5pbj4NCj4gQ2M6IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogTW9iaXZlaWwgbGVnYWN5IElSUSBi
aW5kaW5nIGVycm9uZW91cyBpbnRlcnJ1cHQtbWFwDQo+IA0KPiBIaSBIb3UsIEthcnRoaWtleWFu
LA0KPiANCj4gSSBoYXZlIGp1c3Qgbm90aWNlZCB0aGUgbW9iaXZlaWwgaW50ZXJydXB0LW1hcCBE
VCBiaW5kaW5ncyBleGFtcGxlIGlzIHdyb25nOg0KPiANCj4gVGhpczoNCj4gDQo+IGludGVycnVw
dC1tYXAgPSA8MCAwIDAgMCAmcGNpX2V4cHJlc3MgMD4sDQo+IAkJPDAgMCAwIDEgJnBjaV9leHBy
ZXNzIDE+LA0KPiAJCTwwIDAgMCAyICZwY2lfZXhwcmVzcyAyPiwNCj4gCQk8MCAwIDAgMyAmcGNp
X2V4cHJlc3MgMz47DQo+IA0KPiBzaG91bGQgYmU6DQo+IA0KPiBpbnRlcnJ1cHQtbWFwID0gPDAg
MCAwIDEgJnBjaV9leHByZXNzIDA+LA0KPiAJCTwwIDAgMCAyICZwY2lfZXhwcmVzcyAxPiwNCj4g
CQk8MCAwIDAgMyAmcGNpX2V4cHJlc3MgMj4sDQo+IAkJPDAgMCAwIDQgJnBjaV9leHByZXNzIDM+
Ow0KPiANCj4gTGVnYWN5IElSUXMgSW50ZXJydXB0IHBpbnMgbWFwIHRoaXMgd2F5Og0KPiANCj4g
e3sxLCBJTlRBfSwgezIsIElOVEJ9LCB7MyxJTlRDfSwgezQsSU5URH19DQo+IA0KPiAoYXMgcmVh
ZCBmcm9tIEludGVycnVwdCBwaW4gcmVnaXN0ZXIgaW4gdGhlIGNvbmZpZyBzcGFjZSBoZWFkZXIp
IChpZSByZWZlciB0bw0KPiBQQ0kgbG9jYWwgYnVzIHNwZWNpZmljYXRpb24gMy4wKSwgcGxlYXNl
IGZpeCBpdCBhcyBzb29uIGFzIHBvc3NpYmxlLg0KPiANCj4gTG9yZW56bw0K
