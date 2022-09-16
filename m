Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD65BA726
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 09:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIPHIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 03:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIPHIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 03:08:22 -0400
Received: from m1564.mail.126.com (m1564.mail.126.com [220.181.15.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 328FBA3D43
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=J9yBY
        bsHeprzAm37Y/G8jAhb3IaaELswHP/bvZzZ7JI=; b=cbO3DoBC+Pi96RgXBk1l0
        bOJHL3h8XPgbWlF+QibBCxoK/PvHud+A43l7es7gLt+DqRBxiiTuZhMh+mU/uUYq
        8XBqc46Zt8ZJCruASsxXI8SIIYEuTFP1mVUEQLLMqX4/BXoyZKPWiutEYUJdX3EL
        7CGAvLdGZBZP+03yT4ox5Q=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr64
 (Coremail) ; Fri, 16 Sep 2022 15:07:06 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 16 Sep 2022 15:07:06 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, jgross@suse.com,
        virtualization@lists.linux-foundation.org, wangkelin2023@163.com,
        jan.kiszka@siemens.com, "Thomas Gleixner" <tglx@linutronix.de>,
        jailhouse-dev@googlegroups.com, mark.rutland@arm.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        robh+dt@kernel.org, "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re:Re: Re: [PATCH] jailhouse: Hold reference returned from
 of_find_xxx API
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <CAHp75Vd-ZdHJfjdgob7=e3X_=NQR_chWZzTiSVU64S9eTiAY0g@mail.gmail.com>
References: <20220915022343.4001331-1-windhl@126.com>
 <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
 <89a1b1f.165e.18344069cab.Coremail.windhl@126.com>
 <CAHp75Vd-ZdHJfjdgob7=e3X_=NQR_chWZzTiSVU64S9eTiAY0g@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7f9efc57.4645.183451f5b84.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMqowAA3P3ObICRj6YNxAA--.57196W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgd+F18RP1kgPwABsW
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKQXQgMjAyMi0wOS0xNiAxMzozODozOSwgIkFuZHkgU2hldmNoZW5rbyIgPGFuZHkuc2hldmNo
ZW5rb0BnbWFpbC5jb20+IHdyb3RlOgo+T24gRnJpLCBTZXAgMTYsIDIwMjIgYXQgNTowMiBBTSBM
aWFuZyBIZSA8d2luZGhsQDEyNi5jb20+IHdyb3RlOgo+PiBBdCAyMDIyLTA5LTE2IDA3OjI5OjA2
LCAiU3JpdmF0c2EgUy4gQmhhdCIgPHNyaXZhdHNhQGNzYWlsLm1pdC5lZHU+IHdyb3RlOgo+PiA+
T24gOS8xNC8yMiA3OjIzIFBNLCBMaWFuZyBIZSB3cm90ZToKPgo+Li4KPgo+PiA+PiAgc3RhdGlj
IGlubGluZSBib29sIGphaWxob3VzZV9wYXJhdmlydCh2b2lkKQo+PiA+PiAgewo+PiA+PiAtICAg
IHJldHVybiBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiamFpbGhvdXNlLGNl
bGwiKTsKPj4gPj4gKyAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gb2ZfZmluZF9jb21wYXRp
YmxlX25vZGUoTlVMTCwgTlVMTCwgImphaWxob3VzZSxjZWxsIik7Cj4+ID4+ICsKPj4gPj4gKyAg
ICBvZl9ub2RlX3B1dChucCk7Cj4+ID4+ICsKPj4gPj4gKyAgICByZXR1cm4gbnA7Cj4+ID4+ICB9
Cj4+ID4KPj4gPlRoYW5rIHlvdSBmb3IgdGhlIGZpeCwgYnV0IHJldHVybmluZyBhIHBvaW50ZXIg
ZnJvbSBhIGZ1bmN0aW9uIHdpdGggYQo+PiA+Ym9vbCByZXR1cm4gdHlwZSBsb29rcyBvZGQuIENh
biB3ZSBhbHNvIGZpeCB0aGF0IHVwIHBsZWFzZT8KPj4gPgo+Pgo+PiBUaGFua3MgZm9yIHlvdXIg
cmV2aWV3LCBob3cgYWJvdXQgZm9sbG93aW5nIHBhdGNoOgo+Pgo+PiAtICAgICAgIHJldHVybiBv
Zl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiamFpbGhvdXNlLGNlbGwiKTsKPj4g
KyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUo
TlVMTCwgTlVMTCwgImphaWxob3VzZSxjZWxsIik7Cj4+ICsKPj4gKyAgICAgICBvZl9ub2RlX3B1
dChucCk7Cj4+ICsKPj4gKyAgICAgICByZXR1cm4gKG5wPT1OVUxMKTsKPgoKPlRoaXMgd2lsbCBi
ZSBvcHBvc2l0ZSB0byB0aGUgYWJvdmUuIFBlcmhhcHMgeW91IHdhbnRlZAoKU29ycnksIEkgd2Fu
dGVkIHRvIHVzZSAnbnAhPU5VTEwnCgo+ICByZXR1cm4gICEhbnA7Cj4KPkFsc28gcG9zc2libGUg
KGJ1dCB3aHk/KQo+Cj4gIHJldHVybiBucCA/IHRydWUgOiBmYWxzZTsKCj4KClNvLCBjYW4gSSBj
aG9zZSAncmV0dXJuIG5wP3RydWU6IGZhbHNlOycgYXMgdGhlIGZpbmFsIHBhdGNoPwoKClRoYW5r
cywKCgpMaWFuZwoKCgoKPi0tID5XaXRoIEJlc3QgUmVnYXJkcywKPkFuZHkgU2hldmNoZW5rbwo=

