Return-Path: <linux-pci+bounces-32882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4EB10A60
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A761C7B4A45
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ECE2D23BD;
	Thu, 24 Jul 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXHP+Iia"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410A2D2394;
	Thu, 24 Jul 2025 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360699; cv=none; b=QcejCKy9+Y2u27H8fhVsGeSo73RDRULVFnFILfnRLqIcT+jM5uOsKh/b4jIDBToIZqgpcriEwdiJOSJtItLAVuMiz95d3k6zown3TZChVdjrpDCpgJUBtoJ0AyR3Ld0ciK9jc02XhtF8v/E3/51ZDxsgoUdLxNnVqdZW6OQL/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360699; c=relaxed/simple;
	bh=/Fd2dbY46+nBw/SuxVNMWZV5DxNiY31qjK4IwBKCoK8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cVyyaotcsCzrT21tTBmB6tlLDG6qji5UA03PvgGJBLLbuWcyQmSkf77CZoXaq24miLBmznNKhuD11pH598mNii6dtMb0QEYUQ7+mI7WIw/BuI7Dl1Id0hZubCcRH2nkki7+Qz2zFOhH5Y44zDiM1RUBFfYnU5DArNIA3ZskHKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXHP+Iia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A25C4CEEF;
	Thu, 24 Jul 2025 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753360697;
	bh=/Fd2dbY46+nBw/SuxVNMWZV5DxNiY31qjK4IwBKCoK8=;
	h=From:Date:Subject:To:Cc:From;
	b=GXHP+Iia+nvex6ZfvQnOJUKGaVC0jt2egJEDcpG4gcts8VStSdvav2MlYwBfJyfkt
	 e34gBQXC8h5VdodRM7RWrvTYdbtaT6NJPCcttxaW25SFNGa9m+rHDby00KQ7FoU5h1
	 uRYkj1g0m7b1QOvPyIiW1zgwoTiPaRHZYJ1ULO0Bqzue6M2qGyXnv9WlOQixxPYlE0
	 tNo9Qhn0BExOSv3+1zhYcgA9hUc8SBBHBIguXxgnpWQ00kBc9+jEuhF5ljL8F29bbn
	 ALvrgD48nHLPb7crkPIZ8LWKuspf9KWfZIrcHYMN1btwGG9VpMWZTuSMQsRW4UtBKf
	 OFmu0qmifr0Ng==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-613a6e39f52so483977eaf.3;
        Thu, 24 Jul 2025 05:38:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0eJyDOgmk3yGTAjll9f60b97xfUpY3F6B9sjTkzsAJiAByH+kfFqumRcSq90zBDuuuC4CBkYhDmv27cs=@vger.kernel.org, AJvYcCX7/W4MhbFEsg5EXlUO1gceYft318S+xFCE67oUj+qtlAerQvDfr5L1LPV9pTmo+D3AbvPv2Rw0c48=@vger.kernel.org, AJvYcCXRe9W/asK+JMvVh4TEI+k2kpCJ+fK2w0+DXsGmcpdongRNXcTDBepU1SeCFJMmzlclA80BP0atBoNT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5l5Ok5iHzU6ObePAajXwljfphu2fbijKNnyEYEcNMLwDj+oFj
	Ep9IiMy3HRVUrz8d15iVs9/VbZ/DU0aG758Y4SK/5OSw+3SW31/xQhjowTDI1I62NiSRH6PV5sf
	o4tqMgEivHtjJtxvWVgj4To6cHZY+VfQ=
X-Google-Smtp-Source: AGHT+IEkAmZy5QE7Vk6V7gx+c/efF4IyXjJE6AByaRl+/ROgN+l7w1X3AWDgTR/uKU2aTwOkv1mh3/7/yi998ls2kTo=
X-Received: by 2002:a05:6820:2004:b0:615:b293:1f17 with SMTP id
 006d021491bc7-6187d8f800emr4676536eaf.8.1753360697059; Thu, 24 Jul 2025
 05:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Jul 2025 14:38:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jTEdWhm-1aYbLtyqo99dJw4kY0PaYUy=_zh+1M+jo3Vw@mail.gmail.com>
X-Gm-Features: Ac12FXyOWhpG1bIKrnrrOQtS5GKQsc2xVEuW-EisH29LnmbfBKphNrK8Ka_NJOM
Message-ID: <CAJZ5v0jTEdWhm-1aYbLtyqo99dJw4kY0PaYUy=_zh+1M+jo3Vw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

I'm sending this early because I will be mostly offline next week
and I'm not planning to add anything to it.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.17-rc1

with top-most commit ea34e67ae7a6318dc775a8d98cf00c3e45bfb7d2

 Merge branch 'acpi-misc'

on top of commit 89be9a83ccf1f88522317ce02f854f30d6115c41

 Linux 6.16-rc7

to receive ACPI updates for 6.17-rc1.

These update APEI (new EINJv2 error injection, assorted fixes), fix the
ACPI processor driver, update the legacy ACPI /proc interface (multiple
assorted fixes of minor issues) and several assorted ACPI drivers (minor
fixes and cleanups):

 - Printing the address in acpi_ex_trace_point() is either incorrect
   during early kernel boot or not really useful later when pathnames
   resolve properly, so stop doing it (Mario Limonciello)

 - Address several minor issues in the legacy ACPI proc interface (Andy
   Shevchenko)

 - Fix acpi_object union initialization in the ACPI processor driver to
   avoid using memory that contains leftover data (Sebastian Ott)

 - Make the ACPI processor perflib driver take the initial _PPC limit
   into account as appropriate (Jiayi Li)

 - Fix message formatting in the ACPI processor throttling driver and
   in the ACPI PCI link driver (Colin Ian King)

 - Clean up general ACPI PM domain handling (Rafael Wysocki)

 - Fix iomem-related sparse warnings in the APEI EINJ driver (Zaid
   Alali, Tony Luck)

 - Add EINJv2 error injection support to the APEI EINJ driver (Zaid
   Alali)

 - Fix memory corruption in error_type_set() in the APEI EINJ driver (Dan
   Carpenter)

 - Fix less than zero comparison on a size_t variable in the APEI EINJ
   driver (Colin Ian King)

 - Fix check and iounmap of an uninitialized pointer in the APEI EINJ
   driver (Colin Ian King)

 - Add TAINT_MACHINE_CHECK to the GHES panic path in APEI to improve
   diagnostics and post-mortem analysis (Breno Leitao)

 - Update APEI reviewer records and other ACPI-related information in
   MAINTAINERS as well as the contact information in the ACPI ABI
   documentation (Rafael Wysocki)

 - Fix the handling of synchronous uncorrected memory errors in APEI
   (Shuai Xue)

 - Remove an AudioDSP-related ID from the ACPI LPSS driver (Andy
   Shevchenko)

 - Replace sprintf()/scnprintf() with sysfs_emit() in the ACPI fan
   driver and update a debug message in fan_get_state_acpi4() (Eslam
   Khafagy, Abdelrahman Fekry, Sumeet Pawnikar)

 - Add Intel Wildcat Lake support to the ACPI DPTF driver (Srinivas
   Pandruvada)

 - Add more debug information regarding failing firmware updates to the
   ACPI pfr_update driver (Chen Yu)

 - Reduce the verbosity of the ACPI PRM (platform runtime mechanism)
   driver to avoid user confusion (Zhu Qiyu)

 - Replace sprintf() with sysfs_emit() in the ACPI TAD (time and alarm
   device) driver (Sukrut Heroorkar)

 - Enable CONFIG_ACPI_DEBUG by default to make it easier to get ACPI
   debug messages from OEM platforms (Mario Limonciello)

 - Fix parent device references in ASL examples in the ACPI
   documentation and fix spelling and style in the gpio-properties
   documentation in firmware-guide (Andy Shevchenko)

 - Fix typos in ACPI documentation and comments (Bjorn Helgaas)

Thanks!


---------------

Abdelrahman Fekry (1):
      ACPI: fan: Replace sprintf()/scnprintf() with sysfs_emit() in
show() functions

Andy Shevchenko (8):
      ACPI: wakeup: Drop unneeded casting for sleep_state
      ACPI: proc: Use correct format specifier and drop casting
      ACPI: proc: Remove unused header
      ACPI: proc: Use str_enabled_disabled() helper
      ACPI: proc: Prefer to use octal permission
      Documentation: firmware-guide: gpio-properties: Spelling and style fixes
      ACPI: LPSS: Remove AudioDSP related ID
      Documentation: ACPI: Fix parent device references

Breno Leitao (1):
      ACPI: APEI: GHES: add TAINT_MACHINE_CHECK on GHES panic path

Chen Yu (1):
      ACPI: pfr_update: Add more debug information when firmware update failed

Colin Ian King (4):
      ACPI: APEI: EINJ: Fix less than zero comparison on a size_t variable
      ACPI: APEI: EINJ: Fix check and iounmap of uninitialized pointer p
      ACPI: processor: throttling: Remove space before newline
      ACPI/PCI: Remove space before newline

Dan Carpenter (1):
      ACPI: APEI: EINJ: prevent memory corruption in error_type_set()

Eslam Khafagy (1):
      ACPI: fan: Replace sprintf() with sysfs_emit()

Jiayi Li (1):
      ACPI: processor: perflib: Fix initial _PPC limit application

Mario Limonciello (2):
      ACPI: Enable CONFIG_ACPI_DEBUG by default
      ACPICA: Decrease `AcpiExTracePoint` verbosity

Rafael J. Wysocki (3):
      ACPI: PM: Set .detach in acpi_general_pm_domain definition
      ACPI: APEI: MAINTAINERS: Update reviewers for APEI
      ACPI/PNP: Use my kernel.org address in MAINTAINERS and ABI docs

Sebastian Ott (1):
      ACPI: processor: fix acpi_object initialization

Shuai Xue (2):
      ACPI: APEI: send SIGBUS to current task if synchronous memory
error not recovered
      ACPI: APEI: handle synchronous exceptions in task work

Srinivas Pandruvada (1):
      ACPI: DPTF: Support for Wildcat Lake

Sukrut Heroorkar (1):
      ACPI: TAD: Replace sprintf() with sysfs_emit()

Sumeet Pawnikar (1):
      ACPI: fan: Update debug message in fan_get_state_acpi4()

Tony Luck (2):
      ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome
      ACPI: APEI: EINJ: Fix trigger actions

Zaid Alali (6):
      ACPI: APEI: EINJ: Fix kernel test sparse warnings
      ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
      ACPI: APEI: EINJ: Add einjv2 extension struct
      ACPI: APEI: EINJ: Discover EINJv2 parameters
      ACPI: APEI: EINJ: Enable EINJv2 error injections
      ACPI: APEI: EINJ: Update the documentation for EINJv2 support

Zhu Qiyu (1):
      ACPI: PRM: Reduce unnecessary printing to avoid user confusion

---------------

 Documentation/ABI/testing/sysfs-bus-acpi           |  18 +-
 Documentation/ABI/testing/sysfs-firmware-acpi      |   6 +-
 Documentation/firmware-guide/acpi/apei/einj.rst    |  33 ++
 .../firmware-guide/acpi/gpio-properties.rst        |  34 +-
 Documentation/firmware-guide/acpi/i2c-muxes.rst    |   8 +-
 MAINTAINERS                                        |   9 +-
 drivers/acpi/Kconfig                               |   1 +
 drivers/acpi/acpi_processor.c                      |   2 +-
 drivers/acpi/acpi_tad.c                            |   4 +-
 drivers/acpi/acpica/extrace.c                      |   4 +-
 drivers/acpi/apei/apei-internal.h                  |   2 +-
 drivers/acpi/apei/einj-core.c                      | 386 +++++++++++++++++----
 drivers/acpi/apei/einj-cxl.c                       |   2 +-
 drivers/acpi/apei/ghes.c                           |  90 +++--
 drivers/acpi/bus.c                                 |   2 +-
 drivers/acpi/device_pm.c                           |   4 +-
 drivers/acpi/dptf/dptf_power.c                     |   2 +
 drivers/acpi/dptf/int340x_thermal.c                |   7 +
 drivers/acpi/fan.h                                 |   1 +
 drivers/acpi/fan_attr.c                            |   8 +-
 drivers/acpi/fan_core.c                            |   2 +-
 drivers/acpi/pci_link.c                            |   2 +-
 drivers/acpi/pfr_update.c                          |  63 +++-
 drivers/acpi/prmt.c                                |  26 +-
 drivers/acpi/proc.c                                |  17 +-
 drivers/acpi/processor_perflib.c                   |  10 +-
 drivers/acpi/processor_throttling.c                |   2 +-
 drivers/acpi/wakeup.c                              |   4 +-
 drivers/acpi/x86/lpss.c                            |   3 -
 .../intel/int340x_thermal/int3400_thermal.c        |   1 +
 .../intel/int340x_thermal/int3403_thermal.c        |   1 +
 include/acpi/ghes.h                                |   3 -
 include/linux/mm.h                                 |   1 -
 mm/memory-failure.c                                |  13 -
 34 files changed, 567 insertions(+), 204 deletions(-)

