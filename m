Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51663D5119
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 03:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGZA7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Jul 2021 20:59:09 -0400
Received: from mx21.baidu.com ([220.181.3.85]:34920 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231646AbhGZA7I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Jul 2021 20:59:08 -0400
Received: from BC-Mail-Ex28.internal.baidu.com (unknown [172.31.51.22])
        by Forcepoint Email with ESMTPS id A0203B50CA94F17A9CE7;
        Mon, 26 Jul 2021 09:39:33 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex28.internal.baidu.com (172.31.51.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 26 Jul 2021 09:39:33 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Mon, 26 Jul 2021 09:39:33 +0800
From:   "Cai,Huoqing" <caihuoqing@baidu.com>
To:     "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] PCI: Make use of PCI_DEVICE_XXX() helper macro
Thread-Topic: [PATCH v3 0/2] PCI: Make use of PCI_DEVICE_XXX() helper macro
Thread-Index: AQHXf3PqYKCp/KswXE60XJC/01f+UqtUfXmg
Date:   Mon, 26 Jul 2021 01:39:33 +0000
Message-ID: <3d52da0146f24f8e980907b9cdfbedac@baidu.com>
References: <20210723033618.1025-1-caihuoqing@baidu.com>
In-Reply-To: <20210723033618.1025-1-caihuoqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.69.29]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkNCkRvIHlvdSB0aGluayBwYXRjaC12MyBpcyBPSywgIHRoYXQncyBteSBwbGVhc3VyZSBpZiB5
b3UgZ2l2ZSBtZSBzb21lIGNvbW1lbnRzIGFib3V0IHYzDQoNCkNhaQ0KdGhhbmtzDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDYWksSHVvcWluZyA8Y2FpaHVvcWluZ0BiYWlk
dS5jb20+IA0KU2VudDogMjAyMcTqN9TCMjPI1SAxMTozNg0KVG86IGt3QGxpbnV4LmNvbTsgYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb207IGxvcmVuem8ucGll
cmFsaXNpQGFybS5jb207IHJvYmhAa2VybmVsLm9yZw0KQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IENhaSxIdW9xaW5nIDxjYWlodW9x
aW5nQGJhaWR1LmNvbT4NClN1YmplY3Q6IFtQQVRDSCB2MyAwLzJdIFBDSTogTWFrZSB1c2Ugb2Yg
UENJX0RFVklDRV9YWFgoKSBoZWxwZXIgbWFjcm8NCg0KQ291bGQgbWFrZSB1c2Ugb2YgUENJX0RF
VklDRV9YWFgoKSBoZWxwZXIgbWFjcm8NCg0KdjEtPnYyOiAqZml4IGV4dHJhIGluZGVudCBmb3Ig
Z2l0LWFwcGx5IGZhaWx1cmUNCg0KdjItPnYzOiAqdXBkYXRlIHRoZSBzdWJqZWN0IGxpbmUgZnJv
bSAiZnVuY3Rpb24iIHRvICJtYWNybyINCgkqYWRkIGNoYW5nZWxvZyB0byBjb21taXQgbWVzc2Fn
ZQ0KDQpjb21taXQgZGF0ZTogNy0yMy0yMDIxIDExOjAwDQoNCkNhaSBIdW9xaW5nICgyKToNCiAg
UENJOiBNYWtlIHVzZSBvZiBQQ0lfREVWSUNFX1NVQi9fQ0xBU1MoKSBoZWxwZXIgbWFjcm8NCiAg
UENJOiB2bWQ6IE1ha2UgdXNlIG9mIFBDSV9ERVZJQ0VfREFUQSgpIGhlbHBlciBtYWNybw0KDQog
ZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyAgICAgIHwgMzggKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvcGNpL2hvdHBsdWcvY3BxcGhwX2NvcmUuYyB8IDEzICsr
LS0tLS0tLS0tDQogZHJpdmVycy9wY2kvc2VhcmNoLmMgICAgICAgICAgICAgIHwgMTQgKystLS0t
LS0tLS0tDQogaW5jbHVkZS9saW51eC9wY2lfaWRzLmggICAgICAgICAgIHwgIDIgKysNCiA0IGZp
bGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDQyIGRlbGV0aW9ucygtKQ0KDQotLSANCjIu
MjUuMQ0KDQo=
