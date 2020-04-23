Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935FB1B5EF0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 17:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgDWPSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 11:18:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:23924 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWPSL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 11:18:11 -0400
IronPort-SDR: EaWMP4Lb7CLqY2fN8cBa5aZvNr6vnw/Z1zJQpmPQ3UX8IEJkPCYa/ymnwTkrBTCzUmdll40tgX
 nifebXUqh2CA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 08:18:11 -0700
IronPort-SDR: zYEizug2f5pEgxBz0iBF5IN2GkdmOTUfaVcntlAZ2uiPCMykRTIFm63MPB9b9M9RfzEfWF0+6J
 NErz0qlayTWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="430357474"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2020 08:18:10 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 08:18:10 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.140]) with mapi id 14.03.0439.000;
 Thu, 23 Apr 2020 08:18:10 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "Jakowski, Andrzej" <andrzej.jakowski@intel.com>
Subject: Re: [PATCH 0/1] KVM support for VMD devices
Thread-Topic: [PATCH 0/1] KVM support for VMD devices
Thread-Index: AQHWGMupFPgnPdV8d0yMVvPmd3oXgKiGsTeAgACXUwA=
Date:   Thu, 23 Apr 2020 15:18:10 +0000
Message-ID: <f58982d0d37f86c8cf4d8769d42bea284e0c2825.camel@intel.com>
References: <20200422171444.10992-1-jonathan.derrick@intel.com>
         <20200423061631.GA12688@infradead.org>
In-Reply-To: <20200423061631.GA12688@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.1.180]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2693A69249AB774DABEBE1A7DBFD60BC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTIyIGF0IDIzOjE2IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBBcHIgMjIsIDIwMjAgYXQgMDE6MTQ6NDRQTSAtMDQwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVGhlIHR3byBwYXRjaGVzIChMaW51eCAmIFFFTVUpIGFkZCBzdXBwb3J0
IGZvciBwYXNzdGhyb3VnaCBWTUQgZGV2aWNlcw0KPiA+IGluIFFFTVUvS1ZNLiBWTUQgZGV2aWNl
IDI4QzAgYWxyZWFkeSBzdXBwb3J0cyBwYXNzdGhyb3VnaCBuYXRpdmVseSBieQ0KPiA+IHByb3Zp
ZGluZyB0aGUgSG9zdCBQaHlzaWNhbCBBZGRyZXNzIGluIGEgc2hhZG93IHJlZ2lzdGVyIHRvIHRo
ZSBndWVzdA0KPiA+IGZvciBjb3JyZWN0IGJyaWRnZSBwcm9ncmFtbWluZy4NCj4gPiANCj4gPiBU
aGUgUUVNVSBwYXRjaCBlbXVsYXRlcyB0aGUgMjhDMCBtb2RlIGJ5IGNyZWF0aW5nIGEgc2hhZG93
IHJlZ2lzdGVyIGFuZA0KPiA+IGFkdmVydGlzaW5nIGl0cyBzdXBwb3J0IGJ5IHVzaW5nIFFFTVUn
cyBzdWJzeXN0ZW0gdmVuZG9yL2lkLg0KPiA+IFRoZSBMaW51eCBwYXRjaCBtYXRjaGVzIHRoZSBR
RU1VIHN1YnN5c3RlbSB2ZW5kb3IvaWQgdG8gdXNlIHRoZSBzaGFkb3cNCj4gPiByZWdpc3Rlci4N
Cj4gDQo+IFBsZWFzZSBwaWNrIGEgZGlmZmVyZW50IFBDSSBJRCBmb3IgUWVtdSB2cyByZWFsIGhh
cmR3YXJlIHNvIHRoYXQgd2UNCj4gY2FuIHByb3Blcmx5IHF1aXJrIHRoZW0gaWYgdGhleSBlbmQg
dXAgYmVoYXZpbmcgZGlmZmVyZW50bHkgZHVlIHRvDQo+IGhhcmR3YXJlIG9yIHNvZnR3YXJlIGJ1
Z3MuDQoNClN1cmUuIFdpbGwgbG9vayBpbnRvIHRoYXQuDQpUaGFua3MgQ2hyaXN0b3BoDQoNCkpv
bg0K
