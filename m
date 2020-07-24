Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE5422BED5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 09:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGXHQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 03:16:47 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40127 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGXHQr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 03:16:47 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06O7GQ290012633, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06O7GQ290012633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jul 2020 15:16:27 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jul 2020 15:16:26 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jul 2020 15:16:26 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Fri, 24 Jul 2020 15:16:26 +0800
From:   =?big5?B?p2Sp/rzhIFJpY2t5?= <ricky_wu@realtek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Ettle <james@ettle.org.uk>, Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jacopo De Simoi" <wilderkde@gmail.com>
Subject: RE: rtsx_pci not restoring ASPM state after suspend/resume
Thread-Topic: rtsx_pci not restoring ASPM state after suspend/resume
Thread-Index: AQHWYRI0DDVxZTXVzky/7XhwfZkLR6kU4LqAgAFjQYA=
Date:   Fri, 24 Jul 2020 07:16:26 +0000
Message-ID: <83fa1c44e8d342618eb5fbc491ec4779@realtek.com>
References: <20200723165622.GA1413555@bjorn-Precision-5520>
 <20200723171249.GA1422397@bjorn-Precision-5520>
In-Reply-To: <20200723171249.GA1422397@bjorn-Precision-5520>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgSmFtZXMsIEJqb3JuLA0KDQpUaGUgQ2FyZCByZWFkZXIoMTBlYzo1Mjg3KSBpcyBhIGNvbWJv
IGNoaXAgd2l0aCBFdGhlcm5ldCgxMGVjOjgxNjgpLCB3ZSB0aGluayBpdCBpcyBub3QgY2F1c2Ug
Ynkgc2V0dGluZyBvdXIgZGV2aWNlIGNvbmZpZyBzcGFjZSBpbiBpZGxlIHRpbWUuDQpXZSBkaXMv
ZW5hYmxlIHRoZSBBU1BNKHNldHRpbmcgY29uZmlnIHNwYWNlKSBhdCBidXN5L2lkbGUgdGltZSwg
aXQgY2FuIG1ha2Ugb3VyIFIvVyBwZXJmb3JtYW5jZXMgd2VsbCBub3QgYSB3b3JrIGFyb3VuZCBm
dW5jdGlvbg0KUENJIEhvc3QgYW5kIERldmljZSBzZXR0aW5nIHNlbGYgY29uZmlnIHNwYWNlIGFu
ZCBkbyBoYW5kc2hha2luZywgd2UgdGhpbmsgaXQgZG9lcyBub3QgYWZmZWN0IHRoZSBzeXN0ZW0N
Cg0KDQpSaWNreSANCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Qmpvcm4gSGVsZ2FhcyBbbWFpbHRvOmhlbGdhYXNAa2VybmVsLm9yZ10NCj4gU2VudDogRnJpZGF5
LCBKdWx5IDI0LCAyMDIwIDE6MTMgQU0NCj4gVG86IKdkqf684SBSaWNreTsgUnVpIEZlbmcNCj4g
Q2M6IEFybmQgQmVyZ21hbm47IEdyZWcgS3JvYWgtSGFydG1hbjsgSmFtZXMgRXR0bGU7IExlbiBC
cm93bjsgUHVyYW5qYXkNCj4gTW9oYW47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEphY29wbyBEZQ0KPiBTaW1vaQ0KPiBTdWJqZWN0OiBS
ZTogcnRzeF9wY2kgbm90IHJlc3RvcmluZyBBU1BNIHN0YXRlIGFmdGVyIHN1c3BlbmQvcmVzdW1l
DQo+IA0KPiBbK2NjIEphY29wb10NCj4gDQo+IE9uIFRodSwgSnVsIDIzLCAyMDIwIGF0IDExOjU2
OjIyQU0gLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gSmFtZXMgcmVwb3J0ZWQgdGhp
cyBpc3N1ZSB3aXRoIHJ0c3hfcGNpOyBjYW4geW91IGd1eXMgcGxlYXNlIHRha2UgYQ0KPiA+IGxv
b2sgYXQgaXQ/ICBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIw
ODExNw0KPiA+DQo+ID4gVGhlcmUncyBhIGxvdCBvZiBnb29kIGluZm8gaW4gdGhlIGJ1Z3ppbGxh
IGFscmVhZHkuDQo+IA0KPiBMaWtlbHkgZHVwbGljYXRlOiBodHRwczovL2J1Z3ppbGxhLmtlcm5l
bC5vcmcvc2hvd19idWcuY2dpP2lkPTE5ODk1MQ0KPiANCj4gSmFjb3BvLCBjb3VsZCB5b3UgcGxl
YXNlIGF0dGFjaCBhIGNvbXBsZXRlIGRtZXNnIGxvZyBhbmQgInN1ZG8gbHNwY2kNCj4gLXZ2eHh4
eCIgb3V0cHV0IHRvIHlvdXIgYnVnemlsbGE/DQo+IA0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIg
dGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
