Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6322F279FAA
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgI0I3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 04:29:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:31488 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730585AbgI0I3e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 04:29:34 -0400
IronPort-SDR: aGacv/YwZE/Wi8/iVAOjDn78s9ds72acb2CKU/qDFzAo+Ejj3lqhIA9BgJRksyI0FDUm+AXbce
 j2lOjmDHl1ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="161912226"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="161912226"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 01:29:34 -0700
IronPort-SDR: 40aHObQAnplGBnYqAfIAN3SuQU5CaBFREZ3wHS83PY0KCkuXEjpQpS4wrnGDOrMkuUmwO3uFOe
 fXFa5J8+3/Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="456437758"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2020 01:29:30 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com, hch@infradead.org,
        joe@perches.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 5/5 V4] PCI/ERR: don't mix io state not changed and no driver together
Date:   Sun, 27 Sep 2020 04:27:36 -0400
Message-Id: <20200927082736.14633-6-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200927082736.14633-1-haifeng.zhao@intel.com>
References: <20200927082736.14633-1-haifeng.zhao@intel.com>
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
 V4: no change.

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

