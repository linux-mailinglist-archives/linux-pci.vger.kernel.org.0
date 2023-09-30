Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855437B3FC9
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 11:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjI3J5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Sep 2023 05:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjI3J5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2023 05:57:03 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A311FDD;
        Sat, 30 Sep 2023 02:56:58 -0700 (PDT)
Received: from dinghao.liu$zju.edu.cn ( [10.192.195.11] ) by
 ajax-webmail-mail-app3 (Coremail) ; Sat, 30 Sep 2023 17:56:29 +0800
 (GMT+08:00)
X-Originating-IP: [10.192.195.11]
Date:   Sat, 30 Sep 2023 17:56:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Marc Zyngier" <maz@kernel.org>
Cc:     "Toan Le" <toan@os.amperecomputing.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>, "Duc Dang" <dhdang@apm.com>,
        "Tanmay Inamdar" <tinamdar@apm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene-msi: Fix a potential UAF in xgene_msi_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <87jzs9mjdh.wl-maz@kernel.org>
References: <20230926025936.7115-1-dinghao.liu@zju.edu.cn>
 <87jzs9mjdh.wl-maz@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <23c09050.48ec5.18ae584a39d.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgD3_8PO8BdlsEwhAQ--.37042W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgIKBmURl6BBWgARsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBPbiBUdWUsIDI2IFNlcCAyMDIzIDAzOjU5OjM2ICswMTAwLAo+IERpbmdoYW8gTGl1IDxkaW5n
aGFvLmxpdUB6anUuZWR1LmNuPiB3cm90ZToKPiA+IAo+ID4geGdlbmVfYWxsb2NhdGVfZG9tYWlu
cygpIHdpbGwgY2FsbCBpcnFfZG9tYWluX3JlbW92ZSgpIHRvIGZyZWUKPiA+IG1zaS0+aW5uZXJf
ZG9tYWluIG9uIGZhaWx1cmUuIEhvd2V2ZXIsIGl0cyBjYWxsZXIsIHhnZW5lX21zaV9wcm9iZSgp
LAo+ID4gd2lsbCBhbHNvIGNhbGwgaXJxX2RvbWFpbl9yZW1vdmUoKSB0aHJvdWdoIHhnZW5lX21z
aV9yZW1vdmUoKSBvbiB0aGUKPiA+IHNhbWUgZmFpbHVyZSwgd2hpY2ggbWF5IGxlYWQgdG8gYSB1
c2UtYWZ0ZXItZnJlZS4gUmVtb3ZlIHRoZSBmaXJzdAo+ID4gaXJxX2RvbWFpbl9yZW1vdmUoKSBh
bmQgbGV0IHhnZW5lX2ZyZWVfZG9tYWlucygpIGNsZWFudXAgZG9tYWlucy4KPiA+IAo+ID4gRml4
ZXM6IGRjZDE5ZGUzNjc3NSAoIlBDSTogeGdlbmU6IEFkZCBBUE0gWC1HZW5lIHYxIFBDSWUgTVNJ
L01TSVggdGVybWluYXRpb24gZHJpdmVyIikKPiA+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1
IDxkaW5naGFvLmxpdUB6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiAKPiA+IENoYW5nZWxvZzoKPiA+
IAo+ID4gdjI6IC1SZW1vdmUgaXJxX2RvbWFpbl9yZW1vdmUoKSBpbnN0ZWFkIG9mIG51bGxpbmcg
bXNpX2RvbWFpbi4KPiAKPiBVbmZvcnR1bmF0ZWx5LCB5b3VyIGVtYWlsIGRvZXNuJ3QgaW5kaWNh
dGUgdGhpcyBpcyB2Mi4KClNvcnJ5LCBteSBtaXN0YWtlLiBJIHdpbGwgcmVzZW5kIGEgbmV3IHBh
dGNoIHNvb24uCgpSZWdhcmRzLApEaW5naGFv
