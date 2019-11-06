Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63F3F1F91
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKFUOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 15:14:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:42021 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfKFUOe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 15:14:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 12:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="200816626"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga008.fm.intel.com with ESMTP; 06 Nov 2019 12:14:31 -0800
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 12:14:31 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.29]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 12:14:31 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/3] PCI: vmd: Align IRQ lists with child device vectors
Thread-Topic: [PATCH 2/3] PCI: vmd: Align IRQ lists with child device vectors
Thread-Index: AQHVlMmGg0vGws+zFEK04INsqyQZRqd+9l0AgAAjwwA=
Date:   Wed, 6 Nov 2019 20:14:31 +0000
Message-ID: <d250a0f40c1374158be929de253d77f2b7e57a1b.camel@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
         <1573040408-3831-3-git-send-email-jonathan.derrick@intel.com>
         <20191106180630.GC29853@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191106180630.GC29853@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.131]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2EA70454CAE514AA9E97D5BB074AFC5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDAzOjA2ICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDQ6NDA6MDdBTSAtMDcwMCwgSm9uIERlcnJpY2sgd3Jv
dGU6DQo+ID4gSW4gb3JkZXIgdG8gcHJvdmlkZSBiZXR0ZXIgYWZmaW5pdHkgYWxpZ25tZW50IGFs
b25nIHRoZSBlbnRpcmUgc3RvcmFnZQ0KPiA+IHN0YWNrLCBWTUQgSVJRIGxpc3RzIGNhbiBiZSBh
c3NpZ25lZCB0byBpbiBhIG1hbm5lciB3aGVyZSB0aGUgdW5kZXJseWluZw0KPiA+IElSUSBjYW4g
YmUgYWZmaW5pdGl6ZWQgdGhlIHNhbWUgYXMgdGhlIGNoaWxkIChOVk1lKSBkZXZpY2UuDQo+ID4g
DQo+ID4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBhc3NpZ25tZW50IG9mIGNoaWxkIGRldmljZSB2
ZWN0b3JzIGluIElSUSBsaXN0cw0KPiA+IGZyb20gYSByb3VuZC1yb2JpbiBzdHJhdGVneSB0byBh
IG1hdGNoaW5nLWVudHJ5IHN0cmF0ZWd5LiBOVk1lDQo+ID4gYWZmaW5pdGllcyBhcmUgZGV0ZXJt
aW5pc3RpYyBpbiBhIFZNRCBkb21haW4gd2hlbiB0aGVzZSBkZXZpY2VzIGhhdmUgdGhlDQo+ID4g
c2FtZSB2ZWN0b3IgY291bnQgYXMgbGltaXRlZCBieSB0aGUgVk1EIE1TSSBkb21haW4gb3IgY3B1
IGNvdW50LiBXaGVuDQo+ID4gb25lIG9yIG1vcmUgY2hpbGQgZGV2aWNlcyBhcmUgYXR0YWNoZWQg
b24gYSBWTUQgZG9tYWluLCB0aGlzIHBhdGNoDQo+ID4gYWxpZ25zIHRoZSBOVk1lIHN1Ym1pc3Np
b24tc2lkZSBhZmZpbml0eSB3aXRoIHRoZSBWTUQgY29tcGxldGlvbi1zaWRlDQo+ID4gYWZmaW5p
dHkgYXMgaXQgY29tcGxldGVzIHRocm91Z2ggdGhlIFZNRCBJUlEgbGlzdC4NCj4gDQo+IFRoaXMg
cmVhbGx5IG9ubHkgd29ya3MgaWYgdGhlIGNoaWxkIGRldmljZXMgaGF2ZSB0aGUgc2FtZSBpcnEg
Y291bnQgYXMNCj4gdGhlIHZtZCBkZXZpY2UuIElmIHRoZSB2bWQgZGV2aWNlIGhhcyBtb3JlIGlu
dGVycnVwdHMgdGhhbiB0aGUgY2hpbGQNCj4gZGV2aWNlcywgdGhpcyB3aWxsIGVuZCB1cCBvdmVy
bG9hZGluZyB0aGUgbG93ZXIgdm1kIGludGVycnVwdHMgd2l0aG91dA0KPiBldmVuIHVzaW5nIHRo
ZSBoaWdoZXIgb25lcy4NCg0KQ29ycmVjdC4gVGhlIGNoaWxkIE5WTWUgZGV2aWNlIHdvdWxkIG5l
ZWQgdG8gaGF2ZSB0aGUgc2FtZSBvciBtb3JlIHRoYW4NCnRoZSAzMiBJTyB2ZWN0b3JzIFZNRCBv
ZmZlcnMuIFdlIGNvdWxkIGRvIHNvbWV0aGluZyBkeW5hbWljYWxseSB0bw0KZGV0ZXJtaW5lIHdo
ZW4gdG8gZG8gbWF0Y2hpbmctYWZmaW5pdGllcyB2cyByb3VuZC1yb2JpbiwgYnV0IGFzIHRoaXMg
aXMNCmEgaG90cGx1Z2dhYmxlIGRvbWFpbiBpdCBzZWVtcyBmcmFnaWxlIHRvIGJlIGNoYW5naW5n
IGludGVycnVwdHMgaW4NCnN1Y2ggYSB3YXkuDQoNCkkgaGF2ZW4ndCBhY3R1YWxseSBzZWVuIGFu
IE5WTWUgZGV2aWNlIHdpdGggZmV3ZXIgdGhhbiAzMiB2ZWN0b3JzLCBhbmQNCm92ZXJsb2FkaW5n
IFZNRCB2ZWN0b3JzIHNlZW1zIHRvIGJlIHRoZSBsZWFzdCBvZiB0aGUgY29uY2VybnMgb2YNCnBl
cmZvcm1hbmNlIHdpdGggc3VjaCBhIGRldmljZS4gVGhpcyBjb25maWd1cmF0aW9uIHdpbGwgcmVz
dWx0IGluIHdoYXQNCmlzIGVzc2VudGlhbGx5IHRoZSBzYW1lIGlzc3VlIHdlJ3JlIGZhY2luZyB0
b2RheSB3aXRoIHBvb3JseSBhZmZpbmVkDQpWTUQgSVJRIGxpc3RzLg0KDQpGb3IgdGhlIGZ1dHVy
ZSBWTUQgaW1wbGVtZW50YXRpb24gb2ZmZXJpbmcgNjMgSU8gdmVjdG9ycywgeWVzIHRoaXMgd2ls
bA0KYmUgYSBjb25jZXJuIGFuZCBhbGwgSSBjYW4gcmVhbGx5IHN1Z2dlc3QgaXMgdG8gdXNlIGRy
aXZlcyB3aXRoIG1vcmUNCnZlY3RvcnMgdW50aWwgSSBjYW4gZGV0ZXJtaW5lIGEgZ29vZCB3YXkg
dG8gaGFuZGxlIHRoaXMuDQo=
