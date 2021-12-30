Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E509B4818DD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 04:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhL3DNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 22:13:41 -0500
Received: from m13101.mail.163.com ([220.181.13.101]:50223 "EHLO
        m13101.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhL3DNl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 22:13:41 -0500
X-Greylist: delayed 917 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Dec 2021 22:13:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=58oDQ
        PwwMWq3ppqtb+/VkPCahMAprOiUFqSt4oBRFuk=; b=dT14diZn4lDQrMOyk/QX4
        /X5racvcSiYUwHOX09VdKXO02p+J4AiYAcPLIchHpGkVXz5dpK3iDm6wVNxNB2xx
        9PkTJYDYB+TL3ase2LsgT6xl45U0m/upMyloZ7hjIlGxwsr3REQDJwRt8bZ4jruB
        KlNaCAFGAlfThsLC4eVyHc=
Received: from slark_xiao$163.com ( [112.97.50.214] ) by
 ajax-webmail-wmsvr101 (Coremail) ; Thu, 30 Dec 2021 10:57:35 +0800 (CST)
X-Originating-IP: [112.97.50.214]
Date:   Thu, 30 Dec 2021 10:57:35 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>,
        "Sergey Ryazanov" <ryazanov.s.a@gmail.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [Bug 215433] New: data connection lost on Qualcomm SDX55
 PCIe device
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <20211229174605.GA1689297@bhelgaas>
References: <20211229174605.GA1689297@bhelgaas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7d8532a3.2314.17e09457a76.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZcGowABXFWggIM1hjUgQAA--.8508W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAxd5ZGB0IXjwmwAAsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjEtMTItMzAgMDE6NDY6MDUsICJCam9ybiBIZWxnYWFzIiA8
aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToKPlsrY2MgTUhJIGZvbGtzXQo+Cj5PbiBUdWUsIERl
YyAyOCwgMjAyMSBhdCAxMToyNjowMkFNICswMDAwLCBidWd6aWxsYS1kYWVtb25AYnVnemlsbGEu
a2VybmVsLm9yZyB3cm90ZToKPj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0yMTU0MzMKPj4gCj4+ICAgICAgICAgICAgU3VtbWFyeTogZGF0YSBjb25uZWN0aW9u
IGxvc3Qgb24gUXVhbGNvbW0gU0RYNTUgUENJZSBkZXZpY2UKPj4gICAgIEtlcm5lbCBWZXJzaW9u
OiA1LjEzLjAsNS4xNS4wCj4+IC4uLgo+Cj4+IEZvciBRdWFsY29tbSBiYXNlZCBtb2RlbSBkZXZp
Y2VzLCB3aXRoIFBDSUUgaW50ZXJmYWNlLCBhbmQgbWhpIGRyaXZlciBiYXNlZCBvbgo+PiBrZXJu
ZWwgNS4xMy4wLCBpdCB3aWxsIGxvc2UgZGF0YSBjb25uZWN0aW9uLiBEZXRhaWxzIGFzIGJlbG93
Ogo+PiAKPj4gICAgIFBoZW5vbWVub246Cj4+ICAgICAgICAgMSkgQ2FuIE5PVCBjb25uZWN0IHRv
IEludGVybmV0Cj4+ICAgICAgICAgMikgL2Rldi93d2FuMHAxUUNETSwgL2Rldi93d2FuMHAyTUJJ
TSwgL2Rldi93d2FuMHAzQVQgTk9UIHJlc3BvbnNlCj4+IAo+PiAgICAgUmVwcm9kdWNlIHN0ZXBz
Cj4+ICAgICAgICAgMSkgQ29ubmVjdCBJbnRlcm5ldCB2aWEgY2VsbHVsYXIKPj4gICAgICAgICAy
KSBEbyBzcGVlZHRlc3QoaHR0cHM6Ly93d3cuc3BlZWR0ZXN0Lm5ldC8pIG9yIGRvd25sb2FkIGEg
MUdCIGZpbGUKPj4gKGlwdjQuZG93bmxvYWQudGhpbmticm9hZGJhbmQuY29tLzFHQi56aXApCj4+
IAo+PiAgICAgUmVjb3ZlcnkgbWV0aG9kCj4+ICAgICAgICAgT25seSBjYW4gYmUgcmVjb3ZlcmVk
IGJ5IHJlYm9vdCBob3N0Cj4+IAo+PiAgICAgT3RoZXJzCj4+ICAgICAgICAgSXQgY2FuIE5PVCBi
ZSByZXByb2R1Y2VkIGluIFdpbmRvd3MgMTAvMTEuCj4KPlRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRo
ZSByZXBvcnQuICBJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlIG1oaQo+ZHJpdmVyLCBzbyBJIGFk
ZGVkIHNvbWUgZm9sa3Mgd2hvIG1pZ2h0IGJlLgo+Cj5DYW4geW91IHBsZWFzZSBjb2xsZWN0IHRo
ZSBjb21wbGV0ZSBkbWVzZyBsb2cgYW5kIG91dHB1dCBvZgo+InN1ZG8gbHNwY2kgLXZ2IiBhbmQg
YXR0YWNoIGJvdGggdG8gdGhlIGJ1Z3ppbGxhPwo+Cj5Eb2VzIHRoZSBuZXR3b3JrIGNvbm5lY3Rp
b24gd29yayBmb3IgYSB3aGlsZSwgdGhlbiBzdG9wIHdvcmtpbmc/ICBJZgo+c28sIGlzIHRoZXJl
IGFueXRoaW5nIGxvZ2dlZCBpbiB0aGUgZG1lc2cgbG9nIHdoZW4gaXQgc3RvcHMgd29ya2luZz8K
Pgo+RG8geW91IGtub3cgb2YgYW55IExpbnV4IHZlcnNpb25zIHRoYXQgZG8gbm90IGhhdmUgdGhp
cyBwcm9ibGVtPyAgSWYKPml0IHVzZWQgdG8gd29yayBidXQgaXQgZ290IGJyb2tlbiwgdGhhdCB3
b3VsZCBoZWxwIG5hcnJvdyB0aGluZ3MgZG93bi4KPgo+VGhhbmtzLAo+ICBCam9ybgoKSGkgQmpv
cm4sCiAgIFJlbGF0ZWQgbG9nIGhhcyBiZWVuIHVwbG9hZGVkLgogICAKICAgWWVzLCB0aGUgdGlt
ZSBiZWZvcmUgc3RvcCB3b3JraW5nIG1heSBsZXNzIHRoYW4gMSBtaW51dGVzLCBvciBtb3JlIHRo
YW4gMTUgbWludXRlcy4gRmluYWxseSwgaXQgd291bGQgc3RvcCB3b3JraW5nLgogVGhlcmUgaXMg
bm8gbWVzc2FnZSB3b3VsZCBiZSByZXBvcnRlZCBpbiBkbWVzZyBsb2cgd2l0aCBkZWZhdWx0IGxv
ZyBsZXZlbC4gU28gSSB0aGluayB0aGlzIGlzIGEgc2l0dWF0aW9uIHRoYXQgd2UgYWxsIG1heSBt
aXNzIGl0LgpXZSBhbHNvIHRyaWVkIHRvIGFkZCBzb21lIGRlYnVnIGxvZy4gQnV0IG5vIGZpbmRp
bmdzLgogICBBcyB3ZSBhZGQgc3VwcG9ydCBvdXIgZGV2aWNlIGluIHY1LjEyKG1vcmUgb3IgbGVz
cyksIHNvIHdlIGRpZG4ndCB0ZXN0IGl0IHdpdGggcHJldmlvdXMgdmVyc2lvbi4gCkFjdHVhbGx5
IHRoaXMgaXNzdWUgaXMgZm91bmQgaW4gYm90aCB2NS4xMyBhbmQgdjUuMTUgb2ZmaWNpYWwgcmVs
ZWFzZS4KICAgCiAgIEJUVywgdGhlcmUgaXMgc29tZSBvdGhlciB2ZW5kb3IgYWxzbyByZXBvcnQg
dGhpcyBpc3N1ZSwgbGlrZSBRdWVjdGVsIFNEWDI0IG1vZHVsZS4gClNvIEkgYmVsaWV2ZSB0aGlz
IGlzIGEgY29tbW9uIGlzc3VlIGZvciBhbGwgbWhpIGRldmljZS4KIApUaGFua3MKIFNsYXJrCg==

