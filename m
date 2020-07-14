Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DE21F651
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgGNPnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 11:43:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:64488 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgGNPng (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 11:43:36 -0400
IronPort-SDR: 6AxOy2hm+NWrskRGdTCevNHDU3dxO+2pD2164Vbo2rpqdck8iZ9eekNk+XwxSi71JfVp58SN4S
 I0dpa53c19kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="210477375"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="210477375"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 08:43:36 -0700
IronPort-SDR: 5lTfAIGZJqSf2jfXvkEjYhKubkUQjuR6KWtOv7tJYSjmJ9T98sF0q2Z+5v31Dbag63+pW/cW9V
 0TLk/ZW8EEDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="285795145"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2020 08:43:36 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 08:43:36 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.209]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.240]) with mapi id 14.03.0439.000;
 Tue, 14 Jul 2020 08:43:36 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Thread-Topic: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Thread-Index: AQHWSw+RDEde7kWBZ0WSf8C7+Aw2bqjqNSwAgAaBuYCAAKzvAIAAc8gAgAVQzwCAEKEKAIAAAMQA
Date:   Tue, 14 Jul 2020 15:43:35 +0000
Message-ID: <79a5df5e8c76c9af96e89d5c117d582d16e20874.camel@intel.com>
References: <20200630163332.GA3437879@bjorn-Precision-5520>
         <225256cc0ef63a3e149bcac97999d06381c52830.camel@intel.com>
         <87lfjmumtn.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87lfjmumtn.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.73]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4F18B304FB2C647BD04ECA0CEE4E898@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTE0IGF0IDE3OjQwICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+ICJEZXJyaWNrLCBKb25hdGhhbiIgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPiB3cml0
ZXM6DQo+ID4gT24gVHVlLCAyMDIwLTA2LTMwIGF0IDExOjMzIC0wNTAwLCBCam9ybiBIZWxnYWFz
IHdyb3RlOg0KPiA+IEkgc2VlIHRoYXQgc3RydWN0IGlycWNoaXBfZndpZCBjb250YWlucyB0aGUg
YWN0dWFsIGZ3bm9kZSBzdHJ1Y3R1cmUgYW5kDQo+ID4gd2hlbiB0aGF0IGlzIGZyZWVkLCBpdCdz
IGNhdXNlcyB0aGUgaXNzdWUuDQo+ID4gDQo+ID4gSSdtIG5vdGljaW5nIGluIGVhY2ggY2FsbGVy
IG9mIGlycV9kb21haW5fZnJlZV9md25vZGUsIHdlIGhhdmUgdGhlDQo+ID4gZG9tYWluIGl0c2Vs
ZiBhdmFpbGFibGUuIEl0IHNlZW1zIGxpa2UgaXQgc2hvdWxkIGJlIHVwIHRvIHRoZSBjYWxsZXIg
dG8NCj4gPiBkZWFsIHdpdGggdGhlIGZ3bm9kZSBwb2ludGVyLCBidXQgd2UgY291bGQganVzdCBk
bzoNCj4gDQo+IFdoeT8gVGhlIGZ3bm9kZSBwb2ludGVyIGhhbmRsaW5nIGlzIGluY29uc2lzdGVu
dCBmb3IgdGhlIHZhcmlvdXMgZndub2RlDQo+IHR5cGVzLg0KSSBzZWUuLi4gVGhhdCBkb2VzIGV4
cGxhaW4gYSBsb3QuDQoNCj4gIFdlIHJlYWxseSBkb24ndCB3YW50IHRvIGdvIGJhY2sgdG8gdGhh
dCBzdGF0ZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgdGdseA0KDQpUaGFua3MgZm9y
IHRoZSBwcm9tcHQgZml4DQoNCkpvbg0K
