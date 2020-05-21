Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1E31DC568
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 05:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEUDAj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 23:00:39 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:8092 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbgEUDAj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 23:00:39 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 21 May 2020 11:00:15
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Thu, 21 May 2020 11:00:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Thierry Reding" <thierry.reding@gmail.com>, kjlu@umn.edu,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Vidya Sagar" <vidyas@nvidia.com>,
        "Andrew Murray" <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] PCI: tegra: fix runtime pm imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200520163739.GA1100601@bjorn-Precision-5520>
References: <20200520163739.GA1100601@bjorn-Precision-5520>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <a78d156.b93a0.172352c9b6e.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCXPxy_7sVerkDlAQ--.29844W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUHBlZdtOOvVwADsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbtIS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r106r15MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vEFIxGxcIEc7CjxVA2Y2ka0xkIwI1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r
        48MIAIbVCY0x0Ix7I2Y4AK64vIr41lV2xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS
        07vE4x8a6x804xWlV2xY6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14
        v26r1j6r18MIAIbVC20s026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWU
        tVW8ZwCS07vEIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIAIbVCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lV2xY6IIF0xvE
        x4A2jsIE14v26r1j6r4UMIAIbVCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73U
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIGFkdmljZS4gSSB0aGluayB0ZWdyYTE5NCBpcyBhIGdvb2QgY2hv
aWNlIGFuZCAKSSB3aWxsIHVzZSBpdCBpbiB0aGUgbmV4dCBlZGl0aW9uIG9mIHBhdGNoLgoKJnF1
b3Q7Qmpvcm4gSGVsZ2FhcyZxdW90OyAmbHQ7aGVsZ2Fhc0BrZXJuZWwub3JnJmd0O+WGmemBk++8
mgo+IE9uIFdlZCwgTWF5IDIwLCAyMDIwIGF0IDExOjU5OjA4QU0gKzAyMDAsIFRoaWVycnkgUmVk
aW5nIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWF5IDIwLCAyMDIwIGF0IDA0OjUyOjIzUE0gKzA4MDAs
IERpbmdoYW8gTGl1IHdyb3RlOg0KPiA+ID4gcG1fcnVudGltZV9nZXRfc3luYygpIGluY3JlbWVu
dHMgdGhlIHJ1bnRpbWUgUE0gdXNhZ2UgY291bnRlciBldmVuDQo+ID4gPiBpdCByZXR1cm5zIGFu
IGVycm9yIGNvZGUuIFRodXMgYSBwYWlyaW5nIGRlY3JlbWVudCBpcyBuZWVkZWQgb24NCj4gPiAN
Cj4gPiBzL2V2ZW4gaXQvZXZlbiB3aGVuIGl0Lw0KPiA+IA0KPiA+IE1pZ2h0IGFsc28gYmUgYSBn
b29kIGlkZWEgdG8gdXNlIGEgZGlmZmVyZW50IHN1YmplY3QgcHJlZml4IGJlY2F1c2UgSQ0KPiA+
IHdhcyBhbG1vc3Qgbm90IGdvaW5nIHRvIGxvb2sgYXQgdGhlIG90aGVyIHBhdGNoLCB0YWtpbmcg
dGhpcyB0byBiZSBhDQo+ID4gcmVwbGFjZW1lbnQgZm9yIGl0Lg0KPiANCj4gQW1lbi4gIFRoaXMg
d291bGQgYmUgYSBnb29kIGNoYW5nZSB0byBzdGFydCB1c2luZyAiUENJOiB0ZWdyYTE5NCIgb3IN
Cj4gc29tZXRoaW5nIGZvciBwY2llLXRlZ3JhMTk0LmMuICBPciB3aWxsIHRoZXJlIGJlIHRlZ3Jh
MTk1LCB0ZWdyYSAxOTYsDQo+IGV0YyBhZGRlZCB0byB0aGlzIGRyaXZlcj8NCj4gDQo+IEFsc28s
IHBsZWFzZSBjYXBpdGFsaXplIHRoZSBmaXJzdCB3b3JkIGFuZCAiUE0iIGluIHRoZSBzdWJqZWN0
czoNCj4gDQo+ICAgUENJOiB0ZWdyYTE5NDogRml4IHJ1bnRpbWUgUE0gaW1iYWxhbmNlIG9uIGVy
cm9yDQo+IA0KPiBCam9ybg0K
