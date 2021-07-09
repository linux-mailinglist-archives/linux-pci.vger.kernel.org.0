Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878503C237D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhGIMlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhGIMlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 08:41:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0910C0613DD;
        Fri,  9 Jul 2021 05:38:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m83so932084pfd.0;
        Fri, 09 Jul 2021 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmpEl8jyHm3zHYz90wVqs2oB/lVmJE3SrC9iWzeIxbI=;
        b=dagvDfJTqEjUdj3WcSA9oME5qoqA1lNshO6JuBlLPhlSoPD85QrsOMmK2NJoKsQKnJ
         bhvkf464d/wbkKpaK87u64qWN/C41rtN4ALC4MGysCNI/JRGdOdaFq6b6Y8ugkpxlw+h
         A2Gd+qmME4goCN+4/AiHNumJFEntwUtolF9tG0Ccz4dIzM2dX42z3vrb2Jz1b23IpUMU
         6UeiF+LieKFjkN1Agm4/4mtHQNNuf9ll52XS1Cx31HsDNx2jKkuJ+a2sPb/VGGuW5DYk
         /QtTIg0LqBGszPGl0gfuULdi36zXsEvYGPn8x4s3rEFx+GoHf+axlZ9M6twM9Qz8o1ra
         xwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmpEl8jyHm3zHYz90wVqs2oB/lVmJE3SrC9iWzeIxbI=;
        b=gD0Xka0uNu1l0z/liwKUSkQAee6Tgf6IoXIBPJiOsZzjgSTr3cvMoch+zCX5uaQ4GS
         BKIarghWzhfDLeDvCEMwM7zGrNGyyYD0Le9udMU/3dkf8a3hJAUe22+X2SMdNGy4P2lV
         NVJR/ozVlZfLFyjt4gz+WmRAzv6xXBZD8/kvef4lvjEYHxlOIGrv5y2i28114IuZBLre
         vF06kS85LHMbEySxBQWrUtRZ0ZQi/2uYhwoBtrMnS/kZhL1w1ssIyNAkSkLhfjhNZWot
         v1+4GXtsLxIN7Z4XvffWh4x0DEa1BOcqdW0WEzqMTvE19KD/vGtAWTQ7ruYYdcndrvV8
         LmzQ==
X-Gm-Message-State: AOAM531SgAfSjHhBX2fAUz0tFtuHSxVUbbhlDOWqJKlfpvSwNxHWKbWB
        r0ZhjtVsW0iI8toBP7oC9Us=
X-Google-Smtp-Source: ABdhPJx9qDUqhb3FCpPy6p1bff9KhIlpJi6RzX0iQyIXgsp4pJ8oO0N0KhfHnvGpvwCtZEwogx7OFQ==
X-Received: by 2002:a63:1601:: with SMTP id w1mr37488621pgl.116.1625834308250;
        Fri, 09 Jul 2021 05:38:28 -0700 (PDT)
Received: from localhost.localdomain ([152.57.176.46])
        by smtp.googlemail.com with ESMTPSA id j6sm5592402pji.23.2021.07.09.05.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:38:27 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v10 0/8] Expose and manage PCI device reset
Date:   Fri,  9 Jul 2021 18:08:05 +0530
Message-Id: <20210709123813.8700-1-ameynarkhede03@gmail.com>
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
 drivers/pci/hotplug/pnv_php.c                 |   4 +-
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
 16 files changed, 363 insertions(+), 146 deletions(-)

--
2.32.0
