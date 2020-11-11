Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F312AE68F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 03:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgKKCtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 21:49:55 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:38786
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgKKCtz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 21:49:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4G7YvV2FmQWzj49vRXVfiBCgxVzc77lHip5jraTQwuzYIJO1xr3Q/5bD23w7giIdEifNca9dPYgX6dmBxEvfIiriktiWYZQb+7bdsk+11voyTioETTq/SEzd8k2+g6esN4PCxZaGOqsu8DPzhysBRvLJfCezR6yIT2DVEy5p6X2c4yZl9gKa85j3MPUbh0IXspdTV0MROTF7/H0+s1nclH0H92jDs/A1mBFyxyME2KWqR61IDGkKETcCr1z73cMn/S4zQ/jpPhpBA7TpdDhbl/xz0D5L8AT53dEXXGyhPS9GiS6Gn37SnouxL9Zle58s/AvuA/zdV2dS/RW2p0d/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEHs2q6ZI3w1ofByLcfEQkK5WovRYanb5/P9CzU3CTM=;
 b=MivCuOwUqQR4eJoDF68ywdxQ/rmCWbYB02kWkquOOGKZ8A2zsrlkvVLlx7qjAGN8jbEbjMYDtK6uie0wVpcNk6X53hlBWVTziXoQReqVkrHYjTEyuBZVbTZm6CnTFzfytBzhSTlLulfXAVXl4olYOOjpHn1w1mJqX8zyyDU9Djx2ghYKP8oJwZNONJsR85pORSVeamrn3E+7jeajyi2WYK9sEzejkJBvU4uliwEgFjE5Lv+/mLihjx/gWTxnQRtNpx/M0R4mhQEpu13E8aumQI2/A+MEyyXvLodY8R8jWiZ5MOzKFJoltg8NlE7+mck3xpqoikHrglC1Pr6wSWMCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEHs2q6ZI3w1ofByLcfEQkK5WovRYanb5/P9CzU3CTM=;
 b=S06+m5a7+iPhQpjQ3jUfPyQVSiFBe4k1WhVo9SjnmMscCqz0TWPs4ciQ8wQNXAXXwBagHP58XpVGkH/6jveNxSCYrwIg1cJJqFGjT42v6f9+Y1XczAF7AWMHIcZbBZIzEhXSrobBAxAiJn+FVCw1oJkw7wu6HDUopo4jKggHXUY=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VE1PR04MB7453.eurprd04.prod.outlook.com (2603:10a6:800:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Wed, 11 Nov
 2020 02:49:51 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 02:49:51 +0000
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
Thread-Index: AQHWtnmf1Fe2qKyugUaToCGM3cma6am/hnbQgABT4wCAAMJmMIAAz6aAgAAKvACAAAwhgIAAtS8g
Date:   Wed, 11 Nov 2020 02:49:51 +0000
Message-ID: <VI1PR04MB496067EB79873EEC9329B9B992E80@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200930153519.7282-16-kishon@ti.com>
 <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <d6d27475-3464-6772-2122-cc194b8ae022@ti.com>
 <VI1PR04MB49602D24F65E11FF1F14294F92E90@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <30c8f7a1-baa5-1eb4-d2c2-9a13be896f0f@ti.com>
 <CAK8P3a38vBXbAWE09H+TSoZUTkFdYDcQmXX97foT4qXQc8t5ZQ@mail.gmail.com>
 <5a9115c8-322e-ffd4-6274-ae98c375b21d@ti.com>
In-Reply-To: <5a9115c8-322e-ffd4-6274-ae98c375b21d@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 991f25b0-c315-4d9c-6849-08d885ec762a
x-ms-traffictypediagnostic: VE1PR04MB7453:
x-microsoft-antispam-prvs: <VE1PR04MB7453651A14CC9E51BA1F57EF92E80@VE1PR04MB7453.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YaGFLD+d+1xK35YKUmTFNKiHwXnULKfw9MxSCsXTbN9kPym2cUUgQNfXEmgLoyKkLR1BXmCXq8mMkdvEbjdVtg+vvn9mia3EFys79JtThm7+quTOP+4PmbMpvrFH0t6J6xBZepvnjlvYLRjjblDoqlyg2heMsAGwYF++QaNSTxDHOPiVZwuO02HvelQEa88iL7DRp/Ovl9H2SDZvCtSmLvfcNFHrunGUkmctzJ+VXnU1dyr0W1aV53E/34gz+Rayql0gWo5exvZ//X1IB0mEhkcUmxSvlOcAfFW1PoWr+k8C2xVNWVXJBYNeIcNSDb2dPVoL311QMr1jMOsSkW+mI7BacN7IbdT5GBD2VWsAnm5UkEpHh2giFLj77u3uBJ+S0GLTwAlohtunmmcULs8xqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(66946007)(316002)(76116006)(66556008)(66446008)(110136005)(71200400001)(54906003)(83380400001)(52536014)(33656002)(9686003)(53546011)(7696005)(45080400002)(6506007)(66476007)(5660300002)(55016002)(478600001)(26005)(44832011)(186003)(7416002)(966005)(4326008)(8676002)(86362001)(8936002)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yNl0QGWc959BzH4IUTZL6QkAhY/0T9alVCvR+6mE+ETzehPza2lgMBzTfUrhrqAjtXL4kdwe7Pi4AWlnfrYgnk6XaTpbdn/5I7+tG1Ktik0QfcsCIX5SQwZOuNAIsw5lUONVuh0jqaz0vOe2xddZCq7vrFa1Mg38teISKVvUcSk5S9IvXrrpGDoixdHYuoDKczYRiEOw8by76v4NPiYWsHjhhhjlphhlIGVgFzxqUzwQN4gALWl3aaxZzrKSyQwYLQDfpcnhVY1SWvLA2HMTo8swODL1q+PJvKblrBzh9hwU60ok/qBOsJttPcUKWgr78r1slW16UYJ+Yk1B3rFxv6G2dHhPZ3Nx3TI8+QhoXULFROS0eZAr0NT66xyjD7Beo3G2NxH9UD1s6vDw6Qyqj/2LP1YWT6rTb11R6NqFG7QkFFhN25VtJPk5IeRVl+Pufu3VwC4Mtzaw98FdG9LGW+S54haHAcOh+zkF2e2AnF8Zv9oDfHLSUwz/Zx08aYkT3RwFEO89kGMP31072PU0v1Zor41ZcICrj31vVn8BN55ltDd2iqXGJkYaqJjHvIctpOsOXWEiUaF5eYHebdLawWGO7wIy/Yf44fVtsnZUfafi6DfRSVXs3sSZYAyyPw6R03EBVcDytYpy6zWUKNqwx8c6+PzOKJaVUmYFtVtOxhILPbyAkQKu6kydWuHdT24VG6hubIkKyBdDGezNATNZKBjkvDM2sHhZO60eFyvDTn/+QXdlQr7qaZu8i2Ok5buuNKVLxEiWYinFh9I2+dEisKhndq8Ov2ibMTezCZ3rD/+EwgQ8WTmIc4K+VvNPxfIXXCoHKKlbitiOS4ozFqbY9Uv+lxhgZxXMrGd+K5rD4EROLOBadPB5XZe9orz0M0Xf2Y5Bixny+F2cXHqJKAMqow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991f25b0-c315-4d9c-6849-08d885ec762a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 02:49:51.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QT+xczaMI5k5vafZQYY3stf+mNSmIWHNSMkIMnmtP43/f8yNklmBdec0nJQl9Xfo5uycgsVLfUM31JUOy3QTtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMTUvMThdIE5UQjogQWRkIHN1
cHBvcnQgZm9yIEVQRiBQQ0ktRXhwcmVzcyBOb24tDQo+IFRyYW5zcGFyZW50IEJyaWRnZQ0KPiAN
Cj4gSGkgU2hlcnJ5LCBBcm5kLA0KPiANCj4gT24gMTAvMTEvMjAgODoyOSBwbSwgQXJuZCBCZXJn
bWFubiB3cm90ZToNCj4gPiBPbiBUdWUsIE5vdiAxMCwgMjAyMCBhdCAzOjIwIFBNIEtpc2hvbiBW
aWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IHdyb3RlOg0KPiA+PiBPbiAxMC8xMS8y
MCA3OjU1IGFtLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+DQo+ID4+PiBCdXQgZm9yIFZPUCwgb25s
eSB0d28gYm9hcmRzIGFyZSBuZWVkZWQob25lIGJvYXJkIGFzIGhvc3QgYW5kIG9uZQ0KPiA+Pj4g
Ym9hcmQgYXMgY2FyZCkgdG8gcmVhbGl6ZSB0aGUgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIHRoZSB0
d28gc3lzdGVtcywNCj4gc28gbXkgcXVlc3Rpb24gaXMgd2hhdCBhcmUgdGhlIGFkdmFudGFnZXMg
b2YgdXNpbmcgTlRCPw0KPiA+Pg0KPiA+PiBOVEIgaXMgYSBicmlkZ2UgdGhhdCBmYWNpbGl0YXRl
cyBjb21tdW5pY2F0aW9uIGJldHdlZW4gdHdvIGRpZmZlcmVudA0KPiA+PiBzeXN0ZW1zLiBTbyBp
dCBieSBpdHNlbGYgd2lsbCBub3QgYmUgc291cmNlIG9yIHNpbmsgb2YgYW55IGRhdGENCj4gPj4g
dW5saWtlIGEgbm9ybWFsIEVQIHRvIFJQIHN5c3RlbSAob3IgdGhlIFZPUCkgd2hpY2ggd2lsbCBi
ZSBzb3VyY2Ugb3Igc2luaw0KPiBvZiBkYXRhLg0KPiA+Pg0KPiA+Pj4gQmVjYXVzZSBJIHRoaW5r
IHRoZSBhcmNoaXRlY3R1cmUgb2YgTlRCIHNlZW1zIG1vcmUgY29tcGxpY2F0ZWQuIE1hbnkNCj4g
dGhhbmtzIQ0KPiA+Pg0KPiA+PiB5ZWFoLCBJIHRoaW5rIGl0IGVuYWJsZXMgYSBkaWZmZXJlbnQg
dXNlIGNhc2UgYWxsIHRvZ2V0aGVyLiBDb25zaWRlcg0KPiA+PiB5b3UgaGF2ZSB0d28geDg2IEhP
U1QgUENzIChoYXZpbmcgUlApIGFuZCB0aGV5IGhhdmUgdG8gYmUgY29tbXVuaWNhdGUNCj4gPj4g
dXNpbmcgUENJZS4gTlRCIGNhbiBiZSB1c2VkIGluIHN1Y2ggY2FzZXMgZm9yIHRoZSB0d28geDg2
IFBDcyB0bw0KPiA+PiBjb21tdW5pY2F0ZSB3aXRoIGVhY2ggb3RoZXIgb3ZlciBQQ0llLCB3aGlj
aCB3b3VsZG4ndCBiZSBwb3NzaWJsZQ0KPiB3aXRob3V0IE5UQi4NCj4gPg0KPiA+IEkgdGhpbmsg
Zm9yIFZPUCwgd2Ugc2hvdWxkIGhhdmUgYW4gYWJzdHJhY3Rpb24gdGhhdCBjYW4gd29yayBvbiBl
aXRoZXINCj4gPiBOVEIgb3IgZGlyZWN0bHkgb24gdGhlIGVuZHBvaW50IGZyYW1ld29yayBidXQg
cHJvdmlkZSBhbiBpbnRlcmZhY2UNCj4gPiB0aGF0IHRoZW4gbGV0cyB5b3UgY3JlYXRlIGxvZ2lj
YWwgZGV2aWNlcyB0aGUgc2FtZSB3YXkuDQo+ID4NCj4gPiBEb2luZyBWT1AgYmFzZWQgb24gTlRC
IHBsdXMgdGhlIG5ldyBOVEJfRVBGIGRyaXZlciB3b3VsZCBhbHNvIHdvcmsgYW5kDQo+ID4ganVz
dCBtb3ZlIHRoZSBhYnN0cmFjdGlvbiBzb21ld2hlcmUgZWxzZSwgYnV0IEkgZ3Vlc3MgaXQgd291
bGQNCj4gPiBjb21wbGljYXRlIHNldHRpbmcgaXQgdXAgZm9yIHRob3NlIHVzZXJzIHRoYXQgb25s
eSBjYXJlIGFib3V0IHRoZQ0KPiA+IHNpbXBsZXIgZW5kcG9pbnQgY2FzZS4NCj4gDQo+IEknbSBu
b3Qgc3VyZSBpZiB5b3UndmUgZ290IGEgY2hhbmNlIHRvIGxvb2sgYXQgWzFdLCB3aGVyZSBJIGFk
ZGVkIHN1cHBvcnQgZm9yDQo+IFJQPC0+RVAgc3lzdGVtIGJvdGggcnVubmluZyBMaW51eCwgd2l0
aCBFUCBjb25maWd1cmVkIHVzaW5nIExpbnV4IEVQDQo+IGZyYW1ld29yayAoYXMgd2VsbCBhcyBI
T1NUIHBvcnRzIGNvbm5lY3RlZCB0byBOVEIgc3dpdGNoLCBwYXRjaGVzIDIwIGFuZA0KPiAyMSwg
dGhhdCB1c2VzIHRoZSBMaW51eCBOVEIgZnJhbWV3b3JrKSB0byBjb21tdW5pY2F0ZSB1c2luZyB2
aXJ0aW8gb3Zlcg0KPiBQQ0llLg0KPiANCg0KSSBzYXcgeW91ciBwYXRjaGVzIGF0IFsxXSwgaGVy
ZSB5b3UgdGFrZSBhIHJwbXNnIGFzIGFuIGV4YW1wbGUgdG8gY29tbXVuaWNhdGUgYmV0d2Vlbg0K
dHdvIFNvQ3MgdXNpbmcgUENJZSBSQzwtPkVQIGFuZCBIT1NUMS1OVEItSE9TVDIgZm9yIGRpZmZl
cmVudCB1c2VyY2FzZXMuDQpUaGUgVk9QIGNvZGUgd29ya3MgdW5kZXIgdGhlIFBDSWUgUkM8LT5F
UCBmcmFtZXdvcmssIHdoaWNoIG1lYW5zIHRoYXQgd2UgY2FuIGFsc28NCm1ha2UgVk9QIHdvcmtz
IHVuZGVyIHRoZSBMaW51eCBOVEIgZnJhbWV3b3JrLCBqdXN0IGxpa2UgdGhlIHJwbXNnIHdheSB5
b3UgZGlkIGhlcmUsIHJpZ2h0Pw0KDQpCZXN0IHJlZ2FyZHMNClNoZXJyeQ0KDQo+IFRoZSBjb3Zl
ci1sZXR0ZXIgWzFdIHNob3dzIGEgcGljdHVyZSBvZiB0aGUgdHdvIHVzZSBjYXNlcyBzdXBwb3J0
ZWQgaW4gdGhhdA0KPiBzZXJpZXMuDQo+IA0KPiBbMV0gLT4NCj4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZsb3JlLmtlDQo+
IHJuZWwub3JnJTJGciUyRjIwMjAwNzAyMDgyMTQzLjI1MjU5LTEtDQo+IGtpc2hvbiU0MHRpLmNv
bSZhbXA7ZGF0YT0wNCU3QzAxJTdDc2hlcnJ5LnN1biU0MG54cC5jb20lN0M1ZDhiNw0KPiAzYTRi
NzI5NDdiZWE2NWQwOGQ4ODU4ZjUwOTElN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
NSU3DQo+IEMwJTdDMCU3QzYzNzQwNjE5Nzg2NTExOTk5MiU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaQ0KPiBNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMTAwDQo+IDAmYW1wO3NkYXRhPWlSckJ2UTl4am9PVVlVJTJGRGlk
TUxaWnBXNlh1VTRJVFZYRkRBJTJCJTJGNHJKRlUNCj4gJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0K
PiBUaGFuayBZb3UsDQo+IEtpc2hvbg0K
