Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005E922D484
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 05:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgGYD7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 23:59:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:58730 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGYD7I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 23:59:08 -0400
IronPort-SDR: N4GUVqHj81yaOUxG35L7UAXLRmUqPs54hvliehFNCknBjpRlFoI4k2fockfRIDJLZjdpTt0qos
 Bia+jg6gcHbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="212351098"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="212351098"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 20:59:07 -0700
IronPort-SDR: xxjCFDb5zyteuSxxQfPiVGSiK8PEF514if5dVsa9cnQuqJyooLSwnj1EQOu8sMkFSU289FwtsV
 WlcVjm4yhYrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="489405375"
Received: from pittner-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.77.166])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2020 20:59:07 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v8 0/5] Simplify PCIe native ownership detection logic
Date:   Fri, 24 Jul 2020 20:58:51 -0700
Message-Id: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

 drivers/acpi/pci_root.c           | 61 ++++++++++++++++++++++++++-----
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 --
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/dpc.c            |  4 +-
 drivers/pci/pcie/portdrv.h        |  2 -
 drivers/pci/pcie/portdrv_core.c   | 13 +++----
 drivers/pci/probe.c               |  4 +-
 include/linux/pci.h               |  2 +
 9 files changed, 64 insertions(+), 29 deletions(-)

-- 
2.17.1

