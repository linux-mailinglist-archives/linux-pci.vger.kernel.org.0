Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142802301FC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 07:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgG1Fq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 01:46:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42314 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG1Fq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 01:46:56 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06S5kR9p9000735, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06S5kR9p9000735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Jul 2020 13:46:27 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 28 Jul 2020 13:46:27 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 28 Jul 2020 13:46:27 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Tue, 28 Jul 2020 13:46:27 +0800
From:   =?big5?B?p2Sp/rzhIFJpY2t5?= <ricky_wu@realtek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        James Ettle <james@ettle.org.uk>
CC:     Rui Feng <rui_feng@realsil.com.cn>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacopo De Simoi <wilderkde@gmail.com>
Subject: RE: rtsx_pci not restoring ASPM state after suspend/resume
Thread-Topic: rtsx_pci not restoring ASPM state after suspend/resume
Thread-Index: AQHWZF98DDVxZTXVzky/7XhwfZkLR6kccXXg
Date:   Tue, 28 Jul 2020 05:46:27 +0000
Message-ID: <bbbf5619b17e43029a75ef60b6f4fc40@realtek.com>
References: <f02332767323fc3ecccea13dd47ecfff12526112.camel@ettle.org.uk>
 <20200727214712.GA1777201@bjorn-Precision-5520>
In-Reply-To: <20200727214712.GA1777201@bjorn-Precision-5520>
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

DQo+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDA4OjUyOjI1UE0gKzAxMDAsIEphbWVzIEV0dGxl
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0wNy0yNyBhdCAwOToxNCAtMDUwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gPiA+IEkgZG9uJ3Qga25vdyB0aGUgY29ubmVjdGlvbiBiZXR3ZWVuIEFT
UE0gYW5kIHBhY2thZ2UgQy1zdGF0ZXMsIHNvIEkNCj4gPiA+IG5lZWQgdG8gc2ltcGxpZnkgdGhp
cyBldmVuIG1vcmUuICBBbGwgSSB3YW50IHRvIGRvIHJpZ2h0IG5vdyBpcw0KPiA+ID4gdmVyaWZ5
DQo+ID4gPiB0aGF0IGlmIHdlIGRvbid0IGhhdmUgYW55IG91dHNpZGUgaW5mbHVlbmNlcyBvbiB0
aGUgQVNQTQ0KPiA+ID4gY29uZmlndXJhdGlvbg0KPiA+ID4gKGVnLCBubyBtYW51YWwgY2hhbmdl
cyBhbmQgbm8gdWRldiBydWxlcyksIGl0IHN0YXlzIHRoZSBzYW1lIGFjcm9zcw0KPiA+ID4gc3Vz
cGVuZC9yZXN1bWUuDQo+ID4NCj4gPiBCYXNpY2FsbHkgdGhpcyBzdGFydGVkIGZyb20gbWUgb2Jz
ZXJ2aW5nIGRlZXAgcGFja2FnZSBDLXN0YXRlcyB3ZXJlbid0DQo+ID4gYmVpbmcgdXNlZCwgdW50
aWwgSSB3ZW50IGFuZCBmaWRkbGVkIHdpdGggdGhlIEFTUE0gc3RhdGUgb2YgdGhlDQo+ID4gcnRz
eF9wY2kgY2FyZCByZWFkZXIgdW5kZXIgc3lzZnMgLS0gc28gcGhlbm9tZW5vbG9naWNhbCBwb2tp
bmcgb24gbXkNCj4gPiBwYXJ0Lg0KPiA+DQo+ID4gPiBTbyBsZXQncyByZWFkIHRoZSBBU1BNIHN0
YXRlIGRpcmVjdGx5IGZyb20gdGhlDQo+ID4gPiBoYXJkd2FyZSBsaWtlIHRoaXM6DQo+ID4gPg0K
PiA+ID4gICBzdWRvIGxzcGNpIC12dnMgMDA6MWQuMCB8IGVncmVwICJeMHxMbmt8TDF8TFRSfHNu
b29wIg0KPiA+ID4gICBzdWRvIGxzcGNpIC12dnMgMDE6MDAgICB8IGVncmVwICJeMHxMbmt8TDF8
TFRSfHNub29wIg0KPiA+ID4NCj4gPiA+IENhbiB5b3UgdHJ5IHRoYXQgYmVmb3JlIGFuZCBhZnRl
ciBzdXNwZW5kL3Jlc3VtZT8NCj4gPg0KPiA+IEkndmUgYXR0YWNoZWQgdGhlc2UgdG8gdGhlIGJ1
Z3ppbGxhIGVudHJ5IGF0Og0KPiA+DQo+ID4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMDgxMTcNCj4gPg0KPiA+IFNwb2lsZXI6IFdpdGggbm8gdWRldiBydWxl
cyBvciBzdXNwZW5kIGhvb2tzLCB0aGluZ3MgYXJlIHRoZSBzYW1lDQo+ID4gYmVmb3JlIGFuZCBh
ZnRlciBzdXNwZW5kL3Jlc3VtZS4gT25lIHRoaW5nIEkgZG8gc2VlIChib3RoIGJlZm9yZSBhbmQN
Cj4gPiBhZnRlcikgaXMgdGhhdCBBU1BNIEwwcyBhbmQgTDEgaXMgZW5hYmxlZCBmb3IgdGhlIGNh
cmQgcmVhZGVyLCBidXQNCj4gPiBkaXNhYmxlZCBmb3IgdGhlIGV0aGVybmV0IGNoaXAgKGRvZXMg
cjgxNjkgZmlkZGxlIHdpdGggQVNQTSB0b28/KS4NCj4gDQo+IFRoYW5rIHlvdSEgIEl0J3MgZ29v
ZCB0aGF0IHRoaXMgc3RheXMgdGhlIHNhbWUgYWNyb3NzIHN1c3BlbmQvcmVzdW1lLg0KPiBEbyB5
b3Ugc2VlIGRpZmZlcmVudCBDLXN0YXRlIGJlaGF2aW9yIGJlZm9yZSB2cyBhZnRlcj8NCj4gDQo+
IFRoaXMgaXMgdGhlIGNvbmZpZyBJIHNlZToNCj4gDQo+ICAgMDA6MWQuMCBicmlkZ2UgdG8gW2J1
cyAwMV06IEFTUE0gTDEgc3VwcG9ydGVkOyAgICAgQVNQTSBEaXNhYmxlZA0KPiAgIDAxOjAwLjAg
Y2FyZCByZWFkZXI6ICAgICAgICBBU1BNIEwwcyBMMSBzdXBwb3J0ZWQ7IEwwcyBMMSBFbmFibGVk
DQo+ICAgMDE6MDAuMSBHaWdFIE5JQzogICAgICAgICAgIEFTUE0gTDBzIEwxIHN1cHBvcnRlZDsg
QVNQTSBEaXNhYmxlZA0KPiANCj4gVGhpcyBpcyBhY3R1YWxseSBpbGxlZ2FsIGJlY2F1c2UgUENJ
ZSByNS4wLCBzZWMgNS40LjEuMywgc2F5cyBzb2Z0d2FyZQ0KPiBtdXN0IG5vdCBlbmFibGUgTDBz
IGluIGVpdGhlciBkaXJlY3Rpb24gdW5sZXNzIGNvbXBvbmVudHMgb24gYm90aCBlbmRzDQo+IG9m
IHRoZSBsaW5rIHN1cHBvcnQgTDBzLiAgVGhlIGJyaWRnZSAoMDA6MWQuMCkgZG9lcyBub3Qgc3Vw
cG9ydCBMMHMsDQo+IHNvIGl0J3MgaWxsZWdhbCB0byBlbmFibGUgTDBzIG9uIDAxOjAwLjAuICBJ
IGRvbid0IGtub3cgd2hldGhlciB0aGlzDQo+IGNhdXNlcyBwcm9ibGVtcyBpbiBwcmFjdGljZS4N
Cj4gDQoNCklmIHN5c3RlbSB3YW50IHRvIGVudHJ5IGRlZXAgQy1zdGF0ZSwgc3lzdGVtIGhhdmUg
dG8gc3VwcG9ydCBMMS4gSG9zdCBicmlkZ2UgaGFuZHNoYWtlIHdpdGggZGV2aWNlIHRvIGRldGVy
bWluZSB3aGV0aGVyIHRvIGVudGVyIHRoZSBMMSBzdGF0ZS4NCk91ciBjYXJkIHJlYWRlciBkcml2
ZXIgZGlkIG5vdCBzZXQgTDBzLCBoZXJlIG5lZWQgdG8gY2hlY2sgd2hvIHNldCB0aGlzLCBidXQg
d2UgdGhvdWdodCB0aGlzIEwwcyBlbmFibGUgc2hvdWxkIG5vdCBjYXVzZSBIb3N0IGJyaWRnZSBB
U1BNIGRpc2FibGUNCiANCg0KPiBJIGRvbid0IHNlZSBhbnl0aGluZyBpbiBydHN4IHRoYXQgZW5h
YmxlcyBMMHMuICBDYW4geW91IGNvbGxlY3QgdGhlDQo+IGRtZXNnIGxvZyB3aGVuIGJvb3Rpbmcg
d2l0aCAicGNpPWVhcmx5ZHVtcCI/ICBUaGF0IHdpbGwgc2hvdyB3aGV0aGVyDQo+IHRoZSBCSU9T
IGxlZnQgaXQgdGhpcyB3YXkuICBUaGUgUENJIGNvcmUgaXNuJ3Qgc3VwcG9zZWQgdG8gZG8gdGhp
cywgc28NCj4gaWYgaXQgZGlkLCB3ZSBuZWVkIHRvIGZpeCB0aGF0Lg0KPiANCj4gSSBkb24ndCBr
bm93IHdoZXRoZXIgcjgxNjkgbXVja3Mgd2l0aCBBU1BNLiAgSXQgaXMgbGVnYWwgdG8gaGF2ZQ0K
PiBkaWZmZXJlbnQgY29uZmlndXJhdGlvbnMgZm9yIHRoZSB0d28gZnVuY3Rpb25zLCBldmVuIHRo
b3VnaCB0aGV5IHNoYXJlDQo+IHRoZSBzYW1lIGxpbmsuICBTZWMgNS40LjEgaGFzIHJ1bGVzIGFi
b3V0IGhvdyBoYXJkd2FyZSByZXNvbHZlcw0KPiBkaWZmZXJlbmNlcy4NCj4gDQo+ID4gW09kZGx5
IHdoZW4gSSBzZXQgQVNQTSAoZS5nLiB1c2luZyB1ZGV2KSB0aGUgbHNwY2kgdG9vbHMgc2hvdyBB
U1BNDQo+ID4gZW5hYmxlZCBhZnRlciBhIHN1c3BlbmQvcmVzdW1lLCBidXQgc3RpbGwgbm8gZGVl
cCBwYWNrYWdlIEMtc3RhdGVzDQo+ID4gdW50aWwgSSBtYW51YWxseSBmaWRkbGUgdmlhIHN5c2Zz
IG9uIHRoZSBjYXJkIHJlYWRlci4gU29ycnkgaWYgdGhpcw0KPiA+IG9ubHkgbXVkZGllcyB0aGUg
d2F0ZXIgZnVydGhlciFdDQo+IA0KPiBMZXQncyBkZWZlciB0aGlzIGZvciBub3cuICBJdCBzb3Vu
ZHMgd29ydGggcHVyc3VpbmcsIGJ1dCBJIGNhbid0IGtlZXANCj4gZXZlcnl0aGluZyBpbiBteSBo
ZWFkIGF0IG9uY2UuDQo+IA0KPiBCam9ybg0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRo
ZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
