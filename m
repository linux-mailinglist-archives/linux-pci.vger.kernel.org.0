Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7167F29E1C3
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 03:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgJ2CDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 22:03:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:16308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391222AbgJ2CDE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 22:03:04 -0400
IronPort-SDR: 7hJw3C5G9Z9yys1RJ1YggkjmpGrgUA4mgMBPYySa1FLDZUE5otoBgNAxwWXlruY/I2xVO5zx8C
 /IRYnUcqhUbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="186141793"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="186141793"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 19:03:02 -0700
IronPort-SDR: tqrpv8I3IEA1nn7wWKgBLFVtp41QjLbgH06ev3ohSNiunUxB01fDyrJ7EELJslqQF3WOQQoqRK
 3EbTTyQ1h5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="356118179"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 28 Oct 2020 19:03:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Oct 2020 19:03:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Oct 2020 19:03:01 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Wed, 28 Oct 2020 19:03:01 -0700
From:   "Dutt, Sudeep" <sudeep.dutt@intel.com>
To:     "sherry.sun@nxp.com" <sherry.sun@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fugang.duan@nxp.com" <fugang.duan@nxp.com>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
Subject: Re: [EXT] Re: [PATCH V5 0/2] Change vring space from nomal memory to
 dma coherent memory
Thread-Topic: [EXT] Re: [PATCH V5 0/2] Change vring space from nomal memory to
 dma coherent memory
Thread-Index: AQHWrM6mI/n9i6M9302TMCnx4YlfCams+nsAgAAB6wCAABE/AIAANTaAgAAPtICAAEJUgIAACJgAgACqYgCAAAFZgA==
Date:   Thu, 29 Oct 2020 02:03:00 +0000
Message-ID: <8e6da51572b8e64cf89a1e76f06089e8fa181bc9.camel@intel.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
         <20201028055836.GA244690@kroah.com>
         <AM0PR04MB4947032368486CC9874C812692170@AM0PR04MB4947.eurprd04.prod.outlook.com>
         <20201028070712.GA1649838@kroah.com>
         <AM8PR04MB7315D583A9490E642ED13071FF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
         <20201028111351.GA1964851@kroah.com>
         <AM8PR04MB731570801A528203647FAD0AFF170@AM8PR04MB7315.eurprd04.prod.outlook.com>
         <20201028154200.GB2780014@kroah.com>
         <VI1PR04MB49608E4DE25847CC3019A40092140@VI1PR04MB4960.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB49608E4DE25847CC3019A40092140@VI1PR04MB4960.eurprd04.prod.outlook.com>
Reply-To: "Dutt, Sudeep" <sudeep.dutt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <649B453F68255A4FBAC1BCE02270DDE3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTI5IGF0IDAxOjUxICswMDAwLCBTaGVycnkgU3VuIHdyb3RlOg0KPiBI
aSBHcmVnLA0KPiANCj4gPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCBWNSAwLzJdIENo
YW5nZSB2cmluZyBzcGFjZSBmcm9tIG5vbWFsDQo+ID4gbWVtb3J5IHRvIGRtYSBjb2hlcmVudCBt
ZW1vcnkNCj4gPiANCj4gPiBPbiBXZWQsIE9jdCAyOCwgMjAyMCBhdCAwMzoxMToxNVBNICswMDAw
LCBBbmR5IER1YW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4gU2VudDogV2VkbmVzZGF5LA0KPiA+ID4gT2N0b2Jlcg0KPiA+ID4gMjgsIDIw
MjAgNzoxNCBQTQ0KPiA+ID4gPiBPbiBXZWQsIE9jdCAyOCwgMjAyMCBhdCAxMDoxNzozOUFNICsw
MDAwLCBBbmR5IER1YW4gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogR3JlZyBLSCA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+IFNlbnQ6IFdlZG5lc2RheSwNCj4gPiA+ID4gPiBPY3RvYmVyIDI4
LCAyMDIwIDM6MDcgUE0NCj4gPiA+ID4gPiA+IE9uIFdlZCwgT2N0IDI4LCAyMDIwIGF0IDA2OjA1
OjI4QU0gKzAwMDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEhpIEdyZWcsDQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgMC8y
XSBDaGFuZ2UgdnJpbmcgc3BhY2UgZnJvbQ0KPiA+ID4gPiA+ID4gPiA+IG5vbWFsDQo+ID4gPiA+
ID4gPiA+ID4gbWVtb3J5IHRvIGRtYSBjb2hlcmVudCBtZW1vcnkNCj4gPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIE9jdCAyOCwgMjAyMCBhdCAxMDowMzowM0FNICswODAw
LCBTaGVycnkgU3VuDQo+ID4gPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBD
aGFuZ2VzIGluIFY1Og0KPiA+ID4gPiA+ID4gPiA+ID4gMS4gUmVvcmdhbml6ZSB0aGUgdm9wX21t
YXAgZnVuY3Rpb24gY29kZSBpbiBwYXRjaCAxLA0KPiA+ID4gPiA+ID4gPiA+ID4gd2hpY2gNCj4g
PiA+ID4gPiA+ID4gPiA+IGlzIGRvbmUgYnkNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gPiBDaHJpc3RvcGguDQo+ID4gPiA+ID4gPiA+ID4gPiAyLiBDb21wbGV0ZWx5IHJlbW92ZSB0
aGUgdW5uZWNlc3NhcnkgY29kZSByZWxhdGVkIHRvDQo+ID4gPiA+ID4gPiA+ID4gPiByZWFzc2ln
biB0aGUgdXNlZCByaW5nIGZvciBjYXJkIGluIHBhdGNoIDIuDQo+ID4gPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gPiA+IFRoZSBvcmlnaW5hbCB2b3AgZHJpdmVyIG9ubHkgc3VwcG9ydHMg
ZG1hIGNvaGVyZW50DQo+ID4gPiA+ID4gPiA+ID4gPiBkZXZpY2UsDQo+ID4gPiA+ID4gPiA+ID4g
PiBhcyBpdCBhbGxvY2F0ZXMgYW5kIG1hcHMgdnJpbmcgYnkgX2dldF9mcmVlX3BhZ2VzIGFuZA0K
PiA+ID4gPiA+ID4gPiA+ID4gZG1hX21hcF9zaW5nbGUsIGJ1dCBub3QgdXNlDQo+ID4gPiA+ID4g
PiA+ID4gPiBkbWFfc3luY19zaW5nbGVfZm9yX2NwdS9kZXZpY2UNCj4gPiA+ID4gPiA+ID4gPiA+
IHRvIHN5bmMgdGhlIHVwZGF0ZXMgb2YgZGV2aWNlX3BhZ2UvdnJpbmcgYmV0d2VlbiBFUA0KPiA+
ID4gPiA+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gPiA+ID4gPiBSQywgd2hpY2ggd2lsbCBjYXVz
ZSBtZW1vcnkgc3luY2hyb25pemF0aW9uIHByb2JsZW0NCj4gPiA+ID4gPiA+ID4gPiA+IGZvcg0K
PiA+ID4gPiA+ID4gPiA+ID4gZGV2aWNlIGRvbid0IHN1cHBvcnQNCj4gPiA+ID4gDQo+ID4gPiA+
IGhhcmR3YXJlIGRtYSBjb2hlcmVudC4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+ID4gQW5kIGFsbG9jYXRlIHZyaW5ncyB1c2UgZG1hX2FsbG9jX2NvaGVyZW50IGlzIGENCj4g
PiA+ID4gPiA+ID4gPiA+IGNvbW1vbiB3YXkNCj4gPiA+ID4gPiA+ID4gPiA+IGluIGtlcm5lbCwg
YXMgdGhlIG1lbW9yeSBpbnRlcmFjdGVkIGJldHdlZW4gdHdvDQo+ID4gPiA+ID4gPiA+ID4gPiBz
eXN0ZW1zDQo+ID4gPiA+ID4gPiA+ID4gPiBzaG91bGQgdXNlIGNvbnNpc3RlbnQgbWVtb3J5IHRv
IGF2b2lkIGNhY2hpbmcNCj4gPiA+ID4gPiA+ID4gPiA+IGVmZmVjdHMuIFNvDQo+ID4gPiA+ID4g
PiA+ID4gPiBoZXJlIGFkZCBub25jb2hlcmVudCBwbGF0Zm9ybQ0KPiA+ID4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiA+IHN1cHBvcnQgZm9yIHZvcCBkcml2ZXIuDQo+ID4gPiA+ID4gPiA+ID4g
PiBBbHNvIGFkZCBzb21lIHJlbGF0ZWQgZG1hIGNoYW5nZXMgdG8gbWFrZSBzdXJlDQo+ID4gPiA+
ID4gPiA+ID4gPiBub25jb2hlcmVudA0KPiA+ID4gPiA+ID4gPiA+ID4gcGxhdGZvcm0gd29ya3Mg
d2VsbC4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gU2hlcnJ5IFN1biAo
Mik6DQo+ID4gPiA+ID4gPiA+ID4gPiAgIG1pc2M6IHZvcDogY2hhbmdlIHRoZSB3YXkgb2YgYWxs
b2NhdGluZyB2cmluZ3MgYW5kDQo+ID4gPiA+ID4gPiA+ID4gPiBkZXZpY2UgcGFnZQ0KPiA+ID4g
PiA+ID4gPiA+ID4gICBtaXNjOiB2b3A6IGRvIG5vdCBhbGxvY2F0ZSBhbmQgcmVhc3NpZ24gdGhl
IHVzZWQNCj4gPiA+ID4gPiA+ID4gPiA+IHJpbmcNCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+ID4gIGRyaXZlcnMvbWlzYy9taWMvYnVzL3ZvcF9idXMuaCAgICAgfCAgIDIgKw0K
PiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbWlzYy9taWMvaG9zdC9taWNfYm9vdC5jICAgfCAg
IDkgKysNCj4gPiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL21pc2MvbWljL2hvc3QvbWljX21haW4u
YyAgIHwgIDQzICsrLS0tLS0tDQo+ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9taXNjL21pYy92
b3Avdm9wX2RlYnVnZnMuYyB8ICAgNCAtDQo+ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9taXNj
L21pYy92b3Avdm9wX21haW4uYyAgICB8ICA3MCArLS0tLS0tLS0NCj4gPiA+ID4gPiA+ID4gPiA+
IC0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbWlzYy9taWMvdm9wL3ZvcF92cmluZ2gu
YyAgfCAxNjYgKysrKysrKysrKy0NCj4gPiA+ID4gPiA+ID4gPiA+IC0tLS0tLS0tLS0tLQ0KPiA+
IA0KPiA+IC0tLS0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gIGluY2x1ZGUvdWFwaS9saW51eC9taWNf
Y29tbW9uLmggICAgfCAgIDkgKy0NCj4gPiA+ID4gPiA+ID4gPiA+ICA3IGZpbGVzIGNoYW5nZWQs
IDg1IGluc2VydGlvbnMoKyksIDIxOCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gPiBIYXZlIHlvdSBhbGwgc2VlbjoNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiANCmh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQQ0KPiA+ID4gPiA+ID4gPiA+ICUyRiUyNQ0KPiA+ID4gPiA+ID4gPiA+
IDI1DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gDQo+ID4gMkZsb3JlLmtlcm5lbC5vcmclMkZyJTJG
OGMxNDQzMTM2NTYzZGUzNDY5OWQyYzA4NGRmNDc4MTgxYzIwNWRiNC4xNg0KPiA+ID4gPiA+ID4g
PiA+IA0KPiA+IA0KPiA+IDAzODU0NDE2LmdpdC5zdWRlZXAuZHV0dCU0MGludGVsLmNvbSZhbXA7
ZGF0YT0wNCU3QzAxJTdDc2hlcnJ5LnN1biUNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiANCj4gPiA0
MG54cC5jb20lN0NjMTljOTg3NjY3NDM0OTY5ODQ3ZTA4ZDg3YjA2ODVlOCU3QzY4NmVhMWQzYmMy
YjRjNmYNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiANCj4gPiBhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzczOTQ2MTUyMzg5NDAzMjMlN0NVbmtub3duJTdDVFcNCj4gPiA+ID4gPiA+ID4gPiAN
Cj4gPiANCj4gPiBGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlgNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiANCj4gPiBWQ0k2TW4w
JTNEJTdDMTAwMCZhbXA7c2RhdGE9WnElMkZ0SFdUcSUyQnVJVkJZWEZHb2VCbXEwSkp6WWQNCj4g
PiA+ID4gPiA+ID4gPiA5ekR5djROVk40VHBDJTJGVSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IExvb2tzIGxpa2UgdGhpcyBjb2RlIGlzIGFza2lu
ZyB0byBqdXN0IGJlIGRlbGV0ZWQsIGlzDQo+ID4gPiA+ID4gPiA+ID4gdGhhdCBvayB3aXRoIHlv
dT8NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFllcywgSSBzYXcgdGhhdCBwYXRjaC4g
SSdtIG9rIHdpdGggaXQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEdyZWF0LCBjYW4geW91
IHBsZWFzZSBwcm92aWRlIGEgIlJldmlld2VkLWJ5OiIgb3IgIkFja2VkLQ0KPiA+ID4gPiA+ID4g
Ynk6IiBmb3IgaXQ/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IHRoYW5rcywNCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gZ3JlZyBrLWgNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaGVycnkg
dG9vayBtdWNoIGVmZm9ydCBvbiB0aGUgZmVhdHVyZXMgc3VwcG9ydCBvbiBpLk1YDQo+ID4gPiA+
ID4gc2VyaWVzDQo+ID4gPiA+ID4gbGlrZQ0KPiA+ID4gPiANCj4gPiA+ID4gaS5NWDhRTS9pLk1Y
OFFYUC9pLk1YOE1NLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE5vdyBpdCBpcyBhIHBpdHkgdG8g
ZGVsZXRlIHRoZSB2b3AgY29kZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbmUgcXVlc3Rpb24s
DQo+ID4gPiA+ID4gY2FuIHdlIHJlc3VibWl0IHZvcCBjb2RlIGJ5IGNsZWFuIHVwLCBub3cgb25s
eSBmb3IgaS5NWA0KPiA+ID4gPiA+IHNlcmllcyBhcw0KPiA+ID4gPiA+IER1dHQncw0KPiA+ID4g
PiANCj4gPiA+ID4gc3VnZ2VzdGlvbiA/DQoNClJlc3VibWl0dGluZyB0aGUgVk9QIGNvZGUgd2l0
aCBjbGVhbnVwcyB0YWlsb3JlZCBmb3IgaS5NWCBtYWtlcyBzZW5zZQ0KdG8gbWUuDQoNCj4gPiA+
ID4gPiBPciB3ZSBoYXZlIHRvIGRyb3AgdGhlIGRlc2lnbiBhbmQgc3dpdGNoIHRvIHNlbGVjdCBv
dGhlcg0KPiA+ID4gPiA+IHNvbHV0aW9ucyA/DQo+ID4gPiANCj4gPiA+IE9rYXksIHdlIHBsYW4g
dG8gc3dpdGNoIHRvIE5UQiBzb2x1dGlvbi4NCj4gPiANCj4gPiBXaGF0IGlzIGEgIk5UQiBzb2x1
dGlvbiIgZXhhY3RseT8NCj4gDQo+IFRoZSBkcml2ZXIgbG9jYXRlZCBhdCBkcml2ZXJzL250Yi8s
IGl0IGFsc28gY2FuIHNldHVwIGEgcG9pbnQtdG8tDQo+IHBvaW50IFBDSS1FIGJ1cyBjb25uZWN0
aW5nIGJldHdlZW4gdHdvIHN5c3RlbXMuDQo+IEJ1dCB3ZSBoYXZlbid0IGdvdCBhIGRlZXAgbG9v
ayBvZiB0aGlzIGRyaXZlciB5ZXQsIHNvIHdlIGFyZSBub3Qgc3VyZQ0KPiB3aGV0aGVyIGl0IGNh
biByZXBsYWNlIHRoZSB2b3AgZnJhbWV3b3JrLg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gPiBJ
ZiB0aGlzIHdob2xlIHN1YnN5c3RlbSBpcyBiZWluZyBkZWxldGVkIGJlY2F1c2UgaXQgaXMgbm90
IHVzZWQNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IG5ldmVyIHNoaXBwZWQsIHllcywgcGxlYXNlIHVz
ZSBhIGRpZmZlcmVudCBzb2x1dGlvbi4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZG9uJ3QgdW5kZXJz
dGFuZCB3aHkgeW91IHdlcmUgdHJ5aW5nIHRvIHBpZ2d5LWJhY2sgb24gdGhpcw0KPiA+ID4gPiBj
b2RlYmFzZSBpZiB0aGUgaGFyZHdhcmUgd2FzIHRvdGFsbHkgZGlmZmVyZW50LCBmb3Igc29tZSBy
ZWFzb24NCj4gPiA+ID4gSQ0KPiA+ID4gPiB0aG91Z2h0IHRoaXMgd2FzIHRoZSBzYW1lIGhhcmR3
YXJlLiAgV2hhdCBleGFjdGx5IGlzIHRoaXM/DQo+ID4gPiANCj4gPiA+IE5vdCB0aGUgd2hvbGUg
Y29kZWJhc2UsIGp1c3QgdGhlIHZvcCBmcmFtZXdvcmsuDQo+ID4gDQo+ID4gVGhhdCBkaWRuJ3Qg
YW5zd2VyIHRoZSBxdWVzdGlvbiBhdCBhbGwsIHdoYXQgYXJlIHlvdSBhbGwgdHJ5aW5nIHRvDQo+
ID4gZG8gaGVyZSwgd2l0aA0KPiA+IHdoYXQgaGFyZHdhcmUsIHRoYXQgdGhlIFZPUCBjb2RlIHNl
ZW1lZCBsaWtlIGEgZ29vZCBmaXQ/DQo+IA0KPiBWb3AgaXMgYSBjb21tb24gZnJhbWV3b3JrIHdo
aWNoIGlzIGluZGVwZW5kZW50IG9mIHRoZSBJbnRlbCBNSUMNCj4gaGFyZHdhcmUuDQo+IFdlIHBs
YW5lZCB0byByZXVzZSB2b3AgZnJhbWV3b3JrIG9uIHR3byBhcm02NCBhcmNoaXRlY3R1cmUgZGV2
aWNlcywNCj4gdG8gc2V0dXAgdGhlIGNvbm5lY3Rpb24gYmV0d2VlbiB0d28gc3lzdGVtcyBiYXNl
ZCBvbiB2aXJ0aW8gb3Zlcg0KPiBQQ0lFLg0KDQpZZXMsIHdlIHdhbnRlZCBWaXJ0aW8gT3ZlciBQ
Q0llIChWT1ApIHRvIGJlIGluZGVwZW5kZW50IG9mIHRoZSBoYXJkd2FyZQ0KYXMgbXVjaCBhcyBw
b3NzaWJsZS4gSXQgZGlkIGVuZCB1cCB1bmRlciB0aGUgbWljLyBkcml2ZXIgc3Vic3lzdGVtDQp0
aG91Z2ggc28gaXQgd291bGQgYmUgZ29vZCB0byBhdHRlbXB0IHBsYWNpbmcgaXQgaW4gYSBnZW5l
cmljIGZvbGRlcg0Kd2hpY2ggaXMgbm90IHRpZWQgdG8gYSBzcGVjaWZpYyBoYXJkd2FyZSBsYXll
ciB0aGlzIHRpbWUgYXJvdW5kLg0KDQpSZWdhcmRzLA0KU3VkZWVwIER1dHQNCg==
