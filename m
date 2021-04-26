Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE136B8E4
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 20:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhDZS2P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 26 Apr 2021 14:28:15 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41596 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhDZS2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 14:28:14 -0400
Received: by mail-ot1-f50.google.com with SMTP id z20-20020a0568301294b02902a52ecbaf18so644153otp.8;
        Mon, 26 Apr 2021 11:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jcMELw5BG8yX4i+sNXY+MmhU+9vZSj8tiRwJgZw7SdI=;
        b=pERKOlvuCwoF8VfQSjTWJOE+mr7ozl8x6Xw7wU87YucyNyvJDTeAC8b8qhR9g8ZaxL
         2BaQe0rx6agQNbRoQVb49m5LQFXl9gKAFWSD3xsYGgErw3+MBbxTcdandzMgFqUEIhO3
         Bvab0Wf32NMo5YZ8JM5h6dt188AyJHMwUp5pnpGTRw+xmQnTKRQEPqSyjF99rtOwRVQx
         IeDwnih3yHvqB528niOsazx9VDhwH4l3/83i63g3Y3D1NOrooiOK731GF+O89J6fogbW
         TQHcuFHIHe76mk/pUYSjjsab0ogNjqDG2aR/fyaa+0Lgahal5pqi+rE8vw12wBFRzb4/
         Z9Mg==
X-Gm-Message-State: AOAM532Nmctq2y4AT90bPA/VzlK/feM6Dh4dIgW1kcaT7gfbp/s4HOdG
        gAE6Aw3j33q0vlgSFQPpkKRvMFJFGFGFwYrKBXo=
X-Google-Smtp-Source: ABdhPJy7JldSCFpB79oGD7lAC/GYNcCsBaS7C13MaWQ6fP7ISFZQxTGvtqG//3vk+YhyM0jpPoAfPZPhVefYqdc53bA=
X-Received: by 2002:a05:6830:2458:: with SMTP id x24mr4942094otr.206.1619461651066;
 Mon, 26 Apr 2021 11:27:31 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Apr 2021 20:27:20 +0200
Message-ID: <CAJZ5v0iuTS8iDCUVQcqAB5N=8f6KkY00e-A+9Jtq7P3gzj=HmA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.13-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.13-rc1

with top-most commit 59e2c959f20f9f255a42de52cde54a2962fb726f

 Merge branches 'pm-docs' and 'pm-tools'

on top of commit e49d033bddf5b565044e2abe4241353959bc9120

 Linux 5.12-rc6

to receive power management updates for 5.13-rc1.

These add some new hardware support (for example, IceLake-D idle
states in intel_idle), fix some issues (for example, the handling
of negative "sleep length" values in cpuidle governors), add new
functionality to the existing drivers (for example, scale-invariance
support in the ACPI CPPC cpufreq driver) and clean up code all over.

Specifics:

 - Add idle states table for IceLake-D to the intel_idle driver and
   update IceLake-X C6 data in it (Artem Bityutskiy).

 - Fix the C7 idle state on Tegra114 in the tegra cpuidle driver and
   drop the unused do_idle() firmware call from it (Dmitry Osipenko).

 - Fix cpuidle-qcom-spm Kconfig entry (He Ying).

 - Fix handling of possible negative tick_nohz_get_next_hrtimer()
   return values of in cpuidle governors (Rafael Wysocki).

 - Add support for frequency-invariance to the ACPI CPPC cpufreq
   driver and update the frequency-invariance engine (FIE) to use it
   as needed (Viresh Kumar).

 - Simplify the default delay_us setting in the ACPI CPPC cpufreq
   driver (Tom Saeger).

 - Clean up frequency-related computations in the intel_pstate
   cpufreq driver (Rafael Wysocki).

 - Fix TBG parent setting for load levels in the armada-37xx
   cpufreq driver and drop the CPU PM clock .set_parent method for
   armada-37xx (Marek Behún).

 - Fix multiple issues in the armada-37xx cpufreq driver (Pali Rohár).

 - Fix handling of dev_pm_opp_of_cpumask_add_table() return values
   in cpufreq-dt to take the -EPROBE_DEFER one into account as
   appropriate (Quanyang Wang).

 - Fix format string in ia64-acpi-cpufreq (Sergei Trofimovich).

 - Drop the unused for_each_policy() macro from cpufreq (Shaokun
   Zhang).

 - Simplify computations in the schedutil cpufreq governor to avoid
   unnecessary overhead (Yue Hu).

 - Fix typos in the s5pv210 cpufreq driver (Bhaskar Chowdhury).

 - Fix cpufreq documentation links in Kconfig (Alexander Monakov).

 - Fix PCI device power state handling in pci_enable_device_flags()
   to avoid issues in some cases when the device depends on an ACPI
   power resource (Rafael Wysocki).

 - Add missing documentation of pm_runtime_resume_and_get() (Alan
   Stern).

 - Add missing static inline stub for pm_runtime_has_no_callbacks()
   to pm_runtime.h and drop the unused try_to_freeze_nowarn()
   definition (YueHaibing).

 - Drop duplicate struct device declaration from pm.h and fix a
   structure type declaration in intel_rapl.h (Wan Jiabing).

 - Use dev_set_name() instead of an open-coded equivalent of it in
   the wakeup sources code and drop a redundant local variable
   initialization from it (Andy Shevchenko, Colin Ian King).

 - Use crc32 instead of md5 for e820 memory map integrity check
   during resume from hibernation on x86 (Chris von Recklinghausen).

 - Fix typos in comments in the system-wide and hibernation support
   code (Lu Jialin).

 - Modify the generic power domains (genpd) code to avoid resuming
   devices in the "prepare" phase of system-wide suspend and
   hibernation (Ulf Hansson).

 - Add Hygon Fam18h RAPL support to the intel_rapl power capping
   driver (Pu Wen).

 - Add MAINTAINERS entry for the dynamic thermal power management
   (DTPM) code (Daniel Lezcano).

 - Add devm variants of operating performance points (OPP) API
   functions and switch over some users of the OPP framework to
   the new resource-managed API (Yangtao Li and Dmitry Osipenko).

 - Update devfreq core:

   * Register devfreq devices as cooling devices on demand (Daniel
     Lezcano).

   * Add missing unlock operation in devfreq_add_device() (Lukasz
     Luba).

   * Use the next frequency as resume_freq instead of the previous
     frequency when using the opp-suspend property (Dong Aisheng).

   * Check get_dev_status in devfreq_update_stats() (Dong Aisheng).

   * Fix set_freq path for the userspace governor in Kconfig (Dong
     Aisheng).

   * Remove invalid description of get_target_freq() (Dong Aisheng).

 - Update devfreq drivers:

   * imx8m-ddrc: Remove imx8m_ddrc_get_dev_status() and unneeded
     of_match_ptr() (Dong Aisheng, Fabio Estevam).

   * rk3399_dmc: dt-bindings: Add rockchip,pmu phandle and drop
     references to undefined symbols (Enric Balletbo i Serra, Gaël
     PORTAY).

   * rk3399_dmc: Use dev_err_probe() to simplify the code (Krzysztof
     Kozlowski).

   * imx-bus: Remove unneeded of_match_ptr() (Fabio Estevam).

 - Fix kernel-doc warnings in three places (Pierre-Louis Bossart).

 - Fix typo in the pm-graph utility code (Ricardo Ribalda).

Thanks!


---------------

Alan Stern (1):
      PM: runtime: Add documentation for pm_runtime_resume_and_get()

Alexander Monakov (1):
      cpufreq: Kconfig: fix documentation links

Andy Shevchenko (1):
      PM: wakeup: use dev_set_name() directly

Artem Bityutskiy (2):
      intel_idle: update ICX C6 data
      intel_idle: add Iclelake-D support

Bhaskar Chowdhury (1):
      cpufreq: Rudimentary typos fix in the file s5pv210-cpufreq.c

Chris von Recklinghausen (1):
      PM: hibernate: x86: Use crc32 instead of md5 for hibernation
e820 integrity check

Colin Ian King (1):
      PM: wakeup: remove redundant assignment to variable retval

Daniel Lezcano (2):
      PM / devfreq: Register devfreq as a cooling device on demand
      MAINTAINERS: Add DTPM subsystem maintainer

Dmitry Osipenko (4):
      opp: Change return type of devm_pm_opp_register_set_opp_helper()
      opp: Change return type of devm_pm_opp_attach_genpd()
      cpuidle: tegra: Fix C7 idling state on Tegra114
      cpuidle: tegra: Remove do_idle firmware call

Dong Aisheng (5):
      PM / devfreq: Use more accurate returned new_freq as resume_freq
      PM / devfreq: Fix the wrong set_freq path for userspace governor
in Kconfig
      PM / devfreq: Check get_dev_status in devfreq_update_stats
      PM / devfreq: Remove the invalid description for get_target_freq
      PM / devfreq: imx8m-ddrc: Remove imx8m_ddrc_get_dev_status

Enric Balletbo i Serra (1):
      dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.

Fabio Estevam (2):
      PM / devfreq: imx-bus: Remove unneeded of_match_ptr()
      PM / devfreq: imx8m-ddrc: Remove unneeded of_match_ptr()

Gaël PORTAY (1):
      dt-bindings: devfreq: rk3399_dmc: Remove references of unexistant defines

He Ying (1):
      cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration

Krzysztof Kozlowski (1):
      PM / devfreq: rk3399_dmc: Simplify with dev_err_probe()

Lu Jialin (1):
      PM: sleep: fix typos in comments

Lukasz Luba (1):
      PM / devfreq: Unlock mutex and free devfreq struct in error path

Marek Behún (2):
      cpufreq: armada-37xx: Fix setting TBG parent for load levels
      clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM clock

Pali Rohár (7):
      cpufreq: armada-37xx: Fix the AVS value for load L1
      clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250
Mhz to 1 GHz
      clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1 to L0
      cpufreq: armada-37xx: Fix driver cleanup when registration failed
      cpufreq: armada-37xx: Fix determining base CPU frequency
      cpufreq: armada-37xx: Remove cur_frequency variable
      cpufreq: armada-37xx: Fix module unloading

Pierre-Louis Bossart (3):
      PM: runtime: remove kernel-doc warnings
      PM: wakeup: fix kernel-doc warnings and fix typos
      PM: clk: remove kernel-doc warning

Pu Wen (1):
      powercap: Add Hygon Fam18h RAPL support

Quanyang Wang (1):
      cpufreq: dt: dev_pm_opp_of_cpumask_add_table() may return -EPROBE_DEFER

Rafael J. Wysocki (8):
      cpufreq: intel_pstate: Clean up frequency computations
      PCI: PM: Do not read power state in pci_enable_device_flags()
      tick/nohz: Improve tick_nohz_get_next_hrtimer() kerneldoc
      cpuidle: Use s64 as exit_latency_ns and target_residency_ns data type
      cpuidle: teo: Adjust handling of very short idle times
      cpuidle: teo: Take negative "sleep length" values into account
      cpuidle: menu: Take negative "sleep length" values into account
      cpufreq: intel_pstate: Simplify intel_pstate_update_perf_limits()

Ricardo Ribalda (1):
      pm-graph: Fix typo "accesible"

Sergei Trofimovich (1):
      ia64: fix format string for ia64-acpi-cpu-freq

Shaokun Zhang (1):
      cpufreq: Remove unused for_each_policy macro

Tom Saeger (1):
      cpufreq: cppc: simplify default delay_us setting

Ulf Hansson (1):
      PM: domains: Don't runtime resume devices at genpd_prepare()

Viresh Kumar (4):
      arch_topology: Rename freq_scale as arch_freq_scale
      arch_topology: Allow multiple entities to provide
sched_freq_tick() callback
      arch_topology: Export arch_freq_scale and helpers
      cpufreq: CPPC: Add support for frequency invariance

Wan Jiabing (2):
      PM: core: Remove duplicate declaration from header file
      powercap: RAPL: Fix struct declaration in header file

Yangtao Li (11):
      opp: Add devres wrapper for dev_pm_opp_set_clkname
      opp: Add devres wrapper for dev_pm_opp_set_regulators
      opp: Add devres wrapper for dev_pm_opp_set_supported_hw
      opp: Add devres wrapper for dev_pm_opp_of_add_table
      serial: qcom_geni_serial: Convert to use resource-managed OPP API
      spi: spi-geni-qcom: Convert to use resource-managed OPP API
      spi: spi-qcom-qspi: Convert to use resource-managed OPP API
      mmc: sdhci-msm: Convert to use resource-managed OPP API
      drm/lima: Convert to use resource-managed OPP API
      drm/panfrost: Convert to use resource-managed OPP API
      memory: samsung: exynos5422-dmc: Convert to use resource-managed OPP API

Yue Hu (1):
      cpufreq: schedutil: Call sugov_update_next_freq() before check
to fast_switch_enabled

YueHaibing (2):
      freezer: Remove unused inline function try_to_freeze_nowarn()
      PM: runtime: Replace inline function pm_runtime_callbacks_present()

---------------

 Documentation/ABI/testing/sysfs-class-devfreq      |   5 +-
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |  75 +++---
 Documentation/power/runtime_pm.rst                 |   4 +
 MAINTAINERS                                        |   9 +
 arch/arm64/include/asm/topology.h                  |  10 +-
 arch/arm64/kernel/topology.c                       | 109 ++++-----
 arch/x86/kernel/e820.c                             |   4 +-
 arch/x86/power/hibernate.c                         |  89 ++-----
 drivers/base/arch_topology.c                       |  89 ++++++-
 drivers/base/power/clock_ops.c                     |   2 +-
 drivers/base/power/domain.c                        |  36 ---
 drivers/base/power/runtime.c                       |   2 +-
 drivers/base/power/wakeup.c                        |  17 +-
 drivers/base/power/wakeup_stats.c                  |   4 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |  83 ++++---
 drivers/cpufreq/Kconfig                            |  23 +-
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/armada-37xx-cpufreq.c              | 111 +++++++--
 drivers/cpufreq/cppc_cpufreq.c                     | 259 +++++++++++++++++++--
 drivers/cpufreq/cpufreq-dt.c                       |   9 +-
 drivers/cpufreq/cpufreq.c                          |   3 -
 drivers/cpufreq/ia64-acpi-cpufreq.c                |   4 +-
 drivers/cpufreq/intel_pstate.c                     | 107 ++++-----
 drivers/cpufreq/s5pv210-cpufreq.c                  |  14 +-
 drivers/cpuidle/Kconfig.arm                        |   2 +-
 drivers/cpuidle/cpuidle-tegra.c                    |  19 +-
 drivers/cpuidle/driver.c                           |   4 +
 drivers/cpuidle/governors/menu.c                   |  17 +-
 drivers/cpuidle/governors/teo.c                    |  54 +++--
 drivers/devfreq/Kconfig                            |   2 +-
 drivers/devfreq/devfreq.c                          |  14 +-
 drivers/devfreq/governor.h                         |   5 +-
 drivers/devfreq/imx-bus.c                          |   2 +-
 drivers/devfreq/imx8m-ddrc.c                       |  16 +-
 drivers/devfreq/rk3399_dmc.c                       |  20 +-
 drivers/gpu/drm/lima/lima_devfreq.c                |  47 +---
 drivers/gpu/drm/lima/lima_devfreq.h                |   3 -
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |  37 +--
 drivers/gpu/drm/panfrost/panfrost_devfreq.h        |   2 -
 drivers/idle/intel_idle.c                          |   5 +-
 drivers/memory/samsung/exynos5422-dmc.c            |  13 +-
 drivers/mmc/host/sdhci-msm.c                       |  19 +-
 drivers/opp/core.c                                 | 122 ++++++++--
 drivers/opp/of.c                                   |  36 +++
 drivers/pci/pci.c                                  |  16 +-
 drivers/powercap/intel_rapl_common.c               |   1 +
 drivers/powercap/intel_rapl_msr.c                  |   1 +
 drivers/spi/spi-geni-qcom.c                        |  16 +-
 drivers/spi/spi-qcom-qspi.c                        |  18 +-
 drivers/tty/serial/qcom_geni_serial.c              |  23 +-
 include/linux/arch_topology.h                      |  19 +-
 include/linux/cpuidle.h                            |   4 +-
 include/linux/devfreq.h                            |   9 +
 include/linux/freezer.h                            |   1 -
 include/linux/intel_rapl.h                         |   2 +-
 include/linux/pm.h                                 |   1 -
 include/linux/pm_opp.h                             |  44 +++-
 include/linux/pm_runtime.h                         |   2 +-
 include/linux/qcom-geni-se.h                       |   2 -
 kernel/power/autosleep.c                           |   2 +-
 kernel/power/snapshot.c                            |   2 +-
 kernel/power/swap.c                                |   2 +-
 kernel/sched/core.c                                |   1 +
 kernel/sched/cpufreq_schedutil.c                   |  29 +--
 kernel/time/tick-sched.c                           |   6 +-
 tools/power/pm-graph/sleepgraph.py                 |   2 +-
 66 files changed, 997 insertions(+), 723 deletions(-)
