Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9F39EE5D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 07:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFHFwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 01:52:00 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45662 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHFv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 01:51:59 -0400
Received: by mail-ot1-f54.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso6189428oto.12;
        Mon, 07 Jun 2021 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU9gyIhIu/Gt0QDM51vMD/k69XE9ymll1NIzzI6gd34=;
        b=NSsE7la4ii3+JSCFpP8Dc9bMg44O1nZdjmx9BlKDFkIYtfkhtvrDZ5RLQX+0Z0JNVl
         n8+fKBqIpivuQIfKbBwGizUog6NLwNnpBPSdGiyT77hym/oEtZDJJ8OEoxO+nDsMzQF+
         F9tHqCrhHS23dZRP0ZWcjDCDeSnXLAm362TfNU+/fTf31TNr6pxy0/UQHkzyQRsvDgt6
         2xMqcPraOkLOdLuR9hpN6eJ6ccMWmHnkkwK+ID9zvC0d93h3VCUrgOmXNfTBZ8UvxPc0
         wTX6CUV89OEbfFrUTYZQezhr/J9+HyscTXkr/zU6MqU656lPKxfh+1DfEj1tk6SFM0iF
         4Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU9gyIhIu/Gt0QDM51vMD/k69XE9ymll1NIzzI6gd34=;
        b=R/tOK3sq23QzIBc6mCwZ+tMIoypVAEIGS4cruV7dg80iayK7iiUNxjgb2hEHYCCPx4
         b9GbfEmLdQAULazN+CgzW5UlnVTFNXUUZXHtLSeGqwxWKNIUjA+X4nALpiU3BvLNVwwB
         FnOQz/f+q4L1+CWPoZt0eVfotB6r8GxynVNuXV27tlg8+95khNO44hc2+X1orx+iIvUh
         GyKwzrk8fik0B89cUKMH7hkiyHV9mA/FJLHyp/MPTMkZn1u1ChVYc/tr+307lbIQvkL+
         lICI2SeqbpBcK14OxaFyL5RqiPeh69ujSx9PPWVKKunjXcQyuIcWi3UTt//fGSz6518L
         LTqQ==
X-Gm-Message-State: AOAM531x8fJnYN8iQZhXeXanaNH21JRY5jzuiAkqI9uRV+GNKXMelXMJ
        Dn1nXuPQEZponjFFRDzz9Zc=
X-Google-Smtp-Source: ABdhPJw3ZkGpg7jQDZ4aZSj7g1UT7Ji5qHJp6nHzrA3NcpEVSBxSkpKDUML/JVV83o4UwSH9cEl4wg==
X-Received: by 2002:a05:6830:90f:: with SMTP id v15mr8953545ott.120.1623131347268;
        Mon, 07 Jun 2021 22:49:07 -0700 (PDT)
Received: from localhost.localdomain (static-198-54-128-46.cust.tzulo.com. [198.54.128.46])
        by smtp.googlemail.com with ESMTPSA id o2sm2489730oom.26.2021.06.07.22.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:06 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v7 0/8] Expose and manage PCI device reset
Date:   Tue,  8 Jun 2021 11:18:49 +0530
Message-Id: <20210608054857.18963-1-ameynarkhede03@gmail.com>
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
