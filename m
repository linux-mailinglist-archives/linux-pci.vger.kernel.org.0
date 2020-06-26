Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB620B84C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 20:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFZScw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 14:32:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:60445 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFZScv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jun 2020 14:32:51 -0400
IronPort-SDR: fL6CS7rjFh2umksZiALJs9GJehQukSyFRQeaJZYBv0yrN2iUBAJbH2glc6grdl9SzSNXheu1I8
 RRIkfXolfuXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210514063"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210514063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:32:46 -0700
IronPort-SDR: YfvNbgFMAQDzCl3W1f6x63w5UzHdZWJ4/ZS6eGnDUoaNmE/VH8LYzee0ZwamYh7u2aArS/qLFX
 keMTxT7d+Qjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="302409940"
Received: from mwhender-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.77.50])
  by orsmga007.jf.intel.com with ESMTP; 26 Jun 2020 11:32:46 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 0/4] Simplify PCIe native ownership detection logic
Date:   Fri, 26 Jun 2020 11:32:32 -0700
Message-Id: <cover.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, PCIe capabilities ownership status is detected by
verifying the status of pcie_ports_native, pcie_ports_dpc_native
and _OSC negotiated results (cached in  struct pci_host_bridge
->native_* members). But this logic can be simplified, and we can
use only struct pci_host_bridge ->native_* members to detect it. 

This patchset removes the distributed checks for pcie_ports_native,
pcie_ports_dpc_native parameters.

Changes since v5:
 * Rebased on top of v5.8-rc1

Changes since v4:
 * Changed the patch set title (Original link: https://lkml.org/lkml/2020/5/26/1710)
 * Added AER/DPC dependency logic cleanup fixes.
 
Kuppuswamy Sathyanarayanan (4):
  ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
  ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native
    is set.
  PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable
    logic
  PCI/DPC: Move AER/DPC dependency checks out of DPC driver

 drivers/acpi/pci_root.c           | 28 ++++++++++++++++------------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 ---
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/dpc.c            |  4 +---
 drivers/pci/pcie/portdrv.h        |  2 --
 drivers/pci/pcie/portdrv_core.c   | 13 +++++--------
 drivers/pci/probe.c               |  5 +++--
 include/linux/pci.h               |  2 ++
 9 files changed, 29 insertions(+), 32 deletions(-)

-- 
2.17.1

