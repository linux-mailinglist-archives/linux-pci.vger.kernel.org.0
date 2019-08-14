Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52EE8D51C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNNkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 09:40:01 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:37952 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfHNNkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2019 09:40:01 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 09:40:01 EDT
IronPort-SDR: empYqsDDpfPL0FZ7aLvdd6wptwPOiYVsVjLlHUWTGkFyl/sCNeEipgjT2hqCZHmo5XvHX7oDV3
 g1J3HayDxo8bMJjNAamalm2+4bxR14MuN6c1WbJJ47sAqxtCVltangW8uQE9RaoWTCp7db24Ye
 u5IIIaN4OwF0Hte+gCIx1JRyaHV9hIBL2yN/7aeJxfXXE255TQUAProUdGN5QwvbBX441yevGR
 wIGI41C3BCjOVRGoHGQ064P6TwIrZRTmOnxWe4tCuQcCnqm+h1TpTPqfx+SuwRDgQoFfoN8wPv
 62E=
X-IronPort-AV: E=Sophos;i="5.64,385,1559548800"; 
   d="scan'208";a="42250322"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 14 Aug 2019 05:32:54 -0800
IronPort-SDR: Nwk2ypDHsIOB/YPEqXqwelYn4OpbW62jm5Od77HGnrAEpvX43FLJFpxiW859FTR7aoz0Fd5uAj
 YESTmnNyEX+R1syDRQK5Op/UvRdefB2WJDsGkS37fYjSGmzyHxMkCqtyuXUlDFlyZX4Fszn7zD
 wBv1kQFyIcpK+3EwJcr2IcFcgemtxpvh3Ak8ROh5nEfCOyuy8/JQ240N5blPzr2fEkdMQX9ROS
 +ULoJWi9kyjfsMomg86VLmQF/Sz2jmQ3Dz3bpZk+y9Z+i+ia1B4i5ulZyY1nsOfnmY1UgfUzp5
 mj4=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: AW: [PATCH] usb: xhci-pci: reorder removal to avoid use-after-free
Thread-Topic: [PATCH] usb: xhci-pci: reorder removal to avoid use-after-free
Thread-Index: AQHVUpSXBvBKq97fNkaS50QUUgX/8qb6iOeAgAAZUcA=
Date:   Wed, 14 Aug 2019 13:32:49 +0000
Message-ID: <29aadcf136bb4d5285afb4fc5b500b49@SVR-IES-MBX-03.mgc.mentorg.com>
References: <1565782781938.37795@mentor.com>
 <15aa45c7-6e45-d03f-9336-4291f8b2dc66@redhat.com>
In-Reply-To: <15aa45c7-6e45-d03f-9336-4291f8b2dc66@redhat.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+IE9uIGRyaXZlciByZW1vdmFsLCB0aGUgcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIgY2Fs
bA0KPiA+IGF0dGFjaGVkIHRocm91Z2ggZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0IHdhcyBleGVj
dXRlZA0KPiA+IGFmdGVyIHVzYl9oY2RfcGNpX3JlbW92ZS4NCj4gPiBUaGlzIGxlYWQgdG8gYSB1
c2UtYWZ0ZXItZnJlZSBmb3IgdGhlIGlvbWVtIHJlc29yY2Ugb2YNCj4gPiB0aGUgeGhjaS1leHQt
Y2FwcyBkcml2ZXIgaW4gdGhlIHBsYXRmb3JtIHJlbW92YWwNCj4gPiBiZWNhdXNlIHRoZSBwYXJl
bnQgb2YgdGhlIHJlc291cmNlIHdhcyBmcmVlZCBlYXJsaWVyLg0KPiA+DQo+ID4gRml4IHRoaXMg
YnkgcmVvcmRlcmluZyBvZiB0aGUgcmVtb3ZhbCBzZXF1ZW5jZS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENhcnN0ZW4gU2NobWlkIDxjYXJzdGVuX3NjaG1pZEBtZW50b3IuY29tPg0KPiANCj4g
QXNzdW1pbmcgdGhpcyBoYXMgYmVlbiB0ZXN0ZWQsIG92ZXJhbCB0aGlzIGxvb2tzIGdvb2QgdG8g
bWUuDQoNClRlc3RlZCBvbiA0LjE0LjEyOSwgcG9ydGVkIHRvIHY1LjIuNywgY29tcGlsZWQgdGhl
cmUuDQoNCj4gDQo+IEJ1dCB0aGVyZSBhcmUgMiB0aGluZ3MgdG8gZml4Og0KPiANCj4gMSkgTWF5
YmUgcGljayBhIG1vcmUgZGVzY3JpcHRpdmUgc3RydWN0IG1lbWJlciBuYW1lIHRoZW4gcGRldi4N
Cj4gICAgIHBkZXYgd2l0aCBwY2ktZGV2aWNlcyBvZnRlbiBwb2ludHMgdG8gYSBwY2lfZGV2aWNl
IC4uLg0KPiAgICAgSG93IGFib3V0OiByb2xlX3N3aXRjaF9wZGV2ID8NCg0KT2ssIGdvb2QgcG9p
bnQuIEhhZCBwbGF0Zm9ybSBkZXYgcGRldiBpbiBtaW5kIC4uLg0KDQo+IA0KPiAyKSB4aGNpX2V4
dF9jYXBfaW5pdCgpIGlzIG5vdCB0aGUgbGFzdCBjYWxsIHdoaWNoIGNhbiBmYWlsIGluDQo+ICAg
ICB4aGNpX3BjaV9wcm9iZSgpLCBzaW5jZSB5b3Ugbm93IG5vIGxvbmdlciB1c2UNCj4gZGV2bV9h
ZGRfYWN0aW9uX29yX3Jlc2V0DQo+ICAgICBmb3IgYXV0by1jbGVhbnVwLCB5b3UgbXVzdCBub3cg
bWFudWFsbHkgY2xlYW51cCBieSBjYWxsaW5nDQo+ICAgICB4aGNpX2V4dF9jYXBfcmVtb3ZlKCkg
d2hlbiBsYXRlciBzdGVwcyBvZiB4aGNpX3BjaV9wcm9iZSgpIGZhaWwuDQo+ICAgICBpdCBsb29r
cyBsaWtlIHlvdSB3aWxsIG5lZWQgYSBuZXcgZXh0X2NhcF9yZW1vdmUgZXJyb3ItZXhpdCBsYWJl
bA0KPiAgICAgZm9yIHRoaXMgcHV0IGFib3ZlIHRoZSBwdXRfdXNiM19oY2QgbGFiZWwgYW5kIGdv
dG8gdGhpcyBuZXcgbGFiZWwNCj4gICAgIGluc3RlYWQgb2YgdG8gcHV0X3VzYjNfaGNkIGluIGFs
bCBlcnJvciBwYXRocyBhZnRlciBhIHN1Y2Nlc3NmdWwgY2FsbA0KPiAgICAgdG8geGhjaV9leHRf
Y2FwX2luaXQoKQ0KDQpSaWdodC4gV2lsbCByZXZpZXcgdGhpcyBwYXRoIGFuZCBjb3JyZWN0IGFj
Y29yZGluZ2x5Lg0KDQpNYXliZSBhbiBhZGRpdGlvbmFsIGxhYmVsIGlzbid0IHJlcXVpcmVkIGJl
Y2F1c2UgcGRldiBpcyBvbmx5IHNldCB3aGVuDQp4aGNpX2V4dF9jYXBfaW5pdCBjcmVhdGVkIHRo
ZSBwbGF0Zm9ybSBkZXZpY2UsIGFuZCB4aGNpX2V4dF9jYXBfcmVtb3ZlDQpjaGVja3MgZm9yIHBk
ZXYgYmVpbmcgc2V0Lg0KU28gYSBjYWxsIHRvIHhoY2lfZXh0X2NhcF9yZW1vdmUgZG9lc24ndCBo
YXJtIGlmIHBkZXYgaXMgbm90IHNldCB1cCB5ZXQuDQpCdXQgZm9yIHJlYWRhYmlsaXR5IGl0IG1p
Z2h0IGJlIGJldHRlciB0byBjcmVhdGUgYSBsYWJlbC4NCg0KQmVzdCByZWdhcmRzDQpDYXJzdGVu
DQo=
