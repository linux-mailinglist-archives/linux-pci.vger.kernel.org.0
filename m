Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35264436CE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKBT4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 15:56:05 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37386 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKBTzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 15:55:55 -0400
Received: by mail-ot1-f53.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so433451ott.4;
        Tue, 02 Nov 2021 12:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4ysC2TK49duZLeBEw05462rtywvOR8eexLWqsfLcCUY=;
        b=YQ3LU+t+yFQWumKjLRbaF/k+MBO8JSVraMRFPQAXxZlJ7DJG05jYyP17KzfvQwE+7B
         ld9GmvTSwHJXKejFdmnhvgLM9qWlHKtIMkaOh2TE5tlKksmLr7u0M2dxb/xWovWP+FNt
         o5oLpFzY05LzdA2xnCAShHhmB0xOhGzA4CMveKrRN0ameho7X1dIyunc3drwM2qd9VNV
         3xrvlLTq9f2U+OLFY26++5XWjbjI9dcvNilg5DnSmic89jllZ2IALBkWKpuDbyW6Zo6x
         JesudcKEbP0Yb8m1iXK+7OWKrYPTg958RYQEmmW4gXKqJ9csEBm//PHVuWso2Zrfb6x3
         7TVg==
X-Gm-Message-State: AOAM5314UER1Pb0Row2kaIyssuAcGpAYb+ywylBg6XYmPHnWmYiLmyfo
        klBKslvq5R3UzQ0VSS6BrVDUoebjs4QeHhgeZZqk4dyW52U=
X-Google-Smtp-Source: ABdhPJxL66qxLyN//dF1ujCG/e6s/ArvveoGNJAM+n1p7RgtuxComWbDfWGuMfVaHiq93Wh22COzia2CYq+/zPASgSY=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr21571353otg.198.1635882800188;
 Tue, 02 Nov 2021 12:53:20 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Nov 2021 20:53:09 +0100
Message-ID: <CAJZ5v0iSL3vwvmRL_BvS1J4_NHCNoLO5bG4YFcjVK-oXH_uTAg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.16-rc1

with top-most commit bf56b90797c4a03c94b702c50e62296edea9fad9

 Merge branches 'pm-em' and 'powercap'

on top of commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea

 Linux 5.15-rc7

to receive power management updates for 5.16-rc1.

These make the power management of PCI devices with ACPI companions
more straightforwad, add support for inefficient operating performance
points to the Energy model and make cpufreq handle them as appropriate,
rearrange the handling of cpuidle during system PM transitions,
update a few cpufreq drivers and intel_idle, fix assorded issues and
clean up code in multiple places.

Specifics:

 - Add support for inefficient operating performance points to the
   Energy Model and modify cpufreq to use them properly (Vincent
   Donnefort).

 - Rearrange the DTPM framework code to simplify it and make it easier
   to follow (Daniel Lezcano).

 - Fix power intialization in DTPM (Daniel Lezcano).

 - Add CPU load consideration when estimating the instaneous power
   consumption in DTPM (Daniel Lezcano).

 - Fix cpu->pstate.turbo_freq initialization in intel_pstate (Zhang
   Rui).

 - Make intel_pstate process HWP Guaranteed change notifications from
   the processor (Srinivas Pandruvada).

 - Fix typo in cpufreq.h (Rafael Wysocki).

 - Fix tegra driver to handle BPMP errors properly (Mikko Perttunen).

 - Fix the parameter usage of the newly added perf-domain API (Hector
   Yuan).

 - Minor cleanups to cppc, vexpress and s3c244x drivers (Han Wang,
   Guenter Roeck, and Arnd Bergmann).

 - Fix kobject memory leaks in cpuidle error paths (Anel Orazgaliyeva).

 - Make intel_idle enable interrupts before entering C1 on some Xeon
   processor models (Artem Bityutskiy).

 - Clean up hib_wait_io() (Falla Coulibaly).

 - Fix sparse warnings in hibernation-related code (Anders Roxell).

 - Use vzalloc() and kzalloc() instead of their open-coded
   equivalents in hibernation-related code (Cai Huoqing).

 - Prevent user space from crashing the kernel by attempting to
   restore the system state from a swap partition in use (Ye Bin).

 - Do not let "syscore" devices runtime-suspend during system PM
   transitions (Rafael Wysocki).

 - Do not pause cpuidle in the suspend-to-idle path (Rafael Wysocki).

 - Pause cpuidle later and resume it earlier during system PM
   transitions (Rafael Wysocki).

 - Make system suspend code use valid_state() consistently (Rafael
   Wysocki).

 - Add support for enabling wakeup IRQs after invoking the
   ->runtime_suspend() callback and make two drivers use it (Chunfeng
   Yun).

 - Make the association of ACPI device objects with PCI devices more
   straightforward and simplify the code doing that for all devices
   in general (Rafael Wysocki).

 - Eliminate struct pci_platform_pm_ops and handle the both of its
   users (PCI and Intel MID) directly in the PCI bus code (Rafael
   Wysocki).

 - Simplify and clarify ACPI PCI device PM helpers (Rafael Wysocki).

 - Fix ordering of operations in pci_back_from_sleep() (Rafael
   Wysocki).

 - Make exynos-ppmu use hyphens in DT properties (Krzysztof
   Kozlowski).

 - Simplify parsing event-type from DT in exynos-ppmu (Krzysztof
   Kozlowski).

 - Strengthen check for freq_table in devfreq (Samuel Holland).

Some of the changes listed above are also present in the ACPI updates
pull request sent earlier due to dependencies between the ACPI "glue"
code and the PCI device PM changes.

Thanks!


---------------

Anders Roxell (1):
      PM: hibernate: fix sparse warnings

Anel Orazgaliyeva (1):
      cpuidle: Fix kobject memory leaks in error paths

Arnd Bergmann (1):
      cpufreq: s3c244x: add fallthrough comments for switch

Artem Bityutskiy (1):
      intel_idle: enable interrupts before C1 on Xeons

Cai Huoqing (1):
      PM: hibernate: swap: Use vzalloc() and kzalloc()

Chunfeng Yun (3):
      PM / wakeirq: support enabling wake-up irq after runtime_suspend called
      usb: xhci-mtk: enable wake-up interrupt after runtime_suspend called
      usb: mtu3: enable wake-up interrupt after runtime_suspend called

Daniel Lezcano (5):
      powercap/drivers/dtpm: Encapsulate even more the code
      powercap/drivers/dtpm: Simplify the dtpm table
      powercap/drivers/dtpm: Use container_of instead of a private data field
      powercap/drivers/dtpm: Scale the power with the load
      powercap/drivers/dtpm: Fix power limit initialization

Falla Coulibaly (1):
      PM: hibernate: Remove blk_status_to_errno in hib_wait_io

Florian Fainelli (1):
      PM: sleep: Do not assume that "mem" is always present

Guenter Roeck (1):
      cpufreq: vexpress: Drop unused variable

Han Wang (1):
      cpufreq: remove useless INIT_LIST_HEAD()

Hector.Yuan (1):
      cpufreq: Fix parameter in parse_perf_domain()

Krzysztof Kozlowski (2):
      devfreq: exynos-ppmu: use node names with hyphens
      devfreq: exynos-ppmu: simplify parsing event-type from DT

Mikko Perttunen (1):
      cpufreq: tegra186/tegra194: Handle errors in BPMP response

Rafael J. Wysocki (17):
      PCI: ACPI: Drop acpi_pci_bus
      ACPI: glue: Drop cleanup callback from struct acpi_bus_type
      ACPI: glue: Look for ACPI bus type only if ACPI companion is not known
      PCI: PM: Do not use pci_platform_pm_ops for Intel MID PM
      PCI: ACPI: PM: Do not use pci_platform_pm_ops for ACPI
      PCI: PM: Drop struct pci_platform_pm_ops
      PCI: PM: Simplify acpi_pci_power_manageable()
      PCI: PM: Rearrange pci_target_state()
      PCI: PM: Make pci_choose_state() call pci_target_state()
      PCI: PM: Do not call platform_pci_power_manageable() unnecessarily
      Revert "PM: sleep: Do not assume that "mem" is always present"
      PCI: PM: Fix ordering of operations in pci_back_from_sleep()
      cpufreq: Fix typo in cpufreq.h
      PM: sleep: Do not let "syscore" devices runtime-suspend during
system transitions
      PM: suspend: Do not pause cpuidle in the suspend-to-idle path
      PM: sleep: Pause cpuidle later and resume it earlier during
system transitions
      PM: suspend: Use valid_state() consistently

Samuel Holland (1):
      PM / devfreq: Strengthen check for freq_table

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Process HWP Guaranteed change notification

Vincent Donnefort (10):
      PM: EM: Fix inefficient states detection
      PM: EM: Mark inefficient states
      PM: EM: Extend em_perf_domain with a flag field
      PM: EM: Allow skipping inefficient states
      cpufreq: Make policy min/max hard requirements
      cpufreq: Add an interface to mark inefficient frequencies
      cpufreq: Introducing CPUFREQ_RELATION_E
      cpufreq: Use CPUFREQ_RELATION_E in DVFS governors
      PM: EM: Mark inefficiencies in CPUFreq
      cpufreq: mediatek-hw: Fix cpufreq_table_find_index_dl() call

Ye Bin (1):
      PM: hibernate: Get block device exclusively in swsusp_check()

Zhang Rui (1):
      cpufreq: intel_pstate: Fix cpu->pstate.turbo_freq initialization

---------------

 drivers/acpi/glue.c                    |  34 +++--
 drivers/base/power/main.c              |  14 +-
 drivers/base/power/power.h             |   7 +-
 drivers/base/power/runtime.c           |   6 +-
 drivers/base/power/wakeirq.c           | 101 ++++++++++++---
 drivers/cpufreq/acpi-cpufreq.c         |   3 +-
 drivers/cpufreq/amd_freq_sensitivity.c |   3 +-
 drivers/cpufreq/cppc_cpufreq.c         |   2 -
 drivers/cpufreq/cpufreq.c              |  19 ++-
 drivers/cpufreq/cpufreq_conservative.c |   6 +-
 drivers/cpufreq/cpufreq_ondemand.c     |  16 ++-
 drivers/cpufreq/intel_pstate.c         | 120 ++++++++++++++++-
 drivers/cpufreq/mediatek-cpufreq-hw.c  |   2 +-
 drivers/cpufreq/powernv-cpufreq.c      |   4 +-
 drivers/cpufreq/s3c2440-cpufreq.c      |   2 +
 drivers/cpufreq/s5pv210-cpufreq.c      |   2 +-
 drivers/cpufreq/tegra186-cpufreq.c     |   4 +
 drivers/cpufreq/tegra194-cpufreq.c     |   8 +-
 drivers/cpuidle/sysfs.c                |   5 +-
 drivers/devfreq/devfreq.c              |   2 +-
 drivers/devfreq/event/exynos-ppmu.c    |  12 +-
 drivers/idle/intel_idle.c              |  13 +-
 drivers/pci/pci-acpi.c                 |  74 +++--------
 drivers/pci/pci-mid.c                  |  37 ++----
 drivers/pci/pci.c                      | 154 ++++++++++------------
 drivers/pci/pci.h                      |  96 ++++++++------
 drivers/powercap/dtpm.c                |  78 ++++++-----
 drivers/powercap/dtpm_cpu.c            | 228 ++++++++++++++++++---------------
 drivers/usb/host/xhci-mtk.c            |   2 +-
 drivers/usb/mtu3/mtu3_plat.c           |   2 +-
 include/acpi/acpi_bus.h                |   1 -
 include/linux/cpufreq.h                | 169 +++++++++++++++++++-----
 include/linux/cpuhotplug.h             |   2 +-
 include/linux/dtpm.h                   |  26 ++--
 include/linux/energy_model.h           |  68 ++++++++--
 include/linux/pci-acpi.h               |   8 ++
 include/linux/pm_wakeirq.h             |   9 +-
 kernel/power/energy_model.c            |  86 ++++++++++---
 kernel/power/hibernate.c               |  12 +-
 kernel/power/power.h                   |  14 ++
 kernel/power/suspend.c                 |  18 +--
 kernel/power/swap.c                    |  21 ++-
 42 files changed, 946 insertions(+), 544 deletions(-)
