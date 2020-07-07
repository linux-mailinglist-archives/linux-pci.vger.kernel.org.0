Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D82163AC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 04:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGCOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 22:14:07 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:42968 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbgGGCOG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 22:14:06 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Tue, 7 Jul 2020 10:13:52
 +0800 (GMT+08:00)
X-Originating-IP: [210.32.144.65]
Date:   Tue, 7 Jul 2020 10:13:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
Cc:     kjlu@umn.edu, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Stanimir Varbanov" <svarbanov@mm-sol.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] PCI: qcom: fix runtime pm imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200706095821.GB26377@e121166-lin.cambridge.arm.com>
References: <20200520085837.1399-1-dinghao.liu@zju.edu.cn>
 <20200706095821.GB26377@e121166-lin.cambridge.arm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6269091e.4c120.173270d082d.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCHIARg2gNfDI4nAw--.64370W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwNBlZdtO+R4gABsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbuCS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vEFIxGxcIEc7CjxVA2Y2ka0xkIwI1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r
        4UMIAIbVCY0x0Ix7I2Y4AK64vIr41lV2xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS
        07vE4x8a6x804xWlV2xY6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14
        v26r1j6r18MIAIbVC20s026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWU
        tVW8ZwCS07vEIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIAIbVCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
        nxnUU==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRzIHRoZSBydW50aW1lIFBNIHVzYWdl
IGNvdW50ZXIgZXZlbgo+ID4gaXQgcmV0dXJucyBhbiBlcnJvciBjb2RlLiBUaHVzIGEgcGFpcmlu
ZyBkZWNyZW1lbnQgaXMgbmVlZGVkIG9uCj4gPiB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCB0byBr
ZWVwIHRoZSBjb3VudGVyIGJhbGFuY2VkLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5naGFv
IExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jIHwgMyArLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXFjb20uYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtcWNvbS5jCj4gPiBpbmRleCAxMzhlMWEyZDIxY2MuLjM1Njg2OTMwZGYxZCAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXFjb20uYwo+ID4gQEAgLTEzNDAs
OCArMTM0MCw3IEBAIHN0YXRpYyBpbnQgcWNvbV9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCj4gPiAgCXBtX3J1bnRpbWVfZW5hYmxlKGRldik7Cj4gPiAgCXJldCA9IHBt
X3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsKPiA+ICAJaWYgKHJldCA8IDApIHsKPiA+IC0JCXBtX3J1
bnRpbWVfZGlzYWJsZShkZXYpOwo+ID4gLQkJcmV0dXJuIHJldDsKPiA+ICsJCWdvdG8gZXJyX3Bt
X3J1bnRpbWVfcHV0Owo+IAo+IEkgdGhpbmsgeW91IG5lZWQgdG8gcmVtb3ZlIHRoZSBicmFja2V0
cyAtIHRoaXMgYmVjb21lIGEgc2luZ2xlIGxpbmUKPiBpZiBzdGF0ZW1lbnQuCj4gCgpUaGFuayB5
b3UgZm9yIHlvdXIgYWR2aWNlISBJIHdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbiBv
ZiBwYXRjaC4KClJlZ2FyZHMsCkRpbmdoYW8K
