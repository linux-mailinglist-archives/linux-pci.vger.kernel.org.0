Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56DA318E92
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBKP3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 10:29:33 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43719 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhBKPZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 10:25:22 -0500
Received: by mail-ot1-f50.google.com with SMTP id l23so5434365otn.10;
        Thu, 11 Feb 2021 07:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQ9USaj8aoRMWJzKKwNkcbQFrxvetYryQTdhS4q9G7A=;
        b=iUrM01+Hr/rWD/bUZTfuHqrbEoa8Nm7F3yiHVWcTrnNMefNqn1XRNNTBc3sklwOprz
         KqmnjsHn3ZjrE1uOvD8zF1g8cmuqbqQTreZKBGktIF6si009XwRrByqlbhVP2u3kIUiU
         GBQkHSRcKNR03UqufkB0nISyJK+vR52/4z/kxr+PHxKRFt0Ehg8Zg0dvqCoeqPV8rZw4
         0Twbsv7q/sEuagq+6gVK11QDPA2Ugh5+KVx84WYJe1g4a3eRTyq+8WT1IrKRCSHdJRfr
         pLdEDJ+q3p2jPbH05f5k1XrPyo1QXcHeQ1QSwVC9h4MC2lOezF1kcARboCTD7yIIcnV9
         RcIg==
X-Gm-Message-State: AOAM531swaetPrCjXW1g70ptOySNiFYbrhC9t2dasuYpJqYdu3WC9Nur
        COrPBiKtujp9IFMeWAKRx9JigNitcb1JPt863co=
X-Google-Smtp-Source: ABdhPJx/Qv3WQLwulqK/jrqspjtA9/BhSoJkBeqS067Mfk/d5YZpSsZrbk+80BXNc0a2mZa+QbnkdQi4qFhLhIw2oNs=
X-Received: by 2002:a05:6830:1481:: with SMTP id s1mr6255740otq.206.1613057080591;
 Thu, 11 Feb 2021 07:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Feb 2021 16:24:29 +0100
Message-ID: <CAJZ5v0gzd0Xwd006P3PUutKcVRqLNxmREBB-QW85BRMBArbBVw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] x86/platform: Remove SFI framework and users
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 2:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This is last part of Intel MID (SFI based) removal. We have no more users of it
> in the kernel and since SFI has been marked Obsolete for a few years already,
> Remove all the stuff altogether.
>
> Note, the more recent platforms (Intel Merrifield and Moorefield) still work as
> long as they provide correct ACPI tables.
>
> The series requires two prerequisite branches to be pulled first, i.e.
> - one form Rafael's PM tree (currently bleeding-edge)
> - one form TIP tree (x86/platform), actually only one patch is needed from it
>
> Due to above it's convenient to proceed all of these via Rafael's PM tree,
>
> Note, atomisp change is tagged by Sakari on behalf of media tree maintainers.
>
> Andy Shevchenko (9):
>   media: atomisp: Remove unused header
>   cpufreq: sfi-cpufreq: Remove driver for deprecated firmware
>   sfi: Remove framework for deprecated firmware
>   x86/PCI: Get rid of custom x86 model comparison
>   x86/PCI: Describe @reg for type1_access_ok()
>   x86/platform/intel-mid: Get rid of intel_scu_ipc_legacy.h
>   x86/platform/intel-mid: Drop unused __intel_mid_cpu_chip and Co.
>   x86/platform/intel-mid: Remove unused header inclusion in intel-mid.h
>   x86/platform/intel-mid: Update Copyright year and drop file names
>
>  Documentation/ABI/testing/sysfs-firmware-sfi  |  15 -
>  Documentation/ABI/testing/sysfs-platform-kim  |   2 +-
>  MAINTAINERS                                   |   7 -
>  arch/x86/Kconfig                              |   7 +-
>  arch/x86/include/asm/intel-mid.h              |  65 +--
>  arch/x86/include/asm/intel_scu_ipc.h          |   2 -
>  arch/x86/include/asm/intel_scu_ipc_legacy.h   |  74 ---
>  arch/x86/include/asm/platform_sst_audio.h     |   2 -
>  arch/x86/kernel/apic/io_apic.c                |   4 +-
>  arch/x86/kernel/setup.c                       |   2 -
>  arch/x86/pci/intel_mid_pci.c                  |  18 +-
>  arch/x86/pci/mmconfig-shared.c                |   6 +-
>  arch/x86/platform/Makefile                    |   1 -
>  arch/x86/platform/intel-mid/Makefile          |   5 -
>  .../platform/intel-mid/device_libs/Makefile   |  23 -
>  .../intel-mid/device_libs/platform_bcm43xx.c  | 101 ----
>  .../intel-mid/device_libs/platform_bma023.c   |  16 -
>  .../intel-mid/device_libs/platform_bt.c       | 101 ----
>  .../intel-mid/device_libs/platform_emc1403.c  |  39 --
>  .../device_libs/platform_gpio_keys.c          |  81 ---
>  .../intel-mid/device_libs/platform_lis331.c   |  37 --
>  .../intel-mid/device_libs/platform_max7315.c  |  77 ---
>  .../intel-mid/device_libs/platform_mpu3050.c  |  32 --
>  .../device_libs/platform_mrfld_pinctrl.c      |  39 --
>  .../device_libs/platform_mrfld_rtc.c          |  44 --
>  .../intel-mid/device_libs/platform_mrfld_sd.c |  43 --
>  .../device_libs/platform_mrfld_spidev.c       |  50 --
>  .../device_libs/platform_pcal9555a.c          |  95 ----
>  .../intel-mid/device_libs/platform_tc35876x.c |  42 --
>  .../intel-mid/device_libs/platform_tca6416.c  |  53 --
>  arch/x86/platform/intel-mid/intel-mid.c       |  27 +-
>  arch/x86/platform/intel-mid/sfi.c             | 419 --------------
>  arch/x86/platform/sfi/Makefile                |   2 -
>  arch/x86/platform/sfi/sfi.c                   | 100 ----
>  drivers/Makefile                              |   2 +-
>  drivers/cpufreq/Kconfig.x86                   |  10 -
>  drivers/cpufreq/Makefile                      |   1 -
>  drivers/cpufreq/sfi-cpufreq.c                 | 127 -----
>  drivers/platform/x86/intel_scu_pcidrv.c       |  22 +-
>  drivers/sfi/Kconfig                           |  18 -
>  drivers/sfi/Makefile                          |   4 -
>  drivers/sfi/sfi_acpi.c                        | 214 -------
>  drivers/sfi/sfi_core.c                        | 522 ------------------
>  drivers/sfi/sfi_core.h                        |  81 ---
>  .../atomisp/include/linux/atomisp_platform.h  |   1 -
>  include/linux/sfi.h                           | 210 -------
>  include/linux/sfi_acpi.h                      |  93 ----
>  init/main.c                                   |   2 -
>  48 files changed, 37 insertions(+), 2901 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-firmware-sfi
>  delete mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/Makefile
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bma023.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bt.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_emc1403.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_lis331.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_max7315.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mpu3050.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_pinctrl.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_rtc.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_sd.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_spidev.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_pcal9555a.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_tca6416.c
>  delete mode 100644 arch/x86/platform/intel-mid/sfi.c
>  delete mode 100644 arch/x86/platform/sfi/Makefile
>  delete mode 100644 arch/x86/platform/sfi/sfi.c
>  delete mode 100644 drivers/cpufreq/sfi-cpufreq.c
>  delete mode 100644 drivers/sfi/Kconfig
>  delete mode 100644 drivers/sfi/Makefile
>  delete mode 100644 drivers/sfi/sfi_acpi.c
>  delete mode 100644 drivers/sfi/sfi_core.c
>  delete mode 100644 drivers/sfi/sfi_core.h
>  delete mode 100644 include/linux/sfi.h
>  delete mode 100644 include/linux/sfi_acpi.h
>
> --

All of this looks good to me, so I'm going to queue it up for 5.12
unless there are objections against doing that.

Thanks!
