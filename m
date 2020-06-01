Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEA31EA754
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgFAPui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 11:50:38 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37231 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 11:50:38 -0400
Received: by mail-ot1-f52.google.com with SMTP id v13so1540324otp.4;
        Mon, 01 Jun 2020 08:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=69SYC94yn9qZ/Z3PT1dezLCRI01i2qt09YeXnx/s12c=;
        b=dJHO89bKmmNHA6OhwFMjfHBfsGlCUp9t6Ryv1R9GKzAJpPiyDvshtMrCWkpyao4Fq5
         coLmZVCftqkPeJ7keMsQjFErnr8+D9lS2J9uGWsqU/LT5T19mEc9QCRGODsHJOVLIJsd
         JyUm1ihM73iXUhrNJXj9vU6KWd5ojH37bVGO+BmwUL1alhUkwxTdTs7anjP4Nj7Vs0Iz
         giiX1Mf78MiWXNCYUs6XR0sJHh0tP/NHg9pTnuSR1DXs+KbwsKVQ3peA0XEj/IPCc/LD
         +aaYbtC4BzjMMyYewt3wv2qlHV38QxT+0Z8y77pGg00H4WVaOqHl/xXsw9xnSNjtsj+w
         L0dA==
X-Gm-Message-State: AOAM533TdGjm/RbP+tJgl3O8N2qHQ+bg7LZQm46E3J2TcBs4gkOVXWVv
        wydvJRlFlY2vjYsyiM08cyrUtAtj54BFKRadHVs=
X-Google-Smtp-Source: ABdhPJwMqeOG25JNRt/ERle5w0OKtuztUzNyLOw38otV/hzvT2kuDiV+hPlNaxunZghBhKFG8lg6gZWZLpxjLMpE1oE=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr14924271otq.167.1591026636766;
 Mon, 01 Jun 2020 08:50:36 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Jun 2020 17:50:25 +0200
Message-ID: <CAJZ5v0gfVaNkSvDCXghKKXL34cLTwyC5jWBX8TYZjPVUOEvdjw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.8-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.8-rc1

with top-most commit 48ccdeddc54771ecdc46fac098bac689e9df24ca

 Merge branches 'acpi-apei', 'acpi-pmic', 'acpi-video' and 'acpi-dptf'

on top of commit 9cb1fd0efd195590b828b9b865421ad345a4a145

 Linux 5.7-rc7

to receive ACPI updates for 5.8-rc1.

These update the ACPICA code in the kernel to upstream revision
20200430, fix several reference counting errors related to ACPI
tables, add _Exx / _Lxx support to the GED driver, add a new
acpi_evaluate_reg() helper, add new DPTF battery participant driver
and extend the DPFT power participant driver, improve the handling
of memory failures in the APEI code, add a blacklist entry to the
backlight driver, update the PMIC driver and the processor idle
driver, fix two kobject reference count leaks, and make a few
janitory changes.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision
   20200430:

   * Move acpi_gbl_next_cmd_num definition (Erik Kaneda).

   * Ignore AE_ALREADY_EXISTS status in the disassembler when parsing
     create operators (Erik Kaneda).

   * Add status checks to the dispatcher (Erik Kaneda).

   * Fix required parameters for _NIG and _NIH (Erik Kaneda).

   * Make acpi_protocol_lengths static (Yue Haibing).

 - Fix ACPI table reference counting errors in several places, mostly
   in error code paths (Hanjun Guo).

 - Extend the Generic Event Device (GED) driver to support _Exx and
   _Lxx handler methods (Ard Biesheuvel).

 - Add new acpi_evaluate_reg() helper and modify the ACPI PCI hotplug
   code to use it (Hans de Goede).

 - Add new DPTF battery participant driver and make the DPFT power
   participant driver create more sysfs device attributes (Srinivas
   Pandruvada).

 - Improve the handling of memory failures in APEI (James Morse).

 - Add new blacklist entry for Acer TravelMate 5735Z to the backlight
   driver (Paul Menzel).

 - Add i2c address for thermal control to the PMIC driver (Mauro
   Carvalho Chehab).

 - Allow the ACPI processor idle driver to work on platforms with
   only one ACPI C-state present (Zhang Rui).

 - Fix kobject reference count leaks in error code paths in two
   places (Qiushi Wu).

 - Delete unused proc filename macros and make some symbols static
   (Pascal Terjan, Zheng Zengkai, Zou Wei).

Thanks!


---------------

Ard Biesheuvel (2):
      ACPI: GED: add support for _Exx / _Lxx handler methods
      ACPI: GED: use correct trigger type field in _Exx / _Lxx handling

Bob Moore (1):
      ACPICA: Update version to 20200430

Erik Kaneda (4):
      ACPICA: Move acpi_gbl_next_cmd_num definition to acglobal.h
      ACPICA: Disassembler: ignore AE_ALREADY_EXISTS status when
parsing create operators
      ACPICA: Dispatcher: add status checks
      ACPICA: Fix required parameters for _NIG and _NIH

Hanjun Guo (9):
      ACPI: LPIT: Put the low power idle table after using it
      ACPI: watchdog: Put the watchdog action table after parsing
      ACPI: APEI: Put the boot error record table after parsing
      ACPI: APEI: Put the error injection table for error path and module exit
      ACPI: APEI: Put the error record serialization table for error path
      ACPI: APEI: Put the HEST table for error path
      ACPI: EC: Put the ACPI table after using it
      ACPI: scan: Put SPCR and STAO table after using it
      ACPI: sleep: Put the FACS table after using it

Hans de Goede (2):
      ACPI: utils: Add acpi_evaluate_reg() helper
      ACPI: hotplug: PCI: Use the new acpi_evaluate_reg() helper

James Morse (3):
      mm/memory-failure: Add memory_failure_queue_kick()
      ACPI: APEI: Kick the memory_failure() queue for synchronous errors
      arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work

Mauro Carvalho Chehab (1):
      ACPI / PMIC: Add i2c address for thermal control

Pascal Terjan (1):
      ACPI: Delete unused proc filename macros

Paul Menzel (1):
      ACPI: video: Use native backlight on Acer TravelMate 5735Z

Qiushi Wu (2):
      ACPI: sysfs: Fix reference count leak in acpi_sysfs_add_hotplug_profile()
      ACPI: CPPC: Fix reference count leak in acpi_cppc_processor_probe()

Srinivas Pandruvada (2):
      ACPI: DPTF: Additional sysfs attributes for power participant driver
      ACPI: DPTF: Add battery participant driver

Yue Haibing (1):
      ACPICA: Make acpi_protocol_lengths static

Zhang Rui (1):
      ACPI: processor: idle: Allow probing on platforms with one ACPI C-state

Zheng Zengkai (1):
      ACPI: debug: Make two functions static

Zou Wei (1):
      ACPI: CPPC: Make some symbols static

---------------

 Documentation/ABI/testing/sysfs-platform-dptf |  62 ++++++++++-
 arch/arm64/kernel/acpi.c                      |  25 +++++
 arch/arm64/mm/fault.c                         |  12 ++-
 drivers/acpi/acpi_dbg.c                       |   4 +-
 drivers/acpi/acpi_lpit.c                      |   3 +-
 drivers/acpi/acpi_watchdog.c                  |   7 +-
 drivers/acpi/acpica/acglobal.h                |   1 +
 drivers/acpi/acpica/acpredef.h                |   4 +-
 drivers/acpi/acpica/dbhistry.c                |   1 -
 drivers/acpi/acpica/dsfield.c                 |  22 ++--
 drivers/acpi/acpica/exfield.c                 |   2 +-
 drivers/acpi/apei/bert.c                      |   6 +-
 drivers/acpi/apei/einj.c                      |   5 +-
 drivers/acpi/apei/erst.c                      |   4 +-
 drivers/acpi/apei/ghes.c                      |  67 ++++++++++--
 drivers/acpi/apei/hest.c                      |   5 +-
 drivers/acpi/button.c                         |   1 -
 drivers/acpi/cppc_acpi.c                      |   5 +-
 drivers/acpi/dptf/dptf_power.c                | 147 ++++++++++++++++++++++++--
 drivers/acpi/ec.c                             |  21 ++--
 drivers/acpi/evged.c                          |  22 +++-
 drivers/acpi/pci_link.c                       |   2 -
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c       |   1 +
 drivers/acpi/power.c                          |   2 -
 drivers/acpi/processor_idle.c                 |   9 +-
 drivers/acpi/sbs.c                            |   3 -
 drivers/acpi/scan.c                           |  15 ++-
 drivers/acpi/sleep.c                          |   4 +-
 drivers/acpi/sysfs.c                          |   4 +-
 drivers/acpi/utils.c                          |  25 +++++
 drivers/acpi/video_detect.c                   |  10 ++
 drivers/pci/hotplug/acpiphp_glue.c            |  13 +--
 include/acpi/acpi_bus.h                       |   1 +
 include/acpi/acpixf.h                         |   2 +-
 include/acpi/ghes.h                           |   3 +
 include/linux/mm.h                            |   1 +
 mm/memory-failure.c                           |  15 ++-
 37 files changed, 438 insertions(+), 98 deletions(-)
