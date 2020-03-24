Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A9E1902D4
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCXA0W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:60458 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgCXA0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:22 -0400
IronPort-SDR: Vh3v2exNl6M6bXASomNUZf/2It3WlNC1bKl8cW7aba89cSdr/6TJRItwY+iH1IlCHuC/6ed9jP
 +bSfeYlXf+Sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:21 -0700
IronPort-SDR: Jh+d14pK9tDspIaPPB34O5MMMBQTxORGwkxLNoN2KnZz3bl1E4F5/m1SAXg1MrxJc2xk2Rxkjg
 MdokOj0FSHRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692222"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:20 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 00/11] Add Error Disconnect Recover (EDR) support
Date:   Mon, 23 Mar 2020 17:25:57 -0700
Message-Id: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
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

Changes since v17 + Bjorns changes:
 * This version is based on Bjorn's review/edr branch.
 * Moved {pciehp,shpchp}_is_native() function definitions to pci.c and
   removed it's CONFIG_ACPI dependency.
 * Modified dpc_reset_link() function to return PCI_ERS_RESULT_NEED_RESET
   when hotplug is not supported or enabled in kernel.
 * Modified reset_link() function to handle PCI_ERS_RESULT_NEED_RESET as
   valid return value.
 * Moved the implementation of reset_link() function to pcie_do_recovery()
   and renamed function callback parameter from reset_cb to reset_link.
 * Moved the order of pci_acpi_add_edr_notifier() and
   pci_acpi_remove_edr_notifier() calls in pci_acpi_setup() and
   pci_acpi_cleanup() above wakeup capable support checks.
 * Used acpi_check_dsm() to check whether given _DSM is supported or
   not in edr.c.

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

Bjorn Helgaas (1):
  PCI/DPC: Move DPC data into struct pci_dev

Kuppuswamy Sathyanarayanan (10):
  PCI/ERR: Update error status after reset_link()
  PCI: move {pciehp,shpchp}_is_native() definitions to pci.c
  PCI/DPC: Fix DPC recovery issue in non hotplug case
  PCI/ERR: Remove service dependency in pcie_do_recovery()
  PCI/ERR: Return status of pcie_do_recovery()
  PCI/DPC: Cache DPC capabilities in pci_init_capabilities()
  PCI/AER: Add pci_aer_raw_clear_status() to unconditionally clear Error
    Status
  PCI/DPC: Expose dpc_process_error(), dpc_reset_link() for use by EDR
  PCI/DPC: Add Error Disconnect Recover (EDR) support
  PCI/AER: Rationalize error status register clearing

 Documentation/PCI/pcieaer-howto.rst       |  23 +-
 drivers/acpi/pci_root.c                   |  15 ++
 drivers/net/ethernet/intel/ice/ice_main.c |   4 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c           |   4 +-
 drivers/pci/pci-acpi.c                    |  40 +---
 drivers/pci/pci.c                         |  40 +++-
 drivers/pci/pci.h                         |  13 +-
 drivers/pci/pcie/Kconfig                  |  10 +
 drivers/pci/pcie/Makefile                 |   1 +
 drivers/pci/pcie/aer.c                    |  40 ++--
 drivers/pci/pcie/dpc.c                    | 145 ++++++-------
 drivers/pci/pcie/edr.c                    | 251 ++++++++++++++++++++++
 drivers/pci/pcie/err.c                    |  67 ++----
 drivers/pci/pcie/portdrv.h                |   5 -
 drivers/pci/pcie/portdrv_core.c           |  21 --
 drivers/pci/probe.c                       |   2 +
 drivers/scsi/lpfc/lpfc_attr.c             |   4 +-
 include/linux/acpi.h                      |   6 +-
 include/linux/aer.h                       |   9 +-
 include/linux/pci-acpi.h                  |   8 +
 include/linux/pci.h                       |   6 +
 include/linux/pci_hotplug.h               |   7 +-
 22 files changed, 471 insertions(+), 250 deletions(-)
 create mode 100644 drivers/pci/pcie/edr.c

-- 
2.17.1

