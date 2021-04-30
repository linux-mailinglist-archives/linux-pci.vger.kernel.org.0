Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A006D36F65C
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhD3HZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 03:25:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56878 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229590AbhD3HZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 03:25:50 -0400
X-UUID: 40e94ae71d2b470cb30089d2faf0ecd9-20210430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fYnTZjtZi+ChPsBsoKvCFsCx7AX5XBrzMnGC25v6LBM=;
        b=mvXaxDuDdgyPXqi2LZaYW4uD81lp8SmL5kiv8z/Cc5t8Iwq6hG65og37ozLGgqoIVExkVXvoocYZsFXc4RpOGnuqESAST7+ThDxQS/OgkRPZhxiVNFXkFHeOFQYwXqI01rQ3gp2a1U3Hn8qVaQPXkvonVh4QlfKEv0C7uokzYfo=;
X-UUID: 40e94ae71d2b470cb30089d2faf0ecd9-20210430
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1956212543; Fri, 30 Apr 2021 15:24:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 30 Apr
 2021 15:24:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Apr 2021 15:24:54 +0800
Message-ID: <1619767494.1027.3.camel@mhfsdcap03>
Subject: Re: [PATCH][next] PCI: mediatek-gen3: Add missing null pointer check
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Colin King <colin.king@canonical.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Fri, 30 Apr 2021 15:24:54 +0800
In-Reply-To: <20210429110040.63119-1-colin.king@canonical.com>
References: <20210429110040.63119-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8410CB59BBA8CE1684706891C6FE72A498F1C9DD1D6662302587175341C90FE22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQ29saW4sDQoNCk9uIFRodSwgMjAyMS0wNC0yOSBhdCAxMjowMCArMDEwMCwgQ29saW4gS2lu
ZyB3cm90ZToNCj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNv
bT4NCj4gDQo+IFRoZSBjYWxsIHRvIHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUgY2FuIHBv
dGVudGlhbGx5IHJldHVybiBudWxsLCBzbw0KPiBhZGQgYSBudWxsIHBvaW50ZXIgY2hlY2sgdG8g
YXZvaWQgYSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UgaXNzdWUuDQo+IA0KPiBBZGRyZXNzZXMt
Q292ZXJpdHk6ICgiRGVyZWZlcmVuY2UgbnVsbCByZXR1cm4iKQ0KPiBGaXhlczogNDQxOTAzZDll
OGYwICgiUENJOiBtZWRpYXRlay1nZW4zOiBBZGQgTWVkaWFUZWsgR2VuMyBkcml2ZXIgZm9yIE1U
ODE5MiIpDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9u
aWNhbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVr
LWdlbjMuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5j
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiBpbmRleCAy
MDE2NWU0YTc1YjIuLjNjNWI5NzcxNmQ0MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IEBAIC03MjEsNiArNzIxLDggQEAgc3RhdGljIGlu
dCBtdGtfcGNpZV9wYXJzZV9wb3J0KHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiAgCWlu
dCByZXQ7DQo+ICANCj4gIAlyZWdzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgInBjaWUtbWFjIik7DQo+ICsJaWYgKCFyZWdzKQ0KPiArCQlyZXR1
cm4gLUVJTlZBTDsNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KDQpkZXZtX2lvcmVtYXBfcmVz
b3VyY2UoKSB3aWxsIGNoZWNrIGFuZCBkZWNvZGUgdGhpcyBudWxsIHBvaW50ZXINCmRlcmVmZXJl
bmNlIGVycm9yLCBzbyBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gY2hlY2sgaGVyZS4NCg0KVGhh
bmtzLg0KDQo+ICAJcG9ydC0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlZ3Mp
Ow0KPiAgCWlmIChJU19FUlIocG9ydC0+YmFzZSkpIHsNCj4gIAkJZGV2X2VycihkZXYsICJmYWls
ZWQgdG8gbWFwIHJlZ2lzdGVyIGJhc2VcbiIpOw0KDQoNCg==

