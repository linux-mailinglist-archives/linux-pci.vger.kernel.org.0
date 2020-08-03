Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA023A075
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 09:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgHCHrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 03:47:08 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:21874 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725844AbgHCHrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 03:47:07 -0400
X-UUID: 064ccda3e40d4eff9458a146b2cb9c8d-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+eS6fkHPCzh1BpGY8IKPY4oZzmVKv5Jj0Oov80tMj8A=;
        b=JqFr5vP+z8LsunxNDEGLdY4KezuMvR/RxJivwyS/ZoisaaAznmI7swwykZlj9ftf3a2YvyTRle4W0GXZtxxNbMVBwEdW0jXDYfFg79CNTvrcKj/YcF5RMPzGfQ3nqhhSjJxtNBfVVtuMdGHhMoqF2HHDhq79LW9h6JMUrJqmQ/Q=;
X-UUID: 064ccda3e40d4eff9458a146b2cb9c8d-20200803
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1035471897; Mon, 03 Aug 2020 15:46:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 Aug
 2020 15:46:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 15:46:45 +0800
Message-ID: <1596440772.7361.35.camel@mhfsdcap03>
Subject: Re: [PATCH v4 0/4] Split PCIe node to comply with hardware design
From:   Chuanjia Liu <Chuanjia.Liu@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        <jianjun.wang@mediatek.com>
Date:   Mon, 3 Aug 2020 15:46:12 +0800
In-Reply-To: <20200721074915.14516-1-Chuanjia.Liu@mediatek.com>
References: <20200721074915.14516-1-Chuanjia.Liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A4DEB32D28646CC8FDB1C8300E17EFCD6B509D8446129EEA2C19BE289C9AAB672000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTIxIGF0IDE1OjQ5ICswODAwLCBjaHVhbmppYS5saXUgd3JvdGU6DQo+
IFRoZXJlIGFyZSB0d28gaW5kZXBlbmRlbnQgUENJZSBjb250cm9sbGVycyBpbiBNVDI3MTIgYW5k
IE1UNzYyMg0KPiBwbGF0Zm9ybSwgYW5kIGVhY2ggb2YgdGhlbSBzaG91bGQgY29udGFpbiBhbiBp
bmRlcGVuZGVudCBNU0kNCj4gZG9tYWluLg0KPiANCj4gSW4gY3VycmVudCBhcmNoaXRlY3R1cmUs
IE1TSSBkb21haW4gd2lsbCBiZSBpbmhlcml0ZWQgZnJvbSB0aGUNCj4gcm9vdCBicmlkZ2UsIGFu
ZCBhbGwgb2YgdGhlIGRldmljZXMgd2lsbCBzaGFyZSB0aGUgc2FtZSBNU0kgZG9tYWluLg0KPiBI
ZW5jZSB0aGF0LCB0aGUgUENJZSBkZXZpY2VzIHdpbGwgbm90IHdvcmsgcHJvcGVybHkgaWYgdGhl
IGlycQ0KPiBudW1iZXIgd2hpY2ggcmVxdWlyZWQgaXMgbW9yZSB0aGFuIDMyLg0KPiANCj4gU3Bs
aXQgdGhlIFBDSWUgbm9kZSBmb3IgTVQyNzEyIGFuZCBNVDc2MjIgcGxhdGZvcm0gdG8gZml4IE1T
SQ0KPiBpc3N1ZSBhbmQgY29tcGx5IHdpdGggdGhlIGhhcmR3YXJlIGRlc2lnbi4NCg0KDQpIaSBM
b3JlbnpvLA0KDQogICAgICAgZ2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2hzZXQuDQoNCg0KICAg
ICAgIEJUVy4gSSBkb24ndCBzZWUgaXQgaW4gWzFdLGJ1dCBpcyBvayBpbiBbMl0sIEkgZG9uJ3Qg
a25vdyB3aHkuDQoNClsxXWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8NClsyXWh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvMjAyMDA3MjEwNzQ5MTUuMTQ1
MTYtMS1DaHVhbmppYS5MaXVAbWVkaWF0ZWsuY29tLw0KDQpCZXN0IFJlZ2FyZHMsDQpDaHVhbmpp
YQ0KDQo+IA0KPiBjaGFuZ2Ugbm90ZToNCj4gICB2NDpjaGFuZ2UgY29tbWl0IG1lc3NhZ2UgZHVl
IHRvIGJheWVzIHN0YXRpc3RpY2FsIGJvZ29maWx0ZXINCj4gICAgICBjb25zaWRlcnMgdGhpcyBz
ZXJpZXMgcGF0Y2ggU1BBTS4NCj4gICB2MzpyZWJhc2UgZm9yIDUuOC1yYzEuIE9ubHkgY29sbGVj
dCBhY2sgb2YgUnlkZXIsIE5vIGNvZGUgY2hhbmdlLg0KPiAgIHYyOmNoYW5nZSB0aGUgYWxsb2Nh
dGlvbiBvZiBNVDI3MTIgUENJZSBNTUlPIHNwYWNlIGR1ZSB0byB0aGUNCj4gICAgICBhbGxvY2F0
aW9uIHNpemUgaXMgbm90IHJpZ2h0IGluIHYxLg0KPiANCj4gY2h1YW5qaWEubGl1ICg0KToNCj4g
ICBkdC1iaW5kaW5nczogcGNpOiBtZWRpYXRlazogTW9kaWZpZWQgdGhlIERldmljZSB0cmVlIGJp
bmRpbmdzDQo+ICAgUENJOiBtZWRpYXRlazogVXNlIHJlZ21hcCB0byBnZXQgc2hhcmVkIHBjaWUt
Y2ZnIGJhc2UNCj4gICBhcm02NDogZHRzOiBtZWRpYXRlazogU3BsaXQgUENJZSBub2RlIGZvciBN
VDI3MTIgYW5kIE1UNzYyMg0KPiAgIEFSTTogZHRzOiBtZWRpYXRlazogTW9kaWZpZWQgTVQ3NjI5
IFBDSWUgbm9kZQ0KPiANCj4gIC4uLi9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1jZmcueWFt
bCAgICAgICB8ICAzOCArKysrKw0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlh
dGVrLXBjaWUudHh0IHwgMTQ0ICsrKysrKysrKysrLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9k
dHMvbXQ3NjI5LXJmYi5kdHMgICAgICAgICAgICAgIHwgICAzICstDQo+ICBhcmNoL2FybS9ib290
L2R0cy9tdDc2MjkuZHRzaSAgICAgICAgICAgICAgICAgfCAgMjMgKy0tDQo+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUuZHRzaSAgICAgfCAgNzUgKysrKystLS0tDQo+ICAu
Li4vZHRzL21lZGlhdGVrL210NzYyMi1iYW5hbmFwaS1icGktcjY0LmR0cyAgfCAgMTYgKy0NCj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLXJmYjEuZHRzICB8ICAgNiArLQ0K
PiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaSAgICAgIHwgIDY4ICsr
KysrKy0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMgICAgICAg
IHwgIDI1ICsrLQ0KPiAgOSBmaWxlcyBjaGFuZ2VkLCAyNTggaW5zZXJ0aW9ucygrKSwgMTQwIGRl
bGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IC4uLi9iaW5kaW5ncy9wY2kvbWVkaWF0
ZWstcGNpZS1jZmcueWFtbA0KPiANCg0K

