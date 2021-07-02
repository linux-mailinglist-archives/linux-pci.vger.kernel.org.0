Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C669E3B9A74
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 03:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhGBBSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 21:18:22 -0400
Received: from mail.loongson.cn ([114.242.206.163]:50094 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230404AbhGBBSW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 21:18:22 -0400
Received: by ajax-webmail-mail.loongson.cn (Coremail) ; Fri, 2 Jul 2021
 09:15:26 +0800 (GMT+08:00)
X-Originating-IP: [112.20.109.145]
Date:   Fri, 2 Jul 2021 09:15:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Artem Lapkin" <email2tema@gmail.com>, narmstrong@baylibre.com,
        yue.wang@Amlogic.com, khilman@baylibre.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com,
        chenhuacai@gmail.com
Subject: Re: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10a build 20191018(4c4f6d15)
 Copyright (c) 2002-2021 www.mailtech.cn .loongson.cn
In-Reply-To: <20210701154634.GA60743@bjorn-Precision-5520>
References: <20210701154634.GA60743@bjorn-Precision-5520>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <67a9e1fa.81a9.17a64c8e7f7.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf9AxmuCuaN5gtl4bAA--.9556W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQAJBl3QvNnfDwAEsy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIEJqb3JuLAoKJmd0OyAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCiZndDsg5Y+R5Lu25Lq6OiAi
Qmpvcm4gSGVsZ2FhcyIgPGhlbGdhYXNAa2VybmVsLm9yZz4KJmd0OyDlj5HpgIHml7bpl7Q6IDIw
MjEtMDctMDEgMjM6NDY6MzQgKOaYn+acn+WbmykKJmd0OyDmlLbku7bkuro6ICJBcnRlbSBMYXBr
aW4iIDxlbWFpbDJ0ZW1hQGdtYWlsLmNvbT4KJmd0OyDmioTpgIE6IG5hcm1zdHJvbmdAYmF5bGli
cmUuY29tLCB5dWUud2FuZ0BBbWxvZ2ljLmNvbSwga2hpbG1hbkBiYXlsaWJyZS5jb20sIGxvcmVu
em8ucGllcmFsaXNpQGFybS5jb20sIHJvYmhAa2VybmVsLm9yZywga3dAbGludXguY29tLCBqYnJ1
bmV0QGJheWxpYnJlLmNvbSwgY2hyaXN0aWFuc2hld2l0dEBnbWFpbC5jb20sIG1hcnRpbi5ibHVt
ZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20sIGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgtYW1sb2dpY0BsaXN0cy5pbmZy
YWRlYWQub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBhcnRAa2hhZGFzLmNvbSwg
bmlja0BraGFkYXMuY29tLCBnb3V3YUBraGFkYXMuY29tLCAiSHVhY2FpIENoZW4iIDxjaGVuaHVh
Y2FpQGxvb25nc29uLmNuPgomZ3Q7IOS4u+mimDogUmU6IFtQQVRDSCAwLzRdIFBDSTogcmVwbGFj
ZSBkdWJsaWNhdGVkIE1SUlMgbGltaXQgcXVpcmtzCiZndDsgCiZndDsgWytjYyBIdWFjYWldCiZn
dDsgCiZndDsgT24gU2F0LCBKdW4gMTksIDIwMjEgYXQgMDI6Mzk6NDhQTSArMDgwMCwgQXJ0ZW0g
TGFwa2luIHdyb3RlOgomZ3Q7ICZndDsgUmVwbGFjZSBkdWJsaWNhdGVkIE1SUlMgbGltaXQgcXVp
cmtzIGJ5IG1ycnNfbGltaXRfcXVpcmsgZnJvbSBjb3JlCiZndDsgJmd0OyAqIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1rZXlzdG9uZS5jCiZndDsgJmd0OyAqIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpLWxvb25nc29uLmMKJmd0OyAKJmd0OyBzL2R1YmxpY2F0ZWQvZHVwbGljYXRl
ZC8gKHNldmVyYWwgb2NjdXJyZW5jZXMpCiZndDsgCiZndDsgQ2FwaXRhbGl6ZSBzdWJqZWN0IGxp
bmVzLgomZ3Q7IAomZ3Q7IFVzZSAiZ2l0IGxvZyAtLW9ubGluZSIgdG8gbGVhcm4gY29udmVudGlv
bnMgYW5kIGZvbGxvdyB0aGVtLgomZ3Q7IAomZ3Q7IEFkZCAiKCkiIGFmdGVyIGZ1bmN0aW9uIG5h
bWVzLgomZ3Q7IAomZ3Q7IENhcGl0YWxpemUgYWNyb255bXMgYXBwcm9wcmlhdGVseSAoTlZNZSwg
TVJSUywgUENJLCBldGMpLgomZ3Q7IAomZ3Q7IEVuZCBzZW50ZW5jZXMgd2l0aCBwZXJpb2RzLgom
Z3Q7IAomZ3Q7IEEgIm1vdmUiIHBhdGNoIG11c3QgaW5jbHVkZSBib3RoIHRoZSByZW1vdmFsIGFu
ZCB0aGUgYWRkaXRpb24gYW5kIG1ha2UKJmd0OyBubyBjaGFuZ2VzIHRvIHRoZSBjb2RlIGl0c2Vs
Zi4KJmd0OyAKJmd0OyBBbWxvZ2ljIGFwcGVhcnMgd2l0aG91dCBleHBsYW5hdGlvbiBpbiAyLzQu
ICBNdXN0IGJlIHNlcGFyYXRlIHBhdGNoIHRvCiZndDsgYWRkcmVzcyBvbmx5IHRoYXQgc3BlY2lm
aWMgaXNzdWUuICBTaG91bGQgcmVmZXJlbmNlIHB1Ymxpc2hlZCBlcnJhdHVtCiZndDsgaWYgcG9z
c2libGUuICAiU29sdmVzIHNvbWUgaXNzdWUiIGlzIG5vdCBhIGNvbXBlbGxpbmcganVzdGlmaWNh
dGlvbi4KJmd0OyAKJmd0OyBUaGUgdHJlZSBtdXN0IGJlIGNvbnNpc3RlbnQgYW5kIGZ1bmN0aW9u
YWxseSB0aGUgc2FtZSBvciBpbXByb3ZlZAomZ3Q7IGFmdGVyIGV2ZXJ5IHBhdGNoLgomZ3Q7IAom
Z3Q7IEFkZCB0byBwY2lfaWRzLmggb25seSBpZiBzeW1ib2wgdXNlZCBtb3JlIHRoYW4gb25lIHBs
YWNlLgomZ3Q7IAomZ3Q7IFNlZQomZ3Q7IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTA3
MDEwNzQ0NTguMTgwOTUzMi0zLWNoZW5odWFjYWlAbG9vbmdzb24uY24sCiZndDsgd2hpY2ggbG9v
a3Mgc2ltaWxhci4gIENvbWJpbmUgZWZmb3J0cyBpZiBwb3NzaWJsZSBhbmQgY2MgSHVhY2FpIHNv
CiZndDsgeW91J3JlIGJvdGggYXdhcmUgb2Ygb3ZlcmxhcHBpbmcgd29yay4KJmd0OyAKJmd0OyBN
b3JlIGhpbnRzIGluIGNhc2UgdGhleSdyZSB1c2VmdWw6CiZndDsgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtcGNpLzIwMTcxMDI2MjIzNzAxLkdBMjU2NDlAYmhlbGdhYXMtZ2xhcHRvcC5y
b2FtLmNvcnAuZ29vZ2xlLmNvbS8KJmd0OyAKJmd0OyAmZ3Q7IEJvdGgga3NfcGNpZV9xdWlyayBs
b29uZ3Nvbl9tcnJzX3F1aXJrIHdhcyByZXdyaXR0ZW4gd2l0aG91dCBhbnkKJmd0OyAmZ3Q7IGZ1
bmN0aW9uYWxpdHkgY2hhbmdlcyBieSBvbmUgbXJyc19saW1pdF9xdWlyawpEb2VzIHRoYXQgbWVh
bnMga2V5c3RvbmUgYW5kIExvb25nc29uIGhhcyB0aGUgc2FtZSBNUlJTIHByb2JsZW0/IEFuZCB3
aGF0IHNob3VsZCBJIGRvIG5vdz8KCkh1YWNhaQomZ3Q7ICZndDsgCiZndDsgJmd0OyBBZGRlZCBE
ZXNpZ25XYXJlIFBDSSBjb250cm9sbGVyIHdoaWNoIG5lZWQgc2FtZSBxdWlyayBmb3IKJmd0OyAm
Z3Q7ICogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLW1lc29uLmMgKFBDSV9ERVZJQ0Vf
SURfU1lOT1BTWVNfSEFQU1VTQjMpCiZndDsgJmd0OyAKJmd0OyAmZ3Q7IFRoaXMgcXVpcmsgY2Fu
IHNvbHZlIHNvbWUgaXNzdWUgZm9yIEtoYWRhcyBWSU0zL1ZJTTNMKEFtbG9naWMpCiZndDsgJmd0
OyB3aXRoIEhETUkgc2NyYW1ibGVkIHBpY3R1cmUgYW5kIG52bWUgZGV2aWNlcyBhdCBpbnRlbnNp
dmUgd3JpdGluZy4uLgomZ3Q7ICZndDsgCiZndDsgJmd0OyBjb21lIGZyb206CiZndDsgJmd0OyAq
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDIxMDYxODA2MzgyMS4xMzgzMzU3
LTEtYXJ0QGtoYWRhcy5jb20vCiZndDsgJmd0OyAKJmd0OyAmZ3Q7IEFydGVtIExhcGtpbiAoNCk6
CiZndDsgJmd0OyAgUENJOiBtb3ZlIEtleXN0b25lIGFuZCBMb29uZ3NvbiBkZXZpY2UgSURzIHRv
IHBjaV9pZHMKJmd0OyAmZ3Q7ICBQQ0k6IGNvcmU6IHF1aXJrczogYWRkIG1ycnNfbGltaXRfcXVp
cmsKJmd0OyAmZ3Q7ICBQQ0k6IGtleXN0b25lIG1vdmUgbXJycyBxdWlyayB0byBjb3JlCiZndDsg
Jmd0OyAgUENJOiBsb29uZ3NvbiBtb3ZlIG1ycnMgcXVpcmsgdG8gY29yZQomZ3Q7ICZndDsgCiZn
dDsgJmd0OyAtLSAKJmd0OyAmZ3Q7IDIuMjUuMQomZ3Q7ICZndDsKCgo8L2NoZW5odWFjYWlAbG9v
bmdzb24uY24+PC9lbWFpbDJ0ZW1hQGdtYWlsLmNvbT48L2hlbGdhYXNAa2VybmVsLm9yZz4=
