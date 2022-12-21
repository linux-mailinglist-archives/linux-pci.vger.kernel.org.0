Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AE6533E3
	for <lists+linux-pci@lfdr.de>; Wed, 21 Dec 2022 17:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiLUQ0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Dec 2022 11:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUQ0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2022 11:26:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF610568;
        Wed, 21 Dec 2022 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671639997; x=1703175997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=urUO3lBnUtgO+026vENV9ZHIqNZxZaA6oDAmSzARVN0=;
  b=yXPcyDSyhP93ri/pWIgK0+NxSS+wlvegvlv8iKnDYd89iJP+t57BU52j
   1bKIjVfGcVnAz0VeK7KrwxV00qenmz6Rb9OGaFIJvM/I2nHA7TcFGQafO
   ahTEeYFc6gO9js87ZBQsrpxGvo+R+VvPMfdSwtvs4Z77PsCyHExnIZdmC
   FzZ6EZU1DmEpPO1t/r4qwfUkTQst07ZjhneoBoZFIbR49U2p4gh3unA52
   p/ClT8YIlv+t24wb3/ETEvnlD41MLceUw51M8/+qTdCVhj96cJaM8SRTa
   6gf15mbfUfnEHfmOvrjDlCIRc0s+8PDNXF1MaB2q2zZiofPn3H3b95eri
   A==;
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="204941736"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Dec 2022 09:26:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 09:26:36 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 09:26:33 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v2 0/9] PCI: microchip: Partition address translations
Date:   Wed, 21 Dec 2022 16:26:21 +0000
Message-ID: <20221221162630.3632486-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Changes since v1:
- Removed unused variables causing compile warnings
- Removed incorrect Signed-off-by: tags
- Capitalised msi and msi-x
- Capitalised FIC and respelled busses to buses
- Capitalised all comments
- Renamed fabric inter connect to Fabric Interface Controller as per PolarFire SoC TRM

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
  PCI: microchip: Correct the DED and SEC interrupt bit offsets
  PCI: microchip: Align register, offset, and mask names with hw docs
  PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
  PCI: microchip: Clean up initialisation of interrupts
  PCI: microchip: Gather MSI information from hardware config registers
  PCI: microchip: Re-partition code between probe() and init()
  PCI: microchip: Partition outbound address translation
  PCI: microchip: Partition inbound address translation

 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  62 +-
 drivers/pci/controller/pcie-microchip-host.c  | 678 +++++++++++++-----
 2 files changed, 524 insertions(+), 216 deletions(-)


base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
-- 
2.25.1

