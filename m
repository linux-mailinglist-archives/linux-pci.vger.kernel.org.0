Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAC9F1A6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfH0Rcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 13:32:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:62462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730448AbfH0Rcn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 13:32:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 10:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="171269783"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2019 10:32:38 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v8 0/8] Add Error Disconnect Recover (EDR) support
Date:   Tue, 27 Aug 2019 10:29:22 -0700
Message-Id: <cover.1566865502.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

 drivers/acpi/pci_root.c         |   9 ++
 drivers/pci/pci-acpi.c          |  91 +++++++++++++++
 drivers/pci/pcie/Kconfig        |  10 ++
 drivers/pci/pcie/aer.c          |  12 +-
 drivers/pci/pcie/dpc.c          | 194 +++++++++++++++++++++++++++++---
 drivers/pci/pcie/err.c          |  10 +-
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/probe.c             |   1 +
 include/linux/acpi.h            |   6 +-
 include/linux/pci-acpi.h        |  11 ++
 include/linux/pci.h             |   3 +-
 11 files changed, 321 insertions(+), 34 deletions(-)

-- 
2.21.0

