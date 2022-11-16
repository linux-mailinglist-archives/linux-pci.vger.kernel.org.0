Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB362C047
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiKPOAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiKPN6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 08:58:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83348303C0;
        Wed, 16 Nov 2022 05:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668606930; x=1700142930;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gnyeTosH+4bNeTqmiTiA3jrblmnF4auGWZMR6U3XjvQ=;
  b=BHTisShogmS6l79GHc/bQ9MjXPg9vKuSZhuzEjuIQqQo/DwulRh4IoIW
   0C6J/3bFeNnJcIyzGpVxpf3INyiF4PxxOK1n8KvSdqN/KPsN7FU/Md4hj
   j2MKZUvcsZALuY1CFe29/2ov9De+7psPRDlJ0MBgvioUWrc+5mcfRx1Jq
   WTbpugjUWsGLj+CUfBc8rlk0XXz9cHNL1KUi0VcKRq/xzdjh7cRp/zma0
   2a40MKOFVgtH+Da/qD6pPIU0hSTxwnggP+P3idN3qS9FG2P6hgHMuYLBV
   9N3go/TaQdrSlnRWxGfBZZDX6zk7AI6JyCl4Cs6c1tO/kWIMriyjoRt1j
   w==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="183798607"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 06:55:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 06:55:09 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 16 Nov 2022 06:55:06 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v1 0/9] PCI: microchip: Partition address translations
Date:   Wed, 16 Nov 2022 13:54:55 +0000
Message-ID: <20221116135504.258687-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Microchip PolarFire SoC is a 64-bit device and has DDR starting at
0x80000000 and 0x1000000000. Its PCIe rootport is connected to the CPU
Coreplex via an FPGA fabric. The AXI connections between the Coreplex and
the fabric are 64-bit and the AXI connections between the fabric and the
rootport are 32-bit.  For the CPU CorePlex to act as an AXI-Master to the
PCIe devices and for the PCIe devices to act as bus masters to DDR at these
base addresses, the fabric can be customised to add/remove offsets for bits
38-32 in each direction. These offsets, if present, vary with each
customer's design.

To support this variety, the rootport driver must know how much address
translation (both inbound and outbound) is performed by a particular
customer design and how much address translation must be provided by the
rootport.

This patchset contains a parent/child dma-ranges scheme suggested by Rob
Herring. It creates an FPGA PCIe parent bus which wraps the PCIe rootport
and implements a parsing scheme where the root port identifies what address
translations are performed by the FPGA fabric parent bus, and what
address translations must be done by the rootport itself.

See https://lore.kernel.org/linux-pci/20220902142202.2437658-1-daire.mcnamara@microchip.com/
for the relevant previous patch submission discussion.

It also re-partitions the probe() and init() functions as suggested by
Bjorn Helgaas to make them more maintainable as the init() function had
become too large.

It also contains some minor fixes and clean-ups that are pre-requisites:
- to align register, offset, and mask names with the hardware documentation
  and to have the register definitions appear in the same order as in the
  hardware documentation;
- to harvest the MSI information from the hardware configuration register
  as these depend on the FPGA fabric design and can vary with different
  customer designs;
- to clean up interrupt initialisation to make it more maintainable;
- to fix SEC and DED interrupt handling.

I expect Conor will take the dts patch via the soc tree once the PCIe parts
of the series are accepted.

Conor Dooley (1):
  riscv: dts: microchip: add parent ranges and dma-ranges for IKRD
    v2022.09

Daire McNamara (8):
  PCI: microchip: Align register, offset, and mask names with hw docs
  PCI: microchip: Correct the DED and SEC interrupt bit offsets
  PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
  PCI: microchip: Clean up initialisation of interrupts
  PCI: microchip: Gather MSI information from hardware config registers
  PCI: microchip: Re-partition code between probe() and init()
  PCI: microchip: Partition outbound address translation
  PCI: microchip: Partition inbound address translation

 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  62 +-
 drivers/pci/controller/pcie-microchip-host.c  | 676 +++++++++++++-----
 2 files changed, 522 insertions(+), 216 deletions(-)


base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
-- 
2.25.1

