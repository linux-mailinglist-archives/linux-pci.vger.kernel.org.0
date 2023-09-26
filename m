Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0F7AE3A4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 04:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjIZCVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 22:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjIZCVp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 22:21:45 -0400
X-Greylist: delayed 71946 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 19:21:37 PDT
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BB24BF;
        Mon, 25 Sep 2023 19:21:37 -0700 (PDT)
Received: from dinghao.liu$zju.edu.cn ( [10.192.76.118] ) by
 ajax-webmail-mail-app3 (Coremail) ; Tue, 26 Sep 2023 10:21:13 +0800
 (GMT+08:00)
X-Originating-IP: [10.192.76.118]
Date:   Tue, 26 Sep 2023 10:21:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Marc Zyngier" <maz@kernel.org>
Cc:     "Toan Le" <toan@os.amperecomputing.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>, "Duc Dang" <dhdang@apm.com>,
        "Tanmay Inamdar" <tinamdar@apm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene-msi: Fix a potential UAF in xgene_msi_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <87o7hqmvz3.wl-maz@kernel.org>
References: <20230925062133.14170-1-dinghao.liu@zju.edu.cn>
 <87o7hqmvz3.wl-maz@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1c50637d.3e6d5.18acf4a638c.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgBXWRwaQBJlmv3eAA--.28221W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEJBmUQRiAzPQAGsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBPbiBNb24sIDI1IFNlcCAyMDIzIDA3OjIxOjMyICswMTAwLAo+IERpbmdoYW8gTGl1IDxkaW5n
aGFvLmxpdUB6anUuZWR1LmNuPiB3cm90ZToKPiA+IAo+ID4geGdlbmVfYWxsb2NhdGVfZG9tYWlu
cygpIHdpbGwgY2FsbCBpcnFfZG9tYWluX3JlbW92ZSgpIHRvIGZyZWUKPiA+IG1zaS0+aW5uZXJf
ZG9tYWluIG9uIGZhaWx1cmUuIEhvd2V2ZXIsIGl0cyBjYWxsZXIsIHhnZW5lX21zaV9wcm9iZSgp
LAo+ID4gd2lsbCBhbHNvIGNhbGwgaXJxX2RvbWFpbl9yZW1vdmUoKSB0aHJvdWdoIHhnZW5lX21z
aV9yZW1vdmUoKSBvbiB0aGUKPiA+IHNhbWUgZmFpbHVyZSwgd2hpY2ggbWF5IGxlYWQgdG8gYSB1
c2UtYWZ0ZXItZnJlZS4gU2V0IHRoZSBmcmVlZCBwb2ludGVyCj4gPiB0byBOVUxMIHRvIGZpeCB0
aGlzIGlzc3VlLgo+ID4gCj4gPiBGaXhlczogZGNkMTlkZTM2Nzc1ICgiUENJOiB4Z2VuZTogQWRk
IEFQTSBYLUdlbmUgdjEgUENJZSBNU0kvTVNJWCB0ZXJtaW5hdGlvbiBkcml2ZXIiKQo+ID4gU2ln
bmVkLW9mZi1ieTogRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+Cj4gPiAtLS0K
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS14Z2VuZS1tc2kuYyB8IDEgKwo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2kteGdlbmUtbXNpLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaS14Z2VuZS1tc2kuYwo+ID4gaW5kZXggM2NlMzhkZmQwZDI5Li5jMDE5MmM1ZmYwZjMgMTAw
NjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS14Z2VuZS1tc2kuYwo+ID4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2kteGdlbmUtbXNpLmMKPiA+IEBAIC0yNTMs
NiArMjUzLDcgQEAgc3RhdGljIGludCB4Z2VuZV9hbGxvY2F0ZV9kb21haW5zKHN0cnVjdCB4Z2Vu
ZV9tc2kgKm1zaSkKPiA+ICAKPiA+ICAJaWYgKCFtc2ktPm1zaV9kb21haW4pIHsKPiA+ICAJCWly
cV9kb21haW5fcmVtb3ZlKG1zaS0+aW5uZXJfZG9tYWluKTsKPiA+ICsJCW1zaS0+aW5uZXJfZG9t
YWluID0gTlVMTDsKPiA+ICAJCXJldHVybiAtRU5PTUVNOwo+ID4gIAl9Cj4gCj4gV2h5IGNhbid0
IHdlIGp1c3QgZHJvcCB0aGUgaXJxX2RvbWFpbl9yZW1vdmUoKSBjYWxsIGhlcmUgaW5zdGVhZCwg
YW5kCj4gc2ltcGx5IHJlbHkgb24geGdlbmVfbXNpX3JlbW92ZSgpIHRvIGRvIHRoZSByaWdodCB0
aGluZz8gU29tZXRoaW5nCj4gbGlrZSB0aGUgdW50ZXN0ZWQgcGF0Y2ggYmVsb3cuCj4gCj4gVGhh
bmtzLAo+IAo+IAlNLgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aS14Z2VuZS1tc2kuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLXhnZW5lLW1zaS5jCj4g
aW5kZXggMDIzNGU1MjhiOWE1Li5mOThjOWViN2JlYmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2kteGdlbmUtbXNpLmMKPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaS14Z2VuZS1tc2kuYwo+IEBAIC0yNTEsMTAgKzI1MSw4IEBAIHN0YXRpYyBpbnQgeGdl
bmVfYWxsb2NhdGVfZG9tYWlucyhzdHJ1Y3QgeGdlbmVfbXNpICptc2kpCj4gIAkJCQkJCSAgICAm
eGdlbmVfbXNpX2RvbWFpbl9pbmZvLAo+ICAJCQkJCQkgICAgbXNpLT5pbm5lcl9kb21haW4pOwo+
ICAKPiAtCWlmICghbXNpLT5tc2lfZG9tYWluKSB7Cj4gLQkJaXJxX2RvbWFpbl9yZW1vdmUobXNp
LT5pbm5lcl9kb21haW4pOwo+ICsJaWYgKCFtc2ktPm1zaV9kb21haW4pCj4gIAkJcmV0dXJuIC1F
Tk9NRU07Cj4gLQl9Cj4gIAo+ICAJcmV0dXJuIDA7Cj4gIH0KClRoYW5rcyBmb3IgeW91ciBhZHZp
Y2UhIFRoaXMgcGF0Y2ggaXMgbW9yZSBjb25jaXNlLiBJIHdpbGwgcmVzZW5kIGEgbmV3IHBhdGNo
IHNvb24uCgpSZWdhcmRzLApEaW5naGFvCg==
