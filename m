Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A16223123
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 04:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgGQCXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 22:23:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56970 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgGQCXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 22:23:36 -0400
X-UUID: 0e995b4dbbcd4983b6ebcb8e91aef537-20200717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ck3sKpk8p4f4/TOJbf/gg/voKPhUDfRj/uAbUdAGxzo=;
        b=mP4CFlFt1QPU1wt4CZPAVpfEzNjtBPxMQA0gwtXiNPC9Bvl27PyeUalefEfoq3nmdnLB+sXinmLknP9wO2uBPgBHdxR0MJ9AiGZaPNGSX3GKbAQdm03picrnsFP9E8foVzkLYam0HN7wz/Bza6ZbnYy183QSf+IeK7KuFEIBGxk=;
X-UUID: 0e995b4dbbcd4983b6ebcb8e91aef537-20200717
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1693347659; Fri, 17 Jul 2020 10:23:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Jul 2020 10:23:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jul 2020 10:23:26 +0800
From:   <chuanjia.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        <srv_heupstream@mediatek.com>, <jianjun.wang@mediatek.com>
Subject: [PATCH v3 0/4] Split PCIe node to comply with hardware design
Date:   Fri, 17 Jul 2020 10:22:19 +0800
Message-ID: <20200717022223.1437-1-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhlcmUgYXJlIHR3byBpbmRlcGVuZGVudCBQQ0llIGNvbnRyb2xsZXJzIGluIE1UMjcxMi9NVDc2
MjIgcGxhdGZvcm0sDQphbmQgZWFjaCBvZiB0aGVtIHNob3VsZCBjb250YWluIGFuIGluZGVwZW5k
ZW50IE1TSSBkb21haW4uDQoNCkluIGN1cnJlbnQgYXJjaGl0ZWN0dXJlLCBNU0kgZG9tYWluIHdp
bGwgYmUgaW5oZXJpdGVkIGZyb20gdGhlIHJvb3QNCmJyaWRnZSwgYW5kIGFsbCBvZiB0aGUgZGV2
aWNlcyB3aWxsIHNoYXJlIHRoZSBzYW1lIE1TSSBkb21haW4uDQpIZW5jZSB0aGF0LCB0aGUgUENJ
ZSBkZXZpY2VzIHdpbGwgbm90IHdvcmsgcHJvcGVybHkgaWYgdGhlIGlycSBudW1iZXINCndoaWNo
IHJlcXVpcmVkIGlzIG1vcmUgdGhhbiAzMi4NCg0KU3BsaXQgdGhlIFBDSWUgbm9kZSBmb3IgTVQy
NzEyL01UNzYyMiBwbGF0Zm9ybSB0byBmaXggTVNJIGlzc3VlIGFuZA0KY29tcGx5IHdpdGggdGhl
IGhhcmR3YXJlIGRlc2lnbi4NCg0KY2hhbmdlIG5vdGU6DQogIHYzOnJlYmFzZSBmb3IgNS44LXJj
MS4gT25seSBjb2xsZWN0IGFjayBvZiBSeWRlciwgTm8gY29kZSBjaGFuZ2UuDQogIHYyOmNoYW5n
ZSB0aGUgYWxsb2NhdGlvbiBvZiBtdDI3MTIgUENJZSBNTUlPIHNwYWNlIGR1ZSB0byB0aGUNCiAg
ICAgYWxsb2NhdGlvbiBzaXplIGlzIG5vdCByaWdodCBpbiB2MS4NCg0KY2h1YW5qaWEubGl1ICg0
KToNCiAgZHQtYmluZGluZ3M6IFBDSTogTWVkaWF0ZWs6IFVwZGF0ZSBQQ0llIGJpbmRpbmcNCiAg
UENJOiBtZWRpYXRlazogVXNlIHJlZ21hcCB0byBnZXQgc2hhcmVkIHBjaWUtY2ZnIGJhc2UNCiAg
YXJtNjQ6IGR0czogbWVkaWF0ZWs6IFNwbGl0IFBDSWUgbm9kZSBmb3IgTVQyNzEyL01UNzYyMg0K
ICBBUk06IGR0czogbWVkaWF0ZWs6IFVwZGF0ZSBtdDc2MjkgUENJZSBub2RlDQoNCi4uLi9iaW5k
aW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1jZmcueWFtbCAgICAgICB8ICAzOCArKysrKw0KLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUudHh0IHwgMTQ0ICsrKysrKysrKysr
LS0tLS0tLQ0KYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LXJmYi5kdHMgICAgICAgICAgICAgIHwg
ICAzICstDQphcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaSAgICAgICAgICAgICAgICAgfCAg
MjMgKy0tDQphcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUuZHRzaSAgICAgfCAg
NzUgKysrKystLS0tDQouLi4vZHRzL21lZGlhdGVrL210NzYyMi1iYW5hbmFwaS1icGktcjY0LmR0
cyAgfCAgMTYgKy0NCmFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLXJmYjEuZHRz
ICB8ICAgNiArLQ0KYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaSAgICAg
IHwgIDY4ICsrKysrKy0tLQ0KZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMg
ICAgICAgIHwgIDI1ICsrLQ0KOSBmaWxlcyBjaGFuZ2VkLCAyNTggaW5zZXJ0aW9ucygrKSwgMTQw
IGRlbGV0aW9ucygtKQ0KY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1jZmcueWFtbA0KDQotLSANCjIuMjUuMQ0K

