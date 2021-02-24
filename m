Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ADC324106
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 17:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhBXPhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 10:37:13 -0500
Received: from mail-oo1-f50.google.com ([209.85.161.50]:35601 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbhBXPAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 10:00:13 -0500
Received: by mail-oo1-f50.google.com with SMTP id p6so581835oot.2;
        Wed, 24 Feb 2021 06:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=x8wk0TVcIdb1GKDmKArjfnqooeMBnJezjO1YWPQoUSk=;
        b=cr+BkuXVyepACC3+3Q2N3dAjLwRz37QyYnclH9522aAB/+UdtpLeJBgDKfmtA/lfh4
         rB6bJeG0DBxjmPUAjwYQc5msZl9/M9rHSKT/K1J1r682GNulEg1mdAry1kFC+aFdaUzh
         9jL+wp6GWpm3TrPDNJLhl1lJhhvjH2oWl+UpcFp3w6/F0tJ0yyGaYGJOKHthTsxV5tKj
         HYnULB/30sMpYKhUXmLtelKYbSv8tntp2aPqW+um8SmFRfHwcxXZqt2lUbr7uJmk+SdC
         e6Y2q7vSZASQEApleTvsTsgNOA9FpiYasqRdKNxhBQjsIXrhgXlvgT6FpmL4SS69TM+h
         fywQ==
X-Gm-Message-State: AOAM5308oYXCeqlFa7yWg7UN0Pxs7jZBnhDjlXJpF2e0argEd37n4jK2
        SomjPikEeLD6p4OeR5rwHjsbP0s5No8UW53Mg/HPR2IjgLw=
X-Google-Smtp-Source: ABdhPJwOwR8CMhQTqpp0dKomeqseQYg/x5VjmkNE2mV14yjxEyBUyubss00w3R1/TsgxT1k3G7RWK28Nz+V0qoVGOBg=
X-Received: by 2002:a4a:e939:: with SMTP id a25mr7973861ooe.44.1614178766149;
 Wed, 24 Feb 2021 06:59:26 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Feb 2021 15:59:15 +0100
Message-ID: <CAJZ5v0j-pXGo4EFkwS23xWuhmw8ZgS8PPxE0NqQuj_3gzH+gMA@mail.gmail.com>
Subject: [GIT PULL] Simple Firmware Interface (SFI) support removal for v5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 sfi-removal-5.12-rc1

with top-most commit c9c26882776a7adddb0173778957e690ac47b195

 x86/platform/intel-mid: Update Copyright year and drop file names

on top of commit 92bf22614b21a2706f4993b278017e437f7785b3

 Linux 5.11-rc7

to receive Simple Firmware Interface (SFI) support removal for v5.12-rc1.

This drops support for deprecated platforms using SFI, drops the
entire support for SFI that has been long deprecated too and makes
some janitorial changes on top of that.

All of the commits in this batch come from Andy Shevchenko and
some of them have been merged into your tree already through the
platform-drivers-x86 tree.

There are two merge conflicts between this material and your tree, but
they are straightforward to resolve: please delete the

 arch/x86/platform/intel-mid/device_libs/platform_bt.c

file and drop the SFI entry from MAINTAINERS altogether.

Thanks!


---------------

Andy Shevchenko (32):
      drm/gma500: Convert to use new SCU IPC API
      drm/gma500: Get rid of duplicate NULL checks
      gpio: intel-mid: Remove driver for deprecated platform
      gpio: msic: Remove driver for deprecated platform
      platform/x86: intel_mid_thermal: Remove driver for deprecated platform
      platform/x86: intel_mid_powerbtn: Remove driver for deprecated platform
      rtc: mrst: Remove driver for deprecated platform
      watchdog: intel_scu_watchdog: Remove driver for deprecated platform
      watchdog: intel-mid_wdt: Postpone IRQ handler registration till
SCU is ready
      platform/x86: intel_scu_wdt: Move driver from arch/x86
      platform/x86: intel_scu_wdt: Drop SCU notification
      platform/x86: intel_scu_wdt: Get rid of custom x86 model comparison
      platform/x86: intel_scu_wdt: Drop mistakenly added const
      x86/platform/intel-mid: Remove unused leftovers (msic_audio)
      x86/platform/intel-mid: Remove unused leftovers (msic_ocd)
      x86/platform/intel-mid: Remove unused leftovers (msic_battery)
      x86/platform/intel-mid: Remove unused leftovers (msic_gpio)
      x86/platform/intel-mid: Remove unused leftovers (msic_power_btn)
      x86/platform/intel-mid: Remove unused leftovers (msic_thermal)
      x86/platform/intel-mid: Remove unused leftovers (msic)
      x86/platform/intel-mid: Remove unused leftovers (vRTC)
      x86/apb_timer: Remove driver for deprecated platform
      mfd: intel_msic: Remove driver for deprecated platform
      media: atomisp: Remove unused header
      cpufreq: sfi-cpufreq: Remove driver for deprecated firmware
      sfi: Remove framework for deprecated firmware
      x86/PCI: Get rid of custom x86 model comparison
      x86/PCI: Describe @reg for type1_access_ok()
      x86/platform/intel-mid: Get rid of intel_scu_ipc_legacy.h
      x86/platform/intel-mid: Drop unused __intel_mid_cpu_chip and Co.
      x86/platform/intel-mid: Remove unused header inclusion in intel-mid.h
      x86/platform/intel-mid: Update Copyright year and drop file names

---------------

 Documentation/ABI/testing/sysfs-firmware-sfi       |  15 -
 Documentation/ABI/testing/sysfs-platform-kim       |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    |   6 -
 MAINTAINERS                                        |  11 -
 arch/x86/Kconfig                                   |  19 +-
 arch/x86/include/asm/apb_timer.h                   |  40 --
 arch/x86/include/asm/fixmap.h                      |   3 -
 arch/x86/include/asm/intel-mid.h                   |  93 +---
 arch/x86/include/asm/intel_mid_vrtc.h              |  10 -
 arch/x86/include/asm/intel_scu_ipc.h               |   2 -
 arch/x86/include/asm/intel_scu_ipc_legacy.h        |  91 ----
 arch/x86/include/asm/platform_sst_audio.h          |   2 -
 arch/x86/kernel/Makefile                           |   1 -
 arch/x86/kernel/apb_timer.c                        | 347 -------------
 arch/x86/kernel/apic/io_apic.c                     |   4 +-
 arch/x86/kernel/setup.c                            |   2 -
 arch/x86/pci/intel_mid_pci.c                       |  18 +-
 arch/x86/pci/mmconfig-shared.c                     |   6 +-
 arch/x86/platform/Makefile                         |   1 -
 arch/x86/platform/intel-mid/Makefile               |   7 +-
 arch/x86/platform/intel-mid/device_libs/Makefile   |  33 --
 .../intel-mid/device_libs/platform_bcm43xx.c       | 101 ----
 .../intel-mid/device_libs/platform_bma023.c        |  16 -
 .../platform/intel-mid/device_libs/platform_bt.c   | 101 ----
 .../intel-mid/device_libs/platform_emc1403.c       |  39 --
 .../intel-mid/device_libs/platform_gpio_keys.c     |  81 ---
 .../intel-mid/device_libs/platform_lis331.c        |  37 --
 .../intel-mid/device_libs/platform_max7315.c       |  77 ---
 .../intel-mid/device_libs/platform_mpu3050.c       |  32 --
 .../intel-mid/device_libs/platform_mrfld_pinctrl.c |  39 --
 .../device_libs/platform_mrfld_power_btn.c         |  78 ---
 .../intel-mid/device_libs/platform_mrfld_rtc.c     |  44 --
 .../intel-mid/device_libs/platform_mrfld_sd.c      |  43 --
 .../intel-mid/device_libs/platform_mrfld_spidev.c  |  50 --
 .../platform/intel-mid/device_libs/platform_msic.c |  83 ---
 .../platform/intel-mid/device_libs/platform_msic.h |  15 -
 .../intel-mid/device_libs/platform_msic_audio.c    |  42 --
 .../intel-mid/device_libs/platform_msic_battery.c  |  32 --
 .../intel-mid/device_libs/platform_msic_gpio.c     |  43 --
 .../intel-mid/device_libs/platform_msic_ocd.c      |  44 --
 .../device_libs/platform_msic_power_btn.c          |  31 --
 .../intel-mid/device_libs/platform_msic_thermal.c  |  32 --
 .../intel-mid/device_libs/platform_pcal9555a.c     |  95 ----
 .../intel-mid/device_libs/platform_tc35876x.c      |  42 --
 .../intel-mid/device_libs/platform_tca6416.c       |  53 --
 arch/x86/platform/intel-mid/intel-mid.c            | 106 +---
 arch/x86/platform/intel-mid/intel_mid_vrtc.c       | 173 -------
 arch/x86/platform/intel-mid/sfi.c                  | 543 --------------------
 arch/x86/platform/sfi/Makefile                     |   2 -
 arch/x86/platform/sfi/sfi.c                        | 100 ----
 drivers/Makefile                                   |   2 +-
 drivers/cpufreq/Kconfig.x86                        |  10 -
 drivers/cpufreq/Makefile                           |   1 -
 drivers/cpufreq/sfi-cpufreq.c                      | 127 -----
 drivers/gpio/Kconfig                               |  14 -
 drivers/gpio/Makefile                              |   1 -
 drivers/gpio/TODO                                  |   2 +-
 drivers/gpio/gpio-intel-mid.c                      | 414 ---------------
 drivers/gpio/gpio-msic.c                           | 314 ------------
 drivers/gpu/drm/gma500/Kconfig                     |   1 +
 drivers/gpu/drm/gma500/mdfld_device.c              |   2 -
 drivers/gpu/drm/gma500/mdfld_dsi_output.c          |   2 -
 drivers/gpu/drm/gma500/mdfld_output.c              |   8 +-
 drivers/gpu/drm/gma500/oaktrail_device.c           |   3 -
 drivers/gpu/drm/gma500/psb_drv.h                   |   3 +
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c         |  30 +-
 drivers/mfd/Kconfig                                |   9 -
 drivers/mfd/Makefile                               |   1 -
 drivers/mfd/intel_msic.c                           | 425 ----------------
 drivers/platform/x86/Kconfig                       |  23 +-
 drivers/platform/x86/Makefile                      |   3 +-
 drivers/platform/x86/intel_mid_powerbtn.c          | 233 ---------
 drivers/platform/x86/intel_mid_thermal.c           | 560 ---------------------
 drivers/platform/x86/intel_scu_pcidrv.c            |  22 +-
 .../platform/x86/intel_scu_wdt.c                   |  41 +-
 drivers/rtc/Kconfig                                |  12 -
 drivers/rtc/Makefile                               |   1 -
 drivers/rtc/rtc-mrst.c                             | 521 -------------------
 drivers/sfi/Kconfig                                |  18 -
 drivers/sfi/Makefile                               |   4 -
 drivers/sfi/sfi_acpi.c                             | 214 --------
 drivers/sfi/sfi_core.c                             | 522 -------------------
 drivers/sfi/sfi_core.h                             |  81 ---
 .../media/atomisp/include/linux/atomisp_platform.h |   1 -
 drivers/watchdog/Kconfig                           |   9 -
 drivers/watchdog/Makefile                          |   1 -
 drivers/watchdog/intel-mid_wdt.c                   |   8 +-
 drivers/watchdog/intel_scu_watchdog.c              | 533 --------------------
 drivers/watchdog/intel_scu_watchdog.h              |  50 --
 include/linux/mfd/intel_msic.h                     | 453 -----------------
 include/linux/sfi.h                                | 210 --------
 include/linux/sfi_acpi.h                           |  93 ----
 init/main.c                                        |   2 -
 93 files changed, 95 insertions(+), 7776 deletions(-)
