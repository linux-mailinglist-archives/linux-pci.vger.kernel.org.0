Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C527157E17
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 16:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBJPFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 10:05:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:20091 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbgBJPFt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 10:05:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 07:05:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="312769772"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2020 07:05:48 -0800
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 10 Feb 2020 07:05:48 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.110]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.140]) with mapi id 14.03.0439.000;
 Mon, 10 Feb 2020 07:05:48 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Thread-Topic: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Thread-Index: AQHV3hK/y2Hxis+abEWPqwm+8JRaDqgUibyAgACHXAA=
Date:   Mon, 10 Feb 2020 15:05:47 +0000
Message-ID: <3a4de58ad83a88f90f372e162c39d09eeebd8043.camel@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
         <20200210070115.GA7748@lst.de>
In-Reply-To: <20200210070115.GA7748@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.25]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ED1746FD91C894DAB3BB7F957A966A5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTEwIGF0IDA4OjAxICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gRnJpLCBGZWIgMDcsIDIwMjAgYXQgMDQ6NTk6NThQTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVGhpcyBzZXQgYWRkcyBhbiBlbXVsYXRpb24gZHJpdmVyIGZvciBQQ0ll
IEhvdHBsdWcuIFRoZXJlIG1heSBiZSBwbGF0Zm9ybXMgd2l0aA0KPiA+IHNwZWNpZmljIGNvbmZp
Z3VyYXRpb25zIHRoYXQgY2FuIHN1cHBvcnQgaG90cGx1ZyBidXQgZG9uJ3QgcHJvdmlkZSB0aGUg
bG9naWNhbA0KPiA+IHNsb3QgaG90cGx1ZyBoYXJkd2FyZS4gRm9yIGluc3RhbmNlLCB0aGUgcGxh
dGZvcm0gbWF5IHVzZSBhbg0KPiA+IGVsZWN0cmljYWxseS10b2xlcmFudCBpbnRlcnBvc2VyIGJl
dHdlZW4gdGhlIHNsb3QgYW5kIHRoZSBkZXZpY2UuDQo+IA0KPiBUaGUgY29kZSBzZWVtcyBsaWtl
IG9uZSBnaWFudCBoYWNrIHRvIG1lLiAgV2hhdCBpcyB0aGUgcmVhbCBsaWZlDQo+IHVzZSBjYXNl
IGZvciB0aGlzPyAgQW5vdGhlciBJbnRlbCBjaGlwc2V0IGZ1Y2t1cCBsaWtlIHZtZCBvciB0aGUg
YWhjaQ0KPiByZW1hcHBpbmc/DQo+IA0KRXhhY3RseSBhcyB0aGUgY292ZXIgbGV0dGVyIGRlc2Ny
aWJlcy4gQW4gaW50ZXJwb3NlciBiZWluZyB1c2VkIG9uIGENCm5vbi1ob3RwbHVnIHNsb3QuDQo=
