Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484D71E0328
	for <lists+linux-pci@lfdr.de>; Sun, 24 May 2020 23:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbgEXVch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 17:32:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:9322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387879AbgEXVch (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 May 2020 17:32:37 -0400
IronPort-SDR: na2+GEy23Z5Gox2iXhiBQMNfbE4TzcQ/hKgP5rgjGx4sOlGXH2gfNIJq3ynzBJqZruwY1XwN3V
 tZefYBCvc/lA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 14:32:36 -0700
IronPort-SDR: qR8Zd6uw2Bo9zc/Ed0jd5J4jCriPSU00TYJUCnLgroXBsTZ8rBXw1UiZg6P+ldwn6Ab++4h16C
 oaDgIqY2Fhpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="467875383"
Received: from tjrondo-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.251.20.235])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2020 14:32:36 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 0/5] Remove AER HEST table parser
Date:   Sun, 24 May 2020 14:32:29 -0700
Message-Id: <cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Commit c100beb9ccfb ("PCI/AER: Use only _OSC to determine AER ownership")
removed HEST dependency in determining the AER ownership status. The
following patch set cleansup rest of the HEST table related code from
AER driver.

This patchset also includes some minor AER driver fixes.

Changes since v2:
 * Fixed commit sha id for patch "PCI/AER: Use only _OSC to determine AER ownership".

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

