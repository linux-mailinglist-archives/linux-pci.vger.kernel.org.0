Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BC10F3F3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 01:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLCAlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 19:41:00 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:33280 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLCAk7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2019 19:40:59 -0500
Received: by mail-qt1-f202.google.com with SMTP id l25so1241434qtu.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2019 16:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cweK0cFHCK4yx0cTGNuyeGTbb9cMk/2TpbmrW6OL2sw=;
        b=W0qq15I9A33Pt5mZvrv6dJdSPB6iojbWP8Zax5IPxgmEOG1ort9oMIgJQQf1QX/8Qv
         PjNN1225YdINRa2bTwJyPiTK8dP7lmFuNK7qJEW5qc/bihVlCdgMFREPILWnKXpA8Csx
         OZzyDH2Arves+rRlklEqKICnNZ3UEIwnO4CSQ83J8pMmY9tBHTVXrBKBPhlNPxDqm+Se
         GwqosI8eYXvJ5JebLNcY0/PGfJ6nzTEMceiNf+Idy4up37MKByfWhHR4k3eS4YE97tr6
         FBEIhiLaI8oriKqO8LvaGle6/aZI4gbpS52PxeGEc2aMzKgqViA4/NuFlBBgPTX7rZ4F
         GnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cweK0cFHCK4yx0cTGNuyeGTbb9cMk/2TpbmrW6OL2sw=;
        b=jahxtv44U8d4/F+ZlYTtf2xbmFsfkMUFXPEZyWkaUtRFJjbl1Tm+glWwQqpJEXtDjF
         Sw6+FPoBlGpIaskCJJ2JN+o9Jt8GxlK7Vivd7cEAM4FNwk30v7jEa8g/Z78/5QzyE0/K
         ffXH9Nk2PfjAvj5LPmPGyX1pkwyhjPLY7gc6sZUxmOUqM9s6EnebhlfbJRuWV58Kb1QK
         nwFq2ihv1lu2tTA0GuuymlwmMYP91DA4Hi2i5PDJytXJiW8V4sREWWRybxHX2OehFEIy
         9ltZsN5zk4pzQthgFM2cBmJ8OIir/UlGAsOPgBBAvLa3cmvBZs7hyfGiEUJr5wObtT78
         i11g==
X-Gm-Message-State: APjAAAUYR80mlpPNp7+wd8eiz1uwcAQ6NkCwEcinbW7HLbhLRIC3+ZVE
        +DnBmPKaiPOKtAHKgH4aCZnpYoztPJGvRTrJXN24+A==
X-Google-Smtp-Source: APXvYqzJ/iOyZ3XPZdQoev6FW/o7vVmLPZdrpFojAKHBDC43lOmRb7fvsN2exWdsjplWuRxxks00U7YnmChdHLWUF3bJbg==
X-Received: by 2002:aed:3344:: with SMTP id u62mr2536933qtd.73.1575333658016;
 Mon, 02 Dec 2019 16:40:58 -0800 (PST)
Date:   Mon,  2 Dec 2019 16:40:43 -0800
Message-Id: <20191203004043.174977-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges during boot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-efi@vger.kernel.org
Cc:     ard.biesheuvel@linaro.org, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add an option to disable the busmaster bit in the control register on
all PCI bridges before calling ExitBootServices() and passing control to
the runtime kernel. System firmware may configure the IOMMU to prevent
malicious PCI devices from being able to attack the OS via DMA. However,
since firmware can't guarantee that the OS is IOMMU-aware, it will tear
down IOMMU configuration when ExitBootServices() is called. This leaves
a window between where a hostile device could still cause damage before
Linux configures the IOMMU again.

If CONFIG_EFI_NO_BUSMASTER is enabled or the "disable_busmaster=1"
commandline argument is passed, the EFI stub will clear the busmaster
bit on all PCI bridges before ExitBootServices() is called. This will
prevent any malicious PCI devices from being able to perform DMA until
the kernel reenables busmastering after configuring the IOMMU.

This option will cause failures with some poorly behaved hardware and
should not be enabled without testing. The kernel commandline option
"disable_busmaster=0" or "disable_busmaster=1" may be used to override
the default.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 arch/x86/boot/compressed/eboot.c              |  2 +
 drivers/firmware/efi/Kconfig                  | 23 +++++
 drivers/firmware/efi/libstub/Makefile         |  2 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 19 ++++
 drivers/firmware/efi/libstub/efistub.h        |  1 +
 drivers/firmware/efi/libstub/pci.c            | 88 +++++++++++++++++++
 include/linux/efi.h                           |  2 +
 8 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/libstub/pci.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8dee8f68fe15..2d538f27f861 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -881,6 +881,11 @@
 			The feature only exists starting from
 			Arch Perfmon v4 (Skylake and newer).
 
+	disable_busmaster= [X86, EFI]
+			Format: <int>
+			Disable the busmaster bit on all PCI bridges in the
+			EFI boot stub if 1, leave in the default state if 0.
+
 	disable_ddw	[PPC/PSERIES]
 			Disable Dynamic DMA Window support. Use this if
 			to workaround buggy firmware.
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 82bc60c8acb2..2f5226b32a6e 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -137,6 +137,8 @@ static void setup_efi_pci(struct boot_params *params)
 	struct setup_data *data;
 	int i;
 
+	efi_pci_disable_bridge_busmaster(sys_table);
+
 	status = efi_call_early(locate_handle,
 				EFI_LOCATE_BY_PROTOCOL,
 				&pci_proto, NULL, &size, pci_handle);
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index b248870a9806..b1651b40424e 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -194,6 +194,29 @@ config EFI_RCI2_TABLE
 
 	  Say Y here for Dell EMC PowerEdge systems.
 
+config EFI_NO_BUSMASTER
+       bool "Clear Busmaster bit on PCI bridges before ExitBootServices()"
+       depends on X86 || COMPILE_TEST
+       help
+	  Disable the busmaster bit in the control register on all PCI bridges
+	  before calling ExitBootServices() and passing control to the runtime
+	  kernel. System firmware may configure the IOMMU to prevent malicious
+	  PCI devices from being able to attack the OS via DMA. However, since
+	  firmware can't guarantee that the OS is IOMMU-aware, it will tear
+	  down IOMMU configuration when ExitBootServices() is called. This
+	  leaves a window between where a hostile device could still cause
+	  damage before Linux configures the IOMMU again.
+
+	  If you say Y here, the EFI stub will clear the busmaster bit on all
+	  PCI bridges before ExitBootServices() is called. This will prevent
+	  any malicious PCI devices from being able to perform DMA until the
+	  kernel reenables busmastering after configuring the IOMMU.
+
+	  This option will cause failures with some poorly behaved hardware
+	  and should not be enabled without testing. The kernel commandline
+	  option "disable_busmaster=0" or "disable_busmaster=1" may be used
+	  to override this option.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ee0661ddb25b..6536ee851334 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -38,7 +38,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT			:= n
 
-lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o
+lib-y				:= efi-stub-helper.o gop.o pci.o secureboot.o tpm.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 35dbc2791c97..69faeeba1cdb 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -32,6 +32,8 @@ static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
 static int __section(.data) __nokaslr;
 static int __section(.data) __quiet;
 static int __section(.data) __novamap;
+static int __section(.data) __disable_busmaster =
+	IS_ENABLED(CONFIG_EFI_NO_BUSMASTER);
 
 int __pure nokaslr(void)
 {
@@ -46,6 +48,11 @@ int __pure novamap(void)
 	return __novamap;
 }
 
+int __pure nobusmaster(void)
+{
+	return __disable_busmaster;
+}
+
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
 struct file_info {
@@ -458,6 +465,18 @@ efi_status_t efi_parse_options(char const *cmdline)
 	if (str == cmdline || (str && str > cmdline && *(str - 1) == ' '))
 		__quiet = 1;
 
+	str = strstr(cmdline, "disable_busmaster=");
+	if (str) {
+		switch (*(str + strlen("disable_busmaster="))) {
+		case '0':
+			__disable_busmaster = 0;
+			break;
+		case '1':
+			__disable_busmaster = 1;
+			break;
+		}
+	}
+
 	/*
 	 * If no EFI parameters were specified on the cmdline we've got
 	 * nothing to do.
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 7f1556fd867d..12f5f80f6851 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -28,6 +28,7 @@
 extern int __pure nokaslr(void);
 extern int __pure is_quiet(void);
 extern int __pure novamap(void);
+extern int __pure nobusmaster(void);
 
 #define pr_efi(sys_table, msg)		do {				\
 	if (!is_quiet()) efi_printk(sys_table, "EFI stub: "msg);	\
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
new file mode 100644
index 000000000000..dc0db8a1e248
--- /dev/null
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI-related functions used by the EFI stub on multiple
+ * architectures.
+ *
+ * Copyright 2019 Google, LLC
+ */
+
+#include <linux/efi.h>
+#include <linux/pci.h>
+
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+void efi_pci_disable_bridge_busmaster(efi_system_table_t *sys_table)
+{
+	efi_status_t status;
+	void **pci_handle = NULL;
+	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
+	unsigned long size = 0;
+	unsigned long nr_pci;
+	u16 class, command;
+	int i;
+
+	if (!nobusmaster())
+		return;
+
+	status = efi_call_early(locate_handle,
+				EFI_LOCATE_BY_PROTOCOL,
+				&pci_proto, NULL, &size, pci_handle);
+
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		status = efi_call_early(allocate_pool,
+					EFI_LOADER_DATA,
+					size, (void **)&pci_handle);
+
+		if (status != EFI_SUCCESS) {
+			efi_printk(sys_table, "Failed to allocate memory for 'pci_handle'\n");
+			return;
+		}
+
+		status = efi_call_early(locate_handle,
+					EFI_LOCATE_BY_PROTOCOL, &pci_proto,
+					NULL, &size, pci_handle);
+	}
+
+	if (status != EFI_SUCCESS)
+		goto free_handle;
+
+	nr_pci = size / (efi_is_64bit() ? sizeof(u64) : sizeof(u32));
+	for (i = 0; i < nr_pci; i++) {
+		efi_pci_io_protocol_t *pci = NULL;
+
+		status = efi_call_early(handle_protocol,
+					efi_is_64bit() ? ((u64 *)pci_handle)[i]
+						       : ((u32 *)pci_handle)[i],
+					&pci_proto, (void **)&pci);
+		if (status != EFI_SUCCESS || !pci)
+			continue;
+
+		status = efi_call_proto(efi_pci_io_protocol, pci.read, pci,
+					EfiPciIoWidthUint16, PCI_CLASS_DEVICE,
+					1, &class);
+
+		if (status != EFI_SUCCESS || class != PCI_CLASS_BRIDGE_PCI)
+			continue;
+
+		/* Disable busmastering */
+		status = efi_call_proto(efi_pci_io_protocol, pci.read, pci,
+					EfiPciIoWidthUint16, PCI_COMMAND, 1,
+					&command);
+		if (status != EFI_SUCCESS ||
+		    !(command & PCI_COMMAND_MASTER))
+			continue;
+
+		command &= ~PCI_COMMAND_MASTER;
+		status = efi_call_proto(efi_pci_io_protocol, pci.write, pci,
+					EfiPciIoWidthUint16, PCI_COMMAND, 1,
+					&command);
+		if (status != EFI_SUCCESS)
+			efi_printk(sys_table,
+				   "Failed to disable PCI busmastering\n");
+	}
+
+free_handle:
+	efi_call_early(free_pool, pci_handle);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d87acf62958e..b0de9b4a0ad1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1647,6 +1647,8 @@ efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg) { }
 
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
 
+void efi_pci_disable_bridge_busmaster(efi_system_table_t *sys_table);
+
 /*
  * Arch code can implement the following three template macros, avoiding
  * reptition for the void/non-void return cases of {__,}efi_call_virt():
-- 
2.24.0.393.g34dc348eaf-goog

