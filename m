Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECFC394DDB
	for <lists+linux-pci@lfdr.de>; Sat, 29 May 2021 21:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhE2T1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 May 2021 15:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhE2T1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 May 2021 15:27:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53F3C061574;
        Sat, 29 May 2021 12:25:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j12so5164401pgh.7;
        Sat, 29 May 2021 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+Pi6aUWQk8YnBWt2s1qh+0Rx8QcWNf32gFFaODjRD0=;
        b=q9jtcPS7F5rGOd6ROvnbCLLYwjKf1XLja+Wzi1NP+CwtbYldfDojtQv/Mptp/0IV96
         FxhFctcxHSHyjrBBkdhZY9JWknZvBVqVevdeO/hUS4zxDDJlrNaS8YF+otD9dezIYIbh
         icSWDLEzg+0BKjEwyejVusvbDu9B1YCryJISLymq0zb0+gSyc5vzsYVivnqo3wOVLeHd
         j+IUaz/WYNi1b1ypzXP9vSxVAL7AgFYSxVYSPbJ5wSt1rOAMsWSzOU2shV2OAjj1vPEc
         VzsA0TFlujmiRQliqmoxSvBn527YliCblCmoXi3rFLmp7ClBYnxac3+ILn0hvMNpQgTr
         C8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+Pi6aUWQk8YnBWt2s1qh+0Rx8QcWNf32gFFaODjRD0=;
        b=KkS8FZdTF2O8hhOe0QRNWolVWlSks/DLjQlH6+99Xts2Qsr6HkCHrfjH9hkh3n7yCJ
         fKJmmz/VSu/WK+lsgmTBzzz4QSGMFJnejH810oORfxdzDnXKlXfDurxJ9RR59o5/m8MP
         3vipfsyOST/svSPEN4vjybzS+sMWpsXch5DWX3IKvRL9Mjjk3EA3QA7/w4FMn065Jdgz
         c/hXHn7q0Y3kTPlXSB1v7I6veYwF1WYdmEaLkrzHXWZaa8tMTtc7IJMjcy58moiOTI6/
         KPCJS7ho4h8flmDMWSUMeAadjGwIfiAZD8yuQ68dBmxe6cBuGZCRGDIz9R310GoEwfka
         jVzw==
X-Gm-Message-State: AOAM531zRVdYYf2NWB8ivvC3hdQIEFxcNiuXP7kJX2ZOp42uNh7ElLI8
        Df7JzLi2AOJ5MRwgWQTOIWY=
X-Google-Smtp-Source: ABdhPJy/WN+mRTiIeGVtE0FhcGgReHVHYYbdQnLBYSlFqWNd8YwDqFGLHKKek17vmtF9WRRyzyn3Yg==
X-Received: by 2002:a63:2254:: with SMTP id t20mr4888580pgm.322.1622316335299;
        Sat, 29 May 2021 12:25:35 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.172])
        by smtp.googlemail.com with ESMTPSA id ge5sm7286754pjb.45.2021.05.29.12.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 12:25:34 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v5 0/7] Expose and manage PCI device reset
Date:   Sun, 30 May 2021 00:55:20 +0530
Message-Id: <20210529192527.2708-1-ameynarkhede03@gmail.com>
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

Shanker Donthineni (2):
  PCI: Add support for a function level reset based on _RST method
  PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs

 Documentation/ABI/testing/sysfs-bus-pci       |  16 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
 drivers/pci/hotplug/pciehp.h                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |   4 +-
 drivers/pci/pci-sysfs.c                       | 128 ++++++++-
 drivers/pci/pci.c                             | 269 +++++++++++-------
 drivers/pci/pci.h                             |  14 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |   4 +-
 drivers/pci/quirks.c                          |  54 ++--
 drivers/pci/remove.c                          |   1 -
 include/linux/pci.h                           |  16 +-
 include/linux/pci_hotplug.h                   |   2 +-
 14 files changed, 385 insertions(+), 143 deletions(-)

--
2.31.1
