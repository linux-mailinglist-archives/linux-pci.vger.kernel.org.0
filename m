Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0697583C4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjGRRqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjGRRqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 13:46:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158AC1737;
        Tue, 18 Jul 2023 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689702376; x=1721238376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qefIe8TC6X53stGigSXPxrsL1cE2tYo4xiXEZ53Z9yo=;
  b=VOxI73uhy0+IOyRuoD0KGUZzYRTjy+IRcCUKJgHSVSR1/d9C1aMjdWF3
   svkBeHmh8N6EY/BX44se5WrLW3zqpvMZ2Q5YST7M/IF9o5/gU3h8yVMkv
   slhiRlh41bTo6I2G7Q0Hw5l7I2ED1Ys7hpf+YnvtfUyOlgQ+aCfJO7+d9
   GEHq6pNFZCnKhYOzx0PqeeU1AW1AJS6c0KiElpo9DKhPpd6gcZwjYBFc6
   FVbamytXESno45/IkRsosTwSZX/qU4RV5oXjKa3ZTmihDLxI8bq0454+b
   S6UAe6IWyV/+BatJY4hD2hr3kyWS2MNNw0E4mWJf5GWvaufM7Dln/g09S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432452398"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432452398"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:46:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="727034220"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="727034220"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:46:06 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 2/4] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
Date:   Tue, 18 Jul 2023 17:41:58 +0000
Message-Id: <20230718174200.2862849-3-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718174200.2862849-1-jiaqing.zhao@linux.intel.com>
References: <20230718174200.2862849-1-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

