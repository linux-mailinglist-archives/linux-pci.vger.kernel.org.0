Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C393D3236
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 05:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhGWCrh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 22:47:37 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56394 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233459AbhGWCrg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 22:47:36 -0400
Received: from BC-Mail-Ex28.internal.baidu.com (unknown [172.31.51.22])
        by Forcepoint Email with ESMTPS id 183C323367F76E59D69E;
        Fri, 23 Jul 2021 11:28:02 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex28.internal.baidu.com (172.31.51.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Jul 2021 11:28:01 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Fri, 23 Jul 2021 11:28:01 +0800
From:   "Cai,Huoqing" <caihuoqing@baidu.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] PCI: vmd: Make use of PCI_DEVICE_DATA() helper
 function
Thread-Topic: [PATCH 2/2] PCI: vmd: Make use of PCI_DEVICE_DATA() helper
 function
Thread-Index: AQHXfuz06iWan68U8E67FndxP9SPDKtOrgaAgAEY9JD//4ICgIAAht6A
Date:   Fri, 23 Jul 2021 03:28:01 +0000
Message-ID: <3a13ed0d8b1c4eb2bea2e10e982c2ed1@baidu.com>
References: <20210722112954.477-1-caihuoqing@baidu.com>
 <20210722112954.477-3-caihuoqing@baidu.com>
 <f2aeb584-6293-78ce-e5aa-4bde34045a86@intel.com>
 <e44664317c2949e794497dc5f903f2a8@baidu.com>
 <20210723020013.GA2170028@rocinante>
In-Reply-To: <20210723020013.GA2170028@rocinante>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.18.18.94]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCiAJVGhhbmsgZm9yIHlvdXIgc3VnZ2VzdGlvbiwgdXNlZnVsIHRvIG1lDQpJIHdpbGwg
c2VuZCBQQVRDSCB2MyBhZ2FpbiB3aXRoIGNoYW5nZWxvZyA6DQoNCnYxLT52MjogKmZpeCAgZXh0
cmEgaW5kZW50IHdoaWNoIG9jY3VycyBnaXQtYXBwbHkgZXJyb3INCg0KdjItPnYzOiAgKnVwZGF0
ZSB0aGUgc3ViamVjdCBsaW5lIGZyb20gImZ1bnRpb24iIHRvICJtYWNybyINCgkgKmFkZCBjaGFu
Z2Vsb2cgdG8gY29tbWl0IG1lc3NhZ2UNCg0KY29tbWl0IGRhdGU6IDctMjMtMjAyMSAxMTowMA0K
DQp0aHgNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBXaWxj
ennFhHNraSA8a3dAbGludXguY29tPiANClNlbnQ6IDIwMjHlubQ35pyIMjPml6UgMTA6MDANClRv
OiBDYWksSHVvcWluZyA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+DQpDYzogRGVycmljaywgSm9uYXRo
YW4gPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IFBDSTogdm1kOiBNYWtlIHVzZSBvZiBQQ0lfREVWSUNFX0RBVEEoKSBoZWxwZXIgZnVuY3Rpb24N
Cg0KSGksDQoNClRoYW5rIHlvdSBmb3Igc2VuZGluZyB0aGUgcGF0Y2ggb3ZlciENCg0KPiAJUEFU
Q0hbMi8yXSBoYXMgc29tZSBleHRyYSBpbmRlbnRhdGlvbiwgcGxlYXNlIGRvbid0IGFwcGx5IGl0
ICwNCg0KWW91IG1pZ2h0IGtub3cgdGhpcyBhbHJlYWR5LCBidXQganVzdCBpbiBjYXNlIG1ha2Ug
c3VyZSB0byBydW4gdGhlICJjaGVja3BhdGNoLnBsIiBzY3JpcHQgb3ZlciB0aGUgcGF0Y2ggYmVm
b3JlIHN1Ym1pc3Npb24uDQoNCj4gSSdsbCBzZW5kIFBBVENIIFYyLg0KDQpZb3UgbWVhbiB2Mz8g
IE1ha2Ugc3VyZSB0byBpbmNsdWRlIGEgY2hhbmdlbG9nLCBpZiBwb3NzaWJsZS4NCg0KQSBzbWFs
bCBuaXRwaWNrOiB0aGUgUENJX0RFVklDRV9EQVRBKCkgaXMgdGVjaG5pY2FsbHkgYSBtYWNybyBy
YXRoZXIgdGhhbiBhIGZ1bmN0aW9uLCBzbyB5b3UgY291bGQgdXBkYXRlIGJvdGggdGhlIHN1Ympl
Y3QgbGluZSBhbmQgdGhlIGNvbW1pdCBtZXNzYWdlIGFjY29yZGluZ2x5LCBpZiB5b3Ugd2FudC4N
Cg0KQWxzbywgc2luY2UgeW91IGFyZSBhYm91dCB0byBzZW5kIGFub3RoZXIgdmVyc2lvbiwgYWRk
IHBlcmlvZCBhdCB0aGUgZW5kIG9mIHRoZSBzZW50ZW5jZSBpbiB0aGUgY29tbWl0IG1lc3NhZ2Uu
DQoNCkFzaWRlIG9mIHRoZSBhYm92ZSwgaXQncyBhIG5pY2UgcmVmYWN0b3IsIHRoYW5rIHlvdSEN
Cg0KCUtyenlzenRvZg0K
