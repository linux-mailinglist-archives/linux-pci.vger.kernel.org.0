Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232D9138889
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2020 23:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgALWq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Jan 2020 17:46:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:34750 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387500AbgALWqJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Jan 2020 17:46:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 14:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,426,1571727600"; 
   d="scan'208";a="396989488"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2020 14:46:05 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v12 0/8] Add Error Disconnect Recover (EDR) support
Date:   Sun, 12 Jan 2020 14:43:54 -0800
Message-Id: <cover.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This patchset adds support for following features:

1. Error Disconnect Recover (EDR) support.
2. _OSC based negotiation support for DPC.

You can find EDR spec in the following link.

https://members.pcisig.com/wg/PCI-SIG/document/12614

Changes since v11:
 * Allowed error recovery to proceed after successful reset_link().
 * Used correct ACPI handle for sending EDR status.
 * Rebased on top of v5.5-rc5

Changes since v10:
 * Added "edr_enabled" member to dpc priv structure, which is used to cache EDR
   enabling status based on status of pcie_ports_dpc_native and FF mode.
 * Changed type of _DSM argument from Integer to Package in acpi_enable_dpc_port()
   function to fix ACPI related boot warnings.
 * Rebased on top of v5.5-rc3

Changes since v9:
 * Removed caching of pcie_aer_get_firmware_first() in dpc driver.
 * Added proper spec reference in git log for patch 5 & 7.
 * Added new function parameter "ff_check" to pci_cleanup_aer_uncorrect_error_status(),
   pci_aer_clear_fatal_status() and pci_cleanup_aer_error_status_regs() functions.
 * Rebased on top of v5.4-rc5

Changes since v8:
 * Rebased on top of v5.4-rc1

Changes since v7:
 * Updated DSM version number to match the spec.

Changes since v6:
 * Modified the order of patches to enable EDR only after all necessary support is added in kernel.
 * Addressed Bjorn comments.

Changes since v5:
 * Addressed Keith's comments.
 * Added additional check for FF mode in pci_aer_init().
 * Updated commit history of "PCI/DPC: Add support for DPC recovery on NON_FATAL errors" patch.

Changes since v4:
 * Rebased on top of v5.3-rc1
 * Fixed lock/unlock issue in edr_handle_event().
 * Merged "Update error status after reset_link()" patch into this patchset.

Changes since v3:
 * Moved EDR related ACPI functions/definitions to pci-acpi.c
 * Modified commit history in few patches to include spec reference.
 * Added support to handle DPC triggered by NON_FATAL errors.
 * Added edr_lock to protect PCI device receiving duplicate EDR notifications.
 * Addressed Bjorn comments.

Changes since v2:
 * Split EDR support patch into multiple patches.
 * Addressed Bjorn comments.

Changes since v1:
 * Rebased on top of v5.1-rc1

Kuppuswamy Sathyanarayanan (8):
  PCI/ERR: Update error status after reset_link()
  PCI/DPC: Allow dpc_probe() even if firmware first mode is enabled
  PCI/DPC: Add dpc_process_error() wrapper function
  PCI/DPC: Add Error Disconnect Recover (EDR) support
  PCI/AER: Allow clearing Error Status Register in FF mode
  PCI/DPC: Update comments related to DPC recovery on NON_FATAL errors
  PCI/DPC: Clear AER registers in EDR mode
  PCI/ACPI: Enable EDR support

 Documentation/PCI/pcieaer-howto.rst       |   2 +-
 drivers/acpi/pci_root.c                   |   9 +
 drivers/net/ethernet/intel/ice/ice_main.c |   2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c           |   2 +-
 drivers/pci/pci-acpi.c                    |  98 ++++++++++
 drivers/pci/pci.c                         |   2 +-
 drivers/pci/pci.h                         |   2 +-
 drivers/pci/pcie/Kconfig                  |  10 +
 drivers/pci/pcie/aer.c                    |  16 +-
 drivers/pci/pcie/dpc.c                    | 217 ++++++++++++++++++++--
 drivers/pci/pcie/err.c                    |  10 +-
 drivers/pci/pcie/portdrv_core.c           |   7 +-
 drivers/pci/probe.c                       |   1 +
 drivers/scsi/lpfc/lpfc_attr.c             |   2 +-
 include/linux/acpi.h                      |   6 +-
 include/linux/aer.h                       |  12 +-
 include/linux/pci-acpi.h                  |  11 ++
 include/linux/pci.h                       |   3 +-
 18 files changed, 366 insertions(+), 46 deletions(-)

-- 
2.21.0

