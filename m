Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8000C1363E4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 00:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgAIXh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 18:37:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:7499 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgAIXh0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 18:37:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 15:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="246825563"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 15:37:25 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.81]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 15:37:25 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "hch@lst.de" <hch@lst.de>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] PCI: Introduce direct dma alias
Thread-Topic: [PATCH v2 3/5] PCI: Introduce direct dma alias
Thread-Index: AQHVxywXwoQKE3+vlUKZwoCX2cxUfafjfBGAgAAHMAA=
Date:   Thu, 9 Jan 2020 23:37:24 +0000
Message-ID: <f0e837bca2bd141e529dbd5817b52d77cea87ddd.camel@intel.com>
References: <20200109231141.GA41540@google.com>
In-Reply-To: <20200109231141.GA41540@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.159]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF859B91DC1D2F4182403F4327729D56@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTA5IGF0IDE3OjExIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBJbiBzdWJqZWN0Og0KPiBzL0ludHJvZHVjZSBkaXJlY3QgZG1hIGFsaWFzL0FkZCBwY2lfZGly
ZWN0X2RtYV9hbGlhcygpLw0KPiANCj4gT24gVGh1LCBKYW4gMDksIDIwMjAgYXQgMDc6MzA6NTRB
TSAtMDcwMCwgSm9uIERlcnJpY2sgd3JvdGU6DQo+ID4gVGhlIGN1cnJlbnQgZG1hIGFsaWFzIGlt
cGxlbWVudGF0aW9uIHJlcXVpcmVzIHRoZSBhbGlhc2VkIGRldmljZSBiZSBvbg0KPiA+IHRoZSBz
YW1lIGJ1cyBhcyB0aGUgZG1hIHBhcmVudC4gVGhpcyBpbnRyb2R1Y2VzIGFuIGFyY2gtc3BlY2lm
aWMNCj4gPiBtZWNoYW5pc20gdG8gcG9pbnQgdG8gYW4gYXJiaXRyYXJ5IHN0cnVjdCBkZXZpY2Ug
d2hlbiBkb2luZyBtYXBwaW5nIGFuZA0KPiA+IHBjaSBhbGlhcyBzZWFyY2guDQo+IA0KPiAiYXJi
aXRyYXJ5IHN0cnVjdCBkZXZpY2UiIGlzIGEgbGl0dGxlIHdlaXJkIHNpbmNlIGFuIGFyYml0cmFy
eSBkZXZpY2UNCj4gZG9lc24ndCBoYXZlIHRvIGJlIGEgUENJIGRldmljZSwgYnV0IHRoZXNlIG1h
cHBpbmdzIGFuZCBhbGlhc2VzIG9ubHkNCj4gbWFrZSBzZW5zZSBpbiB0aGUgUENJIGRvbWFpbi4N
Cj4gDQo+IE1heWJlIGl0IGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCBwY2lfc3lzZGF0YS52bWRf
ZGV2IGJlaW5nIGENCj4gInN0cnVjdCBkZXZpY2UgKiIgcmF0aGVyIHRoYW4gYSAic3RydWN0IHBj
aV9kZXYgKiI/ICBJIGRvbid0IGtub3cgd2h5DQo+IHRoYXQgaXMsIGJlY2F1c2UgaXQgbG9va3Mg
bGlrZSBldmVyeSBwbGFjZSB5b3UgdXNlIGl0LCB5b3UgdXNlDQo+IHRvX3BjaV9kZXYoKSB0byBn
ZXQgdGhlIHBjaV9kZXYgcG9pbnRlciBiYWNrIGFueXdheS4gIEJ1dCBJIGFzc3VtZSB5b3UNCj4g
aGF2ZSBzb21lIGdvb2QgcmVhc29uIGZvciB0aGF0Lg0KTm8gcGFydGljdWxhciByZWFzb24gb3Ro
ZXIgdGhhbiB0byBhbGlnbiB3aXRoIHRoZSBzdWdnZXN0aW9uIGluIHRoZQ0KbGFzdCBzZXQgdG8g
YmUgdXNpbmcgdGhlIHN0cnVjdCBkZXZpY2UuIEl0IGRvZXMgbWFrZSBzZW5zZSB0byByZWZlcmVu
Y2UNCnRoZSBzdHJ1Y3QgZGV2aWNlIGFzIHRoYXQgcHJvdmlkZXMgdGhlIGRtYSBjb250ZXh0LCBo
b3dldmVyIGFzIHlvdSBoYXZlDQpwb2ludGVkIG91dCwgdGhlIGltcGxlbWVudGF0aW9uIGhlcmUg
bW9yZXNvIG5lZWRzIHRoZSBkZXZpY2Uncw0KcGNpX2Rldi4gDQoNCkknbGwgc2VlIGhvdyBpdCBs
b29rcyBmb3IgdGhlIG5leHQgc2V0Lg0KDQo+IA0KPiBzL2RtYS9ETUEvDQo+IHMvcGNpL1BDSS8N
Cj4gKGFib3ZlIGFuZCBhbHNvIGluIGNvZGUgY29tbWVudHMgYmVsb3cpDQo+IA0KPiA+IA0K
