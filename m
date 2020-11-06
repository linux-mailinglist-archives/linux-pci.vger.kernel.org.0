Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED02A8B4F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 01:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbgKFAPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 19:15:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:23004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732804AbgKFAPL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 19:15:11 -0500
IronPort-SDR: sMSKZ4aXalTgHTyfK0Qh5z47Y83wir0buEIKvL4jN5ad1R6oWObgDfSXsj9nHbxg+z69vWt5L/
 tzRmH1Fh879g==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="148759535"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="148759535"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:11 -0800
IronPort-SDR: I7D9R71uEAylk8Nx6awjPWXH1rTJNIxprgWx+evfv6b7y/bm+Fb519NXafTMeud2BDUeQC3FLk
 NUptICr8nGsg==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="529621713"
Received: from gabriels-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.209.37.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:11 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v10 06/16] PCI/ERR: Simplify by using pci_upstream_bridge()
Date:   Thu,  5 Nov 2020 16:14:34 -0800
Message-Id: <20201106001444.667232-7-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201106001444.667232-1-sean.v.kelley@intel.com>
References: <20201106001444.667232-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_upstream_bridge() in place of dev->bus->self.  No functional change
intended.

[bhelgaas: split to separate patch]
Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index db149c6ce4fb..05f61da5ed9d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -159,7 +159,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 */
 	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
-		dev = dev->bus->self;
+		dev = pci_upstream_bridge(dev);
 	bus = dev->subordinate;
 
 	pci_dbg(dev, "broadcast error_detected message\n");
-- 
2.29.2

