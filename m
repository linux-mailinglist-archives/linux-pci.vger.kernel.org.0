Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0461323D
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 10:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJaJI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJaJI4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 05:08:56 -0400
Received: from m13110.mail.163.com (m13110.mail.163.com [220.181.13.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4140C764F;
        Mon, 31 Oct 2022 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=KeBEt
        PRBjJu2aojXJFEa7CWPaJM5bjIAmqL0ScS+3Fg=; b=N20e9PL7PlaAHCOuU4CNt
        ay9WbbGrMbr1m6RIhXJ5LmmWDeZCtpO966Tmty4kxC28MGrzfH/lMngN4WAHI6lh
        Tf34KQO72Pey+By8+DXTVEiCr0TPFJKvCBYq+s63X5hlT8PagHUNXG2s0+45+Dht
        yhiQuJ/WRHH8oJeOhPkOMc=
Received: from slark_xiao$163.com ( [223.104.77.211] ) by
 ajax-webmail-wmsvr110 (Coremail) ; Mon, 31 Oct 2022 17:08:18 +0800 (CST)
X-Originating-IP: [223.104.77.211]
Date:   Mon, 31 Oct 2022 17:08:18 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] PCI: Add vendor ID for Quectel and Cinterion
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20221028160621.GA892468@bhelgaas>
References: <20221028160621.GA892468@bhelgaas>
X-NTES-SC: AL_QuydBf6buEoi7iKcZekWkkcRjuo+UMC0vfgh249fPJs0pCvO6zs+WFBlBkf/+smIMRuUnze3VQBL48BfRY9zfK2EL38cInWozauHOO4WnNVx
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7a4b4099.3628.1842d4c7cc5.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bsGowAAHSwSCkF9jQzRCAA--.53186W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRurZFyPfKWSXAAAsJ
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

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMTAtMjkgMDA6MDY6MjEsICJCam9ybiBIZWxnYWFzIiA8
aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToKPk9uIEZyaSwgT2N0IDI4LCAyMDIyIGF0IDEwOjM3
OjExQU0gKzA4MDAsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+IEluIE1ISSBkcml2ZXIsIHRoZXJlIGFy
ZSBzb21lIGNvbXBhbmllcyBwcm9kdWN0IHN0aWxsIGRvIG5vdCBoYXZlIHRoZWlyCj4+ICBvd24g
UENJIHZlbmRvciBtYWNyby4gU28gd2UgYWRkIGl0IGhlcmUgdG8gbWFrZSB0aGUgY29kZSBuZWF0
LiBSZWYgSUQKPj4gIGNvdWxkIGJlIGZvdW5kIGluIGxpbmsgaHR0cHM6Ly9wY2lzaWcuY29tL21l
bWJlcnNoaXAvbWVtYmVyLWNvbXBhbmllcwo+PiAgYW5kIGh0dHBzOi8vcGNpaWRzLnNvdXJjZWZv
cmdlLm5ldC9wY2kuaWRzIC4gVGhhbGVzIHVzZSBDaW50ZXJpb24gYXMKPj4gdGhlaXIgSU9UIG1v
ZGVtIGNhcmQncyB0cmFkZW1hcmsuIFNvIHlvdSB3aWxsIGZpbmQgMHgxMjY5IGJlbG9uZ3MgdG8K
Pj4gVGhhbGVzLiBBY3R1YWxseSwgQ2ludGVyaW9uIGJlbG9uZ3MgdG8gR2VtYWx0bywgYW5kIEdl
bWFsdG8gYmVsb25ncyB0bwo+PiAgVGhhbGVzLgo+Cj5UaGVyZSBzaG91bGQgbm90IGJlIHNwYWNl
cyBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZXNlIGxpbmVzLgo+Cj5Eb24ndCBib3RoZXIgd2l0aCB0
aGUgc291cmNlZm9yZ2UgVVJMOyBJIGRvbid0IHRoaW5rIHRoYXQncyByZWFsbHkKPnVzZWZ1bCBo
ZXJlLgogVGhlIHNwYWNlIGlzc3VlIHdpbGwgYmUgZml4ZWQgaW4gbmV4dCBwYXRjaC4KPgo+PiBT
aWduZWQtb2ZmLWJ5OiBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+Cj4+IC0tLQo+PiAg
aW5jbHVkZS9saW51eC9wY2lfaWRzLmggfCA0ICsrKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCBi
L2luY2x1ZGUvbGludXgvcGNpX2lkcy5oCj4+IGluZGV4IGIzNjJkOTBlYjliMC4uOWUyYjYyODZm
NTNmIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaAo+PiArKysgYi9pbmNs
dWRlL2xpbnV4L3BjaV9pZHMuaAo+PiBAQCAtMTc2NSw2ICsxNzY1LDggQEAKPj4gICNkZWZpbmUg
UENJX1ZFTkRPUl9JRF9TQVRTQUdFTQkJMHgxMjY3Cj4+ICAjZGVmaW5lIFBDSV9ERVZJQ0VfSURf
U0FUU0FHRU1fTklDQ1kJMHgxMDE2Cj4+ICAKPj4gKyNkZWZpbmUgUENJX1ZFTkRPUl9JRF9DSU5U
RVJJT04JCTB4MTI2OQkvKiBDZWxsdWFyIE1vZHVsZXMqLwo+Cj5UaGlzIHNob3VsZCBpZGVudGlm
eSB0aGUgKnZlbmRvciosIG5vdCBhIHRyYWRlbWFyayBmb3IgYSBzcGVjaWZpYwo+cHJvZHVjdCBs
aW5lLiAgQW5kIGl0IHNob3VsZCBjb3JyZXNwb25kIHNvbWVob3cgd2l0aCB0aGUgUENJLVNJRwo+
cmVnaXN0cmF0aW9uLiAgU28gSSB0aGluayBQQ0lfVkVORE9SX0lEX1RIQUxFUyB3b3VsZCBiZSBt
b3JlCj5hcHByb3ByaWF0ZSBoZXJlLgo+ClllYWgsIGN1cnJlbnRseSBpdCdzIHVzZWQgYnkgSU9U
IG1vZHVsZXMgd2hpY2ggc3VwcG9ydCBQQ0lFLiBCdXQgd2UKY2FuJ3Qga25vdyBpZiB0aGV5IHdp
bGwgdXNlIHRoaXMgVklEIGZvciBvdGhlciBub24tSU9UIG1vZHVsZXMgcHJvZHVjdC4KVGhhbGVz
IHdvdWxkIGJlIGJldHRlci4KCj5JIHRoaW5rIHRoZSBiZXN0IHRoaW5nIGhlcmUgd291bGQgYmUg
dHdvIHBhdGNoZXMuICBPbmUgcGF0Y2ggd291bGQgYWRkCj5QQ0lfVkVORE9SX0lEX1RIQUxFUyB0
byBwY2lfaWRzLmggYW5kIGFsc28gYWRkIGEgdXNlIG9mIGl0IGluIHRoZSBNSEkKPmRyaXZlci4g
IFRoZSBzZWNvbmQgcGF0Y2ggd291bGQgZG8gdGhlIHNhbWUgZm9yIFBDSV9WRU5ET1JfSURfUVVF
Q1RFTC4KPgo+VGhlbiBlYWNoIG9uZSBpcyBsb2dpY2FsbHkgc2VsZi1jb250YWluZWQuCkkgbXVz
dCBtYWtlIHN1cmUgdGhlc2UgaWRzIGFyZSBhcHBsaWVkLCB0aGVuIEkgY291bGQgY29tbWl0IHRo
ZSBjaGFuZ2VzIGluIE1ISQpkcml2ZXIgc2lkZS4gT3RoZXJ3aXNlIGl0IHdpbGwgY2F1c2UgYnVp
bGQgZXJyb3IuClNvIEkgY29tYmluZSBRVUVDVEVMIHdpdGggVEhBTEVTIGFzIGEgc2luZ2xlIHBh
dGNoLiBTaGFsbCBJIHNlcGFyYXRlIGl0IGZyb20KZWFjaCBvdGhlcj8gMSBmb3IgUENJIElEcywg
YW5kIGFub3RoZXIgZm9yIE1ISSBjaGFuZ2UuIEl0IHdvdWxkIGJlIGJldHRlciwgSSB0aGluay4K
Pgo+PiAgI2RlZmluZSBQQ0lfVkVORE9SX0lEX0VOU09OSVEJCTB4MTI3NAo+PiAgI2RlZmluZSBQ
Q0lfREVWSUNFX0lEX0VOU09OSVFfQ1Q1ODgwCTB4NTg4MAo+PiAgI2RlZmluZSBQQ0lfREVWSUNF
X0lEX0VOU09OSVFfRVMxMzcwCTB4NTAwMAo+PiBAQCAtMjU4NSw2ICsyNTg3LDggQEAKPj4gICNk
ZWZpbmUgUENJX1ZFTkRPUl9JRF9URUtSQU0JCTB4MWRlMQo+PiAgI2RlZmluZSBQQ0lfREVWSUNF
X0lEX1RFS1JBTV9EQzI5MAkweGRjMjkKPj4gIAo+PiArI2RlZmluZSBQQ0lfVkVORE9SX0lEX1FV
RUNURUwJCTB4MWVhYwo+PiArCj4+ICAjZGVmaW5lIFBDSV9WRU5ET1JfSURfVEVIVVRJCQkweDFm
YzkKPj4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9URUhVVElfMzAwOQkweDMwMDkKPj4gICNkZWZp
bmUgUENJX0RFVklDRV9JRF9URUhVVElfMzAxMAkweDMwMTAKPj4gLS0gCj4+IDIuMzQuMQo+PiAK

