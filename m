Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBBA5AB487
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiIBO6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiIBO5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 10:57:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B462E4;
        Fri,  2 Sep 2022 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662128548; x=1693664548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ruUuCbd7+5Ub1DZrutHdCrvbcDkefYKJFQJhor7JwlU=;
  b=Bz9VpFzEtGnXxX+DB/346EHj802wunUxopWgrNvLVZM4BMG9i+9hR8KX
   bf6HFZ9R6cq1UHYUEqPihC9QtwmPT9PNLtDB07HkHa60IUe6LcSzZdi9O
   0PZAQgGKpsfTjPiZDBzv1l0J9fKqRRaESfO5DME8KQqQ+sxpaCp+u/48l
   C8XBfoKiCZtroLT3CR+awSbFnYYJ3QV5MwgFv8cpPo/qG33LFmYuXTKXx
   K74l26e/Yt46JufePCP78ZekIi+tKZ3W8qOvZWXPxPIp6QwSPRjM1GW5p
   uRfzBkToZRoGpfo/mRaiEhbMNbkbf7Vo0yj6nXpsmFgjjtcyRNmZzE8fF
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="111937895"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 07:22:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 07:22:25 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 07:22:22 -0700
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
Subject: [PATCH v1 1/4] dt-bindings: PCI: microchip: add fabric address translation properties
Date:   Fri, 2 Sep 2022 15:21:59 +0100
Message-ID: <20220902142202.2437658-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
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

From: Conor Dooley <conor.dooley@microchip.com>

On PolarFire SoC both in- & out-bound address translations occur in two
stages. The specific translations are tightly coupled to the FPGA
designs and supplement the {dma-,}ranges properties. The first stage of
the translation is done by the FPGA fabric & the second by the root
port.
Add two properties so that the translation tables in the root port's
bridge layer can be configured to account for the translation done by
the FPGA fabric.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 .../bindings/pci/microchip,pcie-host.yaml     | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 23d95c65acff..29bb1fe99a2e 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -71,6 +71,113 @@ properties:
     minItems: 1
     maxItems: 6
 
+  microchip,outbound-fabric-translation-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 32
+    description: |
+      The CPU-to-PCIe (outbound) address translation takes place in two stages.
+      Depending on the FPGA bitstream, the outbound address translation tables
+      in the PCIe root port's bridge layer will need to be configured to account
+      for only its part of the overall outbound address translation.
+
+      The first stage of outbound address translation occurs between the CPU address
+      and an intermediate "FPGA address". The second stage of outbound address
+      translation occurs between this FPGA address and the PCIe address. Use this
+      property, in conjunction with the ranges property, to divide the overall
+      address translation into these two stages so that the PCIe address
+      translation tables can be correctly configured.
+
+      If this property is present, one entry is required per range. This is so
+      FPGA designers can choose to route different address ranges through different
+      Fabric Interface Controllers and other logic as they see fit.
+
+      If this property is not present, the entire address translation
+      in any ranges property is attempted by the root port driver via its outbound
+      address translation tables.
+
+      Each element in this property has three components. The first is a
+      PCIe address, the second is an FPGA address, and the third is a size.
+      These properties may be 32 or 64 bit values.
+
+      In operation, the driver will expect a one-to-one correspondance between
+      range properties and this property.  For each pair of range and
+      outbound-fabric-translation-range properties, the root port driver will
+      subtract the FPGA address in this property from the CPU address in the
+      corresponding range property and use the remainder to program its
+      outbound address translation tables.
+
+      For each range, take its PCIe address and size - these are the PCIe
+      address & size for the element. The FPGA address is derived from a given
+      FPGA fabric design and is the address delivered by that FPGA fabric
+      design to the Core Complex. For a trivial configuration, it is likely to be the
+      lower 32 bits of the PCIe address in the range property and the upper
+      bits of the base address of the Fabric Interface Controller the design uses.
+      Otherwise, it is tightly coupled with the data path configured in the
+      FPGA fabric between the root port and the Core Complex.
+
+      For more information on the tables, see Section 1.3.3,
+      "PCIe/AXI4 Address Translation" of the PolarFire SoC PCIe User Guide:
+      https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide
+
+    items:
+      minItems: 3
+      maxItems: 6
+
+  microchip,inbound-fabric-translation-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 32
+    description: |
+      The PCIe-to-CPU (inbound) address translation takes place in two stages.
+      Depending on the FPGA bitstream, the inbound address translation tables
+      in the PCIe root port's bridge layer will need to be configured to account
+      for only its part of the overall inbound address translation.
+
+      The first stage of address translation occurs between the PCIe address and
+      an intermediate FPGA address. The second stage of address translation
+      occurs between the FPGA address and the CPU address. Use this property
+      in conjunction with the dma-ranges property to divide the address
+      translation into these two stages.
+
+      If this property is present, one entry is required per dma-range. This is so
+      FPGA designers can choose to route different address ranges through different
+      Fabric Interface Controllers and other logic as they see fit.
+
+      If this property is not present, the entire address translation
+      in any dma-ranges property is attempted by the root port driver via its
+      inbound address translation tables.
+
+      Each element in this property has three components. The first is a
+      PCIe address, the second is an FPGA address, and the third is a size.
+      These properties may be 32 or 64 bit values.
+
+      In operation, the driver will expect a one-to-one correspondance between
+      dma-range properties and this property.  For each pair of dma-range and
+      inbound-fabric-translation-range properties, the root port driver will
+      subtract the FPGA address in this property from the CPU address in the
+      corresponding dma-range property and use the remainder to program its
+      inbound address translation tables.
+
+      From each dma-range, take its PCIe address and size - these are the PCIe
+      address & size for the element. The FPGA address is derived from a given
+      FPGA fabric design and is the address delivered by that FPGA fabric
+      design to the Core Complex. For a trivial configuration, this property
+      is unlikely to be required (i.e. no fabric translation on the inbound
+      interface).  Otherwise, it is tightly coupled with the inbound data path
+      configured in the FPGA fabric between the root port and the Core Complex.
+      It is expected that more than one translation range may be added to
+      an FPGA fabric design, e.g. to deliver data to cached or non-cached
+      DDR.
+
+      For more information on the tables, see Section 1.3.3,
+      "PCIe/AXI4 Address Translation" of the PolarFire SoC PCIe User Guide:
+      https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide
+
+    items:
+      minItems: 4
+      maxItems: 7
+
   msi-controller:
     description: Identifies the node as an MSI controller.
 
-- 
2.25.1

