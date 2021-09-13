Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9240991E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhIMQb1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 12:31:27 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:13905 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhIMQbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 12:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1631550605; x=1663086605;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=hh6o535Ui+UUGykvJnjyFh4tcXN1dZTZLfx7HK2bTF8=;
  b=p7r66hn8RjsxyyRbwORENI3D2YGew1/BG5KzpEF7pZUvT1iA8psDFY6l
   HSHLEkMhPG9yX6hp+c8gH8Qj1WykcgymNqo9tVfa1u/5EGRLbv4R01+5O
   jA6/X61mTbUlVcM8MYSgJEukBhvq+iC1rC0EUYd0K0OoBKaITXcGqTOHl
   U=;
X-IronPort-AV: E=Sophos;i="5.85,290,1624320000"; 
   d="scan'208";a="141358017"
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Thread-Topic: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 13 Sep 2021 16:29:55 +0000
Received: from EX13D12EUC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id B54CBA06AA;
        Mon, 13 Sep 2021 16:29:53 +0000 (UTC)
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D12EUC001.ant.amazon.com (10.43.164.45) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 13 Sep 2021 16:29:51 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.023;
 Mon, 13 Sep 2021 16:29:51 +0000
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
Thread-Index: AQHV9KTPukJAMq/z+UWtD4VToexxlKuiQk6AgANNjQA=
Date:   Mon, 13 Sep 2021 16:29:51 +0000
Message-ID: <44cac41a02d0fd104b171e9a87b4699197224de4.camel@amazon.de>
References: <20210911140329.GA1202813@bjorn-Precision-5520>
In-Reply-To: <20210911140329.GA1202813@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.211]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8613AD642DD1B04ABDBC700733EB94A0@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDIxLTA5LTExIGF0IDA5OjAzIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
DQo+IEkgdGhpbmsgdGhlIFJvb3QgQ29tcGxleCBtYXkgZXZlbnR1YWxseSBjb21wbGV0ZSB0aGUg
dHJhbnNhY3Rpb24gYXMNCj4gZmFpbGVkICpyZWdhcmRsZXNzKiBvZiB3aGV0aGVyIENSUyBTViBp
cyBlbmFibGVkLiAgVGhpcyBpcyB1bmNsZWFyIGluDQo+IFBDSWUgcjUuMCwgc2VjIDIuMy4yLCBi
ZWNhdXNlIHRoZSB0ZXh0IGZvcm1hdHRpbmcgd2FzIGJyb2tlbiBiZXR3ZWVuDQo+IHI0LjAgYW5k
IHI1LjAuICBbLi4uXQ0KPg0KPiAgIEEgUm9vdCBDb21wbGV4IGltcGxlbWVudGF0aW9uIG1heSBj
aG9vc2UgdG8gbGltaXQgdGhlIG51bWJlciBvZg0KPiAgIENvbmZpZ3VyYXRpb24gUmVxdWVzdC9D
UlMgQ29tcGxldGlvbiBTdGF0dXMgbG9vcHMgYmVmb3JlIGRldGVybWluaW5nDQo+ICAgdGhhdCBz
b21ldGhpbmcgaXMgd3Jvbmcgd2l0aCB0aGUgdGFyZ2V0IG9mIHRoZSBSZXF1ZXN0IGFuZCB0YWtp
bmcNCj4gICBhcHByb3ByaWF0ZSBhY3Rpb24sIGUuZy4sIGNvbXBsZXRlIHRoZSBSZXF1ZXN0IHRv
IHRoZSBob3N0IGFzIGENCj4gICBmYWlsZWQgdHJhbnNhY3Rpb24uDQoNCkkgY2FuIHByb3ZpZGUg
YSBiaXQgbW9yZSBiYWNrZ3JvdW5kOg0KDQpUaGUgaXNzdWUgdGhhdCBwcm9tcHRlZCBtZSB0byBp
bXBsZW1lbnQgdGhpcyBwYXRjaCBpbnZvbHZlZCBhIGRldmljZSB0aGF0DQp1c2VkIENSUyBDb21w
bGV0aW9ucyB0byBzaWduYWwgcG9zdC1yZXNldCAobm9uLSlyZWFkaW5lc3MuIEluIHNvbWUgY2Fz
ZXMsDQp0aGUgZGV2aWNlIHdvdWxkIGdldCBzdHVjayBhbmQgY29udGludWUgaXNzdWluZyBDUlMg
Q29tcGxldGlvbnMgZm9yIGFsbA0KcmVxdWVzdHMgaW5kZWZpbml0ZWx5Lg0KDQpUaGUgZGV2aWNl
IHdhcyBhdHRhY2hlZCBkaXJlY3RseSB0byBhIFJvb3QgUG9ydCBvbiBhIHNlcnZlci1ncmFkZSBJ
bnRlbCBDUFUsDQphbmQgQ1JTIFNWIHdhcyBlbmFibGVkIG9uIHRoYXQgUm9vdCBQb3J0LiBUaGUg
b3JpZ2luYWwgcGNpX2Rldl93YWl0KCkNCmltcGxlbWVudGF0aW9uLCBieSB2aXJ0dWUgb2YgcG9s
bGluZyB0aGUgQ29tbWFuZCByZWdpc3RlciByYXRoZXIgdGhhbiB0aGUNClZlbmRvciBJRCwgd291
bGQgYWx3YXlzIGNhdXNlIGEgVE9SIHRpbWVvdXQgYW5kIGFzc29jaWF0ZWQgaG9zdCBjcmFzaC4N
Cg0KSSBsYXRlciB1bmRlcnN0b29kIHRoZSBzcGVjaWZpYyBDUFUgZGlkIGhhdmUgYSBwcm9wcmll
dGFyeSByZWdpc3RlciBmb3INCiJsaW1pdGluZyB0aGUgbnVtYmVyIG9mIGxvb3BzIiB0aGF0IHRo
ZSBQQ0llIHNwZWMgdGFsa3MgYWJvdXQsIGFuZCBpbmRlZWQNCnRoYXQgcmVnaXN0ZXIgd2FzIHNl
dCB0byAibm8gbGltaXQiLiBDb3VwbGVkIHdpdGggdGhlIHN0dWNrIGRldmljZSwgdGhlc2UNCmlu
ZGVmaW5pdGUgcmV0cmllcyBldmVudHVhbGx5IHRyaWdnZXJlZCBUT1IgdGltZW91dC4NCg0KR3Jh
bnRlZCwgdGhlcmUgYXJlIHN1cmVseSBSb290IENvbXBsZXhlcyB0aGF0IGJlaGF2ZSBkaWZmZXJl
bnRseSwgc2luY2UgdGhlDQpQQ0llIHNwZWMgbGVhdmVzIHRoaXMgdXAgdG8gdGhlIGltcGxlbWVu
dGF0aW9uLiBTdGlsbCwgdGhpcyBwYXRjaCBpbmNyZWFzZXMNCnJvYnVzdG5lc3MgYnkgcG9sbGlu
ZyB0aGUgc2FmZXIgVmVuZG9yIElEIHJlZ2lzdGVyLCB3aGljaCBpcyBzYWZlciBhdCBsZWFzdA0K
aW4gc29tZSBzaXR1YXRpb25zLCBhbmQgbm90IGFueSBsZXNzIHNhZmUgZ2VuZXJhbGx5LiBIb3dl
dmVyLCBpdCBpcyBub3QgYQ0Kc2ltcGxlIG1hdHRlciBvZiBzd2l0Y2hpbmcgd2hpY2ggcmVnaXN0
ZXIgaXMgcG9sbGVkIGR1ZSB0byB0aGUgU1ItSU9WDQpjb25zaWRlcmF0aW9ucyB0aGF0IHJlcXVp
cmUgYSBmYWxsYmFjayB0byBDb21tYW5kLg0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBH
ZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVu
ZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10
c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpV
c3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

