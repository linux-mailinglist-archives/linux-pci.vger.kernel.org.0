Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E26A16AE06
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBXRwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 12:52:20 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:27175 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXRwS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 12:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1582566739; x=1614102739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=0EUqHRglcA/NGux2MT4MfH4tFPygRIXiyd07iGX9q6w=;
  b=T1dBBPjqwpmvOQPcANVCP95lMSPBGL/Ja0N+CnJFQXF5is9Ha3KFTyGQ
   DudTTcplAsOmVppNawP5xkaHAcxodaGpcH3zlxiDX+ox5pOAfv6GYO/vo
   EXu/otXBZfBQBQbUWEKGCDkO/NaIrY7ZMXk36tPL/iQh5OgBDA+3yjAoi
   o=;
IronPort-SDR: /znGeJc7Msus4UaRmrR6W6635aAfMiSlCf91ECR/C4yuE6339xrf3pU5myDVsZo0hpMiPdy2ew
 2Igt47q+mwuA==
X-IronPort-AV: E=Sophos;i="5.70,480,1574121600"; 
   d="scan'208";a="18785513"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 24 Feb 2020 17:52:17 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 0D376A2342;
        Mon, 24 Feb 2020 17:52:15 +0000 (UTC)
Received: from EX13D09EUA002.ant.amazon.com (10.43.165.251) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 24 Feb 2020 17:52:15 +0000
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D09EUA002.ant.amazon.com (10.43.165.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 24 Feb 2020 17:52:14 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.000;
 Mon, 24 Feb 2020 17:52:14 +0000
From:   "Spassov, Stanislav" <stanspas@amazon.de>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wang, Wei" <wawei@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: Make PCIE_RESET_READY_POLL_MS configurable
Thread-Topic: [PATCH 1/3] PCI: Make PCIE_RESET_READY_POLL_MS configurable
Thread-Index: AQHV6kPUZq8jyZIzgU2XP5BjGFqpZqgqZU6AgAA8dQA=
Date:   Mon, 24 Feb 2020 17:52:14 +0000
Message-ID: <21926ab1c8216382801dca9130343f954247b408.camel@amazon.de>
References: <20200224141551.GA217704@google.com>
In-Reply-To: <20200224141551.GA217704@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.246]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E75232C9375D314E8C8E80D27A1E8F49@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTI0IGF0IDA4OjE1IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBbK2NjIEFzaG9rLCBBbGV4LCBTaW5hbiwgUmFqYXRdDQo+IA0KPiBPbiBTdW4sIEZlYiAyMywg
MjAyMCBhdCAwMToyMDo1NVBNICswMTAwLCBTdGFuaXNsYXYgU3Bhc3NvdiB3cm90ZToNCj4gPiBG
cm9tOiBXZWkgV2FuZyA8d2F3ZWlAYW1hem9uLmRlPg0KPiA+IA0KPiA+IFRoZSByZXNvbmFibGUg
dmFsdWUgZm9yIHRoZSBtYXhpbXVtIHRpbWUgdG8gd2FpdCBmb3IgYSBQQ0kgZGV2aWNlIHRvIGJl
DQo+ID4gcmVhZHkgYWZ0ZXIgcmVzZXQgdmFyaWVzIGRlcGVuZGluZyBvbiB0aGUgcGxhdGZvcm0g
YW5kIHRoZSByZWxpYWJpbGl0eQ0KPiA+IG9mIGl0cyBzZXQgb2YgZGV2aWNlcy4NCj4gDQo+IFRo
ZXJlIGFyZSBzZXZlcmFsIG1lY2hhbmlzbXMgaW4gdGhlIHNwZWMgZm9yIHJlZHVjaW5nIHRoZXNl
IHRpbWVzLA0KPiBlLmcuLCBSZWFkaW5lc3MgTm90aWZpY2F0aW9ucyAoUENJZSByNS4wLCBzZWMg
Ni4yMyksIHRoZSBSZWFkaW5lc3MNCj4gVGltZSBSZXBvcnRpbmcgY2FwYWJpbGl0eSAoc2VjIDcu
OS4xNyksIGFuZCBBQ1BJIF9EU00gbWV0aG9kcyAoUENJDQo+IEZpcm13YXJlIFNwZWMgcjMuMiwg
c2VjIDQuNi44LCA0LjYuOSkuDQo+IA0KPiBJIHdvdWxkIG11Y2ggcmF0aGVyIHVzZSBzdGFuZGFy
ZCBtZWNoYW5pc21zIGxpa2UgdGhvc2UgaW5zdGVhZCBvZg0KPiBhZGRpbmcga2VybmVsIHBhcmFt
ZXRlcnMuICBBIHVzZXIgd291bGQgaGF2ZSB0byB1c2UgdHJpYWwgYW5kIGVycm9yDQo+IHRvIGZp
Z3VyZSBvdXQgdGhlIHZhbHVlIHRvIHVzZSB3aXRoIGEgcGFyYW1ldGVyIGxpa2UgdGhpcywgYW5k
IHRoYXQNCj4gZG9lc24ndCBmZWVsIGxpa2UgYSByb2J1c3QgYXBwcm9hY2guDQo+IA0KDQpJIGFn
cmVlIHRoYXQgc3VwcG9ydGluZyB0aGUgc3RhbmRhcmQgbWVjaGFuaXNtcyBpcyBoaWdobHkgZGVz
aXJhYmxlLA0KYnV0IHNvbWUgc29ydCBvZiBmYWxsYmFjayBwb2xsIHRpbWVvdXQgdmFsdWUgaXMg
bmVjZXNzYXJ5IG9uIHBsYXRmb3Jtcw0Kd2hlcmUgbm9uZSBvZiB0aG9zZSBtZWNoYW5pc21zIGFy
ZSBzdXBwb3J0ZWQuIEFyZ3VhYmx5LCBzb21lIGtlcm5lbA0KY29uZmlndXJhYmlsaXR5ICh3aGV0
aGVyIHZpYSBhIGtlcm5lbCBwYXJhbWV0ZXIsIGFzIHByb3Bvc2VkIGhlcmUsDQpvciBzb21lIG90
aGVyIG1lYW5zKSBpcyBzdGlsbCBkZXNpcmFibGUuDQoNCkkgYWxzbyBhZ3JlZSB0aGVyZSBpcyBu
byByb2J1c3QgbWV0aG9kIHRvIGRldGVybWluZSBhICJnb29kIHZhbHVlIiwgYnV0DQp0aGVuIGFn
YWluIC0gaG93IHdhcyB0aGUgY3VycmVudCB2YWx1ZSBmb3IgdGhlIGNvbnN0YW50IGRldGVybWlu
ZWQ/IEFzDQpzdWdnZXN0ZWQgaW4gUEFUQ0ggMiwgdGhlIGlkZWEgaXMgdG8gbG93ZXIgdGhlIGds
b2JhbCB0aW1lb3V0IHRvIGF2b2lkDQpodW5nIHRhc2tzIHdoZW4gZGV2aWNlcyBicmVhayBhbmQg
bmV2ZXIgY29tZSBiYWNrIGFmdGVyIHJlc2V0Lg0KDQpMaW51eCBhbHJlYWR5IChwYXJ0aWFsbHkp
IHN1cHBvcnRzIHRoZSBfRFNNIG1ldGhvZHMgeW91IG1lbnRpb246DQotIGFjcGlfcGNpX2FkZF9i
dXMoKSBxdWVyaWVzIEZ1bmN0aW9uIDggKGRlc2NyaWJlZCBpbiA0LjYuOCkgdG8gc2V0DQogIGln
bm9yZV9yZXNldF9kZWxheSBvbiB0aGUgaG9zdCBicmlkZ2UNCi0gcGNpX2FjcGlfb3B0aW1pemVf
ZGVsYXkoKSB1c2VzIEZ1bmN0aW9uIDkgdG8gc2V0IGQzY29sZF9kZWxheSBhbmQgZDNfZGVsYXkN
CiAgaW4gc3RydWN0IHBjaV9kZXYsIGJ1dCBkb2VzIG5vdCBjdXJyZW50bHkgc3RvcmUgdGhlIERM
X1VwIFRpbWUsDQogIEZMUiBSZXNldCBUaW1lIGFuZCBWRiBFbmFibGUgVGltZQ0KSSBndWVzcyB3
ZSBjYW4gZXh0ZW5kIHBjaV9zdHJ1Y3QgYWtpbiB0byB3aGF0IFBBVENIIDIgZG9lcyB0byBzdG9y
ZSBhbGwNCnJlbGV2YW50IGRlbGF5IHZhbHVlcyBvbiBhIHBlci1kZXZpY2UgYmFzaXMsIHdpdGgg
c29tZSBkZWZhdWx0IHZhbHVlIGFuZA0Kb3ZlcnJpZGluZyB0aGVtIGFzIGFwcHJvcHJpYXRlIGZy
b20gUmVhZGluZXNzIFRpbWUgUmVwb3J0aW5nLCBfRFNNLCBvciBhIHF1aXJrLg0KDQpVbmZvcnR1
bmF0ZWx5LCB0aGUgaGFyZHdhcmUgYW5kIGZpcm13YXJlIGF0IG15IGRpc3Bvc2FsIGRvZXMgbm90
IHN1cHBvcnQNCmFueSBvZiB0aGUgZGlzY3Vzc2VkIG1lY2hhbmlzbXMsIHNvIEkgZG8gbm90IGZl
ZWwgY29tZm9ydGFibGUgbWFraW5nIHRoZSBjaGFuZ2VzDQp3aXRob3V0IGJlaW5nIGFibGUgdG8g
dGVzdCB0aGVtLg0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAy
MzcgODc5CgoK

