Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67BF1A8F96
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 02:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392308AbgDOANR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 20:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392311AbgDOANP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:13:15 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC3120774;
        Wed, 15 Apr 2020 00:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909593;
        bh=dRngsPvuG+kETgs2smktXaw9v1l2uk2emjkFea1ZosU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNc70G7YwSQcq2MM9qgM51emm22lpt/Tuq/i8nVHyR/l+0y5zCxciz4rG1GVYkmKj
         pUBkZ4veIBiIho+l1qIauTrjurx2Pt/rtbf2BZMIQRMLtDj8bjmTc/esrjKJk6Cczd
         2DETdj5iD/rHgC9jtVpQ90O9wrblPLZxrC1g86Sg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 1/4] PCI: dra7xx: Don't select CONFIG_PCI_DRA7XX_HOST by default
Date:   Tue, 14 Apr 2020 19:12:41 -0500
Message-Id: <20200415001244.144623-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415001244.144623-1-helgaas@kernel.org>
References: <20200415001244.144623-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Drivers should not be selected by default because that bloats the kernel
for people who don't need them.

Remove the "default y" for CONFIG_PCI_DRA7XX_HOST.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/pci/controller/dwc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 03dcaf65d159..ea335ee7ca8e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -26,7 +26,6 @@ config PCI_DRA7XX_HOST
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
-	default y
 	help
 	  Enables support for the PCIe controller in the DRA7xx SoC to work in
 	  host mode. There are two instances of PCIe controller in DRA7xx.
-- 
2.26.0.110.g2183baf09c-goog

