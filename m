Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E21F1DC572
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 05:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgEUDGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 23:06:46 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:8798 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbgEUDGq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 23:06:46 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 21 May 2020 11:06:26
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Thu, 21 May 2020 11:06:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Thierry Reding" <thierry.reding@gmail.com>
Cc:     kjlu@umn.edu, "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
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
In-Reply-To: <20200520095908.GD2136208@ulmo>
References: <20200520085231.32552-1-dinghao.liu@zju.edu.cn>
 <20200520095908.GD2136208@ulmo>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <54ce423c.b9436.172353245da.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCXPxwy8MVexFjlAQ--.29859W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUHBlZdtOOvVwAEsm
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbtvS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUGVWUXwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY64IIrI8v6xkF7I0E8cxan2IY04v7MIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwV
        W8GwCS07vEc2IjII80xcxEwVAKI48JMIAIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l
        V2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCFs4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67
        AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwVAFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_
        Jw0_GFylV2xY6IIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCS07vEIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIAIbVCI42IY
        6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUU==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIGFkdmljZS4gSSB3aWxsIGZpeCB0aGVzZSBwcm9ibGVtcyBpbiB0
aGUgbmV4dCBlZGl0aW9uIG9mIHBhdGNoLgoKJnF1b3Q7VGhpZXJyeSBSZWRpbmcmcXVvdDsgJmx0
O3RoaWVycnkucmVkaW5nQGdtYWlsLmNvbSZndDvlhpnpgZPvvJoKPiBPbiBXZWQsIE1heSAyMCwg
MjAyMCBhdCAwNDo1MjoyM1BNICswODAwLCBEaW5naGFvIExpdSB3cm90ZToNCj4gPiBwbV9ydW50
aW1lX2dldF9zeW5jKCkgaW5jcmVtZW50cyB0aGUgcnVudGltZSBQTSB1c2FnZSBjb3VudGVyIGV2
ZW4NCj4gPiBpdCByZXR1cm5zIGFuIGVycm9yIGNvZGUuIFRodXMgYSBwYWlyaW5nIGRlY3JlbWVu
dCBpcyBuZWVkZWQgb24NCj4gDQo+IHMvZXZlbiBpdC9ldmVuIHdoZW4gaXQvDQo+IA0KPiBNaWdo
dCBhbHNvIGJlIGEgZ29vZCBpZGVhIHRvIHVzZSBhIGRpZmZlcmVudCBzdWJqZWN0IHByZWZpeCBi
ZWNhdXNlIEkNCj4gd2FzIGFsbW9zdCBub3QgZ29pbmcgdG8gbG9vayBhdCB0aGUgb3RoZXIgcGF0
Y2gsIHRha2luZyB0aGlzIHRvIGJlIGENCj4gcmVwbGFjZW1lbnQgZm9yIGl0Lg0KPiANCj4gQWx0
aG91Z2gsIGxvb2tpbmcgYXQgdGhlIGxvZyB3ZSBoYXZlIHVzZWQgdGhpcyBzYW1lIHByZWZpeCBm
b3IgYm90aA0KPiBkcml2ZXJzIGluIHRoZSBwYXN0Li4uDQo+IA0KPiA+IHRoZSBlcnJvciBoYW5k
bGluZyBwYXRoIHRvIGtlZXAgdGhlIGNvdW50ZXIgYmFsYW5jZWQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyB8IDIgKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQu
YyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiA+IGluZGV4
IGFlMzBhMmZkMzcxNi4uYTY5ZjllNDlkY2I1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiA+IEBAIC0xNjUxLDggKzE2NTEsOCBAQCBz
dGF0aWMgaW50IHRlZ3JhX3BjaWVfY29uZmlnX3JwKHN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2ll
KQ0KPiA+ICBmYWlsX2hvc3RfaW5pdDoNCj4gPiAgCXRlZ3JhX3BjaWVfZGVpbml0X2NvbnRyb2xs
ZXIocGNpZSk7DQo+ID4gIGZhaWxfcGluY3RybDoNCj4gPiAtCXBtX3J1bnRpbWVfcHV0X3N5bmMo
ZGV2KTsNCj4gPiAgZmFpbF9wbV9nZXRfc3luYzoNCj4gDQo+IEVpdGhlciBvZiB0aG9zZSB0d28g
bGFiZWxzIGlzIG5vdyBubyBsb25nZXIgbmVlZGVkLiBPZiBjb3Vyc2UgaXQnbGwgbm93DQo+IGJl
IG9kZCB0byBqdW1wIHRvIGZhaWxfcG1fZ2V0X3N5bmMgb24gcGluY3RybF9wbV9zZWxlY3RfZGVm
YXVsdF9zdGF0ZSgpDQo+IGZhaWx1cmUsIGJ1dCB0aGF0J3Mgb25lIG9mIHRoZSByZWFzb25zIHdo
eSBsYWJlbCBzaG91bGQgaGF2ZSBuYW1lcw0KPiBkZXNjcmliaW5nIHdoYXQgdGhleSBkbyByYXRo
ZXIgdGhhbiBkZXNjcmliZSB0aGUgZmFpbHVyZSBsb2NhdGlvbi4gSQ0KPiBndWVzcyB3ZSBjYW4g
bGl2ZSB3aXRoIHRoYXQgZm9yIG5vdy4gSSdsbCBtYWtlIGEgbm90ZSB0byBzZW5kIGEgY2xlYW51
cA0KPiBwYXRjaCBmb3IgdGhhdCBsYXRlciBvbi4NCj4gDQo+IFdpdGggdGhlIGZpeHVwIGluIHRo
ZSBjb21taXQgbWVzc2FnZSBhbmQgZWl0aGVyIG9mIHRoZSBsYWJlbHMgcmVtb3ZlZDoNCj4gDQo+
IEFja2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPg0K
