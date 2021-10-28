Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FEB43E8B5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJ1S7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhJ1S7g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:59:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A26D610FD;
        Thu, 28 Oct 2021 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635447429;
        bh=7Qve900myusAiuJ52EKMbKQbQLqBfQ6yVPIdzZTGc1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQIAG2wVGlArGmVeo5kIRlwxf2Y0Vhwz4yjMtytKmXdIUV1eavh+Nl4d7x1O29Knc
         QpNimaCI0J2k7V6Qk9Po33apQakDwSPqiyGufGlvOfVeIxA01Fj9BKkGOX2I1N01OU
         mwjNKECVyT+GxRJwm1VdsfYRDUjZ5GCg6qc1eiOYBY8Vf0f4mQirbNLYSg0D1rN6uZ
         m2+k1XQS4FSrhBVoeUcOnAYVldzsaC1pbF148DS5vbPcMWUd4JFFKUtyH48aN9Foh5
         tflWG9bj3LahczIRzWIFAkAl+Ts9/E16aR2phBD1WpP4gnh78rgU2wEyIjnivvDQDC
         +MxttoGjB1POw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 5/7] PCI: aardvark: Set PCI Bridge Class Code to PCI Bridge
Date:   Thu, 28 Oct 2021 20:56:57 +0200
Message-Id: <20211028185659.20329-6-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211028185659.20329-1-kabel@kernel.org>
References: <20211028185659.20329-1-kabel@kernel.org>
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
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d7db03da4d1c..ddca45415c65 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -511,6 +511,26 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
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

