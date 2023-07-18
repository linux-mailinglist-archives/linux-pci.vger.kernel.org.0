Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA47583C0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjGRRqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 13:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjGRRqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 13:46:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52F1981;
        Tue, 18 Jul 2023 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689702372; x=1721238372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTWJSHEGb9T1ca2QtFopdPGbNjP780uh5D0zf+cKSP4=;
  b=OlTSfaQ23VKGIfcOMcXyV/Qp15H7SDCoo4oV9uIzGg2lZy0GbCrgbehc
   BGzWdmaPp5r0QAFQjQcxrVCFEEd50A8Za3uBDrXfN36TzIr1V7TqimQHZ
   PftSwHMqpAWHf3TzmjsvzeR8Wk2c4erfFOvidhnC9qf0eIoRbH5jL0LQe
   m414pzgKN1JMsxo2FDILYkCA1DLJfxiO5JCMXKaFzC2NUrBMEy7s7tvx6
   faZ12wiaut86R5kpdst23Rfez8JA56IxqyccVtmz1WfMtjok7au1Hkz/m
   mf3l4LNn9RZjT5nkCAGmX6UHP/5akK9GrFYX1X6LEnVVtvW8wrWltuC03
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432452374"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432452374"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="727034174"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="727034174"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:46:03 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 1/4] can: ems_pci: remove PCI_SUBVENDOR_ID_ASIX definition
Date:   Tue, 18 Jul 2023 17:41:57 +0000
Message-Id: <20230718174200.2862849-2-jiaqing.zhao@linux.intel.com>
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

