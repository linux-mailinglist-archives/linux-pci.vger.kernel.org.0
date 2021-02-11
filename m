Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEEA318C8F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhBKNt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:49:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:57467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhBKNoo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:44:44 -0500
IronPort-SDR: V9Z0MDazPefcEiPOmT5mVNW9/VA/Iv0T/aHD8t2RfthU+hZWhwlpZKcTKHL9B0NJ3obcSLmv7s
 hw2x/WEIQnmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179681627"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="179681627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:40:55 -0800
IronPort-SDR: 3/g9rHoUGKCSLDwy9exsPNdZsAkp4+g0aD3JWJOZicKdIuLCuFfEZZbCmb06NH4DcpVJ8FpSel
 UyTPHtK/594A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="362505796"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2021 05:40:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2FFBDE; Thu, 11 Feb 2021 15:40:45 +0200 (EET)
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
Subject: [PATCH v1 0/9] x86/platform: Remove SFI framework and users
Date:   Thu, 11 Feb 2021 15:39:59 +0200
Message-Id: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is last part of Intel MID (SFI based) removal. We have no more users of it
in the kernel and since SFI has been marked Obsolete for a few years already,
Remove all the stuff altogether.

Note, the more recent platforms (Intel Merrifield and Moorefield) still work as
long as they provide correct ACPI tables.

The series requires two prerequisite branches to be pulled first, i.e.
- one form Rafael's PM tree (currently bleeding-edge)
- one form TIP tree (x86/platform), actually only one patch is needed from it

Due to above it's convenient to proceed all of these via Rafael's PM tree,

Note, atomisp change is tagged by Sakari on behalf of media tree maintainers.

Andy Shevchenko (9):
  media: atomisp: Remove unused header
  cpufreq: sfi-cpufreq: Remove driver for deprecated firmware
  sfi: Remove framework for deprecated firmware
  x86/PCI: Get rid of custom x86 model comparison
  x86/PCI: Describe @reg for type1_access_ok()
  x86/platform/intel-mid: Get rid of intel_scu_ipc_legacy.h
  x86/platform/intel-mid: Drop unused __intel_mid_cpu_chip and Co.
  x86/platform/intel-mid: Remove unused header inclusion in intel-mid.h
  x86/platform/intel-mid: Update Copyright year and drop file names

 Documentation/ABI/testing/sysfs-firmware-sfi  |  15 -
 Documentation/ABI/testing/sysfs-platform-kim  |   2 +-
 MAINTAINERS                                   |   7 -
 arch/x86/Kconfig                              |   7 +-
 arch/x86/include/asm/intel-mid.h              |  65 +--
 arch/x86/include/asm/intel_scu_ipc.h          |   2 -
 arch/x86/include/asm/intel_scu_ipc_legacy.h   |  74 ---
 arch/x86/include/asm/platform_sst_audio.h     |   2 -
 arch/x86/kernel/apic/io_apic.c                |   4 +-
 arch/x86/kernel/setup.c                       |   2 -
 arch/x86/pci/intel_mid_pci.c                  |  18 +-
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
 arch/x86/platform/intel-mid/intel-mid.c       |  27 +-
 arch/x86/platform/intel-mid/sfi.c             | 419 --------------
 arch/x86/platform/sfi/Makefile                |   2 -
 arch/x86/platform/sfi/sfi.c                   | 100 ----
 drivers/Makefile                              |   2 +-
 drivers/cpufreq/Kconfig.x86                   |  10 -
 drivers/cpufreq/Makefile                      |   1 -
 drivers/cpufreq/sfi-cpufreq.c                 | 127 -----
 drivers/platform/x86/intel_scu_pcidrv.c       |  22 +-
 drivers/sfi/Kconfig                           |  18 -
 drivers/sfi/Makefile                          |   4 -
 drivers/sfi/sfi_acpi.c                        | 214 -------
 drivers/sfi/sfi_core.c                        | 522 ------------------
 drivers/sfi/sfi_core.h                        |  81 ---
 .../atomisp/include/linux/atomisp_platform.h  |   1 -
 include/linux/sfi.h                           | 210 -------
 include/linux/sfi_acpi.h                      |  93 ----
 init/main.c                                   |   2 -
 48 files changed, 37 insertions(+), 2901 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-firmware-sfi
 delete mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
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
 delete mode 100644 drivers/cpufreq/sfi-cpufreq.c
 delete mode 100644 drivers/sfi/Kconfig
 delete mode 100644 drivers/sfi/Makefile
 delete mode 100644 drivers/sfi/sfi_acpi.c
 delete mode 100644 drivers/sfi/sfi_core.c
 delete mode 100644 drivers/sfi/sfi_core.h
 delete mode 100644 include/linux/sfi.h
 delete mode 100644 include/linux/sfi_acpi.h

-- 
2.30.0

