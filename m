Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21AA1ADA33
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgDQJjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 05:39:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49158 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730334AbgDQJjE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 05:39:04 -0400
X-UUID: a5014796a69e4ca3b5650e004148ca6b-20200417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=iZuTCT/J0fHisHx7WtJAL9zKonXahC0te+mVqf6Soa0=;
        b=WxsTLLlrQavvq6OkxUqojnXXIxiLR/1Mk2gAVpiZbI3c25gm3oBtivjnWU+ajRZIdMPzLG+FzkfuukLu7doTywFgMOXPdujZR2SP8AAVeUCrVHIvq2BCKtrWyzGuob98FogczhH76D9A6y/Ao2my2LR4E9kA8sHJfA9JSrcuRGs=;
X-UUID: a5014796a69e4ca3b5650e004148ca6b-20200417
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1464473628; Fri, 17 Apr 2020 17:38:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 17:38:57 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Apr 2020 17:38:55 +0800
From:   <chuanjia.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <amurray@thegoodpenguin.co.uk>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ryder.lee@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <jianjun.wang@mediatek.com>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH 0/4] Spilt PCIe node to comply with hardware design
Date:   Fri, 17 Apr 2020 17:35:01 +0800
Message-ID: <20200417093505.13978-1-chuanjia.liu@mediatek.com>
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
IGhhcmR3YXJlIGRlc2lnbi4NCg0KY2h1YW5qaWEubGl1ICg0KToNCiAgZHQtYmluZGluZ3M6IFBD
STogTWVkaWF0ZWs6IFVwZGF0ZSBQQ0llIGJpbmRpbmcNCiAgUENJOiBtZWRpYXRlazogVXNlIHJl
Z21hcCB0byBnZXQgc2hhcmVkIHBjaWUtY2ZnIGJhc2UNCiAgYXJtNjQ6IGR0czogbWVkaWF0ZWs6
IFNwbGl0IFBDSWUgbm9kZSBmb3IgTVQyNzEyL01UNzYyMg0KICBBUk06IGR0czogbWVkaWF0ZWs6
IFVwZGF0ZSBtdDc2MjkgUENJZSBub2RlDQoNCiAuLi4vYmluZGluZ3MvcGNpL21lZGlhdGVrLXBj
aWUtY2ZnLnlhbWwgICAgICAgfCAgMzggKysrKysrDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL21lZGlhdGVrLXBjaWUudHh0IHwgMTIwICsrKysrKysrKysrKy0tLS0tLQ0KIGFyY2gvYXJt
L2Jvb3QvZHRzL210NzYyOS1yZmIuZHRzICAgICAgICAgICAgICB8ICAgMyArLQ0KIGFyY2gvYXJt
L2Jvb3QvZHRzL210NzYyOS5kdHNpICAgICAgICAgICAgICAgICB8ICAyMyArKy0tDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDI3MTJlLmR0c2kgICAgIHwgIDUxICsrKysrLS0tDQog
Li4uL2R0cy9tZWRpYXRlay9tdDc2MjItYmFuYW5hcGktYnBpLXI2NC5kdHMgIHwgIDE2ICstLQ0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLXJmYjEuZHRzICB8ICAgNiArLQ0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kgICAgICB8ICA2OCArKysr
KystLS0tDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMgICAgICAgIHwg
IDI1ICsrKy0NCiA5IGZpbGVzIGNoYW5nZWQsIDIzNCBpbnNlcnRpb25zKCspLCAxMTYgZGVsZXRp
b25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1jZmcueWFtbA0KDQotLQ0KMi4xOC4wIA0KDQo=

