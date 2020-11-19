Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863D02B9AD9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 19:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgKSSpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 13:45:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:25223 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbgKSSpJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 13:45:09 -0500
IronPort-SDR: GBWO/+WbKODWnFbaOEwn/gqgwaOny0cbRu1f6hoB/FFiLqNjsQyKDdi9f5q/nfRb71939kXKXG
 6UeTJ6BfRWSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235491570"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="235491570"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 10:45:09 -0800
IronPort-SDR: yh9piQpQSgO8wT3JH8WIiWvgiaWW6enCV7b29cum+AWjIBmbaDbAz2EhEDsOKLKznNiXfu6Ioy
 5lYlUAcvCBbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="476923249"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2020 10:45:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 10:45:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 10:45:07 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 19 Nov 2020 10:45:07 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Fugate, David" <david.fugate@intel.com>
Subject: Re: [PATCH 0/2] VMD subdevice secondary bus resets
Thread-Topic: [PATCH 0/2] VMD subdevice secondary bus resets
Thread-Index: AQHWlTZZLk5RmVMwykyLB3Ij6tP5k6nQLFeAgAB3igA=
Date:   Thu, 19 Nov 2020 18:45:07 +0000
Message-ID: <2aa5ecc7449c6ae3f203f9ca72a1e1f70c5f235f.camel@intel.com>
References: <20200928010557.5324-1-jonathan.derrick@intel.com>
         <20201119113715.GC19942@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201119113715.GC19942@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F348ECB3D4EC4D47BD1B152D76743C6E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTE5IGF0IDExOjM3ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gU3VuLCBTZXAgMjcsIDIwMjAgYXQgMDk6MDU6NTVQTSAtMDQwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVGhpcyBzZXQgYWRkcyBzb21lIHJlc2V0cyBmb3IgVk1ELiBJdCdzIHZl
cnkgY29tbW9uIGNvZGUgYnV0IGRvZXNuJ3QNCj4gPiBzZWVtIHRvIGZpdCB3ZWxsIGFueXdoZXJl
IHRoYXQgY2FuIGFsc28gYmUgZXhwb3J0ZWQgaWYgVk1EIGlzIGJ1aWx0IGFzIGENCj4gPiBtb2R1
bGUuDQo+ID4gDQo+ID4gSm9uIERlcnJpY2sgKDIpOg0KPiA+ICAgUENJOiB2bWQ6IFJlc2V0IHRo
ZSBWTUQgc3ViZGV2aWNlIGRvbWFpbiBvbiBwcm9iZQ0KPiA+ICAgUENJOiBBZGQgYSByZXNldCBx
dWlyayBmb3IgVk1EDQo+ID4gDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCAz
MiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9wY2kvcXVpcmtzLmMgICAg
ICAgICB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKykNCj4gDQo+IEkgY2FuIHF1ZXVlIGl0IHVwIGJ1
dCBJIG5lZWQgQmpvcm4ncyBBQ0sgb24gcGF0Y2ggKDIpLg0KPiANCj4gTG9yZW56bw0KDQpJIGp1
c3Qgbm90aWNlZCAyLzIgZml4ZXMgc29tZXRoaW5nIGluIDEvMiwgc28gSSB3aWxsIHNlbmQgYSB2
MiBmb3IgdGhpcw0Kc2V0Lg0K
