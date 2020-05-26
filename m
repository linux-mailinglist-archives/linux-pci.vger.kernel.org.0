Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356FC1E314E
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 23:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbgEZVjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 17:39:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgEZVjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 17:39:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id q2so26370437ljm.10;
        Tue, 26 May 2020 14:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRj4tDj226LXoCqDpfgeWGCOGyN0uiUKx/LO9i4kEaU=;
        b=aQ2U2YuNEu6ho2y0FlgjQi0Et2YUdb0ohwt8myuuMarsY4Pt5qsql3cAixMOYkzknt
         9p00XXPN8/+n8xnrtyBFFzsKPOeYzgOwNhlTORagVQrxeRgA4+VtaGmHouoFCAminJjo
         OUhXLsxHqiodYxmwOTc7Za0U3kQecXX0K7kflJNCthrAqYCoIegvwHwbcvgstPmJIAsc
         2z+y+yktdkuCD6k7r5yhT1xxgGZhyExCLElvjS4pHJz2Gb02a2Eq3j9GF7lxrCcnj9jW
         TadcTgnDSgwlFpFpwfJHoK47pv0Pv38f/PdLymv/3MpnzCUiJJf2+wlAL3ftrVMW0zR/
         +BvA==
X-Gm-Message-State: AOAM53275t911xJWS81Ru5VD1u5TvcmpezAhVDnZMtpqKUg3bUqFMEHx
        b66DtzycS4t0IrT1+5PjPMB9fyIyEMos1Up1
X-Google-Smtp-Source: ABdhPJyE5OHBsrOqcY2LzpzMrxciVg2yq6VIObderbdb6PZJ5mSINBkPvHm1vORx7iC/06htVKvrDA==
X-Received: by 2002:a2e:991a:: with SMTP id v26mr1577489lji.470.1590529147981;
        Tue, 26 May 2020 14:39:07 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d11sm215117lji.85.2020.05.26.14.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:39:07 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] PCI: Rename _DSM constants to align with PCI Firmware specification
Date:   Tue, 26 May 2020 21:39:05 +0000
Message-Id: <20200526213905.2479381-1-kw@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename PCI-related _DSM constants to better align them with the PCI
Firmware specification (see PCI Firmware Specification, Revision 3.2,
Section 4.6., p. 58).  All the constants names should correlate more
strongly with the descriptions in the aforementioned specification to
make them unambiguous.

Additionally, all of the renamed constants will use the DSM_ prefix,
similarly to the PCI _OSC constants that use the OSC_ prefix, to make it
clear what these are.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/acpi/pci_root.c  |  2 +-
 drivers/pci/pci-acpi.c   |  4 ++--
 drivers/pci/pci-label.c  |  4 ++--
 include/linux/pci-acpi.h | 10 ++++++----
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ac8ad6cb82aa..ee4d0bf717fd 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -938,7 +938,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	 * assignments made by firmware for this host bridge.
 	 */
 	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
-	                        IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
+				DSM_PCI_IGNORE_BOOT_CONFIG, NULL);
 	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
 		host_bridge->preserve_config = 1;
 	ACPI_FREE(obj);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d21969fba6ab..a2e9f01434de 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1128,7 +1128,7 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 		return;
 
 	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
-				RESET_DELAY_DSM, NULL);
+				DSM_PCI_POWER_ON_RESET_DELAY, NULL);
 	if (!obj)
 		return;
 
@@ -1193,7 +1193,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 		pdev->d3cold_delay = 0;
 
 	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 3,
-				FUNCTION_DELAY_DSM, NULL);
+				DSM_PCI_DEVICE_READINESS_DURATIONS, NULL);
 	if (!obj)
 		return;
 
diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index a5910f942857..69db1fd10f21 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -178,7 +178,7 @@ static int dsm_get_label(struct device *dev, char *buf,
 		return -1;
 
 	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
-				DEVICE_LABEL_DSM, NULL);
+				DSM_PCI_PCIE_DEVICE_NAME, NULL);
 	if (!obj)
 		return -1;
 
@@ -218,7 +218,7 @@ static bool device_has_dsm(struct device *dev)
 		return false;
 
 	return !!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
-				1 << DEVICE_LABEL_DSM);
+				1 << DSM_PCI_PCIE_DEVICE_NAME);
 }
 
 static umode_t acpi_index_string_exist(struct kobject *kobj,
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 2d155bfb8fbf..21b32fe47607 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -107,10 +107,12 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 #endif
 
 extern const guid_t pci_acpi_dsm_guid;
-#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
-#define DEVICE_LABEL_DSM		0x07
-#define RESET_DELAY_DSM			0x08
-#define FUNCTION_DELAY_DSM		0x09
+
+/* _DSM Definitions for PCI */
+#define DSM_PCI_IGNORE_BOOT_CONFIG		0x05
+#define DSM_PCI_PCIE_DEVICE_NAME		0x07
+#define DSM_PCI_POWER_ON_RESET_DELAY		0x08
+#define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
 
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
-- 
2.26.2

