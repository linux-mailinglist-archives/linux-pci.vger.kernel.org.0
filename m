Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6997E131D
	for <lists+linux-pci@lfdr.de>; Sun,  5 Nov 2023 12:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjKELUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Nov 2023 06:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKELUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Nov 2023 06:20:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC729DE
        for <linux-pci@vger.kernel.org>; Sun,  5 Nov 2023 03:20:07 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-208-_gyjXBTTOsWWsWRWtT5SRQ-1; Sun, 05 Nov 2023 11:20:04 +0000
X-MC-Unique: _gyjXBTTOsWWsWRWtT5SRQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 5 Nov
 2023 11:20:03 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 5 Nov 2023 11:20:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Epping' <david.epping@missinglinkelectronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
Subject: RE: mach-socfpga: PCIe Root IO TLP support for Cyclone V
Thread-Topic: mach-socfpga: PCIe Root IO TLP support for Cyclone V
Thread-Index: AQHaC+rcwX/RJWhaCEGpb3NmFV615LBrmEmQ
Date:   Sun, 5 Nov 2023 11:20:03 +0000
Message-ID: <fd407621b4a64cebaf8a847b3ff1ad2e@AcuMS.aculab.com>
References: <ZUDd04c7FXUeusxK@nucnuc.mle>
In-Reply-To: <ZUDd04c7FXUeusxK@nucnuc.mle>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogRGF2aWQgRXBwaW5nDQo+IFNlbnQ6IDMxIE9jdG9iZXIgMjAyMyAxMDo1OA0KPiANCj4g
SGVsbG8gQVJNIFBDSWUgYW5kIGVzcGVjaWFsbHkgSW50ZWwgQWx0ZXJhIFNPQ0ZQR0EgbWFpbnRh
aW5lcnMsDQo+IA0KPiB0aGUgSW50ZWwgQWx0ZXJhIEN5Y2xvbmUgViBQQ0llIFJvb3QgQ29tcGxl
eCBkcml2ZXJzIGFmYWlrIGN1cnJlbnRseQ0KPiBkb27igJl0IHN1cHBvcnQgc2VuZGluZyBJTyBU
TFBzLg0KPiBUaGUgUm9vdCBDb21wbGV4IElQIENvcmUsIHNlZW1pbmdseSB1bmxpa2UgbWFueSBv
dGhlciBBUk0gUm9vdCBDb21wbGV4ZXMsDQoNCkl0IGlzbid0IGFuIEFSTSByb290IGNvbXBsZXgg
Li4uDQpJIGRpZG4ndCB0aGluayBhbnkgb2YgdGhlIEN5Y2xvbmUgViBoYWQgZW1iZWRkZWQgYXJt
IGNwdS4NCkkga25vdyBzb21lIG9mIHRoZSBtb3JlIHJlY2VudCBBbHRlcmEgRlBHQSBkbywgYnkg
dGhlIEN5Y2xvbmUgVg0KaXMgcHJldHR5IG9sZCBub3cgLSBhbHRob3VnaCB3ZSBhcmUgc3RpbGwg
dXNpbmcgdGhlbSBpbiBuZXcgY2FyZHMuDQooT25seSBhcyBQQ0llIGVuZHBvaW50cyB0aG91Z2gu
KQ0KDQo+IGRvZXMgbm90IG9mZmVyIGEgbWVtb3J5IG1hcHBpbmcgZm9yIHRoZSBJTyBhZGRyZXNz
IHNwYWNlLCBidXQgaW5zdGVhZCByZWxpZXMNCj4gb24gaW5kaXJlY3QgYWRkcmVzc2luZyB2aWEg
YWRkcmVzcyBhbmQgZGF0YSByZWdpc3RlcnMuDQoNCklmIHlvdSBhcmUgYnVpbGRpbmcgdGhlIEZQ
R0EgaW1hZ2UgdGhlbiBhbGwgdGhlIGxvZ2ljIHRvIGNvbnZlcnQgdGhlDQptZW1vcnkgbWFwcGVk
IHNsYXZlIGN5Y2xlcyAoaW50byB0aGUgZnBnYSBsb2dpYykgaXMgc3VwcGxpZWQgYXMNCnZlcmls
b2cgc291cmNlLg0KU28geW91IHNob3VsZCBiZSBhYmxlIHRvICdmaXgnIGl0IGRvIGdlbmVyYXRl
IElPIFRMUCBpbnN0ZWFkIG9mIGRhdGENClRMUCBmb3IgY2VydGFpbiBhZGRyZXNzZXMuDQooQSBm
ZXcgeWVhcnMgYmFjayB3ZSBoYWQgdG8gZml4IGl0IHRvIGNvcnJlY3RseSBwcm9jZXNzIG11bHRp
cGxlDQpkYXRhIFRMUCBpbiByZXNwb25zZSB0byBhIHNpbmdsZSByZWFkIFRMUCAtIG5vdCBhIHBy
b2JsZW0gbm93LikNCg0KLi4uDQo+IFRvIHN1cHBvcnQgYW4gQVg5OTEwMCBlbmRwb2ludCAod2hp
Y2ggcmVxdWlyZXMgSU8gQkFScyBmb3Igc29tZSBvZiBpdHMgZmVhdHVyZXMpDQoNCkkgdGhvdWdo
dCB0aGF0IGFsbCByZWNlbnQgZW5kcG9pbnRzIHdlcmUgcmVxdWlyZWQgWzFdIHRvIHdvcmsgd2l0
aA0KanVzdCBtZW1vcnkgQkFScyAtIGV2ZW4gZ29pbmcgYmFjayB0byB0aGUgbGF0ZXIgUENJIHZl
cnNpb25zLg0KU28gSSdtIHN1cnByaXNlZCBhIFBDSWUgZW5kcG9pbnQgbmVlZCBhbiBJTyBCQVIu
DQoNCglEYXZpZA0KDQpbMV0gd2VsbCBzdHJvbmdseSBpbXBsaWVkIHRoYXQgaXQgd2FzIGEgcmVh
bGx5IGdvb2QgaWRlYSA6LSkNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

