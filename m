Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287532FFD24
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 08:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbhAVHNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 02:13:04 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:39122 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726292AbhAVHNA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 02:13:00 -0500
X-UUID: 18bfa4098eb448e597d6492d9cb46e0e-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fL/MgIC+7IuxEDr3pIYZFZ1fLaM2nU+O0q+PZiXufQc=;
        b=pO6xDPyrA7TculZOrJ1gQhGXF2BC3gjgTqyjdusMKYRq5bkLdWDZGZTlN50BsFiXsSPdwpGQIzqN3wtLyBsBmrCuENx4OiooCwRtuqTN2Lsa6L48e2wrdIt3fdBGQE2FfMIN/PWvlIBtrXdl760Uv+rSiPyiyqKMv7lbAb0hEMA=;
X-UUID: 18bfa4098eb448e597d6492d9cb46e0e-20210122
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <mingchuang.qiao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1315486227; Fri, 22 Jan 2021 15:03:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Jan
 2021 15:03:12 +0800
Received: from [10.19.240.15] (10.19.240.15) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 15:03:11 +0800
Message-ID: <1611298991.5980.42.camel@mcddlt001>
Subject: Re: [PATCH v2] PCI: Re-enable downstream port LTR if it was
 previously enabled
From:   Mingchuang Qiao <mingchuang.qiao@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Utkarsh H Patel" <utkarsh.h.patel@intel.com>,
        <linux-pci@vger.kernel.org>, <matthias.bgg@gmail.com>,
        <lambert.wang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <haijun.liu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Alex Williamson" <alex.williamson@redhat.com>
Date:   Fri, 22 Jan 2021 15:03:11 +0800
In-Reply-To: <20210121223139.GA2698934@bjorn-Precision-5520>
References: <20210121223139.GA2698934@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2CD612E64180C9CBC7FBC648089FF19836C607A61BD963F52342411B2B02F6712000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTIxIGF0IDE2OjMxIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBbK2NjIEFsZXggYW5kIE1pbmdjaHVhbmcgZXQgYWwgZnJvbQ0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjEwMTEyMDcyNzM5LjMxNjI0LTEtbWluZ2NodWFuZy5xaWFvQG1lZGlhdGVr
LmNvbV0NCj4gDQo+IE9uIFR1ZSwgSmFuIDE5LCAyMDIxIGF0IDA0OjE0OjEwUE0gKzAzMDAsIE1p
a2EgV2VzdGVyYmVyZyB3cm90ZToNCj4gPiBQQ0llIHI1LjAsIHNlYyA3LjUuMy4xNiBzYXlzIHRo
YXQgdGhlIGRvd25zdHJlYW0gcG9ydHMgbXVzdCByZXNldCB0aGUNCj4gPiBMVFIgZW5hYmxlIGJp
dCBpZiB0aGUgbGluayBnb2VzIGRvd24gKHBvcnQgZ29lcyBETF9Eb3duIHN0YXR1cykuIE5vdywg
aWYNCj4gPiB3ZSBoYWQgTFRSIHByZXZpb3VzbHkgZW5hYmxlZCBhbmQgdGhlIFBDSWUgZW5kcG9p
bnQgZ2V0cyBob3QtcmVtb3ZlZCBhbmQNCj4gPiB0aGVuIGhvdC1hZGRlZCBiYWNrIHRoZSAtPmx0
cl9wYXRoIG9mIHRoZSBkb3duc3RyZWFtIHBvcnQgaXMgc3RpbGwgc2V0DQo+ID4gYnV0IHRoZSBw
b3J0IG5vdyBkb2VzIG5vdCBoYXZlIHRoZSBMVFIgZW5hYmxlIGJpdCBzZXQgYW55bW9yZS4NCj4g
PiANCj4gPiBGb3IgdGhpcyByZWFzb24gY2hlY2sgaWYgdGhlIGJyaWRnZSB1cHN0cmVhbSBoYWQg
TFRSIGVuYWJsZWQgcHJldmlvdXNseQ0KPiA+IGFuZCByZS1lbmFibGUgaXQgYmVmb3JlIGVuYWJs
aW5nIExUUiBmb3IgdGhlIGVuZHBvaW50Lg0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5OiBVdGthcnNo
IEggUGF0ZWwgPHV0a2Fyc2guaC5wYXRlbEBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TWlrYSBXZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPg0KPiANCj4g
SSB0aGluayB0aGlzIGFuZCBNaW5nY2h1YW5nJ3MgcGF0Y2gsIHdoaWNoIGlzIGVzc2VudGlhbGx5
IGlkZW50aWNhbCwNCj4gYXJlIHJpZ2h0IGFuZCBzb2x2ZXMgdGhlIHByb2JsZW0gZm9yIGhvdC1y
ZW1vdmUvaG90LWFkZC4gIEluIHRoYXQNCj4gc2NlbmFyaW8gd2UgY2FsbCBwY2lfY29uZmlndXJl
X2x0cigpIG9uIHRoZSBob3QtYWRkZWQgZGV2aWNlLCBhbmQNCj4gd2l0aCB0aGlzIHBhdGNoLCB3
ZSdsbCByZS1lbmFibGUgTFRSIG9uIHRoZSBicmlkZ2UgbGVhZGluZyB0byB0aGUgbmV3DQo+IGRl
dmljZSBiZWZvcmUgZW5hYmxpbmcgTFRSIG9uIHRoZSBuZXcgZGV2aWNlIGl0c2VsZi4NCj4gDQo+
IEJ1dCBkb24ndCB3ZSBoYXZlIGEgc2ltaWxhciBwcm9ibGVtIGlmIHdlIHNpbXBseSBkbyBhIEZ1
bmRhbWVudGFsDQo+IFJlc2V0IG9uIGEgZGV2aWNlPyAgSSB0aGluayB0aGUgcmVzZXQgcGF0aCB3
aWxsIHJlc3RvcmUgdGhlIGRldmljZSdzDQo+IHN0YXRlLCBpbmNsdWRpbmcgUENJX0VYUF9ERVZD
VEwyLCBidXQgaXQgZG9lc24ndCBkbyBhbnl0aGluZyB3aXRoIHRoZQ0KPiB1cHN0cmVhbSBicmlk
Z2UsIGRvZXMgaXQ/DQo+IA0KDQpZZXMuIEkgdGhpbmsgdGhlIHNhbWUgcHJvYmxlbSBleGlzdHMg
dW5kZXIgc3VjaCBzY2VuYXJpbywgYW5kIHRoYXTigJlzIHRoZQ0KaXNzdWUgbXkgcGF0Y2ggaW50
ZW5kcyB0byByZXNvbHZlLg0KSSBhbHNvIHByZXBhcmVkIGEgdjIgcGF0Y2ggZm9yIHJldmlldyh1
cGRhdGUgdGhlIHBhdGNoIGRlc2NyaXB0aW9uKS4NClNoYWxsIEkgc3VibWl0IHRoZSB2MiBwYXRj
aCBmb3IgcmV2aWV3Pw0KDQo+IFNvIGlmIGEgYnJpZGdlIGFuZCBhIGRldmljZSBiZWxvdyBpdCBi
b3RoIGhhdmUgTFRSIGVuYWJsZWQsIGNhbid0IHdlDQo+IGhhdmUgdGhlIGZvbGxvd2luZzoNCj4g
DQo+ICAgLSBicmlkZ2UgTFRSIGVuYWJsZWQNCj4gICAtIGRldmljZSBMVFIgZW5hYmxlZA0KPiAg
IC0gcmVzZXQgZGV2aWNlLCBlLmcuLCB2aWEgU2Vjb25kYXJ5IEJ1cyBSZXNldA0KPiAgIC0gbGlu
ayBnb2VzIGRvd24sIGJyaWRnZSBkaXNhYmxlcyBMVFINCj4gICAtIGxpbmsgY29tZXMgYmFjayB1
cCwgTFRSIGRpc2FibGVkIGluIGJvdGggYnJpZGdlIGFuZCBkZXZpY2UNCj4gICAtIHJlc3RvcmUg
ZGV2aWNlIHN0YXRlLCBpbmNsdWRpbmcgTFRSIGVuYWJsZQ0KPiAgIC0gZGV2aWNlIHNlbmRzIExU
UiBtZXNzYWdlDQo+ICAgLSBicmlkZ2UgcmVwb3J0cyBVbnN1cHBvcnRlZCBSZXF1ZXN0DQo+IA0K
PiA+IC0tLQ0KPiA+IFByZXZpb3VzIHZlcnNpb24gY2FuIGJlIGZvdW5kIGhlcmU6DQo+ID4gDQo+
ID4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyMTAxMTQxMzQ3MjQuNzk1
MTEtMS1taWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tLw0KPiA+IA0KPiA+IENoYW5nZXMg
ZnJvbSB0aGUgcHJldmlvdXMgdmVyc2lvbjoNCj4gPiANCj4gPiAgICogQ29ycmVjdGVkIHR5cG9z
IGluIHRoZSBjb21taXQgbWVzc2FnZQ0KPiA+ICAgKiBObyBuZWVkIHRvIGNhbGwgcGNpZV9kb3du
c3RyZWFtX3BvcnQoKQ0KPiA+IA0KPiA+ICBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgMTcgKysrKysr
KysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2Ry
aXZlcnMvcGNpL3Byb2JlLmMNCj4gPiBpbmRleCAwZWI2OGI0NzM1NGYuLmE0YThjMDMwNWZiOSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+ID4gKysrIGIvZHJpdmVycy9w
Y2kvcHJvYmUuYw0KPiA+IEBAIC0yMTUzLDcgKzIxNTMsNyBAQCBzdGF0aWMgdm9pZCBwY2lfY29u
ZmlndXJlX2x0cihzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiA+ICB7DQo+ID4gICNpZmRlZiBDT05G
SUdfUENJRUFTUE0NCj4gPiAgCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmhvc3QgPSBwY2lfZmlu
ZF9ob3N0X2JyaWRnZShkZXYtPmJ1cyk7DQo+ID4gLQlzdHJ1Y3QgcGNpX2RldiAqYnJpZGdlOw0K
PiA+ICsJc3RydWN0IHBjaV9kZXYgKmJyaWRnZSA9IE5VTEw7DQo+ID4gIAl1MzIgY2FwLCBjdGw7
DQo+ID4gIA0KPiA+ICAJaWYgKCFwY2lfaXNfcGNpZShkZXYpKQ0KPiA+IEBAIC0yMTkxLDYgKzIx
OTEsMjEgQEAgc3RhdGljIHZvaWQgcGNpX2NvbmZpZ3VyZV9sdHIoc3RydWN0IHBjaV9kZXYgKmRl
dikNCj4gPiAgCWlmIChwY2lfcGNpZV90eXBlKGRldikgPT0gUENJX0VYUF9UWVBFX1JPT1RfUE9S
VCB8fA0KPiA+ICAJICAgICgoYnJpZGdlID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShkZXYpKSAmJg0K
PiA+ICAJICAgICAgYnJpZGdlLT5sdHJfcGF0aCkpIHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIERv
d25zdHJlYW0gcG9ydHMgcmVzZXQgdGhlIExUUiBlbmFibGUgYml0IHdoZW4gdGhlDQo+ID4gKwkJ
ICogbGluayBnb2VzIGRvd24gKGUuZyBvbiBob3QtcmVtb3ZlKSBzbyByZS1lbmFibGUgdGhlDQo+
ID4gKwkJICogYml0IGhlcmUgaWYgbm90IHNldCBhbnltb3JlLg0KPiA+ICsJCSAqIFBDSWUgcjUu
MCwgc2VjIDcuNS4zLjE2Lg0KPiA+ICsJCSAqLw0KPiA+ICsJCWlmIChicmlkZ2UpIHsNCj4gPiAr
CQkJcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQoYnJpZGdlLCBQQ0lfRVhQX0RFVkNUTDIsICZj
dGwpOw0KPiA+ICsJCQlpZiAoIShjdGwgJiBQQ0lfRVhQX0RFVkNUTDJfTFRSX0VOKSkgew0KPiA+
ICsJCQkJcGNpX2RiZyhicmlkZ2UsICJyZS1lbmFibGluZyBMVFJcbiIpOw0KPiA+ICsJCQkJcGNp
ZV9jYXBhYmlsaXR5X3NldF93b3JkKGJyaWRnZSwgUENJX0VYUF9ERVZDVEwyLA0KPiA+ICsJCQkJ
CQkJIFBDSV9FWFBfREVWQ1RMMl9MVFJfRU4pOw0KPiA+ICsJCQl9DQo+ID4gKwkJfQ0KPiA+ICsJ
CXBjaV9kYmcoZGV2LCAiZW5hYmxpbmcgTFRSXG4iKTsNCj4gPiAgCQlwY2llX2NhcGFiaWxpdHlf
c2V0X3dvcmQoZGV2LCBQQ0lfRVhQX0RFVkNUTDIsDQo+ID4gIAkJCQkJIFBDSV9FWFBfREVWQ1RM
Ml9MVFJfRU4pOw0KPiA+ICAJCWRldi0+bHRyX3BhdGggPSAxOw0KPiA+IC0tIA0KPiA+IDIuMjku
Mg0KPiA+IA0KDQo=

