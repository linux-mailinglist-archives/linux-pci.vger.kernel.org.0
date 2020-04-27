Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9E1BA02E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgD0Jl0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 05:41:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40789 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0Jl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 05:41:26 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03R9enxgF016452, This message is accepted by code: ctaloc0852
Received: from RS-CAS01.realsil.com.cn (rsfs1.realsil.com.cn[172.29.17.2])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03R9enxgF016452
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 Apr 2020 17:40:49 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS01.realsil.com.cn
 ([::1]) with mapi id 14.03.0439.000; Mon, 27 Apr 2020 17:40:48 +0800
From:   =?gb2312?B?t+vI8Q==?= <rui_feng@realsil.com.cn>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBtbWM6IHJ0c3g6IEFkZCBTRCBFeHByZXNzIG1vZGUg?= =?gb2312?Q?support_for_RTS5261?=
Thread-Topic: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
Thread-Index: AQHWG2mdb2Wi+0TUh0G7QGay1iuqfqiL+UQAgAC/B7A=
Date:   Mon, 27 Apr 2020 09:40:48 +0000
Message-ID: <2A308283684ECD4B896628E09AF5361E028BCA26@RS-MBS01.realsil.com.cn>
References: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
 <20200427061426.GA11270@infradead.org>
In-Reply-To: <20200427061426.GA11270@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.40.150]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IE9uIFN1biwgQXByIDI2LCAyMDIwIGF0IDA5OjI1OjQ2QU0gKzA4MDAsIHJ1aV9mZW5nQHJl
YWxzaWwuY29tLmNuIHdyb3RlOg0KPiA+IEZyb206IFJ1aSBGZW5nIDxydWlfZmVuZ0ByZWFsc2ls
LmNvbS5jbj4NCj4gPg0KPiA+IFJUUzUyNjEgc3VwcG9ydCBsZWdhY3kgU0QgbW9kZSBhbmQgU0Qg
RXhwcmVzcyBtb2RlLg0KPiA+IEluIFNENy54LCBTRCBhc3NvY2lhdGlvbiBpbnRyb2R1Y2UgU0Qg
RXhwcmVzcyBhcyBhIG5ldyBtb2RlLg0KPiA+IFNEIEV4cHJlc3MgbW9kZSBpcyBkaXN0aW5ndWlz
aGVkIGJ5IENNRDguDQo+ID4gVGhlcmVmb3JlLCBDTUQ4IGhhcyBuZXcgYml0IGZvciBTRCBFeHBy
ZXNzLg0KPiA+IFNEIEV4cHJlc3MgaXMgYmFzZWQgb24gUENJZS9OVk1lLg0KPiA+IFJUUzUyNjEg
dXNlcyBDTUQ4IHRvIHN3aXRjaCB0byBTRCBFeHByZXNzIG1vZGUuDQo+IA0KPiBTbyBob3cgZG9l
cyB0aGlzIGJpdCB3b3JrPyAgVGhleSB3YXkgSSBpbWFnaW5lZCBTRCBFeHByZXNzIHRvIHdvcmsg
aXMgdGhhdA0KPiB0aGUgYWN0dWFsIFNEIENhcmQganVzdCBzaG93cyB1cCBhcyBhIHJlYWwgUENJ
ZSBkZXZpY2UsIHNpbWlsYXIgdG8gc2F5DQo+IFRodW5kZXJib2x0Lg0KDQpOZXcgU0QgRXhwcmVz
cyBjYXJkIGhhcyBkdWFsIG1vZGUuIE9uZSBpcyBTRCBtb2RlIGFuZCBhbm90aGVyIGlzIFBDSWUg
bW9kZS4NCkluIFBDSWUgbW9kZSwgaXQgYWN0IGFzIGEgUENJZSBkZXZpY2UgYW5kIHVzZSBQQ0ll
IHByb3RvY29sIG5vdCBUaHVuZGVyYm9sdCBwcm90b2NvbC4NCg==
