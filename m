Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358FE5AB485
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiIBO6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiIBO5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 10:57:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0CFF4C98;
        Fri,  2 Sep 2022 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662128538; x=1693664538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=00MuWJs7nufafUVbmiAfu3d9nDl7PUc8fJXHDrqkkec=;
  b=e84ERhGos410xBoyxuxE8F4lj58EX6VvIhw3RgG+7tKgyi+9uVyQK9ER
   RzRn+pU2G2ZGvYITQCmCn8hLZpqL7QRGS7FOTAs0LfWih69FBJ9IMAMBk
   ZoP00OcLG3Iaycw6dOlDA+4VvyA7SQC/jzHr55MDqLEv61CG3uOWVLnqQ
   /wfT5Jx2AEb90eJ04OUup3ghwRs1IUzuz+7gO+L6zNbTgbZ06k2ZcR08z
   bp8N/ua1BI8cIfVq+5+idh/zNiU2cI6TqMrGtFzxKoMHQaEnNJI9E2lt2
   hYQX+CJ7C0BupHmgRU+ZEmjcZmeee0ebJ0Njz9hsW2hcI/Gbin5IWDklb
   w==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="178808371"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 07:22:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 07:22:16 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 07:22:13 -0700
From:   <daire.mcnamara@microchip.com>
To:     <aou@eecs.berkeley.edu>, <bhelgaas@google.com>,
        <conor.dooley@microchip.com>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <lpieralisi@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <cyril.jean@microchip.com>, <padmarao.begari@microchip.com>,
        <heinrich.schuchardt@canonical.com>,
        <david.abdurachmanov@gmail.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v1 0/4] PCI: microchip: apportion address translation between rootport and FPGA
Date:   Fri, 2 Sep 2022 15:21:58 +0100
Message-ID: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Hi all,

This series includes an attempt to deal with the PCIe address translation
behaviour of Microchip PolarFire SoC.  On this chip, FPGA logic exists
between the PCIe rootport and the CPUs (Core Complex). So, outbound and
inbound translation to PCIe devices is achieved by a combination of individual 
customer's FPGA fabric designs and by the PCIe rootport itself and thus
the outbound and inbound address translation specified in range
properties and dma-range properties of the PCIe rootport appears insufficient
as they do not capture how much outbound and inbound address translation
has occured in the FPGA design between the addresses used by the CPU and
the addresses used by the PCIe devices. So, we require some mechanism
to inform the root port of what address translation it actually needs
to perform in order to achieve the goals specified in the range and
dma-range properties.

This series proposes two new Microchip properties, each in the form of
ranges, which capture the amount of outbound and inbound translation
done by the FPGA fabric, if any.  

If the new properties are absent, the range and dma-range properties 
are intended to be parsed by the root port driver as usual, and the 
entire specified address translation is carried out by the root port
using its address translation tables.

if one of the new properties are present, the translations
carried out by the rootport, as specified in the range or dma-range properties,
are adjusted by the amount of address translation carried out by
the FPGA design, as described in the details of the new properties.

The new properties are structured as ranges to enable FPGA designers to have
different address translation ranges; for example, an FPGA designer may
choose to partition 32-bit address translation and 38-bit translation through
different apertures for their particular design or may choose to target
non-cached and/or cached DDR with different dma-ranges.

This series contains a proposed new binding for the properties, and an
implementation of the new properties for the Microchip PolarFire SoC
PCIe rootport driver.

Thanks,
Daire

Conor Dooley (1):
  dt-bindings: PCI: microchip: add fabric address translation properties

Daire McNamara (3):
  riscv: dts: microchip: add fabric address translation properties
  PCI: microchip: add fabric address translation properties
  of: PCI: tidy up logging of ranges containing configuration space type

 .../bindings/pci/microchip,pcie-host.yaml     | 107 ++++++++++++++++++
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |   6 +-
 drivers/pci/controller/pcie-microchip-host.c  |  59 ++++++++--
 drivers/pci/of.c                              |   2 +
 4 files changed, 166 insertions(+), 8 deletions(-)


base-commit: 6496a28df951641c0d50052ee195c7765591ff92
prerequisite-patch-id: 39bd182e929a064e38ca191a1726dd6d5a620f2d
prerequisite-patch-id: 9401b90950832090dabfe5f74f525ed4fa1c1410
prerequisite-patch-id: 606a8ca57d3dc19b04490b6e75d267a7c0d76163
-- 
2.25.1

