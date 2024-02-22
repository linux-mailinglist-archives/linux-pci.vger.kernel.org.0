Return-Path: <linux-pci+bounces-3899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DB860586
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381981C2453E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241A13BADD;
	Thu, 22 Feb 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocbsyBFE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7513BAD9;
	Thu, 22 Feb 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640140; cv=none; b=mqXpom37QUKT8dStiSfGN2/hmGfeMJ5fo8VECfSIcgGTVxzJWSLnzgs1s7GXDp5qeIVcVop3PRjIXROZ16bStYt/GW45yxQKFXhhIbxNLutQ+gxjfpw2dGDUVPIo8V5ujq2w/+SV8r9YnOA1/NykY3MxMyuZ+0jyctO+VVD6t5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640140; c=relaxed/simple;
	bh=hhEw0qiaiAYkiEH9B0A5irgUskKyCnw76BLLf50VB+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNT2FMx4CpmWQ1pEL/NSGwWU4JUhe0+QDFKUdLymfojy5eDM+K5m0T78R2eYBEoRDB1oyqrf5gAI7YfZEb2ieEO3vUbqN/WH/LtgfqMH2V0J3JHqRu8V+qf8aCUEhurM9Bwdy5FSibIJkkrnlT1NrfQV4Rtkqu0qTcfd6juWJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocbsyBFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0107DC43394;
	Thu, 22 Feb 2024 22:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708640140;
	bh=hhEw0qiaiAYkiEH9B0A5irgUskKyCnw76BLLf50VB+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocbsyBFETCqICZl+rLoPCOLZarNPdHIPeSe5/DanR0suSE7dBzbun6UTv6mTaHMNB
	 QJK1kedCyyHc9ls/oSv6LNUPHFCtMUetX0QF45quWxmYJWQDCzmu2iOhEUMnKisPqr
	 aedpNd2xLasUeBScB8VsYke6iisaEGKeXgnO3/YjDrk4GbAQ1FGKLZZjQuvZfQi4tb
	 0mKuomPEzKK91AElsAm/kuvsmkb9HdJoQicZRL+1kfwxIbh1WkdSjrB7UwFU4/YdWb
	 hdm3TgbINREcLvfvVcK7A86h6YedloY/tMAtrR6ZS67o1olUFA7psOkfLmmjtKTyfg
	 rKOqCy5ezvrLw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/3] PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
Date: Thu, 22 Feb 2024 16:15:21 -0600
Message-Id: <20240222221521.32159-4-helgaas@kernel.org>
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

pci_acpi_add_edr_notifier() and pci_acpi_remove_edr_notifier() are only
referenced inside drivers/pci/.  Move their declarations from
include/linux/pci-acpi.h to drivers/pci/pci.h so they're not visible
outside drivers/pci/.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h        | 4 ++++
 include/linux/pci-acpi.h | 8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab..03bf2776d73b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -432,11 +432,15 @@ void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
+void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
+void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
+static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
+static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 92e196ba0249..f447ce215adf 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -122,14 +122,6 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
 
-#ifdef CONFIG_PCIE_DPC
-void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
-void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
-#else
-static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
-static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
-#endif /* CONFIG_PCIE_DPC */
-
 int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
 void pci_acpi_clear_companion_lookup_hook(void);
 
-- 
2.34.1


