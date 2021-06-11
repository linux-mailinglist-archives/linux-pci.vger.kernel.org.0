Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A33A3BB9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 08:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFKGMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 02:12:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59447 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230463AbhFKGMy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 02:12:54 -0400
X-UUID: 557d55a163574bb8a9ea390b1925ce5f-20210611
X-UUID: 557d55a163574bb8a9ea390b1925ce5f-20210611
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1474560928; Fri, 11 Jun 2021 14:10:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Jun 2021 14:10:08 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 14:10:07 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>
CC:     <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/4] PCI: mediatek: Spilt PCIe node to comply with hardware design
Date:   Fri, 11 Jun 2021 14:08:58 +0800
Message-ID: <20210611060902.12418-1-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two independent PCIe controllers in MT2712 and MT7622
platform. Each of them should contain an independent MSI domain.

In old dts architecture, MSI domain will be inherited from the root
bridge, and all of the devices will share the same MSI domain.
Hence that, the PCIe devices will not work properly if the irq number
which required is more than 32.

Split the PCIe node for MT2712 and MT7622 platform to comply with
the hardware design and fix MSI issue.

change note:
  v10:Rebase for 5.13-rc1, no code change. 
  v9:Add reviewed-by Rob and fix kernel-ci bot warning.
     In the scene of using new dts format,when mtk_pcie_parse_port fails,
     of_node_put don't need to be called.
  v8:Remove slot node and fix yaml warning.
  v7:dt-bindings file was modified as suggested by Rob, other file no change.
  v6:Fix yaml error. make sure driver compatible with old and new DTS format.
  v5:Rebase for 5.9-rc1, no code change. 
  v4:Change commit message due to bayes statistical bogofilter
     considers this series patch SPAM.
  v3:Rebase for 5.8-rc1. Only collect ack of Ryder, No code change.
  v2:Change the allocation of MT2712 PCIe MMIO space due to the
     allocation size is not right in v1.

Chuanjia Liu (4):
  dt-bindings: PCI: mediatek: Update the Device tree bindings
  PCI: mediatek: Add new method to get shared pcie-cfg base address and
      parse node
  arm64: dts: mediatek: Split PCIe node for MT2712 and MT7622
  ARM: dts: mediatek: Update MT7629 PCIe node for new format

  .../bindings/pci/mediatek-pcie-cfg.yaml       |  39 ++++
  .../devicetree/bindings/pci/mediatek-pcie.txt | 201 ++++++++++--------
  arch/arm/boot/dts/mt7629-rfb.dts              |   3 +-
  arch/arm/boot/dts/mt7629.dtsi                 |  45 ++--
  arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  97 +++++----
  .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |  16 +-
  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   6 +-
  arch/arm64/boot/dts/mediatek/mt7622.dtsi      | 112 +++++-----
  drivers/pci/controller/pcie-mediatek.c        |  52 +++--
  9 files changed, 326 insertions(+), 245 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml

-- 
2.18.0



