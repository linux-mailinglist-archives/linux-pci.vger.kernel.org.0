Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1ED730449
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 17:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjFNP4I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjFNP4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 11:56:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0AB106
        for <linux-pci@vger.kernel.org>; Wed, 14 Jun 2023 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686758164; x=1718294164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V0ZOQaPKSV/H5+EVRJxA4Vvcf0hXmJjJ6BdLur6kYRU=;
  b=V643aerYP+6zmwo8MM1sZNAcU+JgKnAmpKMkNHj3tlnAehl3e2NHg0wV
   GSJaNzAcyzTi8nyi6RY5mVKXK2Q1kUz0tkXslCySJcbZiONLo7pn4Hn9K
   OKTmWOit2Xd3aXazZ+a2j0/uPK9KkKWBOD9dZNJfhXPfEokmxekLluyLb
   BNa9IfvUUDkhzkbJIhajFLKwE7eI03W1YfGfI2F2lPu3okU+LC9/kCsFM
   Rgr8JLfV7gkSTojwpAVEsS0F6MwfO8oE+gp/SXIj7kEMZ5v6zesURWvP+
   yDpBj6cy4MA+eKmo5bqVp8fououqqHLmiV9uBdvQbREAomhHcgbltqlDd
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="156969570"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 08:56:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 08:56:00 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 14 Jun 2023 08:55:59 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v1 0/8] PCI: microchip: Fixes and clean-ups
Date:   Wed, 14 Jun 2023 16:55:48 +0100
Message-ID: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
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

These patches are regenerated on v6.4-rc6.

Link: https://lore.kernel.org/linux-riscv/Y8p16kaddL+Ot2Oa@wendy/

Daire McNamara (8):
  PCI: microchip: Correct the DED and SEC interrupt bit offsets
  PCI: microchip: Remove cast warning for devm_add_action_or_reset() arg
  PCI: microchip: enable building this driver as a module
  PCI: microchip: Align register, offset, and mask names with hw docs
  PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
  PCI: microchip: Clean up initialisation of interrupts
  PCI: microchip: Gather MSI information from hardware config registers
  PCI: microchip: Re-partition code between probe() and init()

 drivers/pci/controller/Kconfig               |   2 +-
 drivers/pci/controller/pcie-microchip-host.c | 412 +++++++++++--------
 2 files changed, 246 insertions(+), 168 deletions(-)


base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
-- 
2.25.1

