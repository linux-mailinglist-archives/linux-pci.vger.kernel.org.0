Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E11C9918D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 13:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbfHVLB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 07:01:56 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:46530 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfHVLB4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 07:01:56 -0400
IronPort-SDR: BsvS9NEWYPDJZj0azY/2TrryKB7256Q0QzMGhLiY1OlITNy8nggdb5a3yofsuQP9UwDf0OghzL
 b2e0Xr4FW64AAXWTqeYievuPUuOwvuQHlU2ciceuAvGRC1JWV2lGZ6I07oVXhk6uWNystPkrdw
 FPMMt4rikxPZibQGTVnl5G4Z4IEe+IHgO5xnwmSkgQjQGEHSQTCNLXuuY8goXEyxTAkoNINqMU
 u2fq4NUZlamB+6BLtGseskRTQUKMwpXcdR4xJ/RjuPlSf8aK1fyrflSlTgMdaVAL3xf0tl855O
 BWw=
X-IronPort-AV: E=Sophos;i="5.64,416,1559548800"; 
   d="scan'208";a="40679350"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 22 Aug 2019 03:01:55 -0800
IronPort-SDR: GUR8j+0Go+nUoI0C3g+TY+M3S72kHnsBqnNvn0F51ujFTzkjV9sY1PXobIPTFyR03YPAb+faKN
 HpHSJq7Bonto06B7+1+xc1TlkEZ1HQbXHRXng7P4CvFDu4gebC8dhi4rKKGJEzaD0Ow3uKan82
 BkXaEUbOLqeNZgjZOMND3w73zw8q+VYr+wGqomaUjp0Xvk0kf74Kd9HJfx8yDm9KoqNf/Ls2nk
 d1KEgt1o0hunVaWOtLldC92JsMihFbUJkRQWc6Q9/kyv1jQBj0duCIgxTOgKwI11ves1iCe5Fo
 890=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Fawad Lateef <fawadlateef@gmail.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: AW: Unhandled fault: imprecise external abort (0x1406) when loading
 xhci_pci.ko - uPD720202, PEX8605, iMX6Q and linux-4.19.25
Thread-Topic: Unhandled fault: imprecise external abort (0x1406) when loading
 xhci_pci.ko - uPD720202, PEX8605, iMX6Q and linux-4.19.25
Thread-Index: AQHVSEHAMPaxqF08hEykKiPIRN/jH6bmeLKAgAEMruCAABtagIAfUy8AgAAUnVCAAANwgIAAFEBw
Date:   Thu, 22 Aug 2019 11:01:50 +0000
Message-ID: <bb206643df9346e7830dbf08ec458d18@SVR-IES-MBX-03.mgc.mentorg.com>
References: <CAGgoGu5FfLFzCf0QiAd8UcMrZ7gtLyapgT3TZ-Hx0dknWy4LMQ@mail.gmail.com>
 <CAGgoGu4zP_7QpKHiXSkLfkb=zHEezBzstVfjQMQ4CO60+YubCw@mail.gmail.com>
 <CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com>
 <20190801171725.GD151852@google.com>
 <743ef7fab5144df69bfc8673fff7f0f7@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAGgoGu4ZZR3ZVD5mx_oJN_8gwNM4fa=of=erwM+P8P7zzaMDrQ@mail.gmail.com>
 <CAGgoGu5WP1qQUf4HS8xWGXUuP0L9vM6HGz1OZoGBBh1B67ZYSg@mail.gmail.com>
 <5c4bae3d066e4f1084c7eeb394b8a7d7@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAGgoGu5vH0LZsJDyTag2aWqicrTboLFHdYJ=0pWAsjuNp-J-BA@mail.gmail.com>
In-Reply-To: <CAGgoGu5vH0LZsJDyTag2aWqicrTboLFHdYJ=0pWAsjuNp-J-BA@mail.gmail.com>
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

PiANCj4gT2NjYXNpb25hbGx5IHdlIHNlZSBjcmFzaCBhdCBib290IHRvbyB3aXRob3V0IGV2ZW4g
cmVhY2hpbmcgc3RhZ2Ugb2YNCj4gbG9hZGluZyB4aGNpLXBjaS5rbyBkcml2ZXIuDQo+IA0KPiBM
b2cgaXMgYmVsb3cuIElzIHRoaXMgY2FuIGJlIGJlY2F1c2Ugb2YgYWdhaW4gdVBEIGNvbm5lY3Rl
ZCBvbiBQQ0llDQo+IGJ1cyAodGhyb3VnaCBQQ0llIHN3aXRjaCk/DQo+IA0KPiBbICAgIDguMjYz
MTE3XSBVbmhhbmRsZWQgZmF1bHQ6IGltcHJlY2lzZSBleHRlcm5hbCBhYm9ydCAoMHgxNDA2KSBh
dCAweGZhZjA2YTViDQoNCkxvb2tzIGxpa2UgYSBoYXJkd2FyZSBpc3N1ZSBvbiB5b3VyIGJvYXJk
LCBsaWtlIFBDSWUgYWNjZXNzZXMgc29tZXRpbWVzIGZhaWwuDQpPdXQgb2YgbXkgc2NvcGUsIHNv
cnJ5Lg0KDQpBbnl3YXksIHRyeSB3aXRoIFBNIGRpc2FibGVkLg0KDQpCZXN0IHJlZ2FyZHMNCkNh
cnN0ZW4NCg==
