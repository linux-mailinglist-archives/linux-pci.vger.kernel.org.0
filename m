Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D87F1D03B8
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 02:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEMAiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 20:38:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:12636 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgEMAiv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 May 2020 20:38:51 -0400
IronPort-SDR: NHjwjPfzm++DiH401j5jTh3nE7kbMOiawEoUCW6/2hTMAnabnxUZvuEYX6hi+hdjjCbn5uLg06
 cp/a1rBUJ9Lg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 17:35:49 -0700
IronPort-SDR: AyFd3pus07WNvU6S+zu/F5J/HlA7T67n7upCWppGmWg6TGnWwbqXTKz8h/DbX1T5bd7aXRnwv3
 WZ6oFsD8F0Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,385,1583222400"; 
   d="scan'208";a="280321256"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga002.jf.intel.com with ESMTP; 12 May 2020 17:35:49 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 May 2020 17:35:48 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.116]) with mapi id 14.03.0439.000;
 Tue, 12 May 2020 17:35:48 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH for QEMU v2] hw/vfio: Add VMD Passthrough Quirk
Thread-Topic: [PATCH for QEMU v2] hw/vfio: Add VMD Passthrough Quirk
Thread-Index: AQHWJ8jLhzj2DHdp5kGlhUP8edKhKKij9WuAgAGtPgA=
Date:   Wed, 13 May 2020 00:35:47 +0000
Message-ID: <91c6795937035d6ad72cb78c7997ba8168f643c5.camel@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
         <20200511190129.9313-2-jonathan.derrick@intel.com>
         <20200511165927.27b41d65@w520.home>
In-Reply-To: <20200511165927.27b41d65@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.4.28]
Content-Type: text/plain; charset="utf-8"
Content-ID: <97618F2C992A0E4AAE7859582A4EBE55@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQWxleCwNCg0KSSdtIHByb2JhYmx5IG5vdCBnZXR0aW5nIHRoZSB0cmFuc2xhdGlvbiB0ZWNo
bmljYWwgZGV0YWlscyBjb3JyZWN0Lg0KDQpPbiBNb24sIDIwMjAtMDUtMTEgYXQgMTY6NTkgLTA2
MDAsIEFsZXggV2lsbGlhbXNvbiB3cm90ZToNCj4gT24gTW9uLCAxMSBNYXkgMjAyMCAxNTowMToy
NyAtMDQwMA0KPiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+IHdyb3Rl
Og0KPiANCj4gPiBUaGUgVk1EIGVuZHBvaW50IHByb3ZpZGVzIGEgcmVhbCBQQ0llIGRvbWFpbiB0
byB0aGUgZ3Vlc3QsIGluY2x1ZGluZw0KPiANCj4gUGxlYXNlIGRlZmluZSBWTUQuICBJJ20gc3Vy
ZSB0aGlzIGlzIG9idmlvdXMgdG8gbWFueSwgYnV0IEkndmUgaGFkIHRvDQo+IGRvIHNvbWUgcmVz
ZWFyY2guICBUaGUgYmVzdCBUTDtEUiBzdW1tYXJ5IEkndmUgZm91bmQgaXMgS2VpdGgncw0KPiBv
cmlnaW5hbCBjb21taXQgMTg1YTM4M2FkYTJlIGFkZGluZyB0aGUgY29udHJvbGxlciB0byBMaW51
eC4gIElmIHRoZXJlJ3MNCj4gc29tZXRoaW5nIGJldHRlciwgcGxlYXNlIGxldCBtZSBrbm93Lg0K
VGhhdCdzIHRoZSBjb3JyZWN0IGNvbW1pdCwgYnV0IEknbGwgdHJ5IHRvIHN1bW1hcml6ZSB0aGUg
aW1wb3J0YW50IGJpdHMNCmZvciB2My4NCg0KPiANCj4gPiBicmlkZ2VzIGFuZCBlbmRwb2ludHMu
IEJlY2F1c2UgdGhlIFZNRCBkb21haW4gaXMgZW51bWVyYXRlZCBieSB0aGUgZ3Vlc3QNCj4gPiBr
ZXJuZWwsIHRoZSBndWVzdCBrZXJuZWwgd2lsbCBhc3NpZ24gR3Vlc3QgUGh5c2ljYWwgQWRkcmVz
c2VzIHRvIHRoZQ0KPiA+IGRvd25zdHJlYW0gZW5kcG9pbnQgQkFScyBhbmQgYnJpZGdlIHdpbmRv
d3MuDQo+ID4gDQo+ID4gV2hlbiB0aGUgZ3Vlc3Qga2VybmVsIHBlcmZvcm1zIE1NSU8gdG8gVk1E
IHN1Yi1kZXZpY2VzLCBJT01NVSB3aWxsDQo+ID4gdHJhbnNsYXRlIGZyb20gdGhlIGd1ZXN0IGFk
ZHJlc3Mgc3BhY2UgdG8gdGhlIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UuDQo+ID4gQmVjYXVzZSB0
aGUgYnJpZGdlcyBoYXZlIGJlZW4gcHJvZ3JhbW1lZCB3aXRoIGd1ZXN0IGFkZHJlc3NlcywgdGhl
DQo+ID4gYnJpZGdlcyB3aWxsIHJlamVjdCB0aGUgdHJhbnNhY3Rpb24gY29udGFpbmluZyBwaHlz
aWNhbCBhZGRyZXNzZXMuDQo+IA0KPiBJJ20gbG9zdCwgd2hhdCBJT01NVSBpcyBpbnZvbHZlZCBp
biBDUFUgYWNjZXNzIHRvIE1NSU8gc3BhY2U/ICBNeSBndWVzcw0KPiBpcyB0aGF0IHNpbmNlIGFs
bCBNTUlPIG9mIHRoaXMgZG9tYWluIGlzIG1hcHBlZCBiZWhpbmQgdGhlIGhvc3QNCj4gZW5kcG9p
bnQgQkFScyAyICYgNCB0aGF0IFFFTVUgc2ltcGx5IGFjY2Vzc2VzIGl0IHZpYSBtYXBwaW5nIG9m
IHRob3NlDQo+IEJBUnMgaW50byB0aGUgVk0sIHNvIGl0J3MgdGhlIE1NVSwgbm90IHRoZSBJT01N
VSBwZXJmb3JtaW5nIHRob3NlIEdQQQ0KPiB0byBIUEEgdHJhbnNsYXRpb25zLiAgQnV0IHRoZW4g
cHJlc3VtYWJseSB0aGUgYnJpZGdlcyB3aXRoaW4gdGhlIGRvbWFpbg0KPiBhcmUgc2NyYW1ibGVk
IGJlY2F1c2UgdGhlaXIgYXBlcnR1cmVzIGFyZSBwcm9ncmFtbWVkIHdpdGggcmFuZ2VzIHRoYXQN
Cj4gZG9uJ3QgbWFwIGludG8gdGhlIFZNRCBlbmRwb2ludCBCQVJzLiAgSXMgdGhhdCByZW1vdGVs
eSBjb3JyZWN0PyAgU29tZQ0KPiAvcHJvYy9pb21lbSBvdXRwdXQgYW5kL29yIGxzcGNpIGxpc3Rp
bmcgZnJvbSB0aGUgaG9zdCB0byBzZWUgaG93IHRoaXMNCj4gd29ya3Mgd291bGQgYmUgdXNlZnVs
Lg0KQ29ycmVjdC4gU28gTU1VIG5vdCBJT01NVS4NCg0KSW4gdGhlIGd1ZXN0IGtlcm5lbCwgdGhl
IGJyaWRnZXMgYW5kIGRldmljZXMgaW4gdGhlIFZNRCBkb21haW4gYXJlDQpwcm9ncmFtbWVkIHdp
dGggdGhlIGFkZHJlc3NlcyBwcm92aWRlZCBpbiB0aGUgVk1EIGVuZHBvaW50J3MgQkFSMiY0DQoo
TUVNQkFSMSYyKS4gQmVjYXVzZSB0aGVzZSBCQVJzIGFyZSBwb3B1bGF0ZWQgd2l0aCBndWVzdCBh
ZGRyZXNzZXMsIE1NVQ0KdHJhbnNsYXRlcyB0byBob3N0IHBoeXNpY2FsIGFuZCB0aGUgYnJpZGdl
IHdpbmRvdyByZWplY3RzIE1NSU8gbm90IGluDQppdHMgW0dQQV0gcmFuZ2UuDQoNCkFzIGFuIGV4
YW1wbGU6DQpIb3N0Og0KICA5NDAwMDAwMC05N2ZmZmZmZiA6IDAwMDA6MTc6MDUuNQ0KICAgIDk0
MDAwMDAwLTk3ZmZmZmZmIDogVk1EIE1FTUJBUjENCiAgICAgIDk0MDAwMDAwLTk0M2ZmZmZmIDog
UENJIEJ1cyAxMDAwMDowMQ0KICAgICAgICA5NDAwMDAwMC05NDAwZmZmZiA6IDEwMDAwOjAxOjAw
LjANCiAgICAgICAgOTQwMTAwMDAtOTQwMTNmZmYgOiAxMDAwMDowMTowMC4wDQogICAgICAgICAg
OTQwMTAwMDAtOTQwMTNmZmYgOiBudm1lDQogICAgICA5NDQwMDAwMC05NDdmZmZmZiA6IFBDSSBC
dXMgMTAwMDA6MDENCiAgICAgIDk0ODAwMDAwLTk0YmZmZmZmIDogUENJIEJ1cyAxMDAwMDowMg0K
ICAgICAgICA5NDgwMDAwMC05NDgwZmZmZiA6IDEwMDAwOjAyOjAwLjANCiAgICAgICAgOTQ4MTAw
MDAtOTQ4MTNmZmYgOiAxMDAwMDowMjowMC4wDQogICAgICAgICAgOTQ4MTAwMDAtOTQ4MTNmZmYg
OiBudm1lDQogICAgICA5NGMwMDAwMC05NGZmZmZmZiA6IFBDSSBCdXMgMTAwMDA6MDINCg0KDQpN
RU1CQVIgMiBpcyBzaW1pbGFybHkgYXNzaWduZWQNCg0KPiANCj4gPiBWTUQgZGV2aWNlIDI4QzAg
bmF0aXZlbHkgYXNzaXN0cyBwYXNzdGhyb3VnaCBieSBwcm92aWRpbmcgdGhlIEhvc3QNCj4gPiBQ
aHlzaWNhbCBBZGRyZXNzIGluIHNoYWRvdyByZWdpc3RlcnMgYWNjZXNzaWJsZSB0byB0aGUgZ3Vl
c3QgZm9yIGJyaWRnZQ0KPiA+IHdpbmRvdyBhc3NpZ25tZW50LiBUaGUgc2hhZG93IHJlZ2lzdGVy
cyBhcmUgdmFsaWQgaWYgYml0IDEgaXMgc2V0IGluIFZNRA0KPiA+IFZNTE9DSyBjb25maWcgcmVn
aXN0ZXIgMHg3MC4gRnV0dXJlIFZNRHMgd2lsbCBhbHNvIHN1cHBvcnQgdGhpcyBmZWF0dXJlLg0K
PiA+IEV4aXN0aW5nIFZNRHMgaGF2ZSBjb25maWcgcmVnaXN0ZXIgMHg3MCByZXNlcnZlZCwgYW5k
IHdpbGwgcmV0dXJuIDAgb24NCj4gPiByZWFkcy4NCj4gDQo+IFNvIHRoZXNlIHNoYWRvdyByZWdp
c3RlcnMgYXJlIHNpbXBseSBleHBvc2luZyB0aGUgaG9zdCBCQVIyICYgQkFSNA0KPiBhZGRyZXNz
ZXMgaW50byB0aGUgZ3Vlc3QsIHNvIHRoZSBxdWlyayBpcyBkZXBlbmRlbnQgb24gcmVhZGluZyB0
aG9zZQ0KPiB2YWx1ZXMgZnJvbSB0aGUgZGV2aWNlIGJlZm9yZSBhbnlvbmUgaGFzIHdyaXR0ZW4g
dG8gdGhlbSBhbmQgdGhlIEJBUg0KPiBlbXVsYXRpb24gaW4gdGhlIGtlcm5lbCBraWNrcyBpbiAo
bm90IGEgcHJvYmxlbSwganVzdCBhbiBvYnNlcnZhdGlvbikuDQpJdCdzIG5vdCBleHBlY3RlZCB0
aGF0IHRoZXJlIHdpbGwgYmUgYW55dGhpbmcgd3JpdGluZyB0aGF0IHJlc291cmNlIGFuZA0KdGhv
c2UgcmVnaXN0ZXJzIGFyZSByZWFkLW9ubHkuDQpUaGUgZmlyc3QgMHgyMDAwIG9mIE1FTUJBUjIg
KEJBUjQpIGNvbnRhaW4gbXNpeCB0YWJsZXMsIGFuZCBtYXBwaW5ncyB0bw0Kc3Vib3JkaW5hdGUg
YnVzZXMgYXJlIG9uIDFNQiBhbGlnbmVkLg0KDQoNCj4gRG9lcyB0aGUgVk1EIGNvbnRyb2xsZXIg
Y29kZSB0aGVuIHVzZSB0aGVzZSBiYXNlcyBhZGRyZXNzZXMgdG8gcHJvZ3JhbQ0KPiB0aGUgYnJp
ZGdlcy9lbmRwb2ludCB3aXRoaW4gdGhlIGRvbWFpbj8gIFdoYXQgZG9lcyB0aGUgc2FtZSAvcHJv
Yy9pb21lbQ0KPiBvciBsc3BjaSBsb29rIGxpa2UgaW5zaWRlIHRoZSBndWVzdCB0aGVuPyAgSXQg
c2VlbXMgbGlrZSB3ZSdkIHNlZSB0aGUNCj4gVk1EIGVuZHBvaW50IHdpdGggR1BBIEJBUnMsIGJ1
dCB0aGUgZGV2aWNlcyB3aXRoaW4gdGhlIGRvbWFpbiB1c2luZw0KPiBIUEFzLiAgSWYgdGhhdCdz
IHJlbW90ZWx5IHRydWUsIGFuZCB3ZSdyZSBub3QgZm9yY2luZyBhbiBpZGVudGl0eQ0KPiBtYXBw
aW5nIG9mIHRoaXMgSFBBIHJhbmdlIGludG8gdGhlIEdQQSwgZG9lcyB0aGUgdm1kIGNvbnRyb2xs
ZXIgZHJpdmVyDQo+IGltcG9zZSBhIFRSQSBmdW5jdGlvbiBvbiB0aGVzZSBNTUlPIGFkZHJlc3Nl
cyBpbiB0aGUgZ3Vlc3Q/DQoNClRoaXMgaXMgdGhlIGd1ZXN0IHdpdGggdGhlIGd1ZXN0IGFkZHJl
c3NlczoNCiAgZjgwMDAwMDAtZmJmZmZmZmYgOiAwMDAwOjAwOjA3LjANCiAgICBmODAwMDAwMC1m
YmZmZmZmZiA6IFZNRCBNRU1CQVIxDQogIA0KICAgIGY4MDAwMDAwLWY4M2ZmZmZmIDogUENJIEJ1
cyAxMDAwMDowMQ0KICAgICAgICBmODAwMDAwMC1mODAwZmZmZiA6DQoxMDAwMDowMTowMC4wDQog
ICAgICAgIGY4MDEwMDAwLWY4MDEzZmZmIDogMTAwMDA6MDE6MDAuMA0KICAgICAgICAgIGY4MDEw
MDANCjAtZjgwMTNmZmYgOiBudm1lDQogICAgICBmODQwMDAwMC1mODdmZmZmZiA6IFBDSSBCdXMg
MTAwMDA6MDENCiAgICAgIGY4ODAwMA0KMDAtZjhiZmZmZmYgOiBQQ0kgQnVzIDEwMDAwOjAyDQog
ICAgICAgIGY4ODAwMDAwLWY4ODBmZmZmIDogMTAwMDA6MDI6MDAuMA0KICAgICAgICBmODgxMDAw
MC1mODgxM2ZmZiA6IDEwMDAwOjAyOjAwLjANCiAgICAgICAgICBmODgxMDAwMC1mODgxM2ZmZiA6
DQpudm1lDQogICAgICBmOGMwMDAwMC1mOGZmZmZmZiA6IFBDSSBCdXMgMTAwMDA6MDINCg0KDQpU
aGUgVk1EIGd1ZXN0IGRyaXZlciBkb2VzIHRoZSB0cmFuc2xhdGlvbiBvbiB0aGUgc3VwcGxpZWQg
YWRkcmVzcyB1c2luZw0KcGNpX2FkZF9yZXNvdXJjZV9vZmZzZXQgcHJpb3IgdG8gY3JlYXRpbmcg
dGhlIHJvb3QgYnVzIGFuZCBlbnVtZXJhdGluZw0KdGhlIGRvbWFpbjoNCg0KCW9mZnNldFswXSA9
IHZtZC0+ZGV2LT5yZXNvdXJjZVtWTURfTUVNQkFSMV0uc3RhcnQgLQ0KCQkJcmVhZHEobWVtYmFy
MiArIE1CMl9TSEFET1dfT0ZGU0VUKTsNCglvZmZzZXRbMV0gPSB2bWQtPmRldi0+cmVzb3VyY2Vb
Vk1EX01FTUJBUjJdLnN0YXJ0IC0NCgkJCXJlYWRxKG1lbWJhcjIgKyBNQjJfU0hBRE9XX09GRlNF
VCArIDgpOw0KLi4uDQoJcGNpX2FkZF9yZXNvdXJjZSgmcmVzb3VyY2VzLCAmdm1kLT5yZXNvdXJj
ZXNbMF0pOw0KCXBjaV9hZGRfcmVzb3VyY2Vfb2Zmc2V0KCZyZXNvdXJjZXMsICZ2bWQtPnJlc291
cmNlc1sxXSwgb2Zmc2V0WzBdKTsNCglwY2lfYWRkX3Jlc291cmNlX29mZnNldCgmcmVzb3VyY2Vz
LCAmdm1kLT5yZXNvdXJjZXNbMl0sIG9mZnNldFsxXSk7DQoNCgl2bWQtPmJ1cyA9IHBjaV9jcmVh
dGVfcm9vdF9idXMoJnZtZC0+ZGV2LT5kZXYsIHZtZC0+YnVzbl9zdGFydCwNCgkJCQkgICAgICAg
JnZtZF9vcHMsIHNkLCAmcmVzb3VyY2VzKTsNCg0KDQpUaGUgb2Zmc2V0IGJlY29tZXMgdGhlIENQ
VS10by1icmlkZ2UgdHJhbnNsYXRpb24gZnVuY3Rpb24gZm9yDQpwcm9ncmFtbWluZyB0aGUgZ3Vl
c3QncyBWTUQgZG9tYWluIHdpdGggYnVzIGFkZHJlc3Nlcy4NCg0KDQpJbiB0aGUgcGF0Y2hlZCBn
dWVzdCdzIGxzcGNpLCBmb3IgdGhlIGJyaWRnZSB5b3Ugc2VlOg0KIyBsc3BjaSAtdiAtcyAxMDAw
MDowMDowMi4wDQoxMDAwMDowMDowMi4wIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIFNr
eSBMYWtlLUUgUENJIEV4cHJlc3MgUm9vdCBQb3J0IEMNCgkuLi4NCglNZW1vcnkgYmVoaW5kIGJy
aWRnZTogOTQwMDAwMDAtOTQzZmZmZmYNCg0KDQpCdXQgdGhlIGtlcm5lbCBkb2Vzbid0IGV4cG9y
dCB0aGUgb2Zmc2V0IEJBUiBmb3IgdGhlIGVuZHBvaW50Og0KIyBsc3BjaSAtdiAtcyAxMDAwMDow
MjowMC4wDQoxMDAwMDowMjowMC4wIE5vbi1Wb2xhdGlsZSBtZW1vcnkgY29udHJvbGxlcjogSW50
ZWwgQ29ycG9yYXRpb24gTlZNZSBEYXRhY2VudGVyIFNTRA0KCS4uLg0KCU1lbW9yeSBhdCBmODgx
MDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNktdDQoJW3ZpcnR1YWxdIEV4
cGFuc2lvbiBST00gYXQgZjg4MDAwMDAgW2Rpc2FibGVkXSBbc2l6ZT02NEtdDQoNClRoZSBlbmRw
b2ludCBpcyBzdGlsbCBwcm9ncmFtbWVkIHdpdGggdGhlIG9mZnNldDoNCiMgc2V0cGNpIC1zIDEw
MDAwOjAyOjAwLjAgMTAubA0KOTQ4MTAwMDQNCg0KDQo+IA0KPiBTb3JyeSBpZiBJJ20gd2F5IG9m
ZiwgSSdtIHBpZWNpbmcgdGhpbmdzIHRvZ2V0aGVyIGZyb20gc2NhbnQNCj4gaW5mb3JtYXRpb24g
aGVyZS4gIFBsZWFzZSBDYyBtZSBvbiBmdXR1cmUgdmZpbyByZWxhdGVkIHBhdGNoZXMuICBUaGFu
a3MsDQo+IA0KPiBBbGV4DQo+IA0KTm8gcHJvYmxlbQ0KDQpUaGFua3MsDQpKb24NCg0KPiAgDQo+
ID4gSW4gb3JkZXIgdG8gc3VwcG9ydCBleGlzdGluZyBWTURzLCB0aGlzIHF1aXJrIGVtdWxhdGVz
IHRoZSBWTUxPQ0sgYW5kDQo+ID4gSFBBIHNoYWRvdyByZWdpc3RlcnMgZm9yIGFsbCBWTUQgZGV2
aWNlIGlkcyB3aGljaCBkb24ndCBuYXRpdmVseSBhc3Npc3QNCj4gPiB3aXRoIHBhc3N0aHJvdWdo
LiBUaGUgTGludXggVk1EIGRyaXZlciBpcyB1cGRhdGVkIHRvIGFsbG93IGV4aXN0aW5nIFZNRA0K
PiA+IGRldmljZXMgdG8gcXVlcnkgVk1MT0NLIGZvciBwYXNzdGhyb3VnaCBzdXBwb3J0Lg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbiBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVs
LmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvdmZpby9wY2ktcXVpcmtzLmMgfCAxMDMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBody92ZmlvL3BjaS5jICAg
ICAgICB8ICAgNyArKysNCj4gPiAgaHcvdmZpby9wY2kuaCAgICAgICAgfCAgIDIgKw0KPiA+ICBo
dy92ZmlvL3RyYWNlLWV2ZW50cyB8ICAgMyArKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDExNSBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLXF1aXJrcy5j
IGIvaHcvdmZpby9wY2ktcXVpcmtzLmMNCj4gPiBpbmRleCAyZDM0OGY4MjM3Li40MDYwYTZhOTVk
IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3ZmaW8vcGNpLXF1aXJrcy5jDQo+ID4gKysrIGIvaHcvdmZp
by9wY2ktcXVpcmtzLmMNCj4gPiBAQCAtMTcwOSwzICsxNzA5LDEwNiBAQCBmcmVlX2V4aXQ6DQo+
ID4gIA0KPiA+ICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+ICsNCj4gPiArLyoNCj4gPiAr
ICogVGhlIFZNRCBlbmRwb2ludCBwcm92aWRlcyBhIHJlYWwgUENJZSBkb21haW4gdG8gdGhlIGd1
ZXN0IGFuZCB0aGUgZ3Vlc3QNCj4gPiArICoga2VybmVsIHBlcmZvcm1zIGVudW1lcmF0aW9uIG9m
IHRoZSBWTUQgc3ViLWRldmljZSBkb21haW4uIEd1ZXN0IHRyYW5zYWN0aW9ucw0KPiA+ICsgKiB0
byBWTUQgc3ViLWRldmljZXMgZ28gdGhyb3VnaCBJT01NVSB0cmFuc2xhdGlvbiBmcm9tIGd1ZXN0
IGFkZHJlc3NlcyB0bw0KPiA+ICsgKiBwaHlzaWNhbCBhZGRyZXNzZXMuIFdoZW4gTU1JTyBnb2Vz
IHRvIGFuIGVuZHBvaW50IGFmdGVyIGJlaW5nIHRyYW5zbGF0ZWQgdG8NCj4gPiArICogcGh5c2lj
YWwgYWRkcmVzc2VzLCB0aGUgYnJpZGdlIHJlamVjdHMgdGhlIHRyYW5zYWN0aW9uIGJlY2F1c2Ug
dGhlIHdpbmRvdw0KPiA+ICsgKiBoYXMgYmVlbiBwcm9ncmFtbWVkIHdpdGggZ3Vlc3QgYWRkcmVz
c2VzLg0KPiA+ICsgKg0KPiA+ICsgKiBWTUQgY2FuIHVzZSB0aGUgSG9zdCBQaHlzaWNhbCBBZGRy
ZXNzIGluIG9yZGVyIHRvIGNvcnJlY3RseSBwcm9ncmFtIHRoZQ0KPiA+ICsgKiBicmlkZ2Ugd2lu
ZG93cyBpbiBpdHMgUENJZSBkb21haW4uIFZNRCBkZXZpY2UgMjhDMCBoYXMgSFBBIHNoYWRvdyBy
ZWdpc3RlcnMNCj4gPiArICogbG9jYXRlZCBhdCBvZmZzZXQgMHgyMDAwIGluIE1FTUJBUjIgKEJB
UiA0KS4gVGhlIHNoYWRvdyByZWdpc3RlcnMgYXJlIHZhbGlkDQo+ID4gKyAqIGlmIGJpdCAxIGlz
IHNldCBpbiB0aGUgVk1EIFZNTE9DSyBjb25maWcgcmVnaXN0ZXIgMHg3MC4gVk1EIGRldmljZXMg
d2l0aG91dA0KPiA+ICsgKiB0aGlzIG5hdGl2ZSBhc3Npc3RhbmNlIGNhbiBoYXZlIHRoZXNlIHJl
Z2lzdGVycyBzYWZlbHkgZW11bGF0ZWQgYXMgdGhlc2UNCj4gPiArICogcmVnaXN0ZXJzIGFyZSBy
ZXNlcnZlZC4NCj4gPiArICovDQo+ID4gK3R5cGVkZWYgc3RydWN0IFZGSU9WTURRdWlyayB7DQo+
ID4gKyAgICBWRklPUENJRGV2aWNlICp2ZGV2Ow0KPiA+ICsgICAgdWludDY0X3QgbWVtYmFyX3Bo
eXNbMl07DQo+ID4gK30gVkZJT1ZNRFF1aXJrOw0KPiA+ICsNCj4gPiArc3RhdGljIHVpbnQ2NF90
IHZmaW9fdm1kX3F1aXJrX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdW5zaWduZWQg
c2l6ZSkNCj4gPiArew0KPiA+ICsgICAgVkZJT1ZNRFF1aXJrICpkYXRhID0gb3BhcXVlOw0KPiA+
ICsgICAgdWludDY0X3QgdmFsID0gMDsNCj4gPiArDQo+ID4gKyAgICBtZW1jcHkoJnZhbCwgKHZv
aWQgKilkYXRhLT5tZW1iYXJfcGh5cyArIGFkZHIsIHNpemUpOw0KPiA+ICsgICAgcmV0dXJuIHZh
bDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyB2Zmlv
X3ZtZF9xdWlyayA9IHsNCj4gPiArICAgIC5yZWFkID0gdmZpb192bWRfcXVpcmtfcmVhZCwNCj4g
PiArICAgIC5lbmRpYW5uZXNzID0gREVWSUNFX0xJVFRMRV9FTkRJQU4sDQo+ID4gK307DQo+ID4g
Kw0KPiA+ICsjZGVmaW5lIFZNRF9WTUxPQ0sgIDB4NzANCj4gPiArI2RlZmluZSBWTURfU0hBRE9X
ICAweDIwMDANCj4gPiArI2RlZmluZSBWTURfTUVNQkFSMiA0DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IHZmaW9fdm1kX2VtdWxhdGVfc2hhZG93X3JlZ2lzdGVycyhWRklPUENJRGV2aWNlICp2ZGV2
KQ0KPiA+ICt7DQo+ID4gKyAgICBWRklPUXVpcmsgKnF1aXJrOw0KPiA+ICsgICAgVkZJT1ZNRFF1
aXJrICpkYXRhOw0KPiA+ICsgICAgUENJRGV2aWNlICpwZGV2ID0gJnZkZXYtPnBkZXY7DQo+ID4g
KyAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgIGRhdGEgPSBnX21hbGxvYzAoc2l6ZW9mKCpk
YXRhKSk7DQo+ID4gKyAgICByZXQgPSBwcmVhZCh2ZGV2LT52YmFzZWRldi5mZCwgZGF0YS0+bWVt
YmFyX3BoeXMsIDE2LA0KPiA+ICsgICAgICAgICAgICAgICAgdmRldi0+Y29uZmlnX29mZnNldCAr
IFBDSV9CQVNFX0FERFJFU1NfMik7DQo+ID4gKyAgICBpZiAocmV0ICE9IDE2KSB7DQo+ID4gKyAg
ICAgICAgZXJyb3JfcmVwb3J0KCJWTUQgJXMgY2Fubm90IHJlYWQgTUVNQkFScyAoJWQpIiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgdmRldi0+dmJhc2VkZXYubmFtZSwgcmV0KTsNCj4gPiAr
ICAgICAgICBnX2ZyZWUoZGF0YSk7DQo+ID4gKyAgICAgICAgcmV0dXJuIC1FRkFVTFQ7DQo+ID4g
KyAgICB9DQo+ID4gKw0KPiA+ICsgICAgcXVpcmsgPSB2ZmlvX3F1aXJrX2FsbG9jKDEpOw0KPiA+
ICsgICAgcXVpcmstPmRhdGEgPSBkYXRhOw0KPiA+ICsgICAgZGF0YS0+dmRldiA9IHZkZXY7DQo+
ID4gKw0KPiA+ICsgICAgLyogRW11bGF0ZSBTaGFkb3cgUmVnaXN0ZXJzICovDQo+ID4gKyAgICBt
ZW1vcnlfcmVnaW9uX2luaXRfaW8ocXVpcmstPm1lbSwgT0JKRUNUKHZkZXYpLCAmdmZpb192bWRf
cXVpcmssIGRhdGEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgInZmaW8tdm1kLXF1
aXJrIiwgc2l6ZW9mKGRhdGEtPm1lbWJhcl9waHlzKSk7DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9u
X2FkZF9zdWJyZWdpb25fb3ZlcmxhcCh2ZGV2LT5iYXJzW1ZNRF9NRU1CQVIyXS5yZWdpb24ubWVt
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVk1EX1NIQURP
VywgcXVpcmstPm1lbSwgMSk7DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9uX3NldF9yZWFkb25seShx
dWlyay0+bWVtLCB0cnVlKTsNCj4gPiArICAgIG1lbW9yeV9yZWdpb25fc2V0X2VuYWJsZWQocXVp
cmstPm1lbSwgdHJ1ZSk7DQo+ID4gKw0KPiA+ICsgICAgUUxJU1RfSU5TRVJUX0hFQUQoJnZkZXYt
PmJhcnNbVk1EX01FTUJBUjJdLnF1aXJrcywgcXVpcmssIG5leHQpOw0KPiA+ICsNCj4gPiArICAg
IHRyYWNlX3ZmaW9fcGNpX3ZtZF9xdWlya19zaGFkb3dfcmVncyh2ZGV2LT52YmFzZWRldi5uYW1l
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEtPm1l
bWJhcl9waHlzWzBdLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRhdGEtPm1lbWJhcl9waHlzWzFdKTsNCj4gPiArDQo+ID4gKyAgICAvKiBBZHZlcnRpc2Ug
U2hhZG93IFJlZ2lzdGVyIHN1cHBvcnQgKi8NCj4gPiArICAgIHBjaV9ieXRlX3Rlc3RfYW5kX3Nl
dF9tYXNrKHBkZXYtPmNvbmZpZyArIFZNRF9WTUxPQ0ssIDB4Mik7DQo+ID4gKyAgICBwY2lfc2V0
X2J5dGUocGRldi0+d21hc2sgKyBWTURfVk1MT0NLLCAwKTsNCj4gPiArICAgIHBjaV9zZXRfYnl0
ZSh2ZGV2LT5lbXVsYXRlZF9jb25maWdfYml0cyArIFZNRF9WTUxPQ0ssIDB4Mik7DQo+ID4gKw0K
PiA+ICsgICAgdHJhY2VfdmZpb19wY2lfdm1kX3F1aXJrX3ZtbG9jayh2ZGV2LT52YmFzZWRldi5u
YW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwY2lfZ2V0X2J5
dGUocGRldi0+Y29uZmlnICsgVk1EX1ZNTE9DSykpOw0KPiA+ICsNCj4gPiArICAgIHJldHVybiAw
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgdmZpb19wY2lfdm1kX2luaXQoVkZJT1BDSURldmlj
ZSAqdmRldikNCj4gPiArew0KPiA+ICsgICAgaW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsgICAg
c3dpdGNoICh2ZGV2LT5kZXZpY2VfaWQpIHsNCj4gPiArICAgIGNhc2UgMHgyOEMwOiAvKiBOYXRp
dmUgcGFzc3Rocm91Z2ggc3VwcG9ydCAqLw0KPiA+ICsgICAgICAgIGJyZWFrOw0KPiA+ICsgICAg
LyogRW11bGF0ZXMgTmF0aXZlIHBhc3N0aHJvdWdoIHN1cHBvcnQgKi8NCj4gPiArICAgIGNhc2Ug
MHgyMDFEOg0KPiA+ICsgICAgY2FzZSAweDQ2N0Y6DQo+ID4gKyAgICBjYXNlIDB4NEMzRDoNCj4g
PiArICAgIGNhc2UgMHg5QTBCOg0KPiA+ICsgICAgICAgIHJldCA9IHZmaW9fdm1kX2VtdWxhdGVf
c2hhZG93X3JlZ2lzdGVycyh2ZGV2KTsNCj4gPiArICAgICAgICBicmVhazsNCj4gPiArICAgIH0N
Cj4gPiArDQo+ID4gKyAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gZGlmZiAtLWdpdCBhL2h3
L3ZmaW8vcGNpLmMgYi9ody92ZmlvL3BjaS5jDQo+ID4gaW5kZXggNWU3NWE5NTEyOS4uODU0MjVh
MWE2ZiAxMDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+ID4gKysrIGIvaHcvdmZpby9w
Y2kuYw0KPiA+IEBAIC0zMDI0LDYgKzMwMjQsMTMgQEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXpl
KFBDSURldmljZSAqcGRldiwgRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgICAgIH0NCj4gPiAgICAg
IH0NCj4gPiAgDQo+ID4gKyAgICBpZiAodmRldi0+dmVuZG9yX2lkID09IFBDSV9WRU5ET1JfSURf
SU5URUwpIHsNCj4gPiArICAgICAgICByZXQgPSB2ZmlvX3BjaV92bWRfaW5pdCh2ZGV2KTsNCj4g
PiArICAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiRmFp
bGVkIHRvIHNldHVwIFZNRCIpOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiArDQo+
ID4gICAgICB2ZmlvX3JlZ2lzdGVyX2Vycl9ub3RpZmllcih2ZGV2KTsNCj4gPiAgICAgIHZmaW9f
cmVnaXN0ZXJfcmVxX25vdGlmaWVyKHZkZXYpOw0KPiA+ICAgICAgdmZpb19zZXR1cF9yZXNldGZu
X3F1aXJrKHZkZXYpOw0KPiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5oIGIvaHcvdmZpby9w
Y2kuaA0KPiA+IGluZGV4IDBkYTdhMjBhN2UuLmU4NjMyZDgwNmIgMTAwNjQ0DQo+ID4gLS0tIGEv
aHcvdmZpby9wY2kuaA0KPiA+ICsrKyBiL2h3L3ZmaW8vcGNpLmgNCj4gPiBAQCAtMjE3LDYgKzIx
Nyw4IEBAIGludCB2ZmlvX3BjaV9pZ2Rfb3ByZWdpb25faW5pdChWRklPUENJRGV2aWNlICp2ZGV2
LA0KPiA+ICBpbnQgdmZpb19wY2lfbnZpZGlhX3YxMDBfcmFtX2luaXQoVkZJT1BDSURldmljZSAq
dmRldiwgRXJyb3IgKiplcnJwKTsNCj4gPiAgaW50IHZmaW9fcGNpX252bGluazJfaW5pdChWRklP
UENJRGV2aWNlICp2ZGV2LCBFcnJvciAqKmVycnApOw0KPiA+ICANCj4gPiAraW50IHZmaW9fcGNp
X3ZtZF9pbml0KFZGSU9QQ0lEZXZpY2UgKnZkZXYpOw0KPiA+ICsNCj4gPiAgdm9pZCB2ZmlvX2Rp
c3BsYXlfcmVzZXQoVkZJT1BDSURldmljZSAqdmRldik7DQo+ID4gIGludCB2ZmlvX2Rpc3BsYXlf
cHJvYmUoVkZJT1BDSURldmljZSAqdmRldiwgRXJyb3IgKiplcnJwKTsNCj4gPiAgdm9pZCB2Zmlv
X2Rpc3BsYXlfZmluYWxpemUoVkZJT1BDSURldmljZSAqdmRldik7DQo+ID4gZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vdHJhY2UtZXZlbnRzIGIvaHcvdmZpby90cmFjZS1ldmVudHMNCj4gPiBpbmRleCBi
MWVmNTVhMzNmLi5lZDY0ZTQ3N2RiIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3ZmaW8vdHJhY2UtZXZl
bnRzDQo+ID4gKysrIGIvaHcvdmZpby90cmFjZS1ldmVudHMNCj4gPiBAQCAtOTAsNiArOTAsOSBA
QCB2ZmlvX3BjaV9udmlkaWFfZ3B1X3NldHVwX3F1aXJrKGNvbnN0IGNoYXIgKm5hbWUsIHVpbnQ2
NF90IHRndCwgdWludDY0X3Qgc2l6ZSkgIg0KPiA+ICB2ZmlvX3BjaV9udmxpbmsyX3NldHVwX3F1
aXJrX3NzYXRndChjb25zdCBjaGFyICpuYW1lLCB1aW50NjRfdCB0Z3QsIHVpbnQ2NF90IHNpemUp
ICIlcyB0Z3Q9MHglIlBSSXg2NCIgc2l6ZT0weCUiUFJJeDY0DQo+ID4gIHZmaW9fcGNpX252bGlu
azJfc2V0dXBfcXVpcmtfbG5rc3BkKGNvbnN0IGNoYXIgKm5hbWUsIHVpbnQzMl90IGxpbmtfc3Bl
ZWQpICIlcyBsaW5rX3NwZWVkPTB4JXgiDQo+ID4gIA0KPiA+ICt2ZmlvX3BjaV92bWRfcXVpcmtf
c2hhZG93X3JlZ3MoY29uc3QgY2hhciAqbmFtZSwgdWludDY0X3QgbWIxLCB1aW50NjRfdCBtYjIp
ICIlcyBtZW1iYXIxX3BoeXM9MHglIlBSSXg2NCIgbWVtYmFyMl9waHlzPTB4JSJQUkl4NjQNCj4g
PiArdmZpb19wY2lfdm1kX3F1aXJrX3ZtbG9jayhjb25zdCBjaGFyICpuYW1lLCB1aW50OF90IHZt
bG9jaykgIiVzIHZtbG9jaz0weCV4Ig0KPiA+ICsNCj4gPiAgIyBjb21tb24uYw0KPiA+ICB2Zmlv
X3JlZ2lvbl93cml0ZShjb25zdCBjaGFyICpuYW1lLCBpbnQgaW5kZXgsIHVpbnQ2NF90IGFkZHIs
IHVpbnQ2NF90IGRhdGEsIHVuc2lnbmVkIHNpemUpICIgKCVzOnJlZ2lvbiVkKzB4JSJQUkl4NjQi
LCAweCUiUFJJeDY0ICIsICVkKSINCj4gPiAgdmZpb19yZWdpb25fcmVhZChjaGFyICpuYW1lLCBp
bnQgaW5kZXgsIHVpbnQ2NF90IGFkZHIsIHVuc2lnbmVkIHNpemUsIHVpbnQ2NF90IGRhdGEpICIg
KCVzOnJlZ2lvbiVkKzB4JSJQUkl4NjQiLCAlZCkgPSAweCUiUFJJeDY0DQo=
