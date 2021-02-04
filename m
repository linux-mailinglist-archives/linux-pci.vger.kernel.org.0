Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8644F30EFCB
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhBDJgC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 04:36:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37856 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235019AbhBDJf7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 04:35:59 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-117-EX2iitf4NT-Fy2zSSa0XDQ-1; Thu, 04 Feb 2021 09:34:16 +0000
X-MC-Unique: EX2iitf4NT-Fy2zSSa0XDQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 4 Feb 2021 09:34:15 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 4 Feb 2021 09:34:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sergei Miroshnichenko' <s.miroshnichenko@yadro.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>
Subject: RE: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Topic: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Index: AQHW1WT234xzlvvTV0WAimI1cHAduao9LYkAgABgu4CACWNCAIABDjNg
Date:   Thu, 4 Feb 2021 09:34:15 +0000
Message-ID: <af516d35e51e477aa16af3e254e7cac3@AcuMS.aculab.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
         <20210128145316.GA3052488@bjorn-Precision-5520>
         <20210128203929.GB6613@wunner.de>
 <6844b9c79e784c17ff007cab187abb85e5d91608.camel@yadro.com>
In-Reply-To: <6844b9c79e784c17ff007cab187abb85e5d91608.camel@yadro.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBBY3R1YWxseSwgd2UgYXJlIGhvdHBsdWdnaW5nIG5vdCBvbmx5IGVuZHBvaW50cywgYnV0IG5l
c3RlZCBQQ0llDQo+IHN3aXRjaGVzIGFzIHdlbGw6IHRob3NlIGFyZSBQQ0llIEpCT0QgY2hhc3Np
cyAod2l0aCBOVk1lcyBhbmQgU0FTDQo+IGRyaXZlcykuDQoNCkZyb20gd2hhdCBJIHJlbWVtYmVy
IG9mIHBsYXlpbmcgd2l0aCBzb21lIFBDSSBob3QtcGx1ZyBoYXJkd2FyZQ0KYW5kIGNhcmRidXMg
ZXh0ZW5kZXJzIHRvIFBDSSBjaGFzc2lzIG1hbnkgeWVhcnMgYWdvIGJ1cyBudW1iZXJzDQp3ZXJl
IGFjdHVhbGx5IGEgYmlnIHByb2JsZW0uDQoNCkEgc3VycHJpc2luZyBudW1iZXIgb2YgaW8gY2Fy
ZHMgY29udGFpbiBhIGJyaWRnZSAtIHNvIG5lZWQgYQ0KYnVzIG51bWJlciBpZiBob3QtcGx1Z2dl
ZC4NCg0KKEluIHNwaXRlIG9mIHRoZSBtYXJrZXRpbmcgaHlwZSBob3QtcGx1ZyBiYXNpY2FsbHkg
bGV0IHlvdSByZW1vdmUNCmEgd29ya2luZyBjYXJkIGFuZCByZXBsYWNlIGl0IHdpdGggYW4gaWRl
bnRpY2FsIG9uZSENCk1vZGVybiBkcml2ZXJzIGFuZCBPUyBhcmUgbGlrZWx5IHRvIGhhbmRsZSB0
aGUgZXJyb3JzIGZyb20NCmZhdWx0eSBjYXJkcyBiZXR0ZXIuKQ0KDQpUaGUgaW5pdGlhbCBhbGxv
Y2F0aW9uIG9mIGJ1cy1udW1iZXJzIGNvdWxkIGVhc2lseSBzcHJlYWQgb3V0DQp0aGUgdW51c2Vk
IGJ1cyBudW1iZXJzLg0KRG9pbmcgdGhhdCBmb3IgbWVtb3J5IHJlc291cmNlcyBtYXkgaGF2ZSBv
dGhlciBwcm9ibGVtcw0KKFlvdSBwcm9iYWJseSBkb24ndCB3YW50IHRvIGFsbG9jYXRlIHRoZSBl
bnRpcmUgcmFuZ2UgdG8gdGhlDQpyb290IGh1Yj8pDQoNCkFyZSB0aGUgYnVzIG51bWJlcnMgZXhw
b3NlZCBhcyBrZXlzL2ZpbGVuYW1lIGluIC9zeXMgPw0KSW4gd2hpY2ggY2FzZSBjaGFuZ2luZyB0
aGVtIGFmdGVyIGJvb3QgaXMgcHJvYmxlbWF0aWMuDQpZb3UnZCBuZWVkIGEgbWFwIG9mIHZpcnR1
YWwgYnVzIG51bWJlcnMgdG8gcGh5c2ljYWwgb25lcy4NCg0KQXMgd2VsbCBhcyB5b3VyICdzdXNw
ZW5kL3Jlc3VtZScgc2VxdWVuY2UsIGl0IHNob3VsZA0KYmUgcG9zc2libGUgdG8gc2VuZCBhIGNh
cmQtcmVtb3ZlL2luc2VydCBzZXF1ZW5jZSB0bw0KYW4gaWRsZSBkcml2ZXIuDQoNClRoZXJlIGlz
IGFub3RoZXIgY2FzZSB3ZXJlIEJBUnMgbWlnaHQgbmVlZCBtb3ZpbmcuDQpUaGUgUENJZSBzcGVj
IGRvZXNuJ3QgYWxsb3cgdmVyeSBsb25nICgyMDBtcz8pIGZyb20NCnJlc2V0IHJlbW92YWwgKHdo
aWNoIG1pZ2h0IGJlIGNsb3NlIHRvIHBvd2VyIG9uKSBhbmQNCnRoZSByZXF1aXJlbWVudCBmb3Ig
ZW5kcG9pbnRzIHRvIGFuc3dlciBjb25maWcgY3ljbGVzLg0KSWYgeW91IGhhdmUgdG8gbG9hZCBh
IGxhcmdlIEZQR0EgZnJvbSBhIHNlcmlhbCBFRVBST00NCnRoaXMgaXMgYWN0dWFsbHkgYSByZWFs
IHByb2JsZW0uDQpTbyBpZiB0aGUgT1MgZG9lcyBhIGZ1bGwgcHJvYmUgb2YgdGhlIFBDSSBkZXZp
Y2VzIGl0IG1heQ0KZmluZCBlbmRwb2ludHMgKG9yIGV2ZW4gYnJpZGdlcykgdGhhdCB3ZXJlbid0
IGFjdHVhbGx5IHRoZXJlDQp3aGVuIHRoZSBCSU9TIChvciBlcXVpdmFsZW50KSBkaWQgaXRzIGVh
cmxpZXIgcHJvYmUuDQpGaW5kaW5nIHNwYWNlIGluIHRoZSBtaWRkbGUgb2YgdGhlIHBjaSBkZXZp
Y2VzIGZvciBhbiBlbmRwb2ludA0KdGhhdCB3YW50cyB0d28gMU1CIEJBUnMgaXMgdW5saWtlbHkg
dG8gc3VjZWVkIQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

