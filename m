Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935DA299630
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783514AbgJZS5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:57:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:46460 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783214AbgJZS5I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:57:08 -0400
IronPort-SDR: CTaCBP5upYd7NRs0oV3s1Xp3JIheMEXC8G459BoffeZe6Yxfb8ssHz/DumtAnPCZb14rJ+9OpY
 l6cKYMavFVnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155752386"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="155752386"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:57:07 -0700
IronPort-SDR: 15F2yqHjNs2FiJ64nFI+beVytYDa8Fha+tRdffFVd6WOmBD3voLrHOELcXnY+xbiK4eat46D7d
 9sfwzbxVks6g==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="525607171"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:57:06 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v10 0/5] Simplify PCIe native ownership detection logic
Date:   Mon, 26 Oct 2020 11:56:38 -0700
Message-Id: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

 drivers/acpi/pci_root.c           | 37 ++++++++++++++++++++++---------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 ---
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/dpc.c            |  3 ---
 drivers/pci/pcie/portdrv.h        |  2 --
 drivers/pci/pcie/portdrv_core.c   | 13 +++++------
 drivers/pci/probe.c               |  6 +++--
 include/linux/acpi.h              |  2 ++
 include/linux/pci.h               |  2 ++
 10 files changed, 42 insertions(+), 30 deletions(-)

-- 
2.17.1

