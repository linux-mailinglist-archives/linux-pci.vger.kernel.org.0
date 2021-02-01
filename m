Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290B230A072
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 04:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhBADCb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Jan 2021 22:02:31 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41840 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231336AbhBADCa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jan 2021 22:02:30 -0500
X-UUID: 36e3e8bb05c54d0c84966d9b51e58f55-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4DaRnR0RDonEuYHoySDMzHFlzRHmLObfdyELeUP0L7A=;
        b=S+hdQzQiqrfQVr9s1EszAIw9rfagaWlpNkmlESTn9a3ymUqbjfmPNgOuJ5S90D5lvDJKYPM4Tka9WewCRRxzDwlxXXblPjuOvdc453wYS+QiitXTJrzbdbtzZ2auNa8KFjm0/oFHgaRS1B9omq0QfMIaFEUJQAw5z1HVcPSZmqA=;
X-UUID: 36e3e8bb05c54d0c84966d9b51e58f55-20210201
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <mingchuang.qiao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 91236079; Mon, 01 Feb 2021 11:01:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Feb
 2021 11:01:27 +0800
Received: from [10.19.240.15] (10.19.240.15) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 11:01:26 +0800
Message-ID: <1612148486.5980.115.camel@mcddlt001>
Subject: Re: [v2] PCI: Avoid unsync of LTR mechanism configuration
From:   Mingchuang Qiao <mingchuang.qiao@mediatek.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <haijun.liu@mediatek.com>,
        <lambert.wang@mediatek.com>, <kerun.zhu@mediatek.com>,
        <alex.williamson@redhat.com>, <rjw@rjwysocki.net>,
        <utkarsh.h.patel@intel.com>
Date:   Mon, 1 Feb 2021 11:01:26 +0800
In-Reply-To: <20210128142742.GV2542@lahna.fi.intel.com>
References: <20210128100531.2694-1-mingchuang.qiao@mediatek.com>
         <20210128142742.GV2542@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F3737F1BBDFC02D87822EE46E76318472CAB920FD28DF5C228C7598C6FB5B9F92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTI4IGF0IDE2OjI3ICswMjAwLCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6
DQo+IEhpLA0KPiANCj4gT24gVGh1LCBKYW4gMjgsIDIwMjEgYXQgMDY6MDU6MzFQTSArMDgwMCwg
bWluZ2NodWFuZy5xaWFvQG1lZGlhdGVrLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBNaW5nY2h1YW5n
IFFpYW8gPG1pbmdjaHVhbmcucWlhb0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gSW4gYnVzIHNj
YW4gZmxvdywgdGhlICJMVFIgTWVjaGFuaXNtIEVuYWJsZSIgYml0IG9mIERFVkNUTDIgcmVnaXN0
ZXIgaXMNCj4gPiBjb25maWd1cmVkIGluIHBjaV9jb25maWd1cmVfbHRyKCkuIElmIGRldmljZSBh
bmQgYnJpZGdlIGJvdGggc3VwcG9ydCBMVFINCj4gPiBtZWNoYW5pc20sIHRoZSAiTFRSIE1lY2hh
bmlzbSBFbmFibGUiIGJpdCBvZiBkZXZpY2UgYW5kIGJyaWRnZSB3aWxsIGJlDQo+ID4gZW5hYmxl
ZCBpbiBERVZDVEwyIHJlZ2lzdGVyLiBBbmQgcGNpX2Rldi0+bHRyX3BhdGggd2lsbCBiZSBzZXQg
YXMgMS4NCj4gPiANCj4gPiBJZiBQQ0llIGxpbmsgZ29lcyBkb3duIHdoZW4gZGV2aWNlIHJlc2V0
cywgdGhlICJMVFIgTWVjaGFuaXNtIEVuYWJsZSIgYml0DQo+ID4gb2YgYnJpZGdlIHdpbGwgY2hh
bmdlIHRvIDAgYWNjb3JkaW5nIHRvIFBDSWUgcjUuMCwgc2VjIDcuNS4zLjE2LiBIb3dldmVyLA0K
PiA+IHRoZSBwY2lfZGV2LT5sdHJfcGF0aCB2YWx1ZSBvZiBicmlkZ2UgaXMgc3RpbGwgMS4NCj4g
PiANCj4gPiBGb3IgZm9sbG93aW5nIGNvbmRpdGlvbnMsIGNoZWNrIGFuZCByZS1jb25maWd1cmUg
IkxUUiBNZWNoYW5pc20gRW5hYmxlIiBiaXQNCj4gPiBvZiBicmlkZ2UgdG8gbWFrZSAiTFRSIE1l
Y2hhbmlzbSBFbmFibGUiIGJpdCBtdGFjaCBsdHJfcGF0aCB2YWx1ZS4NCj4gPiAgICAtYmVmb3Jl
IGNvbmZpZ3VyaW5nIGRldmljZSdzIExUUiBmb3IgaG90LXJlbW92ZS9ob3QtYWRkDQo+ID4gICAg
LWJlZm9yZSByZXN0b3JpbmcgZGV2aWNlJ3MgREVWQ1RMMiByZWdpc3RlciB3aGVuIHJlc3RvcmUg
ZGV2aWNlIHN0YXRlDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZ2NodWFuZyBRaWFvIDxt
aW5nY2h1YW5nLnFpYW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IGNoYW5nZXMgb2YgdjIN
Cj4gPiAgLW1vZGlmeSBwYXRjaCBkZXNjcmlwdGlvbg0KPiA+ICAtcmVjb25maWd1cmUgYnJpZGdl
J3MgTFRSIGJlZm9yZSByZXN0b3JpbmcgZGV2aWNlIERFVkNUTDIgcmVnaXN0ZXINCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9wY2kvcGNpLmMgICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgZHJpdmVycy9wY2kvcHJvYmUuYyB8IDE5ICsrKysrKysrKysrKysrKystLS0NCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jDQo+
ID4gaW5kZXggYjlmZWNjMjVkMjEzLi44OGI0ZWI3MGMyNTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9wY2kvcGNpLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2kuYw0KPiA+IEBAIC0xNDM3
LDYgKzE0MzcsMjQgQEAgc3RhdGljIGludCBwY2lfc2F2ZV9wY2llX3N0YXRlKHN0cnVjdCBwY2lf
ZGV2ICpkZXYpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIHZv
aWQgcGNpX3JlY29uZmlndXJlX2JyaWRnZV9sdHIoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gPiAr
ew0KPiA+ICsjaWZkZWYgQ09ORklHX1BDSUVBU1BNDQo+ID4gKwlzdHJ1Y3QgcGNpX2RldiAqYnJp
ZGdlOw0KPiA+ICsJdTMyIGN0bDsNCj4gPiArDQo+ID4gKwlicmlkZ2UgPSBwY2lfdXBzdHJlYW1f
YnJpZGdlKGRldik7DQo+ID4gKwlpZiAoYnJpZGdlICYmIGJyaWRnZS0+bHRyX3BhdGgpIHsNCj4g
PiArCQlwY2llX2NhcGFiaWxpdHlfcmVhZF9kd29yZChicmlkZ2UsIFBDSV9FWFBfREVWQ1RMMiwg
JmN0bCk7DQo+ID4gKwkJaWYgKCEoY3RsICYgUENJX0VYUF9ERVZDVEwyX0xUUl9FTikpIHsNCj4g
PiArCQkJcGNpX2RiZyhicmlkZ2UsICJyZS1lbmFibGluZyBMVFJcbiIpOw0KPiA+ICsJCQlwY2ll
X2NhcGFiaWxpdHlfc2V0X3dvcmQoYnJpZGdlLCBQQ0lfRVhQX0RFVkNUTDIsDQo+ID4gKwkJCQkJ
CSBQQ0lfRVhQX0RFVkNUTDJfTFRSX0VOKTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKyNlbmRp
Zg0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCBwY2lfcmVzdG9yZV9wY2llX3N0YXRl
KHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4gIHsNCj4gPiAgCWludCBpID0gMDsNCj4gPiBAQCAt
MTQ0Nyw2ICsxNDY1LDEzIEBAIHN0YXRpYyB2b2lkIHBjaV9yZXN0b3JlX3BjaWVfc3RhdGUoc3Ry
dWN0IHBjaV9kZXYgKmRldikNCj4gPiAgCWlmICghc2F2ZV9zdGF0ZSkNCj4gPiAgCQlyZXR1cm47
DQo+ID4gIA0KPiA+ICsJLyoNCj4gPiArCSAqIERvd25zdHJlYW0gcG9ydHMgcmVzZXQgdGhlIExU
UiBlbmFibGUgYml0IHdoZW4gbGluayBnb2VzIGRvd24uDQo+ID4gKwkgKiBDaGVjayBhbmQgcmUt
Y29uZmlndXJlIHRoZSBiaXQgaGVyZSBiZWZvcmUgcmVzdG9yaW5nIGRldmljZS4NCj4gPiArCSAq
IFBDSWUgcjUuMCwgc2VjIDcuNS4zLjE2Lg0KPiA+ICsJICovDQo+ID4gKwlwY2lfcmVjb25maWd1
cmVfYnJpZGdlX2x0cihkZXYpOw0KPiA+ICsNCj4gPiAgCWNhcCA9ICh1MTYgKikmc2F2ZV9zdGF0
ZS0+Y2FwLmRhdGFbMF07DQo+ID4gIAlwY2llX2NhcGFiaWxpdHlfd3JpdGVfd29yZChkZXYsIFBD
SV9FWFBfREVWQ1RMLCBjYXBbaSsrXSk7DQo+ID4gIAlwY2llX2NhcGFiaWxpdHlfd3JpdGVfd29y
ZChkZXYsIFBDSV9FWFBfTE5LQ1RMLCBjYXBbaSsrXSk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+ID4gaW5kZXggOTUzZjE1YWJj
ODUwLi40YWQxNzI1MTdmZDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcHJvYmUuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL3Byb2JlLmMNCj4gPiBAQCAtMjEzMiw5ICsyMTMyLDIyIEBA
IHN0YXRpYyB2b2lkIHBjaV9jb25maWd1cmVfbHRyKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4g
IAkgKiBDb21wbGV4IGFuZCBhbGwgaW50ZXJtZWRpYXRlIFN3aXRjaGVzIGluZGljYXRlIHN1cHBv
cnQgZm9yIExUUi4NCj4gPiAgCSAqIFBDSWUgcjQuMCwgc2VjIDYuMTguDQo+ID4gIAkgKi8NCj4g
PiAtCWlmIChwY2lfcGNpZV90eXBlKGRldikgPT0gUENJX0VYUF9UWVBFX1JPT1RfUE9SVCB8fA0K
PiA+IC0JICAgICgoYnJpZGdlID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShkZXYpKSAmJg0KPiA+IC0J
ICAgICAgYnJpZGdlLT5sdHJfcGF0aCkpIHsNCj4gPiArCWlmIChwY2lfcGNpZV90eXBlKGRldikg
PT0gUENJX0VYUF9UWVBFX1JPT1RfUE9SVCkgew0KPiA+ICsJCXBjaWVfY2FwYWJpbGl0eV9zZXRf
d29yZChkZXYsIFBDSV9FWFBfREVWQ1RMMiwNCj4gPiArCQkJCQkgUENJX0VYUF9ERVZDVEwyX0xU
Ul9FTik7DQo+ID4gKwkJZGV2LT5sdHJfcGF0aCA9IDE7DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCWJyaWRnZSA9IHBjaV91cHN0cmVhbV9icmlkZ2UoZGV2KTsNCj4gPiAr
CWlmIChicmlkZ2UgJiYgYnJpZGdlLT5sdHJfcGF0aCkgew0KPiA+ICsJCXBjaWVfY2FwYWJpbGl0
eV9yZWFkX2R3b3JkKGJyaWRnZSwgUENJX0VYUF9ERVZDVEwyLCAmY3RsKTsNCj4gPiArCQlpZiAo
IShjdGwgJiBQQ0lfRVhQX0RFVkNUTDJfTFRSX0VOKSkgew0KPiA+ICsJCQlwY2lfZGJnKGJyaWRn
ZSwgInJlLWVuYWJsaW5nIExUUlxuIik7DQo+ID4gKwkJCXBjaWVfY2FwYWJpbGl0eV9zZXRfd29y
ZChicmlkZ2UsIFBDSV9FWFBfREVWQ1RMMiwNCj4gPiArCQkJCQkJIFBDSV9FWFBfREVWQ1RMMl9M
VFJfRU4pOw0KPiA+ICsJCX0NCj4gPiArDQo+IA0KPiBDYW4ndCB5b3UgdXNlIHBjaV9yZWNvbmZp
Z3VyZV9icmlkZ2VfbHRyKCkgaGVyZSB0b28/DQo+IA0KPiBPdGhlcndpc2UgbG9va3MgZ29vZC4N
Cg0KVGhhbmtzIGZvciByZXZpZXcuIEkgaGF2ZSBzZW50IGEgbmV3IHBhdGNoIGZvciB0aGlzLg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDIxMDEyOTA3MTEzNy44
NzQzLTEtbWluZ2NodWFuZy5xaWFvQG1lZGlhdGVrLmNvbS8gDQoNCg==

