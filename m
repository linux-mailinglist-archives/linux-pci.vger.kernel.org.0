Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FB27A5C3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 05:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1D2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 23:28:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:7882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbgI1D2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 23:28:30 -0400
X-UUID: 2e567311069b47fd9e21a0b4bb7b90c5-20200928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=agUedE9PsMXuVeno9bFALFYE9PxOrPom7M+8kFzGWYA=;
        b=GRiY7BdVQdwHOAQzibc9oZE06JufBhSXtL9aA66cGOxzdpuwcpBYZa2k4lJCTrcPIWCAETzbFx2wp2lYrnoHgLCUbPyW9OJIeTFOtgrKCKfd9UsRg+RqhjsRVIFqvDFGsTm8YIOfi0qiayG8prUez9EjYQJm3d6P83RoI8VR5og=;
X-UUID: 2e567311069b47fd9e21a0b4bb7b90c5-20200928
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1991438022; Mon, 28 Sep 2020 11:28:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 11:28:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Sep 2020 11:28:23 +0800
Message-ID: <1601263551.21671.1.camel@mhfsdcap03>
Subject: Re: Aw: [PATCH v6 0/4] Spilt PCIe node to comply with hardware
 design
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>
Date:   Mon, 28 Sep 2020 11:25:51 +0800
In-Reply-To: <trinity-a791b919-956f-4cde-a496-919d4f3f2ba9-1600083556775@3c-app-gmx-bap20>
References: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
         <trinity-a791b919-956f-4cde-a496-919d4f3f2ba9-1600083556775@3c-app-gmx-bap20>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FCAC36D56FCFFF84C336092A77EF8DD389128F98161ACBA993639780B59DBAF42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTE0IGF0IDEzOjM5ICswMjAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiA+IEJldHJlZmY6IFtQQVRDSCB2NiAwLzRdIFNwaWx0IFBDSWUgbm9kZSB0byBjb21wbHkg
d2l0aCBoYXJkd2FyZSBkZXNpZ24NCj4gDQo+IGp1c3QgaWYgeW91IG5lZWQgdG8gbWFrZSBhbm90
aGVyIHZlcnNpb24gKGFzIGl0IGlzIG9ubHkgdGhlIGNvdmVyLWxldHRlcikgeW91IGNhbiBmaXgg
dGhlIHR5cG8gaW4gc3ViamVjdCA7KQ0KDQpUaGFua3MgZm9yIHlvdXIgcmVtaW5kaW5nLCBJIHdp
bGwgY2hhbmdlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiByZWdhcmRzIEZyYW5rDQo+
IA0KDQo=

