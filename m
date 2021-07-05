Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4A3BBE1D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhGEOYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhGEOYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 10:24:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F4CC06175F;
        Mon,  5 Jul 2021 07:21:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v13so10333799ple.9;
        Mon, 05 Jul 2021 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTmmmfhbZe/o2WqiYNUf5EzatKBKvlNcT12AxwNNdlg=;
        b=aoGYRHtzWYrI8gbO8G/cf3w4ATS52HdhdNFmIYQQO5sBR4rlKNg5hWj/E3UDjxh8Xe
         y9RLGsaj+BGN4XbMqCRW/wUFQ0sym/xW9gyD9rI8SevjNCHdvYP6n7EGy0Q6UJkSetDW
         nIDYpIF61E7Kx68HHYBPDa7fXB8mQU72tR6BsBRkIBtufxJKeX1Z+g///Hje5bOwT4Gk
         cxf6EI0CKkII/iQUpD6Wc/Bs67yl4XeS/c2J9/QGHJIftieDWw1foP9g3eDG7Jy76cdv
         QTkGs8C8BwUV5345qGF6LuqjuV9bU3LyP/3KS3VIg/54TDNMTVuCaicPZxDRTZu3ynjh
         TabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTmmmfhbZe/o2WqiYNUf5EzatKBKvlNcT12AxwNNdlg=;
        b=gXjt27yaOokwYtrZIgqLNhDUCXHn2TCPYI+cW/zqT2QifPAAlMbbCdKD1U/C85ytmy
         ZIkScW7AjymyT6tUC1cEr7a9V1kwIQYJeFNKH7mOSM27Kn4tnoAOAGdTyMwBHB70SdoK
         DsSi/wP0yI6PpeRLzsdcrn5E4t20dVx+gOGjasPVjSMBgv0hPyBfurlZsBYumRsyUua9
         mW0VV9IS6DfklheiI4pdYoLMlQ/PLtRiAklsu5Bx9NRynqYVAvpKUiSs+vDcpTJne7Yw
         AI6YC7y6a7tznCoxmjK8yZI52VA9HhvKIxD8nkbYV59yPizirPb39nvKN+zZmVTm8ffi
         tjog==
X-Gm-Message-State: AOAM532MR9qqTuSj554492+OBIKhb40aPG7Eve+29wZoh+wlIuVoDBod
        I3YksxmleYYK7sAOM4agMW0=
X-Google-Smtp-Source: ABdhPJwuacdErMcPMZfKjdrxNMrKEVhUPu0ZprxwaTQ+PwMIMcQJHFhgVyR7hl3omb/7RH8X9t1Q9w==
X-Received: by 2002:a17:902:f543:b029:129:8fd3:c6ac with SMTP id h3-20020a170902f543b02901298fd3c6acmr4150975plf.31.1625494918968;
        Mon, 05 Jul 2021 07:21:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
        by smtp.googlemail.com with ESMTPSA id 92sm22615307pjv.29.2021.07.05.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:21:58 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v9 0/8] Expose and manage PCI device reset
Date:   Mon,  5 Jul 2021 19:51:30 +0530
Message-Id: <20210705142138.2651-1-ameynarkhede03@gmail.com>
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

Amey Narkhede (5):
  PCI: Add pcie_reset_flr to follow calling convention of other reset
    methods
  PCI: Add new array for keeping track of ordering of reset methods
  PCI: Remove reset_fn field from pci_dev
  PCI/sysfs: Allow userspace to query and set device reset mechanism
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
 drivers/pci/pci-acpi.c                        |  38 +++-
 drivers/pci/pci-sysfs.c                       | 107 ++++++++-
 drivers/pci/pci.c                             | 215 ++++++++++--------
 drivers/pci/pci.h                             |  23 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |  17 +-
 drivers/pci/quirks.c                          |  42 ++--
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  17 +-
 include/linux/pci_hotplug.h                   |   2 +-
 15 files changed, 361 insertions(+), 144 deletions(-)

--
2.32.0
