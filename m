Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA72336F3A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 10:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhCKJur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 04:50:47 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23322 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232120AbhCKJuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 04:50:25 -0500
X-UUID: e5328eea42a34bd78e6899844d53d5dc-20210311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=a9ej59heEilQzTKWC4HbE25Ht5GD9Ct0059vCNX/I/s=;
        b=b/fiesXnCh7ySSCfvoHnSxpK/D4VYjfKySMm1KzuavvUqrRLcZl0zuryJ9ZuWVp0dbATFvwLXEC1/GFGdB7hg5cijeMlJ38lux1g+R/ZkJgyHWNftPczFTIyhV4czctrYw9SvggcuJEMSXuoCIhSlnMBZiGNIhg9W1/aXCLoFV4=;
X-UUID: e5328eea42a34bd78e6899844d53d5dc-20210311
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1471753253; Thu, 11 Mar 2021 17:50:17 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Mar
 2021 17:50:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Mar 2021 17:50:14 +0800
Message-ID: <1615456214.25662.62.camel@mhfsdcap03>
Subject: Re: [v8,5/7] PCI: mediatek-gen3: Add MSI support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Date:   Thu, 11 Mar 2021 17:50:14 +0800
In-Reply-To: <e6c53aa3863c3f5b0560ed65282fc5e2@kernel.org>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-6-jianjun.wang@mediatek.com>
         <20210311000555.epypouwxdbql2aqx@pali>
         <e6c53aa3863c3f5b0560ed65282fc5e2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F9A112B6DED8DAAFAF6E68A112F27E84405F5EF3E9F86C2A91FF46CE880EBB382000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTExIGF0IDA4OjE5ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIDIwMjEtMDMtMTEgMDA6MDUsIFBhbGkgUm9ow6FyIHdyb3RlOg0KPiA+IE9uIFdlZG5lc2Rh
eSAyNCBGZWJydWFyeSAyMDIxIDE0OjExOjMwIEppYW5qdW4gV2FuZyB3cm90ZToNCj4gPj4gK3N0
YXRpYyBpbnQgbXRrX21zaV9ib3R0b21fZG9tYWluX2FsbG9jKHN0cnVjdCBpcnFfZG9tYWluICpk
b21haW4sDQo+ID4+ICsJCQkJICAgICAgIHVuc2lnbmVkIGludCB2aXJxLCB1bnNpZ25lZCBpbnQg
bnJfaXJxcywNCj4gPj4gKwkJCQkgICAgICAgdm9pZCAqYXJnKQ0KPiA+PiArew0KPiA+PiArCXN0
cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0ID0gZG9tYWluLT5ob3N0X2RhdGE7DQo+ID4+ICsJc3Ry
dWN0IG10a19tc2lfc2V0ICptc2lfc2V0Ow0KPiA+PiArCWludCBpLCBod2lycSwgc2V0X2lkeDsN
Cj4gPj4gKw0KPiA+PiArCW11dGV4X2xvY2soJnBvcnQtPmxvY2spOw0KPiA+PiArDQo+ID4+ICsJ
aHdpcnEgPSBiaXRtYXBfZmluZF9mcmVlX3JlZ2lvbihwb3J0LT5tc2lfaXJxX2luX3VzZSwgDQo+
ID4+IFBDSUVfTVNJX0lSUVNfTlVNLA0KPiA+PiArCQkJCQlvcmRlcl9iYXNlXzIobnJfaXJxcykp
Ow0KPiA+PiArDQo+ID4+ICsJbXV0ZXhfdW5sb2NrKCZwb3J0LT5sb2NrKTsNCj4gPj4gKw0KPiA+
PiArCWlmIChod2lycSA8IDApDQo+ID4+ICsJCXJldHVybiAtRU5PU1BDOw0KPiA+PiArDQo+ID4+
ICsJc2V0X2lkeCA9IGh3aXJxIC8gUENJRV9NU0lfSVJRU19QRVJfU0VUOw0KPiA+PiArCW1zaV9z
ZXQgPSAmcG9ydC0+bXNpX3NldHNbc2V0X2lkeF07DQo+ID4+ICsNCj4gPj4gKwlmb3IgKGkgPSAw
OyBpIDwgbnJfaXJxczsgaSsrKQ0KPiA+PiArCQlpcnFfZG9tYWluX3NldF9pbmZvKGRvbWFpbiwg
dmlycSArIGksIGh3aXJxICsgaSwNCj4gPj4gKwkJCQkgICAgJm10a19tc2lfYm90dG9tX2lycV9j
aGlwLCBtc2lfc2V0LA0KPiA+PiArCQkJCSAgICBoYW5kbGVfZWRnZV9pcnEsIE5VTEwsIE5VTEwp
Ow0KPiA+PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gK3N0YXRp
YyB2b2lkIG10a19tc2lfYm90dG9tX2RvbWFpbl9mcmVlKHN0cnVjdCBpcnFfZG9tYWluICpkb21h
aW4sDQo+ID4+ICsJCQkJICAgICAgIHVuc2lnbmVkIGludCB2aXJxLCB1bnNpZ25lZCBpbnQgbnJf
aXJxcykNCj4gPj4gK3sNCj4gPj4gKwlzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCA9IGRvbWFp
bi0+aG9zdF9kYXRhOw0KPiA+PiArCXN0cnVjdCBpcnFfZGF0YSAqZGF0YSA9IGlycV9kb21haW5f
Z2V0X2lycV9kYXRhKGRvbWFpbiwgdmlycSk7DQo+ID4+ICsNCj4gPj4gKwltdXRleF9sb2NrKCZw
b3J0LT5sb2NrKTsNCj4gPj4gKw0KPiA+PiArCWJpdG1hcF9jbGVhcihwb3J0LT5tc2lfaXJxX2lu
X3VzZSwgZGF0YS0+aHdpcnEsIG5yX2lycXMpOw0KPiA+IA0KPiA+IE1hcmMsIHNob3VsZCBub3Qg
YmUgdGhlcmUgYml0bWFwX3JlbGVhc2VfcmVnaW9uKCkgd2l0aCBvcmRlcl9iYXNlXzIoKT8NCj4g
PiANCj4gPiBiaXRtYXBfcmVsZWFzZV9yZWdpb24ocG9ydC0+bXNpX2lycV9pbl91c2UsIGRhdGEt
Pmh3aXJxLCANCj4gPiBvcmRlcl9iYXNlXzIobnJfaXJxcykpOw0KPiA+IA0KPiA+IEJlY2F1c2Ug
bXRrX21zaV9ib3R0b21fZG9tYWluX2FsbG9jKCkgaXMgYWxsb2NhdGluZw0KPiA+IG9yZGVyX2Jh
c2VfMihucl9pcnFzKSBpbnRlcnJ1cHRzLCBub3Qgb25seSBucl9pcnFzLg0KPiANCj4gSW5kZWVk
LCBnb29kIGNhdGNoLg0KDQpJIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHZlcnNpb24sIHRoYW5r
cyBmb3IgeW91ciByZXZpZXcuDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgIE0uDQoN
Cg==

