Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF7109E62
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 13:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfKZMzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 07:55:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38380 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfKZMzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 07:55:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id a14so16519529oid.5;
        Tue, 26 Nov 2019 04:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YSHsJY2ZH1bwO7jLvlHgKYh9UyxOH116OQ47Cgq1Vtc=;
        b=Y+cgo5vJNE7dqfB/+yU8/mZjXyT6qxSNKpllwRSkq6PUax4++7hJKYWrUP3Vjt8B7N
         sWFJJ/aSM3IRZ6b8pZyyzSN8wMaStBTNCZmco6HpIGzbaiHm8UTrf9FAxTURAj+MdH/d
         NsVyOb1MBJJRDXqGSMCXpq/YwpwJ7tXDZGF825l2Pc2vCmVUliOigu/oyipwF1+E9P1g
         PU0CtfDa0VQIlX1zENEZqUQQQReuUsHc63mYPAFE6DQT2dbBaXgukh9FFKNxJLDSL1AU
         nWzhDCfzbv4vSdVxSlYH2zFW2nWPJ1SH/fT9hhk4NEqgGN5qTtbL9frpSw3ggvL0lSlG
         r2yw==
X-Gm-Message-State: APjAAAWC/gBRd7DBbN9aUriF3toUpn1OiJL+0drVTO6Sk2JVjVgHSqJg
        3krtpNEORuUNMC4A4H5FrHWf/eUvQijvVqcfQdkMMr25
X-Google-Smtp-Source: APXvYqxo3rr86ItiU+1xhnQcivJAlDZUPyehf3hiNaneh/4u1kpbMO2kfGpBtQGEfBVrG7yViW9tqL3cbE/HNRR2FWo=
X-Received: by 2002:aca:c753:: with SMTP id x80mr3270720oif.115.1574772943970;
 Tue, 26 Nov 2019 04:55:43 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Nov 2019 13:55:32 +0100
Message-ID: <CAJZ5v0hNKs11t2d0L=GkMN5RgOBfQ7sgss4U0VEJtS=EETwtNA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.5-rc1

with top-most commit e350b60f4e0f089f585d738e27213c8133fe9093

 Merge branches 'pm-avs', 'pm-docs' and 'pm-tools'

on top of commit 05ff1ba412fd6bd48d56dd4c0baff626533728cc

 PM: QoS: Invalidate frequency QoS requests after removal

to receive power management updates for 5.5-rc1.

These include cpuidle changes to use nanoseconds (instead of
microseconds) as the unit of time and to simplify checks for
disabled idle states in the idle loop, some cpuidle fixes and
governor updates, assorted cpufreq updates (driver updates
mostly and a few core fixes and cleanups), devfreq updates
(dominated by the tegra30 driver changes), new CPU IDs for
the RAPL power capping driver, relatively minor updates of
the generic power domains (genpd) and operation performance
points (OPP) frameworks, and assorted fixes and cleanups.

There are also two maintainer information updates: Chanwoo Choi will
be maintaining the devfreq subsystem going forward and Todd Brandt is
going to maintain the pm-graph utility (created by him).

Specifics:

 - Use nanoseconds (instead of microseconds) as the unit of time in
   the cpuidle core and simplify checks for disabled idle states in
   the idle loop (Rafael Wysocki).

 - Fix and clean up the teo cpuidle governor (Rafael Wysocki).

 - Fix the cpuidle registration error code path (Zhenzhong Duan).

 - Avoid excessive vmexits in the ACPI cpuidle driver (Yin Fengwei).

 - Extend the idle injection infrastructure to be able to measure the
   requested duration in nanoseconds and to allow an exit latency
   limit for idle states to be specified (Daniel Lezcano).

 - Fix cpufreq driver registration and clarify a comment in the
   cpufreq core (Viresh Kumar).

 - Add NULL checks to the show() and store() methods of sysfs
   attributes exposed by cpufreq (Kai Shen).

 - Update cpufreq drivers:

   * Fix for a plain int as pointer warning from sparse in
     intel_pstate (Jamal Shareef).

   * Fix for a hardcoded number of CPUs and stack bloat in the
     powernv driver (John Hubbard).

   * Updates to the ti-cpufreq driver and DT files to support new
     platforms and migrate bindings from opp-v1 to opp-v2 (Adam Ford,
     H. Nikolaus Schaller).

   * Merging of the arm_big_little and vexpress-spc drivers and
     related cleanup (Sudeep Holla).

   * Fix for imx's default speed grade value (Anson Huang).

   * Minor cleanup of the s3c64xx driver (Nathan Chancellor).

   * CPU speed bin detection fix for sun50i (Ondrej Jirman).

 - Appoint Chanwoo Choi as the new devfreq maintainer.

 - Update the devfreq core:

   * Check NULL governor in available_governors_show sysfs to prevent
     showing wrong governor information and fix a race condition
     between devfreq_update_status() and trans_stat_show() (Leonard
     Crestez).

   * Add new 'interrupt-driven' flag for devfreq governors to allow
     interrupt-driven governors to prevent the devfreq core from
     polling devices for status (Dmitry Osipenko).

   * Improve an error message in devfreq_add_device() (Matthias
     Kaehlcke).

 - Update devfreq drivers:

   * tegra30 driver fixes and cleanups (Dmitry Osipenko).

   * Removal of unused property from dt-binding documentation for
     the exynos-bus driver (Kamil Konieczny).

   * exynos-ppmu cleanup and DT bindings update (Lukasz Luba, Marek
     Szyprowski).

 - Add new CPU IDs for CometLake Mobile and Desktop to the Intel RAPL
   power capping driver (Zhang Rui).

 - Allow device initialization in the generic power domains (genpd)
   framework to be more straightforward and clean it up (Ulf Hansson).

 - Add support for adjusting OPP voltages at run time to the OPP
   framework (Stephen Boyd).

 - Avoid freeing memory that has never been allocated in the
   hibernation core (Andy Whitcroft).

 - Clean up function headers in a header file and coding style in the
   wakeup IRQs handling code (Ulf Hansson, Xiaofei Tan).

 - Clean up the SmartReflex adaptive voltage scaling (AVS) driver for
   ARM (Ben Dooks, Geert Uytterhoeven).

 - Wrap power management documentation to fit in 80 columns (Bjorn
   Helgaas).

 - Add pm-graph utility entry to MAINTAINERS (Todd Brandt).

 - Update the cpupower utility:

   * Fix the handling of set and info subcommands (Abhishek Goel).

   * Fix build warnings (Nathan Chancellor).

   * Improve mperf_monitor handling (Janakarajan Natarajan).

There is a merge conflict of this with the PCI tree (specifically in the
PCI power management documentation) that has been addressed by the
appended patch from Stephen in linux-next.

Thanks!


---------------

Abhishek Goel (1):
      cpupower : Handle set and info subcommands correctly

Adam Ford (2):
      cpufreq: ti-cpufreq: Add support for AM3517
      ARM: dts: Add OPP-V2 table for AM3517

Andy Whitcroft (1):
      PM / hibernate: memory_bm_find_bit(): Tighten node optimisation

Anson Huang (1):
      cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default speed grade value

Ben Dooks (1):
      ARM: OMAP2+: SmartReflex: add omap_sr_pdata definition

Bjorn Helgaas (1):
      PM: Wrap documentation to fit in 80 columns

Chanwoo Choi (1):
      MAINTAINERS: Update myself as maintainer for DEVFREQ subsystem support

Daniel Lezcano (2):
      cpuidle: Allow idle injection to apply exit latency limit
      cpuidle: Pass exit latency limit to cpuidle_use_deepest_state()

Dmitry Osipenko (18):
      PM / devfreq: tegra30: Change irq type to unsigned int
      PM / devfreq: tegra30: Keep interrupt disabled while governor is stopped
      PM / devfreq: tegra30: Handle possible round-rate error
      PM / devfreq: tegra30: Drop write-barrier
      PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
      PM / devfreq: tegra30: Use kHz units uniformly in the code
      PM / devfreq: tegra30: Use CPUFreq notifier
      PM / devfreq: tegra30: Move clk-notifier's registration to
governor's start
      PM / devfreq: tegra30: Reset boosting on startup
      PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
      PM / devfreq: tegra30: Constify structs
      PM / devfreq: tegra30: Include appropriate header
      PM / devfreq: tegra30: Don't enable already enabled consecutive interrupts
      PM / devfreq: tegra30: Disable consecutive interrupts when appropriate
      PM / devfreq: tegra30: Use kHz units for dependency threshold
      PM / devfreq: Add new interrupt_driven flag for governors
      PM / devfreq: tegra30: Support variable polling interval
      PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient

Geert Uytterhoeven (1):
      power: avs: smartreflex: Remove superfluous cast in
debugfs_create_file() call

H. Nikolaus Schaller (6):
      cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
      ARM: dts: omap34xx & omap36xx: replace opp-v1 tables by opp-v2 for
      DTS: bindings: omap: update bindings documentation
      ARM: dts: omap3: bulk convert compatible to be explicitly
ti,omap3430 or ti,omap3630 or ti,am3517
      cpufreq: ti-cpufreq: omap36xx use "cpu0","vbb" if run in
multi_regulator mode
      ARM: dts: omap36xx: using OPP1G needs to control the abb_ldo

Jamal Shareef (1):
      cpufreq: intel_pstate: Fix plain int as pointer warning from sparse

Janakarajan Natarajan (4):
      cpupower: Move needs_root variable into a sub-struct
      cpupower: mperf_monitor: Introduce per_cpu_schedule flag
      cpupower: mperf_monitor: Update cpupower to use the RDPRU instruction
      cpupower: ToDo: Update ToDo with ideas for per_cpu_schedule handling

John Hubbard (1):
      cpufreq: powernv: fix stack bloat and hard limit on number of CPUs

Kai Shen (1):
      cpufreq: Add NULL checks to show() and store() methods of cpufreq

Kamil Konieczny (1):
      dt-bindings: devfreq: exynos-bus: Remove unused property

Leonard Crestez (2):
      PM / devfreq: Check NULL governor in available_governors_show
      PM / devfreq: Lock devfreq in trans_stat_show

Lukasz Luba (2):
      include: dt-bindings: add Performance Monitoring Unit for Exynos
      Documentation: devicetree: add PPMU events description

Marek Szyprowski (1):
      PM / devfreq: exynos-ppmu: remove useless assignment

Matthias Kaehlcke (1):
      PM / devfreq: Make log message more explicit when devfreq device
already exists

Nathan Chancellor (2):
      tools/power/cpupower: Fix initializer override in hsw_ext_cstates
      cpufreq: s3c64xx: Remove pointless NULL check in
s3c64xx_cpufreq_driver_init

Ondrej Jirman (1):
      cpufreq: sun50i: Fix CPU speed bin detection

Rafael J. Wysocki (10):
      cpuidle: teo: Ignore disabled idle states that are too deep
      cpuidle: teo: Rename local variable in teo_select()
      cpuidle: teo: Consider hits and misses metrics of disabled states
      cpuidle: teo: Fix "early hits" handling for disabled idle states
      cpuidle: Consolidate disabled state checks
      cpuidle: Use nanoseconds as the unit of time
      cpuidle: teo: Exclude cpuidle overhead from computations
      cpuidle: teo: Avoid using "early hits" incorrectly
      cpuidle: teo: Avoid code duplication in conditionals
      cpuidle: Introduce cpuidle_driver_state_disabled() for driver quirks

Stephen Boyd (1):
      PM / OPP: Support adjusting OPP voltages at runtime

Sudeep Holla (7):
      cpufreq: scpi: remove stale/outdated comment about the driver
      cpufreq: merge arm_big_little and vexpress-spc
      cpufreq: vexpress-spc: drop unnessary cpufreq_arm_bL_ops abstraction
      cpufreq: vexpress-spc: remove lots of debug messages
      cpufreq: vexpress-spc: fix some coding style issues
      cpufreq: vexpress-spc: use macros instead of hardcoded values
for cluster ids
      cpufreq: vexpress-spc: find and skip duplicates when merging frequencies

Todd Brandt (1):
      pm-graph info added to MAINTAINERS

Ulf Hansson (5):
      PM / core: Clean up some function headers in power.h
      PM / Domains: Introduce dev_pm_domain_start()
      PM / Domains: Implement the ->start() callback for genpd
      mmc: tmio: Avoid boilerplate code in ->runtime_suspend()
      PM / Domains: Convert to dev_to_genpd_safe() in genpd_syscore_switch()

Viresh Kumar (2):
      cpufreq: Clarify the comment in cpufreq_set_policy()
      cpufreq: Register drivers only after CPU devices have been registered

Xiaofei Tan (1):
      PM / wakeirq: remove unnecessary parentheses

Yin Fengwei (1):
      ACPI: processor_idle: Skip dummy wait if kernel is in guest

Zhang Rui (2):
      powercap/intel_rapl: add support for CometLake Mobile
      powercap/intel_rapl: add support for Cometlake desktop

Zhenzhong Duan (1):
      cpuidle: Do not unset the driver if it is there already

---------------

 .../devicetree/bindings/arm/omap/omap.txt          |  30 +-
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |   6 +-
 .../bindings/devfreq/event/exynos-ppmu.txt         |  26 +-
 .../devicetree/bindings/devfreq/exynos-bus.txt     |   2 -
 Documentation/power/drivers-testing.rst            |   7 +-
 Documentation/power/freezing-of-tasks.rst          |  37 +-
 Documentation/power/opp.rst                        |  32 +-
 Documentation/power/pci.rst                        |  28 +-
 Documentation/power/pm_qos_interface.rst           |  26 +-
 Documentation/power/runtime_pm.rst                 |   4 +-
 Documentation/power/suspend-and-cpuhotplug.rst     |   7 +-
 Documentation/power/swsusp.rst                     |  14 +-
 MAINTAINERS                                        |  23 +-
 arch/arm/boot/dts/am3517.dtsi                      |  31 +
 arch/arm/boot/dts/am3517_mt_ventoux.dts            |   2 +-
 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts   |   2 +-
 arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts  |   2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +-
 arch/arm/boot/dts/omap3-cm-t3530.dts               |   2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts               |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts       |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts       |   2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts             |   2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   2 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts                 |   2 +-
 arch/arm/boot/dts/omap3-ha.dts                     |   2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts         |   2 +-
 arch/arm/boot/dts/omap3-igep0020.dts               |   2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts         |   2 +-
 arch/arm/boot/dts/omap3-igep0030.dts               |   2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts           |   2 +-
 arch/arm/boot/dts/omap3-n9.dts                     |   2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |   7 -
 arch/arm/boot/dts/omap3-n950.dts                   |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-alto35.dts     |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-palo35.dts     |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-palo43.dts     |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-summit.dts     |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts    |   2 +-
 arch/arm/boot/dts/omap3-pandora-1ghz.dts           |   2 +-
 arch/arm/boot/dts/omap3-sbc-t3530.dts              |   2 +-
 arch/arm/boot/dts/omap3-sbc-t3730.dts              |   2 +-
 arch/arm/boot/dts/omap3-sniper.dts                 |   2 +-
 arch/arm/boot/dts/omap3-thunder.dts                |   2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |   2 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |  66 ++-
 arch/arm/boot/dts/omap36xx.dtsi                    |  65 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  |   4 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c              |   2 +-
 drivers/acpi/processor_idle.c                      |  21 +-
 drivers/base/power/common.c                        |  20 +
 drivers/base/power/domain.c                        |  40 +-
 drivers/base/power/power.h                         |  30 +-
 drivers/base/power/wakeirq.c                       |   4 +-
 drivers/cpufreq/Kconfig.arm                        |  12 +-
 drivers/cpufreq/Makefile                           |   2 -
 drivers/cpufreq/arm_big_little.c                   | 658 ---------------------
 drivers/cpufreq/arm_big_little.h                   |  43 --
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +-
 drivers/cpufreq/cpufreq.c                          |  18 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |  20 +-
 drivers/cpufreq/intel_pstate.c                     |  30 +-
 drivers/cpufreq/powernv-cpufreq.c                  |  17 +-
 drivers/cpufreq/s3c64xx-cpufreq.c                  |   7 -
 drivers/cpufreq/scpi-cpufreq.c                     |   2 -
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |  25 +-
 drivers/cpufreq/ti-cpufreq.c                       | 119 +++-
 drivers/cpufreq/vexpress-spc-cpufreq.c             | 584 +++++++++++++++++-
 drivers/cpuidle/cpuidle-powernv.c                  |   7 +-
 drivers/cpuidle/cpuidle.c                          |  72 +--
 drivers/cpuidle/driver.c                           |  72 ++-
 drivers/cpuidle/governor.c                         |   7 +-
 drivers/cpuidle/governors/haltpoll.c               |   7 +-
 drivers/cpuidle/governors/ladder.c                 |  29 +-
 drivers/cpuidle/governors/menu.c                   | 131 ++--
 drivers/cpuidle/governors/teo.c                    | 182 ++++--
 drivers/cpuidle/poll_state.c                       |   2 +
 drivers/cpuidle/sysfs.c                            |  71 ++-
 drivers/devfreq/devfreq.c                          |  33 +-
 drivers/devfreq/event/exynos-ppmu.c                |   1 -
 drivers/devfreq/governor.h                         |   3 +
 drivers/devfreq/tegra30-devfreq.c                  | 417 +++++++++----
 drivers/mmc/host/tmio_mmc.h                        |   1 -
 drivers/mmc/host/tmio_mmc_core.c                   |  10 +-
 drivers/opp/core.c                                 |  69 +++
 drivers/power/avs/smartreflex.c                    |   2 +-
 drivers/powercap/intel_rapl_common.c               |   2 +
 include/dt-bindings/pmu/exynos_ppmu.h              |  25 +
 include/linux/cpu.h                                |   7 +-
 include/linux/cpuidle.h                            |  27 +-
 include/linux/pm.h                                 |   2 +
 include/linux/pm_domain.h                          |   5 +
 include/linux/pm_opp.h                             |  13 +
 include/linux/power/smartreflex.h                  |   3 +
 kernel/power/snapshot.c                            |   9 +-
 kernel/sched/idle.c                                |  24 +-
 tools/power/cpupower/ToDo                          |  14 +
 tools/power/cpupower/utils/cpupower-info.c         |   9 +
 tools/power/cpupower/utils/cpupower-set.c          |   9 +
 tools/power/cpupower/utils/helpers/cpuid.c         |   4 +
 tools/power/cpupower/utils/helpers/helpers.h       |   1 +
 .../cpupower/utils/idle_monitor/amd_fam14h_idle.c  |   2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |   2 +-
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |   2 +-
 .../cpupower/utils/idle_monitor/cpupower-monitor.h |   5 +-
 .../cpupower/utils/idle_monitor/hsw_ext_idle.c     |   3 +-
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  64 +-
 tools/power/cpupower/utils/idle_monitor/nhm_idle.c |   2 +-
 tools/power/cpupower/utils/idle_monitor/snb_idle.c |   2 +-
 116 files changed, 2091 insertions(+), 1406 deletions(-)


---------------

diff --cc Documentation/power/pci.rst
index 0924d29636ad,51e0a493d284..000000000000
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@@ -692,11 -692,11 +692,11 @@@ controlling the runtime power managemen
  At the time of this writing there are two ways to define power management
  callbacks for a PCI device driver, the recommended one, based on using a
  dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and
- the "legacy" one, in which the .suspend() and .resume() callbacks from struct
- pci_driver are used.  The legacy approach, however, doesn't allow
one to define
- runtime power management callbacks and is not really suitable for any new
- drivers.  Therefore it is not covered by this document (refer to the
source code
- to learn more about it).
 -the "legacy" one, in which the .suspend(), .suspend_late(),
.resume_early(), and
 -.resume() callbacks from struct pci_driver are used.  The legacy approach,
 -however, doesn't allow one to define runtime power management callbacks and is
 -not really suitable for any new drivers.  Therefore it is not covered by this
 -document (refer to the source code to learn more about it).
++the "legacy" one, in which the .suspend() and .resume() callbacks from
++struct pci_driver are used.  The legacy approach, however, doesn't allow
++one to define runtime power management callbacks and is not really suitable
++for any new drivers.  Therefore it is not covered by this document (refer
++to the source code to learn more about it).

  It is recommended that all PCI device drivers define a struct
dev_pm_ops object
  containing pointers to power management (PM) callbacks that will be
executed by
