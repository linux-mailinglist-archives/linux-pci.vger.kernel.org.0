Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F193D351F
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhGWGg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 02:36:57 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47380 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229560AbhGWGg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 02:36:57 -0400
X-UUID: 75498d81aefb4632a4746dbb27fda214-20210723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=prDrh7DxvcudMBmuQ1JSmdMeIVoEkDXcOOdpbvc2mFA=;
        b=QI6jc+ZVluBVkxEG3ZV3sBFIUZDM97gmELDiXF/AEQI7ajf4sXdARMqMiH4kcznjq+GCXDI1lpw2gaCJXuYd6IMGyM8llAodIzi1B9TAzvMr1XrdtAnMmdKF15rtlebhqXtxSUP9oknFJ6wmBAReIxBMzfQ9XwfQ9tlDR+Rc4Qw=;
X-UUID: 75498d81aefb4632a4746dbb27fda214-20210723
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 288064018; Fri, 23 Jul 2021 15:17:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Jul 2021 15:17:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Jul 2021 15:17:26 +0800
Message-ID: <1627024646.19956.2.camel@mhfsdcap03>
Subject: Re: [PATCH v11 1/4] dt-bindings: PCI: mediatek: Update the Device
 tree bindings
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        PCI <linux-pci@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        <devicetree@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>
Date:   Fri, 23 Jul 2021 15:17:26 +0800
In-Reply-To: <CAL_JsqJXN1b5Tq7uAngXfDmpTJoPvDmSzMedK3kr6efvuCgQ=w@mail.gmail.com>
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
         <20210719073456.28666-2-chuanjia.liu@mediatek.com>
         <20210719224718.GA2766057@robh.at.kernel.org>
         <1626746843.2466.10.camel@mhfsdcap03>
         <CAL_JsqJXN1b5Tq7uAngXfDmpTJoPvDmSzMedK3kr6efvuCgQ=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTIwIGF0IDEwOjI2IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBKdWwgMTksIDIwMjEgYXQgODowNyBQTSBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxp
dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCAyMDIxLTA3LTE5IGF0IDE2
OjQ3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+IE9uIE1vbiwgMTkgSnVsIDIwMjEg
MTU6MzQ6NTMgKzA4MDAsIENodWFuamlhIExpdSB3cm90ZToNCj4gPiA+ID4gVGhlcmUgYXJlIHR3
byBpbmRlcGVuZGVudCBQQ0llIGNvbnRyb2xsZXJzIGluIE1UMjcxMiBhbmQgTVQ3NjIyDQo+ID4g
PiA+IHBsYXRmb3JtLiBFYWNoIG9mIHRoZW0gc2hvdWxkIGNvbnRhaW4gYW4gaW5kZXBlbmRlbnQg
TVNJIGRvbWFpbi4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gb2xkIGR0cyBhcmNoaXRlY3R1cmUsIE1T
SSBkb21haW4gd2lsbCBiZSBpbmhlcml0ZWQgZnJvbSB0aGUgcm9vdA0KPiA+ID4gPiBicmlkZ2Us
IGFuZCBhbGwgb2YgdGhlIGRldmljZXMgd2lsbCBzaGFyZSB0aGUgc2FtZSBNU0kgZG9tYWluLg0K
PiA+ID4gPiBIZW5jZSB0aGF0LCB0aGUgUENJZSBkZXZpY2VzIHdpbGwgbm90IHdvcmsgcHJvcGVy
bHkgaWYgdGhlIGlycSBudW1iZXINCj4gPiA+ID4gd2hpY2ggcmVxdWlyZWQgaXMgbW9yZSB0aGFu
IDMyLg0KPiA+ID4gPg0KPiA+ID4gPiBTcGxpdCB0aGUgUENJZSBub2RlIGZvciBNVDI3MTIgYW5k
IE1UNzYyMiBwbGF0Zm9ybSB0byBjb21wbHkgd2l0aA0KPiA+ID4gPiB0aGUgaGFyZHdhcmUgZGVz
aWduIGFuZCBmaXggTVNJIGlzc3VlLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBD
aHVhbmppYSBMaXUgPGNodWFuamlhLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IEFja2VkLWJ5
OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiAgLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNmZy55YW1sICAgICAgIHwgIDM5ICsr
KysNCj4gPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLnR4
dCB8IDIwNiArKysrKysrKysrLS0tLS0tLS0NCj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTUw
IGluc2VydGlvbnMoKyksIDk1IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1j
ZmcueWFtbA0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBQbGVhc2UgYWRkIEFja2VkLWJ5
L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJzaW9ucy4gSG93ZXZlciwNCj4g
PiA+IHRoZXJlJ3Mgbm8gbmVlZCB0byByZXBvc3QgcGF0Y2hlcyAqb25seSogdG8gYWRkIHRoZSB0
YWdzLiBUaGUgdXBzdHJlYW0NCj4gPiA+IG1haW50YWluZXIgd2lsbCBkbyB0aGF0IGZvciBhY2tz
IHJlY2VpdmVkIG9uIHRoZSB2ZXJzaW9uIHRoZXkgYXBwbHkuDQo+ID4gPg0KPiA+ID4gSWYgYSB0
YWcgd2FzIG5vdCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNo
YW5nZWQuDQo+ID4gPg0KPiA+IEhpLFJvYg0KPiA+IEkgaGF2ZSBkZXNjcmliZWQgaW4gdGhlIGNv
dmVyIGxldHRlcjoNCj4gPiB2MTE6UmViYXNlIGZvciA1LjE0LXJjMSBhbmQgYWRkICJpbnRlcnJ1
cHQtbmFtZXMiLCAibGludXgscGNpLWRvbWFpbiINCj4gPiAgICAgZGVzY3JpcHRpb24gaW4gYmlu
ZGluZyBmaWxlLiBObyBjb2RlIGNoYW5nZS4NCj4gPiBpZiB5b3Ugc3RpbGwgb2sgZm9yIHRoaXMs
IEkgd2lsbCBhZGQgUi1iIGluIG5leHQgdmVyc2lvbi4NCj4gDQo+IFllcywgaXQncyBmaW5lLg0K
PiANCj4gSW4gdGhlIGZ1dHVyZSwgcHV0IHRoZSBjaGFuZ2Vsb2cgZm9yIGEgcGF0Y2ggaW4gdGhl
IHBhdGNoLg0KSGksIFJvYg0KIFRoYW5rcyBmb3IgeW91IHN1Z2dlc3Rpb24sIEkgd2lsbCBkbyB0
aGlzIGluIGZ1dHVyZSB2ZXJzaW9ucy4NCkJlc3QgcmVnYXJkcw0KDQoNCg==

