Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912A5A0D5F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 00:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfH1WSG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 18:18:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:11611 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfH1WSG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 18:18:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 15:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="197662402"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2019 15:18:05 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v7 0/7] Fix PF/VF dependency issue
Date:   Wed, 28 Aug 2019 15:14:00 -0700
Message-Id: <cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Current implementation of ATS, PASID, PRI does not handle VF dependencies
correctly. Following patches addresses this issue.

Changes since v6:
 * Removed locking interfaces used in v6.
 * Made necessary changes to PRI/PASID enable/disable calls to allow
   register changes only for PF.

Changes since v5:
 * Created new patches for PRI/PASID capability caching.
 * Removed individual locks (pri_lock, pasid_lock) and added common
   resource lock to synchronize PRI/PASID updates between PF/VF.
 * Addressed comments from Bjorn Helgaas.

Changes since v4:
 * Defined empty functions for pci_pri_init() and pci_pasid_init() for cases
   where CONFIG_PCI_PRI and CONFIG_PCI_PASID are not enabled.

Changes since v3:
 * Fixed critical path (lock context) in pci_restore_*_state functions.

Changes since v2:
 * Added locking mechanism to synchronize accessing PF registers in VF.
 * Removed spec compliance checks in patches.
 * Addressed comments from Bjorn Helgaas.

Changes since v1:
 * Added more details about the patches in commit log.
 * Removed bulk spec check patch.
 * Addressed comments from Bjorn Helgaas.

Kuppuswamy Sathyanarayanan (7):
  PCI/ATS: Fix pci_prg_resp_pasid_required() dependency issues
  PCI/ATS: Cache PRI capability check result
  PCI/ATS: Cache PASID capability check result
  PCI/ATS: Add PRI support for PCIe VF devices
  PCI/ATS: Add PASID support for PCIe VF devices
  PCI/ATS: Disable PF/VF ATS service independently
  PCI: Skip Enhanced Allocation (EA) initialization for VF device

 drivers/pci/ats.c       | 202 ++++++++++++++++++++++++++++------------
 drivers/pci/pci.c       |   7 ++
 include/linux/pci-ats.h |  12 ++-
 include/linux/pci.h     |   3 +-
 4 files changed, 159 insertions(+), 65 deletions(-)

-- 
2.21.0

