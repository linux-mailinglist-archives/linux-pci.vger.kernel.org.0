Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D931C90BA3
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2019 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfHQANY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 20:13:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:12917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfHQANX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="168194997"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 17:13:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 0/8] Fix PF/VF dependency issue
Date:   Fri, 16 Aug 2019 17:10:14 -0700
Message-Id: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Kuppuswamy Sathyanarayanan (8):
  PCI/ATS: Fix pci_prg_resp_pasid_required() dependency issues
  PCI/ATS: Cache PRI capability check result
  PCI/ATS: Cache PASID capability check result
  PCI/IOV: Add pci_physfn_reslock/unlock() interfaces
  PCI/ATS: Add PRI support for PCIe VF devices
  PCI/ATS: Add PASID support for PCIe VF devices
  PCI/ATS: Disable PF/VF ATS service independently
  PCI: Skip Enhanced Allocation (EA) initialization for VF device

 drivers/pci/ats.c       | 276 +++++++++++++++++++++++++++++-----------
 drivers/pci/iov.c       |   1 +
 drivers/pci/pci.c       |   7 +
 drivers/pci/pci.h       |  40 ++++++
 include/linux/pci-ats.h |  12 +-
 include/linux/pci.h     |   5 +-
 6 files changed, 260 insertions(+), 81 deletions(-)

-- 
2.21.0

