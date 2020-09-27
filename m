Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FDA279E70
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 07:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgI0Faj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 01:30:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:23634 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730325AbgI0Fad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 01:30:33 -0400
IronPort-SDR: kz45VRzIvB/Yz+d0VE8vuWrubWlo/cubvB5VTu3F78PSblpVeaFqKhNvw+YFL55MOT0q9M2BxF
 ag5Yxxs3G8ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="225993145"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="225993145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 22:30:33 -0700
IronPort-SDR: wAmf8ckV5LcAVkHc6U//N7Z1GbAd4QYDLQ8AtknV2w5/bvFaeazLbdmuLnTb2+89YEZaZaBdkC
 yy7jwAlDxNgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="323909418"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2020 22:30:29 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com,
        Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 5/5 V3] PCI/ERR: don't mix io state not changed and no driver together
Date:   Sun, 27 Sep 2020 01:28:41 -0400
Message-Id: <20200927052841.12629-6-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200927052841.12629-1-haifeng.zhao@intel.com>
References: <20200927052841.12629-1-haifeng.zhao@intel.com>
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
 V2: no change.
 V3: no change.

 drivers/pci/pcie/err.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index e35c4480c86b..d85f27c90c26 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -55,8 +55,10 @@ static int report_error_detected(struct pci_dev *dev,
 	if (!pci_dev_get(dev))
 		return 0;
 	device_lock(&dev->dev);
-	if (!pci_dev_set_io_state(dev, state) ||
-		!dev->driver ||
+	if (!pci_dev_set_io_state(dev, state)) {
+		pci_dbg(dev, "Device might already being in error handling ...\n");
+		vote = PCI_ERS_RESULT_NONE;
+	} else if (!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->error_detected) {
 		/*
-- 
2.18.4

