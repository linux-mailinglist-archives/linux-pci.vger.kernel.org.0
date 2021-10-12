Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420BE42A9C7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJLQoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhJLQoG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:44:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E08FD61076;
        Tue, 12 Oct 2021 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056924;
        bh=kY1dXfyNYpcpAYJ01xtEYI0Vj2+JUlx5S8nnxpkVqUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4LmXMM5s1xbTmRtFJb2wrJdI3P5M5btI7ZQFbceJhnAFkPtqQcYx6fS1AXBiAJLz
         F1vap9iqspfKsL12zuepTsTq9yjilfRfGKHVagUGpvPXbNs4ojjHIrjbs9LIE5IZNR
         JWDCOqyaUFwxPn5LJtRfaUwGrvMe8KpCE4HB/KjOzo7rbEz6V2TTybYw2dKIuOizQI
         QpOPARDfqh7PDOVaSheEIkOeeAxbrw/IEtO3+R1M9nafUXqeqazK8+NcYMUvD1fbKA
         icmG8/VPYQ7/wrUevJ5j1LDDTYiX3qK0zA6NFJaKAYWttoRrwRcg05bvX3Uzid9gjm
         V8jTnp5UCaIPA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 12/14] PCI: aardvark: Set PCI Bridge Class Code to PCI Bridge
Date:   Tue, 12 Oct 2021 18:41:43 +0200
Message-Id: <20211012164145.14126-13-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Aardvark controller has something like config space of a Root Port
available at offset 0x0 of internal registers - these registers are used
for implementation of the emulated bridge.

The default value of Class Code of this bridge corresponds to a RAID Mass
storage controller, though. (This is probably intended for when the
controller is used as Endpoint.)

Change the Class Code to correspond to a PCI Bridge.

Add comment explaining this change.

Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 289cd45ed1ec..801657e7da93 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -513,6 +513,26 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg = (PCI_VENDOR_ID_MARVELL << 16) | PCI_VENDOR_ID_MARVELL;
 	advk_writel(pcie, reg, VENDOR_ID_REG);
 
+	/*
+	 * Change Class Code of PCI Bridge device to PCI Bridge (0x600400),
+	 * because the default value is Mass storage controller (0x010400).
+	 *
+	 * Note that this Aardvark PCI Bridge does not have compliant Type 1
+	 * Configuration Space and it even cannot be accessed via Aardvark's
+	 * PCI config space access method. Something like config space is
+	 * available in internal Aardvark registers starting at offset 0x0
+	 * and is reported as Type 0. In range 0x10 - 0x34 it has totally
+	 * different registers.
+	 *
+	 * Therefore driver uses emulation of PCI Bridge which emulates
+	 * access to configuration space via internal Aardvark registers or
+	 * emulated configuration buffer.
+	 */
+	reg = advk_readl(pcie, PCIE_CORE_DEV_REV_REG);
+	reg &= ~0xffffff00;
+	reg |= (PCI_CLASS_BRIDGE_PCI << 8) << 8;
+	advk_writel(pcie, reg, PCIE_CORE_DEV_REV_REG);
+
 	/* Disable Root Bridge I/O space, memory space and bus mastering */
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 	reg &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-- 
2.32.0

