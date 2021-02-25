Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6A532497F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 04:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBYDfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 22:35:38 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38103 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229466AbhBYDfi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 22:35:38 -0500
X-UUID: 370eee8b7744405d9cddd96f74e00801-20210225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kjY3YWrArb7e1auQGb2M/I7sB1u1U1g/YZLxN9Rl800=;
        b=ROu/egn/o8mV6ahwqK0C3xgYpHrYFB0Tx5QVbeuDRlVB7nHzohGoh4kXqve+ZdIn9mLQb15TACgDOqGTsgScq6cDyVXi5sWMyNohnQod3l0WRNlqG/sTFzyA1flbE6BhD3xNFfVchlZYsz+uHdJ5F43ZYFq7arXytwb68URxXb8=;
X-UUID: 370eee8b7744405d9cddd96f74e00801-20210225
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 638520649; Thu, 25 Feb 2021 11:34:54 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 11:34:50 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 11:34:49 +0800
Message-ID: <1614224089.25750.14.camel@mhfsdcap03>
Subject: Re: [v8,6/7] PCI: mediatek-gen3: Add system PM support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Sj Huang" <sj.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>, <drinkcat@chromium.org>,
        <Rex-BC.Chen@mediatek.com>, <anson.chuang@mediatek.com>
Date:   Thu, 25 Feb 2021 11:34:49 +0800
In-Reply-To: <YDZeRc6CHV/WzyCm@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-7-jianjun.wang@mediatek.com>
         <YDZeRc6CHV/WzyCm@rocinante>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B8240DFBE026559C95C4FF794CAECB89FE75F5E7653980143DBA6B8E787D410D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LA0KDQpPbiBXZWQsIDIwMjEt
MDItMjQgYXQgMTU6MTAgKzAxMDAsIEtyenlzenRvZiBXaWxjennFhHNraSB3cm90ZToNCj4gSGkg
Smlhbmp1biwNCj4gDQo+ID4gQWRkIHN1c3BlbmRfbm9pcnEgYW5kIHJlc3VtZV9ub2lycSBjYWxs
YmFjayBmdW5jdGlvbnMgdG8gaW1wbGVtZW50DQo+ID4gUE0gc3lzdGVtIHN1c3BlbmQgaG9va3Mg
Zm9yIE1lZGlhVGVrIEdlbjMgUENJZSBjb250cm9sbGVyLg0KPiANCj4gU28sICJzeXN0ZW1zIHN1
c3BlbmQiIGFuZCAicmVzdW1lIiBob29rcywgY29ycmVjdD8NCg0KVGhlIGNhbGxiYWNrIGZ1bmN0
aW9ucyBpcyBzdXNwZW5kX25vaXJxIGFuZCByZXN1bWVfbm9pcnEsIHNob3VsZCBJIHVzZQ0KInN5
c3RlbXMgc3VzcGVuZCIgYW5kICJyZXN1bWUiIGluIHRoZSBjb21taXQgbWVzc2FnZT8NCg0KPiAN
Cj4gPiBXaGVuIHN5c3RlbSBzdXNwZW5kLCB0cmlnZ2VyIHRoZSBQQ0llIGxpbmsgdG8gTDIgc3Rh
dGUgYW5kIHB1bGwgZG93bg0KPiANCj4gSXQgcHJvYmFibHkgd291bGQgYmUgInRoZSBzeXN0ZW0g
c3VzcGVuZHMiLg0KPiANCj4gWy4uLl0NCj4gPiBXaGVuIHN5c3RlbSByZXN1bSwgdGhlIFBDSWUg
bGluayBzaG91bGQgYmUgcmUtZXN0YWJsaXNoZWQgYW5kIHRoZQ0KPiA+IHJlbGF0ZWQgY29udHJv
bCByZWdpc3RlciB2YWx1ZXMgc2hvdWxkIGJlIHJlc3RvcmVkLg0KPiANCj4gU2ltaWxhcmx5IHRv
IHRoZSBhYm92ZTogInRoZSBzeXN0ZW0gcmVzdW1lcyIuDQo+IA0KPiBbLi4uXQ0KPiA+ICsJaWYg
KGVycikgew0KPiA+ICsJCWRldl9lcnIocG9ydC0+ZGV2LCAiY2FuIG5vdCBlbnRlciBMMiBzdGF0
ZVxuIik7DQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArCX0NCj4gDQo+IE1vc3QgbGlrZWx5IHlv
dSB3YW50ICJjYW5ub3QiIG9yICJjYW4ndCIgaW4gdGhlIGFib3ZlIGVycm9yIG1lc3NhZ2UuDQo+
IA0KPiA+ICsJLyogUHVsbCBkb3duIHRoZSBQRVJTVCMgcGluICovDQo+ID4gKwl2YWwgPSByZWFk
bF9yZWxheGVkKHBvcnQtPmJhc2UgKyBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+ID4gKwl2YWwgfD0g
UENJRV9QRV9SU1RCOw0KPiA+ICsJd3JpdGVsX3JlbGF4ZWQodmFsLCBwb3J0LT5iYXNlICsgUENJ
RV9SU1RfQ1RSTF9SRUcpOw0KPiA+ICsNCj4gPiArCWRldl9kYmcocG9ydC0+ZGV2LCAiZW50ZXIg
TDIgc3RhdGUgc3VjY2VzcyIpOw0KPiANCj4gSnVzdCBhIG5pdHBpY2suICBXaGF0IGFib3V0ICJl
bnRlcmVkIEwyIHN0YXRlcyBzdWNjZXNzZnVsbHkiPw0KPiANCj4gWy4uLl0NCj4gPiArCWlmIChl
cnIpIHsNCj4gPiArCQlkZXZfZXJyKHBvcnQtPmRldiwgInJlc3VtZSBmYWlsZWRcbiIpOw0KPiA+
ICsJCXJldHVybiBlcnI7DQo+ID4gKwl9DQo+IA0KPiBUaGlzIGVycm9yIG1lc3NhZ2UgZG9lcyBu
b3QgcXVpdGUgY29udmV5IHRoYXQgdGhlIG10a19wY2llX3N0YXJ0dXBfcG9ydCgpDQo+IHdhcyB0
aGUgZnVuY3Rpb24gdGhhdCBmYWlsZWQsIHdoaWNoIGlzIG9ubHkgYSBwYXJ0IG9mIHdoYXQgeW91
IGhhdmUgdG8gZG8NCj4gdG8gc3VjY2Vzc2Z1bGx5IHJlc3VtZS4NCj4gDQo+ID4gKwlkZXZfZGJn
KHBvcnQtPmRldiwgInJlc3VtZSBkb25lXG4iKTsNCj4gDQo+IEEgbml0cGljay4gIFByb2JhYmx5
IG5vdCBuZWVkZWQsIGFzIGxhY2sgb2YgZXJyb3IgbWVzc2FnZSB3b3VsZCBtZWFuDQo+IHRoYXQg
dGhlIGRldmljZSByZXN1bWVkIHN1Y2Nlc3NmdWxseSBhZnRlciBiZWluZyBzdXNwZW5kZWQuDQo+
IA0KPiBLcnp5c3p0b2YNCg0KVGhhbmtzLg0KDQo=

