Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0764679B2A7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350618AbjIKVjt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbjIKMPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:15:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FFCEB;
        Mon, 11 Sep 2023 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694434537; x=1725970537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iz/TfyVmyYapPX4+HPuAdQeqqvO4j5VMykMoNAn7m90=;
  b=fyT8/svE9J9rmAYFmQZkpPGNAK6F8/XQhAkOM1C34UNAj4xGWJie6sb9
   4+0A2E+R1H2PrvimTxR5LoeYY+DUwC0ILRVQvbjbXF3LMHfuGmFjiVX0E
   +bnuQTIzuZlECgPYWJW4Sf+3c0ZEmKi5IdKVIKHL1PXTykRU/Nm0eGg7L
   FlQgZqnz7l9m03YTJEItsc9LA/SWeBtT62yIUAAhHzQbCnjmqCGLLy5mJ
   7LsVj8Yq6nzSVEYI3YyRC02EptG2noeKaPVY3TTb5OnKG5CfMZI95VJkn
   OtmOHGG9fUb/qAavR1S7qz5ONFH2kSpHXFfoKTeH3Jap7ExGJ/fT37BMZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381863579"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="381863579"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746383365"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="746383365"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:34 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/8] scsi: esas2r: Use FIELD_GET() to extract Link Width
Date:   Mon, 11 Sep 2023 15:15:00 +0300
Message-Id: <20230911121501.21910-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use FIELD_GET() to extract PCIe Negotiated and Maximum Link Width fields
instead of custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/scsi/esas2r/esas2r_ioctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 055d2e87a2c8..3252780fd099 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -41,6 +41,8 @@
  * USA.
  */
 
+#include <linux/bitfield.h>
+
 #include "esas2r.h"
 
 /*
@@ -797,11 +799,9 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
 			gai->pci.link_speed_max =
 				(u8)(caps & PCI_EXP_LNKCAP_SLS);
 			gai->pci.link_width_curr =
-				(u8)((stat & PCI_EXP_LNKSTA_NLW)
-				     >> PCI_EXP_LNKSTA_NLW_SHIFT);
+				(u8)FIELD_GET(PCI_EXP_LNKSTA_NLW, stat);
 			gai->pci.link_width_max =
-				(u8)((caps & PCI_EXP_LNKCAP_MLW)
-				     >> 4);
+				(u8)FIELD_GET(PCI_EXP_LNKCAP_MLW, caps);
 		}
 
 		gai->pci.msi_vector_cnt = 1;
-- 
2.30.2

