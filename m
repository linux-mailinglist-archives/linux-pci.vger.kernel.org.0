Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9A75ABEB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGTK32 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 06:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjGTK31 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 06:29:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD0610F1;
        Thu, 20 Jul 2023 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689848967; x=1721384967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTWJSHEGb9T1ca2QtFopdPGbNjP780uh5D0zf+cKSP4=;
  b=gEMCVHLwG9dFbz2J98dcj7EGDrj64yCpaAyLGAs1zTuFZIJnw/PCyiBX
   OwuXdxCEsM1sVfReHVRyi97oGPE09LDuiAAxWcvnHr4mX4YcU3TtfInR4
   Ecv5i46CSyacrwtAw/cFEEin3F3aQOHGIDf0KKCQFDHsUfE/OROlFedNb
   cHIjqZhaWgddsjEw9/sTaxSbXsZsm/aOdUkJTaHDQwtWI3vTFXByPQZs/
   buHZe/3GmYaxDWqvXu1k4mIsa1gGwUOQNug8AzEOoGsiU5po5m0UojCXu
   p3J9Aocf7k2u6bEktCcd1drqa77I9KVrxvJXt8kyyZ9CGODsZ/LbduND9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370261360"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="370261360"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="727636707"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="727636707"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:29:24 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v2 1/2] can: ems_pci: remove PCI_SUBVENDOR_ID_ASIX definition
Date:   Thu, 20 Jul 2023 10:28:58 +0000
Message-Id: <20230720102859.2985655-2-jiaqing.zhao@linux.intel.com>
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

PCI_SUBVENDOR_ID_ASIX is defined as 0xa000, which is not the vendor id
assigned to ASIX by PCI-SIG. Remove it to avoid possible confusion and
conflict.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/can/sja1000/ems_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index c56e27223e5f..3e18c63a982c 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -111,7 +111,6 @@ struct ems_pci_card {
 #ifndef PCI_VENDOR_ID_ASIX
 #define PCI_VENDOR_ID_ASIX 0x125b
 #define PCI_DEVICE_ID_ASIX_9110 0x9110
-#define PCI_SUBVENDOR_ID_ASIX 0xa000
 #endif
 #define PCI_SUBDEVICE_ID_EMS 0x4010
 
@@ -123,7 +122,7 @@ static const struct pci_device_id ems_pci_tbl[] = {
 	/* CPC-104P v2 */
 	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_PLX, 0x4002},
 	/* CPC-PCIe v3 */
-	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_9110, PCI_SUBVENDOR_ID_ASIX, PCI_SUBDEVICE_ID_EMS},
+	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_9110, 0xa000, PCI_SUBDEVICE_ID_EMS},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
-- 
2.39.2

