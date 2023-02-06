Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79BB68C7ED
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBFUts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBFUtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:49:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2B11F496;
        Mon,  6 Feb 2023 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716582; x=1707252582;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uC8lEuvwHH2deqsIZTrfxKpysQ5Jn97kcwiU6Ljxh8g=;
  b=S9PReeM6TGhU6Km2U3G7O3gD3h3D1wmL3ubI+oZRJTJO0d8U/smEP1OI
   0aU5YK+WZL8s6LQPhX/m4LJRwMcCEcHhAW/UBvVXonwNIYe+npH27jG1S
   Z/ckkZjTUeEx1u4TIWd1G1gSQHPpa82kVxcswPsTwFN78x/nZK7adUuc+
   E+kWvEeoexFaP1pJz9d8ZAaD8C6btkTnjA+uO19msjjnZHDPZJWZ0t9yh
   paxpIbvH8KCqZKphc07BkkRslgu0hWp8Y+KigH0maT60h5jyQumNHLMVA
   Cl0QYSG2U7P/TpBmjpuz8BcrYg4L5qnWCH6IzsdSQ6Y5LXrSTKrwQbnpv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393911834"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393911834"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616559380"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616559380"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:41 -0800
Subject: [PATCH 02/18] ACPICA: Export acpi_ut_verify_cdat_checksum()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:49:39 -0700
Message-ID: <167571657859.587790.12435839081602248140.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export the CDAT checksum verify function so CXL driver can use it to verify
CDAT coming from the CXL devices.

Given that this function isn't actually being used by ACPI internals,
removing the define check of APCI_CHECKSUM_ABORT so the function would
return failure on checksum fail since the driver will need to know.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/acpica/utcksum.c |    4 +---
 include/linux/acpi.h          |    7 +++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
index c166e4c05ab6..c0f98c8f9a0b 100644
--- a/drivers/acpi/acpica/utcksum.c
+++ b/drivers/acpi/acpica/utcksum.c
@@ -102,15 +102,13 @@ acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
 				   "should be 0x%2.2X",
 				   acpi_gbl_CDAT, cdat_table->checksum,
 				   checksum));
-
-#if (ACPI_CHECKSUM_ABORT)
 		return (AE_BAD_CHECKSUM);
-#endif
 	}
 
 	cdat_table->checksum = checksum;
 	return (AE_OK);
 }
+EXPORT_SYMBOL_GPL(acpi_ut_verify_cdat_checksum);
 
 /*******************************************************************************
  *
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5e6a876e17ba..09b44afef7df 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1504,9 +1504,16 @@ static inline void acpi_init_ffh(void) { }
 #ifdef CONFIG_ACPI
 extern void acpi_device_notify(struct device *dev);
 extern void acpi_device_notify_remove(struct device *dev);
+extern acpi_status
+acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length);
 #else
 static inline void acpi_device_notify(struct device *dev) { }
 static inline void acpi_device_notify_remove(struct device *dev) { }
+static inline acpi_status
+acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
+{
+	return (AE_NOT_CONFIGURED);
+}
 #endif
 
 #endif	/*_LINUX_ACPI_H*/


