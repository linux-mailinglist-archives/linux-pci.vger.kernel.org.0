Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199D1318F1C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 16:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhBKPss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 10:48:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231367AbhBKPqu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 10:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613058323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39EV7/G2PzTJehWm5IY3xEu3xVTJ2cfFkuLTjx/NCso=;
        b=Fs0v+FUX0koAuz9/I4KhY1Hw+3Ami1iRWsHdBL9gGdHznXxIF/UWwUgVT3Arxl73U4RKNt
        qJd4dKf7BDKscAqF1z9EO01CgY05e8BWg7NvwdOwTrUS0L78EGwmR0J0pPbw11MJQvhwmf
        0A/MoiMBrGq+P373lZX5Ug1wE+htPFM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-YOlCPfg8OT6gH7ZU9eECNg-1; Thu, 11 Feb 2021 10:45:21 -0500
X-MC-Unique: YOlCPfg8OT6gH7ZU9eECNg-1
Received: by mail-ed1-f72.google.com with SMTP id g6so4816082edy.9
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2021 07:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=39EV7/G2PzTJehWm5IY3xEu3xVTJ2cfFkuLTjx/NCso=;
        b=EWEWXf+WL5zEge4LPrWHEnFErSnjtKdeZA6aqKKRWz1BDgaluSeVzp/WAKVUYzWHqS
         D1lbn6KHBQzmCzlFkaVHW1jgrOQn6dWjj4Bd6EbmHpiGNuaYS6jC9JlHOyPB1++/npe7
         UfG+AXKPN6k0axr7vqZg26LDq+02KrjjQWr4gxAr7bA3HDyPmvIJI+2rxZsB2mbA9zEF
         /ZpR6kNVh/2PDj8lUQg/hHpiRM9V7fUJYefZq2ylr0dzjAgozOpTS3D7FR/VubvRUVI0
         7ftTNZO2nyo1im1r9QirXEg2dVx90bEZtjyihMaAmSlGsbh6ybmTD6nrIWZ6ao1t8Az9
         WAMA==
X-Gm-Message-State: AOAM530eLxpW0dob+WXvEXsKuEUZ2Nk5Mtm6o1QZBiBTOCHVNpBqUnU6
        FppD4b8xpvTo/XCAp9mekCeJoaa1CyaTVqB9n3KUsj+zjLXuVe+M5Rraalanj3EPZV42DXXV9pW
        grmcd64DooGqEAW6aWMor
X-Received: by 2002:a17:906:c0d7:: with SMTP id bn23mr9024992ejb.94.1613058320145;
        Thu, 11 Feb 2021 07:45:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAqoP5eDFW4xcTb4dIWPHhgt73k8gUL/gfI/YINR2uueo6qHqMl/9WQ2OnMwUijI+is8nBSg==
X-Received: by 2002:a17:906:c0d7:: with SMTP id bn23mr9024980ejb.94.1613058319935;
        Thu, 11 Feb 2021 07:45:19 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bk2sm4539280ejb.98.2021.02.11.07.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 07:45:19 -0800 (PST)
Subject: Re: [PATCH v1 0/9] x86/platform: Remove SFI framework and users
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
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
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gzd0Xwd006P3PUutKcVRqLNxmREBB-QW85BRMBArbBVw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bf10026f-13bb-c1c6-2787-d8c9520f8401@redhat.com>
Date:   Thu, 11 Feb 2021 16:45:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gzd0Xwd006P3PUutKcVRqLNxmREBB-QW85BRMBArbBVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2/11/21 4:24 PM, Rafael J. Wysocki wrote:
> On Thu, Feb 11, 2021 at 2:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> This is last part of Intel MID (SFI based) removal. We have no more users of it
>> in the kernel and since SFI has been marked Obsolete for a few years already,
>> Remove all the stuff altogether.
>>
>> Note, the more recent platforms (Intel Merrifield and Moorefield) still work as
>> long as they provide correct ACPI tables.
>>
>> The series requires two prerequisite branches to be pulled first, i.e.
>> - one form Rafael's PM tree (currently bleeding-edge)
>> - one form TIP tree (x86/platform), actually only one patch is needed from it
>>
>> Due to above it's convenient to proceed all of these via Rafael's PM tree,
>>
>> Note, atomisp change is tagged by Sakari on behalf of media tree maintainers.
>>
>> Andy Shevchenko (9):
>>   media: atomisp: Remove unused header
>>   cpufreq: sfi-cpufreq: Remove driver for deprecated firmware
>>   sfi: Remove framework for deprecated firmware
>>   x86/PCI: Get rid of custom x86 model comparison
>>   x86/PCI: Describe @reg for type1_access_ok()
>>   x86/platform/intel-mid: Get rid of intel_scu_ipc_legacy.h
>>   x86/platform/intel-mid: Drop unused __intel_mid_cpu_chip and Co.
>>   x86/platform/intel-mid: Remove unused header inclusion in intel-mid.h
>>   x86/platform/intel-mid: Update Copyright year and drop file names
>>
>>  Documentation/ABI/testing/sysfs-firmware-sfi  |  15 -
>>  Documentation/ABI/testing/sysfs-platform-kim  |   2 +-
>>  MAINTAINERS                                   |   7 -
>>  arch/x86/Kconfig                              |   7 +-
>>  arch/x86/include/asm/intel-mid.h              |  65 +--
>>  arch/x86/include/asm/intel_scu_ipc.h          |   2 -
>>  arch/x86/include/asm/intel_scu_ipc_legacy.h   |  74 ---
>>  arch/x86/include/asm/platform_sst_audio.h     |   2 -
>>  arch/x86/kernel/apic/io_apic.c                |   4 +-
>>  arch/x86/kernel/setup.c                       |   2 -
>>  arch/x86/pci/intel_mid_pci.c                  |  18 +-
>>  arch/x86/pci/mmconfig-shared.c                |   6 +-
>>  arch/x86/platform/Makefile                    |   1 -
>>  arch/x86/platform/intel-mid/Makefile          |   5 -
>>  .../platform/intel-mid/device_libs/Makefile   |  23 -
>>  .../intel-mid/device_libs/platform_bcm43xx.c  | 101 ----
>>  .../intel-mid/device_libs/platform_bma023.c   |  16 -
>>  .../intel-mid/device_libs/platform_bt.c       | 101 ----
>>  .../intel-mid/device_libs/platform_emc1403.c  |  39 --
>>  .../device_libs/platform_gpio_keys.c          |  81 ---
>>  .../intel-mid/device_libs/platform_lis331.c   |  37 --
>>  .../intel-mid/device_libs/platform_max7315.c  |  77 ---
>>  .../intel-mid/device_libs/platform_mpu3050.c  |  32 --
>>  .../device_libs/platform_mrfld_pinctrl.c      |  39 --
>>  .../device_libs/platform_mrfld_rtc.c          |  44 --
>>  .../intel-mid/device_libs/platform_mrfld_sd.c |  43 --
>>  .../device_libs/platform_mrfld_spidev.c       |  50 --
>>  .../device_libs/platform_pcal9555a.c          |  95 ----
>>  .../intel-mid/device_libs/platform_tc35876x.c |  42 --
>>  .../intel-mid/device_libs/platform_tca6416.c  |  53 --
>>  arch/x86/platform/intel-mid/intel-mid.c       |  27 +-
>>  arch/x86/platform/intel-mid/sfi.c             | 419 --------------
>>  arch/x86/platform/sfi/Makefile                |   2 -
>>  arch/x86/platform/sfi/sfi.c                   | 100 ----
>>  drivers/Makefile                              |   2 +-
>>  drivers/cpufreq/Kconfig.x86                   |  10 -
>>  drivers/cpufreq/Makefile                      |   1 -
>>  drivers/cpufreq/sfi-cpufreq.c                 | 127 -----
>>  drivers/platform/x86/intel_scu_pcidrv.c       |  22 +-
>>  drivers/sfi/Kconfig                           |  18 -
>>  drivers/sfi/Makefile                          |   4 -
>>  drivers/sfi/sfi_acpi.c                        | 214 -------
>>  drivers/sfi/sfi_core.c                        | 522 ------------------
>>  drivers/sfi/sfi_core.h                        |  81 ---
>>  .../atomisp/include/linux/atomisp_platform.h  |   1 -
>>  include/linux/sfi.h                           | 210 -------
>>  include/linux/sfi_acpi.h                      |  93 ----
>>  init/main.c                                   |   2 -
>>  48 files changed, 37 insertions(+), 2901 deletions(-)
>>  delete mode 100644 Documentation/ABI/testing/sysfs-firmware-sfi
>>  delete mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/Makefile
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bma023.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_bt.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_emc1403.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_lis331.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_max7315.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mpu3050.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_pinctrl.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_rtc.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_sd.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_spidev.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_pcal9555a.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
>>  delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_tca6416.c
>>  delete mode 100644 arch/x86/platform/intel-mid/sfi.c
>>  delete mode 100644 arch/x86/platform/sfi/Makefile
>>  delete mode 100644 arch/x86/platform/sfi/sfi.c
>>  delete mode 100644 drivers/cpufreq/sfi-cpufreq.c
>>  delete mode 100644 drivers/sfi/Kconfig
>>  delete mode 100644 drivers/sfi/Makefile
>>  delete mode 100644 drivers/sfi/sfi_acpi.c
>>  delete mode 100644 drivers/sfi/sfi_core.c
>>  delete mode 100644 drivers/sfi/sfi_core.h
>>  delete mode 100644 include/linux/sfi.h
>>  delete mode 100644 include/linux/sfi_acpi.h
>>
>> --
> 
> All of this looks good to me, so I'm going to queue it up for 5.12
> unless there are objections against doing that.

That is fine by me (for the drivers/platform/x86 bits) :

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

