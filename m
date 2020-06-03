Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36441ED3E7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 18:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgFCQEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 12:04:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:13099 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgFCQEo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 12:04:44 -0400
IronPort-SDR: uh3kJ5b9VrnHT9Ptd7xJIU0OsHlUChHZ9jAg36wdyCmSMYImhGtaY/Ux8qS5C5MQCpttMDQCUm
 bUCz2uJvylEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 09:04:42 -0700
IronPort-SDR: aLWTu8Bn2cOfM5hPCNhVoW0LWZS7GwctC4FSg8GA/H4FnwFwE73QfSo4u6pw8uDhXtzsBWH85s
 rNplsms/R2GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="471185786"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2020 09:04:42 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jun 2020 09:04:42 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jun 2020 09:04:42 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 3 Jun 2020 09:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhFnlV9LlAF3iSqGjCoRfZkQ9mPOQe1w1hu+RWbXUFjNXOD3mBEwSSDU1BbF/2sv6VXUWPGdS6UdSPYr4Irl/sDW35/wDOQ8SyWqTy1BcvHWD74r11rMYVKGnQdSWsNZYYb6sXJZuWMn0LrcEtqQwO1Gbz5IibZn/oOfY0cix2WwexpcQKW9Y3Bay6OvLq04a9JzUjC0Mv/6djildVoE2KeY5xSFOCHtSiFddjuorSRUUXjDRhnCFTigd0pc6eMavPyHK6uQMOPWsXFrShlKB0uzRNi895kvNATkYVBWLGYJFWzDYf1L4WvZsysjHT/ErnbJc0n7Z1L7irTLs9JPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeTYBsZx2hl8r6nKpVR9UqQrp+Gel8ovk4qkoULVdlY=;
 b=FncMsVAwnEawInHguHZo/qZl0Uj3bScKXNms3H7zPNqMjVaiv9ej5k8bY+b/PWwQOLxqDvQd/QYEhQLGcfDpHQx7k2H/bPpLi+tPirEwig+D1l1C+bEz3YXEnUI7d7juNDw8PsV01xjgr3ccsAR2lCSU5aITkm9D8b+FKpLgu5QP0PG8XfPdN6fxtZMd0TyZQh6jTdYQG88l+YH1kFcuEtoUfD00ETFDlAIU5KSBjxM4D1CaNpTboxeHUO87pkAIybJgKlGoP7jtNefwUZ/c/7af9PRx2Agh5Cbj5ru/IJJhA0muXJTSoJe5MdZzDxQKXGMvcac/lQpmST8awfa1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeTYBsZx2hl8r6nKpVR9UqQrp+Gel8ovk4qkoULVdlY=;
 b=RVLGvZh5ZX5IqLHl3MfhxxX93118NDF6jH+Q9iOmNW3HKJlI1E1gBdl8oenjsmk2pm7EnNf68kbSwdFYhttyMSxrH2BSWI+o/p6YiWYcF5rSTfCKZojkvner5i8fcis0bHOSax3bZLd+Iol+xT9tmF9m8pipqW2g/H7Z1+Wyav8=
Received: from CY4PR11MB1528.namprd11.prod.outlook.com (2603:10b6:910:d::12)
 by CY4PR11MB1238.namprd11.prod.outlook.com (2603:10b6:903:2f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 16:04:38 +0000
Received: from CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd]) by CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd%11]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 16:04:37 +0000
From:   "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 01/15] PCI/MSI: Forward MSI-X vector enable error code
 in pci_alloc_irq_vectors_affinity()
Thread-Topic: [PATCH v2 01/15] PCI/MSI: Forward MSI-X vector enable error code
 in pci_alloc_irq_vectors_affinity()
Thread-Index: AQHWOZyHaAYLXzqRs023OZ8sXbUNwKjHCZ0AgAABCJA=
Date:   Wed, 3 Jun 2020 16:04:16 +0000
Deferred-Delivery: Wed, 3 Jun 2020 16:03:51 +0000
Message-ID: <CY4PR11MB152819A4C01C524E06A48EBFF9880@CY4PR11MB1528.namprd11.prod.outlook.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
 <20200603114425.12734-1-piotr.stankiewicz@intel.com>
 <3bc1522b-33ba-04ee-4d8e-e4a31ec50756@deltatee.com>
In-Reply-To: <3bc1522b-33ba-04ee-4d8e-e4a31ec50756@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2Y1ODIyODAtMzZjZi00NmU4LTljZTktMDI2ZjljOGQ2NjFhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSkl4bnFybUV3dk1pVFhnYjdCbUZcL3ZDaUorZDFOa2h4Mm1MdUI5ckVNZXBaSkhybU5PRURHSjZueDdySnN3czAifQ==
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.221.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b2e6769-4ad5-41f8-2135-08d807d7d0da
x-ms-traffictypediagnostic: CY4PR11MB1238:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1238DC38CBCA03AF56DC4E55F9880@CY4PR11MB1238.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHipR+wmNe+nMT2BOuRSGBOuBZYJrJzAvRUysr6+Y2i2nZMmvLw4gIppaAN8Ton7SN4QiH8hDfJjrkcbImKVYcHVDnHHIpA7J4giohoJMR+I47q68X5ypVV48B+sZfQXS+Bgr0UIFnpmvHGEsrukRc/higvHY6HnVhy2C3FSOnCJU7mEq43qAac2/ur3b9CScQy2HPoqnrsEY239C547Cxt6Vrvlmhb1R9JW4pYoLx3F9SLUODUZ7CEPf7uqpd7UwX1OPoq8KgWno6eQr1+TbtC9Z8b+oUg1dn2SB/voPoMACzIHHrhvh+axI8UHeGcOPoUs7yfT+FQCdt85ZWo3Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39860400002)(376002)(136003)(346002)(26005)(4326008)(186003)(316002)(478600001)(71200400001)(6506007)(33656002)(53546011)(66556008)(64756008)(6666004)(8936002)(76116006)(66476007)(8676002)(2906002)(66946007)(66446008)(55016002)(86362001)(83380400001)(7696005)(5660300002)(110136005)(54906003)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oaExvbSPJK1Q3AvKybZw1ts9DOh1tTTx2lJd/5IEYUTLsboKwqlAobbh43Mp355Rwe1cPPFKni/GQXUVKJtmYbiEVRhmfQ8JpZwCtYSMGE+7ihsjvNwcrf9tFCQyELptBUe8rp+9nmXlZkocSvb0vFrKy4WOdUwZFADumOnrnP0T/qg7Qgbts11LqpdDeXY8Ro/neK35t6B6lGaYpZBGrqB7DMVSG2FnbKpcWs004p6DNJK6I+ur7gSGHHd6c2OULWCutQj2bwMhIbl3CquFtFOhum8CM0Y35oDOFdNM1y8s/LQURvce1fwGfUeG1i85rHQZfX/OJsGEXH6+kBrmr+pRZVFjWynUE7bWtSkyQmq0jsziDfTpexxfAYtK+ln2wQgoTseVLvvPBGZRTn2Acu2J+iyp9/hEVnKMioIJ1sVwGM23l98kGQebXAQiDGzQlBvFYFbLqrlk0uV5owCYvzDB3LlSfjEYGgr34niM2zsjhR8ED4S4sjvNod6QG4v9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2e6769-4ad5-41f8-2135-08d807d7d0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 16:04:37.5085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLjmn51CEMxtkwsBnXN1w5DCBU4ds8d5Hl2UEeBJm3AeSK/U7aGnuZxqLHRdn/ZBH4UfHQLHdimM59eQCBrq3Oh/zx6WAgBAPqGqx16mJ8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1238
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2dhbiBHdW50aG9ycGUgPGxv
Z2FuZ0BkZWx0YXRlZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAzLCAyMDIwIDU6NDgg
UE0NCj4gDQo+IA0KPiANCj4gT24gMjAyMC0wNi0wMyA1OjQ0IGEubS4sIFBpb3RyIFN0YW5raWV3
aWN6IHdyb3RlOg0KPiA+IFdoZW4gZGVidWdnaW5nIGFuIGlzc3VlIHdoZXJlIEkgd2FzIGFza2lu
ZyB0aGUgUENJIG1hY2hpbmVyeSB0byBlbmFibGUgYQ0KPiA+IHNldCBvZiBNU0ktWCB2ZWN0b3Jz
LCB3aXRob3V0IGZhbGxpbmcgYmFjayBvbiBNU0ksIEkgcmFuIGFjcm9zcyBhDQo+ID4gYmVoYXZp
b3VyIHdoaWNoIHNlZW1zIG9kZC4gVGhlIHBjaV9hbGxvY19pcnFfdmVjdG9yc19hZmZpbml0eSgp
IHdpbGwNCj4gPiBhbHdheXMgcmV0dXJuIC1FTk9TUEMgb24gZmFpbHVyZSwgd2hlbiBhbGxvY2F0
aW5nIE1TSS1YIHZlY3RvcnMgb25seSwNCj4gPiB3aGVyZWFzIHdpdGggTVNJIGZhbGxiYWNrIGl0
IHdpbGwgZm9yd2FyZCBhbnkgZXJyb3IgcmV0dXJuZWQgYnkNCj4gPiBfX3BjaV9lbmFibGVfbXNp
X3JhbmdlKCkuIFRoaXMgaXMgYSBjb25mdXNpbmcgYmVoYXZpb3VyLCBzbyBoYXZlIHRoZQ0KPiA+
IHBjaV9hbGxvY19pcnFfdmVjdG9yc19hZmZpbml0eSgpIGZvcndhcmQgdGhlIGVycm9yIGNvZGUg
ZnJvbQ0KPiA+IF9fcGNpX2VuYWJsZV9tc2l4X3JhbmdlKCkgd2hlbiBhcHByb3ByaWF0ZS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpb3RyIFN0YW5raWV3aWN6IDxwaW90ci5zdGFua2lld2lj
ekBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNo
ZXZjaGVua29AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9tc2kuYyB8IDUg
KysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9tc2kuYyBiL2RyaXZlcnMvcGNp
L21zaS5jDQo+ID4gaW5kZXggNmI0M2E1NDU1YzdhLi40NDNjYzMyNGIxOTYgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvbXNpLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9tc2kuYw0KPiA+
IEBAIC0xMjMxLDggKzEyMzEsOSBAQCBpbnQgcGNpX2FsbG9jX2lycV92ZWN0b3JzX2FmZmluaXR5
KHN0cnVjdCBwY2lfZGV2DQo+ICpkZXYsIHVuc2lnbmVkIGludCBtaW5fdmVjcywNCj4gPiAgCQl9
DQo+ID4gIAl9DQo+ID4NCj4gPiAtCWlmIChtc2l4X3ZlY3MgPT0gLUVOT1NQQykNCj4gPiAtCQly
ZXR1cm4gLUVOT1NQQzsNCj4gPiArCWlmIChtc2l4X3ZlY3MgPT0gLUVOT1NQQyB8fA0KPiA+ICsJ
ICAgIChmbGFncyAmIChQQ0lfSVJRX01TSSB8IFBDSV9JUlFfTVNJWCkpID09IFBDSV9JUlFfTVNJ
WCkNCj4gPiArCQlyZXR1cm4gbXNpeF92ZWNzOw0KPiA+ICAJcmV0dXJuIG1zaV92ZWNzOw0KPiA+
ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0wocGNpX2FsbG9jX2lycV92ZWN0b3JzX2FmZmluaXR5KTsN
Cj4gPg0KPiANCj4gSXQgb2NjdXJzIHRvIG1lIHRoYXQgd2UgY291bGQgY2xlYW4gdGhpcyBmdW5j
dGlvbiB1cCBhIGJpdCBtb3JlLi4uIEkNCj4gZG9uJ3Qgc2VlIGFueSBuZWVkIHRvIGhhdmUgdHdv
IHZhcmlhYmxlcyBmb3IgbXNpX3ZlY3MgYW5kIG1zaXhfdmVjcyBhbmQNCj4gdGhlbiBoYXZlIGEg
Y29tcGxpY2F0ZWQgYml0IG9mIGxvZ2ljIGF0IHRoZSBlbmQgdG8gZGVjaWRlIHdoaWNoIHRvIHJl
dHVybi4NCj4gDQo+IFdoeSBub3QgaW5zdGVhZCBqdXN0IGhhdmUgb25lIHZhcmlhYmxlIHdoaWNo
IGlzIHNldCBieQ0KPiBfX3BjaV9lbmFibGVfbXNpeF9yYW5nZSgpLCB0aGVuIF9fcGNpX2VuYWJs
ZV9tc2lfcmFuZ2UoKSwgdGhlbiByZXR1cm5lZA0KPiBpZiB0aGV5IGJvdGggZmFpbD8NCj4NCg0K
VGhhdCB3b3VsZG4ndCBwcmVzZXJ2ZSB0aGUgb3JpZ2luYWwgYml0IG9mIGxvZ2ljIHdoZXJlIC1F
Tk9TUEMgaXMgcmV0dXJuZWQNCmFueSB0aW1lIF9fcGNpX2VuYWJsZV9tc2l4X3JhbmdlKCkgZmFp
bHMgd2l0aCAtRU5PU1BDLCBpcnJlc3BlY3RpdmUgb2Ygd2hldGhlcg0KTVNJIGZhbGxiYWNrIHdh
cyByZXF1ZXN0ZWQuIFRob3VnaCBJIGRvbid0IGtub3cgaWYgdGhhdCBpcyBkZXNpcmVkIGJlaGF2
aW91ci4NCiANCkJSLA0KUGlvdHINCg==
