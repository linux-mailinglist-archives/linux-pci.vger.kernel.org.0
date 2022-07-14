Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47E857585F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiGOADi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbiGOADh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:03:37 -0400
Received: from m151.mail.126.com (m151.mail.126.com [220.181.15.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF4BFB8D
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 17:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=tTALt
        WW5NTLhuOGU6Pelew2TaC2PZlt7VxdBK3nq61k=; b=TwTv5CMhlUtdszJ15o3ki
        3IPlwkeLDmYcJc3MEtsb7/UA2azM6pz5iNNPlusCeesdSteJBadCWIa/Jefb3OgP
        AW/lJeV+zrOToc24csMH0dqA4cd2BE7lNlszQOi9UcK9scHCmwpZpUtvsCPJvGC+
        dwXL9QoBY9MMz9r2Gises0=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr1
 (Coremail) ; Fri, 15 Jul 2022 07:58:54 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 15 Jul 2022 07:58:54 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linmq006@gmail.com
Subject: Re:Re: [PATCH] pci: controller: brcmstb: Move of_node_put() out of
 'if' in brcm_pcie_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220714164726.GA1021692@bhelgaas>
References: <20220714164726.GA1021692@bhelgaas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <600e0df6.13d.181ff26b0cd.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AcqowACnwLC+rdBiEBgiAA--.12747W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RY+F1pEAZiqAQACs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CkF0IDIwMjItMDctMTUgMDA6NDc6MjYsICJCam9ybiBIZWxnYWFzIiA8aGVsZ2Fhc0BrZXJuZWwu
b3JnPiB3cm90ZToKPk9uIE1vbiwgSnVsIDA0LCAyMDIyIGF0IDAyOjU1OjAxUE0gKzA4MDAsIExp
YW5nIEhlIHdyb3RlOgo+PiBDb21taXQgM2E4N2NiOGY2YSAoIkZpeCByZWZjb3VudCBsZWFrIGlu
IGJyY21fcGNpZV9wcm9iZSgpIikgYWRkcwo+PiBvZl9ub2RlX3B1dCgpIGZvciBvZl9wYXJzZV9w
aGFuZGxlKCkgaW4gZmFpbCBwYXRoIGJ1dCBub3QgYWRkcyBpdAo+PiBjb3JyZWN0bHkgaW4gbm9y
bWFsIHBhdGguIFdlIHNob3VsZCBtb3ZlIHRoZSBzZWNvbmQgb2Zfbm9kZV9wdXQoKQo+PiBvdXQg
b2YgdGhlICdpZihwY2lfbXNpX2VuYWJsZWQoKSAmJiBtc2lfbnAgPT0gcGNpZS0+bnApJy4KPj4g
Cj4+IEZpeGVzOiAzYTg3Y2I4ZjZhICgiRml4IHJlZmNvdW50IGxlYWsgaW4gYnJjbV9wY2llX3By
b2JlKCkiKQo+PiBDby1hdXRob3JlZC1ieTogTWlhb3FpYW4gTGluIDxsaW5tcTAwNkBnbWFpbC5j
b20+Cj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5kaGxAMTI2LmNvbT4KPj4gLS0tCj4+
ICBQYXRjaGVkIGZpbGUgaGFzIGJlZW4gY29tcGlsZWQgdGVzdCBpbiBuZXh0IGJyYW5jaC4KPj4g
Cj4+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtYnJjbXN0Yi5jIHwgMiArLQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWJyY21zdGIuYyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1icmNtc3RiLmMKPj4gaW5kZXggNDhhNzE0ODM3NmQ0Li44MGUxOWQw
NTNlOWYgMTAwNzU1Cj4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1icmNtc3Ri
LmMKPj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWJyY21zdGIuYwo+PiBAQCAt
MTQxMyw4ICsxNDEzLDggQEAgc3RhdGljIGludCBicmNtX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKPj4gIAkJCW9mX25vZGVfcHV0KG1zaV9ucCk7Cj4+ICAJCQlnb3Rv
IGZhaWw7Cj4+ICAJCX0KPj4gLQkJb2Zfbm9kZV9wdXQobXNpX25wKTsKPj4gIAl9Cj4+ICsJb2Zf
bm9kZV9wdXQobXNpX25wKTsKPgo+Q2FuIHdlIGp1c3QgbW92ZSB0aGUgb2ZfcGFyc2VfcGhhbmRs
ZSgpIGFuZCByZWxhdGVkIGNoZWNraW5nIGludG8KPmJyY21fcGNpZV9lbmFibGVfbXNpKCk/ICBJ
dCBjYW4gcmV0dXJuIHN1Y2Nlc3Mgd2l0aG91dCBkb2luZyBhbnl0aGluZwo+aWYgIXBjaV9tc2lf
ZW5hYmxlZCgpIG9yIG1zaV9ucCAhPSBwY2llX25wLgo+Cj5JZiB5b3UgZG9uJ3Qgd2FudCB0byBk
byB0aGF0LCBwbGVhc2UganVzdCBzZW5kIGEgcmV2aXNlZCB2ZXJzaW9uIG9mCj4zYTg3Y2I4ZjZh
NzIgKCJQQ0k6IGJyY21zdGI6IEZpeCByZWZjb3VudCBsZWFrIGluIGJyY21fcGNpZV9wcm9iZSgp
IikuCj5UaGF0J3Mgbm90IHVwc3RyZWFtIHlldCwgYW5kIEkgZG9uJ3Qgd2FudCB0byBjbHV0dGVy
IHRoZSBnaXQgaGlzdG9yeQo+d2l0aCBhIGZpeCBvZiBhIGZpeC4KCj4KCgpUaGFua3MsIEJqb3Ju
LApXZSB3aWxsIG1ha2UgYSBiZXR0ZXIgdmVyc2lvbiBvciBhIHJldmlzZWQgdmVyc2lvbiBzb29u
LgpMaWFuZwoKCgo+PiAgCWJyaWRnZS0+b3BzID0gcGNpZS0+dHlwZSA9PSBCQ003NDI1ID8gJmJy
Y21fcGNpZV9vcHMzMiA6ICZicmNtX3BjaWVfb3BzOwo+PiAgCWJyaWRnZS0+c3lzZGF0YSA9IHBj
aWU7Cj4+IC0tIAo+PiAyLjI1LjEKPj4gCg==
