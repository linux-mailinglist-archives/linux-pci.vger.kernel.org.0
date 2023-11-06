Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB537E1CBA
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 09:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjKFI4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 03:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjKFI4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 03:56:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E62EA
        for <linux-pci@vger.kernel.org>; Mon,  6 Nov 2023 00:56:42 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-mxgNysgyOKm726Ww5FXCrQ-1; Mon, 06 Nov 2023 08:56:39 +0000
X-MC-Unique: mxgNysgyOKm726Ww5FXCrQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 6 Nov
 2023 08:56:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 6 Nov 2023 08:56:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'David Epping' <david.epping@missinglinkelectronics.com>,
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
Thread-Index: AQHaC+rcwX/RJWhaCEGpb3NmFV615LBrmEmQgAFpulA=
Date:   Mon, 6 Nov 2023 08:56:38 +0000
Message-ID: <11dfbc12d3b8451aad1226d185d44228@AcuMS.aculab.com>
References: <ZUDd04c7FXUeusxK@nucnuc.mle>
 <fd407621b4a64cebaf8a847b3ff1ad2e@AcuMS.aculab.com>
In-Reply-To: <fd407621b4a64cebaf8a847b3ff1ad2e@AcuMS.aculab.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDA1IE5vdmVtYmVyIDIwMjMgMTE6MjANCj4gDQo+
IEZyb206IERhdmlkIEVwcGluZw0KPiA+IFNlbnQ6IDMxIE9jdG9iZXIgMjAyMyAxMDo1OA0KPiA+
DQo+ID4gSGVsbG8gQVJNIFBDSWUgYW5kIGVzcGVjaWFsbHkgSW50ZWwgQWx0ZXJhIFNPQ0ZQR0Eg
bWFpbnRhaW5lcnMsDQo+ID4NCj4gPiB0aGUgSW50ZWwgQWx0ZXJhIEN5Y2xvbmUgViBQQ0llIFJv
b3QgQ29tcGxleCBkcml2ZXJzIGFmYWlrIGN1cnJlbnRseQ0KPiA+IGRvbuKAmXQgc3VwcG9ydCBz
ZW5kaW5nIElPIFRMUHMuDQo+ID4gVGhlIFJvb3QgQ29tcGxleCBJUCBDb3JlLCBzZWVtaW5nbHkg
dW5saWtlIG1hbnkgb3RoZXIgQVJNIFJvb3QgQ29tcGxleGVzLA0KPiANCj4gSXQgaXNuJ3QgYW4g
QVJNIHJvb3QgY29tcGxleCAuLi4NCj4gSSBkaWRuJ3QgdGhpbmsgYW55IG9mIHRoZSBDeWNsb25l
IFYgaGFkIGVtYmVkZGVkIGFybSBjcHUuDQo+IEkga25vdyBzb21lIG9mIHRoZSBtb3JlIHJlY2Vu
dCBBbHRlcmEgRlBHQSBkbywgYnkgdGhlIEN5Y2xvbmUgVg0KPiBpcyBwcmV0dHkgb2xkIG5vdyAt
IGFsdGhvdWdoIHdlIGFyZSBzdGlsbCB1c2luZyB0aGVtIGluIG5ldyBjYXJkcy4NCj4gKE9ubHkg
YXMgUENJZSBlbmRwb2ludHMgdGhvdWdoLikNCj4gDQo+ID4gZG9lcyBub3Qgb2ZmZXIgYSBtZW1v
cnkgbWFwcGluZyBmb3IgdGhlIElPIGFkZHJlc3Mgc3BhY2UsIGJ1dCBpbnN0ZWFkIHJlbGllcw0K
PiA+IG9uIGluZGlyZWN0IGFkZHJlc3NpbmcgdmlhIGFkZHJlc3MgYW5kIGRhdGEgcmVnaXN0ZXJz
Lg0KPiANCj4gSWYgeW91IGFyZSBidWlsZGluZyB0aGUgRlBHQSBpbWFnZSB0aGVuIGFsbCB0aGUg
bG9naWMgdG8gY29udmVydCB0aGUNCj4gbWVtb3J5IG1hcHBlZCBzbGF2ZSBjeWNsZXMgKGludG8g
dGhlIGZwZ2EgbG9naWMpIGlzIHN1cHBsaWVkIGFzDQo+IHZlcmlsb2cgc291cmNlLg0KPiBTbyB5
b3Ugc2hvdWxkIGJlIGFibGUgdG8gJ2ZpeCcgaXQgZG8gZ2VuZXJhdGUgSU8gVExQIGluc3RlYWQg
b2YgZGF0YQ0KPiBUTFAgZm9yIGNlcnRhaW4gYWRkcmVzc2VzLg0KPiAoQSBmZXcgeWVhcnMgYmFj
ayB3ZSBoYWQgdG8gZml4IGl0IHRvIGNvcnJlY3RseSBwcm9jZXNzIG11bHRpcGxlDQo+IGRhdGEg
VExQIGluIHJlc3BvbnNlIHRvIGEgc2luZ2xlIHJlYWQgVExQIC0gbm90IGEgcHJvYmxlbSBub3cu
KQ0KDQpBbm90aGVyIGlkZWEgd291bGQgdG8gYmUgdG8gd3JpdGUgYW4gQXZhbG9uIHNsYXZlIHRo
YXQgY29udmVydHMNCmEgc2luZ2xlIHJlYWQvd3JpdGUgaW50byB0aGUgcmVxdWlyZWQgc2VxdWVu
Y2Ugb2YgdHJhbnNmZXJzIGludG8gdGhlDQpjeWNsb25lIFYgUENJZSBibG9jayB0byBnZW5lcmF0
ZSB0aGUgSU8gVExQIGZyb20gYSBjcHUgbWVtb3J5IGFjY2Vzcy4NClRoYXQgaXNuJ3QgaGFyZCB0
byB3cml0ZS4NCg0KSXQgd291bGQgYWxzbyBsZXQgeW91IGltcGxlbWVudCBwb3N0ZWQgd3JpdGVz
IGFuZCBhc3luY2hyb25vdXMgcmVhZHMuDQpBbHRob3VnaCB0aGUgZHJpdmVycyB3b24ndCBleHBl
Y3QgYXN5bmMgcmVhZHMgdGhlIFBDSWUgaXMgc2xvdw0KZW5vdWdoIHRoYXQgdGhleSByZWFsbHkg
ZG8gbWFrZSBzZW5zZS4NCg0KSW4gbXkgbWVhc3VyZW1lbnRzIGEgQ3ljbG9uZSBWIGVuZHBvaW50
ICh0aGUgcm9vdCB3aWxsIGJlIG11Y2ggdGhlDQpzYW1lKSB0YWtlcyBhYm91dCAxMjggY2xvY2tz
IChvZiB0aGUgMTI1TUh6IFBDSWUgY2xvY2spIHRvIHByb2Nlc3MNCmFuIGluY29taW5nIHJlYWQg
VExQLg0KVGhpcyBzdGFsbHMgYSAzR0h6IGhvc3QgZm9yIGFib3V0IDMwMDAgY2xvY2tzLg0KSUlS
QyB0aGUgdGltZSBmb3IgYW4gb3V0Z29pbmcgcmVhZCBpcyBtdWNoIHRoZSBzYW1lLCB0aGUgbG9j
YWwNCmNwdSB3aWxsIGJlIHNsb3dlciAob3VycyBhcmUgNjIuNU1IeiBOaW9zKSBidXQgaXQgaXMg
c3RpbGwNCnNpZ25pZmljYW50Lg0KDQpNb3N0IG9mIHRoZSBQQ0llIHRyYW5zZmVycyB3ZSBkbyBh
cmUgZnJvbSBhIGxvY2FsbHkgd3JpdHRlbg0KbXVsdGktY2hhbm5lbCBETUEgYmxvY2sgdGhhdCBn
ZW5lcmF0ZXMgMTI4Ynl0ZSBUTFAuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

