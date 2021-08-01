Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86D83DCC01
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhHAOZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhHAOZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Aug 2021 10:25:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14022C06175F;
        Sun,  1 Aug 2021 07:25:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so2065751pjs.0;
        Sun, 01 Aug 2021 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eoz9FemMT9AVrqSFq+i56u1UYtKq1LSRDdTIiQVdGj8=;
        b=nBbmSfVUZ97Nei4Zvsb+kFpjB57sTD0Lo7RZgCK2L8YylbJv5s8ZXnwGNJc9CJ5ZRg
         8Okot3/EqWz7q1mLuLxWxPsZ2Yaf9xWkgm8cSyQRGyXgtD/y+Tojax4ge1CYZnwJW97K
         dWF+kwC/E76r3YEg8e/HLXCslYNSDU3aSMK1ipDwsx42dw5tRAPZjgry1gT+sxs0fJbd
         nPCpH6v/WdywOcoEJPGkEuViW5Yn74E9/AbkmhrFi9J8gUSVeigZTp2ZGQxY03sjIhAS
         p9AMEcRPKthHWHMAUkzf1dSO+13RJ9xVMfgYH6v0owI+yAsw45OzdykwqtVLGZG7gths
         liaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eoz9FemMT9AVrqSFq+i56u1UYtKq1LSRDdTIiQVdGj8=;
        b=djhU7qQlnPxEMQmRQWWh2iPea6xplG7+0NqxiRdcSgEzad4Tx4HzHsWj4ust7y25jR
         ADiKmr9TokLKc/XI8ktRgT5/W1EDbI+0nmy47BfdHFLGttSawozwlFsHtxW8+9+DKl4H
         NM0INAQl8axxTa5/dzpNklMWW1UmvOZ0p0Y7Ra28wi5hsJV0U6kHV4vO8R6QQhASH8E4
         oAEdadPm8bMXiNnjpTxWz2AYXlkhS5DtcoFPydUixH9or/glV6ZhQ/DuopepaqtAxsYs
         dG5a5lInjPywCG6JTFJR0Wv/biqex6Lcn1Hb8ETf9f6Nb7+fv15kLSkomP36a7xGKjpO
         GmXA==
X-Gm-Message-State: AOAM532baaVktOmZkPk4NlejSs9roRjYFv/e99/bgUVuQQ/OCqxmAUvA
        vlKM1ZbsZWph1NKNkWRagqs=
X-Google-Smtp-Source: ABdhPJwpkb0mTXDNCZvJ3deSV4RAyZOqbTN0xifQTlBricILM/mhOgqqzZuuxKZLaTYc6tI+6rcqzw==
X-Received: by 2002:a17:90a:e2c8:: with SMTP id fr8mr12549049pjb.131.1627827928595;
        Sun, 01 Aug 2021 07:25:28 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.186])
        by smtp.googlemail.com with ESMTPSA id g11sm7740897pju.13.2021.08.01.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 07:25:28 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v13 0/9] PCI: Expose and manage PCI device reset
Date:   Sun,  1 Aug 2021 19:55:09 +0530
Message-Id: <20210801142518.1224-1-ameynarkhede03@gmail.com>
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
 drivers/pci/hotplug/pciehp_hpc.c              |   4 +-
 drivers/pci/hotplug/pnv_php.c                 |   4 +-
 drivers/pci/pci-acpi.c                        |  35 ++-
 drivers/pci/pci-sysfs.c                       |   3 +-
 drivers/pci/pci.c                             | 290 +++++++++++++-----
 drivers/pci/pci.h                             |  24 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |  16 +-
 drivers/pci/quirks.c                          |  39 ++-
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  14 +-
 include/linux/pci_hotplug.h                   |   2 +-
 16 files changed, 336 insertions(+), 135 deletions(-)

--
2.32.0
