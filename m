Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259D62539E6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Aug 2020 23:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHZVnd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Aug 2020 17:43:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:34921 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgHZVnd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Aug 2020 17:43:33 -0400
IronPort-SDR: AhWLQ9p7DrUzLrL7YVs59BeQkoynZqH+C6DMeyacO+lMIa+GzvkYbWwrOEe7Z/T/nBR2k4l+4B
 tPNqE5gRC5rQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="144149708"
X-IronPort-AV: E=Sophos;i="5.76,357,1592895600"; 
   d="scan'208";a="144149708"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 14:43:32 -0700
IronPort-SDR: OD9JTnBIG8pJs82RcAuk1kcyOG2KRmMTOf5aJfbgxvnxYGM5qj1Olf51blrN/XgKqL1TuqeRP5
 ecFeGk8vkYwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,357,1592895600"; 
   d="scan'208";a="329367051"
Received: from irsmsx602.ger.corp.intel.com ([163.33.146.8])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 14:43:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 irsmsx602.ger.corp.intel.com (163.33.146.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 22:43:29 +0100
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 26 Aug 2020 14:43:27 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Thread-Topic: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Thread-Index: AQHWd7clLgwBVuAUCESee06o/u7QiKlI1l4AgAKTLgA=
Date:   Wed, 26 Aug 2020 21:43:27 +0000
Message-ID: <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
         <20200825062320.GA27116@infradead.org>
In-Reply-To: <20200825062320.GA27116@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.222.2]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8000C6336A84F43B2F822D3244D885C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTI1IGF0IDA2OjIzICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gRnJpLCBBdWcgMjEsIDIwMjAgYXQgMDg6MzI6MjBQTSArMDgwMCwgS2FpLUhlbmcg
RmVuZyB3cm90ZToNCj4gPiBOZXcgSW50ZWwgbGFwdG9wcyB3aXRoIFZNRCBjYW5ub3QgcmVhY2gg
ZGVlcGVyIHBvd2VyIHNhdmluZyBzdGF0ZSwNCj4gPiByZW5kZXJzIHZlcnkgc2hvcnQgYmF0dGVy
eSB0aW1lLg0KPiANCj4gU28gd2hhdCBhYm91dCBqdXN0IGRpc2FibGluZyBWTUQgZ2l2ZW4gaG93
IGJsb29keSBwb2ludGxlc3MgaXQgaXM/DQo+IEhhc24ndCBhbnlvbmUgbGVhcm5lZCBmcm9tIHRo
ZSBBSENJIHJlbWFwcGluZyBkZWJhY2xlPw0KPiANCj4gSSdtIHJlYWxseSBwaXNzZWQgYXQgYWxs
IHRoaXMgcG9pbnRsZXNzIGNyYXAgaW50ZWwgY29tZXMgdXAgd2l0aCBqdXN0DQo+IHRvIG1ha2Ug
bGlmZSBoYXJkIGZvciBhYnNvbHV0ZWx5IG5vIGdhaW4uICBJcyBpdCBzbyBoYXJkIHRvIGp1c3Qg
bGVhdmUNCj4gYSBOVk1lIGRldmljZSBhcyBhIHN0YW5kYXJkIE5WTWUgZGV2aWNlIGluc3RlYWQg
b2YgZipeJmluZyBldmVyeXRoaW5nDQo+IHVwIGluIHRoZSBjaGlwc2V0IHRvIG1ha2UgT1Mgc3Vw
cG9ydCBhIHBhaW4gYW5kIEkvTyBzbG93ZXIgdGhhbiBieQ0KPiBkb2luZyBub3RoaW5nPw0KDQoN
CkZlZWwgZnJlZSB0byByZXZpZXcgbXkgc2V0IHRvIGRpc2FibGUgdGhlIE1TSSByZW1hcHBpbmcg
d2hpY2ggd2lsbCBtYWtlDQppdCBwZXJmb3JtIGFzIHdlbGwgYXMgZGlyZWN0LWF0dGFjaGVkOg0K
DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcGNpL2xpc3QvP3Nl
cmllcz0zMjU2ODENCg==
