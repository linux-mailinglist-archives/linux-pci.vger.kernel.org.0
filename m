Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC65221DDA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 10:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGPIHo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 04:07:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55801 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgGPIHn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 04:07:43 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-256-PplaHSnfMy-vJii-bmgfqA-1; Thu, 16 Jul 2020 09:07:38 +0100
X-MC-Unique: PplaHSnfMy-vJii-bmgfqA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 16 Jul 2020 09:07:37 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 16 Jul 2020 09:07:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     'Oliver O'Halloran' <oohall@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        "Marek Vasut" <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Russell King <linux@armlinux.org.uk>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ray Jui <rjui@broadcom.com>, Jens Axboe <axboe@fb.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Richard Henderson <rth@twiddle.net>,
        Juergen Gross <jgross@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        Scott Branden <sbranden@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: RE: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Thread-Topic: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Thread-Index: AQHWWvotn5bD1WsSsUK40p+tBVrtaakJ2CmQ
Date:   Thu, 16 Jul 2020 08:07:37 +0000
Message-ID: <5a7574c0efc1475a89f84c6393e598d6@AcuMS.aculab.com>
References: <20200715221230.GA563957@bjorn-Precision-5520>
 <5d4b3a716f85017c17c52a85915fba9e19509e81.camel@kernel.crashing.org>
In-Reply-To: <5d4b3a716f85017c17c52a85915fba9e19509e81.camel@kernel.crashing.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogQmVuamFtaW4gSGVycmVuc2NobWlkdA0KPiBTZW50OiAxNSBKdWx5IDIwMjAgMjM6NDkN
Cj4gT24gV2VkLCAyMDIwLTA3LTE1IGF0IDE3OjEyIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3Rl
Og0KPiA+ID4gSSd2ZSAncGxheWVkJyB3aXRoIFBDSWUgZXJyb3IgaGFuZGxpbmcgLSB3aXRob3V0
IG11Y2ggc3VjY2Vzcy4NCj4gPiA+IFdoYXQgbWlnaHQgYmUgdXNlZnVsIGlzIGZvciBhIGRyaXZl
ciB0aGF0IGhhcyBqdXN0IHJlYWQgfjB1IHRvDQo+ID4gPiBiZSBhYmxlIHRvIGFzayAnaGFzIHRo
ZXJlIGJlZW4gYW4gZXJyb3Igc2lnbmFsbGVkIGZvciB0aGlzIGRldmljZT8nLg0KPiA+DQo+ID4g
SW4gbWFueSBjYXNlcyBhIGRyaXZlciB3aWxsIGtub3cgdGhhdCB+MCBpcyBub3QgYSB2YWxpZCB2
YWx1ZSBmb3IgdGhlDQo+ID4gcmVnaXN0ZXIgaXQncyByZWFkaW5nLiAgQnV0IGlmIH4wICpjb3Vs
ZCogYmUgdmFsaWQsIGFuIGludGVyZmFjZSBsaWtlDQo+ID4geW91IHN1Z2dlc3QgY291bGQgYmUg
dXNlZnVsLiAgSSBkb24ndCB0aGluayB3ZSBoYXZlIGFueXRoaW5nIGxpa2UgdGhhdA0KPiA+IHRv
ZGF5LCBidXQgbWF5YmUgd2UgY291bGQuICBJdCB3b3VsZCBjZXJ0YWlubHkgYmUgbmljZSBpZiB0
aGUgUENJIGNvcmUNCj4gPiBub3RpY2VkLCBsb2dnZWQsIGFuZCBjbGVhcmVkIGVycm9ycy4gIFdl
IGhhdmUgc29tZSBvZiB0aGF0IGZvciBBRVIsDQo+ID4gYnV0IHRoYXQncyBhbiBvcHRpb25hbCBm
ZWF0dXJlLCBhbmQgc3VwcG9ydCBmb3IgdGhlIGVycm9yIGJpdHMgaW4gdGhlDQo+ID4gZ2FyZGVu
LXZhcmlldHkgUENJX1NUQVRVUyByZWdpc3RlciBpcyBwcmV0dHkgaGFwaGF6YXJkLiAgQXMgeW91
IG5vdGUNCj4gPiBiZWxvdywgdGhpcyBzb3J0IG9mIFNFUlIvUEVSUiByZXBvcnRpbmcgaXMgZnJl
cXVlbnRseSBoYXJkLXdpcmVkIGluDQo+ID4gd2F5cyB0aGF0IHRha2VzIGl0IG91dCBvZiBvdXIg
cHVydmlldy4NCj4gDQo+IFdlIGRvIGhhdmUgcGNpX2NoYW5uZWxfc3RhdGUgKHZpYSBwY2lfY2hh
bm5lbF9vZmZsaW5lKCkpIHdoaWNoIGNvdmVycw0KPiB0aGUgY2FzZXMgd2hlcmUgdGhlIHVuZGVy
bHlpbmcgZXJyb3IgaGFuZGxpbmcgKHN1Y2ggYXMgRUVIIG9yIHVucGx1ZykNCj4gcmVzdWx0cyBp
biB0aGUgZGV2aWNlIGJlaW5nIG9mZmxpbmVkIHRob3VnaCB0aGlzIHRlbmQgdG8gYmUNCj4gYXN5
bmNocm9ub3VzIHNvIGl0IG1pZ2h0IHRha2UgYSBmZXcgfjAncyBiZWZvcmUgeW91IGdldCBpdC4N
Cg0KT24gb25lIG9mIG15IHN5c3RlbXMgSSBkb24ndCB0aGluayB0aGUgZXJyb3IgVExQIGZyb20g
dGhlIHRhcmdldA0KbWFkZSBpdHMgd2F5IHBhc3QgdGhlIGZpcnN0IGJyaWRnZSAtIEkgY291bGQg
c2VlIHRoZSBlcnJvciBpbiBpdCdzDQpzdGF0dXMgcmVnaXN0ZXJzLg0KQnV0IEkgY291bGRuJ3Qg
ZmluZCBhbnkgb2YgdGhlIEFFUiBzdGF0dXMgcmVnaXN0ZXJzIGluIHRoZSByb290IGJyaWRnZS4N
ClNvIEkgdGhpbmsgeW91J2QgbmVlZCBhIHNvZnR3YXJlIHBvbGwgb2YgdGhlIGJyaWRnZSByZWdp
c3RlcnMgdG8NCmZpbmQgb3V0IChhbmQgY2xlYXIpIHRoZSBlcnJvci4NCg0KVGhlIE5NSSBvbiB0
aGUgZGVsbCBzeXN0ZW0gKHdoaWNoIGlzIHN1cHBvc2VkIHRvIG1lZXQgc29tZSBzcGVjaWFsDQpO
RUJTPyBzZXJ2ZXIgcmVxdWlyZW1lbnRzKSBpcyBqdXN0IHN0dXBpZC4NClRvbyBsYXRlIHRvIGJl
IHN5bmNocm9ub3VzIGFuZCBpbXBvc3NpYmxlIGZvciB0aGUgT1MgdG8gaGFuZGxlLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

