Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE6627742
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 09:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiKNIPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 03:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiKNIO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 03:14:59 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37C9E1A209;
        Mon, 14 Nov 2022 00:14:50 -0800 (PST)
Received: from loongson.cn (unknown [223.106.24.7])
        by gateway (Coremail) with SMTP id _____8Cxrrf4+HFjItcGAA--.15924S3;
        Mon, 14 Nov 2022 16:14:48 +0800 (CST)
Received: from chenhuacai$loongson.cn ( [223.106.24.7] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Mon, 14 Nov 2022 16:14:47
 +0800 (GMT+08:00)
X-Originating-IP: [223.106.24.7]
Date:   Mon, 14 Nov 2022 16:14:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     "Liu Peibao" <liupeibao@loongson.cn>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Jianmin Lv" <lvjianmin@loongson.cn>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] PCI: loongson: Skip scanning unavailable child
 devices
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <20221114074346.23008-1-liupeibao@loongson.cn>
References: <20221114074346.23008-1-liupeibao@loongson.cn>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: zU7c12Zvb3Rlcl90eHQ9MzA3Mzo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3eb09d86.900e.1847534872f.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8Dxf+L3+HFjYWkSAA--.5102W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQAKBmNw3mQOZQAAsP
X-Coremail-Antispam: 1Uk129KBjvJXoWxAryfGr18tr4fZr4xuw17KFg_yoW5ZFW5pa
        y3Aayakr4UtFyxCanIq34UCF13Z39xG393GrZrCwn29asxu34DWFykCF1jvrZFvr40q3Wj
        vr4jgr18Ka1DtaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bvxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFcxC0V
        AYjxAxZF0Ew4CEw7xC0wACY4xI67k04243AVC20s07MxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JwCE64xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07
        jYyIUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIFBlaWJhbywKCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bkuro6ICJMaXUg
UGVpYmFvIiA8bGl1cGVpYmFvQGxvb25nc29uLmNuPgo+IOWPkemAgeaXtumXtDoyMDIyLTExLTE0
IDE1OjQzOjQ2ICjmmJ/mnJ/kuIApCj4g5pS25Lu25Lq6OiAiQmpvcm4gSGVsZ2FhcyIgPGJoZWxn
YWFzQGdvb2dsZS5jb20+LCAiUm9iIEhlcnJpbmciIDxyb2JoK2R0QGtlcm5lbC5vcmc+LCAiS3J6
eXN6dG9mIEtvemxvd3NraSIgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4sICJM
b3JlbnpvIFBpZXJhbGlzaSIgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz4sICJLcnp5c3p0b2YgV2ls
Y3p5xYRza2kiIDxrd0BsaW51eC5jb20+LCAiSmlheHVuIFlhbmciIDxqaWF4dW4ueWFuZ0BmbHln
b2F0LmNvbT4sICJDaHJpc3RvcGhlIEpBSUxMRVQiIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRv
by5mcj4KPiDmioTpgIE6ICJIdWFjYWkgQ2hlbiIgPGNoZW5odWFjYWlAbG9vbmdzb24uY24+LCAi
Smlhbm1pbiBMdiIgPGx2amlhbm1pbkBsb29uZ3Nvbi5jbj4sICJZaW5ibyBaaHUiIDx6aHV5aW5i
b0Bsb29uZ3Nvbi5jbj4sIHdhbmdob25nbGlhbmcgPHdhbmdob25nbGlhbmdAbG9vbmdzb24uY24+
LCAiTGl1IFBlaWJhbyIgPGxpdXBlaWJhb0Bsb29uZ3Nvbi5jbj4sIGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiDkuLvpopg6IFtQQVRDSCBW
NV0gUENJOiBsb29uZ3NvbjogU2tpcCBzY2FubmluZyB1bmF2YWlsYWJsZSBjaGlsZCBkZXZpY2Vz
Cj4gCj4gVGhlIFBDSSBDb250cm9sbGVyIG9mIDJLMTAwMCBjb3VsZCBub3QgbWFzayBkZXZpY2Vz
IGJ5IHNldHRpbmcgdmVuZGVyIElEIG9yCkkgdGhpbmsgdGhpcyBwYXRjaCBpcyBuZWVkZWQgYnkg
Ym90aCBMUzJLNTAwIGFuZCBMUzJLMTAwMCwgc28gcmVwbGFjZSAySzEwMDAgd2l0aCAiTFMySyIg
b3IgIkxvb25nc29uLTJLIiBvciAiTFMySzUwMC9MUzJLMTAwMCIgbWF5YmUgYmV0dGVyLiBJZiBu
ZXcgdmVyc2lvbiBpcyBuZWVkZWQsIHBsZWFzZSBjaGFuZ2UgdGhpcywgdGhhbmtzLgoKSHVhY2Fp
Cgo+IGRldmljZSBJRCBpbiBjb25maWd1cmF0aW9uIHNwYWNlIGhlYWRlciBhcyBpbnZhbGlkIHZh
bHVlcy4gV2hlbiB0aGVyZSBhcmUKPiBwaW5zIHNoYXJlYWJsZSBiZXR3ZWVuIHRoZSBwbGF0Zm9y
bSBkZXZpY2UgYW5kIHRoZSBvbiBjaGlwIFBDSSBkZXZpY2UsIGlmCj4gdGhlIHBsYXRmb3JtIGRl
dmljZSBpcyBwcmVmZXJyZWQsIHdlIHNob3VsZCBub3Qgc2NhbiB0aGlzIFBDSSBkZXZpY2UuIElu
Cj4gdGhlIGFib3ZlIHNjZW5lLCBhZGQgYHN0YXR1cyA9ICJkaXNhYmxlZCJgIHByb3BlcnR5IGlu
IERUIG5vZGUgb2YgdGhpcyBQQ0kKPiBkZXZpY2UuCj4gCj4gQmVmb3JlIHRoaXMgcGF0Y2gsIHRv
IHNvbHZlIHRoZSBhYm92ZSBwcm9ibGVtLCB3ZSB0cmVhdCB0aGUgb24gY2hpcCBQQ0kKPiBkZXZp
Y2VzIGFzIHBsYXRmb3JtIGRldmljZXMgd2l0aCBmaXhlZCBhZGRyZXNzIGFzc2lnbmVkIGJ5IHRo
ZSBCSU9TLiBXaGVuCj4gdGhlcmUgaXMgZGV2aWNlIG5vdCBwcmVmZXJyZWQsIGFkZCB0aGUgYHN0
YXR1cyA9ICJkaXNhYmxlZCJgIHByb3BlcnR5IGluIERUCj4gbm9kZS4gSW4ga2VybmVsLCB0aGUg
UENJIGhvc3QgYnJpZGdlIG9ubHkgc2NhbnMgc2xvdCA5L0EvQi9DL0QvRSB0aGF0IGFyZQo+IGJy
aWRnZXMuIE92ZXJhbGwsIHRoaXMgbG9va3Mgbm90IG11Y2ggZWxlZ2FudC4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBMaXUgUGVpYmFvIDxsaXVwZWliYW9AbG9vbmdzb24uY24+Cj4gLS0tCj4gVjQgLT4g
VjU6IG1ha2UgdGhlIGlzc3VlIHdlIGFyZSBmYWNpbmcgY2xlYXIgaW4gY29tbWl0IGxvZy4KPiBW
MyAtPiBWNDogMS4gZ2V0IHJpZCBvZiB0aGUgbWFza2xpc3QgYW5kIHNlYXJjaCB0aGUgc3RhdHVz
IHByb3BlcnR5Cj4gCSAgZGlyZWN0bHkuCj4gICAgICAgICAgIDIuIGNoZWNrIHRoZSBzdGF0dXMg
cHJvcGVydHkgb25seSB3aGVuIGFjY2Vzc2luZyB0aGUgdmVuZG9yIElELgo+IFYyIC0+IFYzOiAx
LiB1c2UgbGlzdF9mb3JfZWFjaF9lbnRyeSgpIGZvciBtb3JlIGNsZWFybHkuCj4gICAgICAgICAg
IDIuIGZpeCB3cm9uZyB1c2Ugb2Ygc2l6ZW9mKCkuCj4gVjEgLT4gVjI6IHVzZSBleGlzdGluZyBw
cm9wZXJ0eSAic3RhdHVzIiBpbnN0ZWFkIG9mIGFkZGluZyBuZXcgcHJvcGVydHkuCj4gCj4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWxvb25nc29uLmMgfCAxMSArKysrKysrKysrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaS1sb29uZ3Nvbi5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2ktbG9vbmdzb24uYwo+IGluZGV4IDA1YzUwNDA4ZjEzYi4uZWZjYTBiM2I1YTI5IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWxvb25nc29uLmMKPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1sb29uZ3Nvbi5jCj4gQEAgLTE5NCw2ICsxOTQsMTcgQEAg
c3RhdGljIHZvaWQgX19pb21lbSAqcGNpX2xvb25nc29uX21hcF9idXMoc3RydWN0IHBjaV9idXMg
KmJ1cywKPiAgCQkJcmV0dXJuIE5VTEw7Cj4gIAl9Cj4gIAo+ICsjaWZkZWYgQ09ORklHX09GCj4g
KwkvKiBEb24ndCBhY2Nlc3MgZGlzYWJsZWQgZGV2aWNlcy4gKi8KPiArCWlmIChwY2lfaXNfcm9v
dF9idXMoYnVzKSAmJiB3aGVyZSA9PSBQQ0lfVkVORE9SX0lEKSB7Cj4gKwkJc3RydWN0IGRldmlj
ZV9ub2RlICpkbjsKPiArCj4gKwkJZG4gPSBvZl9wY2lfZmluZF9jaGlsZF9kZXZpY2UoYnVzLT5k
ZXYub2Zfbm9kZSwgZGV2Zm4pOwo+ICsJCWlmIChkbiAmJiAhb2ZfZGV2aWNlX2lzX2F2YWlsYWJs
ZShkbikpCj4gKwkJCXJldHVybiBOVUxMOwo+ICsJfQo+ICsjZW5kaWYKPiArCj4gIAkvKiBDRkcw
IGNhbiBvbmx5IGFjY2VzcyBzdGFuZGFyZCBzcGFjZSAqLwo+ICAJaWYgKHdoZXJlIDwgUENJX0NG
R19TUEFDRV9TSVpFICYmIHByaXYtPmNmZzBfYmFzZSkKPiAgCQlyZXR1cm4gY2ZnMF9tYXAocHJp
diwgYnVzLCBkZXZmbiwgd2hlcmUpOwo+IC0tIAo+IDIuMjAuMQoNCg0K5pys6YKu5Lu25Y+K5YW2
6ZmE5Lu25ZCr5pyJ6b6Z6Iqv5Lit56eR55qE5ZWG5Lia56eY5a+G5L+h5oGv77yM5LuF6ZmQ5LqO
5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB5q2i
5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO
5YWo6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu5Lu25Y+K
5YW26ZmE5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM6K+35oKo
56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu244CC
IA0KVGhpcyBlbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGlu
Zm9ybWF0aW9uIGZyb20gTG9vbmdzb24gVGVjaG5vbG9neSAsIHdoaWNoIGlzIGludGVuZGVkIG9u
bHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3Zl
LiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkg
KGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1
cmUsIHJlcHJvZHVjdGlvbiBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4g
dGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0
aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3Ig
ZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdC4g

