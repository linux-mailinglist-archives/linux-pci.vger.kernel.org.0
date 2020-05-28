Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8BA1E576C
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 08:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgE1GSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 02:18:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40887 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726913AbgE1GSy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 02:18:54 -0400
X-UUID: 5089073cb53a4d67ac27a7c76a50a6ae-20200528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=k9n3h0/X69wAHhYT1nFTsKcL3wy3KEtSe7PgG0o+trw=;
        b=hIAZb1puZnLEPVjq5jDmEkjVsbzUDIAt6MA0YBUDYkSkrXCtKWMYhOx7bqxk1MEBjozlQmX9srmcs67BfeqDYGT+EMtoEOAVnv9cvBYun9/Na6JQsNKGjFxIRNUB+2P0SSEGwb7wViOOFuUdFPTj7vHeJskAeY0zxtmq/2qBYrE=;
X-UUID: 5089073cb53a4d67ac27a7c76a50a6ae-20200528
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1704384534; Thu, 28 May 2020 14:18:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 May 2020 14:18:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 May 2020 14:18:46 +0800
From:   <chuanjia.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <ryder.lee@mediatek.com>,
        <matthias.bgg@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <bhelgaas@google.com>,
        <chuanjia.liu@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>, <srv_heupstream@mediatek.com>
Subject: [PATCH v2 0/4] Spilt PCIe node to comply with hardware design
Date:   Thu, 28 May 2020 14:16:44 +0800
Message-ID: <20200528061648.32078-1-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8CF1375321BD3043410D80C9D460D099090CF36CFC4DCB666F3A8866FC761E1E2000:8
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
IGhhcmR3YXJlIGRlc2lnbi4NCg0KY2hhbmdlIG5vdGU6DQp2MjogY2hhbmdlIHRoZSBhbGxvY2F0
aW9uIG9mIG10MjcxMiBQQ0llIE1NSU8gc3BhY2UgZHVlIHRvIHRoZSBhbGxjYXRpb24NCnNpemUg
aXMgbm90IHJpZ2h0IGluIHYxLg0KDQpjaHVhbmppYS5saXUgKDQpOg0KICBkdC1iaW5kaW5nczog
UENJOiBNZWRpYXRlazogVXBkYXRlIFBDSWUgYmluZGluZw0KICBQQ0k6IG1lZGlhdGVrOiBVc2Ug
cmVnbWFwIHRvIGdldCBzaGFyZWQgcGNpZS1jZmcgYmFzZQ0KICBhcm02NDogZHRzOiBtZWRpYXRl
azogU3BsaXQgUENJZSBub2RlIGZvciBNVDI3MTIvTVQ3NjIyDQogIEFSTTogZHRzOiBtZWRpYXRl
azogVXBkYXRlIG10NzYyOSBQQ0llIG5vZGUNCg0KIC4uLi9iaW5kaW5ncy9wY2kvbWVkaWF0ZWst
cGNpZS1jZmcueWFtbCAgICAgICB8ICAzOCArKysrKw0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9tZWRpYXRlay1wY2llLnR4dCB8IDE0NCArKysrKysrKysrKy0tLS0tLS0NCiBhcmNoL2Fy
bS9ib290L2R0cy9tdDc2MjktcmZiLmR0cyAgICAgICAgICAgICAgfCAgIDMgKy0NCiBhcmNoL2Fy
bS9ib290L2R0cy9tdDc2MjkuZHRzaSAgICAgICAgICAgICAgICAgfCAgMjMgKy0tDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDI3MTJlLmR0c2kgICAgIHwgIDc1ICsrKysrLS0tLQ0K
IC4uLi9kdHMvbWVkaWF0ZWsvbXQ3NjIyLWJhbmFuYXBpLWJwaS1yNjQuZHRzICB8ICAxNiArLQ0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLXJmYjEuZHRzICB8ICAgNiArLQ0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kgICAgICB8ICA2OCArKysr
KystLS0NCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYyAgICAgICAgfCAg
MjUgKystDQogOSBmaWxlcyBjaGFuZ2VkLCAyNTggaW5zZXJ0aW9ucygrKSwgMTQwIGRlbGV0aW9u
cygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGNpL21lZGlhdGVrLXBjaWUtY2ZnLnlhbWwNCg0KLS0NCjIuMTguMA0KDQo=

