Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7C491012
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 19:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbiAQSKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 13:10:07 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:34318 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbiAQSKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 13:10:05 -0500
Received: by mail-qt1-f171.google.com with SMTP id y10so19989482qtw.1;
        Mon, 17 Jan 2022 10:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+gX+6EZFnPH0WFg52hMFqitJk0/W3pruPDYiBt6+qX4=;
        b=bsk6noTyVlrggN4cU9seAOdFV+JjHW38gJj7FtDPjsroZPr8PcdTA4+HO0dHpDqpC6
         L0HBm1fjZxDXnWKraS8iYxjCK83DpM6OFgQPvww6YaaH73G+sWOQgf5Li+f1ZlbFMtHS
         boZgkcdk/14JGhJosRBga6Y5OJLUEhiUNnmWbLUkcCE8EntZG004dgliiFf05ynglOE1
         hs5P/r9GqIp+1XG2fankyIO/VVI1Dc3XX6882838BtdNEbNX97uAbWgtFgaJdW86k0ZI
         pR3yPpnUIq2uqFHbmc3fjCfZ49E4RBsUDtii9/1W90azbaUEWLQKZ98d9r0qY+56Vul6
         Uttg==
X-Gm-Message-State: AOAM530OGXb6ns4emksrLfyYlL8Y7EBcyEsMVCS23pJ3q4sMa2slUyWE
        L8DrVLjSWxhwIyCl8iivu4zVFAx9xdP9u/D675g=
X-Google-Smtp-Source: ABdhPJxEHcXaXeIMEtK9tfhgAY7BqRWKoWmTshdQCLDeHFwbBDrr2ytiScou+KuQywMa1NOaEgxzE+xNulyCeVFuQHQ=
X-Received: by 2002:ac8:578d:: with SMTP id v13mr3961180qta.472.1642443004229;
 Mon, 17 Jan 2022 10:10:04 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jan 2022 19:09:53 +0100
Message-ID: <CAJZ5v0iD_Ar15npwR8Cp2oEKF3DgPVo2KaKqfYax5RmTBkbZmg@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.17-rc1-2

with top-most commit e3daa2607b1f4bb1d09a5a8ad89ad9f7327a2e63

 Merge branch 'acpi-pfrut'

on top of commit bca21755b9fc00dbe371994b53389eb5d70b8e72

 Merge tag 'acpi-5.17-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.17-rc1.

The most significant item here is the Platform Firmware Runtime
Update and Telemetry (PFRUT) support designed to allow certain
pieces of the platform firmware to be updated on the fly, among
other things.

Also important is the e820 handling change on x86 that should work
around PCI BAR allocation issues on some systems shipping since
2019.

The rest is just a handful of assorted fixes and cleanups on top
of the ACPI material merged previously.

Specifics:

 - Add support for the the Platform Firmware Runtime Update and
   Telemetry (PFRUT) interface based on ACPI to allow certain pieces
   of the platform firmware to be updated without restarting the
   system and to provide a mechanism for collecting platform firmware
   telemetry data (Chen Yu, Dan Carpenter, Yang Yingliang).

 - Ignore E820 reservations covering PCI host bridge windows on
   sufficiently recent x86 systems to avoid issues with allocating
   PCI BARs on systems where the E820 reservations cover the entire
   PCI host bridge memory window returned by the _CRS object in the
   system's ACPI tables (Hans de Goede).

 - Fix and clean up acpi_scan_init() (Rafael Wysocki).

 - Add more sanity checking to ACPI SPCR tables parsing (Mark
   Langsdorf).

 - Fix up ACPI APD (AMD Soc) driver initialization (Jiasheng Jiang).

 - Drop unnecessary "static" from the ACPI PCC address space handling
   driver added recently (kernel test robot).

Thanks!


---------------

Chen Yu (4):
      efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and
corresponding structures
      ACPI: Introduce Platform Firmware Runtime Update device driver
      ACPI: Introduce Platform Firmware Runtime Telemetry driver
      ACPI: tools: Introduce utility for firmware updates/telemetry

Dan Carpenter (1):
      ACPI: pfr_telemetry: Fix info leak in pfrt_log_ioctl()

Hans de Goede (1):
      x86/PCI: Ignore E820 reservations for bridge windows on newer systems

Jiasheng Jiang (1):
      ACPI: APD: Check for NULL pointer after calling devm_ioremap()

Mark Langsdorf (1):
      ACPI: SPCR: check if table->serial_port.access_width is too wide

Rafael J. Wysocki (3):
      ACPI: scan: Change acpi_scan_init() return value type to void
      ACPI: scan: Simplify initialization of power and sleep buttons
      ACPI: scan: Rename label in acpi_scan_init()

Yang Yingliang (1):
      ACPI: pfr_update: Fix return value check in pfru_write()

kernel test robot (1):
      ACPI: PCC: pcc_ctx can be static

---------------

 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 arch/x86/kernel/resource.c                         |  23 +-
 drivers/acpi/Kconfig                               |  22 +
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/acpi_apd.c                            |   2 +
 drivers/acpi/acpi_pcc.c                            |   2 +-
 drivers/acpi/internal.h                            |   2 +-
 drivers/acpi/pfr_telemetry.c                       | 435 ++++++++++++++++
 drivers/acpi/pfr_update.c                          | 575 +++++++++++++++++++++
 drivers/acpi/scan.c                                |  76 +--
 drivers/acpi/spcr.c                                |   9 +-
 include/linux/efi.h                                |  46 ++
 include/uapi/linux/pfrut.h                         | 262 ++++++++++
 tools/power/acpi/.gitignore                        |   1 +
 tools/power/acpi/Makefile                          |  16 +-
 tools/power/acpi/Makefile.rules                    |   2 +-
 tools/power/acpi/man/pfrut.8                       | 137 +++++
 tools/power/acpi/tools/pfrut/Makefile              |  23 +
 tools/power/acpi/tools/pfrut/pfrut.c               | 424 +++++++++++++++
 19 files changed, 1997 insertions(+), 62 deletions(-)
