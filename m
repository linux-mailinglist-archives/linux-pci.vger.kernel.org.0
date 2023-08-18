Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0492C780709
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358553AbjHRIWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358586AbjHRIV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 04:21:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF212D7E
        for <linux-pci@vger.kernel.org>; Fri, 18 Aug 2023 01:21:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-94-jdFtRMMNMtSgqSB6x-RgDA-1; Fri, 18 Aug 2023 09:21:52 +0100
X-MC-Unique: jdFtRMMNMtSgqSB6x-RgDA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 18 Aug
 2023 09:21:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 18 Aug 2023 09:21:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v13 01/12] PCI: Only put Intel PCIe ports >= 2015 into D3
Thread-Topic: [PATCH v13 01/12] PCI: Only put Intel PCIe ports >= 2015 into D3
Thread-Index: AQHZ0aviY0yNhl4nokiZHvlSG8ejsq/vtbRQ
Date:   Fri, 18 Aug 2023 08:21:49 +0000
Message-ID: <106803fab8da4648a6881991c7f37214@AcuMS.aculab.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-2-mario.limonciello@amd.com>
 <CAJZ5v0iHvbbNBnwb-RKvcBaFR8VMGyGt--b6RmbUmwuzcBZKnQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHvbbNBnwb-RKvcBaFR8VMGyGt--b6RmbUmwuzcBZKnQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogUmFmYWVsIEouIFd5c29ja2kNCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTgsIDIwMjMg
OToxMiBBTQ0KPiANCj4gT24gRnJpLCBBdWcgMTgsIDIwMjMgYXQgNzoxNOKAr0FNIE1hcmlvIExp
bW9uY2llbGxvDQo+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+
IGNvbW1pdCA5ZDI2ZDNhOGYxYjAgKCJQQ0k6IFB1dCBQQ0llIHBvcnRzIGludG8gRDMgZHVyaW5n
IHN1c3BlbmQiKQ0KPiA+IGNoYW5nZWQgcGNpX2JyaWRnZV9kM19wb3NzaWJsZSgpIHNvIHRoYXQg
YW55IHZlbmRvcidzIFBDSWUgcG9ydHMNCj4gPiBmcm9tIG1vZGVybiBtYWNoaW5lcyAoPj0yMDE1
KSBhcmUgYWxsb3dlZCB0byBiZSBwdXQgaW50byBEMy4NCj4gPg0KPiA+IElhaW4gcmVwb3J0cyB0
aGF0IFVTQiBkZXZpY2VzIGNhbid0IGJlIHVzZWQgdG8gd2FrZSBhIExlbm92byBaMTMNCj4gPiBm
cm9tIHN1c3BlbmQuIFRoaXMgaXMgYmVjYXVzZSB0aGUgUENJZSByb290IHBvcnQgaGFzIGJlZW4g
cHV0DQo+ID4gaW50byBEMyBhbmQgQU1EJ3MgcGxhdGZvcm0gY2FuJ3QgaGFuZGxlIFVTQiBkZXZp
Y2VzIHdha2luZyBpbiB0aGlzDQo+ID4gY2FzZS4NCj4gPg0KLi4uDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kvcGNpLmMNCj4gPiBpbmRleCA2MDIzMGRh
OTU3ZTBjLi4wNTFlODhlZTY0YzYzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaS5j
DQo+ID4gKysrIGIvZHJpdmVycy9wY2kvcGNpLmMNCj4gPiBAQCAtMzAzNywxMCArMzAzNywxMSBA
QCBib29sIHBjaV9icmlkZ2VfZDNfcG9zc2libGUoc3RydWN0IHBjaV9kZXYgKmJyaWRnZSkNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiAgICAgICAg
ICAgICAgICAgLyoNCj4gPiAtICAgICAgICAgICAgICAgICogSXQgc2hvdWxkIGJlIHNhZmUgdG8g
cHV0IFBDSWUgcG9ydHMgZnJvbSAyMDE1IG9yIG5ld2VyDQo+ID4gKyAgICAgICAgICAgICAgICAq
IEl0IGlzIHNhZmUgdG8gcHV0IEludGVsIFBDSWUgcG9ydHMgZnJvbSAyMDE1IG9yIG5ld2VyDQo+
ID4gICAgICAgICAgICAgICAgICAqIHRvIEQzLg0KPiA+ICAgICAgICAgICAgICAgICAgKi8NCj4g
DQo+IEkgd291bGQgc2F5ICJBbGxvdyBJbnRlbCBQQ0llIHBvcnRzIGZyb20gMjAxNSBvbndhcmQg
dG8gZ28gaW50byBEMyB0bw0KPiBhY2hpZXZlIGFkZGl0aW9uYWwgZW5lcmd5IGNvbnNlcnZhdGlv
biBvbiBzb21lIHBsYXRmb3JtcyIgd2l0aG91dCB0aGUNCj4gIkl0IGlzIHNhZmUiIHBhcnQgdGhh
dCBpcyBraW5kIG9mIG9idmlvdXMgKGl0IHdvdWxkbid0IGJlIGRvbmUgaWYgaXQNCj4gd2VyZSB1
bnNhZmUpLg0KDQpKdXN0IHNheSB3aHkuLi4NCg0KIkRvbid0IHB1dCByb290IHBvcnRzIGludG8g
RDMgb24gbm9uLUludGVsIHN5c3RlbXMgdG8gYXZvaWQgaXNzdWVzDQp3aXRoIFVTQiBkZXZpY2Vz
IGJlaW5nIHVuYWJsZSB0byB3YWtlIHVwIHNvbWUgQU1EIGJhc2VkIGxhcHRvcHMuIg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

