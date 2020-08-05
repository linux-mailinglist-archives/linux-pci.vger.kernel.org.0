Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8570323CBC9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHEPpf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 11:45:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:64502 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgHEPkr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 11:40:47 -0400
IronPort-SDR: iungMxntL79sPHxL2sV3Zs8CRAgB7Ix3w5iPKrOV1FROhU2sqyLMKifBZ4yy4GQ9wlDiWCTy8l
 2YDkL8TKfWjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="214096488"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="214096488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 08:30:01 -0700
IronPort-SDR: 94qWMKUQFeyKjw08rseu7VO8G71WTlqDwzixd/GygvvyZcSJv/E4rJ5Mi7WVR3gaRpIbZCGZq5
 TPeQucCdOJ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="493321467"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2020 08:30:01 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 08:30:01 -0700
Received: from orsmsx107.amr.corp.intel.com (10.22.240.5) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 08:30:01 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.158]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.70]) with mapi id 14.03.0439.000;
 Wed, 5 Aug 2020 08:30:00 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] PCI: vmd: Allow VMD PM to use PCI core PM code
Thread-Topic: [PATCH] PCI: vmd: Allow VMD PM to use PCI core PM code
Thread-Index: AQHWZ2DMvLKu8hekmkeNJCwhOBvOzqkpodkAgAB/SQA=
Date:   Wed, 5 Aug 2020 15:30:00 +0000
Message-ID: <31275a25f29cad2fbda49f94839e128afc15acee.camel@intel.com>
References: <20200731171544.6155-1-jonathan.derrick@intel.com>
         <7a46dec4-20a4-27d4-ae3d-f428608813e4@canonical.com>
In-Reply-To: <7a46dec4-20a4-27d4-ae3d-f428608813e4@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.27.177]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E711E9B1A61CB4FAEE6A83CBE6037EF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTA1IGF0IDE1OjU0ICswODAwLCBZb3UtU2hlbmcgWWFuZyB3cm90ZToN
Cj4gT24gMjAyMC0wOC0wMSAwMToxNSwgSm9uIERlcnJpY2sgd3JvdGU6DQo+ID4gVGhlIHBjaV9z
YXZlX3N0YXRlIGNhbGwgaW4gdm1kX3N1c3BlbmQgY2FuIGJlIHBlcmZvcm1lZCBieQ0KPiA+IHBj
aV9wbV9zdXNwZW5kX2lycS4gVGhpcyBhbGxvd3MgdGhlIGNhbGwgdG8gcGNpX3ByZXBhcmVfdG9f
c2xlZXAgaW50bw0KPiA+IEFTUE0gZmxvdy4NCj4gPiANCj4gPiBUaGUgcGNpX3Jlc3RvcmVfc3Rh
dGUgY2FsbCBpbiB2bWRfcmVzdW1lIHdhcyByZXN0b3Jpbmcgc3RhdGUgYWZ0ZXINCj4gPiBwY2lf
cG1fcmVzdW1lLT5wY2lfcmVzdG9yZV9zdGFuZGFyZF9jb25maWcgaGFkIGFscmVhZHkgcmVzdG9y
ZWQgc3RhdGUuDQo+ID4gSXQncyBhbHNvIGJlZW4gc3VzcGVjdGVkIHRoYXQgdGhlIGNvbmZpZyBz
dGF0ZSBzaG91bGQgYmUgcmVzdG9yZWQgYmVmb3JlDQo+ID4gcmUtcmVxdWVzdGluZyBJUlFzLg0K
PiA+IA0KPiA+IFJlbW92ZSB0aGUgcGNpX3tzYXZlLHJlc3RvcmV9X3N0YXRlIGNhbGxzIGluIHZt
ZF97c3VzcGVuZCxyZXN1bWV9IGluDQo+ID4gb3JkZXIgdG8gYWxsb3cgcHJvcGVyIGZsb3cgdGhy
b3VnaCBQQ0kgY29yZSBwb3dlciBtYW5hZ2VtZW50IEFTUE0gY29kZS4NCj4gDQo+IEkgaGFkIGEg
dHJ5IG9uIHRoaXMgcGF0Y2ggYnV0IGBsc3BjaWAgc3RpbGwgc2hvd3MgQVNQTSBEaXNhYmxlZC4N
Cj4gQW55dGhpbmcgcHJlcmVxdWlzaXRlIG1pc3NpbmcgaGVyZT8NCj4gDQoNCklzIGVuYWJsaW5n
IEwwcy9MMS9ldGMgb24gYSBkZXZpY2Ugc29tZXRoaW5nIHRoYXQgdGhlIGRyaXZlciBzaG91bGQg
YmUNCmRvaW5nPw0KDQpEb2VzIHRoZSBzdGF0ZSBjaGFuZ2Ugd2l0aCBwY2llX2FzcG0ucG9saWN5
PXBvd2Vyc2F2ZSA/DQoNCg0KPiBZb3UtU2hlbmcgWWFuZw0KPiANCg==
