Return-Path: <linux-pci+bounces-3802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D185CC4D
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 00:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E77284134
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7980154C02;
	Tue, 20 Feb 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOpTa8eH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0632C1B1;
	Tue, 20 Feb 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473332; cv=none; b=dG9qKl+iGUgyjECwHnXgQDlQyqEdh4k8IauWCO/hIKeELMSCx0pBAZHWqDDx5TrKA2fcukCY6wOvIPOwX5EDrRVfqRFwI6JWCgQO0YRDBhUHVGjXa4ZiPezDhj2IRUwtXYqp8lLUh5EjRygPv7nKfHk2sLvpke7Di8q9KHRB064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473332; c=relaxed/simple;
	bh=pxMSv6jAyvYB/3P8lPP0YmoEDtMkNQ0qpAnwOIXPqOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aki+HXwh+oxfwiDchQrLgNkcfDUG+JuP4q5rlPrLHWrYwhTrWMf6BSf1m7b3N9BV8Jm3I7Z5oWl7iCzBrAqV6kOUAqAa6rrltL35plxdWmGT8GN1KTqkqlR3jDToXEHO7i7k94WVMPdztVfMTyvT+xWL5PZMVo3kTZ+y9Mt6JaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOpTa8eH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D884C433F1;
	Tue, 20 Feb 2024 23:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708473331;
	bh=pxMSv6jAyvYB/3P8lPP0YmoEDtMkNQ0qpAnwOIXPqOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OOpTa8eHu85Il3VQM6AN5fQV/X/C2vZnrC182k7nHLPpADaKz/ZL/f/5LiHDdu0dF
	 iR0ushZ7TbHyg4zhSgZmXECCB9tIVNAf2yBBYHiCRBfJh/Y2FoFu1pTZ/H21qP+K8c
	 BDR1Ab4KHBhsdDRh/n1zjscLUnEp87Q6HJTyQhJvVssI7+yhz+rfcWre1brJzi2S2K
	 j1Ms4SLvhEZx1GWELZbPunnkEND6OkBOkGrFNfu3bbcF6O9R9d9ubbr8r2aJ0gutGE
	 iyBlTBLBqOiBVrHvI9GTRFGuYVD8nd9Wr7tzjJLt4JKz03aujz1DATVTy/jqTdFpqv
	 STQgIHG49uAEw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH] PCI/DPC: Request DPC only if also requesting AER
Date: Tue, 20 Feb 2024 17:55:20 -0600
Message-Id: <20240220235520.1514548-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

When booting with "pci=noaer", we don't request control of AER, but we
previously *did* request control of DPC, as in the dmesg log attached at
the bugzilla below:

  Command line: ... pci=noaer
  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
  acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]

That's illegal per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, which
says:

  If the operating system sets this bit [OSC_PCI_EXPRESS_DPC_CONTROL], it
  must also set bit 7 of the Support field (indicating support for Error
  Disconnect Recover notifications) and bits 3 and 4 of the Control field
  (requesting control of PCI Express Advanced Error Reporting and the PCI
  Express Capability Structure).

Request DPC control only if we have also requested AER control.

Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218491#c12
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>	# v5.7+
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Matthew W Carlis <mattc@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/acpi/pci_root.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 58b89b8d950e..1c16965427b3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -518,17 +518,19 @@ static u32 calculate_control(void)
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
 		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 
-	if (pci_aer_available())
+	if (pci_aer_available()) {
 		control |= OSC_PCI_EXPRESS_AER_CONTROL;
 
-	/*
-	 * Per the Downstream Port Containment Related Enhancements ECN to
-	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
-	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
-	 * and EDR.
-	 */
-	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
-		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+		/*
+		 * Per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, the
+		 * OS can request DPC control only if it has advertised
+		 * OSC_PCI_EDR_SUPPORT and requested both
+		 * OSC_PCI_EXPRESS_CAPABILITY_CONTROL and
+		 * OSC_PCI_EXPRESS_AER_CONTROL.
+		 */
+		if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
+			control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+	}
 
 	return control;
 }
-- 
2.34.1


