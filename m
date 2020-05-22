Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1331DDEFA
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 06:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgEVEhl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 00:37:41 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:19294 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbgEVEhk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 00:37:40 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Fri, 22 May 2020 12:36:51
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Fri, 22 May 2020 12:36:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     kjlu@umn.edu, "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Vidya Sagar" <vidyas@nvidia.com>,
        "Andrew Murray" <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: Re: [PATCH] [v2] PCI: tegra194: Fix runtime PM imbalance on
 error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200521151620.GA1135365@bjorn-Precision-5520>
References: <20200521151620.GA1135365@bjorn-Precision-5520>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <b626ea1.bdecf.1723aab689f.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCnjwrjVsdexUb7AQ--.40632W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgQIBlZdtOQIGQABsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbtvS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVACI402YVCY1x02628vn2kIc2xKxwCS07vE7I0Y64k_MIAIbVCY02Avz4vE14
        v_GrylV2xY6xkI7II2jI8vz4vEwIxGrwCS07vE42xK82IY6x8ErcxFaVAv8VW8uw4UJr1U
        MIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14v26r106r1rMIAIbVC2zVAF1VAY17CE14v2
        6r1q6r43MIAIbVCI42IY6xIIjxv20xvE14v26r1j6r1xMIAIbVCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lV2xY6IIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIAIbVCI42IY
        6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUU==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sCgpJbiBmYWN0LCBtb3N0IHVzYWdlIG9mIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBp
cyBjb3JyZWN0LiBJIG1hZGUgCmEgc3RhdGljIGFuYWx5c2lzIHRvb2wgdG8gY2hlY2sgdGhpcyBp
bWJhbGFuY2UgaW4ga2VybmVsIGFuZCAKZm91bmQgYWJvdXQgODAgYnVncyBpbiBkaXJ2ZXJzLiBT
b21lIG9mIG15IHBhdGNoZXMgaGF2ZSBiZWVuIAphY2NlcHRlZCBhbmQgSSdtIHRyeWluZyB0byBw
YXRjaCB0aGUgcmVzdCBhcyBzb29uIGFzIHBvc3NpYmxlLgoKUmVnYXJkcywKRGluZ2hhbyAKCj4g
WytjYyBSYWZhZWwsIGxpbnV4LXBtXQo+IAo+IE9uIFRodSwgTWF5IDIxLCAyMDIwIGF0IDExOjEz
OjQ5QU0gKzA4MDAsIERpbmdoYW8gTGl1IHdyb3RlOgo+ID4gcG1fcnVudGltZV9nZXRfc3luYygp
IGluY3JlbWVudHMgdGhlIHJ1bnRpbWUgUE0gdXNhZ2UgY291bnRlciBldmVuCj4gPiB3aGVuIGl0
IHJldHVybnMgYW4gZXJyb3IgY29kZS4gVGh1cyBhIHBhaXJpbmcgZGVjcmVtZW50IGlzIG5lZWRl
ZCBvbgo+ID4gdGhlIGVycm9yIGhhbmRsaW5nIHBhdGggdG8ga2VlcCB0aGUgY291bnRlciBiYWxh
bmNlZC4KPiAKPiBJIGRpZG4ndCByZWFsaXplIHRoZXJlIHdlcmUgc28gbWFueSBkcml2ZXJzIHdp
dGggdGhlIGV4YWN0IHNhbWUgaXNzdWUuCj4gQ2FuIHdlIGp1c3Qgc3F1YXNoIHRoZXNlIGFsbCBp
bnRvIGEgc2luZ2xlIHBhdGNoIHNvIHdlIGNhbiBzZWUgdGhlbQo+IGFsbCB0b2dldGhlcj8KPiAK
PiBIbW0uICBUaGVyZSBhcmUgb3ZlciAxMzAwIGNhbGxlcnMgb2YgcG1fcnVudGltZV9nZXRfc3lu
YygpLCBhbmQgaXQKPiBsb29rcyBsaWtlIG1hbnkgb2YgdGhlbSBoYXZlIHNpbWlsYXIgaXNzdWVz
LCBpLmUuLCB0aGV5IGhhdmUgYSBwYXR0ZXJuCj4gbGlrZSB0aGlzCj4gCj4gICByZXQgPSBwbV9y
dW50aW1lX2dldF9zeW5jKGRldik7Cj4gICBpZiAocmV0IDwgMCkKPiAgICAgcmV0dXJuOwo+IAo+
ICAgcG1fcnVudGltZV9wdXQoZGV2KTsKPiAKPiB3aGVyZSB0aGVyZSBpcyBub3QgYSBwbV9ydW50
aW1lX3B1dCgpIHRvIG1hdGNoIGV2ZXJ5Cj4gcG1fcnVudGltZV9nZXRfc3luYygpLiAgUmFuZG9t
IHNhbXBsZToKPiAKPiAgIG5kczMyX3BtdV9yZXNlcnZlX2hhcmR3YXJlCj4gICBzYXRhX3JjYXJf
cHJvYmUKPiAgIGV4eW5vc190cm5nX3Byb2JlCj4gICBrc19zYV9ybmdfcHJvYmUKPiAgIG9tYXBf
YWVzX3Byb2JlCj4gICBzdW44aV9zc19wcm9iZQo+ICAgb21hcF9hZXNfcHJvYmUKPiAgIHp5bnFf
Z3Bpb19wcm9iZQo+ICAgYW1kZ3B1X2h3bW9uX3Nob3dfcG93ZXJfYXZnCj4gICBtdGtfY3J0Y19k
ZHBfaHdfaW5pdAo+ICAgLi4uCj4gCj4gU3VyZWx5IEknbSBtaXNzaW5nIHNvbWV0aGluZyBhbmQg
dGhlc2UgYXJlbid0IGFsbCBicm9rZW4sIHJpZ2h0Pwo+IAo+IE1heWJlIHdlIGNvdWxkIHB1dCB0
b2dldGhlciBhIGNvY2NpbmVsbGUgc2NyaXB0IHRvIHNjYW4gdGhlIHRyZWUgZm9yCj4gdGhpcyBp
c3N1ZT8KPiAKPiA+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5naGFvLmxpdUB6anUu
ZWR1LmNuPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdy
YTE5NC5jIHwgNSArKy0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLXRlZ3JhMTk0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRl
Z3JhMTk0LmMKPiA+IGluZGV4IGFlMzBhMmZkMzcxNi4uMmMwZDJjZTE2YjQ3IDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMKPiA+IEBAIC0xNjIz
LDcgKzE2MjMsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX3BjaWVfY29uZmlnX3JwKHN0cnVjdCB0ZWdy
YV9wY2llX2R3ICpwY2llKQo+ID4gIAlyZXQgPSBwaW5jdHJsX3BtX3NlbGVjdF9kZWZhdWx0X3N0
YXRlKGRldik7Cj4gPiAgCWlmIChyZXQgPCAwKSB7Cj4gPiAgCQlkZXZfZXJyKGRldiwgIkZhaWxl
ZCB0byBjb25maWd1cmUgc2lkZWJhbmQgcGluczogJWRcbiIsIHJldCk7Cj4gPiAtCQlnb3RvIGZh
aWxfcGluY3RybDsKPiA+ICsJCWdvdG8gZmFpbF9wbV9nZXRfc3luYzsKPiA+ICAJfQo+ID4gIAo+
ID4gIAl0ZWdyYV9wY2llX2luaXRfY29udHJvbGxlcihwY2llKTsKPiA+IEBAIC0xNjUwLDkgKzE2
NTAsOCBAQCBzdGF0aWMgaW50IHRlZ3JhX3BjaWVfY29uZmlnX3JwKHN0cnVjdCB0ZWdyYV9wY2ll
X2R3ICpwY2llKQo+ID4gIAo+ID4gIGZhaWxfaG9zdF9pbml0Ogo+ID4gIAl0ZWdyYV9wY2llX2Rl
aW5pdF9jb250cm9sbGVyKHBjaWUpOwo+ID4gLWZhaWxfcGluY3RybDoKPiA+IC0JcG1fcnVudGlt
ZV9wdXRfc3luYyhkZXYpOwo+ID4gIGZhaWxfcG1fZ2V0X3N5bmM6Cj4gPiArCXBtX3J1bnRpbWVf
cHV0X3N5bmMoZGV2KTsKPiA+ICAJcG1fcnVudGltZV9kaXNhYmxlKGRldik7Cj4gPiAgCXJldHVy
biByZXQ7Cj4gPiAgfQo+ID4gLS0gCj4gPiAyLjE3LjEKPiA+IAo=
