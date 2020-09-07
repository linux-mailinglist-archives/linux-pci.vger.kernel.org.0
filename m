Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF13425FA38
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgIGMLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 08:11:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3714 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729238AbgIGMK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 08:10:58 -0400
X-UUID: 1234c8e3ab9f4b2293c8ae9cf58e7298-20200907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3Ts95OagkB8HioiMDNRF+4vLVq463WgaXrfur7KeqjM=;
        b=tlTv8LQipVyz1T7lFlPM3zYv92H+lpXZi9MpWmQC56nYcGITxXRg4Lq4LjPlSqBQwg26qz6qFd+5tQCB1lERY1pIgf3DlV6NoJCK78a8505Q6B6WmTMOnu0QSKyjcZoiQqnQpJDLUyYUyrxpv6RQOPGv/bpV2/HgxdKawWNEQw4=;
X-UUID: 1234c8e3ab9f4b2293c8ae9cf58e7298-20200907
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1168662045; Mon, 07 Sep 2020 20:10:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Sep 2020 20:10:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 20:10:53 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Subject: [v1,3/3] MAINTAINERS: update entry for MediaTek PCIe controller
Date:   Mon, 7 Sep 2020 20:08:52 +0800
Message-ID: <20200907120852.12090-4-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200907120852.12090-1-jianjun.wang@mediatek.com>
References: <20200907120852.12090-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIG1haW50YWluZXIgZm9yIE1lZGlhVGVrIFBDSWUgY29udHJvbGxlciBkcml2ZXIuDQoNCkFj
a2VkLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBNQUlOVEFJ
TkVSUyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0
IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KaW5kZXggZGVhYWZiNjE3MzYxLi41YzYxMTA0
Njg1MjYgMTAwNjQ0DQotLS0gYS9NQUlOVEFJTkVSUw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC0x
MzQ1OSw2ICsxMzQ1OSw3IEBAIEY6CWRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtaGlz
dGIuYw0KIA0KIFBDSUUgRFJJVkVSIEZPUiBNRURJQVRFSw0KIE06CVJ5ZGVyIExlZSA8cnlkZXIu
bGVlQG1lZGlhdGVrLmNvbT4NCitNOglKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRl
ay5jb20+DQogTDoJbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KIEw6CWxpbnV4LW1lZGlhdGVr
QGxpc3RzLmluZnJhZGVhZC5vcmcNCiBTOglTdXBwb3J0ZWQNCi0tIA0KMi4yNS4xDQo=

