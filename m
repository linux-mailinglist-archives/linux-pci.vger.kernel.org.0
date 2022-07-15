Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740AC575882
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiGOAHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiGOAHG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:07:06 -0400
Received: from m151.mail.126.com (m151.mail.126.com [220.181.15.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D198735AE
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=zSJN9
        W3O4eTfltL8WpEi1Y771OZA3vzv1F3fSf/UHm8=; b=iczy0N/7Jz1PaLYY1o8oq
        PwlPzDrZttl0Y1hKv0PiCtNAfWuunDpS6n2wul2ilgbElgmU4xeUnrzxmc+wIpPW
        WVVauS9/hyxibNB0JAleFeW+NlX8CducjmhgBZbbcaojrUv46smL6LyobomUVsRz
        Kv65wZzVlbakWZVWRPK/JI=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr1
 (Coremail) ; Fri, 15 Jul 2022 08:06:46 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 15 Jul 2022 08:06:46 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     Zhiqiang.Hou@nxp.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linmq006@gmail.com
Subject: Re:Re: [PATCH] pci: controller: mobiveil: Hold reference returned
 by of_parse_phandle()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220714163751.GA930301@bhelgaas>
References: <20220714163751.GA930301@bhelgaas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3302b8f5.15f.181ff2de1f8.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AcqowAD3CLGXr9BiRBgiAA--.55071W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RY-F1pEAZoVBAAAsH
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CkF0IDIwMjItMDctMTUgMDA6Mzc6NTEsICJCam9ybiBIZWxnYWFzIiA8aGVsZ2Fhc0BrZXJuZWwu
b3JnPiB3cm90ZToKPk9uIE1vbiwgSnVsIDA0LCAyMDIyIGF0IDAyOjI2OjA4UE0gKzA4MDAsIExp
YW5nIEhlIHdyb3RlOgo+PiBJbiBsc19nNF9wY2llX3Byb2JlKCksIHdlIHNob3VsZCBob2xkIHRo
ZSByZWZlcmVuY2UgcmV0dXJuZWQgYnkKPj4gb2ZfcGFyc2VfcGhhbmRsZSgpIGFuZCB1c2UgaXQg
dG8gY2FsbCBvZl9ub2RlX3B1dCgpIGZvciByZWZjb3VudAo+PiBiYWxhbmNlLgo+PiAKPj4gRml4
ZXM6IGQyOWFkNzBhODEzYiAoIlBDSTogbW9iaXZlaWw6IEFkZCBQQ0llIEdlbjQgUkMgZHJpdmVy
IGZvciBMYXllcnNjYXBlIFNvQ3MiKQo+PiBDby1hdXRob3JlZC1ieTogTWlhb3FpYW4gTGluIDxs
aW5tcTAwNkBnbWFpbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5kaGxAMTI2
LmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5
ZXJzY2FwZS1nZW40LmMgfCA2ICsrKystLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMKPj4gaW5kZXggZDdiNzM1MGYw
MmRkLi4wNzVhYTQ4N2Y5MmUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1sYXllcnNjYXBlLWdlbjQuYwo+PiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMKPj4gQEAgLTIwNCwxMyArMjA0
LDE1IEBAIHN0YXRpYyBpbnQgX19pbml0IGxzX2c0X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikKPj4gIAlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2U7Cj4+ICAJ
c3RydWN0IG1vYml2ZWlsX3BjaWUgKm12X3BjaTsKPj4gIAlzdHJ1Y3QgbHNfZzRfcGNpZSAqcGNp
ZTsKPj4gLQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOwo+PiArCXN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGUsICpwYXJzZV9ucDsKPj4gIAlpbnQgcmV0
Owo+PiAgCj4+IC0JaWYgKCFvZl9wYXJzZV9waGFuZGxlKG5wLCAibXNpLXBhcmVudCIsIDApKSB7
Cj4+ICsJcGFyc2VfbnAgPSBvZl9wYXJzZV9waGFuZGxlKG5wLCAibXNpLXBhcmVudCIsIDApOwo+
Cj5JIGRvbid0IHVuZGVyc3RhbmQgd2hhdCdzIGdvaW5nIG9uIGhlcmUuICBXaGVyZSBpcyAibXNp
LXBhcmVudCIKPmFjdHVhbGx5IHVzZWQ/ICBJZiB3ZSBqdXN0IG5lZWQgdG8ga25vdyB3aGV0aGVy
ICJtc2ktcGFyZW50IiBleGlzdHMsCj5jYW4gd2UgdXNlIG9mX3Byb3BlcnR5X3JlYWRfYm9vbCgp
IGluc3RlYWQ/ICBPciBjYW4gd2UgY2FsbAo+b2ZfcGFyc2VfcGhhbmRsZSgpIGNsb3NlciB0byB3
aGVyZSBpdCBpcyB1c2VkPyAgCj4KCkhpLCBCam9ybiwKCkkgdGhpbmsgdGhpcyBjb2RlIGlzIHVz
ZWQgdG8gY2hlY2sgdGhlIGV4aXN0ZW5jZSBvZiB0aGUgZGV2aWNlX25vZGUgd2hvc2UKcHJvcGVy
dHkgaXMgIm1zaS1wYXJlbnQiLiBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woKSBjYW4gb25seSBiZSB1
c2VkIHRvIGNoZWNrCmN1cnJlbnQgZGV2aWNlX25vZGUgJ25wJy4KSWYgdGhpcyBpcyByaWdodCwg
SSB0aGluayB3ZSBjYW4gdXNlIGEgaGVscGVyIHRvIG1ha2UgdGhpbmcgc2ltcGxlIGxpa2UgdGhp
czoKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDcxMjA2MTQxNy4zNjMxNDUtMS13
aW5kaGxAMTI2LmNvbS8KCklmIGl0IGlzIG9rLCBJIHdpbGwgcHJlcGFyZSB0aGUgaGVscGVyIGlu
IG5ldyB2ZXJzaW9uLgoKVGhhbmtzIGFnYWluLAoKTGlhbmcKCgo+PiArCWlmICghcGFyc2VfbnAp
IHsKPj4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZmluZCBtc2ktcGFyZW50XG4iKTsKPj4g
IAkJcmV0dXJuIC1FSU5WQUw7Cj4+ICAJfQo+PiArCW9mX25vZGVfcHV0KHBhcnNlX25wKTsKPj4g
IAo+PiAgCWJyaWRnZSA9IGRldm1fcGNpX2FsbG9jX2hvc3RfYnJpZGdlKGRldiwgc2l6ZW9mKCpw
Y2llKSk7Cj4+ICAJaWYgKCFicmlkZ2UpCj4+IC0tIAo+PiAyLjI1LjEKPj4gCg==
