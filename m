Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBED2198B4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 08:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgGIGbb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 02:31:31 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:61914 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbgGIGbb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 02:31:31 -0400
Received: by ajax-webmail-mail-app2 (Coremail) ; Thu, 9 Jul 2020 14:31:17
 +0800 (GMT+08:00)
X-Originating-IP: [210.32.144.65]
Date:   Thu, 9 Jul 2020 14:31:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
Cc:     kjlu@umn.edu, "Marek Vasut" <marek.vasut+renesas@gmail.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [v2] PCI: rcar: Fix runtime PM imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200707111622.GA14935@e121166-lin.cambridge.arm.com>
References: <20200607093134.6393-1-dinghao.liu@zju.edu.cn>
 <20200707111622.GA14935@e121166-lin.cambridge.arm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <390ac334.1fb2.17332456bae.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBnEJ61uQZfvqQOAA--.2391W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwNBlZdtO+R4gAHsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbGCS07vEb7Iv0x
        C_Xr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r47MIAIbVCY0x0Ix7I2Y4AK64vIr41lV2
        xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY6xC20s026xCa
        FVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s026x8GjcxK67
        AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIAIbVCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUU==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBPbiBTdW4sIEp1biAwNywgMjAyMCBhdCAwNTozMTozM1BNICswODAwLCBEaW5naGFvIExpdSB3
cm90ZToKPiA+IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRzIHRoZSBydW50aW1lIFBN
IHVzYWdlIGNvdW50ZXIgZXZlbgo+ID4gdGhlIGNhbGwgcmV0dXJucyBhbiBlcnJvciBjb2RlLiBU
aHVzIGEgY29ycmVzcG9uZGluZyBkZWNyZW1lbnQgaXMKPiA+IG5lZWRlZCBvbiB0aGUgZXJyb3Ig
aGFuZGxpbmcgcGF0aCB0byBrZWVwIHRoZSBjb3VudGVyIGJhbGFuY2VkLgo+ID4gCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4KPiA+IC0tLQo+
ID4gCj4gPiBDaGFuZ2Vsb2c6Cj4gPiAKPiA+IHYyOiAtIFJlbW92ZSB1bm5lY2Vzc2FyeSAnZXJy
X3BtX3B1dCcgbGFiZWwuCj4gPiAgICAgICBSZWZpbmUgY29tbWl0IG1lc3NhZ2UuCj4gPiAtLS0K
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcmNhci5jIHwgNiArKy0tLS0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IENhbiB5
b3UgcmViYXNlIGl0IG9uIHRvcCBvZiB2NS44LXJjMSBhbmQgcmVzZW5kIGl0IHdpdGggWW9zaGlo
aXJvJ3MgdGFncwo+IHBsZWFzZSA/Cj4gCgpTdXJlLCBJIHdpbGwgcmVzZW5kIGl0IHNvb24uCgpS
ZWdhcmRzLApEaW5naGFvCg==
