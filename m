Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F491561C8
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBHAGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:06:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:55817 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbgBHAGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:06:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:06:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="250596577"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga002.jf.intel.com with ESMTP; 07 Feb 2020 16:06:05 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v14 0/5] Add Error Disconnect Recover (EDR) support
Date:   Fri,  7 Feb 2020 16:03:30 -0800
Message-Id: <cover.1581119844.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Kuppuswamy Sathyanarayanan (5):
  PCI/ERR: Update error status after reset_link()
  PCI/DPC: Remove pcie_device reference from dpc_dev structure
  PCI/EDR: Export AER, DPC and error recovery functions
  PCI/DPC: Add Error Disconnect Recover (EDR) support
  PCI/ACPI: Enable EDR support

 drivers/acpi/pci_root.c   |  16 +++
 drivers/pci/pci-acpi.c    |   3 +
 drivers/pci/pci.h         |   8 ++
 drivers/pci/pcie/Kconfig  |  10 ++
 drivers/pci/pcie/Makefile |   1 +
 drivers/pci/pcie/aer.c    |  39 ++++--
 drivers/pci/pcie/dpc.c    |  92 ++++++++------
 drivers/pci/pcie/dpc.h    |  20 +++
 drivers/pci/pcie/edr.c    | 259 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/err.c    |  35 ++++--
 drivers/pci/probe.c       |   1 +
 include/linux/acpi.h      |   6 +-
 include/linux/pci-acpi.h  |   8 ++
 include/linux/pci.h       |   1 +
 14 files changed, 441 insertions(+), 58 deletions(-)
 create mode 100644 drivers/pci/pcie/dpc.h
 create mode 100644 drivers/pci/pcie/edr.c

-- 
2.21.0

