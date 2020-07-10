Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6183121BF4E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGJViJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 17:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJViI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 17:38:08 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC43206C3;
        Fri, 10 Jul 2020 21:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594417088;
        bh=voaw5zogeDEPtBupN3rvnArHqvP6llFW4mbuvf6Xffo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FO8jE0iqjJnkmrLxpkOmyeOfdtp3zUbsvRMLgb3XSfomgPrqbfGlPCKpXP9hqovJm
         sTeQWLOoBXZIXHE8idFbJCWM0WAE+s3cLSd2ctCx8bUWbSESrWlW/phjxxVGyTU5Kr
         UWgw1R+2oVwAOboEIUV0ckMNP62xSPiVbbfSo8yk=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI/ACPI: Unexport acpi_pci_osc_control_set()
Date:   Fri, 10 Jul 2020 16:37:52 -0500
Message-Id: <20200710213753.83420-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710213753.83420-1-helgaas@kernel.org>
References: <20200710213753.83420-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

acpi_pci_osc_control_set() is called only inside pci_root.c and there's no
need for it to be called by modules.  Make it static and unexport it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c | 4 ++--
 include/linux/acpi.h    | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f90e841c59f5..b6da9745efcd 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -355,7 +355,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
  * _OSC bits the BIOS has granted control of, but its contents are meaningless
  * on failure.
  **/
-acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
+static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask,
+					    u32 req)
 {
 	struct acpi_pci_root *root;
 	acpi_status status = AE_OK;
@@ -408,7 +409,6 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 	mutex_unlock(&osc_lock);
 	return status;
 }
-EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d661cd0ee64d..bb20a872729e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -581,9 +581,6 @@ extern bool osc_pc_lpi_support_confirmed;
 #define ACPI_GSB_ACCESS_ATTRIB_RAW_BYTES	0x0000000E
 #define ACPI_GSB_ACCESS_ATTRIB_RAW_PROCESS	0x0000000F
 
-extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
-					     u32 *mask, u32 req);
-
 /* Enable _OST when all relevant hotplug operations are enabled */
 #if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
 	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
-- 
2.25.1

