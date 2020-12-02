Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132B52CBE7D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 14:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgLBNjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 08:39:05 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44891 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727924AbgLBNjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2020 08:39:05 -0500
X-UUID: 9a6bf7d6662d4ddb8bf75a2a1785f47c-20201202
X-UUID: 9a6bf7d6662d4ddb8bf75a2a1785f47c-20201202
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1497272996; Wed, 02 Dec 2020 21:38:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Dec 2020 21:38:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Dec 2020 21:38:16 +0800
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
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>
Subject: [v5,0/3] PCI: mediatek: Add new generation controller support
Date:   Wed, 2 Dec 2020 21:38:10 +0800
Message-ID: <20201202133813.6917-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series patches add pcie-mediatek-gen3.c and dt-bindings file to
support new generation PCIe controller.

Changes in v5:
1. Remove unused macros
2. Modify the config read/write callbacks, set the config byte field
   in TLP header and use pci_generic_config_read32/write32
   to access the config space
3. Fix the settings of translation window, both MEM and IO regions
   works properly
4. Fix typos

Changes in v4:
1. Fix PCIe power up/down flow
2. Use "mac" and "phy" for reset names
3. Add clock names
4. Fix the variables type

Changes in v3:
1. Remove standard property in binding document
2. Return error number when get_optional* API throws an error
3. Use the bulk clk APIs

Changes in v2:
1. Fix the typo of dt-bindings patch
2. Remove the unnecessary properties in binding document
3. dispos the irq mappings of msi top domain when irq teardown

Jianjun Wang (3):
  dt-bindings: PCI: mediatek: Add YAML schema
  PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
  MAINTAINERS: update entry for MediaTek PCIe controller

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  135 +++
 MAINTAINERS                                   |    1 +
 drivers/pci/controller/Kconfig                |   13 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-mediatek-gen3.c   | 1039 +++++++++++++++++
 5 files changed, 1189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
 create mode 100644 drivers/pci/controller/pcie-mediatek-gen3.c

-- 
2.25.1

