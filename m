Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346B51DDFA9
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 08:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEVGHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 02:07:16 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:28152 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbgEVGHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 02:07:16 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Fri, 22 May 2020 14:06:51
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Fri, 22 May 2020 14:06:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Bjorn Helgaas" <helgaas@kernel.org>, "Kangjie Lu" <kjlu@umn.edu>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Vidya Sagar" <vidyas@nvidia.com>,
        "Andrew Murray" <amurray@thegoodpenguin.co.uk>,
        "Linux PCI" <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Linux PM" <linux-pm@vger.kernel.org>
Subject: Re: Re: [PATCH] [v2] PCI: tegra194: Fix runtime PM imbalance on
 error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAJZ5v0g1-WrBskdBHQ0vpWEk2E-dSaZcQsZngn84rcjcemoAAA@mail.gmail.com>
References: <20200521031355.7022-1-dinghao.liu@zju.edu.cn>
 <20200521151620.GA1135365@bjorn-Precision-5520>
 <CAJZ5v0g1-WrBskdBHQ0vpWEk2E-dSaZcQsZngn84rcjcemoAAA@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3b325121.be647.1723afdd028.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHf3j7a8deSJr8AQ--.39177W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAggIBlZdtOQP3QAAsN
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbtCS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUAVWUtwCS07vEYx0Ex4A2jsIE14v26r4j6F4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY64IIrI8v6xkF7I0E8cxan2IY04v7MIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwV
        W8AwCS07vEc2IjII80xcxEwVAKI48JMIAIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l
        V2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCFs4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67
        AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwVAFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_
        Jw0_GFylV2xY6IIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCS07vEIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIAIbVCI42IY
        6I8E87Iv67AKxVW8JVWxJwCS07vEIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
        VFxhVjvjDU=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cj4gT24gVGh1LCBNYXkgMjEsIDIwMjAgYXQgNToxNiBQTSBCam9ybiBIZWxnYWFzIDxoZWxnYWFz
QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+IFsrY2MgUmFmYWVsLCBsaW51eC1wbV0KPiA+Cj4g
PiBPbiBUaHUsIE1heSAyMSwgMjAyMCBhdCAxMToxMzo0OUFNICswODAwLCBEaW5naGFvIExpdSB3
cm90ZToKPiA+ID4gcG1fcnVudGltZV9nZXRfc3luYygpIGluY3JlbWVudHMgdGhlIHJ1bnRpbWUg
UE0gdXNhZ2UgY291bnRlciBldmVuCj4gPiA+IHdoZW4gaXQgcmV0dXJucyBhbiBlcnJvciBjb2Rl
LiBUaHVzIGEgcGFpcmluZyBkZWNyZW1lbnQgaXMgbmVlZGVkIG9uCj4gPiA+IHRoZSBlcnJvciBo
YW5kbGluZyBwYXRoIHRvIGtlZXAgdGhlIGNvdW50ZXIgYmFsYW5jZWQuCj4gPgo+ID4gSSBkaWRu
J3QgcmVhbGl6ZSB0aGVyZSB3ZXJlIHNvIG1hbnkgZHJpdmVycyB3aXRoIHRoZSBleGFjdCBzYW1l
IGlzc3VlLgo+ID4gQ2FuIHdlIGp1c3Qgc3F1YXNoIHRoZXNlIGFsbCBpbnRvIGEgc2luZ2xlIHBh
dGNoIHNvIHdlIGNhbiBzZWUgdGhlbQo+ID4gYWxsIHRvZ2V0aGVyPwo+ID4KPiA+IEhtbS4gIFRo
ZXJlIGFyZSBvdmVyIDEzMDAgY2FsbGVycyBvZiBwbV9ydW50aW1lX2dldF9zeW5jKCksIGFuZCBp
dAo+ID4gbG9va3MgbGlrZSBtYW55IG9mIHRoZW0gaGF2ZSBzaW1pbGFyIGlzc3VlcywgaS5lLiwg
dGhleSBoYXZlIGEgcGF0dGVybgo+ID4gbGlrZSB0aGlzCj4gPgo+ID4gICByZXQgPSBwbV9ydW50
aW1lX2dldF9zeW5jKGRldik7Cj4gPiAgIGlmIChyZXQgPCAwKQo+ID4gICAgIHJldHVybjsKPiA+
Cj4gPiAgIHBtX3J1bnRpbWVfcHV0KGRldik7Cj4gPgo+ID4gd2hlcmUgdGhlcmUgaXMgbm90IGEg
cG1fcnVudGltZV9wdXQoKSB0byBtYXRjaCBldmVyeQo+ID4gcG1fcnVudGltZV9nZXRfc3luYygp
LiAgUmFuZG9tIHNhbXBsZToKPiA+Cj4gPiAgIG5kczMyX3BtdV9yZXNlcnZlX2hhcmR3YXJlCj4g
PiAgIHNhdGFfcmNhcl9wcm9iZQo+ID4gICBleHlub3NfdHJuZ19wcm9iZQo+ID4gICBrc19zYV9y
bmdfcHJvYmUKPiA+ICAgb21hcF9hZXNfcHJvYmUKPiA+ICAgc3VuOGlfc3NfcHJvYmUKPiA+ICAg
b21hcF9hZXNfcHJvYmUKPiA+ICAgenlucV9ncGlvX3Byb2JlCj4gPiAgIGFtZGdwdV9od21vbl9z
aG93X3Bvd2VyX2F2Zwo+ID4gICBtdGtfY3J0Y19kZHBfaHdfaW5pdAo+ID4gICAuLi4KPiA+Cj4g
PiBTdXJlbHkgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGFuZCB0aGVzZSBhcmVuJ3QgYWxsIGJyb2tl
biwgcmlnaHQ/Cj4gCj4gSWYgdGhleSBkbyB3aGF0IHlvdSd2ZSBzYWlkLCB0aGV5IGFyZSBhbGwg
YnJva2VuIEknbSBhZnJhaWQuCj4gCj4gVGhleSBzaG91bGQgYWxsIGJlIGRvaW5nIHNvbWV0aGlu
ZyBsaWtlCj4gCj4gICAgIHJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsKPiAgICAgaWYg
KHJldCA8IDApCj4gICAgICAgICBnb3RvIG91dDsKPiAKPiAgICAgLi4uCj4gCj4gb3V0Ogo+ICAg
ICBwbV9ydW50aW1lX3B1dChkZXYpOwo+IAo+ID4gTWF5YmUgd2UgY291bGQgcHV0IHRvZ2V0aGVy
IGEgY29jY2luZWxsZSBzY3JpcHQgdG8gc2NhbiB0aGUgdHJlZSBmb3IKPiA+IHRoaXMgaXNzdWU/
Cj4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVk
dS5jbj4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRl
Z3JhMTk0LmMgfCA1ICsrLS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS10ZWdyYTE5NC5jCj4gPiA+IGluZGV4IGFlMzBhMmZkMzcxNi4uMmMwZDJjZTE2YjQ3IDEw
MDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0
LmMKPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5j
Cj4gPiA+IEBAIC0xNjIzLDcgKzE2MjMsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX3BjaWVfY29uZmln
X3JwKHN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2llKQo+ID4gPiAgICAgICByZXQgPSBwaW5jdHJs
X3BtX3NlbGVjdF9kZWZhdWx0X3N0YXRlKGRldik7Cj4gPiA+ICAgICAgIGlmIChyZXQgPCAwKSB7
Cj4gPiA+ICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gY29uZmlndXJlIHNp
ZGViYW5kIHBpbnM6ICVkXG4iLCByZXQpOwo+ID4gPiAtICAgICAgICAgICAgIGdvdG8gZmFpbF9w
aW5jdHJsOwo+ID4gPiArICAgICAgICAgICAgIGdvdG8gZmFpbF9wbV9nZXRfc3luYzsKPiA+ID4g
ICAgICAgfQo+ID4gPgo+ID4gPiAgICAgICB0ZWdyYV9wY2llX2luaXRfY29udHJvbGxlcihwY2ll
KTsKPiA+ID4gQEAgLTE2NTAsOSArMTY1MCw4IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9jb25m
aWdfcnAoc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUpCj4gPiA+Cj4gPiA+ICBmYWlsX2hvc3Rf
aW5pdDoKPiA+ID4gICAgICAgdGVncmFfcGNpZV9kZWluaXRfY29udHJvbGxlcihwY2llKTsKPiA+
ID4gLWZhaWxfcGluY3RybDoKPiA+ID4gLSAgICAgcG1fcnVudGltZV9wdXRfc3luYyhkZXYpOwo+
ID4gPiAgZmFpbF9wbV9nZXRfc3luYzoKPiA+ID4gKyAgICAgcG1fcnVudGltZV9wdXRfc3luYyhk
ZXYpOwo+IAo+IFdoeSBub3QgcG1fcnVudGltZV9wdXQoKT8QCgpHb29kIHF1ZXN0aW9uLiBGb3Ig
ZnVuY3Rpb25zIHdpdGggUE0gZGVjcmVtZW50IEFQSSBzb21ld2hlcmUsIEkgCndpbGwgYWRvcHQg
aXQuIElmIHRoaXMgQVBJIGlzIG5vdCBzdWl0YWJsZSBoZXJlLCBwbGVhc2UgdGVsbCBtZS4KCj4g
Cj4gPiA+ICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOwo+ID4gPiAgICAgICByZXR1cm4g
cmV0Owo+ID4gPiAgfQo+ID4gPiAtLQo+ID4gPiAyLjE3LjEKPiA+ID4K
