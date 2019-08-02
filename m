Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AABD7E701
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 02:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfHBAIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 20:08:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:59856 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfHBAIq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Aug 2019 20:08:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 17:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,336,1559545200"; 
   d="scan'208";a="177993956"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2019 17:08:44 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 0/7] Fix PF/VF dependency issue
Date:   Thu,  1 Aug 2019 17:05:57 -0700
Message-Id: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
  PCI/ATS: Initialize PRI in pci_ats_init()
  PCI/ATS: Initialize PASID in pci_ats_init()
  PCI/ATS: Add PRI support for PCIe VF devices
  PCI/ATS: Add PASID support for PCIe VF devices
  PCI/ATS: Disable PF/VF ATS service independently
  PCI: Skip Enhanced Allocation (EA) initialization for VF device

 drivers/pci/ats.c       | 373 ++++++++++++++++++++++++++++++----------
 drivers/pci/pci.c       |   7 +
 include/linux/pci-ats.h |  22 ++-
 include/linux/pci.h     |   7 +-
 4 files changed, 315 insertions(+), 94 deletions(-)

-- 
2.21.0

