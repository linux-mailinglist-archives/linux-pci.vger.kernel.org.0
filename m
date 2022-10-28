Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0886108B6
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 05:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiJ1D1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 23:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiJ1D1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 23:27:37 -0400
X-Greylist: delayed 1809 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Oct 2022 20:27:35 PDT
Received: from m1390.mail.163.com (m1390.mail.163.com [220.181.13.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADC1C6B64B;
        Thu, 27 Oct 2022 20:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ChfsP
        hSBHVJpAeVptbDBbTdrVkeaHzjzfQ3nICLGKio=; b=N6DxnqDcqoh6BOjxHU/d9
        9E6U3xIXBHq6HGvvafe8E1EGtk3DejzvlX/DqDc6OcxzzyML9VUrHe6dp4qtDH+7
        cJw68H8+K55//DmnqWr21yB9frBucqzVlHmvXFz8dUIZLnNc50cNvIstGuY2ZJ9x
        +80aKhfQe9mn88TPC/SqYU=
Received: from slark_xiao$163.com ( [223.104.77.214] ) by
 ajax-webmail-wmsvr90 (Coremail) ; Fri, 28 Oct 2022 10:41:55 +0800 (CST)
X-Originating-IP: [223.104.77.214]
Date:   Fri, 28 Oct 2022 10:41:55 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] PCI: Add vendor ID for Quectel and Cinterion
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20221027142742.GA826519@bhelgaas>
References: <20221027142742.GA826519@bhelgaas>
X-NTES-SC: AL_QuydBPWZu0Eq4yaRZekWkkcRjuo+UMC0vfgh249fPJs0pSr/www5QX57MEDZ1t2MOymVsRmZbTJx0slFZrhoU5nmRCR0rlnB/9q+lWjAvlKH
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5ef2b67c.fb2.1841c77abf2.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: WsGowABnJv10QVtjkdVEAA--.15727W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQSoZGBbF8ys6AACsb
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMTAtMjcgMjI6Mjc6NDIsICJCam9ybiBIZWxnYWFzIiA8
aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToKPk9uIFRodSwgT2N0IDI3LCAyMDIyIGF0IDA3OjUx
OjIzUE0gKzA4MDAsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+IEluIE1ISSBkcml2ZXIsIHRoZXJlIGFy
ZSBzb21lIGNvbXBhbmllcyBwcm9kdWN0IHN0aWxsCj4+IGRvIG5vdCBoYXZlIHRoZWlyIG93biBQ
Q0kgdmVuZG9yIG1hY3JvLiBTbyB3ZSBhZGQgaXQKPj4gaGVyZSB0byBtYWtlIHRoZSBjb2RlIG5l
YXQuIFJlZiBJRCBjb3VsZCBiZSBmb3VuZCBpbgo+PiBsaW5rIGh0dHBzOi8vcGNpc2lnLmNvbS9t
ZW1iZXJzaGlwL21lbWJlci1jb21wYW5pZXMuCj4KPlJld3JhcCB0byBmaWxsIDc1IGNvbHVtbnMu
Cj4KPlBvc3QgYWxvbmcgd2l0aCB0aGUgcGF0Y2ggdGhhdCB1c2VzIHRoZSBkZWZpbml0aW9ucy4K
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+Cj4+IC0t
LQo+PiAgaW5jbHVkZS9saW51eC9wY2lfaWRzLmggfCA0ICsrKysKPj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaV9p
ZHMuaCBiL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oCj4+IGluZGV4IGIzNjJkOTBlYjliMC4uZTNi
ZmVhMDZiOTBlIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaAo+PiArKysg
Yi9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaAo+PiBAQCAtMTcyLDYgKzE3MiwxMCBAQAo+PiAgI2Rl
ZmluZSBQQ0lfREVWSUNFX0lEX0JFUktPTV9BNFQJCTB4ZmZhNAo+PiAgI2RlZmluZSBQQ0lfREVW
SUNFX0lEX0JFUktPTV9TQ0lURUxfUVVBRFJPCTB4ZmZhOAo+PiAgCj4+ICsjZGVmaW5lIFBDSV9W
RU5ET1JfSURfQ0lOVEVSSU9OCQkweDEyNjkKPgo+VGhlIFVSTCBhYm92ZSBzYXlzIDB4MTI2OSBi
ZWxvbmdzIHRvIFRoYWxlcy4gIE1heWJlIGFkZCBhIGNvbW1lbnQgdG8KPnRoYXQgZWZmZWN0LCBz
aW1pbGFyIHRvIHRoZSBvbmUgZm9yIFBDSV9WRU5ET1JfSURfQ0IuCj4KPj4gKyNkZWZpbmUgUENJ
X1ZFTkRPUl9JRF9RVUVDVEVMCQkweDFlYWMKPgo+Qm90aCBuZXcgZGVmaW5pdGlvbnMgbG9vayBs
aWtlIHRoZXkncmUgZHJvcHBlZCBpbiBhIHJhbmRvbSBsb2NhdGlvbi4KPlBsZWFzZSBtb3ZlIHRo
ZW0gc28gdGhlIHZlbmRvciBJRHMgaW4gdGhlIGZpbGUgcmVtYWluIHNvcnRlZCBieQo+bnVtZXJp
YyB2YWx1ZS4KPgpIaSBCam9ybiwKICBWMiB2ZXJzaW9uIGlzIHNlbnQuIEkgYWRkIGV4cGxhbmF0
aW9uIGFib3V0IHRoZSByZWxhdGlvbnNoaXAgYmV0d2VlbiBUaGFsZXMgCmFuZCBDSW50ZXJpb24u
IEFuZCBJIGp1c3QgIGZpbmQgdGhlc2UgVklEcyBhcmUgc29ydGVkIGJ5IG51bWVyaWMsIHNvIEkg
Zml4IGl0IGluIHYyLgoKVGhhbmtzLiAKPj4gICNkZWZpbmUgUENJX1ZFTkRPUl9JRF9DT01QQVEJ
CTB4MGUxMQo+PiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX0NPTVBBUV9UT0tFTlJJTkcJMHgwNTA4
Cj4+ICAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfQ09NUEFRX1RBQ0hZT04JMHhhMGZjCj4+IC0tIAo+
PiAyLjM0LjEKPj4gCg==
