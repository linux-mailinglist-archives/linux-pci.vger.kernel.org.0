Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFC6E6B45
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjDRRoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjDRRnz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 13:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD96B75F;
        Tue, 18 Apr 2023 10:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9945C63773;
        Tue, 18 Apr 2023 17:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2921C433D2;
        Tue, 18 Apr 2023 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839833;
        bh=zpWqmGvi9CSxKxYVFIGXgRmOWG8TbX9XjeHQATchqSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KK6eHqqCu9DNgOk6vlUyYvD+Bax8t9CcyT6M37foWjeBIhQYTpvLeC8eigyyJ8bOK
         M10POSYpvjvDCgnvx8chGfPA568wJPxznF5PKMWAq6TKsvbsO0igNjJhPaXaHAQ3l5
         v344IW/SR+f8KkNwDRQS+QTdtgxW7wBHP6rgP4AZDudSdYmdFOTqL/pQrMFdLVLU6a
         f1huk/mr434fkd8gNEmFQQsviTtj3L11XHHpImWa5qd8fEOVcy8vdgoJ4lRj9iITgW
         NZFzLfYXqKjBt7ih0q7BL/2eXsfK8DRMSofgE4OiusVuCX3SIe39c3Yf4RqiVHrJ2H
         niDh9cs/MAHiQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 3/7] PCI: xilinx-nwl: Add 'Xilinx' to Kconfig prompt
Date:   Tue, 18 Apr 2023 12:43:32 -0500
Message-Id: <20230418174336.145585-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418174336.145585-1-helgaas@kernel.org>
References: <20230418174336.145585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add the "Xilinx" vendor name to the CONFIG_PCIE_XILINX_NWL Kconfig prompt
so it matches other drivers.  Rename from "PCIe Core" to "PCIe controller".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8b1f9a3f83ea..5875587d8b59 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -28,7 +28,7 @@ config PCI_AARDVARK
 	 3700 SoC.
 
 config PCIE_XILINX_NWL
-	bool "NWL PCIe Core"
+	bool "Xilinx NWL PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on PCI_MSI
 	help
-- 
2.25.1

