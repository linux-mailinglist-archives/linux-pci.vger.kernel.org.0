Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED3432EFAF
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCEQIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 11:08:30 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:37358 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230023AbhCEQIM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 11:08:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 22F18412FC;
        Fri,  5 Mar 2021 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1614960488; x=
        1616774889; bh=Lgm8O5kDBSPzbgyEEg2T656NF3gHClwH82FUP9Gow20=; b=d
        dYka3z7KnfdVBqDS4BpIv9IP7gDuEKESxxoLX8htOAhOIOOUG18aayvXFgVLCkc4
        8kcfqCJOj4dCjuqxkIVG+eJLt+TEy4FN1l00S/3jjmgWkziYuPa6vuiLYzg/Krg4
        evjOy0sXxZ5HyiwMR4xajTChgdUFRla8HhR+O1sI7o=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lu5Yq3ISsruM; Fri,  5 Mar 2021 19:08:08 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AA11E4127C;
        Fri,  5 Mar 2021 19:08:08 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (172.17.100.103) by
 T-EXCH-03.corp.yadro.com (172.17.100.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 5 Mar 2021 19:08:08 +0300
Received: from T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272]) by
 T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272%14]) with mapi id
 15.01.0669.032; Fri, 5 Mar 2021 19:08:08 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "andrey.grodzovsky@amd.com" <andrey.grodzovsky@amd.com>
CC:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re: Question about supporting AMD eGPU hot plug case
Thread-Topic: Question about supporting AMD eGPU hot plug case
Thread-Index: AQHW+OZCLrcKjeWn9U26wbGoIrW3kKpDtUMAgAMa8QCAAZA8AIAHl62AgAGbQTWAAcXUAIABBq+AgAgRTACAAdG764AF+qGAgAOCQVGAABswAIAAiN+AgADALoCAAM2HAIAKSU2AgAFUg4A=
Date:   Fri, 5 Mar 2021 16:08:08 +0000
Message-ID: <1647946cb73ae390b40a593bb021699308bab33e.camel@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
         <MN2PR12MB44880052F5C4ECF3EF22B58EF7B69@MN2PR12MB4488.namprd12.prod.outlook.com>
         <ffb816ae8336ff2373ec5fcf695e698900c3d557.camel@yadro.com>
         <9c41221f-ecfa-5554-f2ea-6f72cfe7dc7e@amd.com>
         <dae8dfd8-3a99-620d-f0aa-ceb39923b807@amd.com>
         <7d9e947648ce47a4ba8d223cdec08197@yadro.com>
         <c82919f3-5296-cd0a-0b8f-c33614ca3ea9@amd.com>
         <340062dba82b813b311b2c78022d2d3d0e6f414d.camel@yadro.com>
         <927d7fbe-756f-a4f1-44cd-c68aecd906d7@amd.com>
         <dc2de228b92c4e27819c7681f650e1e5@yadro.com>
         <a6af29ed-179a-7619-3dde-474542c180f4@amd.com>
         <8f53f1403f0c4121885398487bbfa241@yadro.com>
         <fc2ea091-8470-9501-242d-8d82714adecb@amd.com>
         <50afd1079dbabeba36fd35fdef84e6e15470ef45.camel@yadro.com>
         <c53c23b5-dd37-44f1-dffd-ff9699018a82@amd.com>
         <8d7e2d7b7982d8d78c0ecaa74b9d40ace4db8453.camel@yadro.com>
         <f5a9bc49-3708-a4af-fff1-6822b49732c0@amd.com>
In-Reply-To: <f5a9bc49-3708-a4af-fff1-6822b49732c0@amd.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <34F5E30DA842EE409BF0937CAA21EE85@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTA0IGF0IDE0OjQ5IC0wNTAwLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90
ZToNCj4gKyBsaW51eC1wY2kNCj4gDQo+IE9uIDIwMjEtMDItMjYgMTo0NCBhLm0uLCBTZXJnZWkg
TWlyb3NobmljaGVua28gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIxLTAyLTI1IGF0IDEzOjI4IC0w
NTAwLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToNCj4gPiA+IE9uIDIwMjEtMDItMjUgMjowMCBh
Lm0uLCBTZXJnZWkgTWlyb3NobmljaGVua28gd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgMjAyMS0w
Mi0yNCBhdCAxNzo1MSAtMDUwMCwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6DQo+ID4gPiA+ID4g
T24gMjAyMS0wMi0yNCAxOjIzIHAubS4sIFNlcmdlaSBNaXJvc2huaWNoZW5rbyB3cm90ZToNCj4g
PiA+ID4gPiA+IC4uLg0KPiA+ID4gPiA+IEFyZSB5b3Ugc2F5aW5nIHRoYXQgZXZlbiB3aXRob3V0
IGhvdC1wbHVnZ2luZywgd2hpbGUgYm90aA0KPiA+ID4gPiA+IG52bWUNCj4gPiA+ID4gPiBhbmQN
Cj4gPiA+ID4gPiBBTUQNCj4gPiA+ID4gPiBjYXJkIGFyZSBwcmVzZW50DQo+ID4gPiA+ID4gcmln
aHQgZnJvbSBib290LCB5b3Ugc3RpbGwgZ2V0IEJBUnMgbW92aW5nIGFuZCBNTUlPIHJhbmdlcw0K
PiA+ID4gPiA+IHJlYXNzaWduZWQNCj4gPiA+ID4gPiBmb3IgTlZNRSBCQVJzDQo+ID4gPiA+ID4g
anVzdCBiZWNhdXNlIGFtZGdwdSBkcml2ZXIgd2lsbCBzdGFydCByZXNpemUgb2YgQU1EIGNhcmQg
QkFScw0KPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiB3aWxsIHRyaWdn
ZXIgTlZNRXMgQkFScyBtb3ZlIHRvDQo+ID4gPiA+ID4gYWxsb3cgQU1EIGNhcmQgQkFScyB0byBj
b3ZlciBmdWxsIHJhbmdlIG9mIFZJREVPIFJBTSA/DQo+ID4gPiA+IFllcy4gVW5jb25kaXRpb25h
bGx5LCBiZWNhdXNlIGl0IGlzIHVua25vd24gYmVmb3JlaGFuZCBpZg0KPiA+ID4gPiBOVk1lJ3MN
Cj4gPiA+ID4gQkFSDQo+ID4gPiA+IG1vdmVtZW50IHdpbGwgaGVscC4gSW4gdGhpcyBwYXJ0aWN1
bGFyIGNhc2UgQkFSIG1vdmVtZW50IGlzIG5vdA0KPiA+ID4gPiBuZWVkZWQsDQo+ID4gPiA+IGJ1
dCBpcyBkb25lIGFueXdheS4NCj4gPiA+ID4gDQo+ID4gPiA+IEJBUnMgYXJlIG5vdCBtb3ZlZCBv
bmUgYnkgb25lLCBidXQgdGhlIGtlcm5lbCByZWxlYXNlcyBhbGwgdGhlDQo+ID4gPiA+IHJlbGVh
c2FibGUgb25lcywgYW5kIHRoZW4gcmVjYWxjdWxhdGVzIGEgbmV3IEJBUiBsYXlvdXQgdG8gZml0
DQo+ID4gPiA+IHRoZW0NCj4gPiA+ID4gYWxsLiBLZXJuZWwncyBhbGdvcml0aG0gaXMgZGlmZmVy
ZW50IGZyb20gQklPUydzLCBzbyBOVk1FIGhhcw0KPiA+ID4gPiBhcHBlYXJlZA0KPiA+ID4gPiBh
dCBhIG5ldyBwbGFjZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgaXMgdHJpZ2dlcmVkIGJ5IGZv
bGxvd2luZzoNCj4gPiA+ID4gLSBhdCBib290LCBpZiBCSU9TIGhhZCBhc3NpZ25lZCBub3QgZXZl
cnkgQkFSOw0KPiA+ID4gPiAtIGR1cmluZyBwY2lfcmVzaXplX3Jlc291cmNlKCk7DQo+ID4gPiA+
IC0gZHVyaW5nIHBjaV9yZXNjYW5fYnVzKCkgLS0gYWZ0ZXIgYSBwY2llaHAgZXZlbnQgb3IgYSBt
YW51YWwNCj4gPiA+ID4gdmlhDQo+ID4gPiA+IHN5c2ZzLg0KPiA+ID4gDQo+ID4gPiBCeSBtYW51
YWwgdmlhIHN5c2ZzIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlIHRoaXMgLSAnZWNobyAxID4NCj4g
PiA+IC9zeXMvYnVzL3BjaS9kcml2ZXJzL2FtZGdwdS8wMDAwXDowY1w6MDAuMC9yZW1vdmUgJiYg
ZWNobyAxID4NCj4gPiA+IC9zeXMvYnVzL3BjaS9yZXNjYW4gJyA/IEkgYW0gbG9va2luZyBpbnRv
IGhvdyBtb3N0IHJlbGlhYmx5DQo+ID4gPiB0cmlnZ2VyDQo+ID4gPiBQQ0kNCj4gPiA+IGNvZGUg
dG8gY2FsbCBteSBjYWxsYmFja3MgZXZlbiB3aXRob3V0IGhhdmluZyBleHRlcm5hbCBQQ0kgY2Fn
ZQ0KPiA+ID4gZm9yDQo+ID4gPiBHUFUNCj4gPiA+ICh3aWxsIHRha2UgbWUgc29tZSB0aW1lIHRv
IGdldCBpdCkuDQo+ID4gDQo+ID4gWWVhaCwgdGhpcyBpcyBvdXIgd2F5IHRvIGdvIHdoZW4gYSBk
ZXZpY2UgY2FuJ3QgYmUgcGh5c2ljYWxseQ0KPiA+IHJlbW92ZWQNCj4gPiBvciB1bnBvd2VyZWQg
cmVtb3RlbHkuIFdpdGgganVzdCBhIGJpdCBzaG9ydGVyIHBhdGg6DQo+ID4gDQo+ID4gICAgc3Vk
byBzaCAtYyAnZWNobyAxID4gL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMFw6MGNcOjAwLjAvcmVt
b3ZlJw0KPiA+ICAgIHN1ZG8gc2ggLWMgJ2VjaG8gMSA+IC9zeXMvYnVzL3BjaS9yZXNjYW4nDQo+
ID4gDQo+ID4gT3IsIGp1c3QgYSBzZWNvbmQgY29tbWFuZCAocmVzY2FuKSBpcyBlbm91Z2g6IGEg
QkFSIG1vdmVtZW50DQo+ID4gYXR0ZW1wdA0KPiA+IHdpbGwgYmUgdHJpZ2dlcmVkIGV2ZW4gaWYg
dGhlcmUgd2VyZSBubyBjaGFuZ2VzIGluIFBDSSB0b3BvbG9neS4NCj4gPiANCj4gPiBTZXJnZQ0K
PiA+IA0KPiANCj4gSGkgU2VncmVpDQo+IA0KPiBIZXJlIGlzIGEgbGluayB0byBpbml0aWFsIGlt
cGxlbWVudGF0aW9uIG9uIHRvcCBvZiB5b3VyIHRyZWUgDQo+IChtb3ZhYmxlX2JhcnNfdjkuMSkg
LSANCj4gaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9+YWdyb2R6b3YvbGludXgvY29tbWl0
Lz9oPXlhZHJvL3BjaWVfaG90cGx1Zy9tb3ZhYmxlX2JhcnNfdjkuMSZpZD0wNWQ2YWJjZWVkNjUw
MTgxYmI3ZmUwYTQ5ODg0YTI2ZTM3OGI5MDhlDQo+IEkgYW0gYWJsZSB0byBwYXNzIG9uZSByZS1z
Y2FuIGN5Y2xlIGFuZCBjYW4gdXNlIHRoZSBjYXJkIGFmdGVyd2FyZHMNCj4gKHNlZSANCj4gbG9n
MS5sb2cpLg0KPiBCdXQsIGFjY29yZGluZyB0byB5b3VyIHByaW50cyBvbmx5IEJBUjUgd2hpY2gg
aXMgcmVnaXN0ZXJzIEJBUiB3YXMNCj4gdXBkYXRlZCAoYW1kZ3B1IDAwMDA6MGI6MDAuMDogQkFS
IDUgdXBkYXRlZDogMHhmY2MwMDAwMCAtPg0KPiAweGZjMTAwMDAwKQ0KPiB3aGlsZSBJIGFtIGlu
dGVyZXN0ZWQgdG8gdGVzdCBCQVIwIChHcmFwaGljIFJBTSkgbW92ZSBzaW5jZSB0aGlzIGlzDQo+
IHdoZXJlIG1vc3Qgb2YgdGhlIGNvbXBsZXhpdHkgaXMuIElzIHRoZXJlIGEgd2F5IHRvIGhhY2sg
eW91ciBjb2RlIHRvIA0KPiBmb3JjZSB0aGlzID8NCg0KSGkgQW5kcmV5LA0KDQpSZWdhcmRpbmcg
dGhlIGFtZGdwdSdzIEJBUjAgcmVtYWluaW5nIG9uIGl0cyBwbGFjZTogaXQgc2VlbXMgdGhpcyBp
cw0KYmVjYXVzZSBvZiBmaXhlZCBCQVJzIHN0YXJ0aW5nIGZyb20gZmM2MDAwMDAuIFRoZSBrZXJu
ZWwgdGVuZHMgdG8gZ3JvdXANCnRoZSBCQVJzIGNsb3NlIHRvIGVhY2ggb3RoZXIsIG1ha2luZyBh
IGJyaWRnZSB3aW5kb3cgYXMgY29tcGFjdCBhcw0KcG9zc2libGUuIFNvIHRoZSBCQVIwIGhhZCBv
Y2N1cGllZCB0aGUgY2xvc2VzdCAiY29tZm9ydGFibGUiIHNsb3RzDQoweGUwMDAwMDAwLTB4ZWZm
ZmZmZmYsIHdpdGggdGhlIHJlc3VsdGluZyBicmlkZ2Ugd2luZG93IG9mIGJ1cyAwMA0KY292ZXJp
bmcgYWxsIHRoZSBCQVJzOg0KDQogICAgcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSAxMCBbbWVt
IDB4ZTAwMDAwMDAtMHhmZWMyZmZmZiB3aW5kb3ddDQoNCkknbGwgbGV0IHlvdSBrbm93IGlmIEkg
Z2V0IGFuIGlkZWEgaG93IHRvIHJlYXJyYW5nZSB0aGF0IG1hbnVhbGx5Lg0KDQpUd28gR1BVcyBj
YW4gYWN0dWFsbHkgc3dhcCB0aGVpciBwbGFjZXMuDQoNCldoYXQgYWxzbyBjYW4gbWFrZSBhIEJB
UiBtb3ZhYmxlIC0tIGlzIHJtbW9kJ2luZyBpdHMgZHJpdmVyLiBJdCBjb3VsZA0KYmUgc29tZSBo
YWNrIGZyb20gd2l0aGluIGEgdG11eCwgbGlrZToNCg0KICBybW1vZCBpZ2I7IFwNCiAgcm1tb2Qg
eGhjaV9oY2Q7IFwNCiAgcm1tb2QgYWhjaTsgXA0KICBlY2hvIDEgPiAvc3lzL2J1cy9wY2kvcmVz
Y2FuOyBcDQogIG1vZHByb2JlIGlnYjsgXA0KICBtb2Rwcm9iZSB4aGNpX2hjZDsgXA0KICBtb2Rw
cm9iZSBhaGNpDQoNCkkgdGhpbmsgcGNpX3JlbGVhc2VfcmVzb3VyY2UoKSBzaG91bGQgbm90IGJl
IGluDQphbWRncHVfZGV2aWNlX3VubWFwX21taW8oKSAtLSB0aGUgcGF0Y2hlZCBrZXJuZWwgd2ls
bCBkbyB0aGF0IGl0c2VsZg0KZm9yIEJBUnMgdGhlIGFtZGdwdV9kZXZpY2VfYmFyX2ZpeGVkKCkg
cmV0dXJucyBmYWxzZS4gRXZlbiBtb3JlIC0tIHRoZQ0Ka2VybmVsIHdpbGwgZW5zdXJlIHRoYXQg
YWxsIEJBUnMgd2hpY2ggd2VyZSB3b3JraW5nIGJlZm9yZSwgYXJlDQpyZWFzc2lnbmVkIHByb3Bl
cmx5LCBzbyBpdCBuZWVkcyB0aGVtIHRvIGJlIGFzc2lnbmVkIGJlZm9yZSB0aGUNCnByb2NlZHVy
ZS4NClRoZSBzYW1lIGZvciBwY2lfYXNzaWduX3VuYXNzaWduZWRfYnVzX3Jlc291cmNlcygpIGlu
DQphbWRncHVfZGV2aWNlX3JlbWFwX21taW8oKTogdGhpcyBjYWxsYmFjayBpcyBpbnZva2VkIGZy
b20NCnBjaV9yZXNjYW5fYnVzKCkgYWZ0ZXIgcGNpX2Fzc2lnbl91bmFzc2lnbmVkX3Jvb3RfYnVz
X3Jlc291cmNlcygpLg0KDQo+IFdoZW4gdGVzdGluZyB3aXRoIDIgZ3JhcGhpYyBjYXJkcyBhbmQg
dHJpZ2dlcmluZyByZXNjYW4sIGhhcmQgaGFuZyBvZg0KPiB0aGUgc3lzdGVtIGhhcHBlbnMgZHVy
aW5nIHJlc2Nhbl9wcmVwYXJlIG9mIHRoZSBzZWNvbmQgY2FyZCAgd2hlbiANCj4gc3RvcHBpbmcg
dGhlIEhXIChzZWUgbG9nMi5sb2cpIC0gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGlzIHdvdWxk
IA0KPiBoYXBwZW4gYXMgZWFjaCBvZiB0aGVtIHBhc3NlcyBmaW5lIHdoZW4gdGhleSBhcmUgc3Rh
bmRhbG9uZSB0ZXN0ZWQNCj4gYW5kIA0KPiB0aGVyZSBzaG91bGQgYmUgbm8gaW50ZXJkZXBlbmRl
bmNlIGJldHdlZW4gdGhlbSBhcyBmYXIgYXMgaSBrbm93Lg0KPiBEbyB5b3UgaGF2ZSBhbnkgaWRl
YSA/DQoNCldoYXQgaGFwcGVucyB3aXRoIHR3byBHUFVzIGlzIHVuY2xlYXIgZm9yIG1lIGFzIHdl
bGwsIG5vdGhpbmcgbG9va3MNCnN1c3BpY2lvdXMuDQoNClNlcmdlDQo=
