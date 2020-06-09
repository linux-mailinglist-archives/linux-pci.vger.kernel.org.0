Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB43D1F370C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgFIJ12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:27:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:50159 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgFIJ1U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:27:20 -0400
IronPort-SDR: kcN2xqS81Qf9Zj/6edpCn1dLLQtntsTaCB5+Kn+6fxdByfiiWAqN5OaQT/wbhTO3cemTsxIKZg
 8BWYLBz3eChQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:27:18 -0700
IronPort-SDR: yiZQjbBMNwmDIEvR2JwqjClOdo7NWyHuTMZ5qlIhNosH95XwQEovKsQGg0XriWRym0MTjtkliB
 sTOWrvQDLKfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="472906814"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2020 02:27:18 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jun 2020 02:27:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 9 Jun 2020 02:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXCP+nvumf1NsK5Mvezd6qQcRSTaeAyJpluo5FPscIlbB1O8E+4HbWG7ZJEghqgfXNlQ1Sr0FsCcb0HVyPGeWb0T9ID8BHk9gcnOmrqg70PNfmfZrjRe3hlK/lvwJnFKZ9Kz0rMtEp45zOihPyslIwdgqqqc9OLprTWTQBhmhLL/cZ4WoZXSkIl3QR1dcuArD3gX6rsWddjw2q5EDvwscQLf/hGvxxzfvx4E/zpX3A/2NiKMH0ZPV/7gfFq0sNHkJmQFD7JckwgBUb6RMCjFv/1dYHCCFLR2TxFkGhf6v7zMGI9ic9qADgfoRVOaLdWYB7XMAU4I8xBHQ/xg5HRJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KFzoIMRN3Hkj9feidBy2CTkdGPqqDzUp+ljZG2MYQI=;
 b=g3aWjs+aG507k2atzVe0KnsMmYsrdBkPD4Cq3oBbx2Ka+0nE6FX8vb1Fp2wgnwhmC0AxQEM/yravFNCVa3pYge4K5C1OV33NJngFdeklwhUOIxSRJlZMtiVrcEfdhGaPJCeA6MfClFCS8LMnuRjWiQFHd0IZKGDPbOZeDGHMDLW5XQfSNYxIVaKjtoRAU5ScyFt88oAMtVswoZAfIm222BJs5WBVvOPkGohRWSuxHwZFE1irw+TwI3J+xv5CaqNfhQ/1JAuKnka9PWjUvm1chSY3jRiLwI3ati3ZyWvahMmCQ6DNi2+JOMSCYB3CXAffl9MRuRPT930wLENFwoSI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KFzoIMRN3Hkj9feidBy2CTkdGPqqDzUp+ljZG2MYQI=;
 b=TirkZfWCTTWzISBfm/TeylHP3mY8vBJ/bghY+OdMA51SZ/pOMFVOx1dc59UuqlRThw9qYYqPvZR81/78uY4zz9WJBClJnqvDYLDd93ebXlhUqdJ+UIunSkUr8o/PJyV6aw3Hw6QBZUGAcL8V5YyX/QgF/ifGAA1FIbVwfkkzbxU=
Received: from CY4PR11MB1528.namprd11.prod.outlook.com (2603:10b6:910:d::12)
 by CY4PR11MB1368.namprd11.prod.outlook.com (2603:10b6:903:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 09:27:16 +0000
Received: from CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd]) by CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd%11]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 09:27:16 +0000
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
Thread-Index: AQHWOZyHaAYLXzqRs023OZ8sXbUNwKjHCZ0AgAABCJCAAAhsAIAI+FUw
Date:   Tue, 9 Jun 2020 09:27:05 +0000
Deferred-Delivery: Tue, 9 Jun 2020 09:26:11 +0000
Message-ID: <CY4PR11MB1528E7DA159FD5E39AD3228BF9820@CY4PR11MB1528.namprd11.prod.outlook.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
 <20200603114425.12734-1-piotr.stankiewicz@intel.com>
 <3bc1522b-33ba-04ee-4d8e-e4a31ec50756@deltatee.com>
 <CY4PR11MB152819A4C01C524E06A48EBFF9880@CY4PR11MB1528.namprd11.prod.outlook.com>
 <6bfeb14e-b2b7-3843-f417-1a2858859869@deltatee.com>
In-Reply-To: <6bfeb14e-b2b7-3843-f417-1a2858859869@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjhkOGE4NjgtNjg0NS00NGU4LWFlZTUtNWJkYTJhZDI2ZWFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibElJQmhmRUdWTTkwdzRYeXZUWHJWcmVqWlpkS2J0Z2Q0OWx1WmpjN3pkSG8zcnRJSFlxcnc4NUZaRVlPVXVnSyJ9
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.221.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8871a5f3-e3a6-470f-311b-08d80c574cde
x-ms-traffictypediagnostic: CY4PR11MB1368:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1368B954E1242F971B103F7CF9820@CY4PR11MB1368.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uMLYFichEtlrXJXRmsR9bOzZ68aD/rWP6JcjFXsvtgP24IyybqeLxmlbquhV6+OxBnGzWszZRddbN3whcd+7f6V3BsnAbkI92XUz9gVeM0gQWUzADdLYP+0ZAb/J3BZTLcpX8Va1Rh7hni4QLESOCkRYaabjhGjvLZ8mUIxeiGC8h9trjvjYGH74EXfCKQYT40jDPNPI0MZ4/fsFvKIC2nGSMqG4CBjpj4GuiB02v9WWIv8nakCbXHiaB0+vZ2IiaPzLznLDlBzBvK7V8L0SK1s518gtMHXwVwrtmQkKPpFRf5x3wR2+C/JpHolHuYjAM9fuoFGxgNUAaANOt758w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(8936002)(71200400001)(110136005)(4326008)(66946007)(6506007)(316002)(54906003)(7696005)(2906002)(478600001)(66476007)(76116006)(9686003)(64756008)(55016002)(5660300002)(52536014)(66446008)(53546011)(66556008)(8676002)(26005)(33656002)(6666004)(83380400001)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ttaYPZq1jtCo2Bcs8Dv0JkTKb7gXkxjXiZN+j/+h5VdmXlSDvf+uUis/1Tfrg0JWCn6DjBeqanPtQ/DX/+4eXM577V8W8k2FuqM/E5Sel1IIYCwa87d40QUtiRQ7Lby2dEXsjgXGHmRH+9883H7itOgdRa8Cqa79b2qBtbf4MoCDo2Gn3Wdi3HJTzVLACLyrNeRNGceY4XYM7aNqZ8Ra3QYZRWAMQrOTtU1cGx7t5hj2fiDtrR7QIQ+MfDhbkQxivHhWLADNRiPi/fMdh0hMEFL6UYn3ByXXG/6GxcLDVCIXlE2+JtLKOiDZeDxxHQJCpCu1wbhaVLONETGNCVo4OIh38QM+i01cjTFQ0Kajw3yV+ntvdCYP6ofnaxbg6D1Chp2MhAK9AlqEH5Z7q7CIoX8mL/Y6cBBDp/SI/RJ4lN7cqQIQlviJisC3+t+6qX8kdzhm+1S7nTOrMWVTczjXNTfgMH9snE2wdVxNGBfInv1LwT8ssNiFLpsMJk0u4n4w
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8871a5f3-e3a6-470f-311b-08d80c574cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 09:27:16.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYSKCN1x+bjoSz/hFuEMAcxr4qAahnhu3f8PS9/OGnCZ5RIFj0pZE1+MOgXOTto1OBp82G38SYUpZw7NMNxCS6QFXrLkTlon+pN86vp2ZsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1368
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2dhbiBHdW50aG9ycGUgPGxv
Z2FuZ0BkZWx0YXRlZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAzLCAyMDIwIDY6MjIg
UE0gDQo+IA0KPiANCj4gT24gMjAyMC0wNi0wMyAxMDowNCBhLm0uLCBTdGFua2lld2ljeiwgUGlv
dHIgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IExv
Z2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5
LCBKdW5lIDMsIDIwMjAgNTo0OCBQTQ0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyMDIwLTA2
LTAzIDU6NDQgYS5tLiwgUGlvdHIgU3RhbmtpZXdpY3ogd3JvdGU6DQo+ID4+PiBXaGVuIGRlYnVn
Z2luZyBhbiBpc3N1ZSB3aGVyZSBJIHdhcyBhc2tpbmcgdGhlIFBDSSBtYWNoaW5lcnkgdG8gZW5h
YmxlIGENCj4gPj4+IHNldCBvZiBNU0ktWCB2ZWN0b3JzLCB3aXRob3V0IGZhbGxpbmcgYmFjayBv
biBNU0ksIEkgcmFuIGFjcm9zcyBhDQo+ID4+PiBiZWhhdmlvdXIgd2hpY2ggc2VlbXMgb2RkLiBU
aGUgcGNpX2FsbG9jX2lycV92ZWN0b3JzX2FmZmluaXR5KCkgd2lsbA0KPiA+Pj4gYWx3YXlzIHJl
dHVybiAtRU5PU1BDIG9uIGZhaWx1cmUsIHdoZW4gYWxsb2NhdGluZyBNU0ktWCB2ZWN0b3JzIG9u
bHksDQo+ID4+PiB3aGVyZWFzIHdpdGggTVNJIGZhbGxiYWNrIGl0IHdpbGwgZm9yd2FyZCBhbnkg
ZXJyb3IgcmV0dXJuZWQgYnkNCj4gPj4+IF9fcGNpX2VuYWJsZV9tc2lfcmFuZ2UoKS4gVGhpcyBp
cyBhIGNvbmZ1c2luZyBiZWhhdmlvdXIsIHNvIGhhdmUgdGhlDQo+ID4+PiBwY2lfYWxsb2NfaXJx
X3ZlY3RvcnNfYWZmaW5pdHkoKSBmb3J3YXJkIHRoZSBlcnJvciBjb2RlIGZyb20NCj4gPj4+IF9f
cGNpX2VuYWJsZV9tc2l4X3JhbmdlKCkgd2hlbiBhcHByb3ByaWF0ZS4NCj4gPj4+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBQaW90ciBTdGFua2lld2ljeiA8cGlvdHIuc3RhbmtpZXdpY3pAaW50ZWwu
Y29tPg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVu
a29AaW50ZWwuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9wY2kvbXNpLmMgfCA1ICsr
Ky0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvbXNpLmMgYi9kcml2ZXJz
L3BjaS9tc2kuYw0KPiA+Pj4gaW5kZXggNmI0M2E1NDU1YzdhLi40NDNjYzMyNGIxOTYgMTAwNjQ0
DQo+ID4+PiAtLS0gYS9kcml2ZXJzL3BjaS9tc2kuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9wY2kv
bXNpLmMNCj4gPj4+IEBAIC0xMjMxLDggKzEyMzEsOSBAQCBpbnQgcGNpX2FsbG9jX2lycV92ZWN0
b3JzX2FmZmluaXR5KHN0cnVjdCBwY2lfZGV2DQo+ID4+ICpkZXYsIHVuc2lnbmVkIGludCBtaW5f
dmVjcywNCj4gPj4+ICAJCX0NCj4gPj4+ICAJfQ0KPiA+Pj4NCj4gPj4+IC0JaWYgKG1zaXhfdmVj
cyA9PSAtRU5PU1BDKQ0KPiA+Pj4gLQkJcmV0dXJuIC1FTk9TUEM7DQo+ID4+PiArCWlmIChtc2l4
X3ZlY3MgPT0gLUVOT1NQQyB8fA0KPiA+Pj4gKwkgICAgKGZsYWdzICYgKFBDSV9JUlFfTVNJIHwg
UENJX0lSUV9NU0lYKSkgPT0gUENJX0lSUV9NU0lYKQ0KPiA+Pj4gKwkJcmV0dXJuIG1zaXhfdmVj
czsNCj4gPj4+ICAJcmV0dXJuIG1zaV92ZWNzOw0KPiA+Pj4gIH0NCj4gPj4+ICBFWFBPUlRfU1lN
Qk9MKHBjaV9hbGxvY19pcnFfdmVjdG9yc19hZmZpbml0eSk7DQo+ID4+Pg0KPiA+Pg0KPiA+PiBJ
dCBvY2N1cnMgdG8gbWUgdGhhdCB3ZSBjb3VsZCBjbGVhbiB0aGlzIGZ1bmN0aW9uIHVwIGEgYml0
IG1vcmUuLi4gSQ0KPiA+PiBkb24ndCBzZWUgYW55IG5lZWQgdG8gaGF2ZSB0d28gdmFyaWFibGVz
IGZvciBtc2lfdmVjcyBhbmQgbXNpeF92ZWNzIGFuZA0KPiA+PiB0aGVuIGhhdmUgYSBjb21wbGlj
YXRlZCBiaXQgb2YgbG9naWMgYXQgdGhlIGVuZCB0byBkZWNpZGUgd2hpY2ggdG8gcmV0dXJuLg0K
PiA+Pg0KPiA+PiBXaHkgbm90IGluc3RlYWQganVzdCBoYXZlIG9uZSB2YXJpYWJsZSB3aGljaCBp
cyBzZXQgYnkNCj4gPj4gX19wY2lfZW5hYmxlX21zaXhfcmFuZ2UoKSwgdGhlbiBfX3BjaV9lbmFi
bGVfbXNpX3JhbmdlKCksIHRoZW4gcmV0dXJuZWQNCj4gPj4gaWYgdGhleSBib3RoIGZhaWw/DQo+
ID4+DQo+ID4NCj4gPiBUaGF0IHdvdWxkbid0IHByZXNlcnZlIHRoZSBvcmlnaW5hbCBiaXQgb2Yg
bG9naWMgd2hlcmUgLUVOT1NQQyBpcyByZXR1cm5lZA0KPiA+IGFueSB0aW1lIF9fcGNpX2VuYWJs
ZV9tc2l4X3JhbmdlKCkgZmFpbHMgd2l0aCAtRU5PU1BDLCBpcnJlc3BlY3RpdmUgb2YNCj4gd2hl
dGhlcg0KPiA+IE1TSSBmYWxsYmFjayB3YXMgcmVxdWVzdGVkLiBUaG91Z2ggSSBkb24ndCBrbm93
IGlmIHRoYXQgaXMgZGVzaXJlZCBiZWhhdmlvdXIuDQo+IA0KPiBUaGF0IGRvZXMgbG9vayB2ZXJ5
IG9kZCwgYnV0IG9rLi4uIFRoZW4sIGNvdWxkbid0IHdlIGp1c3Qgc2V0IG1zaV92ZWNzDQo+IHRv
IG1zaXhfdmVjcyBhZnRlciBjYWxsaW5nIF9fcGNpX2VuYWJsZV9tc2l4X3JhbmdlKCkgc3VjaCB0
aGF0IGlmDQo+IF9fcGNpX2VuYWJsZV9tc2lfcmFuZ2UoKSBkb2Vzbid0IGdldCBjYWxsZWQgd2Ug
d2lsbCByZXR1cm4gdGhlIHNhbWUNCj4gZXJyb3Igd2l0aG91dCBuZWVkaW5nIHRoZSBtZXNzeSBz
ZWNvbmQgY29uZGl0aW9uYWw/DQoNCkhhdmluZyB0aG91Z2h0IGFib3V0IGl0IGEgYml0IG1vcmUg
LSB0aGUgb3JpZ2luYWwgYmVoYXZpb3Igc2VlbXMgYnJva2VuIGJlY2F1c2UNCmluIGNhc2Ugc29t
ZW9uZSBhc2tlZCBmb3IgTVNJIG9ubHkgYW5kIHRoYXQgZXJyb3JlZCB3ZSdkIGFsd2F5cyByZXR1
cm4gLUVOT1NQQy4NClNvIEkgd2VudCB3aXRoIHlvdXIgb3JpZ2luYWwgc3VnZ2VzdGlvbiBvZiBo
YXZpbmcgYSBzaW5nbGUgcmV0dXJuIGNvZGUgKEkganVzdCBzZW50IG91dA0KYSB2MykuDQoNClRo
YW5rcywNClBpb3RyDQo=
