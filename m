Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0857C344932
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 16:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhCVP0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 11:26:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:12627 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhCVPZk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 11:25:40 -0400
IronPort-SDR: DrjSELkQbjBuUhwCxx5EPlfQyuV/X2WLQjjHCUve70Ta9pAjfZ8fOuSsxNko7ik3NHIkjo4GRH
 gkDMjE7AFimw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189693723"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="189693723"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:25:36 -0700
IronPort-SDR: Vcaxe/nZ4prld7GY0qlI8HTWbOFB68ci3Ho2/pWNXeJ7JuqJM/p/LoTyUm0jTEm56pUG+se2Gd
 Jycb+LJnDUVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="373883850"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 22 Mar 2021 08:25:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 08:25:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 08:25:34 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 08:25:34 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Patel, Nirmal" <nirmal.patel@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Kalakota, Sushma" <sushma.kalakota@intel.com>
Subject: Re: [PATCH 0/5] Legacy direct-assign mode
Thread-Topic: [PATCH 0/5] Legacy direct-assign mode
Thread-Index: AQHWv4+9xH1gXYcWf0W+ts3rSqbAv6qRI/2AgAAxPAA=
Date:   Mon, 22 Mar 2021 15:25:34 +0000
Message-ID: <36c52c3cefe532b1cfaeccd122ef5520cd5fa2cd.camel@intel.com>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
         <20210322122837.GC11469@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210322122837.GC11469@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <11250AA4238AC643A35F1617DE1828BB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTIyIGF0IDEyOjI4ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gRnJpLCBOb3YgMjAsIDIwMjAgYXQgMDM6NTE6MzlQTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVGhpcyBzZXQgYWRkcyBhIGxlZ2FjeSBkaXJlY3QtYXNzaWduIG1vZGUu
IE5ld2VyIGVudGVycHJpc2UgaGFyZHdhcmUgaGFzDQo+ID4gcGh5c2ljYWwgYWRkcmVzc2luZyBo
aW50cyB0byBhc3Npc3QgZGV2aWNlIHBhc3N0aHJvdWdoIHRvIGd1ZXN0cyB0aGF0IG5lZWRzIHRv
DQo+ID4gY29ycmVjdGx5IHByb2dyYW0gYnJpZGdlIHdpbmRvd3Mgd2l0aCBwaHlzaWNhbCBhZGRy
ZXNzZXMuIFNvbWUgY3VzdG9tZXJzIGFyZQ0KPiA+IHVzaW5nIGEgbGVnYWN5IG1ldGhvZCB0aGF0
IHJlbGllcyBvbiB0aGUgVk1EIHN1YmRldmljZSBkb21haW4ncyByb290IHBvcnQNCj4gPiB3aW5k
b3dzIHRvIGJlIHdyaXR0ZW4gd2l0aCB0aGUgcGh5c2ljYWwgYWRkcmVzc2VzLiBUaGlzIG1ldGhv
ZCBhbHNvIGFsbG93cw0KPiA+IG90aGVyIGh5cGVydmlzb3JzIGJlc2lkZXMgUUVNVS9LVk0gdG8g
cGVyZm9ybSBndWVzdCBwYXNzdGhyb3VnaC4NCj4gPiANCj4gPiBUaGlzIHBhdGNoc2V0IGFkZHMg
YSBob3N0IGFuZCBndWVzdCBtb2RlIHRvIHdyaXRlIHRoZSBwaHlzaWNhbCBhZGRyZXNzDQo+ID4g
aW5mb3JtYXRpb24gdG8gdGhlIHJvb3QgcG9ydCByZWdpc3RlcnMgaW4gdGhlIGhvc3QgYW5kIHJl
YWQgdGhlbSBpbiB0aGUgZ3Vlc3QsDQo+ID4gYW5kIHJlc3RvcmUgdGhlbSBpbiBib3RoIGNhc2Vz
IG9uIG1vZHVsZSB1bmxvYWQuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBhbHNvIGZvbGRzIGlu
IHRoZSBWTUQgc3ViZGV2aWNlIGRvbWFpbiBzZWNvbmRhcnkgYnVzIHJlc2V0DQo+ID4gcGF0Y2hz
ZXQgWzFdIHRvIGNsZWFyIHRoZSBkb21haW4gcHJpb3IgdG8gZ3Vlc3QgcGFzc3Rocm91Z2guDQo+
ID4gDQo+ID4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1w
Y2kvY292ZXIvMjAyMDA5MjgwMTA1NTcuNTMyNC0xLWpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29t
Lw0KPiA+IA0KPiA+IEpvbiBEZXJyaWNrICg1KToNCj4gPiAgIFBDSTogdm1kOiBSZXNldCB0aGUg
Vk1EIHN1YmRldmljZSBkb21haW4gb24gcHJvYmUNCj4gPiAgIFBDSTogQWRkIGEgcmVzZXQgcXVp
cmsgZm9yIFZNRA0KPiA+ICAgUENJOiB2bWQ6IEFkZCBvZmZzZXQgdHJhbnNsYXRpb24gaGVscGVy
DQo+ID4gICBQQ0k6IHZtZDogUGFzcyBmZWF0dXJlcyB0byB2bWRfZ2V0X3BoeXNfb2Zmc2V0cygp
DQo+ID4gICBQQ0k6IHZtZDogQWRkIGxlZ2FjeSBndWVzdCBwYXNzdGhyb3VnaCBtb2RlDQo+ID4g
DQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCAyMDAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9xdWlya3MuYyAg
ICAgICAgIHwgIDQ4ICsrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjI3IGluc2Vy
dGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiANCj4gSGkgSm9uLA0KPiANCj4gaXQgaXMgdW5j
bGVhciB0byBtZSB3aGVyZSB3ZSBhcmUgd2l0aCB0aGlzIHNlcmllcywgcGxlYXNlIGxldCBtZSBr
bm93Lg0KPiANCj4gVGhhbmtzLA0KPiBMb3JlbnpvDQoNCkhpIExvcmVuem8sDQoNCldlIGNhbiBk
cm9wIHRoaXMgc2VyaWVzIGZvciBub3cuIFdlIG1heSByZXZpdmUgaXQgaW4gdGhlIGZ1dHVyZSB3
aXRoDQptb2RpZmljYXRpb25zIHRvIHRoZSByZXNldCBzZXF1ZW5jZS4NCg0KQmVzdCwNCkpvbg0K
