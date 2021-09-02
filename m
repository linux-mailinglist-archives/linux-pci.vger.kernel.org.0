Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327973FF43D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 21:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347407AbhIBTfm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 15:35:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:51133 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347257AbhIBTfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 15:35:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="282934200"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="282934200"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="521312767"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2021 12:34:42 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 2 Sep 2021 12:34:41 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 3 Sep 2021 03:34:38 +0800
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2242.010;
 Thu, 2 Sep 2021 22:34:36 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Barry Song <21cnbao@gmail.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
CC:     lkp <lkp@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "bilbao@vt.edu" <bilbao@vt.edu>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luzmaximilian@gmail.com" <luzmaximilian@gmail.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PCI/MSI] a4fc4cf388:
 dmesg.genirq:Flags_mismatch_irq##(mei_me)vs.#(xhci_hcd)
Thread-Topic: [PCI/MSI] a4fc4cf388:
 dmesg.genirq:Flags_mismatch_irq##(mei_me)vs.#(xhci_hcd)
Thread-Index: AQHXnginGRfCkYvOzEKHZKqjivRGPKuRJldQ
Date:   Thu, 2 Sep 2021 19:34:35 +0000
Message-ID: <8ab95f7f784448038d7777c45f1f2d55@intel.com>
References: <20210825102636.52757-4-21cnbao@gmail.com>
 <20210829145552.GA11556@xsang-OptiPlex-9020>
 <CAGsJ_4yYwjuWsEeK3CvnOhc10mbBNYWXqxqp+mR5587R2FD3gQ@mail.gmail.com>
 <CAGsJ_4zwRdR2QuoR0K0_J86w0=t=mFh=tAKRuP1+Tx8aLn4kKw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zwRdR2QuoR0K0_J86w0=t=mFh=tAKRuP1+Tx8aLn4kKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBkbWVzZy5nZW5pcnE6RmxhZ3NfbWlzbWF0Y2hfaXJxIyMobWVpX21lKXZzLiMoeGhjaV9oY2Qp
DQo+IA0KPiBPbiBUdWUsIEF1ZyAzMSwgMjAyMSBhdCAxOjIxIFBNIEJhcnJ5IFNvbmcgPDIxY25i
YW9AZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwgQXVnIDMwLCAyMDIxIGF0IDI6
MzggQU0ga2VybmVsIHRlc3Qgcm9ib3QNCj4gPG9saXZlci5zYW5nQGludGVsLmNvbT4gd3JvdGU6
DQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBHcmVldGluZywNCj4gPiA+DQo+ID4gPiBGWUks
IHdlIG5vdGljZWQgdGhlIGZvbGxvd2luZyBjb21taXQgKGJ1aWx0IHdpdGggZ2NjLTkpOg0KPiA+
ID4NCj4gPiA+IGNvbW1pdDogYTRmYzRjZjM4ODMxOWVhOTU3ZmZiZGFiNTA3M2JkZDI2N2RlOTA4
MiAoIltQQVRDSCB2MyAzLzNdDQo+ID4gPiBQQ0kvTVNJOiByZW1vdmUgbXNpX2F0dHJpYi5kZWZh
dWx0X2lycSBpbiBtc2lfZGVzYyIpDQo+ID4gPiB1cmw6DQo+ID4gPiBodHRwczovL2dpdGh1Yi5j
b20vMGRheS1jaS9saW51eC9jb21taXRzL0JhcnJ5LVNvbmcvUENJLU1TSS1DbGFyaWZ5LQ0KPiA+
ID4gdGhlLUlSUS1zeXNmcy1BQkktZm9yLVBDSS1kZXZpY2VzLzIwMjEwODI1LTE4MzAxOA0KPiA+
ID4gYmFzZToNCj4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdA0KPiA+ID4gNmU3NjRiY2QxY2Y3MmEyODQ2YzBlNTNkMzk3
NWEwOWIyNDJjMDRjOQ0KPiA+ID4NCj4gPiA+IGluIHRlc3RjYXNlOiBrZXJuZWwtc2VsZnRlc3Rz
DQo+ID4gPiB2ZXJzaW9uOiBrZXJuZWwtc2VsZnRlc3RzLXg4Nl82NC1lYmFhNjAzYi0xXzIwMjEw
ODI1DQo+ID4gPiB3aXRoIGZvbGxvd2luZyBwYXJhbWV0ZXJzOg0KPiA+ID4NCj4gPiA+ICAgICAg
ICAgZ3JvdXA6IHBpZGZkDQo+ID4gPiAgICAgICAgIHVjb2RlOiAweGUyDQo+ID4gPg0KPiA+ID4g
dGVzdC1kZXNjcmlwdGlvbjogVGhlIGtlcm5lbCBjb250YWlucyBhIHNldCBvZiAic2VsZiB0ZXN0
cyIgdW5kZXIgdGhlDQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzLyBkaXJlY3RvcnkuIFRoZXNl
IGFyZSBpbnRlbmRlZCB0byBiZSBzbWFsbCB1bml0IHRlc3RzDQo+IHRvIGV4ZXJjaXNlIGluZGl2
aWR1YWwgY29kZSBwYXRocyBpbiB0aGUga2VybmVsLg0KPiA+ID4gdGVzdC11cmw6IGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24va3NlbGZ0ZXN0LnR4dA0KPiA+ID4NCj4g
PiA+DQo+ID4gPiBvbiB0ZXN0IG1hY2hpbmU6IDQgdGhyZWFkcyBJbnRlbChSKSBDb3JlKFRNKSBp
NS02NTAwIENQVSBAIDMuMjBHSHoNCj4gPiA+IHdpdGggMzJHIG1lbW9yeQ0KPiA+ID4NCj4gPiA+
IGNhdXNlZCBiZWxvdyBjaGFuZ2VzIChwbGVhc2UgcmVmZXIgdG8gYXR0YWNoZWQgZG1lc2cva21z
ZyBmb3IgZW50aXJlDQo+IGxvZy9iYWNrdHJhY2UpOg0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZw0KPiA+ID4g
UmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+DQo+
ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBbICAxNzkuNjAyMDI4XVsgICBUMzRdIGdlbmlycTog
RmxhZ3MgbWlzbWF0Y2ggaXJxIDE2LiAwMDAwMjAwMCAobWVpX21lKSB2cy4NCj4gMDAwMDAwMDAg
KHhoY2lfaGNkKQ0KPiA+ID4gWyAgMTc5LjYxNDA3M11bICAgVDM0XSBDUFU6IDIgUElEOiAzNCBD
b21tOiBrd29ya2VyL3U4OjIgTm90IHRhaW50ZWQNCj4gNS4xNC4wLXJjNy0wMDAxNC1nYTRmYzRj
ZjM4ODMxICMxDQo+ID4gPiBbICAxNzkuNjIzMjI1XVsgICBUMzRdIEhhcmR3YXJlIG5hbWU6IERl
bGwgSW5jLiBPcHRpUGxleCA3MDQwLzBZN1dZVCwNCj4gQklPUyAxLjguMSAxMi8wNS8yMDE3DQo+
ID4gPiBbICAxNzkuNjMxNDMyXVsgICBUMzRdIFdvcmtxdWV1ZTogZXZlbnRzX3VuYm91bmQgYXN5
bmNfcnVuX2VudHJ5X2ZuDQo+ID4gPiBbICAxNzkuNjM3NTQzXVsgICBUMzRdIENhbGwgVHJhY2U6
DQo+ID4gPiBbICAxNzkuNjQwNzg5XVsgICBUMzRdICBkdW1wX3N0YWNrX2x2bCsweDQ1LzB4NTkN
Cj4gPiA+IFsgIDE3OS42NDUyNTNdWyAgIFQzNF0gIF9fc2V0dXBfaXJxLmNvbGQrMHg1MC8weGQ0
DQo+ID4gPiBbICAxNzkuNjQ5ODkzXVsgICBUMzRdICA/IG1laV9tZV9wZ19leGl0X3N5bmMrMHg0
ODAvMHg0ODAgW21laV9tZV0NCj4gPiA+IFsgIDE3OS42NTU5MjNdWyAgIFQzNF0gIHJlcXVlc3Rf
dGhyZWFkZWRfaXJxKzB4MTBjLzB4MTgwDQo+ID4gPiBbICAxNzkuNjYxMDczXVsgICBUMzRdICA/
IG1laV9tZV9pcnFfcXVpY2tfaGFuZGxlcisweDI0MC8weDI0MA0KPiBbbWVpX21lXQ0KPiA+ID4g
WyAgMTc5LjY2NzUyOF1bICAgVDM0XSAgbWVpX21lX3Byb2JlKzB4MTMxLzB4MzAwIFttZWlfbWVd
DQo+ID4gPiBbICAxNzkuNjcyNzY3XVsgICBUMzRdICBsb2NhbF9wY2lfcHJvYmUrMHg0Mi8weDgw
DQo+ID4gPiBbICAxNzkuNjc3MzEzXVsgICBUMzRdICBwY2lfZGV2aWNlX3Byb2JlKzB4MTA3LzB4
MWMwDQo+ID4gPiBbICAxNzkuNjgyMTE4XVsgICBUMzRdICByZWFsbHlfcHJvYmUrMHhiNi8weDM4
MA0KPiA+ID4gWyAgMTc5LjY4NzA5NF1bICAgVDM0XSAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4
ZmUvMHgxODANCj4gPiA+IFsgIDE3OS42OTIyNDJdWyAgIFQzNF0gIGRyaXZlcl9wcm9iZV9kZXZp
Y2UrMHgxZS8weGMwDQo+ID4gPiBbICAxNzkuNjk3MTMzXVsgICBUMzRdICBfX2RyaXZlcl9hdHRh
Y2hfYXN5bmNfaGVscGVyKzB4MmIvMHg4MA0KPiA+ID4gWyAgMTc5LjcwMjgwMl1bICAgVDM0XSAg
YXN5bmNfcnVuX2VudHJ5X2ZuKzB4MzAvMHgxNDANCj4gPiA+IFsgIDE3OS43MDc2OTNdWyAgIFQz
NF0gIHByb2Nlc3Nfb25lX3dvcmsrMHgyNzQvMHg1YzANCj4gPiA+IFsgIDE3OS43MTI1MDNdWyAg
IFQzNF0gIHdvcmtlcl90aHJlYWQrMHg1MC8weDNjMA0KPiA+ID4gWyAgMTc5LjcxNjk1OV1bICAg
VDM0XSAgPyBwcm9jZXNzX29uZV93b3JrKzB4NWMwLzB4NWMwDQo+ID4gPiBbICAxNzkuNzIxOTM2
XVsgICBUMzRdICBrdGhyZWFkKzB4MTRmLzB4MTgwDQo+ID4gPiBbICAxNzkuNzI1OTU4XVsgICBU
MzRdICA/IHNldF9rdGhyZWFkX3N0cnVjdCsweDQwLzB4NDANCj4gPiA+IFsgIDE3OS43MzA5MzVd
WyAgIFQzNF0gIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQo+ID4gPiBbICAxNzkuNzM1Njk5XVsg
ICBUMzRdIG1laV9tZSAwMDAwOjAwOjE2LjA6IHJlcXVlc3RfdGhyZWFkZWRfaXJxIGZhaWx1cmUu
DQo+IGlycSA9IDE2DQo+ID4gPiBbICAxNzkuNzQzMTI1XVsgICBUMzRdIG1laV9tZSAwMDAwOjAw
OjE2LjA6IGluaXRpYWxpemF0aW9uIGZhaWxlZC4NCj4gPiA+IFsgIDE3OS43NDkzOTldWyAgIFQz
NF0gbWVpX21lOiBwcm9iZSBvZiAwMDAwOjAwOjE2LjAgZmFpbGVkIHdpdGggZXJyb3IgLTE2DQo+
ID4gPg0KPiA+ID4NCj4gPg0KPiA+IGl0IHNlZW1zIHRoZXJlIGlzIGEgZGlyZWN0IHJlZmVyZW5j
ZSB0byBwZGV2LT5pcnEuDQo+ID4gSGkgT2xpdmVyLCB3b3VsZCB5b3UgdHJ5IGlmIHRoZSBiZWxv
dyBwYXRjaCBjYW4gZml4IHRoZSBwcm9ibGVtOg0KPiANCj4gKyBUb21hcw0KPiANCj4gc29ycnku
IGFmdGVyIHNlY29uZCBsb29raW5nLCBkcml2ZXJzL21pc2MvbWVpL3BjaS1tZS5jIGhhcyBtYW55
IHBsYWNlcyB1c2luZw0KPiBwZGV2LT5pcnEgZGlyZWN0bHkuIFdlIHJlYWxseSBuZWVkIHRoaXMg
ZHJpdmVyJ3MgbWFpbnRhaW5lcnMgdG8gYWRkcmVzcyB0aGUNCj4gcHJvYmxlbS4NCg0KV2lsbCBs
b29rIGF0IHRoYXQuIA0KPiANCj4gT24gdGhlIG90aGVyIGhhbmQsICJzdHJ1Y3QgbWVpX21lX2h3
ICpodyIgc2VlbXMgdG8gYmUgdG90YWxseSBub3QgdXNlZCBpbg0KPiB0aGlzIGRyaXZlciBleGNl
cHQgaGVyZToNCj4gMTY0IHN0YXRpYyBpbnQgbWVpX21lX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LCBjb25zdCBzdHJ1Y3QNCj4gcGNpX2RldmljZV9pZCAqZW50KQ0KPiAxNjUgew0KPiAxNjYg
ICAgICAgICBjb25zdCBzdHJ1Y3QgbWVpX2NmZyAqY2ZnOw0KPiAxNjcgICAgICAgICBzdHJ1Y3Qg
bWVpX2RldmljZSAqZGV2Ow0KPiAxNjggICAgICAgICBzdHJ1Y3QgbWVpX21lX2h3ICpodzsNCj4g
MTY5ICAgICAgICAgdW5zaWduZWQgaW50IGlycWZsYWdzOw0KPiAxNzAgICAgICAgICBpbnQgZXJy
Ow0KPiAuLi4uLg0KPiAyMTkgICAgICAgICBody0+aXJxID0gcGRldi0+aXJxOw0KPiAuLi4NCj4g
DQo+IHRoaXMgbG9va3Mgd3JvbmcuIG1heWJlIHdlIGNhbiBsZXZlcmFnZSBody0+aXJxIGluIG90
aGVyIHBsYWNlcyBzdWNoIGFzDQo+IHNodXRkb3duLCBzdXNwZW5kLCByZXN1bWUuDQoNCldlIG5l
ZWQgdGhpcywgdXNhZ2Ugd2lsbCBmb2xsb3cuDQo+IA0KPiBUaGFua3MNCj4gYmFycnkNCj4gDQo+
IA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvcGNpLW1lLmMgYi9kcml2
ZXJzL21pc2MvbWVpL3BjaS1tZS5jDQo+ID4gaW5kZXggYzMzOTNiMzgzZTU5Li5hNDVhMmQ0MjU3
YTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9taXNjL21laS9wY2ktbWUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbWlzYy9tZWkvcGNpLW1lLmMNCj4gPiBAQCAtMjE2LDcgKzIxNiw3IEBAIHN0YXRp
YyBpbnQgbWVpX21lX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiA+IGNvbnN0IHN0cnVj
dCBwY2lfZGV2aWNlX2lkICplbnQpDQo+ID4NCj4gPiAgICAgICAgIHBjaV9lbmFibGVfbXNpKHBk
ZXYpOw0KPiA+DQo+ID4gLSAgICAgICBody0+aXJxID0gcGRldi0+aXJxOw0KPiA+ICsgICAgICAg
aHctPmlycSA9IHBjaV9pcnFfdmVjdG9yKHBkZXYsIDApOw0KPiA+DQo+ID4gICAgICAgICAgLyog
cmVxdWVzdCBhbmQgZW5hYmxlIGludGVycnVwdCAqLw0KPiA+ICAgICAgICAgaXJxZmxhZ3MgPSBw
Y2lfZGV2X21zaV9lbmFibGVkKHBkZXYpID8gSVJRRl9PTkVTSE9UIDoNCj4gPiBJUlFGX1NIQVJF
RDsNCj4gPg0KPiA+DQo+ID4gSSBkb24ndCBoYXZlIGFueSBoYXJkd2FyZSB0byB0ZXN0Lg0KDQoN
CkhhcmQgdG8gYmVsaWV2ZSwgTUVJIGlzIG9uIGV2ZXJ5IEludGVsIGNsaWVudCBwbGF0Zm9ybSA6
KQ0KDQo+ID4NCj4gPiA+DQo+ID4gPiBUbyByZXByb2R1Y2U6DQo+ID4gPg0KPiA+ID4gICAgICAg
ICBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2xrcC10ZXN0cy5naXQNCj4gPiA+
ICAgICAgICAgY2QgbGtwLXRlc3RzDQo+ID4gPiAgICAgICAgIGJpbi9sa3AgaW5zdGFsbCAgICAg
ICAgICAgICAgICBqb2IueWFtbCAgIyBqb2IgZmlsZSBpcyBhdHRhY2hlZCBpbiB0aGlzIGVtYWls
DQo+ID4gPiAgICAgICAgIGJpbi9sa3Agc3BsaXQtam9iIC0tY29tcGF0aWJsZSBqb2IueWFtbCAg
IyBnZW5lcmF0ZSB0aGUgeWFtbCBmaWxlIGZvcg0KPiBsa3AgcnVuDQo+ID4gPiAgICAgICAgIGJp
bi9sa3AgcnVuICAgICAgICAgICAgICAgICAgICBnZW5lcmF0ZWQteWFtbC1maWxlDQo+ID4gPg0K
PiA+ID4NCj4gPiA+DQo+ID4gPiAtLS0NCj4gPiA+IDBEQVkvTEtQKyBUZXN0IEluZnJhc3RydWN0
dXJlICAgICAgICAgICAgICAgICAgIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyDQo+ID4g
PiBodHRwczovL2xpc3RzLjAxLm9yZy9oeXBlcmtpdHR5L2xpc3QvbGtwQGxpc3RzLjAxLm9yZyAg
ICAgICBJbnRlbCBDb3Jwb3JhdGlvbg0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+IE9saXZl
ciBTYW5nDQo+ID4gPg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gYmFycnkNCg==
