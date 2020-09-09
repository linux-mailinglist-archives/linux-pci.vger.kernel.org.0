Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E7A2625C2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 05:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIIDQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 23:16:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49629 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726002AbgIIDQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 23:16:35 -0400
X-UUID: 9e7cc0b894ba4b14a27667a025a37425-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=D4akEY1UsIrLp2l32I4rH/2r4ZNkNg0urog1SmVJQy4=;
        b=f2HMqAS5HdzGiqovALQY3IIbtKL3Vyr5hGlhiL/sOeABmvMNz2pIj3+bU7tho+cXO4lBoFbmBOtw34txCEsM8sJ8tW2XXSDq94rb477khaxWI0WbWxvCLRoWIb1t00QFAijp36TXvmdFbsrwNPHWhB2r3XOSWB79v+tKpBQQhfA=;
X-UUID: 9e7cc0b894ba4b14a27667a025a37425-20200909
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1994703033; Wed, 09 Sep 2020 11:16:33 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 11:16:31 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 11:16:30 +0800
Message-ID: <1599621279.2521.13.camel@mhfsdcap03>
Subject: Re: [v1,1/3] dt-bindings: Add YAML schemas for Gen3 PCIe controller
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>
Date:   Wed, 9 Sep 2020 11:14:39 +0800
In-Reply-To: <20200908200407.GA628520@bjorn-Precision-5520>
References: <20200908200407.GA628520@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0EE92390ADB39B90B8C5C83EAD1CEFB6CD9D6181AF39723CDB849AC1378F8DBA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTA4IGF0IDE1OjA0IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBNb24sIFNlcCAwNywgMjAyMCBhdCAwODowODo1MFBNICswODAwLCBKaWFuanVuIFdhbmcg
d3JvdGU6DQo+ID4gQWRkIFlBTUwgc2NoZW1hcyBkb2N1bWVudGF0aW9uIGZvciBHZW4zIFBDSWUg
Y29udHJvbGxlciBvbg0KPiA+IE1lZGlhVGVrIFNvQ3MuDQo+IA0KPiBQbGVhc2UgbWVudGlvbiAi
bWVkaWF0ZWsiIGluIHRoZSBzdWJqZWN0IGxpbmUgc28gImdpdCBsb2cgLS1vbmVsaW5lIg0KPiBp
cyBtb3JlIHVzZWZ1bC4NCj4gDQo+IFRoZSBjb252ZW50aW9uIChub3QgdW5pdmVyc2FsbHkgb2Jz
ZXJ2ZWQpIHNlZW1zIHRvIGJlIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gICBkdC1iaW5kaW5nczog
UENJOiA8ZHJpdmVyLW5hbWU+OiBBZGQgWUFNTCBzY2hlbWENCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldywgSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo=

