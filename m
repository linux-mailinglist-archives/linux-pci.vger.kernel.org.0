Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA87F17CDB5
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 11:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCGK6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 05:58:36 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:34560 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgCGK6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2020 05:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1583578714; x=1615114714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=HE+L5+d0MRh91wk/A8LGVxzEsAhd6dVWq6NIdabQ6bg=;
  b=R0JUuWcOkjo10bElMaiLM5Deh7kxMV6u2HCONBuYjWpf0rAqPa9Lvrmf
   naNIZKXFEk70VyAUgQd0Jznu/PkkY6qNWFOJtVArJc6Lq0tsoztkN6yQ2
   EHuzY8ywwHVANFyHCcS7sLNyALcc4I5cugQColJzDFbDr9v9t4tg3cvw9
   s=;
IronPort-SDR: 5yrTaXXAkHr+8gRNP5bmowFzM6UWr20Oz0xzw/ToRxth6PBi+iSoDRgE/p2NqH1erXegU6qdx+
 jNQ7ta9M3BGg==
X-IronPort-AV: E=Sophos;i="5.70,525,1574121600"; 
   d="scan'208";a="20213594"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Mar 2020 10:58:21 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id C01E7A2A47;
        Sat,  7 Mar 2020 10:58:17 +0000 (UTC)
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sat, 7 Mar 2020 10:58:17 +0000
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D04EUB003.ant.amazon.com (10.43.166.235) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 7 Mar 2020 10:58:16 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.006;
 Sat, 7 Mar 2020 10:58:16 +0000
From:   "Spassov, Stanislav" <stanspas@amazon.de>
To:     "Spassov, Stanislav" <stanspas@amazon.de>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lkp@intel.com" <lkp@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 04/17] PCI: Do not override delay for D0->D3hot
 transition
Thread-Topic: [PATCH v3 04/17] PCI: Do not override delay for D0->D3hot
 transition
Thread-Index: AQHV9G9NgVU7SP3RrUKHvPMb4vrnaw==
Date:   Sat, 7 Mar 2020 10:58:15 +0000
Message-ID: <5556ec9ccb09796b8555db51a0079dcbd7a49a9e.camel@amazon.de>
References: <20200303132852.13184-1-stanspas@amazon.com>
         <20200303132852.13184-5-stanspas@amazon.com>
         <CAJZ5v0hVFGqWsZbHwYu2uJrdwzVp1m-HDaTCS+A-+qpw5FwuQQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hVFGqWsZbHwYu2uJrdwzVp1m-HDaTCS+A-+qpw5FwuQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.196]
Content-Type: text/plain; charset="utf-8"
Content-ID: <744F4DFEB6896341A7CD43D202656105@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDE5OjU3ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gPiBCb3RoIHNwZWNpZmljYXRpb25zIHRoYXQgZG9jdW1lbnQgbWVjaGFuaXNtcyBmb3Ig
b3ZlcnJpZGluZyB0aGUNCj4gPiBEM2hvdC0+RDAgd2FpdGluZyB0aW1lIG9ubHkgc3BlYWsgb2Yg
dGhpcyBzcGVjaWZpYyBkaXJlY3Rpb24uDQo+ID4gTm90aGluZyBpcyBtZW50aW9uZWQgYWJvdXQg
dGhlIG9wcG9zaXRlIChEKi0+RDNob3QpIGV4Y2VwdCBmb3INCj4gPiB0aGUgZGVmYXVsdCB2YWx1
ZSBvZiAxMG1zIGluIFBDSSBFeHByZXNzIEJhc2UgU3BlY2lmaWNhdGlvbg0KPiA+IHI1LjAgKE1h
eSAyMiwgMjAxOSksIFNlY3Rpb24gNS45ICJTdGF0ZSBUcmFuc2l0aW9uIFJlY292ZXJ5IFRpbWUN
Cj4gPiBSZXF1aXJlbWVudHMiLg0KPiANCj4gVW5sZXNzIHlvdSBoYXZlIGEgc3BlY2lmaWMgZXhh
bXBsZSBvZiBhIHN5c3RlbSBvbiB3aGljaCB0aGUgY3VycmVudA0KPiBjb2RlIGRvZXNuJ3Qgd29y
ayAoYW5kIHdoaWNoIHNob3VsZCBiZSBtZW50aW9uZWQgaGVyZSksIEkgZG9uJ3QgdGhpbmsNCj4g
dGhhdCBpdCBpcyBhIGdvb2QgaWRlYSB0byBtYWtlIHRoaXMgY2hhbmdlLg0KPiANCg0KSSBkbyBu
b3QgaGF2ZSBhIHNwZWNpZmljIGV4YW1wbGUgZm9yIGEgZmFpbGluZyBzeXN0ZW0gaGVyZS4gVGhl
IGludGVudGlvbg0KaXMgcHVyZWx5IHRvIGJyaW5nIHRoZSBjb2RlIGluIGxpbmUgd2l0aCB3aGF0
DQp0aGUgc3BlYyBzYXlzIChvciBpbiB0aGlzIGNhc2U6DQp3aGF0IHRoZSBzcGVjIGRvZXMgbm90
IHNheSkuDQoNCj4gVGhlcmUgYXJlIHN5c3RlbXMgaW4gd2hpY2ggaXQgd291bGQgbWFrZSBhIG1l
YXN1cmFibGUgZGlmZmVyZW5jZSBpbg0KPiB0aGluZ3MgbGlrZSB0aGUgdGltZSBpdCB0YWtlcyB0
byBzdXNwZW5kIHRoZSBzeXN0ZW0uDQoNClRoaXMgcGF0Y2ggb25seSBhZmZlY3RzIHRoZSBEMC0+
RDNob3QgZGVsYXkgd2l0aGluIHBjaV9wbV9yZXNldCgpLg0KKEkgd2lsbCBtYWtlIHRoaXMgbW9y
ZSBleHBsaWNpdCBpbiB0aGUgY29tbWl0IHRpdGxlL21lc3NhZ2UuKQ0KVGhlIFBNIHJlc2V0IGlz
IG9ubHkgZXZlciBpbnZva2VkIGZyb20gX19wY2lfcmVzZXRfZnVuY3Rpb25fbG9ja2VkKCkNCmFu
ZCBwY2lfcHJvYmVfcmVzZXRfZnVuY3Rpb24oKS4gU3BlY2lmaWNhbGx5LCBwY2lfc2V0X3Bvd2Vy
X3N0YXRlKCkgaXMgdW50b3VjaGVkLg0KSSBhbSBub3Qgd2VsbCB2ZXJzZWQgaW50byB0aGUgc3lz
dGVtIHN1c3BlbmQgY29kZSwgYnV0IHVubGVzcyB3ZSBhcmUgcmVzZXR0aW5nIHRoZQ0KZGV2aWNl
cyB0aGVyZSwgdGhpcyBwYXRjaCBzaG91bGQgbm90IGFmZmVjdCBzeXN0ZW0gc3VzcGVuZCB0aW1l
IGF0IGFsbC4NCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVz
ZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hs
YWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0
ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3
IDg3OQoKCg==

