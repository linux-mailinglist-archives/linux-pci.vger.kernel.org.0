Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D384036C696
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhD0NAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 09:00:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24120 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236001AbhD0NAe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 09:00:34 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-127--hFiMNP-PnSmH-CCHA4ytg-1; Tue, 27 Apr 2021 13:59:47 +0100
X-MC-Unique: -hFiMNP-PnSmH-CCHA4ytg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 27 Apr 2021 13:59:46 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Tue, 27 Apr 2021 13:59:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Oliver Neukum' <oneukum@suse.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
CC:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, "Bjorn Helgaas" <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Subject: RE: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
Thread-Topic: [PATCH v2 2/2] pci: Support "removable" attribute for PCI
 devices
Thread-Index: AQHXOpI8ukue0tNuwUC9JgKnmYtYG6rGwqQQgAFxHQCAAB7esA==
Date:   Tue, 27 Apr 2021 12:59:45 +0000
Message-ID: <b5e031652f144ab6accbe553566676c9@AcuMS.aculab.com>
References: <20210424021631.1972022-1-rajatja@google.com>
         <20210424021631.1972022-2-rajatja@google.com>
         <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com>
         <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
         <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com>
 <21c6b5002c5ad36cd7fe0bb849f5eba12a614bca.camel@suse.com>
In-Reply-To: <21c6b5002c5ad36cd7fe0bb849f5eba12a614bca.camel@suse.com>
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

RnJvbTogT2xpdmVyIE5ldWt1bQ0KPiBTZW50OiAyNyBBcHJpbCAyMDIxIDEzOjAwDQo+IA0KPiBB
bSBNb250YWcsIGRlbiAyNi4wNC4yMDIxLCAxMzowMSArMDAwMCBzY2hyaWViIERhdmlkIExhaWdo
dDoNCj4gPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraQ0KPiA+ID4gU2VudDogMjYgQXByaWwgMjAy
MSAxMjo0OQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgQXByIDI2LCAyMDIxIGF0IDExOjE3IEFNIE9s
aXZlciBOZXVrdW0gPG9uZXVrdW1Ac3VzZS5jb20+IHdyb3RlOg0KPiA+ID4gPiBBbSBGcmVpdGFn
LCBkZW4gMjMuMDQuMjAyMSwgMTk6MTYgLTA3MDAgc2NocmllYiBSYWphdCBKYWluOg0KPiA+ID4g
PiA+IEV4cG9ydCB0aGUgYWxyZWFkeSBhdmFpbGFibGUgaW5mbywgdG8gdGhlIHVzZXJzcGFjZSB2
aWEgdGhlDQo+ID4gPiA+ID4gZGV2aWNlIGNvcmUsIHNvIHRoYXQgdXNlcnNwYWNlIGNhbiBpbXBs
ZW1lbnQgd2hhdGV2ZXIgcG9saWNpZXMgaXQNCj4gPiA+ID4gPiB3YW50cyB0bywgZm9yIGV4dGVy
bmFsIHJlbW92YWJsZSBkZXZpY2VzLg0KPiA+ID4gPg0KPiA+ID4gPiBIaSwNCj4gPiA+ID4NCj4g
PiA+ID4gaXMgdGhlcmUgYSB3YXkgdG8gdGVsbCBhcGFydCB3aGV0aGVyIGEgZGV2aWNlIGNhbiB1
bmRlcmdvIHJlZ3VsYXINCj4gPiA+ID4gc3VycHJpc2UgcmVtb3ZhbD8NCj4gPiA+DQo+ID4gPiBQ
Q0kgZGV2aWNlcyBsb2NhdGVkIHVuZGVyIGEgcmVtb3ZhYmxlIHBhcmVudCBjYW4gdW5kZXJnbyBz
dXJwcmlzZQ0KPiA+ID4gcmVtb3ZhbC4gIFRoZSBvbmVzIG9uIGEgVGh1bmRlcmJvbHQgY2hhaW4g
dG9vLg0KPiA+ID4NCj4gPiA+ID4gRG8gd2Ugd2FudCB0aGF0Pw0KPiA+ID4NCj4gPiA+IERvIHlv
dSBtZWFuIHN1cnByaXNlIHJlbW92YWw/ICBZZXMsIHdlIGRvLg0KPiA+DQo+ID4gQWx3YXlzIGJl
ZW4gdHJ1ZSAtIHRoaW5rIG9mIGNhcmRidXMgKFBDSSBwY21jaWEpIGNhcmRzIHdpdGgNCj4gPiBQ
Q0kgYnJpZGdlcyB0byBleHRlcm5hbCBQQ0kgZXhwYW5zaW9uIGNoYXNzaXMgY29udGFpbmluZw0K
PiA+IGFkZGl0aW9uYWwgUENJIHNsb3RzLg0KPiA+IFRoZSBjYXJkYnVzIGNhcmQgaXMgaG90IHJl
bW92YWJsZS4NCj4gDQo+IEhpLA0KPiANCj4gdGhhdCBpcyB0cnVlIGZvciB0aG9zZSBvcHRpb25z
LCBidXQgbm90IGZvciB0aGUgc3R5bGUNCj4gb2YgUENJIGhvdHBsdWcgd2hpY2ggcmVxdWlyZXMg
eW91IHRvIHB1c2ggYSBidXR0b24gYW5kIHdhaXQNCj4gZm9yIHRoZSBibGlua2luZyBsaWdodC4N
Cg0KVHJ1ZSwgSSByZW1lbWJlciBzb21lIG9mIHRob3NlIFBDSSBob3RwbHVnIGNoYXNzaXMgZnJv
bSAyNSB5ZWFycyBhZ28uDQpJU1RSIHdlIGRpZCBnZXQgdGhlIHJlbW92YWwgZXZlbnRzIHdvcmtp
bmcgKFNWUjQvVW5peHdhcmUpIGJ1dCBJDQpkb24ndCByZW1lbWJlciB0aGUgcmVsZXZhbnQgY2hh
c3NpcyBldmVyIGJlaW5nIHNvbGQuDQpJbiBzcGl0ZSBvZiB0aGUgbWFya2V0aW5nIGh5cGUgSSBz
dXNwZWN0IGl0IHdhcyBvbmx5IGV2ZXIgcG9zc2libGUNCnRvIHJlbW92ZSBhIGNvbXBsZXRlbHkg
d29ya2luZyBib2FyZCBhbmQgcmVwbGFjZSBpdCB3aXRoIGFuDQpleGFjdGx5IGVxdWl2YWxlbnQg
b25lLg0KDQpJbiBhbnkgY2FzZSB0aG9zZSBjaGFzc2lzIGFyZSBub3QgJ3N1cnByaXNlIHJlbW92
YWwnLg0KDQpNb3JlIG1vZGVybiBkcml2ZXJzIGFyZSBsZXNzIGxpa2VseSB0byBjcmFzaCAoYW5k
IGJ1cm4/KSB3aGVuDQphIFBDSSByZWFkIHJldHVybnMgfjB1Lg0KQnV0IEkgc3VzcGVjdCBhbiBh
d2Z1bCBsb3QgcmVhbGx5IGRvbid0IGhhbmRsZSBzdXJwcmlzZSByZW1vdmFsDQp2ZXJ5IHdlbGwg
YXQgYWxsLg0KDQpIb3cgbWFueSBlbnN1cmUgdGhhdCBhIH4wdSByZXNwb25zZSBmcm9tIGV2ZXJ5
IFBDSShlKSB3b250DQpjYXVzZSBzb21lIGtpbmQgb2YgZ3JpZWY/DQooV2UndmUgYmVlbiB0aGVy
ZSBkdWUgdG8gYSBidWdneSBmcGdhIG5vdCByZXNwb25kaW5nIHRvIG5vbi1jb25maWcNCmN5Y2xl
cy4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

