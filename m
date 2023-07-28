Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA51766DE0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjG1NOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjG1NOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 09:14:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5923A9B
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690550047; x=1722086047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z0fwAPNzFg8lhlVnwCKJCYD81rl4C9MhpAaVh5wSuOo=;
  b=fBvmB3B7Ib/1ukZXjvT5aiDvDVqgITxyettAVEzF3aG/YEmjd3Z0g6kL
   kG1ABDU3Cwz2kWeIwTuZYVtLUJGPKGkphe3gVPA1TuZBE37VulNpVxpN3
   zjxcJxaiUzucW3YvVsBvqwv8eFHP3yabPcCQp5ltlbtR16tGVocoF38po
   G8Y1r6AOz/JtRSeisKLDXWWLQqMUl8Hp6iDw/3qioe/MzjA23JnCfSazy
   sODjf8riHw+fO4s8jnSgRzrs1Wb5XkumaTJlr9RZQGXRuCCtz+60tmI84
   dCHk5bdPAo6Dedwf2658Q7ruwCBKDEX6kEpOX/zEZgHi9fZUwTKWhYD9b
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="222752993"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 06:14:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 06:14:05 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 06:14:04 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v3 0/7] PCI: microchip: Fixes and clean-ups
Date:   Fri, 28 Jul 2023 14:13:54 +0100
Message-ID: <20230728131401.1615724-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

This patch series contains fixes and clean-ups for the Microchip PolarFire SoC PCIe driver

These patches are extracted from the link below to separate them from the outbound and inbound
range handling which is taking considerable time.
Link: https://lore.kernel.org/linux-riscv/20230111125323.1911373-1-daire.mcnamara@microchip.com/

Resending with correct e-mail address list

These patches are regenerated on v6.5-rc3.

Main changes from v2:
- Reworked "Gather MSI information..." as suggested by Bjorn
- merged 'Gather MSI Information..." and "Rename and refactor" as suggested by Bjorn
- Re-generated on v6.5-rc3

Main Changes from v1:
- Dropped "Remove cast warning for devm_add_action_or_reset()". This
  has been overtaken by a patch series from Krzysztof Wilczynski.
- Improved the comment for "Enable building driver as a module" to
  clarify what enables building the driver as a module.
- Split "Gather MSI information from hardware config registers",
  for clarity, into:
   - "Gather MSI information from hardware config registers" purely
      changing the of source of MSI-related information (Num MSIs and
      MSI address) from #defines (which can be incorrect) to FPGA
      configuration registers (which is the ultimate source of truth),
      and a
   - "Rename and refactor ..." patch as a function's code is now clearly
      unrelated to its current name.

cc: Conor Dooley <conor.dooley@microchip.com>
cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
cc: "Krzysztof Wilczyński" <kw@linux.com>
cc: Rob Herring <robh@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-riscv@lists.infradead.org
cc: linux-pci@vger.kernel.org

Daire McNamara (8):
  PCI: microchip: Correct the DED and SEC interrupt bit offsets
  PCI: microchip: Enable building driver as a module
  PCI: microchip: Align register, offset, and mask names with hw docs
  PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
  PCI: microchip: Clean up initialisation of interrupts
  PCI: microchip: Gather MSI information from hardware config registers
  PCI: microchip: Re-partition code between probe() and init()

 drivers/pci/controller/Kconfig               |   2 +-
 drivers/pci/controller/pcie-microchip-host.c | 393 +++++++++++--------
 2 files changed, 233 insertions(+), 162 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.25.1

