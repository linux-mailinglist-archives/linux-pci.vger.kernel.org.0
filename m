Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E6104084
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfKTQRN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 11:17:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:30407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfKTQRN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 11:17:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 08:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="289992131"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2019 08:16:41 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.246]) with mapi id 14.03.0439.000;
 Wed, 20 Nov 2019 08:16:41 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/2] VMD support for 8086:9A0B
Thread-Topic: [PATCH v2 0/2] VMD support for 8086:9A0B
Thread-Index: AQHVmYoDl/LKsx+9J06UxSW6m9PJ2qeUzs0A
Date:   Wed, 20 Nov 2019 16:16:40 +0000
Message-ID: <b07f1c8a3089f0b4aa43004ccf9131f407b63a7d.camel@intel.com>
References: <1573562873-96828-1-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1573562873-96828-1-git-send-email-jonathan.derrick@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.147]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EA09DD708A4424EBB626546775A937F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTEyIGF0IDA1OjQ3IC0wNzAwLCBKb24gRGVycmljayB3cm90ZToNCj4g
VGhpcyBzZXQgYWRkcyBWTUQgc3VwcG9ydCBmb3IgZGV2aWNlIDgwODY6OUEwQi4gVGhlIGZpcnN0
IHBhdGNoIGFkZHMNCj4gYW5vdGhlciBidXMgcmFuZ2UgcmVzdHJpY3Rpb24gYW5kIHRoZSBzZWNv
bmQgcGF0Y2ggYWRkcyB0aGUgZGV2aWNlIGlkLg0KPiANCj4gdjEtPnYyOg0KPiBSZXdvcmRlZCBh
bWJpZ3VvdXMgY29tbWl0IG1lc3NhZ2UgdG8gbWF0Y2ggY29kZSBjb21tZW50DQo+IENvZGluZyBz
dHlsZSBmaXhlcw0KPiANCj4gSm9uIERlcnJpY2sgKDIpOg0KPiAgIFBDSTogdm1kOiBBZGQgYnVz
IDIyNC0yNTUgcmVzdHJpY3Rpb24gZGVjb2RlDQo+ICAgUENJOiB2bWQ6IEFkZCBkZXZpY2UgaWQg
Zm9yIFZNRCBkZXZpY2UgODA4Njo5QTBCDQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci92
bWQuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICBpbmNsdWRlL2xp
bnV4L3BjaV9pZHMuaCAgICAgIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCg0KQW55IGlzc3VlcyB3aXRoIHRoZXNlPw0K
