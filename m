Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAA4318C62
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhBKNow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:44:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:56478 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232026AbhBKNnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:43:02 -0500
IronPort-SDR: XkVU4VSYVPpARR5lOA6zRSEb58ZVWbJ95gDhj2U4uDGn1U1/yh7EJj3OXJMjeKWkItBEb7kfuN
 hX4ZngGhQ04A==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="178731262"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="178731262"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:41:01 -0800
IronPort-SDR: VWhaioO+oACEH+FId/XxethvES2OPKfJQ0apJjL8JKKIMG0NfzCUT/eN9mGWWw/JS5kAxxlDxH
 AwFiWCD4tUZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="380658742"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 11 Feb 2021 05:40:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1EA8A4BE; Thu, 11 Feb 2021 15:40:46 +0200 (EET)
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
Subject: [PATCH v1 6/9] x86/platform/intel-mid: Get rid of intel_scu_ipc_legacy.h
Date:   Thu, 11 Feb 2021 15:40:05 +0200
Message-Id: <20210211134008.38282-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The header is used by a single user. Move header content to that user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h        |  2 --
 arch/x86/include/asm/intel_scu_ipc_legacy.h | 18 ------------------
 arch/x86/platform/intel-mid/intel-mid.c     |  7 +++++--
 3 files changed, 5 insertions(+), 22 deletions(-)
 delete mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index 11d457af68c5..8537f597d20a 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -65,6 +65,4 @@ static inline int intel_scu_ipc_dev_command(struct intel_scu_ipc_dev *scu, int c
 						   inlen, out, outlen);
 }
 
-#include <asm/intel_scu_ipc_legacy.h>
-
 #endif
diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
deleted file mode 100644
index fa529e5ec142..000000000000
--- a/arch/x86/include/asm/intel_scu_ipc_legacy.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
-#define _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
-
-#include <linux/types.h>
-
-#define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
-#define IPCMSG_COLD_RESET	0xF1
-
-/* Don't call these in new code - they will be removed eventually */
-
-/* Issue commands to the SCU with or without data */
-static inline int intel_scu_ipc_simple_command(int cmd, int sub)
-{
-	return intel_scu_ipc_dev_simple_command(NULL, cmd, sub);
-}
-
-#endif
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 2c044e260b4b..846b2ded39d9 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -29,6 +29,9 @@
 #include <asm/intel_scu_ipc.h>
 #include <asm/reboot.h>
 
+#define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
+#define IPCMSG_COLD_RESET	0xF1
+
 enum intel_mid_cpu_type __intel_mid_cpu_chip;
 EXPORT_SYMBOL_GPL(__intel_mid_cpu_chip);
 
@@ -38,12 +41,12 @@ static void intel_mid_power_off(void)
 	intel_mid_pwr_power_off();
 
 	/* Only for Tangier, the rest will ignore this command */
-	intel_scu_ipc_simple_command(IPCMSG_COLD_OFF, 1);
+	intel_scu_ipc_dev_simple_command(NULL, IPCMSG_COLD_OFF, 1);
 };
 
 static void intel_mid_reboot(void)
 {
-	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
+	intel_scu_ipc_dev_simple_command(NULL, IPCMSG_COLD_RESET, 0);
 }
 
 static void __init intel_mid_time_init(void)
-- 
2.30.0

