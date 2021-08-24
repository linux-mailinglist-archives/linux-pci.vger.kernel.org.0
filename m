Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF283F5DDC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhHXMVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 08:21:48 -0400
Received: from 8bytes.org ([81.169.241.247]:40902 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236676AbhHXMVr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 08:21:47 -0400
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de [79.242.177.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 73781898;
        Tue, 24 Aug 2021 14:21:00 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH v3 3/4] PCI/ACPI: Move _OSC query checks to separate function
Date:   Tue, 24 Aug 2021 14:20:53 +0200
Message-Id: <20210824122054.29481-4-joro@8bytes.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824122054.29481-1-joro@8bytes.org>
References: <20210824122054.29481-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Move the checks about whether the _OSC controls are requested from the
firmware to a separate function.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/pci_root.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ed4e6b55e9bc..f12e512bcddc 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -449,6 +449,24 @@ static u32 calculate_control(void)
 	return control;
 }
 
+static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
+{
+	struct acpi_device *device = root->device;
+
+	if (pcie_ports_disabled) {
+		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
+		return false;
+	}
+
+	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
+		decode_osc_support(root, "not requesting OS control; OS requires",
+				   ACPI_PCIE_REQ_SUPPORT);
+		return false;
+	}
+
+	return true;
+}
+
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
 {
@@ -485,16 +503,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
-	if (pcie_ports_disabled) {
-		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
+	if (!os_control_query_checks(root, support))
 		return;
-	}
-
-	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
-		decode_osc_support(root, "not requesting OS control; OS requires",
-				   ACPI_PCIE_REQ_SUPPORT);
-		return;
-	}
 
 	requested = control = calculate_control();
 
-- 
2.32.0

