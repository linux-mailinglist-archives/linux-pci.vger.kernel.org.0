Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9367692D67
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 03:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBKCjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 21:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCjX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 21:39:23 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 271AD79B04;
        Fri, 10 Feb 2023 18:39:20 -0800 (PST)
Received: from loongson.cn (unknown [112.20.108.204])
        by gateway (Coremail) with SMTP id _____8AxX+vX_+ZjNBsRAA--.33818S3;
        Sat, 11 Feb 2023 10:39:19 +0800 (CST)
Received: from zhoubinbin$loongson.cn ( [112.20.108.204] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Sat, 11 Feb 2023 10:39:19
 +0800 (GMT+08:00)
X-Originating-IP: [112.20.108.204]
Date:   Sat, 11 Feb 2023 10:39:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5ZGo5b2s5b2s?= <zhoubinbin@loongson.cn>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Liu Peibao" <liupeibao@loongson.cn>,
        "Huacai Chen" <chenhuacai@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Honor firmware's device disabled status
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2023 www.mailtech.cn .loongson.cn
In-Reply-To: <20230210164351.2687475-1-robh@kernel.org>
References: <20230210164351.2687475-1-robh@kernel.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: LY8admZvb3Rlcl90eHQ9MTQ4MDo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4ef29ff8.20ba1.1863e5760d2.Coremail.zhoubinbin@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8Dx0OTX_+ZjEtwwAA--.9104W
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQATCGPmM-AKWAAAsO
X-Coremail-Antispam: 1Uk129KBjvJXoW7urW8tw43Ww18tr45Xw1UWrg_yoW8WF4UpF
        ZxAayY9r18Jr1UGrZFqryjkFy5X3s7A398GFWqy3s29as8Cwn2qry3AF43Ja9xJrZ2qF13
        Zr1qqrnFga1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACY4xI67k04243AVAKzVAKj4xxM4
        xvF2IEb7IF0Fy26I8I3I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMVCEFcxC0VAYjxAxZFUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8njjPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiUm9iIEhlcnJpbmciIDxy
b2JoQGtlcm5lbC5vcmc+Cj4g5Y+R6YCB5pe26Ze0OjIwMjMtMDItMTEgMDA6NDM6NTEgKOaYn+ac
n+WFrSkKPiDmlLbku7bkuro6ICJCam9ybiBIZWxnYWFzIiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4K
PiDmioTpgIE6ICJMaXUgUGVpYmFvIiA8bGl1cGVpYmFvQGxvb25nc29uLmNuPiwgIkJpbmJpbiBa
aG91IiA8emhvdWJpbmJpbkBsb29uZ3Nvbi5jbj4sICJIdWFjYWkgQ2hlbiIgPGNoZW5odWFjYWlA
bG9vbmdzb24uY24+LCBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnCj4g5Li76aKYOiBbUEFUQ0hdIFBDSTogSG9ub3IgZmlybXdhcmUncyBkZXZp
Y2UgZGlzYWJsZWQgc3RhdHVzCj4gCj4gSWYgYSBkZXZpY2UgaGFzIGEgZmlybXdhcmUgbm9kZSAo
RFQvQUNQSSksIGFuZCB0aGUgZGV2aWNlIGlzIG1hcmtlZAo+IGRpc2FibGVkLCB0aGF0IGlzIGN1
cnJlbnRseSBpZ25vcmVkLiBBZGQgYSBjaGVjayBmb3IgdGhpcyBjb25kaXRpb24KPiBhbmQgYmFp
bCBvdXQgY3JlYXRpbmcgdGhlIHBjaV9kZXYuCj4gCj4gVGhpcyBhc3N1bWVzIHRoZSBjb25maWcg
c3BhY2UgZm9yIHRoZSBkZXZpY2UgY2FuIHN0aWxsIGJlIGFjY2Vzc2VkCj4gYmVjYXVzZSB0aGV5
IGFscmVhZHkgaGF2ZSBieSB0aGlzIHBvaW50IGluIG9yZGVyIHRvIGlkZW50aWZ5IHRoZSBkZXZp
Y2UuCj4gCj4gQ2M6IExpdSBQZWliYW8gPGxpdXBlaWJhb0Bsb29uZ3Nvbi5jbj4KPiBDYzogQmlu
YmluIFpob3UgPHpob3ViaW5iaW5AbG9vbmdzb24uY24+Cj4gQ2M6IEh1YWNhaSBDaGVuIDxjaGVu
aHVhY2FpQGxvb25nc29uLmNuPgo+IFNpZ25lZC1vZmYtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+CgpUZXN0ZWQtYnk6IEJpbmJpbiBaaG91IDx6aG91YmluYmluQGxvb25nc29uLmNu
PgoKPiAtLS0KPiBQbGVhc2UgdGVzdCBpZiB0aGlzIHdvcmtzIGZvciBMb29uZ3Nvbi4KPiAtLS0K
PiAgZHJpdmVycy9wY2kvcHJvYmUuYyB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9w
Y2kvcHJvYmUuYwo+IGluZGV4IDE3Nzk1ODJmYjUwMC4uYjFkODBjMWQ3YTY5IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMKPiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCj4gQEAg
LTE4NDEsNiArMTg0MSw4IEBAIGludCBwY2lfc2V0dXBfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpk
ZXYpCj4gIAo+ICAJcGNpX3NldF9vZl9ub2RlKGRldik7Cj4gIAlwY2lfc2V0X2FjcGlfZndub2Rl
KGRldik7Cj4gKwlpZiAoZGV2LT5kZXYuZndub2RlICYmICFmd25vZGVfZGV2aWNlX2lzX2F2YWls
YWJsZShkZXYtPmRldi5md25vZGUpKQo+ICsJCXJldHVybiAtRU5PREVWOwo+ICAKPiAgCXBjaV9k
ZXZfYXNzaWduX3Nsb3QoZGV2KTsKPiAgCj4gLS0gCj4gMi4zOS4xCg0KDQrmnKzpgq7ku7blj4rl
hbbpmYTku7blkKvmnInpvpnoiq/kuK3np5HnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDk
uo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHm
raLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDk
uo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5HvvInmnKzpgq7ku7bl
j4rlhbbpmYTku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzpgq7ku7bvvIzor7fm
gqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bj
gIIgDQpUaGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gZnJvbSBMb29uZ3NvbiBUZWNobm9sb2d5ICwgd2hpY2ggaXMgaW50ZW5kZWQg
b25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJv
dmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdh
eSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xv
c3VyZSwgcmVwcm9kdWN0aW9uIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhh
biB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZl
IHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBv
ciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0LiA=

