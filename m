Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF27742D16
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391582AbfFLRKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 13:10:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:44951 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391554AbfFLRKz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 13:10:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 10:10:54 -0700
X-ExtLoop1: 1
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2019 10:10:54 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, mike.campin@intel.com
Subject: [PATCH v2 1/1] PCI/IOV: Fix incorrect cfg_size for VF > 0
Date:   Wed, 12 Jun 2019 10:06:47 -0700
Message-Id: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
other VFs") calculates and caches the cfg_size for VF0 device before
initializing the pcie_cap of the device which results in using incorrect
cfg_size for all VF devices > 0. So set pcie_cap of the device before
calculating the cfg_size of VF0 device.

Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
other VFs")
Cc: Ashok Raj <ashok.raj@intel.com>
Suggested-by: Mike Campin <mike.campin@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Fixed a typo in commit message.

 drivers/pci/iov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 3aa115ed3a65..2869011c0e35 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -160,6 +160,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	virtfn->device = iov->vf_device;
 	virtfn->is_virtfn = 1;
 	virtfn->physfn = pci_dev_get(dev);
+	virtfn->pcie_cap = pci_find_capability(virtfn, PCI_CAP_ID_EXP);
 
 	if (id == 0)
 		pci_read_vf_config_common(virtfn);
-- 
2.21.0

