Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0944A680
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 06:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhKIGBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 01:01:41 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55460 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240251AbhKIGBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 01:01:40 -0500
X-UUID: 32d6c4af378041fb8112828266b68fb6-20211109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=u3Y7rOgSooNJ5mSZ8l6Ju99PK0paNi5uV64VWV4jMbY=;
        b=Txjuc0ZIlw0higt45XGCE0FVvDO43r2m0+yaQDou2mJtd6lOmbfSLVIHiR+6rerEZBCNnOEBds1340DMfATcbX1M55ibQ99SKRw/xx3y/R6u5Xd3mqPdh1qHaM9WGgfYhvEYylQ/fq8c+tL/U7H2TG0V72ZWugNYxBTsnhEfD6c=;
X-UUID: 32d6c4af378041fb8112828266b68fb6-20211109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 212230260; Tue, 09 Nov 2021 13:58:52 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 9 Nov 2021 13:58:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkexhb01.mediatek.inc (172.21.101.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Nov 2021 13:58:51 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 9 Nov 2021 13:58:45 +0800
Message-ID: <0982a0743a2e6fd5678719db0ac6ee74b54f3ee3.camel@mediatek.com>
Subject: Re: Distinguish mediatek drivers
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>
Date:   Tue, 9 Nov 2021 13:58:45 +0800
In-Reply-To: <YYlHzMGAdO1eOQLn@rocinante>
References: <20211105202913.GA944432@bhelgaas>
         <98d237693bc618cba62e93495b7b3379c18ac6b5.camel@mediatek.com>
         <YYlHzMGAdO1eOQLn@rocinante>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGF0J3MgcmVhbGx5IGEgZ29vZCBpZGVhLCB5ZXMsIHdlIGNhbiBj
b21iaW5lIGJvdGggZHJpdmVycyBpbnRvIGENCnNpbmdsZSBvbmUuIA0KDQpCdXQgdGhlIHJlYWwg
cHJvYmxlbSBpcyB0aGF0IHRoZSBvbGQgZHJpdmVyIGhhcyBiZWVuIHVzZWQgdG8gYSBsb3Qgb2YN
CnBsYXRmb3JtcyBhbmQgaXQgd29ya3Mgc3RhYmxlIGZvciBub3cuIFdoZW4gd2UgY29tYmluZSB0
aGVzZSBkcml2ZXJzLA0Kd2Ugd2lsbCBoYXZlIGEgdmVyeSBodWdlIGVmZm9ydCB0byBhZGp1c3Qg
dGhlIGRyaXZlciBzdHlsZSBhbmQgdGVzdCBpdA0KaW4gYWxsIHBsYXRmb3Jtcy4NCg0KV2Ugd2ls
bCBjaGVjayB0aGUgcG9zc2liaWxpdGllcyBidXQgaXQgbWF5IHRha2UgbW9yZSB0aW1lIHRvIGZp
bmlzaCB0aGUNCndvcmsuDQoNClRoYW5rcy4NCg0KT24gTW9uLCAyMDIxLTExLTA4IGF0IDE2OjUy
ICswMTAwLCBLcnp5c3p0b2YgV2lsY3p5xYRza2kgd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gWy4u
Ll0NCj4gPiA+IEJvdGggZHJpdmVycyBhcmUgYWxzbyBuYW1lZCAibXRrLXBjaWUiIGFuZCB1c2Ug
dGhlIHNhbWUgaW50ZXJuYWwNCj4gPiA+ICJtdGtfIiBwcmVmaXggb24gc3RydWN0cyBhbmQgZnVu
Y3Rpb25zLiAgTm90IGEgKmh1Z2UqIHByb2JsZW0sDQo+ID4gPiBidXQNCj4gPiA+IG5vdCByZWFs
bHkgaWRlYWwgZWl0aGVyLg0KPiANCj4gWy4uLl0NCj4gPiBUaGFua3MgZm9yIHRoZSByZW1pbmRl
ciwgSSB3aWxsIHNlbmQgcGF0Y2hlcyB0byB1cGRhdGUgdGhlc2UNCj4gPiBlbnRyaWVzLg0KPiAN
Cj4gUGVyaGFwcyBhIHNpbGx5IHF1ZXN0aW9uLCBidXQgd291bGQgaXQgYmUgcG9zc2libGUgdG8g
Y29tYmluZSBib3RoDQo+IGRyaXZlcnMNCj4gaW50byBhIHNpbmdsZSBvbmUgdGhhdCBoYW5kbGVz
cyBkZXZpY2VzIGFjcm9zcyBhbGwgZ2VuZXJhdGlvbnM/DQo+IA0KPiAJS3J6eXN6dG9mDQo=

