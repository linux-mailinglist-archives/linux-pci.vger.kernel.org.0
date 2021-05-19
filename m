Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05A8389A1E
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 01:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhESXz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 19:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhESXz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 19:55:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB4C061574;
        Wed, 19 May 2021 16:54:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y32so10567657pga.11;
        Wed, 19 May 2021 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQYnKbmkAJ17UumIFNVxhYNqul1vSRER6KQdYAbNXM4=;
        b=r1UjLR406j5LcmougKSL1oU0msLMYnWRhV1QC5RbfYs8GJHxJ4NDnGZztfe/UOTXDo
         ELqUXNuDyV57AW6MOkrHLzR6MxYK+RGK0dMNRTeMVDjKh0XcbjnhfSOfEvt53uBx0BAb
         wcyaCueCVApfmUwk8VH2yraXqWPHcbH/xXY489n1LoOYYw67/0bJ2TDZDe3dlcAef/0f
         D+mi7GOG5btEAlI52Frps3gve4AzgUxCozXlDpBxL+7QZ31GnFRjoZFSEwm0Bx0vZJGM
         T1MXxrr2xsEQeBgT+smDGmwKRC4uCKteVSjgGA0TxflAsVTpGzRpv1OGuvOTc9eYsXKw
         FqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQYnKbmkAJ17UumIFNVxhYNqul1vSRER6KQdYAbNXM4=;
        b=E4lconkiRlAi7qRgOkvFseJpEs6g6ZvyokoBr2DXpcogdk5ane7k9tGGbUfBIMLtWP
         pvJG8drfKTkC1yK9t2c9ot6QfVLArM3TalhwTo4aq3nCIfM/AupB1GH0oo9zD6u/MowS
         VrK3rv0oqpZDXXlalbgFx1Rzp5eKki+PINOLq05N24eMdg1Ru5R1yF3G4N19Te4F0G1D
         2OEeq+THdArapgdT8P9MmrrRL09iQfs27cOIJqWLFHYkov8/VESvBg0A+SUCqEmVx+Gg
         YI5YTrnMENlR21W+AFXVVbeihNZ+LdPvkXJxPNavTztr4HcugU640vuHFYrWumbBuS3z
         faFw==
X-Gm-Message-State: AOAM530rSQlJT5dJe550uYZdUcuybAaBxG7Q9XC/URV63uKBawO6ZEcz
        Z/wNsz3RmKyfkrBsjyjkfsk=
X-Google-Smtp-Source: ABdhPJyYcukJAoyiWW3voXMlBY2qdbP/75/pU71nhmMWyYClDJNEVx4WOuW9OgnKUraiS/f9dMwGXw==
X-Received: by 2002:aa7:97ad:0:b029:2e0:26a8:8da5 with SMTP id d13-20020aa797ad0000b02902e026a88da5mr1560913pfq.37.1621468476262;
        Wed, 19 May 2021 16:54:36 -0700 (PDT)
Received: from localhost.localdomain ([94.140.8.39])
        by smtp.googlemail.com with ESMTPSA id z12sm397670pfk.45.2021.05.19.16.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:54:35 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH RESEND v2 0/7] Expose and manage PCI device reset
Date:   Thu, 20 May 2021 05:24:19 +0530
Message-Id: <20210519235426.99728-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[RESEND with Shanker's patches as those depend on this series]

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

Changes in v2:
	- Use byte array instead of bitmap to keep track of
	  ordering of reset methods
	- Fix incorrect use of reset_fn field in octeon driver
	- Allow writing comma separated list of names of supported reset
	  methods to reset_method sysfs attribute
	- Writing empty string instead of "none" to reset_method attribute
	  disables ability of reset the device

Sending Raphael's patch again as this series depends on it.


Amey Narkhede (4):
  PCI: Add pcie_reset_flr to follow calling convention of other reset
    methods
  PCI: Add new array for keeping track of ordering of reset methods
  PCI: Remove reset_fn field from pci_dev
  PCI/sysfs: Allow userspace to query and set device reset mechanism

Raphael Norwitz (1):
  PCI: merge slot and bus reset implementations

Shanker Donthineni (2):
  PCI: Add support for a function level reset based on _RST method
  PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs

 Documentation/ABI/testing/sysfs-bus-pci       |  16 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
 drivers/pci/pci-sysfs.c                       |  93 +++++++-
 drivers/pci/pci.c                             | 206 +++++++++++-------
 drivers/pci/pci.h                             |  10 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |   4 +-
 drivers/pci/quirks.c                          |  23 +-
 include/linux/pci.h                           |  11 +-
 10 files changed, 278 insertions(+), 103 deletions(-)

--
2.31.1
