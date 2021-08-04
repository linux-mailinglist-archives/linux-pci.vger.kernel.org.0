Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC73E097C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 22:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbhHDUmY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 16:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhHDUmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 16:42:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D82C0613D5;
        Wed,  4 Aug 2021 13:42:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so10593531pjr.1;
        Wed, 04 Aug 2021 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SiD/L0lu+hcEKWOYRA63lkvA8XbHt7tjVZPN9FSwbpw=;
        b=tDHQF1py940hXrJt98b6qcDaepKqM+Dn3ii1WC+esPsw9bLyNx1md66Dfk9nI9XYm8
         wsP2IwT9xmIVAeLIbs+oA8vrwYTPk2hpZ7CKt/qTfsKl+w6uDdQzzyDEh/d9Heq3zuTP
         0TMT6o4kZldYBI1ryS/2Xa0fro2M8I4LYdB7t8cJH8cEDm6Hijy5EzCIz80XSu+Dm8N5
         rIeljMaSWSUN6n0nt1N1HbfewQ26jvU2xJpsp+f5a5/hB88Vb87do+IrmgB3LegYK+TE
         JcAgGTztJus4DC6Itqg7zqpyV3dmLW59gDsEisWq2lZavSPvNTu88V+43ZoMufnwgZQ0
         CNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SiD/L0lu+hcEKWOYRA63lkvA8XbHt7tjVZPN9FSwbpw=;
        b=Gv7H47cy2njJI0xM0bn49J0XHp1WwjMayg25KlqK7iZd8eFQQkBHz8YIHt5s0lsxmD
         cA5Ce35ByU+tM3xXJuC2bDR/UsM0qPi2iL7aoWdYBudWAjasRuaUsJA7jWrQne3MCLKr
         NIh3QNhs5/Qnkkm4eyKSTKje+Zaw7r4SDiKMcTyRu+TunPL4hKQ491DRSwK0MeBCOy4i
         xdx+L9QFiEiCJ+VXDbtMMHoYFc0iKCAgOKe7XE2dWBPrxOat/ssDca1XEg68aL7uy/cs
         iM/iyxooupQqXzMqopX0GkekhnUvyfdzMJsvK2fRkqP5+iJm6A9kkNTg46MCuDbif9oY
         mZWg==
X-Gm-Message-State: AOAM533OrOv0hB1sIjuY7vgR+d54XSO7R59+A3PSwP/wgYKJOPIR6Oy2
        o1uyg/h3foBdKxDws8UZ0xo=
X-Google-Smtp-Source: ABdhPJyLDLss7DbRlhBwymYDJ2LHbsdlJX3UO7RX2+I2yrZxZ6MhALtezlZ6m3P81fZZBmmQwbX2+g==
X-Received: by 2002:a65:6107:: with SMTP id z7mr914998pgu.43.1628109730840;
        Wed, 04 Aug 2021 13:42:10 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id w2sm7064922pjt.14.2021.08.04.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:42:10 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v14 0/9] PCI: Expose and manage PCI device reset
Date:   Thu,  5 Aug 2021 02:11:52 +0530
Message-Id: <20210804204201.1282-1-ameynarkhede03@gmail.com>
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
 drivers/pci/pci.c                             | 286 +++++++++++++-----
 drivers/pci/pci.h                             |  24 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |  16 +-
 drivers/pci/quirks.c                          |  25 +-
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  14 +-
 include/linux/pci_hotplug.h                   |   2 +-
 16 files changed, 331 insertions(+), 120 deletions(-)

--
2.32.0
