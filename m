Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA239149B
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhEZKPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhEZKPy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 06:15:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50CC061574;
        Wed, 26 May 2021 03:14:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j12so540194pgh.7;
        Wed, 26 May 2021 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ht50LVKPwo47LXgtv0kusT35s0sYZLEfbZ0XnD8sXI=;
        b=uztKE0VRFbGbUuP9GJlckJi9QVWzMcC8PvTQocatDU/dFHynAgK16CfnmH0LKyUDs8
         ZQBMpqBCaA9K1cTVbeC2oQMe7SGmmR9ig+1xqxX/Q4QxxZoMZitEHKzHKQTg881SS9br
         KQyjo0aN7/o0sZHLrWJw64WFqUdiYitSWaBROY55Lu11qjMDZgjzvRCrwi9CZmWj0Tl6
         c8bNFEXqOZhdXLXZ8ZzHOuYRtGdECQTTH/9cLA+Pj107zZPoFe4yvuHZy1ta4rPd1RVd
         2bgzI4wz4cz52jaEqqlYARC0Wa97FI8eurZhLpFV6SWMN9gQ2CfnFhXtP5LasllPSnyJ
         IuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ht50LVKPwo47LXgtv0kusT35s0sYZLEfbZ0XnD8sXI=;
        b=S7UzIswPfzopSeVdDFUvfmelSucoZq7MKqIi8h3k5L6TYYrqVQYwcNGIhgaMHjw2+1
         Un79SLD4Nbf+o8jvXDdRLbAx3+kfKDYpvecyMZmsWg0a01lfsL3Se/tcAGQv1QgRNMrL
         CZ1nfX6Zj/JI9sJdtJ/S66kI7HKVTPyxMGt4s5n17B3ZNpsn33LuUPnC2ayjaKzOcCZ8
         Wua88gZDn6+CZCRaOwBjRmGiL8GuKL1r1EKfppBmsAQygD6fvN0kROeh13zKeqKAuMcp
         KsDVAL8nP47CwR7ES+St+nCg4txyUQFk1biKdmLalfQQ+Fgo8sfb6gn2BGf0c7DaN87/
         LozA==
X-Gm-Message-State: AOAM531CiiMmGPwHAlQBL2u1iNM6dAnlNMsQbcH/RhvHQ/Wre+h6ajEv
        fJX3GuiAzEtoqNFSQlc9e4M=
X-Google-Smtp-Source: ABdhPJwI8YaQVQCchTwT3aqyOjZdMwzP9I6Ddc1sWwQ4VkhQY1ec2OP3+Fga3qj8NjJcUnfEQO1Jqw==
X-Received: by 2002:a63:fe53:: with SMTP id x19mr24042214pgj.372.1622024061307;
        Wed, 26 May 2021 03:14:21 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id c191sm15662614pfc.94.2021.05.26.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:14:20 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v3 0/7] Expose and manage PCI device reset
Date:   Wed, 26 May 2021 15:43:56 +0530
Message-Id: <20210526101403.108721-1-ameynarkhede03@gmail.com>
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

The error handling might be too verbose in the last patch
("PCI: Change the type of probe argument in reset functions").
Please let me know your comments.

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

Shanker Donthineni (2):
  PCI: Add support for a function level reset based on _RST method
  PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs

 Documentation/ABI/testing/sysfs-bus-pci       |  16 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
 drivers/pci/hotplug/pciehp.h                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |   7 +-
 drivers/pci/pci-sysfs.c                       |  97 ++++++-
 drivers/pci/pci.c                             | 264 ++++++++++++------
 drivers/pci/pci.h                             |  14 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |   4 +-
 drivers/pci/quirks.c                          |  63 +++--
 include/linux/pci.h                           |  16 +-
 include/linux/pci_hotplug.h                   |   2 +-
 13 files changed, 368 insertions(+), 135 deletions(-)

--
2.31.1
