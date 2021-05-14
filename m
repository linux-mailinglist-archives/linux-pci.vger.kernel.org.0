Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70D03803E0
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhENHBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 03:01:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60823 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230349AbhENHBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 03:01:32 -0400
X-UUID: 5176a6e832494564bff7475722abdff4-20210514
X-UUID: 5176a6e832494564bff7475722abdff4-20210514
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2013543313; Fri, 14 May 2021 14:59:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 May 2021 14:59:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 May 2021 14:59:49 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>, <Ryan-JH.Yu@mediatek.com>
Subject: [PATCH 0/2] PCI: mediatek-gen3: Add support for disable dvfsrc
Date:   Fri, 14 May 2021 14:59:25 +0800
Message-ID: <20210514065927.20774-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series patches add support for disable dvfsrc voltage request.

Jianjun Wang (2):
  dt-bindings: PCI: mediatek-gen3: Add property to disable dvfsrc
    voltage request
  PCI: mediatek-gen3: Add support for disable dvfsrc voltage request

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  8 +++++
 drivers/pci/controller/pcie-mediatek-gen3.c   | 32 +++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.25.1

