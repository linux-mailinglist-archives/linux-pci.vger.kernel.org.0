Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996C63EF146
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhHQSFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhHQSFn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:05:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2D5C061764;
        Tue, 17 Aug 2021 11:05:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so6604013pjb.3;
        Tue, 17 Aug 2021 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXK4GdXjN9PZQabri5B2jGcdbtYNS6tFhMXPaYlGCNA=;
        b=kM9g7eoNCCuqo1ZQ9VnBYgOAd/oMdC5dOQEdL65W+du399mRfQEfYVxhSNrndBLA30
         1XjhT8arlV1b7iiK2ufKiFU+Yd/mHqdEXoHDYmcxLFas0huiSj/Awnw2ZfxIWocUhYA7
         1hTNLD3ZFkDFTXxYcNPg3DZ1mRXROPeLAwU77plzdo6eVU+nMCuAChhIVq/cPShsHNHf
         DQzDeANSqE5yP7eIwl1l/N9/Mu8pVOtqKFWtjIfoFWCpg05xZzbndyljG04DSX3tKt7h
         UfcgUAnxu805ErdipJZGephEOk1TsmIfXggDTYFUNEmMcKpWeHsjDqHeFTRq/2cfZTss
         G4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXK4GdXjN9PZQabri5B2jGcdbtYNS6tFhMXPaYlGCNA=;
        b=T4jgqjGtw5xpyDrz69ZDKIIhvQ7P/s5/YeZpg/aEx1uklGcZ0mpY9tTHoAZjAvAq8j
         l9xFTb6cQK2nwICDw6IFaYY5DDXO4TV17NkFmbO4DDieOOeArNYu3Nw67TAcebwMeo76
         4xBsjwpHu/cPbJceMaN1tg7Df3vNN1fk2Cz0MNGoU0gI7OfoQtZNEXEEIkPv5m0IIjJr
         e8pQZYBiZWU6hjJMjH78Sq8mZ3fhZbM+NjvbcvepeCFL3E4el8kYQF5hvr/bfgUcdY9u
         CT0ROdNh3VFtUY4232J9e4mTCRKFe8JBDz4UkS4ff4vLVyJ6F01fIZtVIkHaHvLtSZwZ
         ZBZg==
X-Gm-Message-State: AOAM533pMKTsByAMvpr3LyUFFq7/qwKTWdphcTjb8KovjYveQbm1RN7L
        5hksj2vdztuuz8qMYZmnJ5Y=
X-Google-Smtp-Source: ABdhPJyBthv+pufF+z6S5AIrudCDObMJuDKaClikha93zezDqzneiX+zuGBQ0jOutW5u/crnIqoO8A==
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr4812464pjg.118.1629223509714;
        Tue, 17 Aug 2021 11:05:09 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id 65sm4065632pgi.12.2021.08.17.11.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:05:09 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v16 0/9] PCI: Expose and manage PCI device reset
Date:   Tue, 17 Aug 2021 23:34:51 +0530
Message-Id: <20210817180500.1253-1-ameynarkhede03@gmail.com>
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

Changes in v16:
	- Refactor acpi_pci_bridge_d3() in patch 7/9
	- Fixed consistency issues in patch 9/9

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
 drivers/pci/pci-acpi.c                        |  83 +++--
 drivers/pci/pci-sysfs.c                       |   3 +-
 drivers/pci/pci.c                             | 287 +++++++++++++-----
 drivers/pci/pci.h                             |  24 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |  16 +-
 drivers/pci/quirks.c                          |  25 +-
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  14 +-
 include/linux/pci_hotplug.h                   |   2 +-
 16 files changed, 351 insertions(+), 149 deletions(-)

--
2.32.0
