Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A14436BD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 20:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhKBTy2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 2 Nov 2021 15:54:28 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36472 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhKBTyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 15:54:10 -0400
Received: by mail-oi1-f169.google.com with SMTP id q124so459151oig.3;
        Tue, 02 Nov 2021 12:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vTWWP64uNRBPhYR9UkSx4oF46k1DV8EYISsWLjC5kq8=;
        b=u1/qdNuLCDxG62qCSfVU/Dhd1An/eZ2O3aH/RHnXZZuMbPhmXhkRKr162dG7ATmkQ9
         aUzUjgzRt15GBskXkBZYYEXbTeM2031lp8YfXNiUrQ+uwKEcvRyakZ1r64R/MN73dWai
         tW9+OYOfsMZVgBVotBLnVZlnmd5CpRHI2F5XmmMsZIROQq3f+UGmybOy906gnjcT5OEn
         avqJgjDGEV+WfN2hqdPwYY5H8sHGNneRWA6ufa3xYZvgtVECY0h6SwJFXl6GL3PTo/ID
         +i76aDnVnu9w0H3N3hQOjpxoVuxrjT67cbphTDiMwnyC3e8VqEjz01MtQ8d3MVMLXDnh
         oQ/A==
X-Gm-Message-State: AOAM533oD4OieaaQCSmGHeS6KsI9UPTCPCqi0TYvyJcnACzr0OE48Z8M
        tXYQgv+EDObg/GCrPiAZLZGzJdso0Oi6Q/2O3CQKfOJyHJA=
X-Google-Smtp-Source: ABdhPJxtTI3uJYMhEsGZPFA4GrdPYKkc91C/83CT2kMHlDzeMGgtmGjoJUH+v1I9mLJFNPAt/iiEKPnOpS1aqwPvKQA=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr6847662oif.154.1635882695136;
 Tue, 02 Nov 2021 12:51:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Nov 2021 20:51:24 +0100
Message-ID: <CAJZ5v0jT44cw=Ls=imqBs1ErO60tbeDnOhD-wGPjPe9L=aa1=Q@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.16-rc1

with top-most commit 90e17edac46882ee5fa4dfb6a72956b89dd188f3

 Merge branches 'acpi-apei', 'acpi-prm' and 'acpi-docs'

on top of commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea

 Linux 5.15-rc7

to receive ACPI updates for 5.16-rc1.

These update the ACPICA code in the kernel to the most recent
upstream revision, address some issues related to the ACPI power
resources management, simplify the enumeration of PCI devices
having ACPI companions, add new quirks, fix assorted problems,
update the ACPI-related information in maintainers and clean up
code in several places.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20210930
   including the following changes:

   * Fix system-wide resume issue caused by evaluating control
     methods too early in the resume path (Rafael Wysocki).

   * Add support for Windows 2020 _OSI string (Mario Limonciello).

   * Add Generic Port Affinity type for SRAT (Alison Schofield).

   * Add disassembly support for the NHLT ACPI table (Bob Moore).

 - Avoid flushing caches before entering C3 type of idle states on
   AMD processors (Deepak Sharma).

 - Avoid enumerating CPUs that are not present and not online-capable
   according to the platform firmware (Mario Limonciello).

 - Add DMI-based mechanism to quirk IRQ overrides and use it for two
   platforms (Hui Wang).

 - Change the configuration of unused ACPI device objects to reflect
   the D3cold power state after enumerating devices (Rafael Wysocki).

 - Update MAINTAINERS information regarding ACPI (Rafael Wysocki).

 - Fix typo in ACPI Kconfig (Masanari Iid).

 - Use sysfs_emit() instead of snprintf() in some places (Qing Wang).

 - Make the association of ACPI device objects with PCI devices more
   straightforward and simplify the code doing that for all devices
   in general (Rafael Wysocki).

 - Use acpi_device_adr() in acpi_find_child_device() instead of
   evaluating _ADR (Rafael Wysocki).

 - Drop duplicate device IDs from PNP device IDs list (Krzysztof
   Kozlowski).

 - Allow acpi_idle_play_dead() to use C3 on AMD processors (Richard
   Gong).

 - Use ACPI_COMPANION() to simplify code in some drivers (Rafael
   Wysocki).

 - Check the states of all ACPI power resources during initialization
   to avoid dealing with power resources in unknown states (Rafael
   Wysocki).

 - Fix ACPI power resource issues related to sharing wakeup power
   resources (Rafael Wysocki).

 - Avoid registering redundant suspend_ops (Rafael Wysocki).

 - Report battery charging state as "full" if it appears to be over
   the design capacity (André Almeida).

 - Quirk GK45 mini PC to skip reading _PSR in the AC driver (Stefan
   Schaeckeler).

 - Mark apei_hest_parse() static (Christoph Hellwig).

 - Relax platform response timeout to 1 second after instructing it
   to inject an error (Shuai Xue).

 - Make the PRM code handle memory allocation and remapping failures
   more gracefully and drop some unnecessary blank lines from that
   code (Aubrey Li).

 - Fix spelling mistake in the ACPI documentation (Colin Ian King).

Thanks!


---------------

Alison Schofield (1):
      ACPICA: ACPI 6.4 SRAT: add Generic Port Affinity type

André Almeida (1):
      ACPI: battery: Accept charges over the design capacity as full

Aubrey Li (2):
      ACPI: PRM: Remove unnecessary blank lines
      ACPI: PRM: Handle memory allocation and memory remap failure

Bob Moore (2):
      ACPICA: iASL table disassembler: Added disassembly support for
the NHLT ACPI table
      ACPICA: Update version to 20210930

Christoph Hellwig (1):
      ACPI: APEI: mark apei_hest_parse() static

Colin Ian King (1):
      Documentation: ACPI: Fix spelling mistake "Millenium" -> "Millennium"

Deepak Sharma (1):
      x86: ACPI: cstate: Optimize C3 entry on AMD CPUs

Hui Wang (2):
      ACPI: resources: Add DMI-based legacy IRQ override quirk
      ACPI: resources: Add one more Medion model in IRQ override quirk

Krzysztof Kozlowski (1):
      ACPI: PNP: remove duplicated BRI0A49 and BDP3336 entries

Mario Limonciello (3):
      ACPICA: Add support for MADT online enabled bit
      x86/ACPI: Don't add CPUs that are not online capable
      ACPICA: Add support for Windows 2020 _OSI string

Masanari Iida (1):
      ACPI: Kconfig: Fix a typo in Kconfig

Qing Wang (1):
      ACPI: replace snprintf() in "show" functions with sysfs_emit()

Rafael J. Wysocki (16):
      PCI: ACPI: Drop acpi_pci_bus
      ACPI: glue: Drop cleanup callback from struct acpi_bus_type
      ACPI: glue: Look for ACPI bus type only if ACPI companion is not known
      ACPI: Update information in MAINTAINERS
      ACPICA: Avoid evaluating methods too early during system resume
      ACPI: scan: Release PM resources blocked by unused objects
      ACPI: LPSS: Use ACPI_COMPANION() directly
      ACPI: PM: Check states of power resources during initialization
      ACPI: PM: Turn off unused wakeup power resources
      ACPI: PM: Fix sharing of wakeup power resources
      ACPI: PM: Turn off wakeup power resources on _DSW/_PSW errors
      ACPI: PM: sleep: Do not set suspend_ops unnecessarily
      nouveau: ACPI: Use the ACPI_COMPANION() macro directly
      gpio-amdpt: ACPI: Use the ACPI_COMPANION() macro directly
      perf: qcom_l2_pmu: ACPI: Use ACPI_COMPANION() directly
      ACPI: glue: Use acpi_device_adr() in acpi_find_child_device()

Richard Gong (1):
      ACPI: processor idle: Allow playing dead in C3 state

Shuai Xue (1):
      ACPI: APEI: EINJ: Relax platform response timeout to 1 second

Stefan Schaeckeler (1):
      ACPI: AC: Quirk GK45 to skip reading _PSR

---------------

 Documentation/firmware-guide/acpi/osi.rst |   2 +-
 MAINTAINERS                               |  20 +--
 arch/x86/kernel/acpi/boot.c               |   9 ++
 arch/x86/kernel/acpi/cstate.c             |  15 ++
 drivers/acpi/Kconfig                      |   2 +-
 drivers/acpi/ac.c                         |  19 +++
 drivers/acpi/acpi_lpss.c                  |  13 +-
 drivers/acpi/acpi_pnp.c                   |   2 -
 drivers/acpi/acpica/acglobal.h            |   2 +
 drivers/acpi/acpica/hwesleep.c            |   8 +-
 drivers/acpi/acpica/hwsleep.c             |  11 +-
 drivers/acpi/acpica/hwxfsleep.c           |   7 +
 drivers/acpi/acpica/utosi.c               |   1 +
 drivers/acpi/apei/einj.c                  |  15 +-
 drivers/acpi/apei/hest.c                  |   5 +-
 drivers/acpi/battery.c                    |   2 +-
 drivers/acpi/dock.c                       |   8 +-
 drivers/acpi/glue.c                       |  66 ++++++--
 drivers/acpi/internal.h                   |   1 +
 drivers/acpi/power.c                      |  97 +++++-------
 drivers/acpi/prmt.c                       |  35 +++--
 drivers/acpi/processor_idle.c             |   3 +-
 drivers/acpi/resource.c                   |  56 ++++++-
 drivers/acpi/scan.c                       |   6 +
 drivers/acpi/sleep.c                      |  10 +-
 drivers/gpio/gpio-amdpt.c                 |   4 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c    |   9 +-
 drivers/pci/pci-acpi.c                    |  31 +---
 drivers/perf/qcom_l2_pmu.c                |   7 +-
 include/acpi/acpi_bus.h                   |   1 -
 include/acpi/acpixf.h                     |   2 +-
 include/acpi/actbl2.h                     | 251 +++++++++++++++++++++++++++++-
 include/acpi/actbl3.h                     |   9 +-
 include/acpi/actypes.h                    |   1 +
 include/acpi/apei.h                       |   3 -
 include/linux/pci-acpi.h                  |   8 +
 36 files changed, 547 insertions(+), 194 deletions(-)
