Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA00285E32
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgJGLdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 07:33:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:24771 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgJGLdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 07:33:49 -0400
IronPort-SDR: FKX8RpaFiJnnC9mekK5tAtiyYqTVbhVnfJJGpj5KcmwPvz4Y3uBG+mxJGG1thoaHHp3zwGpDiN
 VGWNoetE/pmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226492589"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="226492589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 04:33:48 -0700
IronPort-SDR: 7KLHxxLDY6xmAzbLRIFPSBEx6TDN7qXbBiWSdczuzYGDVSX6Fn3qttxZ+0p04sYkbFSWJlkyqW
 qFakeqtkFOfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="354862200"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 04:33:45 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v8 6/6] PCI/ERR: don't mix io state not changed and no driver together
Date:   Wed,  7 Oct 2020 07:31:58 -0400
Message-Id: <20201007113158.48933-7-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201007113158.48933-1-haifeng.zhao@intel.com>
References: <20201007113158.48933-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When we see 'can't recover (no error_detected callback)' on console,
Maybe the reason is io state is not changed by calling
pci_dev_set_io_state(), that is confused. fix it.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
Tested-by: Wen Jin <wen.jin@intel.com>
Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
---
Chagnes:
 v2: no change.
 v3: no change.
 v4: no change.
 v5: no change.
 v6: no change.
 v7: change debug output information.
 v8: no change.

 drivers/pci/pcie/err.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index e35c4480c86b..2ca2723f3b34 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -55,8 +55,10 @@ static int report_error_detected(struct pci_dev *dev,
 	if (!pci_dev_get(dev))
 		return 0;
 	device_lock(&dev->dev);
-	if (!pci_dev_set_io_state(dev, state) ||
-		!dev->driver ||
+	if (!pci_dev_set_io_state(dev, state)) {
+		pci_dbg(dev, "Device was in that state or not allowed setting.\n");
+		vote = PCI_ERS_RESULT_NONE;
+	} else if (!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->error_detected) {
 		/*
-- 
2.18.4

