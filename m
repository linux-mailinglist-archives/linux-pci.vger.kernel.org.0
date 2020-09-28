Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F152027A61C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 06:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1EIs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 00:08:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:30290 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1EIm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 00:08:42 -0400
IronPort-SDR: t+7kTvOuo+TrI/9zmbf/PYWT0jmqNoLlv+z28RFj29cbv0+ZlhGzAw43UvXkkEPgSEIjInaQuY
 j6m2LNAupZlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149710901"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="149710901"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 21:08:41 -0700
IronPort-SDR: p8KvPyKGQSZM5hr74cP0clr+WzHemPj7g9nkcoIqQ09zkuftqdi7829iElGmIQwo1QTi5orxNk
 1g9j8j8vMZWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="311628179"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2020 21:08:38 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com,
        Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 5/5 V5] PCI/ERR: don't mix io state not changed and no driver together
Date:   Mon, 28 Sep 2020 00:06:51 -0400
Message-Id: <20200928040651.24937-6-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200928040651.24937-1-haifeng.zhao@intel.com>
References: <20200928040651.24937-1-haifeng.zhao@intel.com>
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
 V5: no change.

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

