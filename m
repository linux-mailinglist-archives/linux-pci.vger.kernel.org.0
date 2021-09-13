Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB26840985C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbhIMQHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 12:07:41 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:25483 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbhIMQHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 12:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1631549184; x=1663085184;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=EVEqB68PoHNVDvJkveijv3LDziVsbwlkEeXfV6RUyK8=;
  b=k7UbxDjY3BhNaAEERMbuVaXLHV7UHo5yQaV6BPE9NCKrUUElc0ZA0b1T
   rf1+j7ZzwT14u7IZCRu5CPgZ8nfzHDTEvKR3J/gCEjD354WE7iqmx1dJE
   JaiiyLlVq8v+4QjB/WL1j6AoCYVbzaF6rTJJBqPjfIxiIIJP68DG+leav
   Y=;
X-IronPort-AV: E=Sophos;i="5.85,290,1624320000"; 
   d="scan'208";a="159519690"
Subject: Re: [PATCH v4 2/3] PCI: Cache CRS Software Visibiliy in struct pci_dev
Thread-Topic: [PATCH v4 2/3] PCI: Cache CRS Software Visibiliy in struct pci_dev
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 13 Sep 2021 16:06:16 +0000
Received: from EX13D12EUC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id CD831A2C40;
        Mon, 13 Sep 2021 16:06:12 +0000 (UTC)
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D12EUC001.ant.amazon.com (10.43.164.45) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 13 Sep 2021 16:06:12 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.023;
 Mon, 13 Sep 2021 16:06:12 +0000
From:   "Spassov, Stanislav" <stanspas@amazon.de>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        =?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Thread-Index: AQHV9KTNPzRIK6Q+/0Cb9RCo18YlmqujzA4AgAG9MoA=
Date:   Mon, 13 Sep 2021 16:06:12 +0000
Message-ID: <e0bc9f1409470a1e7c30fc92cd6938ebae1ac31a.camel@amazon.de>
References: <20210912133246.GA1279483@bjorn-Precision-5520>
In-Reply-To: <20210912133246.GA1279483@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <448BA2ED6AA89B44AE13048EAD36F01B@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU3VuLCAyMDIxLTA5LTEyIGF0IDA4OjMyIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBTYXQsIE1hciAwNywgMjAyMCBhdCAwNjoyMDo0M1BNICswMTAwLCBTdGFuaXNsYXYgU3Bh
c3NvdiB3cm90ZToNCj4gPiBIb3dldmVyLCBzdG9yaW5nIHRoZSBmbGFnIGluIHN0cnVjdCBwY2lf
ZGV2IGFsbG93cyBpbmRpdmlkdWFsIGRldmljZXMNCj4gPiB0byBiZSBtYXJrZWQgYXMgbm90IHN1
cHBvcnRpbmcgQ1JTIHByb3Blcmx5IGV2ZW4gd2hlbiBDUlMgU1YgaXMgZW5hYmxlZA0KPiA+IG9u
IHRoZWlyIHBhcmVudCBSb290IFBvcnQuIFRoaXMgd2F5LCBmdXR1cmUgY29kZSB0aGF0IHJlbGll
cyBvbiB0aGUgbmV3DQo+ID4gZmxhZyB3aWxsIG5vdCBiZSBtaXNsZWQgdGhhdCBpdCBpcyBzYWZl
IHRvIHByb2JlIGEgZGV2aWNlIGJ5IHJlbHlpbmcgb24NCj4gPiBDUlMgU1YgdG8gbm90IGNhdXNl
IHBsYXRmb3JtIHRpbWVvdXRzIChTZWUgdGhlIG5vdGUgb24gQ1JTIFNWIG9uIHAuIDU1Mw0KPiA+
IG9mIFBDSSBFeHByZXNzIEJhc2UgU3BlY2lmaWNhdGlvbiByNS4wIGZyb20gTWF5IDIyLCAyMDE5
KS4NCj4gDQo+IElmIHdlIGZpbmQgZGV2aWNlcyB0aGF0IGRvbid0IHN1cHBvcnQgQ1JTIHByb3Bl
cmx5LCBJIHRoaW5rIHdlIHNob3VsZA0KPiBxdWlyayB0aGVtIGRpcmVjdGx5IHdpdGggc29tZXRo
aW5nIG90aGVyIHRoYW4gImNyc3N2X2VuYWJsZWQiLg0KDQpJIGFtIGRlZmluaXRlbHkgb3BlbiB0
byBzdWdnZXN0aW9ucyBoZXJlLiBCYXNlZCBvbiBwcmVjZWRlbnQgc3VjaCBhcyB0aGUNCmJyb2tl
bl9pbnR4X21hc2tpbmcgZmllbGQgaW4gc3RydWN0IHBjaV9kZXYgYW5kIGhvdyBpdCBpcyBzZXQg
ZnJvbQ0KcGNpL3F1aXJrcy5jLCB3ZSBjb3VsZCBoYXZlIGEgbmV3IGZpZWxkICJicm9rZW5fY3Jz
Ii4NCg0KSW4gaGluZHNpZ2h0LCB0aGUgY29kZSBmcm9tIFBBVENIIDMvMyB3aGljaCBpcyBjb25k
aXRpb25hbGx5IGV4ZWN1dGVkIGJhc2VkDQpvbiB0aGlzIGZsYWcsIHNob3VsZCBiZSBva2F5IHRv
IGV4ZWN1dGUgdW5jb25kaXRpb25hbGx5OiBwb2xsaW5nIHRoZSBWZW5kb3INCklEIGlzIHNhZmVy
IHRoYW4gcG9sbGluZyBDb21tYW5kIHdoZW4gQ1JTIFNWIGlzIGVuYWJsZWQgYnV0IGl0IGlzIHN0
aWxsIG5vdA0KYW55IG1vcmUgZGFuZ2Vyb3VzIHdoZW4gQ1JTIFNWIGlzIGRpc2FibGVkLiBUaGlz
IGNvbnNpZGVyYXRpb24gYWxsb3dzIHVzDQp0byBkcm9wIHRoZSBjdXJyZW50IFBBVENIIDIvMyBh
bHRvZ2V0aGVyLiBJIHdpbGwgaW1wbGVtZW50IHRoaXMgYXBwcm9hY2ggaW4NCnRoZSBuZXh0IHJl
dmVyc2lvbiBvZiB0aGUgc2VyaWVzIChpdCBpcyBvbGQgYW5kIG5lZWRzIHJlYmFzaW5nIGFueXdh
eSkuDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3Ry
LiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2Vy
LCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkK
Cgo=

