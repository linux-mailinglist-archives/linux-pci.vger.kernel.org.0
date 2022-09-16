Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7FB5BA4A2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 04:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIPCcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 22:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIPCcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 22:32:52 -0400
X-Greylist: delayed 1887 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 19:32:50 PDT
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B429656B91
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=cy+LA
        2w5x9ANkCDCsz88Hi3lIxJIOOYRtoFw6HjTG/s=; b=Wq9mJegFd3fx9ievPLVDw
        g5DnaYUTbizeDErr4AdoIadZ28PqjXrio4fVhytDeScanR6G7awoDLUTSbcgyG3L
        EIeDQdik4PkQ/CSZ9FAXWyAM6MURGA5s3ARJXeHIMcM8i8s2y4zbfuMqCrTICYPS
        SzRUoCdx9rHUtf5KCclgGU=
Received: from windhl$126.com ( [124.16.139.61, 14.29.82.34] ) by
 ajax-webmail-wmsvr50 (Coremail) ; Fri, 16 Sep 2022 10:00:27 +0800 (CST)
X-Originating-IP: [124.16.139.61, 14.29.82.34]
Date:   Fri, 16 Sep 2022 10:00:27 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     jgross@suse.com, virtualization@lists.linux-foundation.org,
        wangkelin2023@163.com, jan.kiszka@siemens.com,
        "Thomas Gleixner" <tglx@linutronix.de>,
        jailhouse-dev@googlegroups.com, mark.rutland@arm.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re:Re: [PATCH] jailhouse: Hold reference returned from of_find_xxx
 API
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
References: <20220915022343.4001331-1-windhl@126.com>
 <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <89a1b1f.165e.18344069cab.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADnPPG82CNjwf1tAA--.52003W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAl+F2JVlaGGMgABsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CkF0IDIwMjItMDktMTYgMDc6Mjk6MDYsICJTcml2YXRzYSBTLiBCaGF0IiA8c3JpdmF0c2FAY3Nh
aWwubWl0LmVkdT4gd3JvdGU6Cj4KPlsgQWRkaW5nIGF1dGhvciBhbmQgcmV2aWV3ZXJzIG9mIGNv
bW1pdCA2MzMzOGEzOGRiOTUgXQo+Cj5PbiA5LzE0LzIyIDc6MjMgUE0sIExpYW5nIEhlIHdyb3Rl
Ogo+PiBJbiBqYWlsaG91c2VfcGFyYXZpcnQoKSwgd2Ugc2hvdWxkIGhvbGQgdGhlIHJlZmVyZW5j
ZSByZXR1cm5lZCBmcm9tCj4+IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKCkgd2hpY2ggaGFzIGlu
Y3JlYXNlZCB0aGUgcmVmY291bnQgYW5kIHRoZW4KPj4gY2FsbCBvZl9ub2RlX3B1dCgpIHdpdGgg
aXQgd2hlbiBkb25lLgo+PiAKPj4gRml4ZXM6IDYzMzM4YTM4ZGI5NSAoImphaWxob3VzZTogUHJv
dmlkZSBkZXRlY3Rpb24gZm9yIG5vbi14ODYgc3lzdGVtcyIpCj4+IFNpZ25lZC1vZmYtYnk6IExp
YW5nIEhlIDx3aW5kaGxAMTI2LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogS2VsaW4gV2FuZyA8d2Fu
Z2tlbGluMjAyM0AxNjMuY29tPgo+PiAtLS0KPj4gIGluY2x1ZGUvbGludXgvaHlwZXJ2aXNvci5o
IHwgNiArKysrKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2h5cGVydmlzb3IuaCBiL2lu
Y2x1ZGUvbGludXgvaHlwZXJ2aXNvci5oCj4+IGluZGV4IDllZmJjNTRlMzVlNS4uN2ZlMWU4YzYy
MTFjIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2h5cGVydmlzb3IuaAo+PiArKysgYi9p
bmNsdWRlL2xpbnV4L2h5cGVydmlzb3IuaAo+PiBAQCAtMjcsNyArMjcsMTEgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGh5cGVydmlzb3JfcGluX3ZjcHUoaW50IGNwdSkKPj4gIAo+PiAgc3RhdGljIGlu
bGluZSBib29sIGphaWxob3VzZV9wYXJhdmlydCh2b2lkKQo+PiAgewo+PiAtCXJldHVybiBvZl9m
aW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiamFpbGhvdXNlLGNlbGwiKTsKPj4gKwlz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVM
TCwgImphaWxob3VzZSxjZWxsIik7Cj4+ICsKPj4gKwlvZl9ub2RlX3B1dChucCk7Cj4+ICsKPj4g
KwlyZXR1cm4gbnA7Cj4+ICB9Cj4+ICAKPgo+VGhhbmsgeW91IGZvciB0aGUgZml4LCBidXQgcmV0
dXJuaW5nIGEgcG9pbnRlciBmcm9tIGEgZnVuY3Rpb24gd2l0aCBhCj5ib29sIHJldHVybiB0eXBl
IGxvb2tzIG9kZC4gQ2FuIHdlIGFsc28gZml4IHRoYXQgdXAgcGxlYXNlPwo+CgpUaGFua3MgZm9y
IHlvdXIgcmV2aWV3LCBob3cgYWJvdXQgZm9sbG93aW5nIHBhdGNoOgoKLQlyZXR1cm4gb2ZfZmlu
ZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgImphaWxob3VzZSxjZWxsIik7CisJc3RydWN0
IGRldmljZV9ub2RlICpucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJq
YWlsaG91c2UsY2VsbCIpOworCisJb2Zfbm9kZV9wdXQobnApOworCisJcmV0dXJuIChucD09TlVM
TCk7Cgo+Cj5SZWdhcmRzLAo+U3JpdmF0c2EKPlZNd2FyZSBQaG90b24gT1MK
