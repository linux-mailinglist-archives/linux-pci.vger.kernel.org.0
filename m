Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5935DB5A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 04:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGCCHy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 22:07:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2963 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGCCHy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 22:07:54 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id BA99EBBF4176F5607A9F;
        Wed,  3 Jul 2019 10:07:52 +0800 (CST)
Received: from dggeme716-chm.china.huawei.com (10.1.199.112) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jul 2019 10:07:52 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme716-chm.china.huawei.com (10.1.199.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 3 Jul 2019 10:07:52 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1591.008;
 Wed, 3 Jul 2019 10:07:52 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>
Subject: Re: [PATCH] net: pci: Fix hotplug event timeout with shpchp
Thread-Topic: [PATCH] net: pci: Fix hotplug event timeout with shpchp
Thread-Index: AdUxQ4Ot2MsgjZ40Rim/5d9K2wgLog==
Date:   Wed, 3 Jul 2019 02:07:51 +0000
Message-ID: <fdbaef22bd774ee49fc58fe13a76bf91@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpPbiBUdWUsIEp1bCAwMiwgMjAxOSBhdCAwMTozNToxOVBNICswMDAwLCBNaWFvaGUgTGluIHdy
b3RlOg0KPiA+IEhvdHBsdWcgYSBuZXR3b3JrIGNhcmQgd291bGQgdGFrZSBtb3JlIHRoYW4gNSBz
ZWNvbmRzIGluIHFlbXUgKyBzaHBjaHAgDQo+ID4gc2NlbmUuIEl04oCZcyBiZWNhdXNlIDUgc2Vj
b25kcyBkZWxheWVkX3dvcmsgaW4gZnVuYyANCj4NCj4gSSdtIGRyb3BwaW5nIHRoaXMgYmVjYXVz
ZSBvZiB0aGUgcmVxdWlyZWQgZGVsYXkgcG9pbnRlZCBvdXQgYnkgTHVrYXMuDQo+DQo+IElmIHlv
dSB0aGluayB3ZSBzdGlsbCBuZWVkIHRvIGRvIHNvbWV0aGluZyBoZXJlLCBwbGVhc2UgY2xhcmlm
eSB0aGUgc2l0dWF0aW9uLiAgQXJlIHlvdSBob3QtYWRkaW5nPyAgSG90LXN3YXBwaW5nPyAgU2lu
Y2UgeW91IG1lbnRpb24gYSBwcm90b2NvbCB0aW1lb3V0LCBJIHN1c3BlY3QgdGhlIGxhdHRlciwg
ZS5nLiwgbWF5YmUgeW91IGhhZCBhbiBleGlzdGluZyBkZXZpY2Ugd2l0aCBjb25uZWN0aW9ucyBh
bHJlYWR5IG9wZW4sIGFuZCB5b3Ugd2FudCB0byByZXBsYWNlIGl0IHdpdGggYSBuZXcgZGV2aWNl
DQo+IFdlIGRvIGhhdmUgdG8gcHJlc2VydmUgdGhlIGV4aXN0aW5nIHVzZXIgZXhwZXJpZW5jZSwg
ZS5nLiwgZGVsYXlzIHRvIGFsbG93IG9wZXJhdG9ycyB0byByZWNvdmVyIGZyb20gbWlzdGFrZW4g
bGF0Y2ggb3BlbnMgb3IgYnV0dG9uIHByZXNzZXMuICBCdXQgaWYgd2Uga25ldyBtb3JlIGFib3V0
IHdoYXQgeW91J3JlIHRyeWluZyB0byBkbywgbWF5YmUgd2UgY291bGQgZmlndXJlIG91dCBhbm90
aGVyIGFwcHJvYWNoLg0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuIEFzIGlzIHNwZWMgcmVxdWly
ZWQsIHdlIHdvdWxkIHRyeSB0byB3b3JrIGFyb3VuZCBpdC4NCk1hbnkgdGhhbmtzLg0KDQpIYXZl
IGEgZ29vZCBkYXkuDQpCZXN0IHdpc2hlcy4NCg==
