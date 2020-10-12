Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86028AD04
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 06:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgJLEdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 00:33:38 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:62853
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbgJLEdi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 00:33:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDxwTn4whCu+mbGp4PUlGrNq1/Zvu5M8OyyezHdP7McqKRz7ileCWlBEyRPvE+LbL5X5NejFvrkkysyJwt6T4+CXVM5/i4aTueEMaAVsHbvfRiZEgAFgGkG97WqYJwV6gr9aJtsZALcmtezNxniqRPFr47mzFL2Wl/koGLngKqsveIjaRsyLB1kI/7U/cPOSJmeEi/17i7qj0gDTGpEowXMM0q8CSYtYtS7VjWZDudj54cN0MfFSWpnAsUBNO1kcIVaoetEDuJzVNzQq0XMkJS3/kGEbbAI5waoWdb+qz+trojZoJf8zN2ni5Croo5pMRMuOLUwPPWwZga/WONeD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPHMTwzNhTqni6LtUG7xzcsSt2rLeAsIa9RV7H5IbCk=;
 b=oSf5XVb3v8qnHc+E67tRrE6vYGy8wXjgTfUrvkfFvBJZT5VX9tMWmRLPCqHZABzLf3ADbiHv1OPm7aYiG7oUyLpE30fD5mtgGK+sgWXvOae+Cc+JigJHrHESZkjulYu1zf3Nb/sjRrpRSb2jr8V/0VRhmObNFksEu0Hw9K3FKaSwNQbA6KUDvBweF3uL2fHFPQNSawb+lgXEJMIYxmFs4MQPT8jx8MughVGwY+Vw2fuFvPwcGl6I6rwf33JP2lSNI2lOx7joZhOy1EMGX4s0E8AOkkWB8AcWZiwUeXNR7XCKJzut/ap2a43BTTtA4t6h2thg4KRdcYxxOptExjgLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPHMTwzNhTqni6LtUG7xzcsSt2rLeAsIa9RV7H5IbCk=;
 b=YnJV2hq83agM3f1pRbcUgcwfSluaC60u6P/pnPpZcWqa1RCYSWo1v1/z3y+MDVGBwkXvtNT+fd0ZIvDzc1f8zwEZZ8CMbsqTrSnkzEjFy5/Z/p0DoLzvXXJAsJnjpwlJer0n/n7p1SWscyEgOqRCiyU1F6xdqO41l2JWzj44RAE=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3179.eurprd04.prod.outlook.com (2603:10a6:7:21::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 04:33:33 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 04:33:33 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] PCI: layerscape: Change back to the default error
 response behavior
Thread-Topic: [PATCH] PCI: layerscape: Change back to the default error
 response behavior
Thread-Index: AQHWlmOUIiAVbf4g/0+1Jt3JLmBS46mBLpWAgAAbmgCAEigaUA==
Date:   Mon, 12 Oct 2020 04:33:32 +0000
Message-ID: <HE1PR0402MB3371AAA60147CAB24C63E2E384070@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200929131328.13779-1-Zhiqiang.Hou@nxp.com>
 <6e6d021b-bc46-63b4-7e84-6ca2c8e631f9@ti.com>
 <CAL_Jsq+rH6-NMb0=jbdYA5mzP_2VphW4TXvKJdKr3cnsPQp1RA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+rH6-NMb0=jbdYA5mzP_2VphW4TXvKJdKr3cnsPQp1RA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69085431-1c5a-4938-059e-08d86e67fa24
x-ms-traffictypediagnostic: HE1PR04MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB3179C86AE13D1497BEF0F18584070@HE1PR04MB3179.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hcik13sLlJb/0jFJYDektw+rXN1+zTll/ycNoRgEWtYrofh0V87dE6os+Q5qMV8yse1fan2cmLP1ZN1PWdn2aDLtUQfYOAOGwtXHN+V8s/uEuqgPb2mr27k0+GORT1ITb4/UZf0GCs8BlIHhjCzqzzRnroa1xggj3KPck5lVGD4tKssiWUt19VLSEaWOUfopThDrjci7T82wuVtz3COE5/hfSMOrP+CZCVkOiyFIv9YmTkAPjVxhzJSqaSkJUt2kkH9+1GH8QrYIS7v4DVt2Wz1YVQHS2720ASsNmfSN59NvpO+PvKe9AYQWyqbHA1oHYWNz/NLcbE9cEcd0CBGT/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(186003)(52536014)(4326008)(33656002)(110136005)(8936002)(26005)(83380400001)(86362001)(66446008)(66946007)(2906002)(66556008)(64756008)(66476007)(55016002)(71200400001)(9686003)(478600001)(53546011)(6506007)(7696005)(54906003)(5660300002)(76116006)(8676002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DNAijQd5Ch8EU6Au0ucM2I8IN+prXR6aLawapJQmD4b8HiGTdRMBJC+Um/0ew/CRuVmSbSECrpIqF1Hp4UwiQvvN+KuggMRv0JrZYSNsBXuMB9vkeG5RdocFwIzmv5DWFou44ZrgAdqkNkftRHRgtzbzvL8PqQMJKGVv4JUBXKmGFQVsioqFxQ7EU1Bv+Y0k6je/b5aPcoXh8Nk1kXjnfPDF0xF/o3VI62Gl7CUv777eJ1Q5sLYle93yadm7qmUoZbmSsrDrdwZRKUYjXsErVZ9FEL97XYmGm12cdn1+8FJnKbyA89YJi3SCTcFaPXHJupWNqdWFN2N5q8dukjMmAQLYdFe4heH6ClulUKz1V9b/i3Lv4pRZq+Z2saadGyAzJBqnxEirfUdCEbfnOKPriBDZXD7EezmQzMVNEIDZxqUi27AJjZLj2q8GlafYGujXfL3QliM9mnnozEJ+9vztS0oJ6IVoKONNaH1mOPP7rtuR6IesfrnZfXiu+o8sSZVZi/8Czqe/fLAqoQi3W0K4qUvEN+hiXUyiJJVR3KP1esA175cMooinVeRI8uxp9JDj7oSN0BPsX2xlXT9b/gUIJk302JDhAx02dgarbL3HLyuIHr07Lyf0TyQn0bZ9Unv6DZBF2DXgVBzZTV/8VZ7/OQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69085431-1c5a-4938-059e-08d86e67fa24
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 04:33:32.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYB9aqM7Gc/QCmfDMCtHHWRjx5zjcQLkT2Ot1la4+isRsrrrlufBZWsptds4mrR8dRb/5XA5PX7I0LMd0hgrNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3179
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iIGFuZCBLaXNob24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMOW5tDnmnIgzMOaX
pSAyMzowOA0KPiBUbzogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4g
Q2M6IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IFBDSSA8bGludXgtcGNpQHZnZXIu
a2VybmVsLm9yZz47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWwNCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IExvcmVuem8g
UGllcmFsaXNpDQo+IDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgQmpvcm4gSGVsZ2FhcyA8
YmhlbGdhYXNAZ29vZ2xlLmNvbT47IE0uaC4NCj4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29t
PjsgUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+OyBNaW5na2FpDQo+IEh1IDxtaW5na2FpLmh1
QG54cC5jb20+OyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gUENJOiBsYXllcnNjYXBlOiBDaGFuZ2UgYmFjayB0byB0aGUgZGVmYXVsdCBlcnJvcg0K
PiByZXNwb25zZSBiZWhhdmlvcg0KPiANCj4gT24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgODoyOSBB
TSBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25AdGkuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IEhpIEhvdSwNCj4gPg0KPiA+IE9uIDI5LzA5LzIwIDY6NDMgcG0sIFpoaXFpYW5nIEhvdSB3
cm90ZToNCj4gPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+
ID4gPg0KPiA+ID4gSW4gdGhlIGN1cnJlbnQgZXJyb3IgcmVzcG9uc2UgYmVoYXZpb3IsIGl0IHdp
bGwgc2VuZCBhIFNMVkVSUg0KPiA+ID4gcmVzcG9uc2UgdG8gZGV2aWNlJ3MgaW50ZXJuYWwgQVhJ
IHNsYXZlIHN5c3RlbSBpbnRlcmZhY2Ugd2hlbiB0aGUNCj4gPiA+IFBDSWUgY29udHJvbGxlciBl
eHBlcmllbmNlcyBhbiBlcnJvbmVvdXMgY29tcGxldGlvbiAoVVIsIENBIGFuZCBDVCkNCj4gPiA+
IGZyb20gYW4gZXh0ZXJuYWwgY29tcGxldGVyIGZvciBpdHMgb3V0Ym91bmQgbm9uLXBvc3RlZCBy
ZXF1ZXN0LA0KPiA+ID4gd2hpY2ggd2lsbCByZXN1bHQgaW4gU0Vycm9yIGFuZCBjcmFzaCB0aGUg
a2VybmVsIGRpcmVjdGx5Lg0KPiA+ID4gVGhpcyBwYXRjaCBjaGFuZ2UgYmFjayBpdCB0byB0aGUg
ZGVmYXVsdCBiZWhhdmlvciB0byBpbmNyZWFzZSB0aGUNCj4gPiA+IHJvYnVzdG5lc3Mgb2YgdGhl
IGtlcm5lbC4gSW4gdGhlIGRlZmF1bHQgYmVoYXZpb3IsIGl0IGFsd2F5cyBzZW5kcw0KPiA+ID4g
YW4gT0tBWSByZXNwb25zZSB0byB0aGUgaW50ZXJuYWwgQVhJIHNsYXZlIGludGVyZmFjZSB3aGVu
IHRoZQ0KPiA+ID4gY29udHJvbGxlciBnZXRzIHRoZXNlIGVycm9uZW91cyBjb21wbGV0aW9ucy4g
QW5kIHRoZSBBRVIgZHJpdmVyIHdpbGwNCj4gPiA+IHJlcG9ydCBhbmQgdHJ5IHRvIHJlY292ZXIg
dGhlc2UgZXJyb3JzLg0KPiA+DQo+ID4gSSBkb24ndCB0aGluayBub3QgZm9yd2FyZGluZyBhbnkg
ZXJyb3IgaW50ZXJydXB0cyBpcyBhIGdvb2QgaWRlYS4NCj4gDQo+IEludGVycnVwdHMgd291bGQg
YmUgZmluZS4gQWJvcnQvU0Vycm9yIGlzIG5vdC4gSSB0aGluayBpdCBpcyBwcmV0dHkgY2xlYXIg
d2hhdCB0aGUNCj4gY29ycmVjdCBiZWhhdmlvciBpcyBmb3IgY29uZmlnIGFjY2Vzc2VzLg0KDQpJ
IGFncmVlIHdpdGggUm9iLg0KDQo+IA0KPiA+IE1heWJlDQo+ID4geW91IGNvdWxkIGRpc2FibGUg
aXQgd2hpbGUgcmVhZGluZyBjb25maWd1cmF0aW9uIHNwYWNlIHJlZ2lzdGVycw0KPiA+ICh2ZW5k
b3JJRCBhbmQgZGV2aWNlSUQpIGFuZCB0aGVuIGVuYWJsZSBlcnJvciBmb3J3YXJkaW5nIGJhY2s/
DQo+IA0KPiBUbyBhZGQgdG8gdGhlIGxvY2tpbmcgKG9yIGxhY2sgb2YpIHByb2JsZW1zIGluIGNv
bmZpZyBhY2Nlc3Nlcz8NCg0KSWYgdGFrZSB0aGlzIGFwcHJvYWNoLCBkdXJpbmcgdGhlIGhvbGUg
b2YgQ0ZHIGFjY2VzcywgdGhlIGVycm9yIG9mIE1FTV9yZCB3aWxsIGFsc28gbm90IGJlIGZvcndh
cmRlZCwgc28gaXQncyBub3QgYSByZWxpYWJsZSBtZWNoYW5pc20gZm9yIHVzZXIuDQoNClRoYW5r
cywNClpoaXFpYW5nDQoNCj4gDQo+IFJvYg0K
