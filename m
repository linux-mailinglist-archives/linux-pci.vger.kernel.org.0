Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D417C50E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCFSHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 13:07:42 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:63405 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFSHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 13:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1583518061; x=1615054061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=RBx28tXAqYegxsqpNcHeqV1C0xz3pWJ+HCGDjYNItYI=;
  b=XNN9cBbT1ithZCsFMyLaN7eIgGO4jp1t0+nmisb2wGRE8/n+mtOD1deD
   +Cop9sNs4MXDpSroS1UwaCMnAiNM5o6YGAKY4b2kInRcodhwhPhi3NDuk
   R+3kKVgrmYTpWo/sbKpeoxb/1jhw7ZoQpkVp8kQjNX+ZA+usP6I0n2943
   w=;
IronPort-SDR: A/4mgSc+fg54FcJMwEP4/3jjITyrPpajg7uCstYuxw9fGbDRMmlhbdqo3HFvDhFC75tssZ1AEg
 ucYcogvrxgQg==
X-IronPort-AV: E=Sophos;i="5.70,523,1574121600"; 
   d="scan'208";a="20404702"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 06 Mar 2020 18:07:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 95D00A1FC4;
        Fri,  6 Mar 2020 18:07:26 +0000 (UTC)
Received: from EX13D12EUC001.ant.amazon.com (10.43.164.45) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Fri, 6 Mar 2020 18:07:26 +0000
Received: from EX13D04EUB003.ant.amazon.com (10.43.166.235) by
 EX13D12EUC001.ant.amazon.com (10.43.164.45) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 6 Mar 2020 18:07:25 +0000
Received: from EX13D04EUB003.ant.amazon.com ([10.43.166.235]) by
 EX13D04EUB003.ant.amazon.com ([10.43.166.235]) with mapi id 15.00.1497.006;
 Fri, 6 Mar 2020 18:07:25 +0000
From:   "Spassov, Stanislav" <stanspas@amazon.de>
To:     "ashok.raj@intel.com" <ashok.raj@intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 16/17] PCI: Add CRS handling to pci_dev_wait()
Thread-Topic: [PATCH v3 16/17] PCI: Add CRS handling to pci_dev_wait()
Thread-Index: AQHV8+IWrpzxIUAC80CDa943SrHMMA==
Date:   Fri, 6 Mar 2020 18:07:24 +0000
Message-ID: <c273cb0c448781cdb42932e3dd324a30668cee65.camel@amazon.de>
References: <20200303132852.13184-1-stanspas@amazon.com>
         <20200303132852.13184-17-stanspas@amazon.com>
         <20200305175620.GA94051@otc-nc-03>
In-Reply-To: <20200305175620.GA94051@otc-nc-03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.159]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B667164A025FF142A9385DD88419E9A9@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+IElGIENSUyBpcyBzdXBwb3J0ZWQgYnkgUm9vdCBQb3J0IGJ1dCBDUlMgU1YgaXMgbm90IGVu
YWJsZWQsIHRoZSByZXF1ZXN0DQo+ID4gaXMgcmV0cmllZCBhdXRvbm9tb3VzbHkgYnkgdGhlIFJv
b3QgUG9ydC4gUGxhdGZvcm0tc3BlY2lmaWMgY29uZmlndXJhdGlvbg0KPiA+IHJlZ2lzdGVycyBt
YXkgZXhpc3QgdG8gbGltaXQgdGhlIG51bWJlciBvZiBvciB0aW1lIHRha2VuIGJ5IHN1Y2ggcmV0
cmllcy4NCj4gDQo+IEFsc28gd2hlbiBDUlNWIGlzIGVuYWJsZWQsIGNvbmZpZyByZWFkIHRoYXQg
ZG9lc24ndCBjb3ZlciBWRU5ET1IgaXMNCj4gYWxzbyByZXRyaWVkIGF1dG9tYXRpY2FsbHkuDQo+
IA0KDQpBZ3JlZWQuIFRoaXMgaXMgZXhwbGFpbmVkIGluIHRoZSB2ZXJ5IG5leHQgc2VudGVuY2Ug
b2YgdGhlIGNvbW1pdCBtZXNzYWdlLA0KYnV0IEkgd2lsbCBzZWUgaWYgSSBjYW4gcmUtb3JkZXIv
cmUtcGhyYXNlIHRvIG1ha2UgdGhlIGV4cGxhbmF0aW9uIGxlc3MgY29uZnVzaW5nLg0KDQo+ID4g
DQo+ID4gKyAgICAgaWYgKGRldi0+Y3Jzc3ZfZW5hYmxlZCkgew0KPiA+ICsgICAgICAgICAgICAg
dTMyIGlkOw0KPiANCj4gSSBsaWtlIHRoaXMgY2hlY2sgdG8gcmVhZCBWRU5ET1JfSUQgd2hlbiBj
cnNzdiBpcyBlbmFibGVkLiBCdXQgeW91ciBwYXRjaGVzDQo+IHNlZW1zIHRvIGRlZmluZSBpbiBw
YXRjaDEzIGFuZCB1c2VkIGluIHBhdGNoMTY/DQo+IA0KPiBjYW4gd2Uga2VlcCB0aGVtIHNpbXBs
ZT8gYW5kIGlmIHBvc3NpYmxlIGp1c3QgdGhpcyB3b3VsZCBiZSBhDQo+IG5lZWRlZCBmaXguIFdl
IGhhdmUgc29tZSBzeXN0ZW1zIHRoYXQgd2UgaGF2ZSBmb3VuZCBjYW4gY2F1c2UNCj4gdGltZW91
dHMgaWYgQ1JTViBpcyBlbmFibGVkLCBidXQgeW91IHJlYWQgYW55IG90aGVyIHJlZ2lzdGVyDQo+
IG90aGVyIHRoYW4gdGhlIFBDSV9WRU5ET1IuDQo+IA0KPiBXb3VsZCBwcmVmZXIgdG8gc2VlIHRo
aXMgZml4IGJlZm9yZSB0aGUgb3RoZXIgY2xlYW51cHMgY2FuIHN0YWJpbGl6ZSA6LSkNCj4gDQoN
Ck1ha2VzIHNlbnNlLiBJIGd1ZXNzIEkgZ290IGFoZWFkIG9mIG15c2VsZiB3aGVuIGV4dGVuZGlu
ZyB0aGUgb3JpZ2luYWwgdjEgb2YgdGhpcyBwYXRjaCBzZXJpZXMgZnJvbSBvbmx5IGRlYWxpbmcg
d2l0aCB0aGUgQ1JTIHByb2JsZW0gdG8gImxldCdzIGZpeCB0aGUgd29ybGQiDQo6LSkgIEkgd2ls
bCByZW9yZGVyIG15IHBhdGNoZXMgYSBiaXQgYW5kIHBvc3QgdGhlbSBhcyB0d28gc2VwYXJhdGUg
c2VyaWVzLCBzbyB0aGF0IHRoZSBDUlMtcmVsYXRlZCBzdHVmZiBjYW4gYmUgcHVzaGVkIGVhcmxp
ZXIgYW5kIG9uIGl0cyBvd24gd2hpbGUgdGhlIHJlc3QNCnN0YWJpbGl6ZXMuDQoNCj4gSSB3b3Vs
ZCBhbHNvIG1hcmsgdGhhdCBmb3Igc3RhYmxlLg0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRl
ciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVo
cnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0g
QW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxp
bgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

