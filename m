Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69C02F4A65
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 12:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbhAMLlk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 06:41:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60713 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbhAMLlk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 06:41:40 -0500
X-UUID: 361aad17095448beb57661ef8259a9ca-20210113
X-UUID: 361aad17095448beb57661ef8259a9ca-20210113
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 543828084; Wed, 13 Jan 2021 19:40:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Jan 2021 19:40:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 19:40:51 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        <anson.chuang@mediatek.com>
Subject: [v7,0/7] PCI: mediatek: Add new generation controller support
Date:   Wed, 13 Jan 2021 19:39:54 +0800
Message-ID: <20210113114001.5804-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series patches add pcie-mediatek-gen3.c and dt-bindings file to
support new generation PCIe controller.

Changes in v7:
1. Split the driver patch to core PCIe, INTx, MSI and PM patches;
2. Reshape MSI init and handle flow, use msi_bottom_domain to cover all sets;
3. Replace readl/writel with their relaxed version;
4. Add MSI description in binding document;
5. Add pl_250m clock in binding document.

Changes in v6:
1. Export pci_pio_to_address() to support compiling as kernel module;
2. Replace usleep_range(100 * 1000, 120 * 1000) with msleep(100);
3. Replace dev_notice with dev_err;
4. Fix MSI get hwirq flow;
5. Fix warning for possible recursive locking in mtk_pcie_set_affinity.

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


Jianjun Wang (7):
  dt-bindings: PCI: mediatek-gen3: Add YAML schema
  PCI: Export pci_pio_to_address() for module use
  PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
  PCI: mediatek-gen3: Add INTx support
  PCI: mediatek-gen3: Add MSI support
  PCI: mediatek-gen3: Add system PM support
  MAINTAINERS: Add Jianjun Wang as MediaTek PCI co-maintainer

 .../bindings/pci/mediatek-pcie-gen3.yaml      | 172 ++++
 MAINTAINERS                                   |   1 +
 drivers/pci/controller/Kconfig                |  13 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-mediatek-gen3.c   | 965 ++++++++++++++++++
 drivers/pci/pci.c                             |   1 +
 6 files changed, 1153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
 create mode 100644 drivers/pci/controller/pcie-mediatek-gen3.c

-- 
2.25.1

