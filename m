Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3857D614482
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 07:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKAGLT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKAGLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 02:11:18 -0400
Received: from m1353.mail.163.com (m1353.mail.163.com [220.181.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0D99FD12;
        Mon, 31 Oct 2022 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=gabve
        hFwyr56t3SCmvrhSqVpo5PbUibG67yyXZP1J28=; b=fsll5eA1DKFIQTuANHYqg
        0rZo1tcI5+kIqYb9aw3Xf4pUUGO/IS5k7ohfMrYeeELkUddYwcbOijVCTrJFovuw
        pUu7OIoEnCnmLe9vr10PCWhR+seaFBcjE+2B/D7yyUilM1ZGG1RtgX7tzY8i5z1Q
        CCEoL+p7cpuoPoy3eIq4Bs=
Received: from slark_xiao$163.com ( [223.104.68.52] ) by
 ajax-webmail-wmsvr53 (Coremail) ; Tue, 1 Nov 2022 14:09:57 +0800 (CST)
X-Originating-IP: [223.104.68.52]
Date:   Tue, 1 Nov 2022 14:09:57 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com, bhelgaas@google.com,
        loic.poulain@linaro.org, dnlplm@gmail.com, yonglin.tan@outlook.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re:Re: [PATCH v3] PCI: Add vendor ID for QUECTEL
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y2Ckm79PgcTcVVne@kroah.com>
References: <20221101021052.7532-1-slark_xiao@163.com>
 <Y2Ckm79PgcTcVVne@kroah.com>
X-NTES-SC: AL_QuydBf6TvUEi4SabbOkWkkcRjuo+UMC0vfgh249fPJs0tSrgxCQbYVBGHkH/18uRORqinzedTwRMy/pzWLB+Za9UYtlBILM/Kdf/2eAiS5kU
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3af61b4.1f11.18431cf918d.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: NcGowAAHF5k1uGBjM_tVAA--.9648W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDQGsZFaELltSCQABs5
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMTEtMDEgMTI6NDY6MTksICJHcmVnIEtIIiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gVHVlLCBOb3YgMDEsIDIwMjIgYXQgMTA6
MTA6NTJBTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gbiBNSEkgZHJpdmVyLCB0aGVyZSBh
cmUgc29tZSBjb21wYW5pZXMnIHByb2R1Y3Qgc3RpbGwgZG8gbm90IGhhdmUgdGhlaXIKPj4gb3du
IFBDSSB2ZW5kb3IgbWFjcm8uIFNvIHdlIGFkZCBpdCBoZXJlIHRvIG1ha2UgdGhlIGNvZGUgbmVh
dC4gUmVmIElECj4+IGNvdWxkIGJlIGZvdW5kIGluIGxpbmsgaHR0cHM6Ly9wY2lzaWcuY29tL21l
bWJlcnNoaXAvbWVtYmVyLWNvbXBhbmllcy4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhp
YW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPj4gLS0tCj4+IHYzOiBTZXBhcmF0ZSBkaWZmZXJlbnQg
dmVuZG9ycyBpbnRvIGRpZmZlcmVudCBwYXRjaC4KPj4gCj4+IHYyOiBVcGRhdGUgdmVuZG9yIElE
IHRvIHRoZSByaWdodCBsb2NhdGlvbiBzb3J0ZWQgYnkgbnVtZXJpYyB2YWx1ZS4KPj4gLS0tCj4+
ICBkcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jIHwgNiArKystLS0KPj4gIGluY2x1
ZGUvbGludXgvcGNpX2lkcy5oICAgICAgICAgICAgfCAyICsrCj4+ICAyIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jIGIvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNp
X2dlbmVyaWMuYwo+PiBpbmRleCBjYWE0Y2UyOGNmOWUuLjgxYWU5YzQ5Y2UyYSAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYwo+PiArKysgYi9kcml2ZXJz
L2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+IEBAIC01NTUsMTEgKzU1NSwxMSBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbWhpX3BjaV9pZF90YWJsZVtdID0gewo+PiAg
CQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfdGVsaXRfZm45OTBfaW5mbyB9
LAo+PiAgCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1FDT00sIDB4MDMwOCksCj4+ICAJCS5k
cml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9xY29tX3NkeDY1X2luZm8gfSwKPj4g
LQl7IFBDSV9ERVZJQ0UoMHgxZWFjLCAweDEwMDEpLCAvKiBFTTEyMFItR0wgKHNkeDI0KSAqLwo+
PiArCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1FVRUNURUwsIDB4MTAwMSksIC8qIEVNMTIw
Ui1HTCAoc2R4MjQpICovCj4+ICAJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1o
aV9xdWVjdGVsX2VtMXh4X2luZm8gfSwKPj4gLQl7IFBDSV9ERVZJQ0UoMHgxZWFjLCAweDEwMDIp
LCAvKiBFTTE2MFItR0wgKHNkeDI0KSAqLwo+PiArCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lE
X1FVRUNURUwsIDB4MTAwMiksIC8qIEVNMTYwUi1HTCAoc2R4MjQpICovCj4+ICAJCS5kcml2ZXJf
ZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9xdWVjdGVsX2VtMXh4X2luZm8gfSwKPj4gLQl7
IFBDSV9ERVZJQ0UoMHgxZWFjLCAweDIwMDEpLCAvKiBFTTEyMFItR0wgZm9yIEZDQ0wgKHNkeDI0
KSAqLwo+PiArCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1FVRUNURUwsIDB4MjAwMSksIC8q
IEVNMTIwUi1HTCBmb3IgRkNDTCAoc2R4MjQpICovCj4+ICAJCS5kcml2ZXJfZGF0YSA9IChrZXJu
ZWxfdWxvbmdfdCkgJm1oaV9xdWVjdGVsX2VtMXh4X2luZm8gfSwKPj4gIAkvKiBUOTlXMTc1IChz
ZHg1NSksIEJvdGggZm9yIGVTSU0gYW5kIE5vbi1lU0lNICovCj4+ICAJeyBQQ0lfREVWSUNFKFBD
SV9WRU5ET1JfSURfRk9YQ09OTiwgMHhlMGFiKSwKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvcGNpX2lkcy5oIGIvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgKPj4gaW5kZXggYjM2MmQ5MGVi
OWIwLi4zYzkxNDYxYmNmZTQgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvcGNpX2lkcy5o
Cj4+ICsrKyBiL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oCj4+IEBAIC0yNTg1LDYgKzI1ODUsOCBA
QAo+PiAgI2RlZmluZSBQQ0lfVkVORE9SX0lEX1RFS1JBTQkJMHgxZGUxCj4+ICAjZGVmaW5lIFBD
SV9ERVZJQ0VfSURfVEVLUkFNX0RDMjkwCTB4ZGMyOQo+PiAgCj4+ICsjZGVmaW5lIFBDSV9WRU5E
T1JfSURfUVVFQ1RFTAkJMHgxZWFjCj4KPldoeSBkaWQgeW91IGlnbm9yZSB0aGUgY29tbWVudCBh
dCB0aGUgdG9wIG9mIHRoaXMgZmlsZSBzYXlpbmcgdGhhdCBuZXcKPmVudHJpZXMgYXJlIG5vdCBu
ZWVkZWQgdG8gYmUgYWRkZWQsIGVzcGVjaWFsbHkgZm9yIGp1c3Qgb25lIHVzZXI/Cj4KPnRoYW5r
cywKPgo+Z3JlZyBrLWgKSGkgR3JlZywKIEFjdHVhbGx5IEkgZGlkbid0IHNlZSB0aGlzIG5vdGlj
ZSBiZWZvcmUgY29tbWl0dGluZyB0aGlzIHBhdGNoLiBJIGV2ZW4gZGlzY3Vzc2VkIAppdCB3aXRo
IHRoZSBtYWludGFpbmVyIGZvciBzZXZlcmFsIHRpbWVzIGFuZCBub2JvZHkgc2hvdyBtZSB0aGlz
IHJ1bGUuCkkgaGF2ZSBhIGNvbmNlcm4sIHNvbWUgSU9UIG1vZHVsZSB2ZW5kb3JzLCBsaWtlIFFV
RUNURUwsIENJTlRFUklPTihUSEFMRVMpLApTSUVSUkEsUk9MTElORyBhbmQgc28gb24sIHRoZXkg
b25seSBwcm9kdWNlIElPVCBtb2R1bGVzIHdpdGhvdXQgb3RoZXIgCmhhcmR3YXJlIHdpdGggUENJ
ZSAgaW50ZXJmYWNlLCBhbmQgdGhleSBhcHBsaWVkIGZvciB0aGVpciBvd24gVklELiBCdXQgdGhl
eQpjYW4ndCBnZXQgYSB0aGVpciBvd24gVkVORE9SIE1BUkNPPyBUaGlzIHNlZW1zIHVucmVhc29u
YWJsZS4KVGhpcyBjaGFuZ2Ugc2hvdWxkIGJlIGhhcm1sZXNzIGFuZCAgbWFrZSB0aGUgY29kZSBu
ZWF0LgpUaGlzIGlzIG15IG9waW5pb24uCgpUaGFua3MKU2xhcmsgWGlhbwo=
