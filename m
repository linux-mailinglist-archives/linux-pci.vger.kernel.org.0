Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAB1BB4C6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 05:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD1Dos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 23:44:48 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33850 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1Dos (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 23:44:48 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03S3iHa55023640, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (msx.realsil.com.cn[172.29.17.3])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03S3iHa55023640
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 28 Apr 2020 11:44:18 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS02.realsil.com.cn
 ([::1]) with mapi id 14.03.0439.000; Tue, 28 Apr 2020 11:44:17 +0800
From:   =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tYzogcnRzeDogQWRkIFNEIEV4cHJlc3MgbW9k?= =?utf-8?Q?e_support_for_RTS5261?=
Thread-Topic: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
Thread-Index: AQHWG2mdb2Wi+0TUh0G7QGay1iuqfqiL+UQAgAC/B7D//5LPAIABmysA
Date:   Tue, 28 Apr 2020 03:44:17 +0000
Message-ID: <2A308283684ECD4B896628E09AF5361E028BCB4B@RS-MBS01.realsil.com.cn>
References: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
 <20200427061426.GA11270@infradead.org>
 <2A308283684ECD4B896628E09AF5361E028BCA26@RS-MBS01.realsil.com.cn>
 <CAK8P3a0EY=FOu5j5DG1BzMEoy_6nEy129kniWCjMYDEdO1o_Jw@mail.gmail.com>
In-Reply-To: <CAK8P3a0EY=FOu5j5DG1BzMEoy_6nEy129kniWCjMYDEdO1o_Jw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.40.150]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiANCj4gT24gTW9uLCBBcHIgMjcsIDIwMjAgYXQgMTE6NDEgQU0g5Yav6ZSQIDxydWlfZmVuZ0By
ZWFsc2lsLmNvbS5jbj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gT24gU3VuLCBBcHIgMjYsIDIw
MjAgYXQgMDk6MjU6NDZBTSArMDgwMCwgcnVpX2ZlbmdAcmVhbHNpbC5jb20uY24NCj4gd3JvdGU6
DQo+ID4gPiA+IEZyb206IFJ1aSBGZW5nIDxydWlfZmVuZ0ByZWFsc2lsLmNvbS5jbj4NCj4gPiA+
ID4NCj4gPiA+ID4gUlRTNTI2MSBzdXBwb3J0IGxlZ2FjeSBTRCBtb2RlIGFuZCBTRCBFeHByZXNz
IG1vZGUuDQo+ID4gPiA+IEluIFNENy54LCBTRCBhc3NvY2lhdGlvbiBpbnRyb2R1Y2UgU0QgRXhw
cmVzcyBhcyBhIG5ldyBtb2RlLg0KPiA+ID4gPiBTRCBFeHByZXNzIG1vZGUgaXMgZGlzdGluZ3Vp
c2hlZCBieSBDTUQ4Lg0KPiA+ID4gPiBUaGVyZWZvcmUsIENNRDggaGFzIG5ldyBiaXQgZm9yIFNE
IEV4cHJlc3MuDQo+ID4gPiA+IFNEIEV4cHJlc3MgaXMgYmFzZWQgb24gUENJZS9OVk1lLg0KPiA+
ID4gPiBSVFM1MjYxIHVzZXMgQ01EOCB0byBzd2l0Y2ggdG8gU0QgRXhwcmVzcyBtb2RlLg0KPiA+
ID4NCj4gPiA+IFNvIGhvdyBkb2VzIHRoaXMgYml0IHdvcms/ICBUaGV5IHdheSBJIGltYWdpbmVk
IFNEIEV4cHJlc3MgdG8gd29yaw0KPiA+ID4gaXMgdGhhdCB0aGUgYWN0dWFsIFNEIENhcmQganVz
dCBzaG93cyB1cCBhcyBhIHJlYWwgUENJZSBkZXZpY2UsDQo+ID4gPiBzaW1pbGFyIHRvIHNheSBU
aHVuZGVyYm9sdC4NCj4gPg0KPiA+IE5ldyBTRCBFeHByZXNzIGNhcmQgaGFzIGR1YWwgbW9kZS4g
T25lIGlzIFNEIG1vZGUgYW5kIGFub3RoZXIgaXMgUENJZQ0KPiBtb2RlLg0KPiA+IEluIFBDSWUg
bW9kZSwgaXQgYWN0IGFzIGEgUENJZSBkZXZpY2UgYW5kIHVzZSBQQ0llIHByb3RvY29sIG5vdCBU
aHVuZGVyYm9sdA0KPiBwcm90b2NvbC4NCj4gDQo+IEkgdGhpbmsgd2hhdCBDaHJpc3RvcGggd2Fz
IGFza2luZyBhYm91dCBpcyB3aHkgeW91IG5lZWQgdG8gaXNzdWUgYW55DQo+IGNvbW1hbmRzIGF0
IGFsbCBpbiBTRCBtb2RlIHdoZW4geW91IHdhbnQgdG8gdXNlIFBDSWUgbW9kZSBpbnN0ZWFkLiBX
aGF0DQo+IGhhcHBlbnMgaWYgeW91IGxvYWQgdGhlIE5WTWUgZHRocml2ZXIgYmVmb3JlIGxvYWRp
bmcgdGhlIHJ0czUyNjEgZHJpdmVyPw0KPiANCj4gICAgICAgIEFybmQNCj4gDQo+IC0tLS0tLVBs
ZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWls
Lg0KDQpSVFM1MjYxIHN1cHBvcnQgU0QgbW9kZSBhbmQgUENJZS9OVk1lIG1vZGUuIFRoZSB3b3Jr
ZmxvdyBpcyBhcyBmb2xsb3dzLg0KMS5SVFM1MjYxIHdvcmsgaW4gU0QgbW9kZS4NCjIuSWYgY2Fy
ZCBpcyBwbHVnZ2VkIGluLCBIb3N0IHNlbmQgQ01EOCB0byBhc2sgY2FyZCdzIFBDSWUgYXZhaWxh
YmlsaXR5Lg0KMy5JZiB0aGUgY2FyZCBoYXMgUENJZSBhdmFpbGFiaWxpdHksIFJUUzUyNjEgc3dp
dGNoIHRvIFBDSWUvTlZNZSBtb2RlLg0KNC5NbWMgZHJpdmVyIGV4aXQgYW5kIE5WTWUgZHJpdmVy
IHN0YXJ0IHdvcmtpbmcuDQo1LklmIGNhcmQgaXMgdW5wbHVnZ2VkLCBSVFM1MjYxIHdpbGwgc3dp
dGNoIHRvIFNEIG1vZGUuDQpXZSBzaG91bGQgc2VuZCBDTUQ4IGluIFNEIG1vZGUgdG8gYXNrIGNh
cmQncyBQQ0llIGF2YWlsYWJpbGl0eSwgYW5kIHRoZSBvcmRlciBvZiBOVk1lIGRyaXZlciBhbmQg
cnRzNTI2MSBkcml2ZXIgZG9lc24ndCBtYXR0ZXIuDQo=
