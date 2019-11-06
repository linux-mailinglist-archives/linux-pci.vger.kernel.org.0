Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9980EF1FE4
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 21:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKFUdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 15:33:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:10006 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfKFUdC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 15:33:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 12:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="228660053"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2019 12:33:01 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.181]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 12:33:01 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Thread-Topic: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Thread-Index: AQHVlMmHESuT4wY8tEuHupbWJEM8x6d+934AgAAir4CAAAOAAIAAAZ8A
Date:   Wed, 6 Nov 2019 20:33:01 +0000
Message-ID: <c3327d3eb56f141cb2dbca4e8f69f0beca2fc8dc.camel@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
         <1573040408-3831-4-git-send-email-jonathan.derrick@intel.com>
         <20191106181032.GD29853@redsun51.ssa.fujisawa.hgst.com>
         <0a4a4151b56567f3c8ca71a29a2e39add6e3bf77.camel@intel.com>
         <20191106202712.GA32215@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191106202712.GA32215@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.131]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF7F069177C0149A64F80E0C0DE6BC1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDA1OjI3ICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDg6MTQ6NDFQTSArMDAwMCwgRGVycmljaywgSm9uYXRo
YW4gd3JvdGU6DQo+ID4gWWVzIHRoYXQgcHJvYmxlbSBleGlzdHMgdG9kYXkgDQo+IA0KPiBOb3Qg
cmVhbGx5LCBiZWNhdXNlIHdlJ3JlIGN1cnJlbnRseSB1c2luZyB1bmFtYW5nZWQgaW50ZXJydXB0
cyB3aGljaA0KPiBtaWdyYXRlIHRvIG9ubGluZSBDUFVzLiBJdCdzIG9ubHkgdGhlIG1hbmFnZWQg
b25lcyB0aGF0IGRvbid0IG1pZ3JhdGUNCj4gYmVjYXVzZSB0aGV5IGhhdmUgYSB1bmNoYW5nZWFi
bGUgYWZmaW5pdHkuDQo+IA0KPiA+IGFuZCB0aGlzIHNldCBsaW1pdHMgdGhlIGV4cG9zdXJlIGFz
IGl0J3MNCj4gPiBhIHJhcmUgY2FzZSB3aGVyZSB5b3UgaGF2ZSBhIGNoaWxkIE5WTWUgZGV2aWNl
IHdpdGggZmV3ZXIgdGhhbiAzMg0KPiA+IHZlY3RvcnMuDQo+IA0KPiBJJ20gZGVlcGx5IHNrZXB0
aWNhbCB0aGF0IGlzIHRoZSBjYXNlLiBFdmVuIHRoZSBQMzcwMCBoYXMgb25seSAzMSBJTw0KPiBx
dWV1ZXMsIHlpZWxkaW5nIDMxIHZlY3RvcnMgZm9yIElPIHNlcnZpY2VzLCBzbyB0aGF0IGFscmVh
ZHkgd29uJ3Qgd29yaw0KPiB3aXRoIHRoaXMgc2NoZW1lLg0KPiANCkRhcm4geW91J3JlIHJpZ2h0
LiBBdCBvbmUgcG9pbnQgSSBoYWQgVk1EIHZlY3RvciAxIHVzaW5nIE5WTWUgQVEsDQpsZWF2aW5n
IHRoZSAzMSByZW1haW5pbmcgVk1EIHZlY3RvcnMgZm9yIE5WTWUgSU8gcXVldWVzLiBUaGlzIHdv
dWxkDQpoYXZlIGxpbmVkIHVwIHBlcmZlY3RseS4gSGFkIGNoYW5nZWQgaXQgbGFzdCBtaW51dGUg
YW5kIHRoYXQgZG9lcyBicmVhaw0KdGhlIHNjaGVtZSBmb3IgUDM3MDAuLi4uDQoNCj4gQnV0IGFz
c3VtaW5nIHlvdSB3YW50ZWQgdG8gb25seSB1c2UgZGV2aWNlcyB0aGF0IGhhdmUgYXQgbGVhc3Qg
MzIgSVJRDQo+IHZlY3RvcnMsIHRoZSBudm1lIGRyaXZlciBhbHNvIGFsbG93cyB1c2VycyB0byBj
YXJ2ZSB0aG9zZSB2ZWN0b3JzIHVwDQo+IGludG8gZnVsbHkgYWZmaW5pdGl6ZWQgc2V0cyBmb3Ig
ZGlmZmVyZW50IHNlcnZpY2VzIChyZWFkIHZzLiB3cml0ZSBpcw0KPiB0aGUgb25lIHRoZSBibG9j
ayBzdGFjayBzdXBwb3J0cyksIHdoaWNoIHdvdWxkIGFsc28gYnJlYWsgaWYgYWxpZ25tZW50DQo+
IHRvIHRoZSBwYXJlbnQgZGV2aWNlJ3MgSVJRIHNldHVwIGlzIHJlcXVpcmVkLg0KDQpXYXNuJ3Qg
YXdhcmUgb2YgdGhpcy4gRmFpciBlbm91Z2guDQo=
