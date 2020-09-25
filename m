Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98D0277E07
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 04:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIYCku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 22:40:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:60724 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgIYCku (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 22:40:50 -0400
IronPort-SDR: gGhkLgHy7JwBe9rH1gVdYeuhZRWP9RzTPzH1850yXJTsGLwmuphn+C6xGBksPaMR3DEOo1pKxf
 W0gJdkpOyrMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141431851"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="141431851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 19:36:01 -0700
IronPort-SDR: ufkFF0YDpCuSDDBlyTqSVBAAm7yWx6S9ZOhe0VJvulU99hgn3Gmvwk1LGM9R8HGeeRxsn3QZ2R
 2H5ENX9XXrDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="512515344"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2020 19:35:58 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 5/5] PCI/ERR: don't mix io state not changed and no driver together
Date:   Thu, 24 Sep 2020 22:34:23 -0400
Message-Id: <20200925023423.42675-6-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200925023423.42675-1-haifeng.zhao@intel.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When we see 'can't recover (no error_detected callback)' on console,
Maybe the reason is io state is not changed by calling
pci_dev_set_io_state(), that is confused. fix it.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
Tested-by: Wen jin <wen.jin@intel.com>
Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
---
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

