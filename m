Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E11762FD
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCBSpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:45:06 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59617 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgCBSpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174707; x=1614710707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hkOjHPX+DVf2nZPCTNoZLyZ12zG0FGhF70ycSnOI4YE=;
  b=VBNO3iome1jp29N2FXv9gr/d2dlO1yBMXO5DYnFYtv4zuyulVlJFqxXU
   yK7OI4HgEdT1WM3UzWExGApopDXNxOdf313tSayW0QQQeSP8+8yaw4bjg
   f/e5e1HO+fBoQAofLgqRHnDubzXGeiBYop1YcbP6FMqB8ArEPYakkphQ/
   w=;
IronPort-SDR: FyqZn5GKa83zN/2HPODG1Zu/40IPKKzGCR+IJSHPfkW3u7kf7Wz9CQ/vuFc1+FZ+EYRvwXD8RD
 qHMIS4Be188Q==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="20320295"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Mar 2020 18:45:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 47300A24CF;
        Mon,  2 Mar 2020 18:45:03 +0000 (UTC)
Received: from EX13D12EUA004.ant.amazon.com (10.43.165.162) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D12EUA004.ant.amazon.com (10.43.165.162) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:01 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:44:57 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Sinan Kaya" <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: [PATCH v2 00/17] Improve PCI device post-reset readiness polling
Date:   Mon, 2 Mar 2020 19:44:12 +0100
Message-ID: <20200302184429.12880-1-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stanislav Spassov <stanspas@amazon.de>

The first version of this patch series can be found here:
https://lore.kernel.org/linux-pci/20200223122057.6504-1-stanspas@amazon.com

Originally, this patch series aimed to only solve an issue where
pci_dev_wait can cause system crashes. After a reset, a hung device may
keep responding with CRS completions indefinitely. If CRS Software
Visibility is enabled on the Root Port, attempting to read any register
other than PCI_VENDOR_ID will cause the Root Port to autonomously retry
the request without reporting back to the CPU core. Unless the number of
retries or the amount of time spent retrying is limited by
platform-specific means, this scenario leads to low-level platform
timeouts (such as a TOR Timeout), which easily escalate to a crash.

The feedback on the first version of this patch series inspired a
deeper dive into the PCI Firmware Spec (_DSM functions 8 and 9),
which revealed several different types of delays that can be overriden
on a per-device basis to avoid waiting for too long on device that are
known to come back quickly after reset. The kernel already stores such
overrides for some, but not all of the delays.

While adding the infrastructure to allow overriding delays, I discovered
and addressed several inconsistencies between what the PCIE
Base Specification says and what the code does, and came up with more
improvements all around device resets and readiness polling.

This patch series now paves the way for Readiness Time Reporting capability
support, and touches upon (in comments) some changes that would be
required for supporting Readiness Notifications.

Stanislav Spassov (17):
  PCI: Fall back to slot/bus reset if softer methods timeout
  PCI: Remove unused PCI_PM_BUS_WAIT
  PCI: Use pci_bridge_wait_for_secondary_bus after SBR
  PCI: Do not override delay for D0->D3hot transition
  PCI: Fix handling of _DSM 8 (avoiding reset delays)
  PCI: Fix us->ms conversion in pci_acpi_optimize_delay
  PCI: Clean up and document PM/reset delays
  PCI: Add more delay overrides to struct pci_dev
  PCI: Generalize pci_bus_max_d3cold_delay to pci_bus_max_delay
  PCI: Use correct delay in pci_bridge_wait_for_secondary_bus
  PCI: Refactor pci_dev_wait to remove timeout parameter
  PCI: Refactor pci_dev_wait to take pci_init_event
  PCI: Cache CRS Software Visibiliy in struct pci_dev
  PCI: Introduce per-device reset_ready_poll override
  PCI: Refactor polling loop out of pci_dev_wait
  PCI: Add CRS handling to pci_dev_wait()
  PCI: Lower PCIE_RESET_READY_POLL_MS from 1m to 1s

 Documentation/power/pci.rst         |   4 +-
 arch/x86/pci/intel_mid_pci.c        |   2 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c |   2 +-
 drivers/mfd/intel-lpss-pci.c        |   2 +-
 drivers/net/ethernet/marvell/sky2.c |   2 +-
 drivers/pci/iov.c                   |   4 +-
 drivers/pci/pci-acpi.c              | 106 +++++++++----
 drivers/pci/pci-driver.c            |   4 +-
 drivers/pci/pci.c                   | 233 +++++++++++++++++++---------
 drivers/pci/pci.h                   |  81 +++++++++-
 drivers/pci/probe.c                 |  10 +-
 drivers/pci/quirks.c                |   9 +-
 include/linux/pci-acpi.h            |   8 +-
 include/linux/pci.h                 |  45 +++++-
 14 files changed, 388 insertions(+), 124 deletions(-)


base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



