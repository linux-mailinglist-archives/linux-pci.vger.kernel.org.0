Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E5162B1E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2019 23:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbfGHVgk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 8 Jul 2019 17:36:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37667 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfGHVgk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 17:36:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so17749651otp.4;
        Mon, 08 Jul 2019 14:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=eMUSKo6iEe8G01P776LcpFMuJ7VQceevTGt23xb94tA=;
        b=CplHVk7yD68U89ylzP+KsJ0AjhqPaNEcDcKQKH9HjJ84QOn0bRhdFLXSRt9Nw4t3oz
         eH2lTlilLYF/2FDtegfgCTkQA2xEyFwju+rnNJ/6XWPZy+QhkDlRNDnB4mpYDuBvAnpS
         V4zo4d5HoDr73M2fwmb1Rku853bfmppvflC+GlyDPDWfmiwGVQqPFEeoVLAr3R+xoXzF
         YEN45rPH0ZeQtoE+Pwrm22+RYDx6s0pfvsQxX+BFZrNovUGRV1EgchG8XZ0eIT2rLKPW
         Uv4iCVY8kRdIUePkml1hgNwshkB/PlyfCXhzodlFosF8Lcc/gVGDv+woKnptDZKu6NaC
         Grhg==
X-Gm-Message-State: APjAAAXtoDG4PUwV8fvbtu8b57D8wHEtDtjzp4nidoC/J2DZUrYwJ3qp
        9gDFA5Obd6Sn0EtyFuzdsAT9vfgXPRSBTAEvee+CG63c
X-Google-Smtp-Source: APXvYqwPgpD//Rh4nEEkHTfVcFnuPpe+M8/PQSIAWA+yyF9sjiFaIcFgD9mz95D/ILFolo5QGWvkOTa55UsUmt3HY+4=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr15574374otp.189.1562621798432;
 Mon, 08 Jul 2019 14:36:38 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Jul 2019 23:36:26 +0200
Message-ID: <CAJZ5v0jfQX=QmX9NFRu7M98=WjeVhSW4X0nTW93-MeB3FR1uWw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.3-rc1

with top-most commit 586a07dca8c51b966960d1f0d8be9c27d7e0a95c

 Merge branch 'pm-cpufreq'

on top of commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf

 Linux 5.2-rc7

to receive power management updates for 5.3-rc1.

These update PCI and ACPI power management (improved handling of
ACPI power resources and PCIe link delays, fixes related to corner
cases, hibernation handling rework), fix and extend the operating
performance points (OPP) framework, add new cpufreq drivers for
Raspberry Pi and imx8m chips, update some other cpufreq drivers,
clean up assorted pieces of PM code and documentation and update
tools.

Specifics:

 - Improve the handling of shared ACPI power resources in the PCI
   bus type layer (Mika Westerberg).

 - Make the PCI layer take link delays required by the PCIe spec
   into account as appropriate and avoid polling devices in D3cold
   for PME (Mika Westerberg).

 - Fix some corner case issues in ACPI device power management and
   in the PCI bus type layer, optimiza and clean up the handling of
   runtime-suspended PCI devices during system-wide transitions to
   sleep states (Rafael Wysocki).

 - Rework hibernation handling in the ACPI core and the PCI bus type
   to resume runtime-suspended devices before hibernation (which
   allows some functional problems to be avoided) and fix some ACPI
   power management issues related to hiberation (Rafael Wysocki).

 - Extend the operating performance points (OPP) framework to support
   a wider range of devices (Rajendra Nayak, Stehpen Boyd).

 - Fix issues related to genpd_virt_devs and issues with platforms
   using the set_opp() callback in the OPP framework (Viresh Kumar,
   Dmitry Osipenko).

 - Add new cpufreq driver for Raspberry Pi (Nicolas Saenz Julienne).

 - Add new cpufreq driver for imx8m and imx7d chips (Leonard Crestez).

 - Fix and clean up the pcc-cpufreq, brcmstb-avs-cpufreq, s5pv210,
   and armada-37xx cpufreq drivers (David Arcari, Florian Fainelli,
   Paweł Chmiel, YueHaibing).

 - Clean up and fix the cpufreq core (Viresh Kumar, Daniel Lezcano).

 - Fix minor issue in the ACPI system sleep support code and export
   one function from it (Lenny Szubowicz, Dexuan Cui).

 - Clean up assorted pieces of PM code and documentation (Kefeng Wang,
   Andy Shevchenko, Bart Van Assche, Greg Kroah-Hartman, Fuqian Huang,
   Geert Uytterhoeven, Mathieu Malaterre, Rafael Wysocki).

 - Update the pm-graph utility to v5.4 (Todd Brandt).

 - Fix and clean up the cpupower utility (Abhishek Goel, Nick Black).

Thanks!


---------------

Abhishek Goel (1):
      cpupower : frequency-set -r option misses the last cpu in related cpu list

Andy Shevchenko (1):
      ACPI / sleep: Switch to use acpi_dev_get_first_match_dev()

Bart Van Assche (1):
      PM: sleep: Show how long dpm_suspend_start() and dpm_suspend_end() take

Daniel Lezcano (1):
      cpufreq: Move the IS_ENABLED(CPU_THERMAL) macro into a stub

David Arcari (1):
      cpufreq: pcc-cpufreq: Fail initialization if driver cannot be registered

Dexuan Cui (1):
      ACPI: PM: Make acpi_sleep_state_supported() non-static

Dmitry Osipenko (1):
      opp: Don't use IS_ERR on invalid supplies

Florian Fainelli (2):
      cpufreq: brcmstb-avs-cpufreq: Fix initial command check
      cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency

Fuqian Huang (1):
      kernel: power: swap: use kzalloc() instead of kmalloc() followed
by memset()

Geert Uytterhoeven (2):
      PM / clk: Remove error message on out-of-memory condition
      Documentation: ABI: power: Add missing newline at end of file

Greg Kroah-Hartman (2):
      power: avs: smartreflex: no need to check return value of
debugfs_create functions
      drivers: base: power: remove wakeup_sources_stats_dentry variable

Kefeng Wang (1):
      drivers: base: power: clock_ops: Use of_clk_get_parent_count()

Lenny Szubowicz (1):
      ACPI / LPIT: Correct LPIT end address for lpit_process()

Leonard Crestez (5):
      cpufreq: Add imx-cpufreq-dt driver
      dt-bindings: imx-cpufreq-dt: Document opp-supported-hw usage
      cpufreq: imx-cpufreq-dt: Fix no OPPs available on unfused parts
      cpufreq: imx-cpufreq-dt: Remove global platform match list
      cpufreq: Switch imx7d to imx-cpufreq-dt for speed grading

Mathieu Malaterre (1):
      PM: hibernate: powerpc: Expose pfn_is_nosave() prototype

Mika Westerberg (5):
      PCI: Add missing link delays required by the PCIe spec
      PCI: Do not poll for PME if the device is in D3cold
      PCI / ACPI: Use cached ACPI device state to get PCI device power state
      ACPI / PM: Introduce concept of a _PR0 dependent device
      PCI / ACPI: Add _PR0 dependent devices

Nick Black (1):
      cpupower: correct spelling of interval

Nicolas Saenz Julienne (1):
      cpufreq: add driver for Raspberry Pi

Paweł Chmiel (1):
      cpufreq: s5pv210: Don't flood kernel log after cpufreq change

Rafael J. Wysocki (14):
      PCI: PM: Avoid resuming devices in D3hot during system suspend
      PCI: PM: Replace pci_dev_keep_suspended() with two functions
      PM: suspend: Rename pm_suspend_via_s2idle()
      PM: sleep: Update struct wakeup_source documentation
      ACPI: PM: Avoid evaluating _PS3 on transitions from D3hot to D3cold
      ACPI: PM: Allow transitions to D0 to occur in special cases
      PCI: PM/ACPI: Refresh all stale power state data in pci_pm_complete()
      PM: ACPI/PCI: Resume all devices during hibernation
      PCI: PM: Simplify bus-level hibernation callbacks
      ACPI: PM: Simplify and fix PM domain hibernation callbacks
      ACPI: PM: Introduce "poweroff" callbacks for ACPI PM domain and LPSS
      ACPI: PM: Drop unused function and function header
      ACPI: PM: Unexport acpi_device_get_power()
      PM: sleep: Drop dev_pm_skip_next_resume_phases()

Rajendra Nayak (1):
      opp: Make dev_pm_opp_set_rate() handle freq = 0 to drop performance votes

Stephen Boyd (1):
      opp: Don't overwrite rounded clk rate

Todd Brandt (3):
      Update to pm-graph 5.3
      Update to pm-graph 5.4
      Add README and update pm-graph and sleepgraph docs

Viresh Kumar (7):
      opp: Attach genpds to devices from within OPP core
      opp: Allocate genpd_virt_devs from dev_pm_opp_attach_genpd()
      cpufreq: Remove redundant !setpolicy check
      cpufreq: Use has_target() instead of !setpolicy
      cpufreq: Don't skip frequency validation for has_target() drivers
      cpufreq: Consolidate cpufreq_update_current_freq() and __cpufreq_get()
      cpufreq: Avoid calling cpufreq_verify_current_freq() from handle_update()

YueHaibing (1):
      cpufreq: armada-37xx: Remove set but not used variable 'freq'

---------------

 Documentation/ABI/testing/sysfs-power              |   2 +-
 .../devicetree/bindings/cpufreq/imx-cpufreq-dt.txt |  37 +
 arch/powerpc/kernel/suspend.c                      |   1 +
 arch/s390/kernel/entry.h                           |   1 -
 drivers/acpi/acpi_lpit.c                           |   7 +-
 drivers/acpi/acpi_lpss.c                           | 111 ++-
 drivers/acpi/device_pm.c                           | 165 ++--
 drivers/acpi/internal.h                            |   7 +
 drivers/acpi/power.c                               | 135 ++++
 drivers/acpi/sleep.c                               |  22 +-
 drivers/base/power/clock_ops.c                     |   6 +-
 drivers/base/power/main.c                          |  36 +-
 drivers/base/power/wakeup.c                        |   6 +-
 drivers/cpufreq/Kconfig.arm                        |  17 +
 drivers/cpufreq/Makefile                           |   2 +
 drivers/cpufreq/armada-37xx-cpufreq.c              |   4 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |  12 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +-
 drivers/cpufreq/cpufreq.c                          | 121 ++-
 drivers/cpufreq/imx-cpufreq-dt.c                   |  97 +++
 drivers/cpufreq/pcc-cpufreq.c                      |   4 +-
 drivers/cpufreq/raspberrypi-cpufreq.c              |  97 +++
 drivers/cpufreq/s5pv210-cpufreq.c                  |   2 +-
 drivers/input/serio/i8042.c                        |   2 +-
 drivers/opp/core.c                                 | 174 +++--
 drivers/opp/of.c                                   |  30 +-
 drivers/pci/pci-acpi.c                             |  14 +-
 drivers/pci/pci-driver.c                           |  74 +-
 drivers/pci/pci.c                                  | 116 ++-
 drivers/pci/pci.h                                  |   8 +-
 drivers/pci/pcie/portdrv_core.c                    |  66 ++
 drivers/power/avs/smartreflex.c                    |  41 +-
 drivers/soc/imx/soc-imx8.c                         |   3 +
 include/acpi/acpi_bus.h                            |  11 +-
 include/linux/acpi.h                               |  14 +-
 include/linux/cpufreq.h                            |   6 +
 include/linux/pm.h                                 |   1 -
 include/linux/pm_opp.h                             |   8 +-
 include/linux/pm_wakeup.h                          |   2 +-
 include/linux/suspend.h                            |   5 +-
 kernel/power/power.h                               |   2 -
 kernel/power/suspend.c                             |   6 +-
 kernel/power/swap.c                                |   3 +-
 tools/power/cpupower/man/cpupower-monitor.1        |   2 +-
 tools/power/cpupower/po/cs.po                      |   2 +-
 tools/power/cpupower/po/de.po                      |   2 +-
 tools/power/cpupower/po/fr.po                      |   2 +-
 tools/power/cpupower/po/it.po                      |   2 +-
 tools/power/cpupower/po/pt.po                      |   2 +-
 tools/power/cpupower/utils/cpufreq-set.c           |   2 +
 tools/power/pm-graph/README                        | 552 +++++++++++++
 tools/power/pm-graph/bootgraph.py                  |   8 +-
 tools/power/pm-graph/config/example.cfg            |  26 +
 tools/power/pm-graph/sleepgraph.8                  |  16 +-
 tools/power/pm-graph/sleepgraph.py                 | 857 ++++++++++++++++-----
 55 files changed, 2325 insertions(+), 631 deletions(-)
