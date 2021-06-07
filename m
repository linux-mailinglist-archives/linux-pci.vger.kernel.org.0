Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE7439E675
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFGSYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhFGSY3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 14:24:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C0CC061766;
        Mon,  7 Jun 2021 11:22:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o9so11648093pgd.2;
        Mon, 07 Jun 2021 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOpjpKhJVE8UzEqMVCHON7lHpeTVYDRI0KE/MmWnE44=;
        b=qPXdVPe4D6QysWvy9E8c9H6dxc5vFPtkaXyY3Chtjmv0LxlrMauDEaqgz4LzfLaMy5
         RIkgS2f4RSO7cf4d1/WrnwExz81toNYGCNrwfTSzwfkeTs/VuOsq9hdu6HxvilK7e1s3
         mo00GWHyAqOXin5oQlvqnDPDcHX4Ez7WQb0CsZzJWIQBb7uC9iv2XmctDJ01AbN6SB9k
         Hfsxchpj/q55Nwvdn2N3gXt9hth5C6TXRDgTbVrCyZrYR84DCirm0fqNokJ8CgBthZNZ
         YJzowkz5QocoR12Xhip/6Grorp71D7yxqb+rtVQHIPpdg1WXTMY7gTmCa0eL0f4zbfms
         wnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOpjpKhJVE8UzEqMVCHON7lHpeTVYDRI0KE/MmWnE44=;
        b=GO8En6n58H+6zBdXjHf0XCfgwX2tIwYgFfm17lQWsd6xOE7kl5g5an5KWRjFmwRx6k
         qBALc9Tsc9fQQYfikQenGzOJS4wiB6uxWjql9CYygmc5SezylG6OvVUXi980LEKiCwcX
         iLLSRbwZy0UQqxDG+qeDz+GJuN9ohXR5GxFjR4Z0TN1yaNLmHugJpgiO5lb2EEf8obmP
         frBqBVIyC6Svv5FbEm+CyUGlpp7bNc8gVoklW4vjKZDSzOckdHNapZY06FGdrSg4WPjG
         lxkR7G+yDn13g8MW6NwCho2MjKWNNTbnvch2ARJs2jB60Zoha5TWCWL9gPxo+frt+l5H
         F8jw==
X-Gm-Message-State: AOAM532nn75/YaUJlhqoQnogKzocfFD+fDBoc79CeFS316szFPRsbTwK
        3AjYOypdG5KIJiW2l/XNiiM=
X-Google-Smtp-Source: ABdhPJy8Uu6z04Cv48koy1dbTA3UckLhD9H6pq4UvaZ58LENJtgZ/d2JPabOVxcShW4TKCjsBBD7yg==
X-Received: by 2002:a63:4d0:: with SMTP id 199mr19322070pge.423.1623090142825;
        Mon, 07 Jun 2021 11:22:22 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.115])
        by smtp.googlemail.com with ESMTPSA id k1sm8687656pfa.30.2021.06.07.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:22:22 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v6 0/8] Expose and manage PCI device reset
Date:   Mon,  7 Jun 2021 23:51:29 +0530
Message-Id: <20210607182137.5794-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
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
  PCI: Setup ACPI_COMPANION early
  PCI: Add support for ACPI _RST reset method
  PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs

 Documentation/ABI/testing/sysfs-bus-pci       |  16 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
 drivers/pci/hotplug/pciehp.h                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |   4 +-
 drivers/pci/pci-acpi.c                        |  39 ++-
 drivers/pci/pci-sysfs.c                       | 120 ++++++++-
 drivers/pci/pci.c                             | 238 +++++++++++-------
 drivers/pci/pci.h                             |  22 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |   6 +-
 drivers/pci/quirks.c                          |  54 ++--
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  16 +-
 include/linux/pci_hotplug.h                   |   2 +-
 15 files changed, 393 insertions(+), 145 deletions(-)

--
2.31.1
