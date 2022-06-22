Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C189655401A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 03:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347111AbiFVBdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 21:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiFVBdX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 21:33:23 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35C2EE022;
        Tue, 21 Jun 2022 18:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=sShTk
        Lp3LVO89fQdVMgE2NVwkqKEDmFZ37s7+17110E=; b=W1IftgE8BRG3oCBW47WFt
        M8PcCz3gWBkDxr5UWJFnq74eYp6ww5XK3FV5+fiWywCSIclQi6yxO3vELCqBBVC+
        C40mMVVRvUnAgqq9s9zT8BE+oZ9HiNmhUHry+ku4xZ+OcrbKdao+QnRyXOHoHzRF
        yFO9i9tfg6nw3QsvI3umRg=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Wed, 22 Jun 2022 09:32:49 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Wed, 22 Jun 2022 09:32:49 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re:Re: [PATCH] pci/controller/pcie-rcar-host: Hold the reference
 returned by of_find_matching_node
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220621224952.GA1340618@bhelgaas>
References: <20220621224952.GA1340618@bhelgaas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6bd59186.1180.181890a696d.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowAB3hiZCcbJiUV86AA--.950W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BcoF1pEDxgVIAABsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKQXQgMjAyMi0wNi0yMiAwNjo0OTo1MiwgIkJqb3JuIEhlbGdhYXMiIDxoZWxnYWFzQGtlcm5l
bC5vcmc+IHdyb3RlOgo+T24gVHVlLCBKdW4gMjEsIDIwMjIgYXQgMDM6MDE6NDVQTSArMDgwMCwg
TGlhbmcgSGUgd3JvdGU6Cj4+IEluIHJjYXJfcGNpZV9pbml0KCksIHdlIG5lZWQgdG8gaG9sZCB0
aGUgcmVmZXJlbmNlIHJldHVybmVkIGJ5Cj4+IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZSgpIHdoaWNo
IGlzIHVzZWQgdG8gY2FsbCBvZl9ub2RlX3B1dCgpIGZvcgo+PiByZWZjb3VudCBiYWxhbmNlLgo+
PiAKPj4gU2lnbmVkLW9mZi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPgo+PiAtLS0KPj4g
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yY2FyLWhvc3QuYyB8IDUgKysrKy0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4gCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcmNhci1ob3N0LmMgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtcmNhci1ob3N0LmMKPj4gaW5kZXggOTk3YzRkZjZhMWU3Li40
MDVlYzNkNjRmMzAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1y
Y2FyLWhvc3QuYwo+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcmNhci1ob3N0
LmMKPj4gQEAgLTExNTgsNyArMTE1OCwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCByY2FyX3BjaWVfYWJvcnRfaGFuZGxlcl9vZl9tYXRjaFtdIF9faW5pdGNvbnN0Cj4+ICAK
Pj4gIHN0YXRpYyBpbnQgX19pbml0IHJjYXJfcGNpZV9pbml0KHZvaWQpCj4+ICB7Cj4+IC0JaWYg
KG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZShOVUxMLCByY2FyX3BjaWVfYWJvcnRfaGFuZGxlcl9vZl9t
YXRjaCkpIHsKPj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gb2ZfZmluZF9tYXRjaGluZ19u
b2RlKE5VTEwsIHJjYXJfcGNpZV9hYm9ydF9oYW5kbGVyX29mX21hdGNoKTsKPj4gKwo+PiArCWlm
IChucCkgewo+PiArCQlvZl9ub2RlX3B1dChucCk7Cj4KPkkgdGhpbmsgdGhpcyBpcyBjb3JyZWN0
LCBidXQgaXQgd291bGQgYmUgbmljZXIgdG8gdXBkYXRlIHRoZSB3YXkgdGhpcwo+ZHJpdmVyIHVz
ZXMgb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCksIGUuZy4sCj4KPiAgc3RydWN0IHJjYXJfdmFy
aWFudCB7Cj4gICAgaW50ICgqcGh5X2luaXRfZm4pKHN0cnVjdCByY2FyX3BjaWVfaG9zdCAqaG9z
dCk7Cj4gICAgYm9vbCBob29rX2Fib3J0Owo+ICB9Owo+Cj4gIHN0cnVjdCByY2FyX3BjaWVfaG9z
dCB7Cj4gICAgLi4uCj4gICAgY29uc3Qgc3RydWN0IHJjYXJfdmFyaWFudCAqdmFyaWFudDsKPiAg
fTsKPgo+ICBzdGF0aWMgaW50IHJjYXJfcGNpZV9wcm9iZSguLi4pCj4gIHsKPiAgICBob3N0LT52
YXJpYW50ID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7Cj4gICAgZXJyID0gaG9zdC0+
dmFyaWFudC0+cGh5X2luaXRfZm4oaG9zdCk7Cj4gICAgLi4uCj4KPiAgI2lmZGVmIENPTkZJR19B
Uk0KPiAgICBpZiAoaG9zdC0+dmFyaWFudC0+aG9va19hYm9ydCkgewo+ICAjaWZkZWYgQ09ORklH
X0FSTV9MUEFFCj4gICAgICBob29rX2ZhdWx0X2NvZGUoMTcsIC4uLik7Cj4gICMgZWxzZQo+ICAg
ICAgaG9va19mYXVsdF9jb2RlKDIyLCAuLi4pOwo+ICAjZW5kaWYKPiAgICB9Cj4gICNlbmRpZgo+
ICB9Cj4KPk9yIGtlZXAgdGhlIGhvb2sgaW4gYSBzZXBhcmF0ZSBmdW5jdGlvbiBjYWxsZWQgZnJv
bSByY2FyX3BjaWVfcHJvYmUoKQo+aWYgeW91IHRoaW5rIHRoYXQncyBjbGVhbmVyLgo+Cj5JJ20g
bm90IHN1cmUgaG9va19mYXVsdF9jb2RlKCkgbmVlZHMgdG8gYmUgY2FsbGVkIHNlcGFyYXRlbHkg
YXMgYQo+ZGV2aWNlX2luaXRjYWxsKCkuICBUaGUgcGNpLWl4cDR4eC5jIGRyaXZlciBkb2VzIGl0
IGluCj5peHA0eHhfcGNpX3Byb2JlKCksIHNvIEkgYXNzdW1lIHJjYXIgY291bGQgZG8gaXQgaW4g
cHJvYmUgYXMgd2VsbC4KPgo+PiAgI2lmZGVmIENPTkZJR19BUk1fTFBBRQo+PiAgCQlob29rX2Zh
dWx0X2NvZGUoMTcsIHJjYXJfcGNpZV9hYXJjaDMyX2Fib3J0X2hhbmRsZXIsIFNJR0JVUywgMCwK
Pj4gIAkJCQkiYXN5bmNocm9ub3VzIGV4dGVybmFsIGFib3J0Iik7Cj4+IC0tIAo+PiAyLjI1LjEK
Pj4gCgpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGVmZm9ydCB0byByZXZpZXcgbXkgcGF0Y2gu
CgpOb3cgSSBhbSB2ZXJ5IHNvcnJ5IHRoYXQgSSBvbmx5IGtub3cgaG93IHRvIGNvcnJlY3RseSB1
c2Ugb2ZfZmluZF94eHggQVBJcyAKYW5kIHdoZW4gdGhlcmUgd2lsbCBiZSBhIGxlYWsgYnVnLgoK
SW4gYW5vdGhlciB3b3JkLCBJIGhhdmUgbm8gaWRlYSB0aGUgZGV0YWlscyBvZiB0aGUgZHJpdmVy
cyBhbmQgSSBjYW5ub3QgZG8gCmFueW90aGVyIHRoaW5nIHRoYW4gIGp1c3QgZml4IHRoZSBsZWFr
IGJ1ZyBjYXVzZWQgYnkgbWlzc2luZyBvZl9ub2RlX3B1dCgpLgoKU29ycnkgYWdhaW4uCgpMaWFu
Zw==
