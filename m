Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9D51B4FFE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgDVWR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 18:17:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:64695 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVWR6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 18:17:58 -0400
IronPort-SDR: /j94CWv1mVZyaUG5rxsfxuD9S/lZ14CRcT0+7OLku89IQGy9iKd9hL4vzOnvsQA42RtQzljivi
 lwhDukktWVkA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 15:17:58 -0700
IronPort-SDR: p1Ujg028c0lEOtoOttEuV1B4Ci6ZYBuIeJr51EE8NcHpOqSLEvo26mU61JJyGMSAfakGOKq/1R
 UiNBPa6rxSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="255788029"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2020 15:17:58 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Apr 2020 15:17:57 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.34]) with mapi id 14.03.0439.000;
 Wed, 22 Apr 2020 15:17:57 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Jakowski, Andrzej" <andrzej.jakowski@intel.com>
Subject: Re: [PATCH for QEMU] hw/vfio: Add VMD Passthrough Quirk
Thread-Topic: [PATCH for QEMU] hw/vfio: Add VMD Passthrough Quirk
Thread-Index: AQHWGMtyZw4X1Uq3s0+HhumXVtYMzKiGH9SAgAALrAA=
Date:   Wed, 22 Apr 2020 22:17:56 +0000
Message-ID: <48e2ef3f6f843d533e4f3cdb83da9be5184768e6.camel@intel.com>
References: <158759136841.3922.4821101148440128786@39012742ff91>
In-Reply-To: <158759136841.3922.4821101148440128786@39012742ff91>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.7.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC102D38D2895946AC9731BC742461CF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTIyIGF0IDE0OjM2IC0wNzAwLCBuby1yZXBseUBwYXRjaGV3Lm9yZyB3
cm90ZToNCj4gUGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMjE3
MTMwNS4xMDkyMy0xLWpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tLw0KPiANCj4gDQo+IA0KPiBI
aSwNCj4gDQo+IFRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2Ug
ZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQNCj4gdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5
b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdA0K
PiBsb2NhbGx5Lg0KPiANCj4gPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQ0KPiAjIS9iaW4vYmFz
aA0KPiBleHBvcnQgQVJDSD14ODZfNjQNCj4gbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTENCj4gdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQ0KPiA9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQ0KPiANCj4gICBDQyAgICAgIHFlbXUtaW8tY21kcy5vDQo+ICAgQ0MgICAgICByZXBsaWNhdGlv
bi5vDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBody92ZmlvL3RyYWNlLmM6NToNCj4gL3RtcC9x
ZW11LXRlc3QvYnVpbGQvaHcvdmZpby90cmFjZS5oOjIzNDg6MTIwOiBlcnJvcjogZXhwZWN0ZWQg
JyknDQo+ICAgICAgICAgcWVtdV9sb2coIiVkQCV6dS4lMDZ6dTp2ZmlvX3BjaV92bWRfcXVpcmtf
c2hhZG93X3JlZ3MgIiAiJXMgbWVtYmFyMV9waHlzPTB4JSJQUkl4NjQiIG1lbWJhcjJfcGh5cz0w
eCUiUFJJeDY0IiAiXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gDQoNCkl0J3MgdGhlIGV4dHJhICIgYXQgdGhl
IGVuZCwgd2hpY2ggd2lsbCBiZSBmaXhlZCBpbiB2Mg0KVGhhbmtzIGZvciB0aGUgc2FuaXR5IGNo
ZWNrDQoNCg==
