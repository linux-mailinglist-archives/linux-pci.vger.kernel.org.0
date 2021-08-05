Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDF63E1978
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 18:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhHEQ36 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHEQ3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 12:29:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D6DC061765;
        Thu,  5 Aug 2021 09:29:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso7057748pjb.5;
        Thu, 05 Aug 2021 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsYpGvyHZuOAJzeF+YGA1lgrH6KHim3VPc69mv3Sy6k=;
        b=Ae8AHqFNWti/dfbrUwRJX9O6HjkRwWemoXe3vsBKlen8ZuErEf9Z1oaXxuKWfo9MOO
         biQ/CRLxFUD1BUyEfN8giwA4Twx28L8761JMm9ba8LlCmUD0S7TtJPQbBDIzcMJ0C7/s
         GpRCsm2nWFIH8NevRBHk3qlVVSmV3I35dFJnH2uPlf6iT3Y66NCiSZ9TAey4tdobPlXd
         mukkCiq2KP67QbkICDeDA0Sj7ScxygIuQPWrco+N/cKona56tTnPAWu/OUAH8foRRmsk
         zfx1RLSyICufrMh7DBMFpfkb3SDcscVZAZxvJ3ZwC4GqhAifoUlHm1JvxFhG0GsltsH5
         aKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsYpGvyHZuOAJzeF+YGA1lgrH6KHim3VPc69mv3Sy6k=;
        b=OGvrPAkAVCKn+FpgYE84m5M/aZn812uMz/lLAxpKPaezz9zmVQbvkB3Z5RvkwlH+h1
         W/NH5Jj0yebn6d/BRnyc5zLsdYWn12QXcIXP1daS3Xvw8YI3BPH8s47j7HDCML+pJdUP
         y50al2lCAi/rHddwLUJ8TsUx+4DeqbWNVmI5L1jjP1r4TvBvO8Kmp1DfnhRYNmExgSW2
         ibbJOURU3tg1TrbsATb5nmXj1b704VEcpq9sqDP2OgTRH9x9cJymMS9AgGKn2NayqqyJ
         C9PTiLUc4ceuZaxkb7xNXdLmv5ED1ejFMoo7C4pmPTHM1uU6KsptkSnhRLEgYUlK+yDE
         jrWA==
X-Gm-Message-State: AOAM5324bU00kKO55TUzTMeIb9sOvMotqqpPW1eBZnozui/f4aBcUeUQ
        HEAgVpb2dF5WvhfsAD853VI=
X-Google-Smtp-Source: ABdhPJyciQ6R/i/idfHq+fumh1UWhMRqYa1whmv0xe9IGfxUKlMLqISnuFXRCbaCr7KfYGe+CB1kBg==
X-Received: by 2002:a17:90b:38c3:: with SMTP id nn3mr5687810pjb.193.1628180978077;
        Thu, 05 Aug 2021 09:29:38 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id nr6sm62551pjb.39.2021.08.05.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 09:29:37 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v15 0/9] PCI: Expose and manage PCI device reset
Date:   Thu,  5 Aug 2021 21:59:08 +0530
Message-Id: <20210805162917.3989-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI and PCIe devices may support a number of possible reset mechanisms
for example Function Level Reset (FLR) provided via Advanced Feature or
PCIe capabilities, Power Management reset, bus reset, or device specific reset.
Currently the PCI subsystem creates a policy prioritizing these reset methods
which provides neither visibility nor control to userspace.

Expose the reset methods available per device to userspace, via sysfs
and allow an administrative user or device owner to have ability to
manage per device reset method priorities or exclusions.
This feature aims to allow greater control of a device for use cases
as device assignment, where specific device or platform issues may
interact poorly with a given reset method, and for which device specific
quirks have not been developed.

Changes in v15:
	- Fix use of uninitialized variable in patch 3/9

Changes in v14:
	- Remove duplicate entries from pdev->reset_methods as per
	  Shanker's suggestion

Changes in v13:
	- Added "PCI: Cache PCIe FLR capability"
	- Removed memcpy in pci_init_reset_methods() and reset_method_show
	- Moved reset_method sysfs attribute code from pci-sysfs.c to
	  pci.c

Changes in v12:
        - Corrected subject in 0/8 (cover letter).

Changes in v11:
        - Alex's suggestion fallback back to other resets if the ACPI RST
          fails. Fix "s/-EINVAL/-ENOTTY/" in 7/8 patch.

Changes in v10:
        - Fix build error on ppc as reported by build bot

Changes in v9:
        - Renamed has_flr bitfield to has_pcie_flr and restored
          use of PCI_DEV_FLAGS_NO_FLR_RESET in quirk_no_flr()
        - Cleaned up sysfs code

Changes in v8:
        - Added has_flr bitfield to struct pci_dev to cache flr
          capability
        - Updated encoding scheme used in reset_methods array as per
          Bjorn's suggestion
        - Updated Shanker's ACPI patches

Changes in v7:
        - Fix the pci_dev_acpi_reset() prototype mismatch
          in case of CONFIG_ACPI=n

Changes in v6:
        - Address Bjorn's and Krzysztof's review comments
        - Add Shanker's updated patches along with new
          "PCI: Setup ACPI_COMPANION early" patch

Changes in v5:
        - Rebase the series over pci/reset branch of
          Bjorn's pci tree to avoid merge conflicts
          caused by recent changes in existing reset
          sysfs attribute

Changes in v4:
        - Change the order or strlen and strim in reset_method_store
          function to avoid extra strlen call.
        - Use consistent terminology in new
          pci_reset_mode enum and rename the probe argument
          of reset functions.

Changes in v3:
        - Dropped "PCI: merge slot and bus reset implementations" which was
          already accepted separately
        - Grammar fixes
        - Added Shanker's patches which were rebased on v2 of this series
        - Added "PCI: Change the type of probe argument in reset functions"
          and additional user input sanitization code in reset_method_store
          function per review feedback from Krzysztof

Changes in v2:
        - Use byte array instead of bitmap to keep track of
          ordering of reset methods
        - Fix incorrect use of reset_fn field in octeon driver
        - Allow writing comma separated list of names of supported reset
          methods to reset_method sysfs attribute
        - Writing empty string instead of "none" to reset_method attribute
          disables ability of reset the device

Amey Narkhede (6):
  PCI: Cache PCIe FLR capability
  PCI: Add pcie_reset_flr to follow calling convention of other reset
    methods
  PCI: Add new array for keeping track of ordering of reset methods
  PCI: Remove reset_fn field from pci_dev
  PCI: Allow userspace to query and set device reset mechanism
  PCI: Change the type of probe argument in reset functions

Shanker Donthineni (3):
  PCI: Define a function to set ACPI_COMPANION in pci_dev
  PCI: Setup ACPI fwnode early and at the same time with OF
  PCI: Add support for ACPI _RST reset method

 Documentation/ABI/testing/sysfs-bus-pci       |  19 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
 drivers/pci/hotplug/pciehp.h                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |   2 +-
 drivers/pci/hotplug/pnv_php.c                 |   4 +-
 drivers/pci/pci-acpi.c                        |  35 ++-
 drivers/pci/pci-sysfs.c                       |   3 +-
 drivers/pci/pci.c                             | 287 +++++++++++++-----
 drivers/pci/pci.h                             |  24 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |  16 +-
 drivers/pci/quirks.c                          |  25 +-
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  14 +-
 include/linux/pci_hotplug.h                   |   2 +-
 16 files changed, 332 insertions(+), 120 deletions(-)

--
2.32.0
