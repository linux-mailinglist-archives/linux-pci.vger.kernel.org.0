Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C838E2241AF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGQRX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 13:23:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:31672 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQRX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 13:23:58 -0400
IronPort-SDR: OFJYXlogb16ppUjs+TWCd4zaVul4KDClaGU94Wzx76H7+iItvmg1s3uwEOEG9y4JzARD8Nx4ML
 wPPVfBtyg7zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="214353102"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="214353102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 10:23:58 -0700
IronPort-SDR: iNR3F7qJMOwhGnwPv1O/kG6/t0nbXlYXsmGroekpGUfA8s1LLmDdbRa/36RwTUKfoLjmR67igH
 SjTMJWL0/2pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="282846749"
Received: from jmharral-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.77.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2020 10:23:57 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v7 0/5] Simplify PCIe native ownership detection logic
Date:   Fri, 17 Jul 2020 10:23:45 -0700
Message-Id: <cover.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

 drivers/acpi/pci_root.c           | 62 ++++++++++++++++++++++++++-----
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 --
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/dpc.c            |  4 +-
 drivers/pci/pcie/portdrv.h        |  2 -
 drivers/pci/pcie/portdrv_core.c   | 13 +++----
 drivers/pci/probe.c               |  4 +-
 include/linux/pci.h               |  2 +
 9 files changed, 65 insertions(+), 29 deletions(-)

-- 
2.17.1

