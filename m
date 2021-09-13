Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E6B409BB0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhIMSFg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 14:05:36 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:48209 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346476AbhIMSFf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 14:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1631556260; x=1663092260;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=r+SmOCRHXbH1F/kuuCIgycWXVijjxKdwyL78B4FomlE=;
  b=Ctjdiz49zdkMMZzSjn+mFFvS/zuU7ZmXBML4ualEVoeRe+U+mDT8mof6
   HZRc6UXkwd0D3qFGgLXIaINA3IL2G19ppolXkdqo1bColJbJyrnL/OuJc
   YX2rkUOJE+82qX3ZxsF3fOTHUSuCS7FnKGRO8OrhQ7JAHHPstEU130s9f
   s=;
X-IronPort-AV: E=Sophos;i="5.85,290,1624320000"; 
   d="scan'208";a="957404151"
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Thread-Topic: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 13 Sep 2021 18:04:08 +0000
Received: from EX13D12EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id 6D25FA1A9B;
        Mon, 13 Sep 2021 18:04:07 +0000 (UTC)
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D12EUA001.ant.amazon.com (10.43.165.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 13 Sep 2021 18:04:05 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.023;
 Mon, 13 Sep 2021 18:04:05 +0000
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
Thread-Index: AQHV9KTPukJAMq/z+UWtD4VToexxlKuiQk6AgANNjQCAAAKBgIAAF9MA
Date:   Mon, 13 Sep 2021 18:04:05 +0000
Message-ID: <9cae764f00c5969c364728ed031c29ce49c03480.camel@amazon.de>
References: <20210913163847.GA1335093@bjorn-Precision-5520>
In-Reply-To: <20210913163847.GA1335093@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.98]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5959D6340E23CA4CBE8D86422EA33F2F@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTA5LTEzIGF0IDExOjM4IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBNb24sIFNlcCAxMywgMjAyMSBhdCAwNDoyOTo1MVBNICswMDAwLCBTcGFzc292LCBTdGFu
aXNsYXYgd3JvdGU6DQo+ID4gT24gU2F0LCAyMDIxLTA5LTExIGF0IDA5OjAzIC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+IA0KPiA+IEkgbGF0ZXIgdW5kZXJzdG9vZCB0aGUgc3BlY2lm
aWMgQ1BVIGRpZCBoYXZlIGEgcHJvcHJpZXRhcnkgcmVnaXN0ZXIgZm9yDQo+ID4gImxpbWl0aW5n
IHRoZSBudW1iZXIgb2YgbG9vcHMiIHRoYXQgdGhlIFBDSWUgc3BlYyB0YWxrcyBhYm91dCwgYW5k
IGluZGVlZA0KPiA+IHRoYXQgcmVnaXN0ZXIgd2FzIHNldCB0byAibm8gbGltaXQiLiBDb3VwbGVk
IHdpdGggdGhlIHN0dWNrIGRldmljZSwgdGhlc2UNCj4gPiBpbmRlZmluaXRlIHJldHJpZXMgZXZl
bnR1YWxseSB0cmlnZ2VyZWQgVE9SIHRpbWVvdXQuDQo+IA0KPiAiTm8gbGltaXQiIHNvdW5kcyBs
aWtlIGEgcHJldHR5IGJhZCBjaG9pY2UsIGdpdmVuIHRoYXQgaXQgbWVhbnMgdGhlDQo+IENQVSB3
aWxsIGVzc2VudGlhbGx5IGhhbmcgZm9yZXZlciBiZWNhdXNlIG9mIGEgZGVmZWN0aXZlIEkvTyBk
ZXZpY2UuDQo+IFRoZXJlIHNob3VsZCBiZSBhIHRpbWVvdXQgc28gc29mdHdhcmUgY2FuIHJlY292
ZXIgKHRoZSAqZGV2aWNlKiBtYXkNCj4gbmV2ZXIgcmVjb3ZlciwgYnV0IHRoYXQncyBubyByZWFz
b24gd2h5IHRoZSBrZXJuZWwgbXVzdCBjcmFzaCkuDQo+IA0KDQpDb3JyZWN0LiAiTm8gbGltaXQi
IGlzIGRlZmluaXRlbHkgYSBiYWQgY2hvaWNlIGZvciB0aGF0IHJlZ2lzdGVyLA0KYW5kIGZpeGlu
ZyB0aGUgdmFsdWUgd291bGQgYmUgcHJlZmVyYWJsZSB0byBhbnkgc29mdHdhcmUgc29sdXRpb24u
DQoNClVuZm9ydHVuYXRlbHksIGF0IGxlYXN0IGluIHRoZSBjYXNlIEkgd29ya2VkIG9uLCB0aGF0
IHJlZ2lzdGVyIHdhcw0Kbm90IGFjY2Vzc2libGUgYnkgdGhlIGtlcm5lbC4gSW50ZWwgZXhwb3Nl
cyBtYW55IENQVSBjb25maWd1cmF0aW9uDQpyZWdpc3RlcnMgaW4gdGVybXMgb2YgdmlydHVhbCBQ
Q0kgZGV2aWNlcyByZXNpZGluZyBkaXJlY3RseSBvbiBSb290DQpCdXNlcywgYW5kIHRoZSBzeXN0
ZW0vcGxhdGZvcm0gZmlybXdhcmUgaXMgYWJsZSB0byB1c2UgdmVuZG9yLXByb3ZpZGVkDQptZWFu
cyB0byBjb21wbGV0ZWx5IGhpZGUgc29tZSBvZiB0aGVzZSBwc2V1ZG8tZGV2aWNlcyBmcm9tIHRo
ZSBPUy4NCg0KQWRkaXRpb25hbGx5LCB0aGUgd2F5IHRoZSBQQ0llIHNwZWMgaXMgcGhyYXNlZCwg
bm90IGV2ZXJ5IFJvb3QgQ29tcGxleA0KaW1wbGVtZW50YXRpb24gaXMgcmVxdWlyZWQgdG8gZXZl
biBoYXZlIHN1Y2ggYSBsaW1pdGluZyByZWdpc3Rlciwgd2hpbGUNCmFsbCBpbXBsZW1lbnRhdGlv
bnMgdGhhdCBhZHZlcnRpc2UgQ1JTIFNWIGNhcGFiaWxpdHkgYXJlIHJlcXVpcmVkIHRvDQpiZWhh
dmUgYXMgcHJlc2NyaWJlZCB3aGVuIFBDSV9WRU5ET1JfSUQgaXMgcmVhZC4gSGVuY2Ugd2h5IEkg
YmVsaWV2ZQ0KdGhpcyBwYXRjaCBpcyBhIGdlbmVyYWwgcm9idXN0bmVzcyBpbXByb3ZlbWVudCwg
cmF0aGVyIHRoYW4gYSB3b3JrYXJvdW5kDQpmb3IgYSBzcGVjaWZpYyBkZXZpY2UvcGxhdGZvcm0u
DQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAz
OAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBK
b25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1
bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

