Return-Path: <linux-pci+bounces-3897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B7860581
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A211C249EF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC513791F;
	Thu, 22 Feb 2024 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO0vpnTK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEC137919;
	Thu, 22 Feb 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640137; cv=none; b=T5w/R/Z0xd5fPfUrbj2ouwz/me18GYbO7QZevjCylOqrbzsFMEmZdi5EFuDx7AimlfsU/2CeNebDFRwoGk4HH3vU/IDs20U9iqhX5/O8F/S3EAqA8mevXUzTrkhcKPO300zi6flIE8FWucYRdkAd3AkL1kWnmxzv/mu1m7Xdfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640137; c=relaxed/simple;
	bh=+MPNAv4j9xziDIGU7n8YhnwXjcPBGJ3afHmStckr/LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeHsm1bR0zfrZTkipX1aIhYAAVgpFHY5pVqGv0LXXnpUQVZnYxZzbTw28dBvb4FVu7ywGH1ThcFvQxf+czIc/mBtVVhVoCTht3bCI3g5vuHGV2nhlKnrJ7DiHdWbw61qay42in6wNxMHqfjtgBlbEZbpDAkcLF1y+tuZAkvyt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO0vpnTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F7C433F1;
	Thu, 22 Feb 2024 22:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708640136;
	bh=+MPNAv4j9xziDIGU7n8YhnwXjcPBGJ3afHmStckr/LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BO0vpnTKrzJhRRACJU7/OJ5jHMKV5z75nlY+Rah3m83VgXiuVB9mkpOwxSFkvnS8o
	 PRSKfTHqDsRTtVNMEtwz+H21sqTRKJxb/D9k4yyomoZbpJhezoGQFy0BE6Z3u5ZYXS
	 wfkhlijVmz/HWdizhD3TJ11pdllQFvUwQl51bQUsPpC41tc813FwFp0/DXO1/F3Mce
	 db/MJ+Rf1NqC8Mz7wcywry7tr3JMy5Ymc1Xe0kKEcOb4K+z/yg8o0KEpM6FYf8ecN0
	 wVQqPB8//tlLyzj/9x86EKYSOZBx1/LHfgnpjsNx3kyFgPSmp4L0nN6njos+xnHLtz
	 S6qL/NTMWlNuw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] PCI/DPC: Request DPC only if also requesting AER
Date: Thu, 22 Feb 2024 16:15:19 -0600
Message-Id: <20240222221521.32159-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222221521.32159-1-helgaas@kernel.org>
References: <20240222221521.32159-1-helgaas@kernel.org>
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
index 58b89b8d950e..efc292b6214e 100644
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
+		if (IS_ENABLED(CONFIG_PCIE_DPC))
+			control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+	}
 
 	return control;
 }
-- 
2.34.1


