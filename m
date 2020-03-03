Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905F01776F8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCCN3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:29:08 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31077 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgCCN3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242146; x=1614778146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6aT2iVKaU3CdZpvZbkcMGdpLccOAfl0OuWApHtrLgI0=;
  b=nqwMNVvYF1XQYlzERcio0ghcc6CJrwdQnQk1pDKFy1SZmSsb87Kp40Rf
   F8wS3l+I4+cIvFBq5BZNEFtUo/N68YWxkmT9/b201ziVA/Vs7+2D6lrrh
   dX9fXFDPlPv2yYhQ1/rPxGVmFd28McdEblPBXoabDEfkPknbTKZhGk0Jl
   c=;
IronPort-SDR: YKBruZw2eunFnfNRBBwICfu717xKJ4iN7VjCqX0YqCj7VTpkFsX8e88Q0wh4jHSaA3u7M8Alwf
 CVaQWj7FkdYQ==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20495977"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Mar 2020 13:29:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 18F1CA2393;
        Tue,  3 Mar 2020 13:29:03 +0000 (UTC)
Received: from EX13D04EUA004.ant.amazon.com (10.43.165.150) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:29:02 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D04EUA004.ant.amazon.com (10.43.165.150) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:29:01 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:28:58 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v3 00/17] Improve PCI device post-reset readiness polling
Date:   Tue, 3 Mar 2020 14:28:35 +0100
Message-ID: <20200303132852.13184-1-stanspas@amazon.com>
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

Originally (v1), this patch series aimed to only solve an issue where
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

[Compared to v2, v3 fixes build failures on i386 and arm/arm64:
Reported-by: kbuild test robot <lkp@intel.com>
- int(value_us / 1000) does not work for u64 value_us due to:
  undefined reference to `__udivdi3'
  Change: use '(int)value_us / 1000' to match pre-existing code.
  It seems this would be susceptible to overflow/truncation ?
- I had failed to replace all mentions of PCI_PM_D3COLD_WAIT after
  renaming that constant to PCI_RESET_DELAY.]

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

 Documentation/power/pci.rst           |   4 +-
 arch/x86/pci/intel_mid_pci.c          |   2 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c   |   2 +-
 drivers/mfd/intel-lpss-pci.c          |   2 +-
 drivers/net/ethernet/marvell/sky2.c   |   2 +-
 drivers/pci/controller/pci-aardvark.c |   2 +-
 drivers/pci/controller/pci-mvebu.c    |   2 +-
 drivers/pci/iov.c                     |   4 +-
 drivers/pci/pci-acpi.c                | 106 ++++++++----
 drivers/pci/pci-driver.c              |   4 +-
 drivers/pci/pci.c                     | 233 ++++++++++++++++++--------
 drivers/pci/pci.h                     |  81 ++++++++-
 drivers/pci/probe.c                   |  10 +-
 drivers/pci/quirks.c                  |   9 +-
 include/linux/pci-acpi.h              |   8 +-
 include/linux/pci.h                   |  45 ++++-
 16 files changed, 390 insertions(+), 126 deletions(-)


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



