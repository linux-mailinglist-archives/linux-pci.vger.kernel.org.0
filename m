Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369BC2693A1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 19:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgINRiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 13:38:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:30060 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgINM0R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 08:26:17 -0400
IronPort-SDR: DHFR/XaEL8ey2iVZP6XxdDPg/rQVmc9geOcAuQCPp/kTahBQEK5VIqwZSr7eDT5ObiwRtYHyLF
 itXzDTHwcOtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="156506930"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="156506930"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 05:21:08 -0700
IronPort-SDR: DGEV7+pZox9U1lCWkmzuTml+4qYc+0aQ29B1iO0BGMyJqF6nUuGb02ngaBKsrJhhgc8OI518S0
 13j7DjFb1aaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="345411343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2020 05:21:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 05:21:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 05:21:07 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 14 Sep 2020 05:21:07 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Add AHCI to fast interrupt list
Thread-Topic: [PATCH] PCI: vmd: Add AHCI to fast interrupt list
Thread-Index: AQHWguEt85oAyGvP20GdNJJAboR/h6lkx9wAgAPKtIA=
Date:   Mon, 14 Sep 2020 12:21:07 +0000
Message-ID: <7bfa36aff6bd83a4083b84d54896673fec28812c.camel@intel.com>
References: <20200904171325.64959-1-jonathan.derrick@intel.com>
         <20200912022636.GB3655346@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200912022636.GB3655346@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.209.178.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <40B736BEDC06BD48AB59EA626B7211EC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDE5OjI2IC0wNzAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gRnJpLCBTZXAgMDQsIDIwMjAgYXQgMTE6MTM6MjVBTSAtMDYwMCwgSm9uIERlcnJpY2sgd3Jv
dGU6DQo+ID4gU29tZSBwbGF0Zm9ybXMgaGF2ZSBhbiBBSENJIGNvbnRyb2xsZXIgYmVoaW5kIFZN
RC4gVGhlc2UgcGxhdGZvcm1zIGFyZQ0KPiA+IHdvcmtpbmcgY29ycmVjdGx5IGV4Y2VwdCBmb3Ig
YSBjYXNlIHdoZW4gdGhlIEFIQ0kgTVNJIGlzIHByb2dyYW1tZWQgd2l0aA0KPiA+IFZNRCBJUlEg
dmVjdG9yIDAgKDB4ZmVlMDAwMDApLiBXaGVuIHByb2dyYW1tZWQgd2l0aCBhbnkgb3RoZXIgaW50
ZXJydXB0DQo+ID4gKDB4ZmVlTk4wMDApLCB0aGUgTVNJIGlzIHJvdXRlZCBjb3JyZWN0bHkgYW5k
IGlzIGhhbmRsZWQgYnkgVk1ELiBQbGFjaW5nDQo+ID4gdGhlIEFIQ0kgTVNJKHMpIGluIHRoZSBm
YXN0LWludGVycnVwdCBhbGxvdyBsaXN0IHNvbHZlcyB0aGUgaXNzdWUuDQo+IA0KPiBUaGUgb25s
eSByZWFzb24gd2UgaGF2ZSB0aGUgZmFzdCB2cy4gc2xvdyBpcyBiZWNhdXNlIG9mIHRoZSBub24t
cG9zdGVkDQo+IHRyYW5zYWN0aW9ucyBmcm9tIHNsb3cgZHJpdmVyJ3MgaW50ZXJydXB0IGhhbmRs
ZXJzIHRhbmtpbmcgcGVyZm9ybWFuY2UNCj4gb2YgdGhlIG52bWUgZGV2aWNlcyBzaGFyaW5nIHRo
ZSBzYW1lIHZlY3Rvci4gVGhlIG1pY3Jvc2VtaSBzd2l0Y2h0ZWMgd2FzDQo+IG9uZSBvZiB0aGUg
Zmlyc3Qgc3VjaCBkZXZpY2VzIGlkZW50aWZpZWQgdGhhdCBsZWQgdG8gdGhlIGN1cnJlbnQNCj4g
c3BsaXQgaW4gdGhlIFZNRCBkb21haW4uIEFIQ0kncyBkcml2ZXIgYWxzbyBoYXMgbm9uLXBvc3Rl
ZCB0cmFuc2FjdGlvbnMNCj4gaW4gdGhlaXIgaW50ZXJydXB0IGhhbmRsaW5nLCBzbyB5b3UgcHJv
YmFibHkgZG9uJ3Qgd2FudCB0aG9zZSBkZXZpY2VzDQo+IHNoYXJpbmcgdmVjdG9ycyB3aXRoIHlv
dXIgZmFzdCBudm1lIGRldmljZXMuDQoNCkdvb2QgcG9pbnRzIGFuZCBJIHRoaW5rIHRoaXMgd291
bGQgYmUgc2ltcGx5IHJlc29sdmVkIGJ5IG9mZnNldHRpbmcgdGhlDQpzdGFydGluZyB2ZWN0b3Ig
YW5kIGF2b2lkaW5nIHZlY3RvciAwIGZvciBhbGwgdmVjdG9ycy4NCg0KVGhhbmtzDQo=
