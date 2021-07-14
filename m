Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F057D3C80BE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhGNI6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbhGNI6O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 04:58:14 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE836C061762;
        Wed, 14 Jul 2021 01:55:21 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de [79.242.177.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id E476B3D0;
        Wed, 14 Jul 2021 10:55:19 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <helgass@kernel.org>
Subject: [PATCH v2 2/2] PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS
Date:   Wed, 14 Jul 2021 10:55:12 +0200
Message-Id: <20210714085512.2176-3-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714085512.2176-1-joro@8bytes.org>
References: <20210714085512.2176-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

These masks are only used internally in the PCI Host Bridge _OSC
negotiation code, which already makes sure nothing outside of these
masks is set. Remove the masks and simplify the code.

Suggested-by: Bjorn Helgaas <helgass@kernel.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/pci_root.c | 4 +---
 include/linux/acpi.h    | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c703832b7f7f..0d147c682929 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -199,9 +199,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 	acpi_status status;
 	u32 result, capbuf[3];
 
-	support &= OSC_PCI_SUPPORT_MASKS;
 	support |= root->osc_support_set;
-	*control &= OSC_PCI_CONTROL_MASKS;
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = support;
@@ -347,7 +345,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32
 	if (!mask)
 		return AE_BAD_PARAMETER;
 
-	ctrl = *mask & OSC_PCI_CONTROL_MASKS;
+	ctrl = *mask;
 	if ((ctrl & req) != req)
 		return AE_TYPE;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 72e4f7fd268c..c6dba5f21384 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -577,7 +577,6 @@ extern u32 osc_sb_native_usb4_control;
 #define OSC_PCI_MSI_SUPPORT			0x00000010
 #define OSC_PCI_EDR_SUPPORT			0x00000080
 #define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
-#define OSC_PCI_SUPPORT_MASKS			0x0000019f
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
@@ -587,7 +586,6 @@ extern u32 osc_sb_native_usb4_control;
 #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
 #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
-#define OSC_PCI_CONTROL_MASKS			0x000000bf
 
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
-- 
2.31.1

