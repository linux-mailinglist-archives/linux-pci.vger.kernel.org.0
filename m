Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6920E1E0303
	for <lists+linux-pci@lfdr.de>; Sun, 24 May 2020 23:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbgEXV2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 17:28:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:34175 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388210AbgEXV2M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 May 2020 17:28:12 -0400
IronPort-SDR: 5fl8YizSDrRhg+mIhDSID7XJcjyAdd/FPndifGl2ou01LhZ1CPj+oc+Cz3Kaut7Vg/NZzgOIgI
 3FgCBG+Ik0Lw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 14:28:11 -0700
IronPort-SDR: FzsUfGIz+lqZEULJSpFqMqJe8JUbf9mKPUQm7T9ujv4sDhR+uEKLkUHXkcF5b8Rg1AcDn1tkXN
 h5HFE4QU2oSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="254928533"
Received: from tjrondo-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.251.20.235])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2020 14:28:06 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 0/5] Remove AER HEST table parser
Date:   Sun, 24 May 2020 14:27:51 -0700
Message-Id: <cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Commit e7909188dd4d ("PCI/AER: Use only _OSC to determine AER ownership")
removed HEST dependency in determining the AER ownership status. The
following patch set cleansup rest of the HEST table related code from
AER driver.

This patchset also includes some minor AER driver fixes.

Kuppuswamy Sathyanarayanan (5):
  PCI/AER: Remove redundant pci_is_pcie() checks.
  PCI/AER: Remove redundant dev->aer_cap checks.
  ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
  ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native
    is set.
  PCI/AER: Replace pcie_aer_get_firmware_first() with
    pcie_aer_is_native()

 drivers/acpi/pci_root.c    |  28 ++++----
 drivers/pci/pcie/aer.c     | 139 ++++---------------------------------
 drivers/pci/pcie/dpc.c     |   2 +-
 drivers/pci/pcie/portdrv.h |  13 +---
 include/linux/pci.h        |   2 +
 5 files changed, 34 insertions(+), 150 deletions(-)

-- 
2.17.1

