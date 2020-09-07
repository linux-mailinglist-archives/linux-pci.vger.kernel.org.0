Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334E25FA1C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgIGMFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 08:05:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47633 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729208AbgIGMEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 08:04:44 -0400
X-UUID: 211cb11decbd4b71941aff5112ad8cb0-20200907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NSF/4NM5uAVLuEnB9EhXhboZR792opTOFNFJm6U+KMM=;
        b=mQjGozUKt5stGY54anpUlfZbak+fxeTqvVai4MeSjwWUtBqWm9W2RdV2APjE5oWP4M3kfcd1a3TKS0bE4bZYQdGKZ0cvdSQGX/hMkAFZpS4BlN2xsNlFVz9nFXsuV+jttj4LHM6fcDgztk+KhEdW+usF5JYIfmgS/qMTSgdTr1c=;
X-UUID: 211cb11decbd4b71941aff5112ad8cb0-20200907
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1145564618; Mon, 07 Sep 2020 20:04:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Sep 2020 20:04:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 20:04:30 +0800
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
Subject: [PATCH 3/3] MAINTAINERS: update entry for MediaTek PCIe controller
Date:   Mon, 7 Sep 2020 20:01:18 +0800
Message-ID: <20200907120118.11667-3-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200907120118.11667-1-jianjun.wang@mediatek.com>
References: <20200907120118.11667-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIG1haW50YWluZXIgZm9yIE1lZGlhVGVrIFBDSWUgY29udHJvbGxlciBkcml2ZXIuDQoNClNp
Z25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIE1BSU5UQUlORVJTIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoN
CmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQppbmRleCBkZWFhZmI2MTcz
NjEuLjVjNjExMDQ2ODUyNiAxMDA2NDQNCi0tLSBhL01BSU5UQUlORVJTDQorKysgYi9NQUlOVEFJ
TkVSUw0KQEAgLTEzNDU5LDYgKzEzNDU5LDcgQEAgRjoJZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1oaXN0Yi5jDQogDQogUENJRSBEUklWRVIgRk9SIE1FRElBVEVLDQogTToJUnlkZXIg
TGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KK006CUppYW5qdW4gV2FuZyA8amlhbmp1bi53
YW5nQG1lZGlhdGVrLmNvbT4NCiBMOglsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQogTDoJbGlu
dXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KIFM6CVN1cHBvcnRlZA0KLS0gDQoyLjE4
LjANCg==

