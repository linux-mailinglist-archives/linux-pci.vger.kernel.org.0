Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90512304E04
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 01:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbhAZXgg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbhAZWEB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 17:04:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1A412065C;
        Tue, 26 Jan 2021 22:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611698601;
        bh=ovcXG3DFzOy85KTaQDZ9xpuTy4A99qEQJncrjnnWKTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b9qvpJ9jYcvD63TvVaiZ6Ttwww765wIZ10dDlS3nDUDSklPBjUlS+/pquqQEdj+2k
         95MEBqpBggCzV/W6b2ObaLohz+yx68SMHFa3cxYjVoNBcD22KECZeWUm2GjHvZPwC2
         h7IZVzZXGuJXeLHWcmhWMIG5htWLq2WiLmkmQLIq8Utf+7RqIrnXeP4WVVqsNXxljr
         qa7CDDbhTutChy+9QOlkaga+mjO9UYc75oSNxm4o7C6O9ETdS9p3BrWGf+0GWXrR8Z
         XEklnETzK9Mj0LihpSECOfcji6psjlJfQwQCu6Nxfw0NJy9Vn/Tl7ypC0iEcrNXDY5
         hUWhfSY7XarcQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI/ACPI: Make acpi_pci_osc_control_set() static
Date:   Tue, 26 Jan 2021 16:03:09 -0600
Message-Id: <20210126220311.2925565-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126220311.2925565-1-helgaas@kernel.org>
References: <20210126220311.2925565-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

acpi_pci_osc_control_set() is only called from pci_root.c, so stop
exporting it and make it static.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c | 3 +--
 include/linux/acpi.h    | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ff7882afeb29..51dec352b8b8 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
  * _OSC bits the BIOS has granted control of, but its contents are meaningless
  * on failure.
  **/
-acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
+static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 {
 	struct acpi_pci_root *root;
 	acpi_status status = AE_OK;
@@ -406,7 +406,6 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 	mutex_unlock(&osc_lock);
 	return status;
 }
-EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 053bf05fb1f7..4703daafcce9 100644
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

