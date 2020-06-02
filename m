Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1326F1EB6AE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgFBHoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 03:44:24 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:50838 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBHoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 03:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591083863; x=1622619863;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=queorqomKSP9LekWnpkGGKIrzqw9PFAECPBLzFJM84U=;
  b=Lf1QciFeG42tnGPqVnAHDlqAwEyQQ4589PbhD+HX/mi7F/qCoevPftRG
   hdq8sQOlBvh17s7df+1d91g1RvWOWm5iczbgNqULLt+KwIZEpQSCedhN9
   a8xZvSJXDYHAv8GHXV2vdAGTf02XzN4bdIPAM9/rlAwQRF0V4557iKGS3
   E=;
IronPort-SDR: 53ixTy8+W3rMwU5SnSkgQ52kEc6BPqVsG7+PdqTi8+Ck1Q1s8i715Qh6tnsQglPVWZPThLN3L3
 2HVMznPqVslg==
X-IronPort-AV: E=Sophos;i="5.73,463,1583193600"; 
   d="scan'208";a="49098053"
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
Thread-Topic: [PATCH v1] PCI: controller: Remove duplicate error message
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 02 Jun 2020 07:44:21 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id B2237A176B;
        Tue,  2 Jun 2020 07:44:19 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 07:44:19 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 07:44:18 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1497.006;
 Tue, 2 Jun 2020 07:44:18 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "zhengdejin5@gmail.com" <zhengdejin5@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        "Chocron, Jonathan" <jonnyc@amazon.com>
Thread-Index: AQHWM3A7ZXCRFcozsESZq5tPMlXzIai6rncAgAE9uoCACRAogA==
Date:   Tue, 2 Jun 2020 07:44:18 +0000
Message-ID: <1b54c08f759c101a8db162f4f62c6b6a8a455d3f.camel@amazon.com>
References: <20200526150954.4729-1-zhengdejin5@gmail.com>
         <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
         <20200527132005.GA7143@nuc8i5>
In-Reply-To: <20200527132005.GA7143@nuc8i5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.53]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C6E3733F2D2BE428C02143171B2B362@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTI3IGF0IDIxOjIwICswODAwLCBEZWppbiBaaGVuZyB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbw0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXINCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4gDQo+IA0KPiANCj4gT24gVHVlLCBNYXkgMjYsIDIwMjAgYXQgMDY6MjI6NTZQTSArMDAw
MCwgQ2hvY3JvbiwgSm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTA1LTI2IGF0IDIz
OjA5ICswODAwLCBEZWppbiBaaGVuZyB3cm90ZToNCj4gPiA+IENBVVRJT046IFRoaXMgZW1haWwg
b3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4NCj4gPiA+IERvDQo+
ID4gPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBj
b25maXJtIHRoZQ0KPiA+ID4gc2VuZGVyDQo+ID4gPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSXQgd2lsbCBwcmludCBhbiBlcnJv
ciBtZXNzYWdlIGJ5IGl0c2VsZiB3aGVuDQo+ID4gPiBkZXZtX3BjaV9yZW1hcF9jZmdfcmVzb3Vy
Y2UoKSBnb2VzIHdyb25nLiBzbyByZW1vdmUgdGhlIGR1cGxpY2F0ZQ0KPiA+ID4gZXJyb3IgbWVz
c2FnZS4NCj4gPiA+IA0KPiA+IA0KPiA+IEl0IHNlZW1zIGxpa2UgdGhhdCBpbiB0aGUgZmlyc3Qg
ZXJyb3IgY2FzZSBpbg0KPiA+IGRldm1fcGNpX3JlbWFwX2NmZ19yZXNvdXJjZSgpLCB0aGUgcHJp
bnQgd2lsbCBiZSBsZXNzIGluZGljYXRpdmUuDQo+ID4gQ291bGQNCj4gPiB5b3UgcGxlYXNlIHNo
YXJlIGFuIGV4YW1wbGUgcHJpbnQgbG9nIHdpdGggdGhlIGR1cGxpY2F0ZSBwcmludD8NCj4gPiAN
Cj4gDQo+IEhpIEpvbmF0aGFuOg0KPiANCj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdXNpbmcg
eW91ciBwcmVjaW91cyB0aW1lIHRvIHJldmlldyBteSBwYXRjaC4NCj4gDQpTdXJlLCBubyBwcm9i
bGVtLg0KDQo+IEkgZGlkIG5vdCBoYXZlIHRoaXMgbG9nIGFuZCBqdXN0IGZvdW5kIGl0IGJ5IHJl
dmlldyBjb2Rlcy4gdGhlDQo+IGZ1bmN0aW9uDQo+IG9mIGRldm1fcGNpX3JlbWFwX2NmZ19yZXNv
dXJjZSgpIGlzIGRlc2lnbmVkIHRvIGhhbmRsZSBlcnJvciBtZXNzYWdlcw0KPiBieQ0KPiBpdHNl
bGYuIGFuZCBJdHMgcmVjb21tZW5kZWQgdXNhZ2UgaXMgYXMgZm9sbG93cyBpbiB0aGUgZnVuY3Rp
b24NCj4gZGVzY3JpcHRpb24NCj4gDQo+ICAgICAgICAgYmFzZSA9IGRldm1fcGNpX3JlbWFwX2Nm
Z19yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0KPiAgICAgICAgIGlmIChJU19FUlIoYmFzZSkp
DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihiYXNlKTsNCj4gDQpJIGFzc3VtZSB0
aGF0IHRoZSByZWNvbW1lbmRlZCB1c2FnZSdzIG1haW4gaW50ZW50IHdhcyB0byBwb2ludCBvdXQg
dGhhdA0KSVNfRVJSKCkgc2hvdWxkIGJlIHVzZWQsIGJ1dCB0aGlzIGlzIG1haW5seSBzcGVjdWxh
dGlvbi4NCg0KPiBJbiBmYWN0LCBJIHRoaW5rIGl0cyBlcnJvciBoYW5kbGluZyBpcyBjbGVhciBl
bm91Z2gsIEl0IGp1c3QgZ29lcw0KPiB3cm9uZw0KPiBpbiB0aHJlZSBwbGFjZXMsIGFzIGZvbGxv
d3M6DQo+IA0KPiB2b2lkIF9faW9tZW0gKmRldm1fcGNpX3JlbWFwX2NmZ19yZXNvdXJjZShzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0KPiB7DQo+ICAgICAgICAgcmVzb3VyY2Vfc2l6ZV90
IHNpemU7DQo+ICAgICAgICAgY29uc3QgY2hhciAqbmFtZTsNCj4gICAgICAgICB2b2lkIF9faW9t
ZW0gKmRlc3RfcHRyOw0KPiANCj4gICAgICAgICBCVUdfT04oIWRldik7DQo+IA0KPiAgICAgICAg
IGlmICghcmVzIHx8IHJlc291cmNlX3R5cGUocmVzKSAhPSBJT1JFU09VUkNFX01FTSkgew0KPiAg
ICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJpbnZhbGlkIHJlc291cmNlXG4iKTsNCj4gICAg
ICAgICAgICAgICAgIHJldHVybiBJT01FTV9FUlJfUFRSKC1FSU5WQUwpOw0KPiAgICAgICAgIH0N
Cj4gDQpJbiB0aGUgYWJvdmUgZXJyb3IgY2FzZSB0aGVyZSBpcyBubyBpbmRpY2F0aW9uIG9mIHdo
aWNoIHJlc291cmNlIGZhaWxlZA0KKG1haW5seSByZWxldmFudCBpZiB0aGUgcmVzb3VyY2UgbmFt
ZSBpcyBtaXNzaW5nIGluIHRoZSBkZXZpY2V0cmVlLA0Kc2luY2UgaW4gdGhlIGRyaXZlcnMgeW91
IGFyZSBjaGFuZ2luZyBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKCkgaXMNCm1vc3RseSB1
c2VkKS4gSW4gdGhlIGV4aXN0aW5nIGRyaXZlcnMnIGNvZGUsIG9uIHJldHVybiBmcm9tIHRoaXMN
CmZ1bmN0aW9uIGluIHRoaXMgY2FzZSwgdGhlIG5hbWUgd291bGQgYmUgcHJpbnRlZCBieSB0aGUg
Y2FsbGVyLg0KDQo+ICAgICAgICAgc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKTsNCj4gICAgICAg
ICBuYW1lID0gcmVzLT5uYW1lID86IGRldl9uYW1lKGRldik7DQo+IA0KPiAgICAgICAgIGlmICgh
ZGV2bV9yZXF1ZXN0X21lbV9yZWdpb24oZGV2LCByZXMtPnN0YXJ0LCBzaXplLCBuYW1lKSkgew0K
PiAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJjYW4ndCByZXF1ZXN0IHJlZ2lvbiBmb3Ig
cmVzb3VyY2UNCj4gJXBSXG4iLCByZXMpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIElPTUVN
X0VSUl9QVFIoLUVCVVNZKTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGRlc3RfcHRyID0g
ZGV2bV9wY2lfcmVtYXBfY2Znc3BhY2UoZGV2LCByZXMtPnN0YXJ0LCBzaXplKTsNCj4gICAgICAg
ICBpZiAoIWRlc3RfcHRyKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImlvcmVt
YXAgZmFpbGVkIGZvciByZXNvdXJjZSAlcFJcbiIsDQo+IHJlcyk7DQo+ICAgICAgICAgICAgICAg
ICBkZXZtX3JlbGVhc2VfbWVtX3JlZ2lvbihkZXYsIHJlcy0+c3RhcnQsIHNpemUpOw0KPiAgICAg
ICAgICAgICAgICAgZGVzdF9wdHIgPSBJT01FTV9FUlJfUFRSKC1FTk9NRU0pOw0KPiAgICAgICAg
IH0NCj4gDQpUaGUgb3RoZXIgMiBlcnJvciBjYXNlcyBhcyB3ZWxsIGRvbid0IHByaW50IHRoZSBy
ZXNvdXJjZSBuYW1lIGFzIGZhciBhcw0KSSByZWNhbGwgKHRoZXkgd2lsbCBhdCBsZWFzdCBwcmlu
dCB0aGUgcmVzb3VyY2Ugc3RhcnQvZW5kKS4NCg0KPiAgICAgICAgIHJldHVybiBkZXN0X3B0cjsN
Cj4gfQ0KPiANCj4gQlIsDQo+IERlamluDQo+IA0KPiA+IFRoYW5rcywNCj4gPiAgICBKb25hdGhh
bg0K
