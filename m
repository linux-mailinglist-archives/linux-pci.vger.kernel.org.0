Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC0396B80
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 04:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhFACp5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 22:45:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56265 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232268AbhFACp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 22:45:57 -0400
X-UUID: bff2d02a406e44839be910fce4ad9fe3-20210601
X-UUID: bff2d02a406e44839be910fce4ad9fe3-20210601
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 621564343; Tue, 01 Jun 2021 10:44:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 10:44:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 10:44:10 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Randy Wu <Randy.Wu@mediatek.com>, <youlin.pei@mediatek.com>
Subject: [PATCH 0/2] PCI: mediatek-gen3: Add controller support for MT8195
Date:   Tue, 1 Jun 2021 10:44:06 +0800
Message-ID: <20210601024408.24485-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series patches modify pcie-mediatek-gen3.c and dt-bindings compatible
string to support the PCIe controller for MT8195.

Jianjun Wang (2):
  dt-bindings: PCI: mediatek-gen3: Add support for MT8195
  PCI: mediatek-gen3: Add controller support for MT8195

 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 +++-
 drivers/pci/controller/pcie-mediatek-gen3.c                   | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.18.0

