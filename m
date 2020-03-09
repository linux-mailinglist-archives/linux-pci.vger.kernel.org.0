Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC20717E4E2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCIQi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 12:38:56 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:22575 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgCIQi4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 12:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1583771935; x=1615307935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=fpoW68wxBMpZKdnqed69yzX+rg/38cvWi03cuqZ5yQE=;
  b=UKlrOLX75iSzdtiV755n9somg0IGuCIQPk7gUaSBozM3ymsrdW73OFyr
   mZ46DIlDB49bvfy/9AyxKGhnNnDSHdYM1Oon0EuN+NvtEbwh1N3o4bHJK
   aPiyZwVbYZUKqQjlVVCM0SRiP9gWfAbu+Bq/uNaXmUATPzpPFR9temBC5
   E=;
IronPort-SDR: j10kfBRt+93cLpImd7A0Y7a3Jm3E8Zc9U82Yd2zWCU8BVEEk/uHMqoGMHtKQ3SxOzbHFMrywn8
 dxqLkd1np6fw==
X-IronPort-AV: E=Sophos;i="5.70,533,1574121600"; 
   d="scan'208";a="21769281"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Mar 2020 16:38:52 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 0B305A2293;
        Mon,  9 Mar 2020 16:38:48 +0000 (UTC)
Received: from EX13D12EUC002.ant.amazon.com (10.43.164.134) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 9 Mar 2020 16:38:48 +0000
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D12EUC002.ant.amazon.com (10.43.164.134) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 9 Mar 2020 16:38:47 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.006;
 Mon, 9 Mar 2020 16:38:47 +0000
From:   "Spassov, Stanislav" <stanspas@amazon.de>
To:     "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Thread-Topic: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Thread-Index: AQHV9jE0lLkuEXEtFEa8Lozwqc8iAw==
Date:   Mon, 9 Mar 2020 16:38:46 +0000
Message-ID: <af2ba4c11c28848dc7d1827c23e6b038cc051eed.camel@amazon.de>
References: <20200307172044.29645-1-stanspas@amazon.com>
         <20200307172044.29645-4-stanspas@amazon.com>
         <0461c706-579b-8c03-cf33-66e79890af92@kernel.org>
         <20200309161951.GA25817@otc-nc-03>
In-Reply-To: <20200309161951.GA25817@otc-nc-03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFFA8CDC99AFDF458DD85728C76C14C7@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTA5IGF0IDA5OjE5IC0wNzAwLCBSYWosIEFzaG9rIHdyb3RlOg0KPiBP
biBNb24sIE1hciAwOSwgMjAyMCBhdCAxMTo1NToxMUFNIC0wNDAwLCBTaW5hbiBLYXlhIHdyb3Rl
Og0KPiA+IE9uIDMvNy8yMDIwIDEyOjIwIFBNLCBTdGFuaXNsYXYgU3Bhc3NvdiB3cm90ZToNCj4g
PiA+ICsgICAgICAgICAgIHJjID0gcGNpX2Rldl9wb2xsX3VudGlsX25vdF9lcXVhbChkZXYsIFBD
SV9WRU5ET1JfSUQsIDB4ZmZmZiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAweDAwMDEsIHJlc2V0X3R5cGUsIHRpbWVvdXQsDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJndhaXRlZCwgJmlkKTsN
Cj4gPiA+ICsgICAgICAgICAgIGlmIChyYykNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgcmV0
dXJuIHJjOw0KPiA+ID4gKw0KPiA+IA0KPiA+IElmIEkgcmVtZW1iZXIgcmlnaHQsIHRoaXMgZG9l
c24ndCB3b3JrIGZvciBWRiBzZW5kaW5nIENSUyBiZWNhdXNlIFZGDQo+ID4gYWx3YXlzIHJldHVy
bnMgMHhmZmZmIGZvciBWRU5ET1JfSUQgcmVnaXN0ZXIuDQo+IA0KPiBJcyB0aGlzIHJlcXVpcmVk
IGJ5IHRoZSBQQ0llIHNwZWM/IGkgdGhpbmsgdGhlIG9ubHkgcmVxdWlyZW1lbnQgaXMNCj4gdGhl
IDFzIHdhaXQgYWZ0ZXIgUEYgaGFzIGRvbmUgdGhlIFZGIGVuYWJsZS4gU2VlIEltcGxlbWVudGF0
aW9uIE5vdGUNCj4gcmlnaHQgYWJvdmUgc2VjdGlvbiAyLjMuMS4xIGluIHRoZSBCYXNlIHNwZWMg
NS4wLg0KPiANCj4gSWYgdGhpcyBiZWhhdmlvciBpcyBkaWZmZXJlbnQgZm9yIG1heWJlIGEgc3Bl
Y2lmaWMgU1JJT1YgZGV2aWNlIHdlIHNob3VsZA0KPiBwcm9iYWJseSBxdWlyayB0aGUgc3RhbmRh
cmQgYmVoYXZpb3I/DQo+IA0KPiBUaGUgcnVsZXMgYXJlIG1lbnRpb25lZCBpbiBzbyBtYW55IHBs
YWNlcywgYnV0IGxvb2tpbmcgdGhyb3VnaCB0aGUNCj4gU1JJT1Ygc2VjdGlvbidzIGRvZXNuJ3Qg
c2VlbSB0byBzcGVjaWZ5IHNwZWNpYWwgcnVsZXMgZm9yIFZGJ3Mgb3RoZXIgdGhhbg0KPiB0aGUg
d2FpdCB0aW1lIGFmdGVyIFZGIGVuYWJsZS4NCg0KUENJIEV4cHJlc3MgQmFzZSBTcGVjaWZpY2F0
aW9uIFJldmlzaW9uIDUuMCBWZXJzaW9uIDEuMCAoTWF5IDIyLCAyMDE5KQ0Kb24gcGFnZXMgMTEz
OSBhbmQgMTE0MCB3aXRoaW4gc2VjdGlvbiA5LjMuNCBQRi9WRiBDb25maWd1cmF0aW9uIFNwYWNl
IEhlYWRlcg0KZGVzY3JpYmVzOg0KDQoiOS4zLjQuMS4xIFZlbmRvciBJRCBSZWdpc3RlciBDaGFu
Z2VzIChPZmZzZXQgMDBoKQ0KLi4uDQpUaGlzIGZpZWxkIGluIGFsbCBWRnMgcmV0dXJucyBGRkZG
aCB3aGVuIHJlYWQuIFZJIHNvZnR3YXJlIHNob3VsZCByZXR1cm4gdGhlIFZlbmRvciBJRCB2YWx1
ZSBmcm9tIHRoZSBhc3NvY2lhdGVkIFBGIGFzIHRoZQ0KVmVuZG9yIElEIHZhbHVlIGZvciB0aGUg
VkYuIg0KDQooYW5kIHNpbWlsYXIgZm9yIHRoZSBEZXZpY2UgSUQpDQoNClJpZ2h0IGFmdGVyIHRo
YXQgaXMgYW4gSW1wbGVtZW50aW9uIE5vdGUgIkxlZ2FjeSBQQ0kgUHJvYmluZyBTb2Z0d2FyZSIg
dGhhdCBleHBsYWluczoNCg0KIlJldHVybmluZyBGRkZGaCBmb3IgRGV2aWNlIElEIGFuZCBWZW5k
b3IgSUQgdmFsdWVzIGFsbG93cyBzb21lIGxlZ2FjeSBzb2Z0d2FyZSB0byBpZ25vcmUgVkZzLiIN
Cg0KU28sIHdoZW5ldmVyIGEgVkYgaXMgcHJvdmlkaW5nIGFuIGFjdHVhbCByZXNwb25zZSB0byBh
IHZpZC9kaWQgcmVhZCwgaXQgd2lsbCByZXNwb25kIHdpdGggYSBTdWNjZXNzZnVsIENvbXBsZXRp
b24gYW5kIHRoZSBkYXRhDQp3aWxsIGJlIDB4RkZGRi4gSG93ZXZlciwgd2hlbiB0aGUgVkYgaXMg
bm90IHJlYWR5IHlldCBhZnRlciBhIHJlc2V0LCBJIHdvdWxkIGV4cGVjdCBpdCB0byBiZSByZXR1
cm5pbmcgQ1JTIGNvbXBsZXRpb25zIGp1c3QgbGlrZQ0KYW55IG90aGVyIGRldmljZSAobm90aGlu
ZyBpbiB0aGUgc3BlYyBleHBsaWNpdGx5IGNvbmZpcm1zIG9yIGRlbmllcyB0aGlzLCBhcyBmYXIg
YXMgSSBjYW4gdGVsbCkuIFRoZW4sIHRoZSByb290IHBvcnQgaGFzIG5vIGlkZWENCmlmIGEgZGV2
aWNlIHRoYXQgaXQgcmVjZWl2ZWQgYSBDUlMgY29tcGxldGlvbiBmcm9tIGlzIGEgUEYgb3IgVkYs
IHNvIGl0IGhhcyB0byB0cmVhdCB0aGVtIGVxdWl2YWxlbnRseSwgYW5kIHRoZXJlZm9yZSAoZm9y
IENSUyBTViBlbmFibGVkKQ0Kc3ludGhlc2l6ZSAweDAwMDEgZm9yIHRoZSBWSUQuDQoKCgpBbWF6
b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBC
ZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBX
ZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIg
MTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

