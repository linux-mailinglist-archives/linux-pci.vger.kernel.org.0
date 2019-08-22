Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568A498FA4
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 11:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfHVJeK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 05:34:10 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:6849 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbfHVJeJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 05:34:09 -0400
IronPort-SDR: 8mf43iBkllaNghz36lCCfRuX6X21cdXD5xZYk59ImiPdhIYJ5ghRtxfr3CfJd79TskO1WCBEH3
 nqQ6TWMkDPUSXQlq8liAY2j2uBZHpLUd2f3hVjcsqlyf+Lyx5ka82P1+31dTJb8tKnU8WXq143
 hGE3ujyFvGt36RsxZJsc8jM0EAnohY4DwS+GKP/8QhiwuP707mLXGYvdY/4ZHLKGTCP+dUZtdG
 mlRx2QCGUR2eeHJGSQzZuYLbl/37+TNH6mF6d/WzMrj70oRuO1OmWPxa1rRhLYjcml0afc3c1B
 DOU=
X-IronPort-AV: E=Sophos;i="5.64,416,1559548800"; 
   d="scan'208";a="40677369"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 22 Aug 2019 01:34:08 -0800
IronPort-SDR: vBF9ZHGzfp0f4QtCTZPNuCgbEvfKi2VvOYN55r64v+pWw47TADneOuvXY1LYI7whMm0QQ6q+w1
 USg1S1Q9VVMvPrzS3fZsnROemikNbE7ULTJ7Ub28R8mzrU674EVWO3EFZOD4Gjs0vCMR/zCe/7
 sooYxpwC0qS0Pm8ocF+DHOFM6+gZecDeN5/YoZ/enHTTwZmEjlSj9PAw8t8fed1iU8l/xxOS9W
 xQ4CoDTvHxWawLtWFJ1CpeWS8wJ1JYcDol4BAhBx6bK6Tt9lHn6HUEkgzUl0nGycrwnAhUhjSu
 AKs=
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
Thread-Index: AQHVSEHAMPaxqF08hEykKiPIRN/jH6bmeLKAgAEMruCAABtagIAfUy8AgAAUnVA=
Date:   Thu, 22 Aug 2019 09:34:02 +0000
Message-ID: <5c4bae3d066e4f1084c7eeb394b8a7d7@SVR-IES-MBX-03.mgc.mentorg.com>
References: <CAGgoGu5FfLFzCf0QiAd8UcMrZ7gtLyapgT3TZ-Hx0dknWy4LMQ@mail.gmail.com>
 <CAGgoGu4zP_7QpKHiXSkLfkb=zHEezBzstVfjQMQ4CO60+YubCw@mail.gmail.com>
 <CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com>
 <20190801171725.GD151852@google.com>
 <743ef7fab5144df69bfc8673fff7f0f7@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAGgoGu4ZZR3ZVD5mx_oJN_8gwNM4fa=of=erwM+P8P7zzaMDrQ@mail.gmail.com>
 <CAGgoGu5WP1qQUf4HS8xWGXUuP0L9vM6HGz1OZoGBBh1B67ZYSg@mail.gmail.com>
In-Reply-To: <CAGgoGu5WP1qQUf4HS8xWGXUuP0L9vM6HGz1OZoGBBh1B67ZYSg@mail.gmail.com>
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

PiANCj4gSGF2ZSBhIHF1ZXN0aW9uIHRoYXQ6IENhbiBJIGRpc2FibGUgUENJZSBwb3dlciBtYW5h
Z2VtZW50IGNvbXBsZXRlbHkNCj4gdXNpbmcgc29tZSBrZXJuZWwgQ09ORklHIG9wdGlvbiBPUiBi
b290IHBhcmFtZXRlcj8gSWYgeWVzIHRoZW4gaG93Pw0KPiANCj4gVGhhbmtzDQo+IA0KU2VlIENP
TkZJR19QTSBhbmQgd2hhdCBpdCBkZXBlbmRzIG9uLg0KDQpCUg0KQ2Fyc3Rlbg0K
