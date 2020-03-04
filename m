Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7E2178874
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbgCDCjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:44650 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbgCDCjH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866891"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v17 00/12] Add Error Disconnect Recover (EDR) support
Date:   Tue,  3 Mar 2020 18:36:23 -0800
Message-Id: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Changes since v16:
 * Removed reset_link from pcie_port_service_driver.
 * Removed pcie_port_find_service().
 * Added pci_dpc_init() in pci_init_capabilities().

Changes since v15:
 * Splitted Patch # 3 in previous set into multiple patches.
 * Refactored EDR driver use pci_dev instead of dpc_dev.
 * Added some debug logs to EDR driver.
 * Used pci_aer_raw_clear_status() for clearing AER errors in EDR path.
 * Addressed other comments from Bjorn.
 * Rebased patches on top of Bjorns "PCI/DPC: Move data to struct pci_dev" patch.

Changes since v14:
 * Rebased on top of v5.6-rc1

Changes since v13:
 * Moved all EDR related code to edr.c
 * Addressed Bjorns comments.

Changes since v12:
 * Addressed Bjorns comments.
 * Added check for CONFIG_PCIE_EDR before requesting DPC control from firmware.
 * Removed ff_check parameter from AER APIs.
 * Used macros for _OST return status values in DPC driver.

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

Kuppuswamy Sathyanarayanan (12):
  PCI/ERR: Update error status after reset_link()
  PCI/AER: Move pci_cleanup_aer_error_status_regs() declaration to pci.h
  PCI/ERR: Remove service dependency in pcie_do_recovery()
  PCI: portdrv: remove unnecessary pcie_port_find_service()
  PCI: portdrv: remove reset_link member from pcie_port_service_driver
  Documentation: PCI: Remove reset_link references
  PCI/ERR: Return status of pcie_do_recovery()
  PCI/DPC: Cache DPC capabilities in pci_init_capabilities()
  PCI/AER: Allow clearing Error Status Register in FF mode
  PCI/DPC: Export DPC error recovery functions
  PCI/DPC: Add Error Disconnect Recover (EDR) support
  PCI/ACPI: Enable EDR support

 Documentation/PCI/pcieaer-howto.rst |  25 ++-
 drivers/acpi/pci_root.c             |  16 ++
 drivers/pci/pci-acpi.c              |   3 +
 drivers/pci/pci.h                   |  16 +-
 drivers/pci/pcie/Kconfig            |  10 ++
 drivers/pci/pcie/Makefile           |   1 +
 drivers/pci/pcie/aer.c              |  34 ++--
 drivers/pci/pcie/dpc.c              |  47 ++++--
 drivers/pci/pcie/edr.c              | 251 ++++++++++++++++++++++++++++
 drivers/pci/pcie/err.c              |  26 +--
 drivers/pci/pcie/portdrv.h          |   5 -
 drivers/pci/pcie/portdrv_core.c     |  21 ---
 drivers/pci/probe.c                 |   2 +
 include/linux/acpi.h                |   6 +-
 include/linux/aer.h                 |   5 -
 include/linux/pci-acpi.h            |   8 +
 include/linux/pci.h                 |   1 +
 17 files changed, 389 insertions(+), 88 deletions(-)
 create mode 100644 drivers/pci/pcie/edr.c

-- 
2.25.1

