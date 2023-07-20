Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296D475ABF0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGTK3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjGTK3a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 06:29:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5D010F5;
        Thu, 20 Jul 2023 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689848969; x=1721384969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fen2UrZQEWJMxifw6fHPovr8FrzHe3MUWivgyT/3EZU=;
  b=A+wRCNmy1JmGIuJTK3/8jeR6vqIr7zWSCB4olY4aHSiF7YKwT938+SNW
   qLYz2jQmC8rPfA4gusOR9G6sJZnCVCMxDxHLiiBqRqhwYe1chAPuYJKch
   5Bzyhx6R0MRM58eWPH92AZVfXWLeAJqRJLIbE0nZt9SFmU12f80FC512A
   pTqVVP/hj+OPP4amwCD0OeYdi6SDA577UkcUMx1sLn50JGPSQpmJT5jXE
   tyi+T9TBzC+G7raJ+NtLIJ10Em2AMqNLidh1kakU3zBQ2M6GNtbPPbMKy
   lGutKTKKBDA1UBlaCSPfcDmYjURmwnWKa0Ks4iWOvMSYUrbcvq3ijtU5T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370261369"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="370261369"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="727636710"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="727636710"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:29:27 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/2] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
Date:   Thu, 20 Jul 2023 10:28:59 +0000
Message-Id: <20230720102859.2985655-3-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
References: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
Controller to pci_ids.h for its serial and parallel port driver
support in subsequent patches.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/can/sja1000/ems_pci.c | 6 +-----
 include/linux/pci_ids.h           | 4 ++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 3e18c63a982c..1aaedaf866f1 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -108,10 +108,6 @@ struct ems_pci_card {
 
 #define EMS_PCI_BASE_SIZE  4096 /* size of controller area */
 
-#ifndef PCI_VENDOR_ID_ASIX
-#define PCI_VENDOR_ID_ASIX 0x125b
-#define PCI_DEVICE_ID_ASIX_9110 0x9110
-#endif
 #define PCI_SUBDEVICE_ID_EMS 0x4010
 
 static const struct pci_device_id ems_pci_tbl[] = {
@@ -122,7 +118,7 @@ static const struct pci_device_id ems_pci_tbl[] = {
 	/* CPC-104P v2 */
 	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_PLX, 0x4002},
 	/* CPC-PCIe v3 */
-	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_9110, 0xa000, PCI_SUBDEVICE_ID_EMS},
+	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100_LB, 0xa000, PCI_SUBDEVICE_ID_EMS},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df1437f..16608ce4fd0f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1760,6 +1760,10 @@
 #define PCI_SUBDEVICE_ID_AT_2700FX	0x2701
 #define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
 
+#define PCI_VENDOR_ID_ASIX		0x125b
+#define PCI_DEVICE_ID_ASIX_AX99100	0x9100
+#define PCI_DEVICE_ID_ASIX_AX99100_LB	0x9110
+
 #define PCI_VENDOR_ID_ESS		0x125d
 #define PCI_DEVICE_ID_ESS_ESS1968	0x1968
 #define PCI_DEVICE_ID_ESS_ESS1978	0x1978
-- 
2.39.2

