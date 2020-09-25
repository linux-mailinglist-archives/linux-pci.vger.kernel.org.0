Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4B277E04
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 04:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIYCku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 22:40:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:60724 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIYCku (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 22:40:50 -0400
IronPort-SDR: iYjanzg5yvkkTDMkg2EMsOFOBOpOEyQ/vxriGv2afsM7qrKlfcAmEsoKVk0Tc3e9eRam+Cms2s
 PQuxDUxz24Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141431845"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="141431845"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 19:35:58 -0700
IronPort-SDR: edQLed7J+7Et0h2PLwHieV0s0QzFTiRjxkPWU1Y571lz/hcfhCCNF4dB5mgNHCb3klmchnXBSo
 yLaHmH6kYifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="512515330"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2020 19:35:55 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 4/5] PCI: only return true when dev io state is really changed
Date:   Thu, 24 Sep 2020 22:34:22 -0400
Message-Id: <20200925023423.42675-5-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200925023423.42675-1-haifeng.zhao@intel.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When uncorrectable error happens, AER driver and DPC driver interrupt
handlers likely call
   pcie_do_recovery()->pci_walk_bus()->report_frozen_detected() with
pci_channel_io_frozen the same time.
   If pci_dev_set_io_state() return true even if the original state is
pci_channel_io_frozen, that will cause AER or DPC handler re-enter
the error detecting and recovery procedure one after another.
   The result is the recovery flow mixed between AER and DPC.
So simplify the pci_dev_set_io_state() function to only return true
when dev->error_state is changed.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
Tested-by: Wen jin <wen.jin@intel.com>
Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
---
 drivers/pci/pci.h | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..d420bb977f3b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -362,35 +362,10 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 	bool changed = false;
 
 	device_lock_assert(&dev->dev);
-	switch (new) {
-	case pci_channel_io_perm_failure:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-		case pci_channel_io_perm_failure:
-			changed = true;
-			break;
-		}
-		break;
-	case pci_channel_io_frozen:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-			changed = true;
-			break;
-		}
-		break;
-	case pci_channel_io_normal:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-			changed = true;
-			break;
-		}
-		break;
-	}
-	if (changed)
+	if (dev->error_state != new) {
 		dev->error_state = new;
+		changed = true;
+	}
 	return changed;
 }
 
-- 
2.18.4

