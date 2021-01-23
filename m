Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C840E3011E8
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jan 2021 02:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbhAWBQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 20:16:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:26863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbhAWBQD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 20:16:03 -0500
IronPort-SDR: BBT4I6a6o8su3JlSOcJFJDu3YPkMqYC1SRd96Zvur3qOXH1u8jXIRkMq3sLCiYk59GPIvWvMio
 FJCGOVTblFqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="176962173"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="176962173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:20 -0800
IronPort-SDR: I1QdyjMVMsE07R9pya9Y/gl4ub+rWu5kkiaW1KaPtY/oTQTHU8PHBtTFaEXSLTphYJEN9ytThl
 Pj9ngkKRDTDA==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="386084669"
Received: from usundar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.36.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:19 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v13 0/5] Simplify PCIe native ownership
Date:   Fri, 22 Jan 2021 17:11:08 -0800
Message-Id: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, PCIe capabilities ownership status is detected by
verifying the status of pcie_ports_native, and _OSC negotiated
results (cached in  struct pci_host_bridge->native_* members).
But this logic can be simplified, and we can use only struct
pci_host_bridge ->native_* members to detect it. 

This patchset removes the distributed checks for pcie_ports_native,
parameter.

Changes since v12:
 * Rebased on top of v5.11-rc1

Changes since v11 (Bjorns update):
 * Add bugfix for DPC with no AER Capability
 * Split OSC_OWNER trivial changes from pcie_ports_native changes
 * Temporarily drop pcie_ports_dpc_native changes (revisit it later).

Changes since v10:
 * Addressed format issue reported by lkp test.

Changes since v9:
 * Rebased on top of v5.10-rc1

Changes since v8:
 * Simplified setting _OSC ownwership logic
 * Moved bridge->native_ltr out of #ifdef CONFIG_PCIEPORTBUS.

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

Bjorn Helgaas (2):
  PCI/DPC: Ignore devices with no AER Capability
  PCI/ACPI: Centralize pci_aer_available() checking

Kuppuswamy Sathyanarayanan (3):
  PCI: Assume control of portdrv-related features only when portdrv
    enabled
  PCI/ACPI: Tidy _OSC control bit checking
  PCI/ACPI: Centralize pcie_ports_native checking

 drivers/acpi/pci_root.c           | 49 ++++++++++++++++++++++++-------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 --
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/dpc.c            |  3 ++
 drivers/pci/pcie/portdrv_core.c   | 11 +++----
 drivers/pci/probe.c               |  6 ++--
 7 files changed, 51 insertions(+), 25 deletions(-)

-- 
2.25.1

