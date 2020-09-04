Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4438D25DB2B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgIDOQf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 10:16:35 -0400
Received: from foss.arm.com ([217.140.110.172]:51202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbgIDOQP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 10:16:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EDB21045;
        Fri,  4 Sep 2020 07:16:14 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.6.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41473F71F;
        Fri,  4 Sep 2020 07:16:13 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM/PCI: Remove struct msi_controller from struct hw_pci
Date:   Fri,  4 Sep 2020 15:16:07 +0100
Message-Id: <20200904141607.4066-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The msi_ctrl field in struct hw_pci is currently unused by arm/mach
PCI host controller drivers.

Remove it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/mach/pci.h | 1 -
 arch/arm/kernel/bios32.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 83d340702680..f3a284e6a90b 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -17,7 +17,6 @@ struct pci_host_bridge;
 struct device;
 
 struct hw_pci {
-	struct msi_controller *msi_ctrl;
 	struct pci_ops	*ops;
 	int		nr_controllers;
 	unsigned int	io_optional:1;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index eecec16aa708..6b73e60cf95a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -480,7 +480,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				bridge->sysdata = sys;
 				bridge->busnr = sys->busnr;
 				bridge->ops = hw->ops;
-				bridge->msi = hw->msi_ctrl;
 				bridge->align_resource =
 						hw->align_resource;
 
-- 
2.26.1

