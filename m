Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806D6A0795
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 18:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1Qls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 12:41:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:14625 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1Qls (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 12:41:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 09:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="380462397"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2019 09:41:47 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 09:41:46 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.119]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.63]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 09:41:46 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] x86/pci: Add a to_pci_sysdata helper
Thread-Topic: [PATCH 2/5] x86/pci: Add a to_pci_sysdata helper
Thread-Index: AQHVXasMRGGSFfOeWEC6h3pcJWlJsKcROPeA
Date:   Wed, 28 Aug 2019 16:41:45 +0000
Message-ID: <809ad38b6aca8e828db7be6423cb03ac9208fb5a.camel@intel.com>
References: <20190828141443.5253-1-hch@lst.de>
         <20190828141443.5253-3-hch@lst.de>
In-Reply-To: <20190828141443.5253-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.6.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4FADED671890B4DA25C0EC95EBE283D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTI4IGF0IDE2OjE0ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gVmFyaW91cyBoZWxwZXJzIG5lZWQgdGhlIHBjaV9zeXNkYXRhIGp1c3QgdG8gZGVyZWZl
cmVuY2UgYSBzaW5nbGUgZmllbGQNCj4gaW4gaXQuICBBZGQgYSBsaXR0bGUgaGVscGVyIHRoYXQg
cmV0dXJucyB0aGUgcHJvcGVybHkgdHlwZWQgc3lzZGF0YQ0KPiBwb2ludGVyIHRvIHJlcXVpcmUg
YSBsaXR0bGUgbGVzcyBib2lsZXJwbGF0ZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9h
c20vcGNpLmggfCAyOCArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGNpLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wY2ku
aA0KPiBpbmRleCA2ZmE4NDY5MjBmNWYuLjc1ZmUyODQ5MjI5MCAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vcGNpLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGNp
LmgNCj4gQEAgLTM1LDEyICszNSwxNSBAQCBleHRlcm4gaW50IG5vaW9hcGljcmVyb3V0ZTsNCj4g
IA0KPiAgI2lmZGVmIENPTkZJR19QQ0kNCj4gIA0KPiArc3RhdGljIGlubGluZSBzdHJ1Y3QgcGNp
X3N5c2RhdGEgKnRvX3BjaV9zeXNkYXRhKHN0cnVjdCBwY2lfYnVzICpidXMpDQpDYW4geW91IG1h
a2UgdGhlIGFyZ3VtZW50IGNvbnN0IHRvIGF2b2lkIGFsbCB0aGUgd2FybmluZ3MgZnJvbSBjYWxs
ZXJzDQpwYXNzaW5nIGNvbnN0IHN0cnVjdCBwY2lfYnVzDQoNCnNuaXANCg==
