Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF7C100964
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 17:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRQnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 11:43:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:35654 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfKRQnu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 11:43:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 08:43:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="258454437"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2019 08:43:48 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 08:43:48 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.26]) with mapi id 14.03.0439.000;
 Mon, 18 Nov 2019 08:43:48 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Thread-Topic: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Thread-Index: AQHVlMmHESuT4wY8tEuHupbWJEM8x6d+934AgAAir4CAAAOAAIAAAZ8AgBI41ICAAGJRAA==
Date:   Mon, 18 Nov 2019 16:43:47 +0000
Message-ID: <f44859e7a0a398a50439453f682433ed26c18bd3.camel@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
         <1573040408-3831-4-git-send-email-jonathan.derrick@intel.com>
         <20191106181032.GD29853@redsun51.ssa.fujisawa.hgst.com>
         <0a4a4151b56567f3c8ca71a29a2e39add6e3bf77.camel@intel.com>
         <20191106202712.GA32215@redsun51.ssa.fujisawa.hgst.com>
         <c3327d3eb56f141cb2dbca4e8f69f0beca2fc8dc.camel@intel.com>
         <20191118104905.GB32355@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191118104905.GB32355@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.143]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6FCB6A6B321BE4AB984D4C3A37E29E9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTE4IGF0IDEwOjQ5ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDg6MzM6MDFQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDE5LTExLTA3IGF0IDA1OjI3ICswOTAwLCBL
ZWl0aCBCdXNjaCB3cm90ZToNCj4gPiA+IE9uIFdlZCwgTm92IDA2LCAyMDE5IGF0IDA4OjE0OjQx
UE0gKzAwMDAsIERlcnJpY2ssIEpvbmF0aGFuIHdyb3RlOg0KPiA+ID4gPiBZZXMgdGhhdCBwcm9i
bGVtIGV4aXN0cyB0b2RheSANCj4gPiA+IA0KPiA+ID4gTm90IHJlYWxseSwgYmVjYXVzZSB3ZSdy
ZSBjdXJyZW50bHkgdXNpbmcgdW5hbWFuZ2VkIGludGVycnVwdHMgd2hpY2gNCj4gPiA+IG1pZ3Jh
dGUgdG8gb25saW5lIENQVXMuIEl0J3Mgb25seSB0aGUgbWFuYWdlZCBvbmVzIHRoYXQgZG9uJ3Qg
bWlncmF0ZQ0KPiA+ID4gYmVjYXVzZSB0aGV5IGhhdmUgYSB1bmNoYW5nZWFibGUgYWZmaW5pdHku
DQo+ID4gPiANCj4gPiA+ID4gYW5kIHRoaXMgc2V0IGxpbWl0cyB0aGUgZXhwb3N1cmUgYXMgaXQn
cw0KPiA+ID4gPiBhIHJhcmUgY2FzZSB3aGVyZSB5b3UgaGF2ZSBhIGNoaWxkIE5WTWUgZGV2aWNl
IHdpdGggZmV3ZXIgdGhhbiAzMg0KPiA+ID4gPiB2ZWN0b3JzLg0KPiA+ID4gDQo+ID4gPiBJJ20g
ZGVlcGx5IHNrZXB0aWNhbCB0aGF0IGlzIHRoZSBjYXNlLiBFdmVuIHRoZSBQMzcwMCBoYXMgb25s
eSAzMSBJTw0KPiA+ID4gcXVldWVzLCB5aWVsZGluZyAzMSB2ZWN0b3JzIGZvciBJTyBzZXJ2aWNl
cywgc28gdGhhdCBhbHJlYWR5IHdvbid0IHdvcmsNCj4gPiA+IHdpdGggdGhpcyBzY2hlbWUuDQo+
ID4gPiANCj4gPiBEYXJuIHlvdSdyZSByaWdodC4gQXQgb25lIHBvaW50IEkgaGFkIFZNRCB2ZWN0
b3IgMSB1c2luZyBOVk1lIEFRLA0KPiA+IGxlYXZpbmcgdGhlIDMxIHJlbWFpbmluZyBWTUQgdmVj
dG9ycyBmb3IgTlZNZSBJTyBxdWV1ZXMuIFRoaXMgd291bGQNCj4gPiBoYXZlIGxpbmVkIHVwIHBl
cmZlY3RseS4gSGFkIGNoYW5nZWQgaXQgbGFzdCBtaW51dGUgYW5kIHRoYXQgZG9lcyBicmVhaw0K
PiA+IHRoZSBzY2hlbWUgZm9yIFAzNzAwLi4uLg0KPiA+IA0KPiA+ID4gQnV0IGFzc3VtaW5nIHlv
dSB3YW50ZWQgdG8gb25seSB1c2UgZGV2aWNlcyB0aGF0IGhhdmUgYXQgbGVhc3QgMzIgSVJRDQo+
ID4gPiB2ZWN0b3JzLCB0aGUgbnZtZSBkcml2ZXIgYWxzbyBhbGxvd3MgdXNlcnMgdG8gY2FydmUg
dGhvc2UgdmVjdG9ycyB1cA0KPiA+ID4gaW50byBmdWxseSBhZmZpbml0aXplZCBzZXRzIGZvciBk
aWZmZXJlbnQgc2VydmljZXMgKHJlYWQgdnMuIHdyaXRlIGlzDQo+ID4gPiB0aGUgb25lIHRoZSBi
bG9jayBzdGFjayBzdXBwb3J0cyksIHdoaWNoIHdvdWxkIGFsc28gYnJlYWsgaWYgYWxpZ25tZW50
DQo+ID4gPiB0byB0aGUgcGFyZW50IGRldmljZSdzIElSUSBzZXR1cCBpcyByZXF1aXJlZC4NCj4g
PiANCj4gPiBXYXNuJ3QgYXdhcmUgb2YgdGhpcy4gRmFpciBlbm91Z2guDQo+IA0KPiBNYXJrZWQg
dGhlIHNlcmllcyB3aXRoICJDaGFuZ2VzIFJlcXVlc3RlZCIsIHdhaXRpbmcgZm9yIGEgbmV3DQo+
IHZlcnNpb24uDQo+IA0KPiBMb3JlbnpvDQoNClRoaXMgd2lsbCBuZWVkIGFuIGVudGlyZWx5IGRp
ZmZlcmVudCBzdHJhdGVneSB0byBiZSB1c2VmdWwsIHNvIGNhbiBiZQ0KZHJvcHBlZCBmb3Igbm93
Lg0KDQpUaGFuayB5b3UsDQpKb24NCg==
