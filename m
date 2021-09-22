Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27024414176
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 08:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhIVGE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 02:04:27 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:36166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231908AbhIVGE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 02:04:26 -0400
X-UUID: 2d782b43a5f4428d84e324231b85b436-20210922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=b7TgjdaX90/kAMrw3hlB4boxdIs0VONZSRH+hU5Jk6c=;
        b=l1j2ZcdGx/96BEIjtoj5Fw62k9jzPBlK2XC0CmoeLaYoAXEE2yyDH0NPJP1An7F6jMZlfODanh/077ULVt1UB++cryvTph7jfuM/sKng7tEUAhYVlkBrBk9P0qEoyATbyLguIWzSjXprs849OcaQtmAWtE0W8bTF08iTuDsdVAg=;
X-UUID: 2d782b43a5f4428d84e324231b85b436-20210922
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 485543766; Wed, 22 Sep 2021 14:02:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 22 Sep 2021 14:02:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Sep 2021 14:02:53 +0800
Message-ID: <1942744399e4817f778f43528b22b82b1d422b4a.camel@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Disable DVFSRC voltage request
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Wilczyski" <kw@linux.com>,
        Tzung-Bi Shih <tzungbi@google.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <qizhong.cheng@mediatek.com>, <Ryan-JH.Yu@mediatek.com>
Date:   Wed, 22 Sep 2021 14:02:55 +0800
In-Reply-To: <53b79201135690800f3c97d861af9567b6f2a40d.camel@mediatek.com>
References: <20210819125939.21253-1-jianjun.wang@mediatek.com>
         <YR8go1l0Xnvvqn5E@google.com>
         <53b79201135690800f3c97d861af9567b6f2a40d.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sIExvcmVuem8sDQoNCkp1c3QgZ2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2gsIHBs
ZWFzZSBraW5kbHkgbGV0IG1lIGtub3cgeW91cg0KY29tbWVudHMgYWJvdXQgdGhpcyBwYXRjaC4N
Cg0KVGhhbmtzLg0KDQpPbiBUaHUsIDIwMjEtMDktMDIgYXQgMTA6MjcgKzA4MDAsIEppYW5qdW4g
V2FuZyB3cm90ZToNCj4gSGkgTWFpbnRhaW5lcnMsDQo+IA0KPiBKdXN0IGdlbnRsZSBwaW5nIGZv
ciB0aGlzIHBhdGNoLCBpZiB0aGVyZSBpcyBhbnl0aGluZyBJIG5lZWQgdG8NCj4gbW9kaWZ5LA0K
PiBwbGVhc2Uga2luZGx5IGxldCBtZSBrbm93Lg0KPiANCj4gVGhhbmtzLg0KPiANCj4gT24gRnJp
LCAyMDIxLTA4LTIwIGF0IDExOjI1ICswODAwLCBUenVuZy1CaSBTaGloIHdyb3RlOg0KPiA+IE9u
IFRodSwgQXVnIDE5LCAyMDIxIGF0IDA4OjU5OjM5UE0gKzA4MDAsIEppYW5qdW4gV2FuZyB3cm90
ZToNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiANCj4gPiBSZXZpZXdlZC1ieTogVHp1bmctQmkgU2hpaCA8dHp1bmdiaUBn
b29nbGUuY29tPg0K

