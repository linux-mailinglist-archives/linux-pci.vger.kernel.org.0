Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C85BA88B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiIPIuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIPIuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 04:50:06 -0400
Received: from m1564.mail.126.com (m1564.mail.126.com [220.181.15.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81B76422DD
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=KRxlD
        bD3EEKTxPyCdCMnd1JDORZitZqDBpNFqUKk+vw=; b=EZbkZ36+b61ZuqBCJ6SyB
        OeB6WPYc+Z6cFx/EX+yKaPR6QUp4yiS51Hg7zY7zGv6BDiQ4xy68upZMGC9fb/az
        PjCA6GZwqRidbXU5QNlXc7nm1o+itMlyW/6Ce5hexbLjfqDaaX46AM6N0MVfUGOn
        28tcI9A+yP3eQPSJsQn148=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr64
 (Coremail) ; Fri, 16 Sep 2022 16:49:22 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 16 Sep 2022 16:49:22 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, jgross@suse.com,
        virtualization@lists.linux-foundation.org, wangkelin2023@163.com,
        jan.kiszka@siemens.com, "Thomas Gleixner" <tglx@linutronix.de>,
        jailhouse-dev@googlegroups.com, mark.rutland@arm.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        robh+dt@kernel.org, "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re:Re: Re: Re: [PATCH] jailhouse: Hold reference returned from
 of_find_xxx API
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <CAHp75VfQHnt2YxuxbFo96tfDrHEZpEqSFKFV_D7ERe6uXEnvEQ@mail.gmail.com>
References: <20220915022343.4001331-1-windhl@126.com>
 <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
 <89a1b1f.165e.18344069cab.Coremail.windhl@126.com>
 <CAHp75Vd-ZdHJfjdgob7=e3X_=NQR_chWZzTiSVU64S9eTiAY0g@mail.gmail.com>
 <7f9efc57.4645.183451f5b84.Coremail.windhl@126.com>
 <CAHp75VfQHnt2YxuxbFo96tfDrHEZpEqSFKFV_D7ERe6uXEnvEQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <480230.5e6f.183457cfc63.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMqowAC3v3OSOCRjZ6ZxAA--.63751W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RV+F1pEAufFlAABs6
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKCkF0IDIwMjItMDktMTYgMTY6NDY6MzYsICJBbmR5IFNoZXZjaGVua28iIDxhbmR5LnNoZXZj
aGVua29AZ21haWwuY29tPiB3cm90ZToKPk9uIEZyaSwgU2VwIDE2LCAyMDIyIGF0IDEwOjA5IEFN
IExpYW5nIEhlIDx3aW5kaGxAMTI2LmNvbT4gd3JvdGU6Cj4+IEF0IDIwMjItMDktMTYgMTM6Mzg6
MzksICJBbmR5IFNoZXZjaGVua28iIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToK
Pj4gPk9uIEZyaSwgU2VwIDE2LCAyMDIyIGF0IDU6MDIgQU0gTGlhbmcgSGUgPHdpbmRobEAxMjYu
Y29tPiB3cm90ZToKPj4gPj4gQXQgMjAyMi0wOS0xNiAwNzoyOTowNiwgIlNyaXZhdHNhIFMuIEJo
YXQiIDxzcml2YXRzYUBjc2FpbC5taXQuZWR1PiB3cm90ZToKPj4gPj4gPk9uIDkvMTQvMjIgNzoy
MyBQTSwgTGlhbmcgSGUgd3JvdGU6Cj4KPi4uLgo+Cj4+ID4+ID4+ICBzdGF0aWMgaW5saW5lIGJv
b2wgamFpbGhvdXNlX3BhcmF2aXJ0KHZvaWQpCj4+ID4+ID4+ICB7Cj4+ID4+ID4+IC0gICAgcmV0
dXJuIG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJqYWlsaG91c2UsY2VsbCIp
Owo+PiA+PiA+PiArICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBvZl9maW5kX2NvbXBhdGli
bGVfbm9kZShOVUxMLCBOVUxMLCAiamFpbGhvdXNlLGNlbGwiKTsKPj4gPj4gPj4gKwo+PiA+PiA+
PiArICAgIG9mX25vZGVfcHV0KG5wKTsKPj4gPj4gPj4gKwo+PiA+PiA+PiArICAgIHJldHVybiBu
cDsKPj4gPj4gPj4gIH0KPj4gPj4gPgo+PiA+PiA+VGhhbmsgeW91IGZvciB0aGUgZml4LCBidXQg
cmV0dXJuaW5nIGEgcG9pbnRlciBmcm9tIGEgZnVuY3Rpb24gd2l0aCBhCj4+ID4+ID5ib29sIHJl
dHVybiB0eXBlIGxvb2tzIG9kZC4gQ2FuIHdlIGFsc28gZml4IHRoYXQgdXAgcGxlYXNlPwo+PiA+
Pgo+PiA+PiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBob3cgYWJvdXQgZm9sbG93aW5nIHBhdGNo
Ogo+PiA+Pgo+PiA+PiAtICAgICAgIHJldHVybiBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxM
LCBOVUxMLCAiamFpbGhvdXNlLGNlbGwiKTsKPj4gPj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgImphaWxob3VzZSxj
ZWxsIik7Cj4+ID4+ICsKPj4gPj4gKyAgICAgICBvZl9ub2RlX3B1dChucCk7Cj4+ID4+ICsKPj4g
Pj4gKyAgICAgICByZXR1cm4gKG5wPT1OVUxMKTsKPj4KPj4gPlRoaXMgd2lsbCBiZSBvcHBvc2l0
ZSB0byB0aGUgYWJvdmUuIFBlcmhhcHMgeW91IHdhbnRlZAo+Pgo+PiBTb3JyeSwgSSB3YW50ZWQg
dG8gdXNlICducCE9TlVMTCcKPj4KPj4gPiAgcmV0dXJuICAhIW5wOwo+PiA+Cj4+ID5BbHNvIHBv
c3NpYmxlIChidXQgd2h5PykKPj4gPgo+PiA+ICByZXR1cm4gbnAgPyB0cnVlIDogZmFsc2U7Cj4+
Cj4+IFNvLCBjYW4gSSBjaG9zZSAncmV0dXJuIG5wP3RydWU6IGZhbHNlOycgYXMgdGhlIGZpbmFs
IHBhdGNoPwo+Cj5PZiBjb3Vyc2UgeW91IGNhbiwgaXQncyB1cCB0byB0aGUgbWFpbnRhaW5lcihz
KSB3aGF0IHRvIGFjY2VwdC4KPgo+LS0gCj5XaXRoIEJlc3QgUmVnYXJkcywKPkFuZHkgU2hldmNo
ZW5rbwoKVGhhbmtzLCBJIHdpbGwgZG8gaXQgbm93Lgo=
