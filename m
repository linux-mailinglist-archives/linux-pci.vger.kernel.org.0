Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79E743F29
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 17:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjF3PtI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3PtH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 11:49:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423B35A5
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688140145; x=1719676145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Azy4tEc4ZZFt8M62Y/BZ47WSbxYTHrOJJk6YOf3OYes=;
  b=DgnsGSwcjdzP3hINqUvXqBofMQ6JyylU3zIPl3nXggBp7CYwHMdrDGMW
   eKvtKBGvV0IYorfvw5tbib5zYvnoEjvP+OTAXYDFr2Ul8Dr510Z4ei9K9
   TdfEP5BdofeEMi3/6h8c3mpBR1oTSIHU7uL1R4bZJ2cjBQT4RE+0d2p7x
   ck4Kiy/Y7vkJm/0jnMrULhwIT3Y60CGILa7anbcFJSiirXeQsYpi7CAVl
   0AxsWlm3qJaXqH+bwkGZHEu2SvfutWT9LsDvtb15azVfzy8ZAlM3PMALq
   AkdpqTpVcnqtYlzY6QYKC4An26JaOwbGIW8/4mmuo8sXdwjAHxSz7USea
   A==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="159339669"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2023 08:49:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 30 Jun 2023 08:49:04 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 30 Jun 2023 08:49:02 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 0/8] PCI: microchip: Fixes and clean-ups
Date:   Fri, 30 Jun 2023 16:48:51 +0100
Message-ID: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

These patches are regenerated on v6.4-rc6.

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
  PCI: microchip: Rename and refactor mc_pcie_enable_msi()
  PCI: microchip: Re-partition code between probe() and init()

 drivers/pci/controller/Kconfig               |   2 +-
 drivers/pci/controller/pcie-microchip-host.c | 402 +++++++++++--------
 2 files changed, 238 insertions(+), 166 deletions(-)


base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
-- 
2.25.1

