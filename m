Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F215C116C2
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEBJyy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 05:54:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:24742 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbfEBJyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 May 2019 05:54:54 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-130-Ng2ipl1kM4iX0CK2opXBrA-1; Thu, 02 May 2019 10:54:50 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 2 May 2019 10:54:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 2 May 2019 10:54:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Srinath Mannam' <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Thread-Topic: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Thread-Index: AQHVADHM3KBPKKWjuUy35ge+uHQL0KZXmYKw
Date:   Thu, 2 May 2019 09:54:50 +0000
Message-ID: <7c44526aebb6403890bab8e252c16375@AcuMS.aculab.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190501113038.GA7961@e121166-lin.cambridge.arm.com>
 <20190501125530.GA15590@google.com>
 <CABe79T5w4hb572KHUhyrwAN7+Xxnz2jF9OGLpfTmAdHuLuO2Fw@mail.gmail.com>
In-Reply-To: <CABe79T5w4hb572KHUhyrwAN7+Xxnz2jF9OGLpfTmAdHuLuO2Fw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Ng2ipl1kM4iX0CK2opXBrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogU3JpbmF0aCBNYW5uYW0NCj4gU2VudDogMDEgTWF5IDIwMTkgMTY6MjMNCi4uLg0KPiA+
ID4gT24gRnJpLCBBcHIgMTIsIDIwMTkgYXQgMDg6NDM6MzJBTSArMDUzMCwgU3JpbmF0aCBNYW5u
YW0gd3JvdGU6DQo+ID4gPiA+IEZldyBTT0NzIGhhdmUgbGltaXRhdGlvbiB0aGF0IHRoZWlyIFBD
SWUgaG9zdCBjYW4ndCBhbGxvdyBmZXcgaW5ib3VuZA0KPiA+ID4gPiBhZGRyZXNzIHJhbmdlcy4g
QWxsb3dlZCBpbmJvdW5kIGFkZHJlc3MgcmFuZ2VzIGFyZSBsaXN0ZWQgaW4gZG1hLXJhbmdlcw0K
PiA+ID4gPiBEVCBwcm9wZXJ0eSBhbmQgdGhpcyBhZGRyZXNzIHJhbmdlcyBhcmUgcmVxdWlyZWQg
dG8gZG8gSU9WQSBtYXBwaW5nLg0KPiA+ID4gPiBSZW1haW5pbmcgYWRkcmVzcyByYW5nZXMgaGF2
ZSB0byBiZSByZXNlcnZlZCBpbiBJT1ZBIG1hcHBpbmcuDQoNCllvdSBwcm9iYWJseSB3YW50IHRv
IGZpeCB0aGUgZW5nbGlzaCBpbiB0aGUgZmlyc3Qgc2VudGVuY2UuDQpUaGUgc2Vuc2UgaXMgcmV2
ZXJzZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

