Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF3610918
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 05:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiJ1D5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 23:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiJ1D5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 23:57:47 -0400
Received: from m1364.mail.163.com (m1364.mail.163.com [220.181.13.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39832D57E8;
        Thu, 27 Oct 2022 20:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=8+baX
        zK4pGCnSPDjay74VDRz+nT5szi52O90ChAtjTQ=; b=FtyTuNdulD0Z+MHr5vS+z
        gntc0TcIZuKpwjuoC4BTlfiIovkyuPhWzsW6/m7uEujexviUZZ3O7wOKGUvm99qx
        L4Xs4AK2CRFq+u3+VTKsuOo+07BvU3U/7jaZ8yuc0s7+2vMKEfLLFa9jeaK6Efqb
        yc4BlvnBzBj8Jp+ft5FzXA=
Received: from slark_xiao$163.com ( [223.104.77.214] ) by
 ajax-webmail-wmsvr64 (Coremail) ; Fri, 28 Oct 2022 11:57:37 +0800 (CST)
X-Originating-IP: [223.104.77.214]
Date:   Fri, 28 Oct 2022 11:57:37 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] PCI: Add vendor ID for Quectel and Cinterion
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y1tRu3SFMrS3su56@debian.me>
References: <20221028023711.4196-1-slark_xiao@163.com>
 <Y1tRu3SFMrS3su56@debian.me>
X-NTES-SC: AL_QuydBPWZtkwu4SKYbekWkkcRjuo+UMC0vfgh249fPJs0lSrP4gUFXW1SAGvuwuKPDyS8ogqlbxFE1vVaYpVaXoAVKLkMfkMEs3Shure/iJBq
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <9ec6b2e.17e9.1841cbcf83b.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMGowAD3Ei8xU1tj4+hcAA--.39292W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDR+oZFaELik5UwACsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMTAtMjggMTE6NTE6MjMsICJCYWdhcyBTYW5qYXlhIiA8
YmFnYXNkb3RtZUBnbWFpbC5jb20+IHdyb3RlOgo+T24gRnJpLCBPY3QgMjgsIDIwMjIgYXQgMTA6
Mzc6MTFBTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gSW4gTUhJIGRyaXZlciwgdGhlcmUg
YXJlIHNvbWUgY29tcGFuaWVzIHByb2R1Y3Qgc3RpbGwgZG8gbm90IGhhdmUgdGhlaXIKPj4gIG93
biBQQ0kgdmVuZG9yIG1hY3JvLiBTbyB3ZSBhZGQgaXQgaGVyZSB0byBtYWtlIHRoZSBjb2RlIG5l
YXQuIFJlZiBJRAo+PiAgY291bGQgYmUgZm91bmQgaW4gbGluayBodHRwczovL3BjaXNpZy5jb20v
bWVtYmVyc2hpcC9tZW1iZXItY29tcGFuaWVzCj4+ICBhbmQgaHR0cHM6Ly9wY2lpZHMuc291cmNl
Zm9yZ2UubmV0L3BjaS5pZHMgLiBUaGFsZXMgdXNlIENpbnRlcmlvbiBhcwo+PiB0aGVpciBJT1Qg
bW9kZW0gY2FyZCdzIHRyYWRlbWFyay4gU28geW91IHdpbGwgZmluZCAweDEyNjkgYmVsb25ncyB0
bwo+PiBUaGFsZXMuIEFjdHVhbGx5LCBDaW50ZXJpb24gYmVsb25ncyB0byBHZW1hbHRvLCBhbmQg
R2VtYWx0byBiZWxvbmdzIHRvCj4+ICBUaGFsZXMuCj4+IAo+Cj5UaGUgcGF0Y2ggZGVzY3JpcHRp
b24gaXMgY29uZnVzaW5nIG1lLgo+Cj5XaGF0IGFib3V0IGJlbG93IGluc3RlYWQ/Cj4KPmBgYAo+
QWRkIG1pc3NpbmcgdmVuZG9yIElEIGZvciBDaW50ZXJpb24gKHdoaWNoIGlzIDB4MTI2OSkuCj5g
YGAKPgpBcyB5b3Ugc2FpZCAweDEyNjkgYmVsb25ncyB0byBUaGFsZXMgKG5vdCBDaW50ZXJpb24p
LCBTbyBJIHdyaXRlIGl0IGFib3V0IHRoZSBkZXRhaWxzLgoKPj4gU2lnbmVkLW9mZi1ieTogU2xh
cmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPgo+PiAtLS0KPj4gIGluY2x1ZGUvbGludXgvcGNp
X2lkcy5oIHwgNCArKysrCj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4+IAo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2lfaWRzLmggYi9pbmNsdWRlL2xpbnV4L3Bj
aV9pZHMuaAo+PiBpbmRleCBiMzYyZDkwZWI5YjAuLjllMmI2Mjg2ZjUzZiAxMDA2NDQKPj4gLS0t
IGEvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9wY2lfaWRz
LmgKPj4gQEAgLTE3NjUsNiArMTc2NSw4IEBACj4+ICAjZGVmaW5lIFBDSV9WRU5ET1JfSURfU0FU
U0FHRU0JCTB4MTI2Nwo+PiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX1NBVFNBR0VNX05JQ0NZCTB4
MTAxNgo+PiAgCj4+ICsjZGVmaW5lIFBDSV9WRU5ET1JfSURfQ0lOVEVSSU9OCQkweDEyNjkJLyog
Q2VsbHVhciBNb2R1bGVzKi8KPj4gKwo+PiAgI2RlZmluZSBQQ0lfVkVORE9SX0lEX0VOU09OSVEJ
CTB4MTI3NAo+PiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX0VOU09OSVFfQ1Q1ODgwCTB4NTg4MAo+
PiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX0VOU09OSVFfRVMxMzcwCTB4NTAwMAo+PiBAQCAtMjU4
NSw2ICsyNTg3LDggQEAKPj4gICNkZWZpbmUgUENJX1ZFTkRPUl9JRF9URUtSQU0JCTB4MWRlMQo+
PiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX1RFS1JBTV9EQzI5MAkweGRjMjkKPj4gIAo+PiArI2Rl
ZmluZSBQQ0lfVkVORE9SX0lEX1FVRUNURUwJCTB4MWVhYwo+PiArCj4KPldoeSBwb3VycmluZyBp
biBRdWVjdGVsIElEIHdoaWxlIHRoaXMgcGF0Y2ggaXMgYWJvdXQgQ2ludGVyaW9uPwo+Cj5UaGFu
a3MuIAo+ClBhdGNoIHRpdGxlIGlzIGZvciAyIHZlbmRvcnMsICBRdWVjdGVsIGFuZCBDaW50ZXJp
b24uIE1heSBJIGFkZCAyIGRpZmZlcmVudCBWSUQgYXQgdGhlIApzYW1lIHRpbWU/Cj4tLSAKPkFu
IG9sZCBtYW4gZG9sbC4uLiBqdXN0IHdoYXQgSSBhbHdheXMgd2FudGVkISAtIENsYXJhCg==
