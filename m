Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A862B0501
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 13:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgKLMfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 07:35:48 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:52960
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbgKLMfr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 07:35:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka3tl271G2RjvG94x6C/NddUTPsrT4RNGP5dXCcK5KY1wb+F4xkbE7X6vxFHiu5zMq39N2HHVmJGYIY6zqGOJqc4KuY/oQqF0Fqlkzta46vzh0acCqfgrS9s1Fd2oXKqmm2cRQ5vWEAB8T+F5I05xhQQs3yrOnmoz2iyqrTRshynqtl95fiyl5GxqvKRsncQCIURUO12xdnTpme8rwhVGsBwrCVJS5pCdHoEnYAHNJIVlkOyJInbitPWl5AfLLnrkx7f2eyOTnidOcrMeMYod3TTkm6U8XPWBsldyUB3sRf9eoanjfZVOK+RWW8w9F+AqwCs19rroC+X8sl+DJZrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytfhsuLrLHj6h8CL1CLLxT5+seQ3AxEd1gYkUX6WPfc=;
 b=iiZRChYbd9kOHbXCoIz/LxxSzjBH8bkyBjdxOE1Mnsqc+PgMYT6z1e3GtyAr4E3N+8Kdb1EVDp+IrPkYpa9NsAQljHQ+3AZuKKor4xOR2Xxl7n35n+BRojyZK2ZXlhgjThWf9GfrarOTB8xDhNDWiw7roScZQu5gXUQdIyz5CcRUcssuHJSVxwDoulYL1kRHDiZ2Rmj/l96hUr+tGNOlwoIQMczDg/XBy6YX+ehfqfDz50mZ4ZruLE7E2GOPnSshuhLDKr6G118ry0/y26gos/6kci1NkJkPLfX5ut8kwx3STpzS3d0wmLEMXUlMrJX0wFLKu4KNnGrA8583E4nSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytfhsuLrLHj6h8CL1CLLxT5+seQ3AxEd1gYkUX6WPfc=;
 b=OKJsHhPx/q7Sg2hMIVENFdzBkVsva7LuwsqwCOoR8xRWnoXliGy2b6+FpI5EZwlEUHDuxlqRdUyG4mFfOM/wDNAj5+y8uZQh3nZvmoctq6y1JGxYWsvrCmsG4XfmXeQkhK+VD37NCQudVVYj5vt5QiPmvgja0Y/CFq26RR0L/NU=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 12:35:41 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 12:35:41 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Subject: RE: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
Thread-Topic: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
Thread-Index: AQHWtnmf1Fe2qKyugUaToCGM3cma6am/hnbQgABT4wCAAMJmMIAAz6aAgAAKvACAAAwhgIAAtS8ggAIkF4CAAAx8wA==
Date:   Thu, 12 Nov 2020 12:35:40 +0000
Message-ID: <VI1PR04MB496066B27A378F1DA7223C9C92E70@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200930153519.7282-16-kishon@ti.com>
 <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <d6d27475-3464-6772-2122-cc194b8ae022@ti.com>
 <VI1PR04MB49602D24F65E11FF1F14294F92E90@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <30c8f7a1-baa5-1eb4-d2c2-9a13be896f0f@ti.com>
 <CAK8P3a38vBXbAWE09H+TSoZUTkFdYDcQmXX97foT4qXQc8t5ZQ@mail.gmail.com>
 <5a9115c8-322e-ffd4-6274-ae98c375b21d@ti.com>
 <VI1PR04MB496067EB79873EEC9329B9B992E80@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <c3e7cfaa-fda9-46f8-ec9a-b26818bef7b6@ti.com>
In-Reply-To: <c3e7cfaa-fda9-46f8-ec9a-b26818bef7b6@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.106.106.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc3f287f-6f49-4445-1f74-08d88707776b
x-ms-traffictypediagnostic: VI1PR04MB7165:
x-microsoft-antispam-prvs: <VI1PR04MB71655CDD5F5E079482F719F692E70@VI1PR04MB7165.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4ikJ1T8HOqlVR896mUm1DKcK4lIN/kiMKt52MRNmcbkBKGtwgmnj1n9/pI7gD4oySxr0IMGOG3asXIja6FfLhrBJ0QBBNiRkXLNNLIEUQsYNy3t1wsHRTdGOALEejyIBa+UW86mRdTSKntQ1j5eztw7SP9mMfRW0nBq65oreqfaq8Qayo8kGmFbN9kt0A0XTBtRiJiQ0TyV1AC8wSV3WidIKl4jZK9v9SLkyHrCKiDm+e61T4dFrDx36sVQaj6GlAUzZZyC0WBCFcx959C6hXXG+Uxfr3q0nhHYAy/0kk1XCLB9gFA2s+LKPQrzfMEXDBDuBrfhNpdXr1gTFMINiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(6506007)(7416002)(76116006)(316002)(71200400001)(86362001)(66946007)(8936002)(33656002)(66476007)(66446008)(478600001)(52536014)(5660300002)(44832011)(53546011)(64756008)(9686003)(2906002)(7696005)(83380400001)(26005)(54906003)(66556008)(8676002)(55016002)(186003)(110136005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PWGHzrxJGGZ+tw+gWzWREh5haOpiNkFVqQxoBaNUlTtBuTA1WAxsnB37r+6JSEySKeB2iyZPUsUFnPsv5Z0VgSuzDqRo996PalSN/Wv6hDvYp3lwLGONeM1ro9+GSC6rjifIgtusWNWUptyKFalPRcstd73pnBFg5DQ71M56sVzzguSiimix/C7jEDU3OInhTeX8EEAPtDuWFiBwOLzIxHUeP8DX7ManHYLXOMQz34dV+c25/oTHqvFZxzugawfOp8mC9L9x1gDP+RMpK1DMPQQig9yZ1I3HxWN7DX2p0OYutA/nOjFlbMfm5kvIkn5jzmL+Apy05FrkAIkGS6hRW7WBSbk0iH/D4Gp7aVSfqfdPsvX0206PD/QFgLXishVZGzLyWCjcrUVy8J6RKRU5J8C7g9eDcKYT175deRKV4xAATW7kXZ1hGU3zCEFWI9VqRjb0td79yzZ6budgkpVnyxOM76YkkHuTOHzKdj0VW2heFVAgG5NrrEWWTjHTURGrnZmYu9UcCALYujCaB2fhrfrMxbuF4AF1A40sy48V9QNR3nI6c5STRGAv4YdniEXqXvhj6AXKMnL5iLhiVgvSZMCzzM++I++JaW5dMtRuvwYjNN3fTr5VzHzmKzowIalF6qt9FiLYFiJJizex2alOZBS89rtRJ3f+W5D1i+WZzY8cZWRQSt8yRBSc43o13/W6bdGFJz+O1m+J327uhYMPEVXZplADjh5y1UpxJ+l1sqy9WMHBDKOsKIsSGtcgW0yZwENAIUEooUaN0tPZR72KBvg10pj4rZYJLQpzGQmu3cS5TsLWfUH+yO4FgXMUJaOKkq/BCY4eVxVlR29c4myVFjPbSg8FEkzKnmZdB+d1ynYDNrKGEs1QTFu2L4TJ15fvz3EGp/Iu/JCkYFvXPZa3+Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3f287f-6f49-4445-1f74-08d88707776b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 12:35:40.4688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VI6wedwBu05zRHOtx0BBUXn+TpoWNJx+iWZKHDKJAU1OwQ8fMDlCaWoiccK1oquRTtFoD6vPBD7JDD0AF50CSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMTUvMThdIE5UQjogQWRkIHN1
cHBvcnQgZm9yIEVQRiBQQ0ktRXhwcmVzcyBOb24tDQo+IFRyYW5zcGFyZW50IEJyaWRnZQ0KPiAN
Cj4gSGkgU2hlcnJ5LA0KPiANCj4gT24gMTEvMTEvMjAgODoxOSBhbSwgU2hlcnJ5IFN1biB3cm90
ZToNCj4gPiBIaSBLaXNob24sDQo+ID4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAxNS8x
OF0gTlRCOiBBZGQgc3VwcG9ydCBmb3IgRVBGIFBDSS1FeHByZXNzDQo+ID4+IE5vbi0gVHJhbnNw
YXJlbnQgQnJpZGdlDQo+ID4+DQo+ID4+IEhpIFNoZXJyeSwgQXJuZCwNCj4gPj4NCj4gPj4gT24g
MTAvMTEvMjAgODoyOSBwbSwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPj4+IE9uIFR1ZSwgTm92
IDEwLCAyMDIwIGF0IDM6MjAgUE0gS2lzaG9uIFZpamF5IEFicmFoYW0gSQ0KPiA+Pj4gPGtpc2hv
bkB0aS5jb20+DQo+ID4+IHdyb3RlOg0KPiA+Pj4+IE9uIDEwLzExLzIwIDc6NTUgYW0sIFNoZXJy
eSBTdW4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+PiBCdXQgZm9yIFZPUCwgb25seSB0d28gYm9hcmRz
IGFyZSBuZWVkZWQob25lIGJvYXJkIGFzIGhvc3QgYW5kIG9uZQ0KPiA+Pj4+PiBib2FyZCBhcyBj
YXJkKSB0byByZWFsaXplIHRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4gdGhlIHR3bw0KPiA+Pj4+
PiBzeXN0ZW1zLA0KPiA+PiBzbyBteSBxdWVzdGlvbiBpcyB3aGF0IGFyZSB0aGUgYWR2YW50YWdl
cyBvZiB1c2luZyBOVEI/DQo+ID4+Pj4NCj4gPj4+PiBOVEIgaXMgYSBicmlkZ2UgdGhhdCBmYWNp
bGl0YXRlcyBjb21tdW5pY2F0aW9uIGJldHdlZW4gdHdvDQo+ID4+Pj4gZGlmZmVyZW50IHN5c3Rl
bXMuIFNvIGl0IGJ5IGl0c2VsZiB3aWxsIG5vdCBiZSBzb3VyY2Ugb3Igc2luayBvZg0KPiA+Pj4+
IGFueSBkYXRhIHVubGlrZSBhIG5vcm1hbCBFUCB0byBSUCBzeXN0ZW0gKG9yIHRoZSBWT1ApIHdo
aWNoIHdpbGwgYmUNCj4gPj4+PiBzb3VyY2Ugb3Igc2luaw0KPiA+PiBvZiBkYXRhLg0KPiA+Pj4+
DQo+ID4+Pj4+IEJlY2F1c2UgSSB0aGluayB0aGUgYXJjaGl0ZWN0dXJlIG9mIE5UQiBzZWVtcyBt
b3JlIGNvbXBsaWNhdGVkLg0KPiA+Pj4+PiBNYW55DQo+ID4+IHRoYW5rcyENCj4gPj4+Pg0KPiA+
Pj4+IHllYWgsIEkgdGhpbmsgaXQgZW5hYmxlcyBhIGRpZmZlcmVudCB1c2UgY2FzZSBhbGwgdG9n
ZXRoZXIuDQo+ID4+Pj4gQ29uc2lkZXIgeW91IGhhdmUgdHdvIHg4NiBIT1NUIFBDcyAoaGF2aW5n
IFJQKSBhbmQgdGhleSBoYXZlIHRvIGJlDQo+ID4+Pj4gY29tbXVuaWNhdGUgdXNpbmcgUENJZS4g
TlRCIGNhbiBiZSB1c2VkIGluIHN1Y2ggY2FzZXMgZm9yIHRoZSB0d28NCj4gPj4+PiB4ODYgUENz
IHRvIGNvbW11bmljYXRlIHdpdGggZWFjaCBvdGhlciBvdmVyIFBDSWUsIHdoaWNoIHdvdWxkbid0
IGJlDQo+ID4+Pj4gcG9zc2libGUNCj4gPj4gd2l0aG91dCBOVEIuDQo+ID4+Pg0KPiA+Pj4gSSB0
aGluayBmb3IgVk9QLCB3ZSBzaG91bGQgaGF2ZSBhbiBhYnN0cmFjdGlvbiB0aGF0IGNhbiB3b3Jr
IG9uDQo+ID4+PiBlaXRoZXIgTlRCIG9yIGRpcmVjdGx5IG9uIHRoZSBlbmRwb2ludCBmcmFtZXdv
cmsgYnV0IHByb3ZpZGUgYW4NCj4gPj4+IGludGVyZmFjZSB0aGF0IHRoZW4gbGV0cyB5b3UgY3Jl
YXRlIGxvZ2ljYWwgZGV2aWNlcyB0aGUgc2FtZSB3YXkuDQo+ID4+Pg0KPiA+Pj4gRG9pbmcgVk9Q
IGJhc2VkIG9uIE5UQiBwbHVzIHRoZSBuZXcgTlRCX0VQRiBkcml2ZXIgd291bGQgYWxzbyB3b3Jr
DQo+ID4+PiBhbmQganVzdCBtb3ZlIHRoZSBhYnN0cmFjdGlvbiBzb21ld2hlcmUgZWxzZSwgYnV0
IEkgZ3Vlc3MgaXQgd291bGQNCj4gPj4+IGNvbXBsaWNhdGUgc2V0dGluZyBpdCB1cCBmb3IgdGhv
c2UgdXNlcnMgdGhhdCBvbmx5IGNhcmUgYWJvdXQgdGhlDQo+ID4+PiBzaW1wbGVyIGVuZHBvaW50
IGNhc2UuDQo+ID4+DQo+ID4+IEknbSBub3Qgc3VyZSBpZiB5b3UndmUgZ290IGEgY2hhbmNlIHRv
IGxvb2sgYXQgWzFdLCB3aGVyZSBJIGFkZGVkDQo+ID4+IHN1cHBvcnQgZm9yIFJQPC0+RVAgc3lz
dGVtIGJvdGggcnVubmluZyBMaW51eCwgd2l0aCBFUCBjb25maWd1cmVkDQo+ID4+IHVzaW5nIExp
bnV4IEVQIGZyYW1ld29yayAoYXMgd2VsbCBhcyBIT1NUIHBvcnRzIGNvbm5lY3RlZCB0byBOVEIN
Cj4gPj4gc3dpdGNoLCBwYXRjaGVzIDIwIGFuZCAyMSwgdGhhdCB1c2VzIHRoZSBMaW51eCBOVEIg
ZnJhbWV3b3JrKSB0bw0KPiA+PiBjb21tdW5pY2F0ZSB1c2luZyB2aXJ0aW8gb3ZlciBQQ0llLg0K
PiA+Pg0KPiA+DQo+ID4gSSBzYXcgeW91ciBwYXRjaGVzIGF0IFsxXSwgaGVyZSB5b3UgdGFrZSBh
IHJwbXNnIGFzIGFuIGV4YW1wbGUgdG8NCj4gPiBjb21tdW5pY2F0ZSBiZXR3ZWVuIHR3byBTb0Nz
IHVzaW5nIFBDSWUgUkM8LT5FUCBhbmQgSE9TVDEtTlRCLQ0KPiBIT1NUMiBmb3IgZGlmZmVyZW50
IHVzZXJjYXNlcy4NCj4gPiBUaGUgVk9QIGNvZGUgd29ya3MgdW5kZXIgdGhlIFBDSWUgUkM8LT5F
UCBmcmFtZXdvcmssIHdoaWNoIG1lYW5zIHRoYXQNCj4gPiB3ZSBjYW4gYWxzbyBtYWtlIFZPUCB3
b3JrcyB1bmRlciB0aGUgTGludXggTlRCIGZyYW1ld29yaywganVzdCBsaWtlIHRoZQ0KPiBycG1z
ZyB3YXkgeW91IGRpZCBoZXJlLCByaWdodD8NCj4gDQo+IERvZXMgVk9QIHJlYWxseSB3b3JrIHdp
dGggRVAgZnJhbWV3b3JrPyBBdC1sZWFzdCB3aGF0ZXZlciBpcyBpbiB1cHN0cmVhbQ0KPiBkb2Vz
bid0IHNlZW0gdG8gaW5kaWNhdGUgc28uDQo+IA0KDQpXZSBkaWQgd3JpdGUgYSBwY2lfZXBmIGRy
aXZlciB0byBzdXBwb3J0IFZPUCwgbG9va3MgbGlrZSBwY2ktZXBmLXRlc3QuYywgYW5kIGl0IHdv
cmtzIHdlbGwuDQpTbyBjZXJ0YWlubHkgVk9QIGNhbiB3b3JrIHdpdGggRVAgZnJhbWV3b3JrLg0K
QnV0IGl0J3MgYSBwaXR5IHRoYXQgdGhlIFZPUCByZWxhdGVkIGNvZGVzIGhhcyBiZWVuIGRlbGV0
ZWQgYmVmb3JlIHdlIHNlbmQgdGhlIHBjaV9lcGZfdm9wIGRyaXZlciBwYXRjaGVzIHRvIHVwc3Ry
ZWFtLg0KDQo+IFRoZSBOVEIgZnJhbWV3b3JrIGxldHMgb25lIGhvc3Qgd2l0aCBSUCBwb3J0IHRv
IGNvbW11bmljYXRlIHdpdGggYW5vdGhlcg0KPiBob3N0IHdpdGggUlAgcG9ydC4NCj4gDQo+IFRo
ZSBFUCBGcmFtZXdvcmsgbGV0cyBvbmUgZGV2aWNlIHdpdGggRVAgcG9ydCB0byBjb21tdW5pY2F0
ZSB3aXRoIGEgaG9zdA0KPiB3aXRoIFJQIHBvcnQuDQo+IA0KPiBSZXN0IG9mIHRoZSB0cmljayBz
aG91bGQgYmUgaG93IHlvdSB0aWUgdGhlbSB0b2dldGhlci4NCj4gDQo+IFBDSWUgZnJhbWV3b3Jr
IGNyZWF0ZXMgInBjaV9kZXZpY2UiIGZvciBlYWNoIG9mIHRoZSBkZXZpY2VzIGl0IGVudW1lcmF0
ZXMuDQo+IE5UQiBmcmFtZXdvcmsgd29ya3Mgb24gdGhpcyBwY2lfZGV2aWNlIHRvIGNvbW11bmlj
YXRlIHdpdGggdGhlIHJlbW90ZQ0KPiBob3N0IHVzaW5nIFBDSWUgYnJpZGdlLiBUaGUgcmVtb3Rl
IGhvc3Qgd2lsbCB1c2UgTlRCIGZyYW1ld29yayBhcyB3ZWxsLg0KPiANCj4gU28gZGVwZW5kcyBv
biB3aGF0IGludGVyZmFjZXMgVk9QIGRldmljZSBwcm92aWRlcyB5b3UgY2FuIHVzZSBlaXRoZXIg
TlRCDQo+IGZyYW1ld29yayBvciBFUCBmcmFtZXdvcmsuIElmIGl0J3MgZ29pbmcgdG8gY29ubmVj
dCB0d28gZGlmZmVyZW50IGRldmljZXMgaW4NCj4gdHVybiBjcmVhdGluZyBwY2lfZGV2aWNlIG9u
IGVhY2ggb2YgdGhlIHN5c3RlbXMsIHRoZW4geW91IGNhbiB1c2UgTlRCDQo+IGZyYW1ld29yay4N
Cj4gDQoNClRoYW5rcyBmb3IgeW91ciBkZXRhaWxlZCBleHBsYW5hdGlvbiEgSXQgaXMgY2xlYXIu
DQpJIHRoaW5rIG1heWJlIFZPUCBpcyBzdWl0YWJsZSBmb3IgdGhlIGJhc2ljIFBDSWUgZnJhbWV3
b3JrIGluc3RlYWQgb2YgTlRCLg0KDQpCZXN0IHJlZ2FyZHMNClNoZXJyeQ0KDQo+IFJlZ2FyZHMN
Cj4gS2lzaG9uDQo=
