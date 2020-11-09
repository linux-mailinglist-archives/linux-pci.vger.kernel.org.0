Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79A52AAF9F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 03:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgKICy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Nov 2020 21:54:57 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:9219 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727979AbgKICy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2020 21:54:57 -0500
X-UUID: d62a8fc4c2fa46fc80703e49743d6e2b-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DQFgYUK++/RRLNHyCwW54CGobbl9tysXmdV/Obiqr7E=;
        b=OHfrmqQ407SVFAcWEU5Dhwzr6wYOkUCBjMbRZDlrKyHwuk6qxvVLQNLoqZoCn6f+Aoq5mS4qMuS6vrvdAZEhf1L/2Fde0cI1NiYDXsVZsCOtfiTlEtx4FCCIlKk6R4J/locxjwCOdqp8xmIvPPiXl8/eh72h1v/QvLnB/rqLifo=;
X-UUID: d62a8fc4c2fa46fc80703e49743d6e2b-20201109
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1046264325; Mon, 09 Nov 2020 10:54:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Nov
 2020 10:54:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:54:46 +0800
Message-ID: <1604890486.8050.7.camel@mhfsdcap03>
Subject: Re: [PATCH v7 4/4] ARM: dts: mediatek: Modified MT7629 PCIe node
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        <linux-pci@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <yong.wu@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 9 Nov 2020 10:54:46 +0800
In-Reply-To: <20201103225147.GA272037@bjorn-Precision-5520>
References: <20201103225147.GA272037@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B8BBFD63134A1EB2BFE5FCA426352709C941954D3CCC7C2E4A7CA939853D0DE12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTAzIGF0IDE2OjUxIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBUaGlzIHN1YmplY3QgbGluZSBpcyBwb2ludGxlc3MuDQo+IA0KPiBFdmVyeSBwYXRjaCBtb2Rp
ZmllcyBzb21ldGhpbmcuICBHaXZlIHVzIGEgaGludCBhYm91dCB3aGF0IHlvdQ0KPiBtb2RpZmll
ZCBhbmQgd2h5Lg0KPiANCj4gQW5kIHVzZSB0aGUgcHJlc2VudCB0ZW5zZSB2ZXJiLCBpLmUuLCAi
TW9kaWZ5IC4uLiIsIG5vdCAiTW9kaWZpZWQiLg0KPiBQcm9iYWJseSAiQWRkIiB3b3VsZCBiZSBi
ZXR0ZXIgdGhhbiAiTW9kaWZ5Ii4gIE9yICJVcGRhdGUiIHdpdGggc29tZQ0KPiBtZWFuaW5nZnVs
IGRlc2NyaXB0aW9uIG9mIHRoZSB1cGRhdGUuDQo+IA0KPiBPbiBUaHUsIE9jdCAyOSwgMjAyMCBh
dCAwNDoxNToxM1BNICswODAwLCBDaHVhbmppYSBMaXUgd3JvdGU6DQo+ID4gUmVtb3ZlIHVudXNl
ZCBwcm9wZXJ0eSBhbmQgYWRkIHBjaWVjZmcgbm9kZS4NCj4gDQo+IEFwcGFyZW50bHkgdGhpcyBh
bHNvIHJlbW92ZXMgInN1YnN5cyIgZnJvbSB0aGUgInJlZyIgcHJvcGVydHkuDQo+IEFuZCByZW1v
dmVzIGFuIGludGVycnVwdC4gIEFuZCBhZGRzICJwY2llX2lycSIuDQoNClRoYW5rcyBmb3IgeW91
IHJldmlld++8jEkgd2lsbCB1cGRhdGUgbXkgc3ViamVjdCBhbmQgY29tbWl0IG1lc3NhZ2UuDQoN
CkFSTTogZHRzOiBtZWRpYXRlazogVXBkYXRlIE1UNzYyOSBQQ0llIG5vZGUNCg0KVG8gbWF0Y2gg
dGhlIG5ldyBEVFMgQmluZGluZywgUmVtb3ZlICJzdWJzeXMiIGFuZCB1bnVzZWQgaW50ZXJydXB0
LkFkZA0KInBjaWVfaXJxIiBwcm9wZXJ0eSBhbmQgcGNpZWNmZyBub2RlLg0KDQpJcyB0aGF0IG9r
Pw0KDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1YW5qaWEgTGl1IDxjaHVhbmppYS5saXVAbWVkaWF0
ZWsuY29tPg0KPiA+IEFja2VkLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS1yZmIuZHRzIHwgIDMgKyst
DQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS5kdHNpICAgIHwgMjIgKysrKysrKysrKysr
LS0tLS0tLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9tdDc2
MjktcmZiLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS1yZmIuZHRzDQo+ID4gaW5kZXgg
OTk4MGMxMGM2ZTI5Li5lYjUzNmNiZWJkOWIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9v
dC9kdHMvbXQ3NjI5LXJmYi5kdHMNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9tdDc2Mjkt
cmZiLmR0cw0KPiA+IEBAIC0xNDAsOSArMTQwLDEwIEBADQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+
ICANCj4gPiAtJnBjaWUgew0KPiA+ICsmcGNpZTEgew0KPiA+ICAJcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4gPiAgCXBpbmN0cmwtMCA9IDwmcGNpZV9waW5zPjsNCj4gPiArCXN0YXR1cyA9
ICJva2F5IjsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gICZwY2llcGh5MSB7DQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyOS5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3
NjI5LmR0c2kNCj4gPiBpbmRleCA1Y2JiM2QyNDRjNzUuLjZkNjM5N2YwYzJmYyAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL210NzYyOS5kdHNpDQo+ID4gQEAgLTM2MCwxNiArMzYwLDIwIEBADQo+ID4gIAkJ
CSNyZXNldC1jZWxscyA9IDwxPjsNCj4gPiAgCQl9Ow0KPiA+ICANCj4gPiAtCQlwY2llOiBwY2ll
QDFhMTQwMDAwIHsNCj4gPiArCQlwY2llY2ZnOiBwY2llY2ZnQDFhMTQwMDAwIHsNCj4gPiArCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXBjaWVjZmciLCAic3lzY29uIjsNCj4gPiAr
CQkJcmVnID0gPDB4MWExNDAwMDAgMHgxMDAwPjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQlw
Y2llMTogcGNpZUAxYTE0NTAwMCB7DQo+ID4gIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3
NjI5LXBjaWUiOw0KPiA+ICAJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+IC0JCQlyZWcgPSA8
MHgxYTE0MDAwMCAweDEwMDA+LA0KPiA+IC0JCQkgICAgICA8MHgxYTE0NTAwMCAweDEwMDA+Ow0K
PiA+IC0JCQlyZWctbmFtZXMgPSAic3Vic3lzIiwicG9ydDEiOw0KPiA+ICsJCQlyZWcgPSA8MHgx
YTE0NTAwMCAweDEwMDA+Ow0KPiA+ICsJCQlyZWctbmFtZXMgPSAicG9ydDEiOw0KPiA+ICAJCQkj
YWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiAgCQkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gLQkJ
CWludGVycnVwdHMgPSA8R0lDX1NQSSAxNzYgSVJRX1RZUEVfTEVWRUxfTE9XPiwNCj4gPiAtCQkJ
CSAgICAgPEdJQ19TUEkgMjI5IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ID4gKwkJCWludGVycnVw
dHMgPSA8R0lDX1NQSSAyMjkgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gPiArCQkJaW50ZXJydXB0
LW5hbWVzID0gInBjaWVfaXJxIjsNCj4gPiAgCQkJY2xvY2tzID0gPCZwY2llc3lzIENMS19QQ0lF
X1AxX01BQ19FTj4sDQo+ID4gIAkJCQkgPCZwY2llc3lzIENMS19QQ0lFX1AwX0FIQl9FTj4sDQo+
ID4gIAkJCQkgPCZwY2llc3lzIENMS19QQ0lFX1AxX0FVWF9FTj4sDQo+ID4gQEAgLTM5MCwyMSAr
Mzk0LDE5IEBADQo+ID4gIAkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDc2MjJfUE9XRVJf
RE9NQUlOX0hJRjA+Ow0KPiA+ICAJCQlidXMtcmFuZ2UgPSA8MHgwMCAweGZmPjsNCj4gPiAgCQkJ
cmFuZ2VzID0gPDB4ODIwMDAwMDAgMCAweDIwMDAwMDAwIDB4MjAwMDAwMDAgMCAweDEwMDAwMDAw
PjsNCj4gPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgDQo+ID4gLQkJCXBjaWUxOiBw
Y2llQDEsMCB7DQo+ID4gLQkJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+ICsJCQlzbG90MTog
cGNpZUAxLDAgew0KPiA+ICAJCQkJcmVnID0gPDB4MDgwMCAwIDAgMCAwPjsNCj4gPiAgCQkJCSNh
ZGRyZXNzLWNlbGxzID0gPDM+Ow0KPiA+ICAJCQkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gIAkJ
CQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+ICAJCQkJcmFuZ2VzOw0KPiA+IC0JCQkJbnVt
LWxhbmVzID0gPDE+Ow0KPiA+ICAJCQkJaW50ZXJydXB0LW1hcC1tYXNrID0gPDAgMCAwIDc+Ow0K
PiA+ICAJCQkJaW50ZXJydXB0LW1hcCA9IDwwIDAgMCAxICZwY2llX2ludGMxIDA+LA0KPiA+ICAJ
CQkJCQk8MCAwIDAgMiAmcGNpZV9pbnRjMSAxPiwNCj4gPiAgCQkJCQkJPDAgMCAwIDMgJnBjaWVf
aW50YzEgMj4sDQo+ID4gIAkJCQkJCTwwIDAgMCA0ICZwY2llX2ludGMxIDM+Ow0KPiA+IC0NCj4g
PiAgCQkJCXBjaWVfaW50YzE6IGludGVycnVwdC1jb250cm9sbGVyIHsNCj4gPiAgCQkJCQlpbnRl
cnJ1cHQtY29udHJvbGxlcjsNCj4gPiAgCQkJCQkjYWRkcmVzcy1jZWxscyA9IDwwPjsNCj4gPiAt
LSANCj4gPiAyLjE4LjANCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQoNCg==

