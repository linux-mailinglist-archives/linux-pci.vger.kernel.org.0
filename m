Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D245ED8B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCUcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 16:32:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:7617 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCUcO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 16:32:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158089378"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:32:12 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 0/8] Add Error Disconnect Recover (EDR) support
Date:   Wed,  3 Jul 2019 13:29:47 -0700
Message-Id: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v1:
 * Rebased on top of v5.1-rc1

Changes since v2:
 * Split EDR support patch into multiple patches.
 * Addressed Bjorn comments.

Changes since v3:
 * Moved EDR related ACPI functions/definitions to pci-acpi.c
 * Modified commit history in few patches to include spec reference.
 * Added support to handle DPC triggered by NON_FATAL errors.
 * Added edr_lock to protect PCI device receiving duplicate EDR notifications.
 * Addressed Bjorn comments.

Kuppuswamy Sathyanarayanan (8):
  PCI/ACPI: Add _OSC based negotiation support for DPC
  PCI/ACPI: Expose EDR support via _OSC to BIOS
  PCI/DPC: Allow dpc_probe() even if firmware first mode is enabled
  PCI/DPC: Add dpc_process_error() wrapper function
  PCI/DPC: Add Error Disconnect Recover (EDR) support
  PCI/AER: Allow clearing Error Status Register in FF mode
  PCI/DPC: Add support for DPC recovery on NON_FATAL errors
  PCI/DPC: Clear AER registers in EDR mode

 drivers/acpi/pci_root.c         |   9 ++
 drivers/pci/pci-acpi.c          |  91 +++++++++++++++
 drivers/pci/pcie/Kconfig        |  10 ++
 drivers/pci/pcie/aer.c          |   9 --
 drivers/pci/pcie/dpc.c          | 200 +++++++++++++++++++++++++++++---
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/probe.c             |   1 +
 include/linux/acpi.h            |   4 +-
 include/linux/pci-acpi.h        |  11 ++
 include/linux/pci.h             |   1 +
 10 files changed, 314 insertions(+), 30 deletions(-)

-- 
2.21.0

