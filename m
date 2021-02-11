Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD1318C76
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhBKNpy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:45:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:43775 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhBKNnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:43:02 -0500
IronPort-SDR: bC50qNqB7Mb6NHZ5TnrMZ28RKqiX7LBMV3QNeddoWBJi9yFfYNYuA0KpFR3ujyeUzLhA0M5M+u
 hOUV6KmR1AjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="182311181"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="182311181"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:41:00 -0800
IronPort-SDR: 9ZUuSvDftvalgJABQz+ZGjkBCy7K976RWT4DxqHDy2UgScMEiMSF7GlPuuZWZVoCYw382fU0Qe
 oH+FP5dWP+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="414807185"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2021 05:40:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 29942525; Thu, 11 Feb 2021 15:40:46 +0200 (EET)
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
Subject: [PATCH v1 7/9] x86/platform/intel-mid: Drop unused __intel_mid_cpu_chip and Co.
Date:   Thu, 11 Feb 2021 15:40:06 +0200
Message-Id: <20210211134008.38282-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since there is no more user of this global variable and associated custom API,
we may safely drop this legacy reinvented a wheel from the kernel sources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-mid.h        | 23 -----------------------
 arch/x86/platform/intel-mid/intel-mid.c | 17 -----------------
 2 files changed, 40 deletions(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 6306fe3e5c4a..c2c7da4c60cf 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -21,36 +21,13 @@ extern void intel_mid_pwr_power_off(void);
 
 extern int intel_mid_pwr_get_lss_id(struct pci_dev *pdev);
 
-/*
- * Medfield is the follow-up of Moorestown, it combines two chip solution into
- * one. Other than that it also added always-on and constant tsc and lapic
- * timers. Medfield is the platform name, and the chip name is called Penwell
- * we treat Medfield/Penwell as a variant of Moorestown. Penwell can be
- * identified via MSRs.
- */
-enum intel_mid_cpu_type {
-	/* 1 was Moorestown */
-	INTEL_MID_CPU_CHIP_PENWELL = 2,
-	INTEL_MID_CPU_CHIP_CLOVERVIEW,
-	INTEL_MID_CPU_CHIP_TANGIER,
-};
-
-extern enum intel_mid_cpu_type __intel_mid_cpu_chip;
-
 #ifdef CONFIG_X86_INTEL_MID
 
-static inline enum intel_mid_cpu_type intel_mid_identify_cpu(void)
-{
-	return __intel_mid_cpu_chip;
-}
-
 extern void intel_scu_devices_create(void);
 extern void intel_scu_devices_destroy(void);
 
 #else /* !CONFIG_X86_INTEL_MID */
 
-#define intel_mid_identify_cpu()	0
-
 static inline void intel_scu_devices_create(void) { }
 static inline void intel_scu_devices_destroy(void) { }
 
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 846b2ded39d9..2802b5e4637b 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -32,9 +32,6 @@
 #define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
 #define IPCMSG_COLD_RESET	0xF1
 
-enum intel_mid_cpu_type __intel_mid_cpu_chip;
-EXPORT_SYMBOL_GPL(__intel_mid_cpu_chip);
-
 static void intel_mid_power_off(void)
 {
 	/* Shut down South Complex via PWRMU */
@@ -58,29 +55,15 @@ static void __init intel_mid_time_init(void)
 
 static void intel_mid_arch_setup(void)
 {
-	if (boot_cpu_data.x86 != 6) {
-		pr_err("Unknown Intel MID CPU (%d:%d), default to Penwell\n",
-			boot_cpu_data.x86, boot_cpu_data.x86_model);
-		__intel_mid_cpu_chip = INTEL_MID_CPU_CHIP_PENWELL;
-		goto out;
-	}
-
 	switch (boot_cpu_data.x86_model) {
-	case 0x35:
-		__intel_mid_cpu_chip = INTEL_MID_CPU_CHIP_CLOVERVIEW;
-		break;
 	case 0x3C:
 	case 0x4A:
-		__intel_mid_cpu_chip = INTEL_MID_CPU_CHIP_TANGIER;
 		x86_platform.legacy.rtc = 1;
 		break;
-	case 0x27:
 	default:
-		__intel_mid_cpu_chip = INTEL_MID_CPU_CHIP_PENWELL;
 		break;
 	}
 
-out:
 	/*
 	 * Intel MID platforms are using explicitly defined regulators.
 	 *
-- 
2.30.0

