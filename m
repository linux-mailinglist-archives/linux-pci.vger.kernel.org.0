Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C460318C7F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhBKNqe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:46:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:57923 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232020AbhBKNnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:43:05 -0500
IronPort-SDR: 6MuKtdTkL4iCp2AepFWrOPKULnnugdS2zQMLcUkjU1RhkYgs53O63zY3r7HZE99n+hR71UqLnQ
 GDZTNMAEef4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="267081096"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="267081096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:40:56 -0800
IronPort-SDR: 6Z6y9wCvU5G8fejaBU0qZokf+V/hZ97RTZw7EOWDdtPrsX9oOairOlKzrBjUDxzQ95C6qDyshJ
 jGHEkrLpzxjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="422265685"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2021 05:40:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F11062BE; Thu, 11 Feb 2021 15:40:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v1 3/9] sfi: Remove framework for deprecated firmware
Date:   Thu, 11 Feb 2021 15:40:02 +0200
Message-Id: <20210211134008.38282-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SFI-based platforms are gone. So does this framework.

This removes mention of SFI through the drivers and other code as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/ABI/testing/sysfs-firmware-sfi  |  15 -
 Documentation/ABI/testing/sysfs-platform-kim  |   2 +-
 MAINTAINERS                                   |   7 -
 arch/x86/Kconfig                              |   7 +-
 arch/x86/include/asm/intel-mid.h              |  37 --
 arch/x86/include/asm/intel_scu_ipc_legacy.h   |  58 +-
 arch/x86/include/asm/platform_sst_audio.h     |   2 -
 arch/x86/kernel/apic/io_apic.c                |   4 +-
 arch/x86/kernel/setup.c                       |   2 -
 arch/x86/pci/mmconfig-shared.c                |   6 +-
 arch/x86/platform/Makefile                    |   1 -
 arch/x86/platform/intel-mid/Makefile          |   5 -
 .../platform/intel-mid/device_libs/Makefile   |  23 -
 .../intel-mid/device_libs/platform_bcm43xx.c  | 101 ----
 .../intel-mid/device_libs/platform_bma023.c   |  16 -
 .../intel-mid/device_libs/platform_bt.c       | 101 ----
 .../intel-mid/device_libs/platform_emc1403.c  |  39 --
 .../device_libs/platform_gpio_keys.c          |  81 ---
 .../intel-mid/device_libs/platform_lis331.c   |  37 --
 .../intel-mid/device_libs/platform_max7315.c  |  77 ---
 .../intel-mid/device_libs/platform_mpu3050.c  |  32 --
 .../device_libs/platform_mrfld_pinctrl.c      |  39 --
 .../device_libs/platform_mrfld_rtc.c          |  44 --
 .../intel-mid/device_libs/platform_mrfld_sd.c |  43 --
 .../device_libs/platform_mrfld_spidev.c       |  50 --
 .../device_libs/platform_pcal9555a.c          |  95 ----
 .../intel-mid/device_libs/platform_tc35876x.c |  42 --
 .../intel-mid/device_libs/platform_tca6416.c  |  53 --
 arch/x86/platform/intel-mid/intel-mid.c       |   1 -
 arch/x86/platform/intel-mid/sfi.c             | 419 --------------
 arch/x86/platform/sfi/Makefile                |   2 -
 arch/x86/platform/sfi/sfi.c                   | 100 ----
 drivers/Makefile                              |   2 +-
 drivers/platform/x86/intel_scu_pcidrv.c       |  22 +-
 drivers/sfi/Kconfig                           |  18 -
 drivers/sfi/Makefile                          |   4 -
 drivers/sfi/sfi_acpi.c                        | 214 -------
 drivers/sfi/sfi_core.c                        | 522 ------------------
 drivers/sfi/sfi_core.h                        |  81 ---
 include/linux/sfi.h                           | 210 -------
 include/linux/sfi_acpi.h                      |  93 ----
 init/main.c                                   |   2 -
 42 files changed, 14 insertions(+), 2695 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-firmware-sfi
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/Makefile
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bma023.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bt.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_emc1403.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_lis331.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_max7315.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mpu3050.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_pinctrl.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_rtc.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_sd.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_spidev.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_pcal9555a.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_tca6416.c
 delete mode 100644 arch/x86/platform/intel-mid/sfi.c
 delete mode 100644 arch/x86/platform/sfi/Makefile
 delete mode 100644 arch/x86/platform/sfi/sfi.c
 delete mode 100644 drivers/sfi/Kconfig
 delete mode 100644 drivers/sfi/Makefile
 delete mode 100644 drivers/sfi/sfi_acpi.c
 delete mode 100644 drivers/sfi/sfi_core.c
 delete mode 100644 drivers/sfi/sfi_core.h
 delete mode 100644 include/linux/sfi.h
 delete mode 100644 include/linux/sfi_acpi.h

diff --git a/Documentation/ABI/testing/sysfs-firmware-sfi b/Documentation/ABI/testing/sysfs-firmware-sfi
deleted file mode 100644
index 5210e0f06ddb..000000000000
--- a/Documentation/ABI/testing/sysfs-firmware-sfi
+++ /dev/null
@@ -1,15 +0,0 @@
-What:		/sys/firmware/sfi/tables/
-Date:		May 2010
-Contact:	Len Brown <lenb@kernel.org>
-Description:
-		SFI defines a number of small static memory tables
-		so the kernel can get platform information from firmware.
-
-		The tables are defined in the latest SFI specification:
-		http://simplefirmware.org/documentation
-
-		While the tables are used by the kernel, user-space
-		can observe them this way::
-
-		  # cd /sys/firmware/sfi/tables
-		  # cat $TABLENAME > $TABLENAME.bin
diff --git a/Documentation/ABI/testing/sysfs-platform-kim b/Documentation/ABI/testing/sysfs-platform-kim
index a7f81de68046..6a52d6d2b601 100644
--- a/Documentation/ABI/testing/sysfs-platform-kim
+++ b/Documentation/ABI/testing/sysfs-platform-kim
@@ -7,7 +7,7 @@ Description:
 		is connected. example: "/dev/ttyS0".
 
 		The device name flows down to architecture specific board
-		initialization file from the SFI/ATAGS bootloader
+		initialization file from the ATAGS bootloader
 		firmware. The name exposed is read from the user-space
 		dameon and opens the device when install is requested.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 420693499bd9..918f60218390 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16233,13 +16233,6 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
-SIMPLE FIRMWARE INTERFACE (SFI)
-S:	Obsolete
-W:	http://simplefirmware.org/
-F:	arch/x86/platform/sfi/
-F:	drivers/sfi/
-F:	include/linux/sfi*.h
-
 SIMPLEFB FB DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-fbdev@vger.kernel.org
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66539749ff43..4f50afe4acab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -443,7 +443,7 @@ config X86_X2APIC
 	  If you don't know what to do here, say N.
 
 config X86_MPPARSE
-	bool "Enable MPS table" if ACPI || SFI
+	bool "Enable MPS table" if ACPI
 	default y
 	depends on X86_LOCAL_APIC
 	help
@@ -602,7 +602,6 @@ config X86_INTEL_MID
 	depends on PCI
 	depends on X86_64 || (PCI_GOANY && X86_32)
 	depends on X86_IO_APIC
-	select SFI
 	select I2C
 	select DW_APB_TIMER
 	select APB_TIMER
@@ -2456,8 +2455,6 @@ source "kernel/power/Kconfig"
 
 source "drivers/acpi/Kconfig"
 
-source "drivers/sfi/Kconfig"
-
 config X86_APM_BOOT
 	def_bool y
 	depends on APM
@@ -2644,7 +2641,7 @@ config PCI_DIRECT
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access" if X86_64
 	default y
-	depends on PCI && (ACPI || SFI || JAILHOUSE_GUEST)
+	depends on PCI && (ACPI || JAILHOUSE_GUEST)
 	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
 
 config PCI_OLPC
diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 7bda0587cf70..6306fe3e5c4a 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -7,7 +7,6 @@
 #ifndef _ASM_X86_INTEL_MID_H
 #define _ASM_X86_INTEL_MID_H
 
-#include <linux/sfi.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
@@ -22,39 +21,6 @@ extern void intel_mid_pwr_power_off(void);
 
 extern int intel_mid_pwr_get_lss_id(struct pci_dev *pdev);
 
-extern int get_gpio_by_name(const char *name);
-
-/*
- * Here defines the array of devices platform data that IAFW would export
- * through SFI "DEVS" table, we use name and type to match the device and
- * its platform data.
- */
-struct devs_id {
-	char name[SFI_NAME_LEN + 1];
-	u8 type;
-	u8 delay;
-	void *(*get_platform_data)(void *info);
-};
-
-#define sfi_device(i)								\
-	static const struct devs_id *const __intel_mid_sfi_##i##_dev __used	\
-	__section(".x86_intel_mid_dev.init") = &i
-
-/**
-* struct mid_sd_board_info - template for SD device creation
-* @name:		identifies the driver
-* @bus_num:		board-specific identifier for a given SD controller
-* @max_clk:		the maximum frequency device supports
-* @platform_data:	the particular data stored there is driver-specific
-*/
-struct mid_sd_board_info {
-	char		name[SFI_NAME_LEN];
-	int		bus_num;
-	unsigned short	addr;
-	u32		max_clk;
-	void		*platform_data;
-};
-
 /*
  * Medfield is the follow-up of Moorestown, it combines two chip solution into
  * one. Other than that it also added always-on and constant tsc and lapic
@@ -99,7 +65,4 @@ static inline void intel_scu_devices_destroy(void) { }
 /* FSB 83MHz */
 #define BSEL_SOC_FUSE_111		0x7
 
-/* The offset for the mapping of global gpio pin to irq */
-#define INTEL_MID_IRQ_OFFSET		0x100
-
 #endif /* _ASM_X86_INTEL_MID_H */
diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
index f8b87d8face7..fa529e5ec142 100644
--- a/arch/x86/include/asm/intel_scu_ipc_legacy.h
+++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
@@ -2,73 +2,17 @@
 #ifndef _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
 #define _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
 
-#include <linux/notifier.h>
-
-#define IPCMSG_INDIRECT_READ	0x02
-#define IPCMSG_INDIRECT_WRITE	0x05
+#include <linux/types.h>
 
 #define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
-
-#define IPCMSG_WARM_RESET	0xF0
 #define IPCMSG_COLD_RESET	0xF1
-#define IPCMSG_SOFT_RESET	0xF2
-#define IPCMSG_COLD_BOOT	0xF3
 
 /* Don't call these in new code - they will be removed eventually */
 
-/* Read a vector */
-static inline int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
-{
-	return intel_scu_ipc_dev_readv(NULL, addr, data, len);
-}
-
-/* Write a vector */
-static inline int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
-{
-	return intel_scu_ipc_dev_writev(NULL, addr, data, len);
-}
-
-/* Update single register based on the mask */
-static inline int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask)
-{
-	return intel_scu_ipc_dev_update(NULL, addr, data, mask);
-}
-
 /* Issue commands to the SCU with or without data */
 static inline int intel_scu_ipc_simple_command(int cmd, int sub)
 {
 	return intel_scu_ipc_dev_simple_command(NULL, cmd, sub);
 }
 
-static inline int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
-					u32 *out, int outlen)
-{
-	/* New API takes both inlen and outlen as bytes so convert here */
-	size_t inbytes = inlen * sizeof(u32);
-	size_t outbytes = outlen * sizeof(u32);
-
-	return intel_scu_ipc_dev_command_with_size(NULL, cmd, sub, in, inbytes,
-						   inlen, out, outbytes);
-}
-
-extern struct blocking_notifier_head intel_scu_notifier;
-
-static inline void intel_scu_notifier_add(struct notifier_block *nb)
-{
-	blocking_notifier_chain_register(&intel_scu_notifier, nb);
-}
-
-static inline void intel_scu_notifier_remove(struct notifier_block *nb)
-{
-	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
-}
-
-static inline int intel_scu_notifier_post(unsigned long v, void *p)
-{
-	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
-}
-
-#define		SCU_AVAILABLE		1
-#define		SCU_DOWN		2
-
 #endif
diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index 16b9f220bdeb..40f92270515b 100644
--- a/arch/x86/include/asm/platform_sst_audio.h
+++ b/arch/x86/include/asm/platform_sst_audio.h
@@ -10,8 +10,6 @@
 #ifndef _PLATFORM_SST_AUDIO_H_
 #define _PLATFORM_SST_AUDIO_H_
 
-#include <linux/sfi.h>
-
 #define MAX_NUM_STREAMS_MRFLD	25
 #define MAX_NUM_STREAMS	MAX_NUM_STREAMS_MRFLD
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index e4ab4804b20d..c3b60c37c728 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -198,7 +198,7 @@ static int __init parse_noapic(char *str)
 }
 early_param("noapic", parse_noapic);
 
-/* Will be called in mpparse/acpi/sfi codes for saving IRQ info */
+/* Will be called in mpparse/ACPI codes for saving IRQ info */
 void mp_save_irq(struct mpc_intsrc *m)
 {
 	int i;
@@ -2863,7 +2863,7 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
 
 	/*
 	 * If mp_register_ioapic() is called during early boot stage when
-	 * walking ACPI/SFI/DT tables, it's too early to create irqdomain,
+	 * walking ACPI/DT tables, it's too early to create irqdomain,
 	 * we are still using bootmem allocator. So delay it to setup_IO_APIC().
 	 */
 	if (hotplug) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 740f3bdb3f61..d883176ef2ce 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -16,7 +16,6 @@
 #include <linux/memblock.h>
 #include <linux/pci.h>
 #include <linux/root_dev.h>
-#include <linux/sfi.h>
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
@@ -1185,7 +1184,6 @@ void __init setup_arch(char **cmdline_p)
 	 * Read APIC and some other early information from ACPI tables.
 	 */
 	acpi_boot_init();
-	sfi_init();
 	x86_dtb_init();
 
 	/*
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 234998f196d4..de6bf0e7e8f8 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -11,9 +11,9 @@
  * themselves.
  */
 
+#include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/sfi_acpi.h>
 #include <linux/bitmap.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
@@ -665,7 +665,7 @@ void __init pci_mmcfg_early_init(void)
 		if (pci_mmcfg_check_hostbridge())
 			known_bridge = 1;
 		else
-			acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+			acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
 		__pci_mmcfg_init(1);
 
 		set_apei_filter();
@@ -683,7 +683,7 @@ void __init pci_mmcfg_late_init(void)
 
 	/* MMCONFIG hasn't been enabled yet, try again */
 	if (pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF) {
-		acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+		acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
 		__pci_mmcfg_init(0);
 	}
 }
diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
index b2f90a1a89f1..3ed03a2552d0 100644
--- a/arch/x86/platform/Makefile
+++ b/arch/x86/platform/Makefile
@@ -10,6 +10,5 @@ obj-y	+= intel-mid/
 obj-y	+= intel-quark/
 obj-y	+= olpc/
 obj-y	+= scx200/
-obj-y	+= sfi/
 obj-y	+= ts5500/
 obj-y	+= uv/
diff --git a/arch/x86/platform/intel-mid/Makefile b/arch/x86/platform/intel-mid/Makefile
index 5794e661050c..ddfc08783fb8 100644
--- a/arch/x86/platform/intel-mid/Makefile
+++ b/arch/x86/platform/intel-mid/Makefile
@@ -1,7 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_X86_INTEL_MID) += intel-mid.o pwr.o
-
-# SFI specific code
-ifdef CONFIG_X86_INTEL_MID
-obj-$(CONFIG_SFI) += sfi.o device_libs/
-endif
diff --git a/arch/x86/platform/intel-mid/device_libs/Makefile b/arch/x86/platform/intel-mid/device_libs/Makefile
deleted file mode 100644
index 4d008b053ac8..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/Makefile
+++ /dev/null
@@ -1,23 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Family-Level Interface Shim (FLIS)
-obj-$(subst m,y,$(CONFIG_PINCTRL_MERRIFIELD)) += platform_mrfld_pinctrl.o
-# SDHCI Devices
-obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI)) += platform_mrfld_sd.o
-# WiFi + BT
-obj-$(subst m,y,$(CONFIG_BRCMFMAC_SDIO)) += platform_bcm43xx.o
-obj-$(subst m,y,$(CONFIG_BT_HCIUART_BCM)) += platform_bt.o
-# SPI Devices
-obj-$(subst m,y,$(CONFIG_SPI_SPIDEV)) += platform_mrfld_spidev.o
-# I2C Devices
-obj-$(subst m,y,$(CONFIG_SENSORS_EMC1403)) += platform_emc1403.o
-obj-$(subst m,y,$(CONFIG_SENSORS_LIS3LV02D)) += platform_lis331.o
-obj-$(subst m,y,$(CONFIG_MPU3050_I2C)) += platform_mpu3050.o
-obj-$(subst m,y,$(CONFIG_INPUT_BMA150)) += platform_bma023.o
-obj-$(subst m,y,$(CONFIG_DRM_MEDFIELD)) += platform_tc35876x.o
-# I2C GPIO Expanders
-obj-$(subst m,y,$(CONFIG_GPIO_PCA953X)) += platform_max7315.o
-obj-$(subst m,y,$(CONFIG_GPIO_PCA953X)) += platform_pcal9555a.o
-obj-$(subst m,y,$(CONFIG_GPIO_PCA953X)) += platform_tca6416.o
-# MISC Devices
-obj-$(subst m,y,$(CONFIG_KEYBOARD_GPIO)) += platform_gpio_keys.o
-obj-$(subst m,y,$(CONFIG_RTC_DRV_CMOS)) += platform_mrfld_rtc.o
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c b/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
deleted file mode 100644
index 564c47c53f3a..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_bcm43xx.c: bcm43xx platform data initialization file
- *
- * (C) Copyright 2016 Intel Corporation
- * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- */
-
-#include <linux/gpio/machine.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/fixed.h>
-#include <linux/sfi.h>
-
-#include <asm/intel-mid.h>
-
-#define WLAN_SFI_GPIO_IRQ_NAME		"WLAN-interrupt"
-#define WLAN_SFI_GPIO_ENABLE_NAME	"WLAN-enable"
-
-#define WLAN_DEV_NAME			"0000:00:01.3"
-
-static struct regulator_consumer_supply bcm43xx_vmmc_supply = {
-	.dev_name		= WLAN_DEV_NAME,
-	.supply			= "vmmc",
-};
-
-static struct regulator_init_data bcm43xx_vmmc_data = {
-	.constraints = {
-		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &bcm43xx_vmmc_supply,
-};
-
-static struct fixed_voltage_config bcm43xx_vmmc = {
-	.supply_name		= "bcm43xx-vmmc-regulator",
-	/*
-	 * Announce 2.0V here to be compatible with SDIO specification. The
-	 * real voltage and signaling are still 1.8V.
-	 */
-	.microvolts		= 2000000,		/* 1.8V */
-	.startup_delay		= 250 * 1000,		/* 250ms */
-	.enabled_at_boot	= 0,			/* disabled at boot */
-	.init_data		= &bcm43xx_vmmc_data,
-};
-
-static struct platform_device bcm43xx_vmmc_regulator = {
-	.name		= "reg-fixed-voltage",
-	.id		= PLATFORM_DEVID_AUTO,
-	.dev = {
-		.platform_data	= &bcm43xx_vmmc,
-	},
-};
-
-static struct gpiod_lookup_table bcm43xx_vmmc_gpio_table = {
-	.dev_id	= "reg-fixed-voltage.0",
-	.table	= {
-		GPIO_LOOKUP("0000:00:0c.0", -1, NULL, GPIO_ACTIVE_LOW),
-		{}
-	},
-};
-
-static int __init bcm43xx_regulator_register(void)
-{
-	struct gpiod_lookup_table *table = &bcm43xx_vmmc_gpio_table;
-	struct gpiod_lookup *lookup = table->table;
-	int ret;
-
-	lookup[0].chip_hwnum = get_gpio_by_name(WLAN_SFI_GPIO_ENABLE_NAME);
-	gpiod_add_lookup_table(table);
-
-	ret = platform_device_register(&bcm43xx_vmmc_regulator);
-	if (ret) {
-		pr_err("%s: vmmc regulator register failed\n", __func__);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void __init *bcm43xx_platform_data(void *info)
-{
-	int ret;
-
-	ret = bcm43xx_regulator_register();
-	if (ret)
-		return NULL;
-
-	pr_info("Using generic wifi platform data\n");
-
-	/* For now it's empty */
-	return NULL;
-}
-
-static const struct devs_id bcm43xx_clk_vmmc_dev_id __initconst = {
-	.name			= "bcm43xx_clk_vmmc",
-	.type			= SFI_DEV_TYPE_SD,
-	.get_platform_data	= &bcm43xx_platform_data,
-};
-
-sfi_device(bcm43xx_clk_vmmc_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bma023.c b/arch/x86/platform/intel-mid/device_libs/platform_bma023.c
deleted file mode 100644
index 32912a17f68e..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_bma023.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_bma023.c: bma023 platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- */
-
-#include <asm/intel-mid.h>
-
-static const struct devs_id bma023_dev_id __initconst = {
-	.name = "bma023",
-	.type = SFI_DEV_TYPE_I2C,
-	.delay = 1,
-};
-
-sfi_device(bma023_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bt.c b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
deleted file mode 100644
index 2930b6e9473e..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_bt.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Bluetooth platform data initialization file
- *
- * (C) Copyright 2017 Intel Corporation
- * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- */
-
-#include <linux/gpio/machine.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
-#include <asm/intel-mid.h>
-
-struct bt_sfi_data {
-	struct device *dev;
-	const char *name;
-	int (*setup)(struct bt_sfi_data *ddata);
-};
-
-static struct gpiod_lookup_table tng_bt_sfi_gpio_table = {
-	.dev_id	= "hci_bcm",
-	.table	= {
-		GPIO_LOOKUP("0000:00:0c.0", -1, "device-wakeup", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("0000:00:0c.0", -1, "shutdown",      GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("0000:00:0c.0", -1, "host-wakeup",   GPIO_ACTIVE_HIGH),
-		{ },
-	},
-};
-
-#define TNG_BT_SFI_GPIO_DEVICE_WAKEUP	"bt_wakeup"
-#define TNG_BT_SFI_GPIO_SHUTDOWN	"BT-reset"
-#define TNG_BT_SFI_GPIO_HOST_WAKEUP	"bt_uart_enable"
-
-static int __init tng_bt_sfi_setup(struct bt_sfi_data *ddata)
-{
-	struct gpiod_lookup_table *table = &tng_bt_sfi_gpio_table;
-	struct gpiod_lookup *lookup = table->table;
-	struct pci_dev *pdev;
-
-	/* Connected to /dev/ttyS0 */
-	pdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(4, 1));
-	if (!pdev)
-		return -ENODEV;
-
-	ddata->dev = &pdev->dev;
-	ddata->name = table->dev_id;
-
-	lookup[0].chip_hwnum = get_gpio_by_name(TNG_BT_SFI_GPIO_DEVICE_WAKEUP);
-	lookup[1].chip_hwnum = get_gpio_by_name(TNG_BT_SFI_GPIO_SHUTDOWN);
-	lookup[2].chip_hwnum = get_gpio_by_name(TNG_BT_SFI_GPIO_HOST_WAKEUP);
-
-	gpiod_add_lookup_table(table);
-	return 0;
-}
-
-static struct bt_sfi_data tng_bt_sfi_data __initdata = {
-	.setup	= tng_bt_sfi_setup,
-};
-
-static const struct x86_cpu_id bt_sfi_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&tng_bt_sfi_data),
-	{}
-};
-
-static int __init bt_sfi_init(void)
-{
-	struct platform_device_info info;
-	struct platform_device *pdev;
-	const struct x86_cpu_id *id;
-	struct bt_sfi_data *ddata;
-	int ret;
-
-	id = x86_match_cpu(bt_sfi_cpu_ids);
-	if (!id)
-		return -ENODEV;
-
-	ddata = (struct bt_sfi_data *)id->driver_data;
-	if (!ddata)
-		return -ENODEV;
-
-	ret = ddata->setup(ddata);
-	if (ret)
-		return ret;
-
-	memset(&info, 0, sizeof(info));
-	info.fwnode	= ddata->dev->fwnode;
-	info.parent	= ddata->dev;
-	info.name	= ddata->name;
-	info.id		= PLATFORM_DEVID_NONE;
-
-	pdev = platform_device_register_full(&info);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	dev_info(ddata->dev, "Registered Bluetooth device: %s\n", ddata->name);
-	return 0;
-}
-device_initcall(bt_sfi_init);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_emc1403.c b/arch/x86/platform/intel-mid/device_libs/platform_emc1403.c
deleted file mode 100644
index a2508582a0b1..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_emc1403.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_emc1403.c: emc1403 platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-#include <asm/intel-mid.h>
-
-static void __init *emc1403_platform_data(void *info)
-{
-	static short intr2nd_pdata;
-	struct i2c_board_info *i2c_info = info;
-	int intr = get_gpio_by_name("thermal_int");
-	int intr2nd = get_gpio_by_name("thermal_alert");
-
-	if (intr < 0)
-		return NULL;
-	if (intr2nd < 0)
-		return NULL;
-
-	i2c_info->irq = intr + INTEL_MID_IRQ_OFFSET;
-	intr2nd_pdata = intr2nd + INTEL_MID_IRQ_OFFSET;
-
-	return &intr2nd_pdata;
-}
-
-static const struct devs_id emc1403_dev_id __initconst = {
-	.name = "emc1403",
-	.type = SFI_DEV_TYPE_I2C,
-	.delay = 1,
-	.get_platform_data = &emc1403_platform_data,
-};
-
-sfi_device(emc1403_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c b/arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c
deleted file mode 100644
index d9435d2196a4..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_gpio_keys.c: gpio_keys platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/input.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/platform_device.h>
-#include <asm/intel-mid.h>
-
-#define DEVICE_NAME "gpio-keys"
-
-/*
- * we will search these buttons in SFI GPIO table (by name)
- * and register them dynamically. Please add all possible
- * buttons here, we will shrink them if no GPIO found.
- */
-static struct gpio_keys_button gpio_button[] = {
-	{KEY_POWER,		-1, 1, "power_btn",	EV_KEY, 0, 3000},
-	{KEY_PROG1,		-1, 1, "prog_btn1",	EV_KEY, 0, 20},
-	{KEY_PROG2,		-1, 1, "prog_btn2",	EV_KEY, 0, 20},
-	{SW_LID,		-1, 1, "lid_switch",	EV_SW,  0, 20},
-	{KEY_VOLUMEUP,		-1, 1, "vol_up",	EV_KEY, 0, 20},
-	{KEY_VOLUMEDOWN,	-1, 1, "vol_down",	EV_KEY, 0, 20},
-	{KEY_MUTE,		-1, 1, "mute_enable",	EV_KEY, 0, 20},
-	{KEY_VOLUMEUP,		-1, 1, "volume_up",	EV_KEY, 0, 20},
-	{KEY_VOLUMEDOWN,	-1, 1, "volume_down",	EV_KEY, 0, 20},
-	{KEY_CAMERA,		-1, 1, "camera_full",	EV_KEY, 0, 20},
-	{KEY_CAMERA_FOCUS,	-1, 1, "camera_half",	EV_KEY, 0, 20},
-	{SW_KEYPAD_SLIDE,	-1, 1, "MagSw1",	EV_SW,  0, 20},
-	{SW_KEYPAD_SLIDE,	-1, 1, "MagSw2",	EV_SW,  0, 20},
-};
-
-static struct gpio_keys_platform_data gpio_keys = {
-	.buttons	= gpio_button,
-	.rep		= 1,
-	.nbuttons	= -1, /* will fill it after search */
-};
-
-static struct platform_device pb_device = {
-	.name		= DEVICE_NAME,
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &gpio_keys,
-	},
-};
-
-/*
- * Shrink the non-existent buttons, register the gpio button
- * device if there is some
- */
-static int __init pb_keys_init(void)
-{
-	struct gpio_keys_button *gb = gpio_button;
-	int i, good = 0;
-
-	for (i = 0; i < ARRAY_SIZE(gpio_button); i++) {
-		gb[i].gpio = get_gpio_by_name(gb[i].desc);
-		pr_debug("info[%2d]: name = %s, gpio = %d\n", i, gb[i].desc,
-					gb[i].gpio);
-		if (gb[i].gpio < 0)
-			continue;
-
-		if (i != good)
-			gb[good] = gb[i];
-		good++;
-	}
-
-	if (good) {
-		gpio_keys.nbuttons = good;
-		return platform_device_register(&pb_device);
-	}
-	return 0;
-}
-late_initcall(pb_keys_init);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_lis331.c b/arch/x86/platform/intel-mid/device_libs/platform_lis331.c
deleted file mode 100644
index a4485cd638c6..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_lis331.c
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_lis331.c:  lis331 platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <asm/intel-mid.h>
-
-static void __init *lis331dl_platform_data(void *info)
-{
-	static short intr2nd_pdata;
-	struct i2c_board_info *i2c_info = info;
-	int intr = get_gpio_by_name("accel_int");
-	int intr2nd = get_gpio_by_name("accel_2");
-
-	if (intr < 0)
-		return NULL;
-	if (intr2nd < 0)
-		return NULL;
-
-	i2c_info->irq = intr + INTEL_MID_IRQ_OFFSET;
-	intr2nd_pdata = intr2nd + INTEL_MID_IRQ_OFFSET;
-
-	return &intr2nd_pdata;
-}
-
-static const struct devs_id lis331dl_dev_id __initconst = {
-	.name = "i2c_accel",
-	.type = SFI_DEV_TYPE_I2C,
-	.get_platform_data = &lis331dl_platform_data,
-};
-
-sfi_device(lis331dl_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_max7315.c b/arch/x86/platform/intel-mid/device_libs/platform_max7315.c
deleted file mode 100644
index e9287c3184da..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_max7315.c
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_max7315.c: max7315 platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-#include <linux/platform_data/pca953x.h>
-#include <asm/intel-mid.h>
-
-#define MAX7315_NUM 2
-
-static void __init *max7315_platform_data(void *info)
-{
-	static struct pca953x_platform_data max7315_pdata[MAX7315_NUM];
-	static int nr;
-	struct pca953x_platform_data *max7315 = &max7315_pdata[nr];
-	struct i2c_board_info *i2c_info = info;
-	int gpio_base, intr;
-	char base_pin_name[SFI_NAME_LEN + 1];
-	char intr_pin_name[SFI_NAME_LEN + 1];
-
-	if (nr == MAX7315_NUM) {
-		pr_err("too many max7315s, we only support %d\n",
-				MAX7315_NUM);
-		return NULL;
-	}
-	/* we have several max7315 on the board, we only need load several
-	 * instances of the same pca953x driver to cover them
-	 */
-	strcpy(i2c_info->type, "max7315");
-	if (nr++) {
-		snprintf(base_pin_name, sizeof(base_pin_name),
-			 "max7315_%d_base", nr);
-		snprintf(intr_pin_name, sizeof(intr_pin_name),
-			 "max7315_%d_int", nr);
-	} else {
-		strcpy(base_pin_name, "max7315_base");
-		strcpy(intr_pin_name, "max7315_int");
-	}
-
-	gpio_base = get_gpio_by_name(base_pin_name);
-	intr = get_gpio_by_name(intr_pin_name);
-
-	if (gpio_base < 0)
-		return NULL;
-	max7315->gpio_base = gpio_base;
-	if (intr != -1) {
-		i2c_info->irq = intr + INTEL_MID_IRQ_OFFSET;
-		max7315->irq_base = gpio_base + INTEL_MID_IRQ_OFFSET;
-	} else {
-		i2c_info->irq = -1;
-		max7315->irq_base = -1;
-	}
-	return max7315;
-}
-
-static const struct devs_id max7315_dev_id __initconst = {
-	.name = "i2c_max7315",
-	.type = SFI_DEV_TYPE_I2C,
-	.delay = 1,
-	.get_platform_data = &max7315_platform_data,
-};
-
-static const struct devs_id max7315_2_dev_id __initconst = {
-	.name = "i2c_max7315_2",
-	.type = SFI_DEV_TYPE_I2C,
-	.delay = 1,
-	.get_platform_data = &max7315_platform_data,
-};
-
-sfi_device(max7315_dev_id);
-sfi_device(max7315_2_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_mpu3050.c b/arch/x86/platform/intel-mid/device_libs/platform_mpu3050.c
deleted file mode 100644
index 28a182713934..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_mpu3050.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_mpu3050.c: mpu3050 platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-#include <asm/intel-mid.h>
-
-static void *mpu3050_platform_data(void *info)
-{
-	struct i2c_board_info *i2c_info = info;
-	int intr = get_gpio_by_name("mpu3050_int");
-
-	if (intr < 0)
-		return NULL;
-
-	i2c_info->irq = intr + INTEL_MID_IRQ_OFFSET;
-	return NULL;
-}
-
-static const struct devs_id mpu3050_dev_id __initconst = {
-	.name = "mpu3050",
-	.type = SFI_DEV_TYPE_I2C,
-	.delay = 1,
-	.get_platform_data = &mpu3050_platform_data,
-};
-
-sfi_device(mpu3050_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_pinctrl.c b/arch/x86/platform/intel-mid/device_libs/platform_mrfld_pinctrl.c
deleted file mode 100644
index 605e1f94ad89..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_pinctrl.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Intel Merrifield FLIS platform device initialization file
- *
- * Copyright (C) 2016, Intel Corporation
- *
- * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- */
-
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-
-#include <asm/intel-mid.h>
-
-#define FLIS_BASE_ADDR			0xff0c0000
-#define FLIS_LENGTH			0x8000
-
-static struct resource mrfld_pinctrl_mmio_resource = {
-	.start		= FLIS_BASE_ADDR,
-	.end		= FLIS_BASE_ADDR + FLIS_LENGTH - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device mrfld_pinctrl_device = {
-	.name		= "pinctrl-merrifield",
-	.id		= PLATFORM_DEVID_NONE,
-	.resource	= &mrfld_pinctrl_mmio_resource,
-	.num_resources	= 1,
-};
-
-static int __init mrfld_pinctrl_init(void)
-{
-	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
-		return platform_device_register(&mrfld_pinctrl_device);
-
-	return -ENODEV;
-}
-arch_initcall(mrfld_pinctrl_init);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_rtc.c b/arch/x86/platform/intel-mid/device_libs/platform_mrfld_rtc.c
deleted file mode 100644
index 40e9808a9634..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_rtc.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Intel Merrifield legacy RTC initialization file
- *
- * (C) Copyright 2017 Intel Corporation
- *
- * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- */
-
-#include <linux/init.h>
-
-#include <asm/hw_irq.h>
-#include <asm/intel-mid.h>
-#include <asm/io_apic.h>
-#include <asm/time.h>
-#include <asm/x86_init.h>
-
-static int __init mrfld_legacy_rtc_alloc_irq(void)
-{
-	struct irq_alloc_info info;
-	int ret;
-
-	if (!x86_platform.legacy.rtc)
-		return -ENODEV;
-
-	ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 1, 0);
-	ret = mp_map_gsi_to_irq(RTC_IRQ, IOAPIC_MAP_ALLOC, &info);
-	if (ret < 0) {
-		pr_info("Failed to allocate RTC interrupt. Disabling RTC\n");
-		x86_platform.legacy.rtc = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
-static int __init mrfld_legacy_rtc_init(void)
-{
-	if (intel_mid_identify_cpu() != INTEL_MID_CPU_CHIP_TANGIER)
-		return -ENODEV;
-
-	return mrfld_legacy_rtc_alloc_irq();
-}
-arch_initcall(mrfld_legacy_rtc_init);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_sd.c b/arch/x86/platform/intel-mid/device_libs/platform_mrfld_sd.c
deleted file mode 100644
index fe3b7ff975f3..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_sd.c
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * SDHCI platform data initilisation file
- *
- * (C) Copyright 2016 Intel Corporation
- * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- */
-
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <linux/mmc/sdhci-pci-data.h>
-
-#include <asm/intel-mid.h>
-
-#define INTEL_MRFLD_SD			2
-#define INTEL_MRFLD_SD_CD_GPIO		77
-
-static struct sdhci_pci_data mrfld_sdhci_pci_data = {
-	.rst_n_gpio	= -EINVAL,
-	.cd_gpio	= INTEL_MRFLD_SD_CD_GPIO,
-};
-
-static struct sdhci_pci_data *
-mrfld_sdhci_pci_get_data(struct pci_dev *pdev, int slotno)
-{
-	unsigned int func = PCI_FUNC(pdev->devfn);
-
-	if (func == INTEL_MRFLD_SD)
-		return &mrfld_sdhci_pci_data;
-
-	return NULL;
-}
-
-static int __init mrfld_sd_init(void)
-{
-	if (intel_mid_identify_cpu() != INTEL_MID_CPU_CHIP_TANGIER)
-		return -ENODEV;
-
-	sdhci_pci_get_data = mrfld_sdhci_pci_get_data;
-	return 0;
-}
-arch_initcall(mrfld_sd_init);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_spidev.c b/arch/x86/platform/intel-mid/device_libs/platform_mrfld_spidev.c
deleted file mode 100644
index b828f4fd40be..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_spidev.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * spidev platform data initialization file
- *
- * (C) Copyright 2014, 2016 Intel Corporation
- * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- *	    Dan O'Donovan <dan@emutex.com>
- */
-
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/sfi.h>
-#include <linux/spi/pxa2xx_spi.h>
-#include <linux/spi/spi.h>
-
-#include <asm/intel-mid.h>
-
-#define MRFLD_SPI_DEFAULT_DMA_BURST	8
-#define MRFLD_SPI_DEFAULT_TIMEOUT	500
-
-/* GPIO pin for spidev chipselect */
-#define MRFLD_SPIDEV_GPIO_CS		111
-
-static struct pxa2xx_spi_chip spidev_spi_chip = {
-	.dma_burst_size		= MRFLD_SPI_DEFAULT_DMA_BURST,
-	.timeout		= MRFLD_SPI_DEFAULT_TIMEOUT,
-	.gpio_cs		= MRFLD_SPIDEV_GPIO_CS,
-};
-
-static void __init *spidev_platform_data(void *info)
-{
-	struct spi_board_info *spi_info = info;
-
-	if (intel_mid_identify_cpu() != INTEL_MID_CPU_CHIP_TANGIER)
-		return ERR_PTR(-ENODEV);
-
-	spi_info->mode = SPI_MODE_0;
-	spi_info->controller_data = &spidev_spi_chip;
-
-	return NULL;
-}
-
-static const struct devs_id spidev_dev_id __initconst = {
-	.name			= "spidev",
-	.type			= SFI_DEV_TYPE_SPI,
-	.delay			= 0,
-	.get_platform_data	= &spidev_platform_data,
-};
-
-sfi_device(spidev_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_pcal9555a.c b/arch/x86/platform/intel-mid/device_libs/platform_pcal9555a.c
deleted file mode 100644
index 5609d8da3978..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_pcal9555a.c
+++ /dev/null
@@ -1,95 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * PCAL9555a platform data initialization file
- *
- * Copyright (C) 2016, Intel Corporation
- *
- * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- *	    Dan O'Donovan <dan@emutex.com>
- */
-
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
-#include <linux/platform_data/pca953x.h>
-#include <linux/sfi.h>
-
-#include <asm/intel-mid.h>
-
-#define PCAL9555A_NUM	4
-
-static struct pca953x_platform_data pcal9555a_pdata[PCAL9555A_NUM];
-static int nr;
-
-static void __init *pcal9555a_platform_data(void *info)
-{
-	struct i2c_board_info *i2c_info = info;
-	char *type = i2c_info->type;
-	struct pca953x_platform_data *pcal9555a;
-	char base_pin_name[SFI_NAME_LEN + 1];
-	char intr_pin_name[SFI_NAME_LEN + 1];
-	int gpio_base, intr;
-
-	snprintf(base_pin_name, sizeof(base_pin_name), "%s_base", type);
-	snprintf(intr_pin_name, sizeof(intr_pin_name), "%s_int", type);
-
-	gpio_base = get_gpio_by_name(base_pin_name);
-	intr = get_gpio_by_name(intr_pin_name);
-
-	/* Check if the SFI record valid */
-	if (gpio_base == -1)
-		return NULL;
-
-	if (nr >= PCAL9555A_NUM) {
-		pr_err("%s: Too many instances, only %d supported\n", __func__,
-		       PCAL9555A_NUM);
-		return NULL;
-	}
-
-	pcal9555a = &pcal9555a_pdata[nr++];
-	pcal9555a->gpio_base = gpio_base;
-
-	if (intr >= 0) {
-		i2c_info->irq = intr + INTEL_MID_IRQ_OFFSET;
-		pcal9555a->irq_base = gpio_base + INTEL_MID_IRQ_OFFSET;
-	} else {
-		i2c_info->irq = -1;
-		pcal9555a->irq_base = -1;
-	}
-
-	strcpy(type, "pcal9555a");
-	return pcal9555a;
-}
-
-static const struct devs_id pcal9555a_1_dev_id __initconst = {
-	.name			= "pcal9555a-1",
-	.type			= SFI_DEV_TYPE_I2C,
-	.delay			= 1,
-	.get_platform_data	= &pcal9555a_platform_data,
-};
-
-static const struct devs_id pcal9555a_2_dev_id __initconst = {
-	.name			= "pcal9555a-2",
-	.type			= SFI_DEV_TYPE_I2C,
-	.delay			= 1,
-	.get_platform_data	= &pcal9555a_platform_data,
-};
-
-static const struct devs_id pcal9555a_3_dev_id __initconst = {
-	.name			= "pcal9555a-3",
-	.type			= SFI_DEV_TYPE_I2C,
-	.delay			= 1,
-	.get_platform_data	= &pcal9555a_platform_data,
-};
-
-static const struct devs_id pcal9555a_4_dev_id __initconst = {
-	.name			= "pcal9555a-4",
-	.type			= SFI_DEV_TYPE_I2C,
-	.delay			= 1,
-	.get_platform_data	= &pcal9555a_platform_data,
-};
-
-sfi_device(pcal9555a_1_dev_id);
-sfi_device(pcal9555a_2_dev_id);
-sfi_device(pcal9555a_3_dev_id);
-sfi_device(pcal9555a_4_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c b/arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
deleted file mode 100644
index 139738bbdd36..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_tc35876x.c: tc35876x platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/gpio/machine.h>
-#include <asm/intel-mid.h>
-
-static struct gpiod_lookup_table tc35876x_gpio_table = {
-	.dev_id	= "i2c_disp_brig",
-	.table	= {
-		GPIO_LOOKUP("0000:00:0c.0", -1, "bridge-reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("0000:00:0c.0", -1, "bl-en", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("0000:00:0c.0", -1, "vadd", GPIO_ACTIVE_HIGH),
-		{ },
-	},
-};
-
-/*tc35876x DSI_LVDS bridge chip and panel platform data*/
-static void *tc35876x_platform_data(void *data)
-{
-	struct gpiod_lookup_table *table = &tc35876x_gpio_table;
-	struct gpiod_lookup *lookup = table->table;
-
-	lookup[0].chip_hwnum = get_gpio_by_name("LCMB_RXEN");
-	lookup[1].chip_hwnum = get_gpio_by_name("6S6P_BL_EN");
-	lookup[2].chip_hwnum = get_gpio_by_name("EN_VREG_LCD_V3P3");
-	gpiod_add_lookup_table(table);
-
-	return NULL;
-}
-
-static const struct devs_id tc35876x_dev_id __initconst = {
-	.name = "i2c_disp_brig",
-	.type = SFI_DEV_TYPE_I2C,
-	.get_platform_data = &tc35876x_platform_data,
-};
-
-sfi_device(tc35876x_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_tca6416.c b/arch/x86/platform/intel-mid/device_libs/platform_tca6416.c
deleted file mode 100644
index e689d8f61059..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_tca6416.c
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_tca6416.c: tca6416 platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/platform_data/pca953x.h>
-#include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <asm/intel-mid.h>
-
-#define TCA6416_NAME	"tca6416"
-#define TCA6416_BASE	"tca6416_base"
-#define TCA6416_INTR	"tca6416_int"
-
-static void *tca6416_platform_data(void *info)
-{
-	static struct pca953x_platform_data tca6416;
-	struct i2c_board_info *i2c_info = info;
-	int gpio_base, intr;
-	char base_pin_name[SFI_NAME_LEN + 1];
-	char intr_pin_name[SFI_NAME_LEN + 1];
-
-	strcpy(i2c_info->type, TCA6416_NAME);
-	strcpy(base_pin_name, TCA6416_BASE);
-	strcpy(intr_pin_name, TCA6416_INTR);
-
-	gpio_base = get_gpio_by_name(base_pin_name);
-	intr = get_gpio_by_name(intr_pin_name);
-
-	if (gpio_base < 0)
-		return NULL;
-	tca6416.gpio_base = gpio_base;
-	if (intr >= 0) {
-		i2c_info->irq = intr + INTEL_MID_IRQ_OFFSET;
-		tca6416.irq_base = gpio_base + INTEL_MID_IRQ_OFFSET;
-	} else {
-		i2c_info->irq = -1;
-		tca6416.irq_base = -1;
-	}
-	return &tca6416;
-}
-
-static const struct devs_id tca6416_dev_id __initconst = {
-	.name = "tca6416",
-	.type = SFI_DEV_TYPE_I2C,
-	.delay = 1,
-	.get_platform_data = &tca6416_platform_data,
-};
-
-sfi_device(tca6416_dev_id);
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 864b0c158b2f..2c044e260b4b 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/regulator/machine.h>
 #include <linux/scatterlist.h>
-#include <linux/sfi.h>
 #include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/notifier.h>
diff --git a/arch/x86/platform/intel-mid/sfi.c b/arch/x86/platform/intel-mid/sfi.c
deleted file mode 100644
index 63ae342ffb12..000000000000
--- a/arch/x86/platform/intel-mid/sfi.c
+++ /dev/null
@@ -1,419 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * intel_mid_sfi.c: Intel MID SFI initialization code
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/scatterlist.h>
-#include <linux/sfi.h>
-#include <linux/spi/spi.h>
-#include <linux/i2c.h>
-#include <linux/skbuff.h>
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/input.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/export.h>
-#include <linux/notifier.h>
-#include <linux/mmc/core.h>
-#include <linux/mmc/card.h>
-#include <linux/blkdev.h>
-
-#include <asm/setup.h>
-#include <asm/mpspec_def.h>
-#include <asm/hw_irq.h>
-#include <asm/apic.h>
-#include <asm/io_apic.h>
-#include <asm/intel-mid.h>
-#include <asm/io.h>
-#include <asm/i8259.h>
-#include <asm/intel_scu_ipc.h>
-#include <asm/reboot.h>
-
-#define	SFI_SIG_OEM0	"OEM0"
-#define MAX_IPCDEVS	24
-#define MAX_SCU_SPI	24
-#define MAX_SCU_I2C	24
-
-static struct platform_device *ipc_devs[MAX_IPCDEVS];
-static struct spi_board_info *spi_devs[MAX_SCU_SPI];
-static struct i2c_board_info *i2c_devs[MAX_SCU_I2C];
-static struct sfi_gpio_table_entry *gpio_table;
-static int ipc_next_dev;
-static int spi_next_dev;
-static int i2c_next_dev;
-static int i2c_bus[MAX_SCU_I2C];
-static int gpio_num_entry;
-
-struct blocking_notifier_head intel_scu_notifier =
-			BLOCKING_NOTIFIER_INIT(intel_scu_notifier);
-EXPORT_SYMBOL_GPL(intel_scu_notifier);
-
-#define intel_mid_sfi_get_pdata(dev, priv)	\
-	((dev)->get_platform_data ? (dev)->get_platform_data(priv) : NULL)
-
-/*
- * Parsing GPIO table first, since the DEVS table will need this table
- * to map the pin name to the actual pin.
- */
-static int __init sfi_parse_gpio(struct sfi_table_header *table)
-{
-	struct sfi_table_simple *sb;
-	struct sfi_gpio_table_entry *pentry;
-	int num, i;
-
-	if (gpio_table)
-		return 0;
-	sb = (struct sfi_table_simple *)table;
-	num = SFI_GET_NUM_ENTRIES(sb, struct sfi_gpio_table_entry);
-	pentry = (struct sfi_gpio_table_entry *)sb->pentry;
-
-	gpio_table = kmemdup(pentry, num * sizeof(*pentry), GFP_KERNEL);
-	if (!gpio_table)
-		return -1;
-	gpio_num_entry = num;
-
-	pr_debug("GPIO pin info:\n");
-	for (i = 0; i < num; i++, pentry++)
-		pr_debug("info[%2d]: controller = %16.16s, pin_name = %16.16s,"
-		" pin = %d\n", i,
-			pentry->controller_name,
-			pentry->pin_name,
-			pentry->pin_no);
-	return 0;
-}
-
-int get_gpio_by_name(const char *name)
-{
-	struct sfi_gpio_table_entry *pentry = gpio_table;
-	int i;
-
-	if (!pentry)
-		return -1;
-	for (i = 0; i < gpio_num_entry; i++, pentry++) {
-		if (!strncmp(name, pentry->pin_name, SFI_NAME_LEN))
-			return pentry->pin_no;
-	}
-	return -EINVAL;
-}
-
-static void __init intel_scu_ipc_device_register(struct platform_device *pdev)
-{
-	if (ipc_next_dev == MAX_IPCDEVS)
-		pr_err("too many SCU IPC devices");
-	else
-		ipc_devs[ipc_next_dev++] = pdev;
-}
-
-static void __init intel_scu_spi_device_register(struct spi_board_info *sdev)
-{
-	struct spi_board_info *new_dev;
-
-	if (spi_next_dev == MAX_SCU_SPI) {
-		pr_err("too many SCU SPI devices");
-		return;
-	}
-
-	new_dev = kzalloc(sizeof(*sdev), GFP_KERNEL);
-	if (!new_dev) {
-		pr_err("failed to alloc mem for delayed spi dev %s\n",
-			sdev->modalias);
-		return;
-	}
-	*new_dev = *sdev;
-
-	spi_devs[spi_next_dev++] = new_dev;
-}
-
-static void __init intel_scu_i2c_device_register(int bus,
-						struct i2c_board_info *idev)
-{
-	struct i2c_board_info *new_dev;
-
-	if (i2c_next_dev == MAX_SCU_I2C) {
-		pr_err("too many SCU I2C devices");
-		return;
-	}
-
-	new_dev = kzalloc(sizeof(*idev), GFP_KERNEL);
-	if (!new_dev) {
-		pr_err("failed to alloc mem for delayed i2c dev %s\n",
-			idev->type);
-		return;
-	}
-	*new_dev = *idev;
-
-	i2c_bus[i2c_next_dev] = bus;
-	i2c_devs[i2c_next_dev++] = new_dev;
-}
-
-/* Called by IPC driver */
-void intel_scu_devices_create(void)
-{
-	int i;
-
-	for (i = 0; i < ipc_next_dev; i++)
-		platform_device_add(ipc_devs[i]);
-
-	for (i = 0; i < spi_next_dev; i++)
-		spi_register_board_info(spi_devs[i], 1);
-
-	for (i = 0; i < i2c_next_dev; i++) {
-		struct i2c_adapter *adapter;
-		struct i2c_client *client;
-
-		adapter = i2c_get_adapter(i2c_bus[i]);
-		if (adapter) {
-			client = i2c_new_client_device(adapter, i2c_devs[i]);
-			if (IS_ERR(client))
-				pr_err("can't create i2c device %s\n",
-					i2c_devs[i]->type);
-		} else
-			i2c_register_board_info(i2c_bus[i], i2c_devs[i], 1);
-	}
-	intel_scu_notifier_post(SCU_AVAILABLE, NULL);
-}
-EXPORT_SYMBOL_GPL(intel_scu_devices_create);
-
-/* Called by IPC driver */
-void intel_scu_devices_destroy(void)
-{
-	int i;
-
-	intel_scu_notifier_post(SCU_DOWN, NULL);
-
-	for (i = 0; i < ipc_next_dev; i++)
-		platform_device_del(ipc_devs[i]);
-}
-EXPORT_SYMBOL_GPL(intel_scu_devices_destroy);
-
-static void __init install_irq_resource(struct platform_device *pdev, int irq)
-{
-	/* Single threaded */
-	static struct resource res __initdata = {
-		.name = "IRQ",
-		.flags = IORESOURCE_IRQ,
-	};
-	res.start = irq;
-	platform_device_add_resources(pdev, &res, 1);
-}
-
-static void __init sfi_handle_ipc_dev(struct sfi_device_table_entry *pentry,
-					struct devs_id *dev)
-{
-	struct platform_device *pdev;
-	void *pdata = NULL;
-
-	pr_debug("IPC bus, name = %16.16s, irq = 0x%2x\n",
-		pentry->name, pentry->irq);
-
-	/*
-	 * We need to call platform init of IPC devices to fill misc_pdata
-	 * structure. It will be used in msic_init for initialization.
-	 */
-	pdata = intel_mid_sfi_get_pdata(dev, pentry);
-	if (IS_ERR(pdata))
-		return;
-
-	pdev = platform_device_alloc(pentry->name, 0);
-	if (pdev == NULL) {
-		pr_err("out of memory for SFI platform device '%s'.\n",
-			pentry->name);
-		return;
-	}
-	install_irq_resource(pdev, pentry->irq);
-
-	pdev->dev.platform_data = pdata;
-	if (dev->delay)
-		intel_scu_ipc_device_register(pdev);
-	else
-		platform_device_add(pdev);
-}
-
-static void __init sfi_handle_spi_dev(struct sfi_device_table_entry *pentry,
-					struct devs_id *dev)
-{
-	struct spi_board_info spi_info;
-	void *pdata = NULL;
-
-	memset(&spi_info, 0, sizeof(spi_info));
-	strncpy(spi_info.modalias, pentry->name, SFI_NAME_LEN);
-	spi_info.irq = ((pentry->irq == (u8)0xff) ? 0 : pentry->irq);
-	spi_info.bus_num = pentry->host_num;
-	spi_info.chip_select = pentry->addr;
-	spi_info.max_speed_hz = pentry->max_freq;
-	pr_debug("SPI bus=%d, name=%16.16s, irq=0x%2x, max_freq=%d, cs=%d\n",
-		spi_info.bus_num,
-		spi_info.modalias,
-		spi_info.irq,
-		spi_info.max_speed_hz,
-		spi_info.chip_select);
-
-	pdata = intel_mid_sfi_get_pdata(dev, &spi_info);
-	if (IS_ERR(pdata))
-		return;
-
-	spi_info.platform_data = pdata;
-	if (dev->delay)
-		intel_scu_spi_device_register(&spi_info);
-	else
-		spi_register_board_info(&spi_info, 1);
-}
-
-static void __init sfi_handle_i2c_dev(struct sfi_device_table_entry *pentry,
-					struct devs_id *dev)
-{
-	struct i2c_board_info i2c_info;
-	void *pdata = NULL;
-
-	memset(&i2c_info, 0, sizeof(i2c_info));
-	strncpy(i2c_info.type, pentry->name, SFI_NAME_LEN);
-	i2c_info.irq = ((pentry->irq == (u8)0xff) ? 0 : pentry->irq);
-	i2c_info.addr = pentry->addr;
-	pr_debug("I2C bus = %d, name = %16.16s, irq = 0x%2x, addr = 0x%x\n",
-		pentry->host_num,
-		i2c_info.type,
-		i2c_info.irq,
-		i2c_info.addr);
-	pdata = intel_mid_sfi_get_pdata(dev, &i2c_info);
-	i2c_info.platform_data = pdata;
-	if (IS_ERR(pdata))
-		return;
-
-	if (dev->delay)
-		intel_scu_i2c_device_register(pentry->host_num, &i2c_info);
-	else
-		i2c_register_board_info(pentry->host_num, &i2c_info, 1);
-}
-
-static void __init sfi_handle_sd_dev(struct sfi_device_table_entry *pentry,
-					struct devs_id *dev)
-{
-	struct mid_sd_board_info sd_info;
-	void *pdata;
-
-	memset(&sd_info, 0, sizeof(sd_info));
-	strncpy(sd_info.name, pentry->name, SFI_NAME_LEN);
-	sd_info.bus_num = pentry->host_num;
-	sd_info.max_clk = pentry->max_freq;
-	sd_info.addr = pentry->addr;
-	pr_debug("SD bus = %d, name = %16.16s, max_clk = %d, addr = 0x%x\n",
-		 sd_info.bus_num,
-		 sd_info.name,
-		 sd_info.max_clk,
-		 sd_info.addr);
-	pdata = intel_mid_sfi_get_pdata(dev, &sd_info);
-	if (IS_ERR(pdata))
-		return;
-
-	/* Nothing we can do with this for now */
-	sd_info.platform_data = pdata;
-
-	pr_debug("Successfully registered %16.16s", sd_info.name);
-}
-
-extern struct devs_id *const __x86_intel_mid_dev_start[],
-		      *const __x86_intel_mid_dev_end[];
-
-static struct devs_id __init *get_device_id(u8 type, char *name)
-{
-	struct devs_id *const *dev_table;
-
-	for (dev_table = __x86_intel_mid_dev_start;
-			dev_table < __x86_intel_mid_dev_end; dev_table++) {
-		struct devs_id *dev = *dev_table;
-		if (dev->type == type &&
-			!strncmp(dev->name, name, SFI_NAME_LEN)) {
-			return dev;
-		}
-	}
-
-	return NULL;
-}
-
-static int __init sfi_parse_devs(struct sfi_table_header *table)
-{
-	struct sfi_table_simple *sb;
-	struct sfi_device_table_entry *pentry;
-	struct devs_id *dev = NULL;
-	int num, i, ret;
-	int polarity;
-	struct irq_alloc_info info;
-
-	sb = (struct sfi_table_simple *)table;
-	num = SFI_GET_NUM_ENTRIES(sb, struct sfi_device_table_entry);
-	pentry = (struct sfi_device_table_entry *)sb->pentry;
-
-	for (i = 0; i < num; i++, pentry++) {
-		int irq = pentry->irq;
-
-		if (irq != (u8)0xff) { /* native RTE case */
-			/* these SPI2 devices are not exposed to system as PCI
-			 * devices, but they have separate RTE entry in IOAPIC
-			 * so we have to enable them one by one here
-			 */
-			if (intel_mid_identify_cpu() ==
-					INTEL_MID_CPU_CHIP_TANGIER) {
-				if (!strncmp(pentry->name, "r69001-ts-i2c", 13))
-					/* active low */
-					polarity = 1;
-				else if (!strncmp(pentry->name,
-						"synaptics_3202", 14))
-					/* active low */
-					polarity = 1;
-				else if (irq == 41)
-					/* fast_int_1 */
-					polarity = 1;
-				else
-					/* active high */
-					polarity = 0;
-			} else {
-				/* PNW and CLV go with active low */
-				polarity = 1;
-			}
-
-			ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 1, polarity);
-			ret = mp_map_gsi_to_irq(irq, IOAPIC_MAP_ALLOC, &info);
-			WARN_ON(ret < 0);
-		}
-
-		dev = get_device_id(pentry->type, pentry->name);
-
-		if (!dev)
-			continue;
-
-		switch (pentry->type) {
-		case SFI_DEV_TYPE_IPC:
-			sfi_handle_ipc_dev(pentry, dev);
-			break;
-		case SFI_DEV_TYPE_SPI:
-			sfi_handle_spi_dev(pentry, dev);
-			break;
-		case SFI_DEV_TYPE_I2C:
-			sfi_handle_i2c_dev(pentry, dev);
-			break;
-		case SFI_DEV_TYPE_SD:
-			sfi_handle_sd_dev(pentry, dev);
-			break;
-		case SFI_DEV_TYPE_UART:
-		case SFI_DEV_TYPE_HSI:
-		default:
-			break;
-		}
-	}
-	return 0;
-}
-
-static int __init intel_mid_platform_init(void)
-{
-	sfi_table_parse(SFI_SIG_GPIO, NULL, NULL, sfi_parse_gpio);
-	sfi_table_parse(SFI_SIG_DEVS, NULL, NULL, sfi_parse_devs);
-	return 0;
-}
-arch_initcall(intel_mid_platform_init);
diff --git a/arch/x86/platform/sfi/Makefile b/arch/x86/platform/sfi/Makefile
deleted file mode 100644
index 4eba24c2af67..000000000000
--- a/arch/x86/platform/sfi/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_SFI)		+= sfi.o
diff --git a/arch/x86/platform/sfi/sfi.c b/arch/x86/platform/sfi/sfi.c
deleted file mode 100644
index 6259563760f9..000000000000
--- a/arch/x86/platform/sfi/sfi.c
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * sfi.c - x86 architecture SFI support.
- *
- * Copyright (c) 2009, Intel Corporation.
- */
-
-#define KMSG_COMPONENT "SFI"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
-
-#include <linux/acpi.h>
-#include <linux/init.h>
-#include <linux/sfi.h>
-#include <linux/io.h>
-
-#include <asm/irqdomain.h>
-#include <asm/io_apic.h>
-#include <asm/mpspec.h>
-#include <asm/setup.h>
-#include <asm/apic.h>
-
-#ifdef CONFIG_X86_LOCAL_APIC
-static unsigned long sfi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
-
-/* All CPUs enumerated by SFI must be present and enabled */
-static void __init mp_sfi_register_lapic(u8 id)
-{
-	if (MAX_LOCAL_APIC - id <= 0) {
-		pr_warn("Processor #%d invalid (max %d)\n", id, MAX_LOCAL_APIC);
-		return;
-	}
-
-	pr_info("registering lapic[%d]\n", id);
-
-	generic_processor_info(id, GET_APIC_VERSION(apic_read(APIC_LVR)));
-}
-
-static int __init sfi_parse_cpus(struct sfi_table_header *table)
-{
-	struct sfi_table_simple *sb;
-	struct sfi_cpu_table_entry *pentry;
-	int i;
-	int cpu_num;
-
-	sb = (struct sfi_table_simple *)table;
-	cpu_num = SFI_GET_NUM_ENTRIES(sb, struct sfi_cpu_table_entry);
-	pentry = (struct sfi_cpu_table_entry *)sb->pentry;
-
-	for (i = 0; i < cpu_num; i++) {
-		mp_sfi_register_lapic(pentry->apic_id);
-		pentry++;
-	}
-
-	smp_found_config = 1;
-	return 0;
-}
-#endif /* CONFIG_X86_LOCAL_APIC */
-
-#ifdef CONFIG_X86_IO_APIC
-
-static int __init sfi_parse_ioapic(struct sfi_table_header *table)
-{
-	struct sfi_table_simple *sb;
-	struct sfi_apic_table_entry *pentry;
-	int i, num;
-	struct ioapic_domain_cfg cfg = {
-		.type = IOAPIC_DOMAIN_STRICT,
-		.ops = &mp_ioapic_irqdomain_ops,
-	};
-
-	sb = (struct sfi_table_simple *)table;
-	num = SFI_GET_NUM_ENTRIES(sb, struct sfi_apic_table_entry);
-	pentry = (struct sfi_apic_table_entry *)sb->pentry;
-
-	for (i = 0; i < num; i++) {
-		mp_register_ioapic(i, pentry->phys_addr, gsi_top, &cfg);
-		pentry++;
-	}
-
-	WARN(pic_mode, KERN_WARNING
-		"SFI: pic_mod shouldn't be 1 when IOAPIC table is present\n");
-	pic_mode = 0;
-	return 0;
-}
-#endif /* CONFIG_X86_IO_APIC */
-
-/*
- * sfi_platform_init(): register lapics & io-apics
- */
-int __init sfi_platform_init(void)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	register_lapic_address(sfi_lapic_addr);
-	sfi_table_parse(SFI_SIG_CPUS, NULL, NULL, sfi_parse_cpus);
-#endif
-#ifdef CONFIG_X86_IO_APIC
-	sfi_table_parse(SFI_SIG_APIC, NULL, NULL, sfi_parse_ioapic);
-#endif
-	return 0;
-}
diff --git a/drivers/Makefile b/drivers/Makefile
index fd11b9ac4cc3..b2af1514a6b3 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -27,7 +27,7 @@ obj-y				+= idle/
 obj-y				+= char/ipmi/
 
 obj-$(CONFIG_ACPI)		+= acpi/
-obj-$(CONFIG_SFI)		+= sfi/
+
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
index 8c5fd8240da9..80abc708e4f2 100644
--- a/drivers/platform/x86/intel_scu_pcidrv.c
+++ b/drivers/platform/x86/intel_scu_pcidrv.c
@@ -17,7 +17,6 @@
 static int intel_scu_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
-	void (*setup_fn)(void) = (void (*)(void))id->driver_data;
 	struct intel_scu_ipc_data scu_data = {};
 	struct intel_scu_ipc_dev *scu;
 	int ret;
@@ -30,27 +29,14 @@ static int intel_scu_pci_probe(struct pci_dev *pdev,
 	scu_data.irq = pdev->irq;
 
 	scu = intel_scu_ipc_register(&pdev->dev, &scu_data);
-	if (IS_ERR(scu))
-		return PTR_ERR(scu);
-
-	if (setup_fn)
-		setup_fn();
-	return 0;
-}
-
-static void intel_mid_scu_setup(void)
-{
-	intel_scu_devices_create();
+	return PTR_ERR_OR_ZERO(scu);
 }
 
 static const struct pci_device_id pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x080e),
-	  .driver_data = (kernel_ulong_t)intel_mid_scu_setup },
-	{ PCI_VDEVICE(INTEL, 0x08ea),
-	  .driver_data = (kernel_ulong_t)intel_mid_scu_setup },
+	{ PCI_VDEVICE(INTEL, 0x080e) },
+	{ PCI_VDEVICE(INTEL, 0x08ea) },
 	{ PCI_VDEVICE(INTEL, 0x0a94) },
-	{ PCI_VDEVICE(INTEL, 0x11a0),
-	  .driver_data = (kernel_ulong_t)intel_mid_scu_setup },
+	{ PCI_VDEVICE(INTEL, 0x11a0) },
 	{ PCI_VDEVICE(INTEL, 0x1a94) },
 	{ PCI_VDEVICE(INTEL, 0x5a94) },
 	{}
diff --git a/drivers/sfi/Kconfig b/drivers/sfi/Kconfig
deleted file mode 100644
index 3d0b64db214e..000000000000
--- a/drivers/sfi/Kconfig
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# SFI Configuration
-#
-
-menuconfig SFI
-	bool "SFI (Simple Firmware Interface) Support"
-	help
-	The Simple Firmware Interface (SFI) provides a lightweight method
-	for platform firmware to pass information to the operating system
-	via static tables in memory.  Kernel SFI support is required to
-	boot on SFI-only platforms.  Currently, all SFI-only platforms are
-	based on the 2nd generation Intel Atom processor platform,
-	code-named Moorestown.
-
-	For more information, see http://simplefirmware.org
-
-	Say 'Y' here to enable the kernel to boot on SFI-only platforms.
diff --git a/drivers/sfi/Makefile b/drivers/sfi/Makefile
deleted file mode 100644
index ca9436b12386..000000000000
--- a/drivers/sfi/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y	+= sfi_acpi.o
-obj-y	+= sfi_core.o
-
diff --git a/drivers/sfi/sfi_acpi.c b/drivers/sfi/sfi_acpi.c
deleted file mode 100644
index d277b36eb389..000000000000
--- a/drivers/sfi/sfi_acpi.c
+++ /dev/null
@@ -1,214 +0,0 @@
-/* sfi_acpi.c Simple Firmware Interface - ACPI extensions */
-
-/*
-
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  You should have received a copy of the GNU General Public License
-  along with this program; if not, write to the Free Software
-  Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
-  The full GNU General Public License is included in this distribution
-  in the file called LICENSE.GPL.
-
-  BSD LICENSE
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-
-*/
-
-#define KMSG_COMPONENT "SFI"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/sfi_acpi.h>
-#include "sfi_core.h"
-
-/*
- * SFI can access ACPI-defined tables via an optional ACPI XSDT.
- *
- * This allows re-use, and avoids re-definition, of standard tables.
- * For example, the "MCFG" table is defined by PCI, reserved by ACPI,
- * and is expected to be present many SFI-only systems.
- */
-
-static struct acpi_table_xsdt *xsdt_va __read_mostly;
-
-#define XSDT_GET_NUM_ENTRIES(ptable, entry_type) \
-	((ptable->header.length - sizeof(struct acpi_table_header)) / \
-	(sizeof(entry_type)))
-
-static inline struct sfi_table_header *acpi_to_sfi_th(
-				struct acpi_table_header *th)
-{
-	return (struct sfi_table_header *)th;
-}
-
-static inline struct acpi_table_header *sfi_to_acpi_th(
-				struct sfi_table_header *th)
-{
-	return (struct acpi_table_header *)th;
-}
-
-/*
- * sfi_acpi_parse_xsdt()
- *
- * Parse the ACPI XSDT for later access by sfi_acpi_table_parse().
- */
-static int __init sfi_acpi_parse_xsdt(struct sfi_table_header *th)
-{
-	struct sfi_table_key key = SFI_ANY_KEY;
-	int tbl_cnt, i;
-	void *ret;
-
-	xsdt_va = (struct acpi_table_xsdt *)th;
-	tbl_cnt = XSDT_GET_NUM_ENTRIES(xsdt_va, u64);
-	for (i = 0; i < tbl_cnt; i++) {
-		ret = sfi_check_table(xsdt_va->table_offset_entry[i], &key);
-		if (IS_ERR(ret)) {
-			disable_sfi();
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
-int __init sfi_acpi_init(void)
-{
-	struct sfi_table_key xsdt_key = { .sig = SFI_SIG_XSDT };
-
-	sfi_table_parse(SFI_SIG_XSDT, NULL, NULL, sfi_acpi_parse_xsdt);
-
-	/* Only call the get_table to keep the table mapped */
-	xsdt_va = (struct acpi_table_xsdt *)sfi_get_table(&xsdt_key);
-	return 0;
-}
-
-static struct acpi_table_header *sfi_acpi_get_table(struct sfi_table_key *key)
-{
-	u32 tbl_cnt, i;
-	void *ret;
-
-	tbl_cnt = XSDT_GET_NUM_ENTRIES(xsdt_va, u64);
-	for (i = 0; i < tbl_cnt; i++) {
-		ret = sfi_check_table(xsdt_va->table_offset_entry[i], key);
-		if (!IS_ERR(ret) && ret)
-			return sfi_to_acpi_th(ret);
-	}
-
-	return NULL;
-}
-
-static void sfi_acpi_put_table(struct acpi_table_header *table)
-{
-	sfi_put_table(acpi_to_sfi_th(table));
-}
-
-/*
- * sfi_acpi_table_parse()
- *
- * Find specified table in XSDT, run handler on it and return its return value
- */
-int sfi_acpi_table_parse(char *signature, char *oem_id, char *oem_table_id,
-			int(*handler)(struct acpi_table_header *))
-{
-	struct acpi_table_header *table = NULL;
-	struct sfi_table_key key;
-	int ret = 0;
-
-	if (sfi_disabled)
-		return -1;
-
-	key.sig = signature;
-	key.oem_id = oem_id;
-	key.oem_table_id = oem_table_id;
-
-	table = sfi_acpi_get_table(&key);
-	if (!table)
-		return -EINVAL;
-
-	ret = handler(table);
-	sfi_acpi_put_table(table);
-	return ret;
-}
-
-static ssize_t sfi_acpi_table_show(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr, char *buf,
-			       loff_t offset, size_t count)
-{
-	struct sfi_table_attr *tbl_attr =
-	    container_of(bin_attr, struct sfi_table_attr, attr);
-	struct acpi_table_header *th = NULL;
-	struct sfi_table_key key;
-	ssize_t cnt;
-
-	key.sig = tbl_attr->name;
-	key.oem_id = NULL;
-	key.oem_table_id = NULL;
-
-	th = sfi_acpi_get_table(&key);
-	if (!th)
-		return 0;
-
-	cnt =  memory_read_from_buffer(buf, count, &offset,
-					th, th->length);
-	sfi_acpi_put_table(th);
-
-	return cnt;
-}
-
-
-void __init sfi_acpi_sysfs_init(void)
-{
-	u32 tbl_cnt, i;
-	struct sfi_table_attr *tbl_attr;
-
-	tbl_cnt = XSDT_GET_NUM_ENTRIES(xsdt_va, u64);
-	for (i = 0; i < tbl_cnt; i++) {
-		tbl_attr =
-			sfi_sysfs_install_table(xsdt_va->table_offset_entry[i]);
-		tbl_attr->attr.read = sfi_acpi_table_show;
-	}
-
-	return;
-}
diff --git a/drivers/sfi/sfi_core.c b/drivers/sfi/sfi_core.c
deleted file mode 100644
index a5136901dd8a..000000000000
--- a/drivers/sfi/sfi_core.c
+++ /dev/null
@@ -1,522 +0,0 @@
-/* sfi_core.c Simple Firmware Interface - core internals */
-
-/*
-
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  You should have received a copy of the GNU General Public License
-  along with this program; if not, write to the Free Software
-  Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
-  The full GNU General Public License is included in this distribution
-  in the file called LICENSE.GPL.
-
-  BSD LICENSE
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-
-*/
-
-#define KMSG_COMPONENT "SFI"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
-
-#include <linux/memblock.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/acpi.h>
-#include <linux/init.h>
-#include <linux/sfi.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-
-#include "sfi_core.h"
-
-#define ON_SAME_PAGE(addr1, addr2) \
-	(((unsigned long)(addr1) & PAGE_MASK) == \
-	((unsigned long)(addr2) & PAGE_MASK))
-#define TABLE_ON_PAGE(page, table, size) (ON_SAME_PAGE(page, table) && \
-				ON_SAME_PAGE(page, table + size))
-
-int sfi_disabled __read_mostly;
-EXPORT_SYMBOL(sfi_disabled);
-
-static u64 syst_pa __read_mostly;
-static struct sfi_table_simple *syst_va __read_mostly;
-
-/*
- * FW creates and saves the SFI tables in memory. When these tables get
- * used, they may need to be mapped to virtual address space, and the mapping
- * can happen before or after the memremap() is ready, so a flag is needed
- * to indicating this
- */
-static u32 sfi_use_memremap __read_mostly;
-
-/*
- * sfi_un/map_memory calls early_memremap/memunmap which is a __init function
- * and introduces section mismatch. So use __ref to make it calm.
- */
-static void __iomem * __ref sfi_map_memory(u64 phys, u32 size)
-{
-	if (!phys || !size)
-		return NULL;
-
-	if (sfi_use_memremap)
-		return memremap(phys, size, MEMREMAP_WB);
-	else
-		return early_memremap(phys, size);
-}
-
-static void __ref sfi_unmap_memory(void __iomem *virt, u32 size)
-{
-	if (!virt || !size)
-		return;
-
-	if (sfi_use_memremap)
-		memunmap(virt);
-	else
-		early_memunmap(virt, size);
-}
-
-static void sfi_print_table_header(unsigned long long pa,
-				struct sfi_table_header *header)
-{
-	pr_info("%4.4s %llX, %04X (v%d %6.6s %8.8s)\n",
-		header->sig, pa,
-		header->len, header->rev, header->oem_id,
-		header->oem_table_id);
-}
-
-/*
- * sfi_verify_table()
- * Sanity check table lengh, calculate checksum
- */
-static int sfi_verify_table(struct sfi_table_header *table)
-{
-
-	u8 checksum = 0;
-	u8 *puchar = (u8 *)table;
-	u32 length = table->len;
-
-	/* Sanity check table length against arbitrary 1MB limit */
-	if (length > 0x100000) {
-		pr_err("Invalid table length 0x%x\n", length);
-		return -1;
-	}
-
-	while (length--)
-		checksum += *puchar++;
-
-	if (checksum) {
-		pr_err("Checksum %2.2X should be %2.2X\n",
-			table->csum, table->csum - checksum);
-		return -1;
-	}
-	return 0;
-}
-
-/*
- * sfi_map_table()
- *
- * Return address of mapped table
- * Check for common case that we can re-use mapping to SYST,
- * which requires syst_pa, syst_va to be initialized.
- */
-static struct sfi_table_header *sfi_map_table(u64 pa)
-{
-	struct sfi_table_header *th;
-	u32 length;
-
-	if (!TABLE_ON_PAGE(syst_pa, pa, sizeof(struct sfi_table_header)))
-		th = sfi_map_memory(pa, sizeof(struct sfi_table_header));
-	else
-		th = (void *)syst_va + (pa - syst_pa);
-
-	 /* If table fits on same page as its header, we are done */
-	if (TABLE_ON_PAGE(th, th, th->len))
-		return th;
-
-	/* Entire table does not fit on same page as SYST */
-	length = th->len;
-	if (!TABLE_ON_PAGE(syst_pa, pa, sizeof(struct sfi_table_header)))
-		sfi_unmap_memory(th, sizeof(struct sfi_table_header));
-
-	return sfi_map_memory(pa, length);
-}
-
-/*
- * sfi_unmap_table()
- *
- * Undoes effect of sfi_map_table() by unmapping table
- * if it did not completely fit on same page as SYST.
- */
-static void sfi_unmap_table(struct sfi_table_header *th)
-{
-	if (!TABLE_ON_PAGE(syst_va, th, th->len))
-		sfi_unmap_memory(th, TABLE_ON_PAGE(th, th, th->len) ?
-					sizeof(*th) : th->len);
-}
-
-static int sfi_table_check_key(struct sfi_table_header *th,
-				struct sfi_table_key *key)
-{
-
-	if (strncmp(th->sig, key->sig, SFI_SIGNATURE_SIZE)
-		|| (key->oem_id && strncmp(th->oem_id,
-				key->oem_id, SFI_OEM_ID_SIZE))
-		|| (key->oem_table_id && strncmp(th->oem_table_id,
-				key->oem_table_id, SFI_OEM_TABLE_ID_SIZE)))
-		return -1;
-
-	return 0;
-}
-
-/*
- * This function will be used in 2 cases:
- * 1. used to enumerate and verify the tables addressed by SYST/XSDT,
- *    thus no signature will be given (in kernel boot phase)
- * 2. used to parse one specific table, signature must exist, and
- *    the mapped virt address will be returned, and the virt space
- *    will be released by call sfi_put_table() later
- *
- * This two cases are from two different functions with two different
- * sections and causes section mismatch warning. So use __ref to tell
- * modpost not to make any noise.
- *
- * Return value:
- *	NULL:			when can't find a table matching the key
- *	ERR_PTR(error):		error value
- *	virt table address:	when a matched table is found
- */
-struct sfi_table_header *
- __ref sfi_check_table(u64 pa, struct sfi_table_key *key)
-{
-	struct sfi_table_header *th;
-	void *ret = NULL;
-
-	th = sfi_map_table(pa);
-	if (!th)
-		return ERR_PTR(-ENOMEM);
-
-	if (!key->sig) {
-		sfi_print_table_header(pa, th);
-		if (sfi_verify_table(th))
-			ret = ERR_PTR(-EINVAL);
-	} else {
-		if (!sfi_table_check_key(th, key))
-			return th;	/* Success */
-	}
-
-	sfi_unmap_table(th);
-	return ret;
-}
-
-/*
- * sfi_get_table()
- *
- * Search SYST for the specified table with the signature in
- * the key, and return the mapped table
- */
-struct sfi_table_header *sfi_get_table(struct sfi_table_key *key)
-{
-	struct sfi_table_header *th;
-	u32 tbl_cnt, i;
-
-	tbl_cnt = SFI_GET_NUM_ENTRIES(syst_va, u64);
-	for (i = 0; i < tbl_cnt; i++) {
-		th = sfi_check_table(syst_va->pentry[i], key);
-		if (!IS_ERR(th) && th)
-			return th;
-	}
-
-	return NULL;
-}
-
-void sfi_put_table(struct sfi_table_header *th)
-{
-	sfi_unmap_table(th);
-}
-
-/* Find table with signature, run handler on it */
-int sfi_table_parse(char *signature, char *oem_id, char *oem_table_id,
-			sfi_table_handler handler)
-{
-	struct sfi_table_header *table = NULL;
-	struct sfi_table_key key;
-	int ret = -EINVAL;
-
-	if (sfi_disabled || !handler || !signature)
-		goto exit;
-
-	key.sig = signature;
-	key.oem_id = oem_id;
-	key.oem_table_id = oem_table_id;
-
-	table = sfi_get_table(&key);
-	if (!table)
-		goto exit;
-
-	ret = handler(table);
-	sfi_put_table(table);
-exit:
-	return ret;
-}
-EXPORT_SYMBOL_GPL(sfi_table_parse);
-
-/*
- * sfi_parse_syst()
- * Checksum all the tables in SYST and print their headers
- *
- * success: set syst_va, return 0
- */
-static int __init sfi_parse_syst(void)
-{
-	struct sfi_table_key key = SFI_ANY_KEY;
-	int tbl_cnt, i;
-	void *ret;
-
-	syst_va = sfi_map_memory(syst_pa, sizeof(struct sfi_table_simple));
-	if (!syst_va)
-		return -ENOMEM;
-
-	tbl_cnt = SFI_GET_NUM_ENTRIES(syst_va, u64);
-	for (i = 0; i < tbl_cnt; i++) {
-		ret = sfi_check_table(syst_va->pentry[i], &key);
-		if (IS_ERR(ret))
-			return PTR_ERR(ret);
-	}
-
-	return 0;
-}
-
-/*
- * The OS finds the System Table by searching 16-byte boundaries between
- * physical address 0x000E0000 and 0x000FFFFF. The OS shall search this region
- * starting at the low address and shall stop searching when the 1st valid SFI
- * System Table is found.
- *
- * success: set syst_pa, return 0
- * fail: return -1
- */
-static __init int sfi_find_syst(void)
-{
-	unsigned long offset, len;
-	void *start;
-
-	len = SFI_SYST_SEARCH_END - SFI_SYST_SEARCH_BEGIN;
-	start = sfi_map_memory(SFI_SYST_SEARCH_BEGIN, len);
-	if (!start)
-		return -1;
-
-	for (offset = 0; offset < len; offset += 16) {
-		struct sfi_table_header *syst_hdr;
-
-		syst_hdr = start + offset;
-		if (strncmp(syst_hdr->sig, SFI_SIG_SYST,
-				SFI_SIGNATURE_SIZE))
-			continue;
-
-		if (syst_hdr->len > PAGE_SIZE)
-			continue;
-
-		sfi_print_table_header(SFI_SYST_SEARCH_BEGIN + offset,
-					syst_hdr);
-
-		if (sfi_verify_table(syst_hdr))
-			continue;
-
-		/*
-		 * Enforce SFI spec mandate that SYST reside within a page.
-		 */
-		if (!ON_SAME_PAGE(syst_pa, syst_pa + syst_hdr->len)) {
-			pr_info("SYST 0x%llx + 0x%x crosses page\n",
-					syst_pa, syst_hdr->len);
-			continue;
-		}
-
-		/* Success */
-		syst_pa = SFI_SYST_SEARCH_BEGIN + offset;
-		sfi_unmap_memory(start, len);
-		return 0;
-	}
-
-	sfi_unmap_memory(start, len);
-	return -1;
-}
-
-static struct kobject *sfi_kobj;
-static struct kobject *tables_kobj;
-
-static ssize_t sfi_table_show(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr, char *buf,
-			       loff_t offset, size_t count)
-{
-	struct sfi_table_attr *tbl_attr =
-	    container_of(bin_attr, struct sfi_table_attr, attr);
-	struct sfi_table_header *th = NULL;
-	struct sfi_table_key key;
-	ssize_t cnt;
-
-	key.sig = tbl_attr->name;
-	key.oem_id = NULL;
-	key.oem_table_id = NULL;
-
-	if (strncmp(SFI_SIG_SYST, tbl_attr->name, SFI_SIGNATURE_SIZE)) {
-		th = sfi_get_table(&key);
-		if (!th)
-			return 0;
-
-		cnt =  memory_read_from_buffer(buf, count, &offset,
-						th, th->len);
-		sfi_put_table(th);
-	} else
-		cnt =  memory_read_from_buffer(buf, count, &offset,
-					syst_va, syst_va->header.len);
-
-	return cnt;
-}
-
-struct sfi_table_attr __init *sfi_sysfs_install_table(u64 pa)
-{
-	struct sfi_table_attr *tbl_attr;
-	struct sfi_table_header *th;
-	int ret;
-
-	tbl_attr = kzalloc(sizeof(struct sfi_table_attr), GFP_KERNEL);
-	if (!tbl_attr)
-		return NULL;
-
-	th = sfi_map_table(pa);
-	if (!th || !th->sig[0]) {
-		kfree(tbl_attr);
-		return NULL;
-	}
-
-	sysfs_attr_init(&tbl_attr->attr.attr);
-	memcpy(tbl_attr->name, th->sig, SFI_SIGNATURE_SIZE);
-
-	tbl_attr->attr.size = 0;
-	tbl_attr->attr.read = sfi_table_show;
-	tbl_attr->attr.attr.name = tbl_attr->name;
-	tbl_attr->attr.attr.mode = 0400;
-
-	ret = sysfs_create_bin_file(tables_kobj,
-				  &tbl_attr->attr);
-	if (ret) {
-		kfree(tbl_attr);
-		tbl_attr = NULL;
-	}
-
-	sfi_unmap_table(th);
-	return tbl_attr;
-}
-
-static int __init sfi_sysfs_init(void)
-{
-	int tbl_cnt, i;
-
-	if (sfi_disabled)
-		return 0;
-
-	sfi_kobj = kobject_create_and_add("sfi", firmware_kobj);
-	if (!sfi_kobj)
-		return 0;
-
-	tables_kobj = kobject_create_and_add("tables", sfi_kobj);
-	if (!tables_kobj) {
-		kobject_put(sfi_kobj);
-		return 0;
-	}
-
-	sfi_sysfs_install_table(syst_pa);
-
-	tbl_cnt = SFI_GET_NUM_ENTRIES(syst_va, u64);
-
-	for (i = 0; i < tbl_cnt; i++)
-		sfi_sysfs_install_table(syst_va->pentry[i]);
-
-	sfi_acpi_sysfs_init();
-	kobject_uevent(sfi_kobj, KOBJ_ADD);
-	kobject_uevent(tables_kobj, KOBJ_ADD);
-	pr_info("SFI sysfs interfaces init success\n");
-	return 0;
-}
-
-void __init sfi_init(void)
-{
-	if (!acpi_disabled)
-		disable_sfi();
-
-	if (sfi_disabled)
-		return;
-
-	pr_info("Simple Firmware Interface v0.81 http://simplefirmware.org\n");
-
-	if (sfi_find_syst() || sfi_parse_syst() || sfi_platform_init())
-		disable_sfi();
-
-	return;
-}
-
-void __init sfi_init_late(void)
-{
-	int length;
-
-	if (sfi_disabled)
-		return;
-
-	length = syst_va->header.len;
-	sfi_unmap_memory(syst_va, sizeof(struct sfi_table_simple));
-
-	/* Use memremap now after it is ready */
-	sfi_use_memremap = 1;
-	syst_va = sfi_map_memory(syst_pa, length);
-
-	sfi_acpi_init();
-}
-
-/*
- * The reason we put it here because we need wait till the /sys/firmware
- * is setup, then our interface can be registered in /sys/firmware/sfi
- */
-core_initcall(sfi_sysfs_init);
diff --git a/drivers/sfi/sfi_core.h b/drivers/sfi/sfi_core.h
deleted file mode 100644
index 1d5cfe854cf7..000000000000
--- a/drivers/sfi/sfi_core.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* sfi_core.h Simple Firmware Interface, internal header */
-
-/*
-
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  You should have received a copy of the GNU General Public License
-  along with this program; if not, write to the Free Software
-  Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
-  The full GNU General Public License is included in this distribution
-  in the file called LICENSE.GPL.
-
-  BSD LICENSE
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-
-*/
-
-#include <linux/sysfs.h>
-
-struct sfi_table_key{
-	char	*sig;
-	char	*oem_id;
-	char	*oem_table_id;
-};
-
-/* sysfs interface */
-struct sfi_table_attr {
-	struct bin_attribute attr;
-	char name[8];
-};
-
-#define SFI_ANY_KEY { .sig = NULL, .oem_id = NULL, .oem_table_id = NULL }
-
-extern int __init sfi_acpi_init(void);
-extern  struct sfi_table_header *sfi_check_table(u64 paddr,
-					struct sfi_table_key *key);
-struct sfi_table_header *sfi_get_table(struct sfi_table_key *key);
-extern void sfi_put_table(struct sfi_table_header *table);
-extern struct sfi_table_attr __init *sfi_sysfs_install_table(u64 pa);
-extern void __init sfi_acpi_sysfs_init(void);
diff --git a/include/linux/sfi.h b/include/linux/sfi.h
deleted file mode 100644
index e0e1597ef9e6..000000000000
--- a/include/linux/sfi.h
+++ /dev/null
@@ -1,210 +0,0 @@
-/* sfi.h Simple Firmware Interface */
-
-/*
-
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  You should have received a copy of the GNU General Public License
-  along with this program; if not, write to the Free Software
-  Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
-  The full GNU General Public License is included in this distribution
-  in the file called LICENSE.GPL.
-
-  BSD LICENSE
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-
-*/
-
-#ifndef _LINUX_SFI_H
-#define _LINUX_SFI_H
-
-#include <linux/init.h>
-#include <linux/types.h>
-
-/* Table signatures reserved by the SFI specification */
-#define SFI_SIG_SYST		"SYST"
-#define SFI_SIG_FREQ		"FREQ"
-#define SFI_SIG_IDLE		"IDLE"
-#define SFI_SIG_CPUS		"CPUS"
-#define SFI_SIG_MTMR		"MTMR"
-#define SFI_SIG_MRTC		"MRTC"
-#define SFI_SIG_MMAP		"MMAP"
-#define SFI_SIG_APIC		"APIC"
-#define SFI_SIG_XSDT		"XSDT"
-#define SFI_SIG_WAKE		"WAKE"
-#define SFI_SIG_DEVS		"DEVS"
-#define SFI_SIG_GPIO		"GPIO"
-
-#define SFI_SIGNATURE_SIZE	4
-#define SFI_OEM_ID_SIZE		6
-#define SFI_OEM_TABLE_ID_SIZE	8
-
-#define SFI_NAME_LEN		16
-
-#define SFI_SYST_SEARCH_BEGIN		0x000E0000
-#define SFI_SYST_SEARCH_END		0x000FFFFF
-
-#define SFI_GET_NUM_ENTRIES(ptable, entry_type) \
-	((ptable->header.len - sizeof(struct sfi_table_header)) / \
-	(sizeof(entry_type)))
-/*
- * Table structures must be byte-packed to match the SFI specification,
- * as they are provided by the BIOS.
- */
-struct sfi_table_header {
-	char	sig[SFI_SIGNATURE_SIZE];
-	u32	len;
-	u8	rev;
-	u8	csum;
-	char	oem_id[SFI_OEM_ID_SIZE];
-	char	oem_table_id[SFI_OEM_TABLE_ID_SIZE];
-} __packed;
-
-struct sfi_table_simple {
-	struct sfi_table_header		header;
-	u64				pentry[1];
-} __packed;
-
-/* Comply with UEFI spec 2.1 */
-struct sfi_mem_entry {
-	u32	type;
-	u64	phys_start;
-	u64	virt_start;
-	u64	pages;
-	u64	attrib;
-} __packed;
-
-struct sfi_cpu_table_entry {
-	u32	apic_id;
-} __packed;
-
-struct sfi_cstate_table_entry {
-	u32	hint;		/* MWAIT hint */
-	u32	latency;	/* latency in ms */
-} __packed;
-
-struct sfi_apic_table_entry {
-	u64	phys_addr;	/* phy base addr for APIC reg */
-} __packed;
-
-struct sfi_freq_table_entry {
-	u32	freq_mhz;	/* in MHZ */
-	u32	latency;	/* transition latency in ms */
-	u32	ctrl_val;	/* value to write to PERF_CTL */
-} __packed;
-
-struct sfi_wake_table_entry {
-	u64	phys_addr;	/* pointer to where the wake vector locates */
-} __packed;
-
-struct sfi_timer_table_entry {
-	u64	phys_addr;	/* phy base addr for the timer */
-	u32	freq_hz;	/* in HZ */
-	u32	irq;
-} __packed;
-
-struct sfi_rtc_table_entry {
-	u64	phys_addr;	/* phy base addr for the RTC */
-	u32	irq;
-} __packed;
-
-struct sfi_device_table_entry {
-	u8	type;		/* bus type, I2C, SPI or ...*/
-#define SFI_DEV_TYPE_SPI	0
-#define SFI_DEV_TYPE_I2C	1
-#define SFI_DEV_TYPE_UART	2
-#define SFI_DEV_TYPE_HSI	3
-#define SFI_DEV_TYPE_IPC	4
-#define SFI_DEV_TYPE_SD		5
-
-	u8	host_num;	/* attached to host 0, 1...*/
-	u16	addr;
-	u8	irq;
-	u32	max_freq;
-	char	name[SFI_NAME_LEN];
-} __packed;
-
-struct sfi_gpio_table_entry {
-	char	controller_name[SFI_NAME_LEN];
-	u16	pin_no;
-	char	pin_name[SFI_NAME_LEN];
-} __packed;
-
-typedef int (*sfi_table_handler) (struct sfi_table_header *table);
-
-#ifdef CONFIG_SFI
-extern void __init sfi_init(void);
-extern int __init sfi_platform_init(void);
-extern void __init sfi_init_late(void);
-extern int sfi_table_parse(char *signature, char *oem_id, char *oem_table_id,
-				sfi_table_handler handler);
-
-extern int sfi_disabled;
-static inline void disable_sfi(void)
-{
-	sfi_disabled = 1;
-}
-
-#else /* !CONFIG_SFI */
-
-static inline void sfi_init(void)
-{
-}
-
-static inline void sfi_init_late(void)
-{
-}
-
-#define sfi_disabled	0
-
-static inline int sfi_table_parse(char *signature, char *oem_id,
-					char *oem_table_id,
-					sfi_table_handler handler)
-{
-	return -1;
-}
-
-#endif /* !CONFIG_SFI */
-
-#endif /*_LINUX_SFI_H*/
diff --git a/include/linux/sfi_acpi.h b/include/linux/sfi_acpi.h
deleted file mode 100644
index a6e555cbe05c..000000000000
--- a/include/linux/sfi_acpi.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/* sfi.h Simple Firmware Interface */
-
-/*
-
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  You should have received a copy of the GNU General Public License
-  along with this program; if not, write to the Free Software
-  Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
-  The full GNU General Public License is included in this distribution
-  in the file called LICENSE.GPL.
-
-  BSD LICENSE
-
-  Copyright(c) 2009 Intel Corporation. All rights reserved.
-
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-
-*/
-
-#ifndef _LINUX_SFI_ACPI_H
-#define _LINUX_SFI_ACPI_H
-
-#include <linux/acpi.h>
-#include <linux/sfi.h>
-
-#ifdef CONFIG_SFI
-extern int sfi_acpi_table_parse(char *signature, char *oem_id,
-				char *oem_table_id,
-				int (*handler)(struct acpi_table_header *));
-
-static inline int __init acpi_sfi_table_parse(char *signature,
-				int (*handler)(struct acpi_table_header *))
-{
-	if (!acpi_table_parse(signature, handler))
-		return 0;
-
-	return sfi_acpi_table_parse(signature, NULL, NULL, handler);
-}
-#else /* !CONFIG_SFI */
-static inline int sfi_acpi_table_parse(char *signature, char *oem_id,
-				char *oem_table_id,
-				int (*handler)(struct acpi_table_header *))
-{
-	return -1;
-}
-
-static inline int __init acpi_sfi_table_parse(char *signature,
-				int (*handler)(struct acpi_table_header *))
-{
-	return acpi_table_parse(signature, handler);
-}
-#endif /* !CONFIG_SFI */
-
-#endif /*_LINUX_SFI_ACPI_H*/
diff --git a/init/main.c b/init/main.c
index 6feee7f11eaf..d7001b37be14 100644
--- a/init/main.c
+++ b/init/main.c
@@ -74,7 +74,6 @@
 #include <linux/kgdb.h>
 #include <linux/ftrace.h>
 #include <linux/async.h>
-#include <linux/sfi.h>
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
@@ -1054,7 +1053,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
-	sfi_init_late();
 	kcsan_init();
 
 	/* Do the rest non-__init'ed, we're now alive */
-- 
2.30.0

