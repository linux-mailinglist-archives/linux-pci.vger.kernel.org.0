Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8077EF1D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 10:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404100AbfHBIYG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 04:24:06 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:49188 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfHBIYG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2019 04:24:06 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1htSqy-0001Dk-Sj from Carsten_Schmid@mentor.com ; Fri, 02 Aug 2019 01:23:56 -0700
Received: from SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Fri, 2 Aug 2019 09:22:39 +0100
Received: from SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17]) by
 SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17%22]) with mapi id
 15.00.1320.000; Fri, 2 Aug 2019 09:22:39 +0100
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Fawad Lateef <fawadlateef@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: AW: Unhandled fault: imprecise external abort (0x1406) when loading
 xhci_pci.ko - uPD720202, PEX8605, iMX6Q and linux-4.19.25
Thread-Topic: Unhandled fault: imprecise external abort (0x1406) when loading
 xhci_pci.ko - uPD720202, PEX8605, iMX6Q and linux-4.19.25
Thread-Index: AQHVSEHAMPaxqF08hEykKiPIRN/jH6bmeLKAgAEMruA=
Date:   Fri, 2 Aug 2019 08:22:39 +0000
Message-ID: <743ef7fab5144df69bfc8673fff7f0f7@SVR-IES-MBX-03.mgc.mentorg.com>
References: <CAGgoGu5FfLFzCf0QiAd8UcMrZ7gtLyapgT3TZ-Hx0dknWy4LMQ@mail.gmail.com>
 <CAGgoGu4zP_7QpKHiXSkLfkb=zHEezBzstVfjQMQ4CO60+YubCw@mail.gmail.com>
 <CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com>
 <20190801171725.GD151852@google.com>
In-Reply-To: <20190801171725.GD151852@google.com>
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

PiA+DQo+ID4gRmFjaW5nIGtlcm5lbCAiVW5oYW5kbGVkIGZhdWx0OiBpbXByZWNpc2UgZXh0ZXJu
YWwgYWJvcnQgKDB4MTQwNikiDQo+ID4gd2hlbiB0cnlpbmcgdG8gbG9hZCB4aGNpX3BjaS5rbyBt
b2R1bGUgZm9yIHVQRDcyMDIwMi4gUmVjZWl2aW5nIHRoaXMNCj4gPiBmYXVsdCBzdHJhaWdodC1h
d2F5IHdoZW4gZHJpdmVyIHRyeWluZyB0byBzZXR1cCBkZXZpY2UuDQo+ID4NCkkgaGFkICJpbXBy
ZWNpc2UgZXh0ZXJuYWwgYWJvcnQiIG9uIEFSTSBzeXN0ZW1zIGluIHRoZSBmb2xsb3dpbmcgY2Fz
ZXM6DQotIFN1YnN5c3RlbSB0aGF0IHdhcyBhY2Nlc3NlZCB3YXMgbm90IHBvd2VyZWQNCi0gQ2xv
Y2sgb2YgYWNjZXNzZWQgc3Vic3lzdGVtIHdhcyB0dXJuZWQgb2ZmDQpNYXliZSB0aGlzIGVuYWJs
ZXMgeW91IHRvIGZpbmQgdGhlIHRydWUgcmVhc29uLg0KDQpDYW4geW91IHRyeSB0byBkaXNhYmxl
IHJ1bnRpbWUgcG93ZXIgbWFuYWdlbWVudCB0byBjaGVjayBpZiBpdCB3b3Jrcz8NCg0KQmVzdCBy
ZWdhcmRzDQpDYXJzdGVuDQo=
