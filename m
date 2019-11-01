Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E299ECC0B
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2019 00:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKAX7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 19:59:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:63645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKAX7O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 19:59:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 16:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="scan'208";a="199469567"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga008.fm.intel.com with ESMTP; 01 Nov 2019 16:59:14 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v10 0/8] Add Error Disconnect Recover (EDR) support
Date:   Fri,  1 Nov 2019 16:56:48 -0700
Message-Id: <cover.1572652041.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/pci/pci-acpi.c                    |  95 ++++++++++
 drivers/pci/pci.c                         |   2 +-
 drivers/pci/pci.h                         |   2 +-
 drivers/pci/pcie/Kconfig                  |  10 +
 drivers/pci/pcie/aer.c                    |  16 +-
 drivers/pci/pcie/dpc.c                    | 215 ++++++++++++++++++++--
 drivers/pci/pcie/err.c                    |  12 +-
 drivers/pci/pcie/portdrv_core.c           |   8 +-
 drivers/pci/probe.c                       |   1 +
 drivers/scsi/lpfc/lpfc_attr.c             |   2 +-
 include/linux/acpi.h                      |   6 +-
 include/linux/aer.h                       |  12 +-
 include/linux/pci-acpi.h                  |  11 ++
 include/linux/pci.h                       |   3 +-
 18 files changed, 365 insertions(+), 45 deletions(-)

-- 
2.21.0

