Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C0333392
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 04:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhCJDGF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 22:06:05 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:35531 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231146AbhCJDFg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 22:05:36 -0500
X-UUID: ec2c40e8e76549dcb83f8aff733505f3-20210310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lgYMPyfI/gWImJMYFgXEdeuYn+Gaj//HQfyXplO2nUg=;
        b=eAHR7Z6RgBLPZpqeXzb9EruqMIo/qOlOo/6Y4ox0RMVLVYB5QvAVmWbyIFrVCxOWZlpK11cB6/arcTCeHY36cddYg6saHulGstBStMlO8J+03UFCKGzfkQNKqWaQRpTjHKJETQUGmFJZUZ+Od+ytLqLwSu3aZ2IjUkWTgxQqf9s=;
X-UUID: ec2c40e8e76549dcb83f8aff733505f3-20210310
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 705515882; Wed, 10 Mar 2021 11:05:28 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Mar
 2021 11:05:22 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Mar 2021 11:05:17 +0800
Message-ID: <1615345515.25662.12.camel@mhfsdcap03>
Subject: Re: [v8,4/7] PCI: mediatek-gen3: Add INTx support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
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
Date:   Wed, 10 Mar 2021 11:05:15 +0800
In-Reply-To: <87r1koy442.wl-maz@kernel.org>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-5-jianjun.wang@mediatek.com>
         <87r1koy442.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D305C0EB95B1E4DB84B071274B4E294D18232D4B3400CB35DD62537707EF37132000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTA5IGF0IDExOjEwICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIFdlZCwgMjQgRmViIDIwMjEgMDY6MTE6MjkgKzAwMDAsDQo+IEppYW5qdW4gV2FuZyA8amlh
bmp1bi53YW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQWRkIElOVHggc3VwcG9y
dCBmb3IgTWVkaWFUZWsgR2VuMyBQQ0llIGNvbnRyb2xsZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogSmlhbmp1biBXYW5nIDxqaWFuanVuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IEFja2Vk
LWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCAxNzYgKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3NiBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1n
ZW4zLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4g
aW5kZXggYzYwMmJlYjlhZmVjLi44YjNiNWY4MzhiNjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiBAQCAtOSw2ICs5LDkgQEAN
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZGVsYXku
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
aXJxLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pcnFjaGlwL2NoYWluZWRfaXJxLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9pcnFkb21haW4uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5l
bC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51
eC9wY2kuaD4NCj4gPiBAQCAtNDUsNiArNDgsMTMgQEANCj4gPiAgI2RlZmluZSBQQ0lFX0xJTktf
U1RBVFVTX1JFRwkJMHgxNTQNCj4gPiAgI2RlZmluZSBQQ0lFX1BPUlRfTElOS1VQCQlCSVQoOCkN
Cj4gPiAgDQo+ID4gKyNkZWZpbmUgUENJRV9JTlRfRU5BQkxFX1JFRwkJMHgxODANCj4gPiArI2Rl
ZmluZSBQQ0lFX0lOVFhfU0hJRlQJCQkyNA0KPiA+ICsjZGVmaW5lIFBDSUVfSU5UWF9FTkFCTEUg
XA0KPiA+ICsJR0VOTUFTSyhQQ0lFX0lOVFhfU0hJRlQgKyBQQ0lfTlVNX0lOVFggLSAxLCBQQ0lF
X0lOVFhfU0hJRlQpDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFBDSUVfSU5UX1NUQVRVU19SRUcJCTB4
MTg0DQo+ID4gKw0KPiA+ICAjZGVmaW5lIFBDSUVfVFJBTlNfVEFCTEVfQkFTRV9SRUcJMHg4MDAN
Cj4gPiAgI2RlZmluZSBQQ0lFX0FUUl9TUkNfQUREUl9NU0JfT0ZGU0VUCTB4NA0KPiA+ICAjZGVm
aW5lIFBDSUVfQVRSX1RSU0xfQUREUl9MU0JfT0ZGU0VUCTB4OA0KPiA+IEBAIC03Myw2ICs4Myw5
IEBADQo+ID4gICAqIEBwaHk6IFBIWSBjb250cm9sbGVyIGJsb2NrDQo+ID4gICAqIEBjbGtzOiBQ
Q0llIGNsb2Nrcw0KPiA+ICAgKiBAbnVtX2Nsa3M6IFBDSWUgY2xvY2tzIGNvdW50IGZvciB0aGlz
IHBvcnQNCj4gPiArICogQGlycTogUENJZSBjb250cm9sbGVyIGludGVycnVwdCBudW1iZXINCj4g
PiArICogQGlycV9sb2NrOiBsb2NrIHByb3RlY3RpbmcgSVJRIHJlZ2lzdGVyIGFjY2Vzcw0KPiA+
ICsgKiBAaW50eF9kb21haW46IGxlZ2FjeSBJTlR4IElSUSBkb21haW4NCj4gPiAgICovDQo+ID4g
IHN0cnVjdCBtdGtfcGNpZV9wb3J0IHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiBA
QCAtODMsNiArOTYsMTAgQEAgc3RydWN0IG10a19wY2llX3BvcnQgew0KPiA+ICAJc3RydWN0IHBo
eSAqcGh5Ow0KPiA+ICAJc3RydWN0IGNsa19idWxrX2RhdGEgKmNsa3M7DQo+ID4gIAlpbnQgbnVt
X2Nsa3M7DQo+ID4gKw0KPiA+ICsJaW50IGlycTsNCj4gPiArCXJhd19zcGlubG9ja190IGlycV9s
b2NrOw0KPiA+ICsJc3RydWN0IGlycV9kb21haW4gKmludHhfZG9tYWluOw0KPiA+ICB9Ow0KPiA+
ICANCj4gPiAgLyoqDQo+ID4gQEAgLTE5OSw2ICsyMTYsMTEgQEAgc3RhdGljIGludCBtdGtfcGNp
ZV9zdGFydHVwX3BvcnQoc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQpDQo+ID4gIAl2YWwgfD0g
UENJX0NMQVNTKFBDSV9DTEFTU19CUklER0VfUENJIDw8IDgpOw0KPiA+ICAJd3JpdGVsX3JlbGF4
ZWQodmFsLCBwb3J0LT5iYXNlICsgUENJRV9QQ0lfSURTXzEpOw0KPiA+ICANCj4gPiArCS8qIE1h
c2sgYWxsIElOVHggaW50ZXJydXB0cyAqLw0KPiA+ICsJdmFsID0gcmVhZGxfcmVsYXhlZChwb3J0
LT5iYXNlICsgUENJRV9JTlRfRU5BQkxFX1JFRyk7DQo+ID4gKwl2YWwgJj0gflBDSUVfSU5UWF9F
TkFCTEU7DQo+ID4gKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBvcnQtPmJhc2UgKyBQQ0lFX0lOVF9F
TkFCTEVfUkVHKTsNCj4gPiArDQo+ID4gIAkvKiBBc3NlcnQgYWxsIHJlc2V0IHNpZ25hbHMgKi8N
Cj4gPiAgCXZhbCA9IHJlYWRsX3JlbGF4ZWQocG9ydC0+YmFzZSArIFBDSUVfUlNUX0NUUkxfUkVH
KTsNCj4gPiAgCXZhbCB8PSBQQ0lFX01BQ19SU1RCIHwgUENJRV9QSFlfUlNUQiB8IFBDSUVfQlJH
X1JTVEIgfCBQQ0lFX1BFX1JTVEI7DQo+ID4gQEAgLTI2Miw2ICsyODQsMTU0IEBAIHN0YXRpYyBp
bnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0KHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiA+
ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRpYyBpbnQgbXRrX3BjaWVfc2V0
X2FmZmluaXR5KHN0cnVjdCBpcnFfZGF0YSAqZGF0YSwNCj4gPiArCQkJCSBjb25zdCBzdHJ1Y3Qg
Y3B1bWFzayAqbWFzaywgYm9vbCBmb3JjZSkNCj4gPiArew0KPiA+ICsJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIG10a19pbnR4X21hc2soc3RydWN0IGly
cV9kYXRhICpkYXRhKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCA9
IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGRhdGEpOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBm
bGFnczsNCj4gPiArCXUzMiB2YWw7DQo+ID4gKw0KPiA+ICsJcmF3X3NwaW5fbG9ja19pcnFzYXZl
KCZwb3J0LT5pcnFfbG9jaywgZmxhZ3MpOw0KPiA+ICsJdmFsID0gcmVhZGxfcmVsYXhlZChwb3J0
LT5iYXNlICsgUENJRV9JTlRfRU5BQkxFX1JFRyk7DQo+ID4gKwl2YWwgJj0gfkJJVChkYXRhLT5o
d2lycSArIFBDSUVfSU5UWF9TSElGVCk7DQo+ID4gKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBvcnQt
PmJhc2UgKyBQQ0lFX0lOVF9FTkFCTEVfUkVHKTsNCj4gPiArCXJhd19zcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZwb3J0LT5pcnFfbG9jaywgZmxhZ3MpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgdm9pZCBtdGtfaW50eF91bm1hc2soc3RydWN0IGlycV9kYXRhICpkYXRhKQ0KPiA+ICt7DQo+
ID4gKwlzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9k
YXRhKGRhdGEpOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArCXUzMiB2YWw7DQo+
ID4gKw0KPiA+ICsJcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZwb3J0LT5pcnFfbG9jaywgZmxhZ3Mp
Ow0KPiA+ICsJdmFsID0gcmVhZGxfcmVsYXhlZChwb3J0LT5iYXNlICsgUENJRV9JTlRfRU5BQkxF
X1JFRyk7DQo+ID4gKwl2YWwgfD0gQklUKGRhdGEtPmh3aXJxICsgUENJRV9JTlRYX1NISUZUKTsN
Cj4gPiArCXdyaXRlbF9yZWxheGVkKHZhbCwgcG9ydC0+YmFzZSArIFBDSUVfSU5UX0VOQUJMRV9S
RUcpOw0KPiA+ICsJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBvcnQtPmlycV9sb2NrLCBm
bGFncyk7DQo+ID4gK30NCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBtdGtfaW50eF9lb2kNCj4g
PiArICogQGRhdGE6IHBvaW50ZXIgdG8gY2hpcCBzcGVjaWZpYyBkYXRhDQo+ID4gKyAqDQo+ID4g
KyAqIEFzIGFuIGVtdWxhdGVkIGxldmVsIElSUSwgaXRzIGludGVycnVwdCBzdGF0dXMgd2lsbCBy
ZW1haW4NCj4gPiArICogdW50aWwgdGhlIGNvcnJlc3BvbmRpbmcgZGUtYXNzZXJ0IG1lc3NhZ2Ug
aXMgcmVjZWl2ZWQ7IGhlbmNlIHRoYXQNCj4gPiArICogdGhlIHN0YXR1cyBjYW4gb25seSBiZSBj
bGVhcmVkIHdoZW4gdGhlIGludGVycnVwdCBoYXMgYmVlbiBzZXJ2aWNlZC4NCj4gPiArICovDQo+
ID4gK3N0YXRpYyB2b2lkIG10a19pbnR4X2VvaShzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0ID0gaXJxX2RhdGFfZ2V0X2lycV9j
aGlwX2RhdGEoZGF0YSk7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGh3aXJxOw0KPiA+ICsNCj4gPiAr
CWh3aXJxID0gZGF0YS0+aHdpcnEgKyBQQ0lFX0lOVFhfU0hJRlQ7DQo+ID4gKwl3cml0ZWxfcmVs
YXhlZChCSVQoaHdpcnEpLCBwb3J0LT5iYXNlICsgUENJRV9JTlRfU1RBVFVTX1JFRyk7DQo+ID4g
K30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgbXRrX2ludHhfaXJxX2NoaXAg
PSB7DQo+ID4gKwkuaXJxX2VuYWJsZQkJPSBtdGtfaW50eF91bm1hc2ssDQo+ID4gKwkuaXJxX2Rp
c2FibGUJCT0gbXRrX2ludHhfbWFzaywNCj4gDQo+IFBsZWFzZSBnZXQgcmlkIG9mIGVuYWJsZS9k
aXNhYmxlLiBHaXZlbiB0aGF0IHlvdSBhbHJlYWR5IGhhdmUNCj4gbWFzay91bm1hc2sgd2l0aCB0
aGUgKnNhbWUqIGltcGxlbWVudGF0aW9uLCB0aGlzIG9mZmVycyB6ZXJvIGJlbmVmaXQuDQoNCkhp
IE1hcmMsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCldlIG5lZWQgdG8gc3VwcG9ydCBz
dXNwZW5kL3Jlc3VtZSBmZWF0dXJlLCB0aGUgSFcgd2lsbCBiZSBwb3dlcmVkIG9mZg0Kd2hlbiB0
aGUgc3lzdGVtIGlzIHN1c3BlbmRlZCwgYW5kIGl0cyByZWdpc3RlciB2YWx1ZSB3aWxsIGJlIGNs
ZWFyZWQuIElmDQp0aGUgZW5hYmxlL2Rpc2FibGUgY2FsbGJhY2sgaXMgbm90IGltcGxlbWVudGVk
LCB0aGUgdW5tYXNrIGZ1bmN0aW9uIHdpbGwNCm5vdCBiZSBjYWxsZWQgd2hlbiB0aGUgc3lzdGVt
IHJlc3VtZSwgc28gSU5UeCB3aWxsIHJlbWFpbiBkaXNhYmxlZC4NCg0KQ2FuIEkga2VlcCB0aGUg
ZW5hYmxlL2Rpc2FibGUgY2FsbGJhY2s/IE9yIGRvIHdlIGhhdmUgYW55IHNvbHV0aW9ucyB0bw0K
cmVzdG9yZSB0aGUgcmVnaXN0ZXIgdmFsdWUgd2hlbiB0aGUgc3lzdGVtIHJlc3VtZT8NCg0KVGhh
bmtzLg0KPiANCj4gPiArCS5pcnFfbWFzawkJPSBtdGtfaW50eF9tYXNrLA0KPiA+ICsJLmlycV91
bm1hc2sJCT0gbXRrX2ludHhfdW5tYXNrLA0KPiA+ICsJLmlycV9lb2kJCT0gbXRrX2ludHhfZW9p
LA0KPiA+ICsJLmlycV9zZXRfYWZmaW5pdHkJPSBtdGtfcGNpZV9zZXRfYWZmaW5pdHksDQo+ID4g
KwkubmFtZQkJCT0gIklOVHgiLA0KPiA+ICt9Ow0KPiANCj4gWy4uLl0NCj4gDQo+IE90aGVyIHRo
YXQgdGhhdCwgdGhpcyBsb29rIGdvb2QgdG8gbWUuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJTS4N
Cj4gDQoNCg==

