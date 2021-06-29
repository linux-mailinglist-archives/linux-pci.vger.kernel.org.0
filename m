Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7AE3B761E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhF2QGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhF2QE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 12:04:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15252C061767;
        Tue, 29 Jun 2021 09:01:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a2so18891926pgi.6;
        Tue, 29 Jun 2021 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ95XS6vBWSUxF/juHUgKaWI9vzuOl5nUNvKuyjmcyQ=;
        b=mt6877pp/SnGLtdNtmtvUBzSMtRbHNSc/dBruh2PdNStctR3smvij1Koe713sVEmJ8
         idmSiwoH4/e980gIzHV6ENYtZLSUnYIbkQDlH8scIB2j0dgsBbUgljkK2uwOPjgYWMmg
         KVgWqUsF7v/wQl8SRlGXqPU7vsdx49WUotFG7AOBZJ7LB9CJZSKZMVz7XXldOHgSDi7G
         Y9Nf1Y6VTJZxD3o0YkAJLIL6DnwAsTU46d4aL2VulIIEfXKkGLNY5OLcKfr8UOkQG+2P
         oujVNFztI8QToPGvtmWPfb7gCQqjJyMPSdWPizSnbOqdO4rYwj/rYEQBvZ1zyRFzdpCi
         SJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ95XS6vBWSUxF/juHUgKaWI9vzuOl5nUNvKuyjmcyQ=;
        b=NLadAaNEFY5OWhPnrodwTqoYe9qkv4GAunbDGrad6bzabHgpKOAp9DwcgcKBZKG2V+
         1Kw5WFxhjNEWggEQn/sQ3bXJjTLuw+lhDC+yT4iPWnBT0ah1KymI+ZlyHiFOl5oBkpug
         Ri2uyZblNNZHOZVTxH249AShdh1Frt67QVri/k26xbNSNuaL0EMKDjX/ER/NEobYctTa
         jlKVc8fD/r1KMXitvJMhv6Ww+0XDvyX70nmBrWKDXqXc2DCeNVXW9ONhiO3FloSAKN/h
         rFuCZvDym+CGlIiFW62Xg2deM8rQ9YaE1xaCVlOrGgGwIG7Dak1r/uzjMb6q8SINI3Bo
         /xfg==
X-Gm-Message-State: AOAM533QB/i7pBYG8KreESddn/HKRl7OR4oAEOsWoP6Ga4IVrssQiUnt
        98M7ZnIRHCoxg2tVHOJoofA=
X-Google-Smtp-Source: ABdhPJxJ9Cl/1XRty79tUGB6y6w3+3bKFXBJ1FcQDEhh/MpqbRrzyDYAIeG6fbyai+9ocPsdYzuSzg==
X-Received: by 2002:a65:6783:: with SMTP id e3mr28974407pgr.281.1624982515634;
        Tue, 29 Jun 2021 09:01:55 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.119])
        by smtp.googlemail.com with ESMTPSA id m14sm19166240pgu.84.2021.06.29.09.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:01:55 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v8 0/8] Expose and manage PCI device reset
Date:   Tue, 29 Jun 2021 21:30:56 +0530
Message-Id: <20210629160104.2893-1-ameynarkhede03@gmail.com>
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
 drivers/pci/pci-acpi.c                        |  38 ++-
 drivers/pci/pci-sysfs.c                       | 106 ++++++++-
 drivers/pci/pci.c                             | 222 ++++++++++--------
 drivers/pci/pci.h                             |  23 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |  17 +-
 drivers/pci/quirks.c                          |  44 ++--
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  21 +-
 include/linux/pci_hotplug.h                   |   2 +-
 15 files changed, 366 insertions(+), 151 deletions(-)

--
2.32.0
