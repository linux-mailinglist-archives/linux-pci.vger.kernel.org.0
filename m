Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F87DC32
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2019 15:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfHANJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 09:09:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:28092 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfHANJw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Aug 2019 09:09:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 06:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="174624320"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2019 06:09:34 -0700
Received: from irsmsx156.ger.corp.intel.com (10.108.20.68) by
 irsmsx105.ger.corp.intel.com (163.33.3.28) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 1 Aug 2019 14:09:33 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.88]) by
 IRSMSX156.ger.corp.intel.com ([169.254.3.73]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 14:09:33 +0100
From:   "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>
CC:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: RE: [PATCH] PCI/AER: save/restore AER registers during
 suspend/resume
Thread-Topic: [PATCH] PCI/AER: save/restore AER registers during
 suspend/resume
Thread-Index: AdU2K450PVQcsHkmQ527SJKW7DkoygAUInqAAB190NAAEuIZAALCgh8AACzLCgAACfqukAAojs8AAMRc64AAZPRK0A==
Date:   Thu, 1 Aug 2019 13:09:32 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28479A8847D@IRSMSX101.ger.corp.intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B28479A7F14D@IRSMSX101.ger.corp.intel.com>
 <1fbfe79b-0123-7305-5fc3-4963599538a3@linux.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B28479A7F9BA@IRSMSX101.ger.corp.intel.com>
 <cd3cb1af-bc80-f92d-b9e4-7b7c2a9bd2fb@linux.intel.com>
 <20190724184548.GC203187@google.com>
 <20190725160822.GB6949@localhost.localdomain>
 <92EBB4272BF81E4089A7126EC1E7B28479A8704C@IRSMSX101.ger.corp.intel.com>
 <20190726161524.GA8437@localhost.localdomain>
 <20190730135753.GI203187@google.com>
In-Reply-To: <20190730135753.GI203187@google.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmNmZDc1OWUtMjg0Yy00MmIzLThjN2MtZjYwMWFkYjZmMDQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicGh5ZUpLbXcyaWhHXC9xUkpGd25GT0t3TEI3WDlYazdFamZ2bHR3ME1pb0FvczFOazl6dWJsaHFFUFY5YUJsZVYifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiANCj4gT24gRnJpLCBKdWwgMjYsIDIwMTkgYXQgMTA6MTU6MjRBTSAtMDYwMCwgS2VpdGggQnVz
Y2ggd3JvdGU6DQo+ID4gT24gRnJpLCBKdWwgMjYsIDIwMTkgYXQgMDI6MDA6MDVBTSAtMDcwMCwg
UGF0ZWwsIE1heXVya3VtYXIgd3JvdGU6DQo+ID4gPiA+IFRoZSBjYWxsIHRvIHBjaV9zYXZlX3N0
YXRlIG1vc3QgbGlrZWx5IG9jY3VycyBsb25nIGJlZm9yZSBhIHVzZXIgaGFzIGFuDQo+ID4gPiA+
IG9wcG9ydHVuaXR5IHRvIGFsdGVyIHRoZXNlIHJlZ3NpdGVycywgdGhvdWdoLiBXb24ndCB0aGlz
IGp1c3QgcmVzdG9yZQ0KPiA+ID4gPiB3aGF0IHdhcyBwcmV2aW91c2x5IHRoZXJlLCBhbmQgbm90
IHRoZSBzdGF0ZSB5b3UgY2hhbmdlZCBpdCB0bz8NCj4gPiA+DQo+ID4gPiBUaGVyZSB3ZXJlIHR3
byB0aGluZ3MgKG5vdCBzdXJlIHRvIGNhbGwgdGhlbSBpc3N1ZXMpLA0KPiA+ID4gMS4gUENJX0VS
Ul9ST09UX0NPTU1BTkQgcmVzZXRzIHRvIDAgIGR1cmluZyBTMyBlbnRyeS9leGl0LCB3aGljaCBk
aXNhYmxlcyBBRVIgaW50ZXJydXB0IHRyaWdnZXINCj4gPiA+IGlmIEFFUiBoYXBwZW5zIG9uIEVu
ZHBvaW50IGFmdGVyIHJlc3VtZS4NCj4gPiA+DQo+ID4gPiBBbHNvIHNwZWNpZmllZCBpbiBzcGVj
LiBOQ0ItUENJX0V4cHJlc3NfQmFzZV80LjByMS4wX1NlcHRlbWJlci0yNy0yMDE3LWMucGRmIGlu
DQo+ID4gPiBjaGFwdGVyIDcuOC40LjkgUm9vdCBFcnJvciBDb21tYW5kIFJlZ2lzdGVyIChPZmZz
ZXQgMkNoKSAtIGluIGJpdGZpZWxkcyBkZXNjcmlwdGlvbnMuDQo+ID4gPiBpLmUuIENvcnJlY3Rh
YmxlIEVycm9yIFJlcG9ydGluZyBFbmFibGUg4oCTIFdoZW4gU2V0LCB0aGlzIGJpdCBlbmFibGVz
IHRoZSBnZW5lcmF0aW9uIG9mIGFuIGludGVycnVwdCB3aGVuDQo+ID4gPiBhIGNvcnJlY3RhYmxl
IGVycm9yIGlzIHJlcG9ydGVkIGJ5IGFueSBvZiB0aGUgRnVuY3Rpb25zIGluIHRoZSBIaWVyYXJj
aHkgRG9tYWluIGFzc29jaWF0ZWQgd2l0aCB0aGlzIFJvb3QgUG9ydC4NCj4gPiA+DQo+ID4gPiAy
LiBSb290IHBvcnQgcmVzZXRzIHRvIGl0cyBkZWZhdWx0IGNvbmZpZ3VyYXRpb24gb2YgVU5DT1Jf
TUFTSy9TRVZFUi9DT1JfTUFTSyByZWdpc3RlciBiaXRzIGFmdGVyIHN5c3RlbSByZXN1bWUuDQo+
ID4gPiBUaGlzIGluZmx1ZW5jZXMgdXNlciBjb25maWd1cmF0aW9ucywgaG93IGVycm9ycyBzaGFs
bCBiZSB0cmVhdGVkIGlmIEFFUiBoYXBwZW5zIG9uIHJvb3QgcG9ydCBpdHNlbGYgZHVlIHRvIERl
dmljZSAoZm9yIGV4YW1wbGUNCj4gPiA+IEVuZHBvaW50IG5vdCBhbnN3ZXJpbmcgd2hpY2ggcmVz
dWx0cyBpbiBjb21wbGV0aW9uIHRpbWVvdXRzIG9uIHJvb3QgcG9ydHMpLg0KPiA+ID4NCj4gPiA+
IEZvbGxvd2luZyBpcyBvbmUgZXhhbXBsZSBzY2VuYXJpbyB3aGljaCBjYW4gaGFuZGxlZCB3aXRo
IHRoaXMgcGF0Y2guDQo+ID4gPiAtIHVzZXIgY29uZmlndXJlcyBBRVIgcmVnaXN0ZXJzIHVzaW5n
IHNldHBjaSBjZXJ0YWluIG1hc2tzIGFuZCBzZXZlcml0eSBiYXNlZCBvbiBkZWJ1ZyByZXF1aXJl
bWVudHMuIFRoaXMgY2FuIGJlIGFwcGxpZWQgb24gUm9vdCBwb3J0IG9mDQo+IEVQLg0KPiA+ID4g
LSB0cmlnZ2VycyBzeXN0ZW0gdGVzdCB3aGljaCBpbmNsdWRlcyBTMyBlbnRyeS9leGl0IGN5Y2xl
cy4NCj4gPiA+IC0gc3lzdGVtIGVudGVycyBzMyAtPiBBRVIgcmVnaXN0ZXJzIHNldHRpbmdzIGFy
ZSBzYXZlZCB3aGljaCBoYXMgYmVlbiBjb25maWd1cmVkIGJ5IHVzZXJzLg0KPiA+ID4gLSBzeXN0
ZW0gZXhpdHMgczMgLT4gQUVSIHJlZ2lzdGVycyBzZXR0aW5ncyBhcmUgcmVzdG9yZWQgd2hpY2gg
aGFzIGJlZW4gY29uZmlndXJlZCBieSB1c2Vycy4NCj4gPg0KPiA+IFJpZ2h0LCBJIHdhcyBqdXN0
IG1vcmUgY3VyaW91cyAqd2hlcmUqIHRoZSBhZXIgc3RhdGUgd2FzIGJlaW5nIHNhdmVkDQo+ID4g
ZHVyaW5nIHN1c3BlbmQgc2luY2UgcGNpIHBvcnQgZHJpdmVyIG9ubHkgc2F2ZXMgc3RhdGUgZHVy
aW5nIHByb2JlLiBUaGlzDQo+ID4gcGF0Y2ggbXVzdCBiZSByZWx5aW5nIG9uIHRoZSBnZW5lcmlj
IHBjaS1kcml2ZXIncyBwb3dlciBtYW5hZ2VtZW50LiBJDQo+ID4gdGhpbmsgdGhhdCB3b3Jrcywg
YnV0IEkganVzdCBkaWRuJ3QgcmVhbGl6ZSBpbml0aWFsbHkgdGhhdCB3ZSdyZSByZWx5aW5nDQo+
ID4gb24gdGhhdCBwYXRoLg0KPiANCj4gSSBhZ3JlZSB0aGF0IHdlIHNob3VsZCBzYXZlIHRoZSBB
RVIgc3RhdGUgYXQgc3VzcGVuZC10aW1lLCBub3QganVzdCBhdA0KPiBwcm9iZS10aW1lLiAgSSAq
dGhpbmsqIHRoaXMgc2hvdWxkIGhhcHBlbiBhbHJlYWR5IHZpYSB0aGUNCj4gcGNpX3NhdmVfc3Rh
dGUoKSBjYWxscyBpbiBwY2lfcG1fc3VzcGVuZF9ub2lycSgpLCBldGMuDQo+IA0KPiA+ID4gPiBZ
b3UgYXJlIGFsbG9jYXRpbmcgdGhlIGNhcGFiaWxpdHkgc2F2ZSBidWZmZXIgaW4gYWVyX3Byb2Jl
KCksIHNvIHRoaXMNCj4gPiA+ID4gc2F2ZS9yZXN0b3JlIGFwcGxpZXMgb25seSB0byByb290IHBv
cnRzLiBCdXQgeW91IG1lbnRpb24gYWJvdmUgdGhhdCB5b3UNCj4gPiA+ID4gd2FudCB0byByZXN0
b3JlIGVuZCBkZXZpY2VzLCByaWdodD8NCj4gPiA+DQo+ID4gPiBUaGF04oCZcyBjb3JyZWN0LiBJ
IGFncmVlIHRoYXQgbXkgY29tbWl0IG1lc3NhZ2Ugd2FzIG5vdCBzbyBleHBsaWNpdC4NCj4gPiA+
IEJ1dCBTaW5jZSBJIGluY2x1ZGVkIFBDSV9FUlJfUk9PVF9DT01NQU5EIHJlZ2lzdGVyIGZvciBz
YXZlL3Jlc3RvcmUgd2hpY2ggaXMgc3BlY2lmaWMgdG8gUm9vdCBwb3J0cyBvbmx5ICYgSSB0aG91
Z2h0DQo+ID4gPiBlbmRwb2ludCBkcml2ZXJzIGNhbiBoYW5kbGUgdG8gc2F2ZS9yZXN0b3JlIChV
TkNPUl9NQVNLL1NFVkVSL0NPUl9NQVNLKSB0aGVtc2VsdmVzIHdpdGggaXRzIHN1c3BlbmQvcmVz
dW1lIGZ1bmN0aW9ucy4NCj4gPiA+DQo+ID4gPiBIb3dldmVyIEkgYW0gZmluZSB0byBtb3ZlIHBj
aV9hZGRfZXh0X2NhcF9zYXZlX2J1ZmZlcigpIHRvIHNvbWUgb3RoZXIgZnVuY3Rpb24gc28NCj4g
PiA+IHRoYXQgaXQgYWxzbyBzYXZlL3Jlc3RvcmVzIFVOQ09SX01BU0svU0VWRVIvQ09SX01BU0sg
cmVnaXN0ZXJzIGZvciBlbmRwb2ludHMgYW5kDQo+ID4gPiBpZiBpdCdzIG5vdCB1c2VmdWwgdG8g
c2F2ZS9yZXN0b3JlIE1BU0sgJiBTRVZFUiByZWdpc3RlcnMgIHRoZW4gYWxzbyBmaW5lIHRvIHJl
bW92ZSB0aGVtDQo+ID4gPiBhbmQganVzdCByZXN0b3JlIFBDSV9FUlJfUk9PVF9DT01NQU5EICYg
RUNSQyBzZXR0aW5ncy4gIFBsZWFzZSBsZXQgbWUga25vdy4NCj4gPg0KPiA+IElmIHVzZXJzIGFy
ZSBjaGFuZ2luZyBkZWZhdWx0IHNldHRpbmdzIHRoYXQgeW91IHdhbnQgdG8gcHJlc2VydmUsIHRo
YXQNCj4gPiByZWFzb24gc2hvdWxkIGFwcGx5IHRvIGJyaWRnZXMgYW5kIGVuZHBvaW50cyB0b28s
IHNvIEkgdGhpbmsgeW91IG91Z2h0DQo+ID4gdG8gYWxsb2NhdGUgdGhlIHNhdmUgYnVmZmVyIGZv
ciB0aGlzIGNhcGFiaWxpdHkgZm9yIGFsbCBkZXZpY2VzIHRoYXQNCj4gPiBzdXBwb3J0IGl0IGlu
IGluIHBjaV9hZXJfaW5pdCgpLiBKdXN0IG1ha2Ugc3VyZSB0byBjaGVjayB0aGUgZGV2aWNlIHR5
cGUNCj4gPiBpbiBzYXZlL3Jlc3RvcmUgc28geW91J3JlIG5vdCBhY2Nlc3Npbmcgcm9vdCBwb3J0
IHNwZWNpZmljIHJlZ2lzdGVycy4NCj4gDQo+IEkgYWdyZWUsIEkgdGhpbmsgd2UgbmVlZCB0byBz
YXZlL3Jlc3RvcmUgQUVSIHNldHRpbmdzIGZvciBhbGwgZGV2aWNlcywNCj4gbm90IGp1c3QgYnJp
ZGdlcy4NCj4gDQoNClRoYW5rcyBmb3IgcmVwbGllcy4gSSB3aWxsIHVwZGF0ZSBteSBwYXRjaCBh
Y2NvcmRpbmdseSBhbmQgcG9zdCBhIHJldmlzZWQgb25lLg0KDQo+IEJqb3JuDQpJbnRlbCBEZXV0
c2NobGFuZCBHbWJIClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMC0xMiwgODU1Nzkg
TmV1YmliZXJnLCBHZXJtYW55ClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwgd3d3LmludGVsLmRlCk1h
bmFnaW5nIERpcmVjdG9yczogQ2hyaXN0aW4gRWlzZW5zY2htaWQsIEdhcnkgS2Vyc2hhdwpDaGFp
cnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUKUmVnaXN0ZXJlZCBP
ZmZpY2U6IE11bmljaApDb21tZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBI
UkIgMTg2OTI4Cg==

