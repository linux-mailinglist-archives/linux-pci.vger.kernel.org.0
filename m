Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B61F0CDD
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jun 2020 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgFGQUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 12:20:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:61715 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgFGQUO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Jun 2020 12:20:14 -0400
IronPort-SDR: Iva6gbObgxqcby4FTdFc02/1aehU7EQ+YiATXo3mjEKeFcqi3dXVnTeGrIVHE0vJXZ+aRdnOIz
 ZMB1rNmWO46w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 09:20:13 -0700
IronPort-SDR: A7erMCZuHEnPqeujE87ppx7rXtJlpuBRT+JasZ/RmTtBeqtpNtWo/rE+nJ5AalzbUdO03yMJOE
 qSGl+twnhMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,484,1583222400"; 
   d="scan'208";a="348938488"
Received: from skaushal-mobl5.gar.corp.intel.com (HELO localhost.localdomain) ([10.255.229.193])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2020 09:20:13 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 0/4] Simplify PCIe native ownership detection logic
Date:   Sun,  7 Jun 2020 09:19:57 -0700
Message-Id: <cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/pci/probe.c               |  4 +++-
 include/linux/pci.h               |  2 ++
 9 files changed, 29 insertions(+), 31 deletions(-)

-- 
2.17.1

