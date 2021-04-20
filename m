Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BDC365018
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 04:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhDTCGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 22:06:24 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60999 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229534AbhDTCGX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 22:06:23 -0400
X-UUID: a621cc90d6e44dd98733707a5bf2256c-20210420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Z09ggkvCRJiJ4/N9vlMDVPDlpKZyre12NKJNa+h4uZw=;
        b=el27YFigHbltheeF4/OrPPrBwGB/2mHaIOAp+PXxxgVwIwshaC+8F2fLog3fC3+dmQCMX7EyKm+58C8AYmUb45XQO84O5L5U/yEorDJvd8tJkOn/DHmhouO+WbN6CfSW7kGufDz/ySduHg1FBDIHofn4NGgElDwv01qVdnZqcYE=;
X-UUID: a621cc90d6e44dd98733707a5bf2256c-20210420
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 127489997; Tue, 20 Apr 2021 10:05:44 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 10:05:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Apr 2021 10:05:38 +0800
Message-ID: <1618884338.29460.3.camel@mhfsdcap03>
Subject: Re: [v9,0/7] PCI: mediatek: Add new generation controller support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>, <drinkcat@chromium.org>,
        <Rex-BC.Chen@mediatek.com>, <anson.chuang@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Tue, 20 Apr 2021 10:05:38 +0800
In-Reply-To: <20210419104432.GA2427@lpieralisi>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
         <20210416192100.GA2745484@bjorn-Precision-5520>
         <20210419104432.GA2427@lpieralisi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B45CF740E0F6667A28FE967807155FA258A3BB8BAE458FD2526271E6569C26AC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTE5IGF0IDExOjQ0ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gRnJpLCBBcHIgMTYsIDIwMjEgYXQgMDI6MjE6MDBQTSAtMDUwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gPiBPbiBXZWQsIE1hciAyNCwgMjAyMSBhdCAxMTowNTowM0FNICswODAw
LCBKaWFuanVuIFdhbmcgd3JvdGU6DQo+ID4gPiBUaGVzZSBzZXJpZXMgcGF0Y2hlcyBhZGQgcGNp
ZS1tZWRpYXRlay1nZW4zLmMgYW5kIGR0LWJpbmRpbmdzIGZpbGUgdG8NCj4gPiA+IHN1cHBvcnQg
bmV3IGdlbmVyYXRpb24gUENJZSBjb250cm9sbGVyLg0KPiA+IA0KPiA+IEluY2lkZW50YWw6IGI0
IGRvZXNuJ3Qgd29yayBvbiB0aGlzIHRocmVhZCwgSSBzdXNwZWN0IGJlY2F1c2UgdGhlDQo+ID4g
dXN1YWwgc3ViamVjdCBsaW5lIGZvcm1hdCBpczoNCj4gPiANCj4gPiAgIFtQQVRDSCB2OSA5Lzdd
DQo+ID4gDQo+ID4gaW5zdGVhZCBvZjoNCj4gPiANCj4gPiAgIFt2OSwwLzddDQo+ID4gDQo+ID4g
Rm9yIGI0IGluZm8sIHNlZSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vdXRpbHMvYjQv
YjQuZ2l0L3RyZWUvUkVBRE1FLnJzdA0KPiANCj4gSmlhbmp1biB3aWxsIHVwZGF0ZSB0aGUgc2Vy
aWVzIGFjY29yZGluZ2x5IChhbmQgcGxlYXNlIGFkZCB0byB2MTAgdGhlDQo+IHJldmlldyB0YWdz
IHlvdSByZWNlaXZlZC4NCj4gDQo+IExvcmVuem8NCg0KWWVzLCBJIHdpbGwgdXBkYXRlIHRoaXMg
c2VyaWVzIGluIHYxMCB0byBmaXggdGhlIHN1YmplY3QgbGluZSBmb3JtYXQgYW5kDQp1c2UgRVhQ
T1JUX1NZTUJPTF9HUEwoKSwgdGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQpUaGFua3MuDQoN
Cg==

