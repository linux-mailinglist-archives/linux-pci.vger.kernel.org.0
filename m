Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D934129A2D0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 03:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408680AbgJ0C5S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 22:57:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:23076 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408598AbgJ0C5Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 22:57:16 -0400
IronPort-SDR: mpiP+4fqWBb9OVTFv6dwPfuWK7qQF/w4mjckbNUA/rRrGYQFb7RX5yw4CY6A3j4zasv+PuK3eT
 p40ivEZGmEGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="185753252"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="185753252"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 19:57:15 -0700
IronPort-SDR: XEDrDogb+1+OgN5uwZqPSSDBO/QpjW/LZMhiJ40xeng5Wff2RVlF6QC841Lwml3mGRwB0gBIDl
 2LlYvxJc4/jg==
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="322772466"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 19:57:15 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v11 0/5] Simplify PCIe native ownership detection logic
Date:   Mon, 26 Oct 2020 19:57:03 -0700
Message-Id: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, PCIe capabilities ownership status is detected by
verifying the status of pcie_ports_native, pcie_ports_dpc_native
and _OSC negotiated results (cached in  struct pci_host_bridge
->native_* members). But this logic can be simplified, and we can
use only struct pci_host_bridge ->native_* members to detect it. 

This patchset removes the distributed checks for pcie_ports_native,
pcie_ports_dpc_native parameters.

Changes since v10:
 * Addressed format issue reported by lkp test.

Changes since v9:
 * Rebased on top of v5.10-rc1

Changes since v8:
 * Simplified setting _OSC ownwership logic
 * Moved bridge->native_ltr out of #ifdef CONFIG_PCIEPORTBUS.

Changes since v7:
 * Fixed "fix array_size.cocci warnings".

Changes since v6:
 * Created new patch for CONFIG_PCIEPORTBUS check in
   pci_init_host_bridge().
 * Added warning message for a case when pcie_ports_native
   overrides _OSC negotiation result.

Changes since v5:
 * Rebased on top of v5.8-rc1

Changes since v4:
 * Changed the patch set title (Original link: https://lkml.org/lkml/2020/5/26/1710)
 * Added AER/DPC dependency logic cleanup fixes.
 

Kuppuswamy Sathyanarayanan (5):
  PCI: Conditionally initialize host bridge native_* members
  ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
  ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native
    is set.
  PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable
    logic
  PCI/DPC: Move AER/DPC dependency checks out of DPC driver

 drivers/acpi/pci_root.c           | 39 +++++++++++++++++++++++--------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 ---
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/dpc.c            |  3 ---
 drivers/pci/pcie/portdrv.h        |  2 --
 drivers/pci/pcie/portdrv_core.c   | 13 ++++-------
 drivers/pci/probe.c               |  6 +++--
 include/linux/acpi.h              |  2 ++
 include/linux/pci.h               |  2 ++
 10 files changed, 44 insertions(+), 30 deletions(-)

-- 
2.17.1

