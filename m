Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46C3F43DB
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 05:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhHWD26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 23:28:58 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34538 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230401AbhHWD26 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 23:28:58 -0400
X-UUID: 84a3a18d9bfa40ab8c99e57022c4c8a4-20210823
X-UUID: 84a3a18d9bfa40ab8c99e57022c4c8a4-20210823
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 46121522; Mon, 23 Aug 2021 11:28:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Aug 2021 11:28:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 23 Aug 2021 11:28:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Aug 2021 11:28:09 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <lorenzo.pieralisi@arm.com>
CC:     <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 0/6] PCI: mediatek: Spilt PCIe node to comply with hardware design 
Date:   Mon, 23 Aug 2021 11:27:54 +0800
Message-ID: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two independent PCIe controllers in MT2712 and MT7622 platform.
Each of them should contain an independent MSI domain.
 
In old dts architecture, MSI domain will be inherited from the root
bridge, and all of the devices will share the same MSI domain.Hence that,
the PCIe devices will not work properly if the irq number which required
is more than 32.
 
Split the PCIe node for MT2712 and MT7622 platform to comply with 
the hardware design and fix MSI issue.
 
change note:
 v12:Add Reviwe by Rob. According to Bjorn's suggestion, 
     split the driver patch into three parts and rewrite 
     the commit logs, there is no code change
 v11:Rebase for 5.14-rc1 and add "interrupt-names", "linux,pci-domain"
     description in binding file. No code change.
 v10:Rebase for 5.13-rc1, no code change.
 v9:fix kernel-ci bot warning. In the scene of using new dts format,
    when mtk_pcie_parse_port fails, of_node_put don't need to be called.
 v8:remove slot node and fix yaml warning.
 v7:dt-bindings file was modified as suggested by Rob, other file no
    change.
 v6:Fix yaml error. make sure driver compatible with old and
    new DTS format.
 v5:rebase for 5.9-rc1, no code change.
 v4:change commit message due to bayes statistical bogofilter
    considers this series patch SPAM.
 v3:rebase for 5.8-rc1. Only collect ack of Ryder, No code change.
 v2:change the allocation of MT2712 PCIe MMIO space due to the
    allocation size is not right in v1.
				      
Chuanjia Liu (6):
  dt-bindings: PCI: mediatek: Update the Device tree bindings
  PCI: mediatek: Add new method to get shared pcie-cfg base address
  PCI: mediatek: Add new method to get irq number
  PCI: mediatek: Get pci domain and decide how to parse node
  arm64: dts: mediatek: Split PCIe node for MT2712 and MT7622
  ARM: dts: mediatek: Update MT7629 PCIe node for new format

  .../bindings/pci/mediatek-pcie-cfg.yaml       |  39 ++++
  .../devicetree/bindings/pci/mediatek-pcie.txt | 206 ++++++++++--------
  arch/arm/boot/dts/mt7629-rfb.dts              |   3 +-
  arch/arm/boot/dts/mt7629.dtsi                 |  45 ++--
  arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  97 +++++----
  .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |  16 +-
  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   6 +-
  arch/arm64/boot/dts/mediatek/mt7622.dtsi      | 112 +++++-----
  drivers/pci/controller/pcie-mediatek.c        |  52 +++--
9 files changed, 330 insertions(+), 246 deletions(-)
create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
 
--
2.18.0
	 

