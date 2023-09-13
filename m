Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388079E80D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbjIMMbC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 08:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbjIMMbA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 08:31:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE61BC8;
        Wed, 13 Sep 2023 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694608249; x=1726144249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1/Ks4shsYec7fIvyglfV0nBYf14xH5c+nwe3xSib8S0=;
  b=IuwJfy2bN+EuGCvy3e79A+V2ExaFySKwqOsDAhHkzsFsrZF+azWEA7Xl
   D5GIRJdv5aCCU+lz3VogF4NrSajM1cZbghT3dlNBhKfuDoY2KQvK+DtJf
   0Im4iBl7MFbmi2AhU/6TgkTSitqzYB6uMxPz+7H3vdcdiM1IhVY6nXSKB
   6z5AAB82B+EUuoi4xp2PJsEeunf6vMKYuzk6+ZGmatqTSXJQXuqDiStCR
   OS31pFICW2F7keSpgMyF7tSeBzTD0+n+AUJIUoOt67dh1jRku1IAaXjlH
   o3VRX9tarh2V3zdawY4xgMN7Y+dU9xKmSnCFoHhozKhXY+nfyhA34tsKI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="368912530"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368912530"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693836656"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693836656"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.45.213])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:25 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 07/10] scsi: esas2r: Use FIELD_GET() to extract PCIe capability fields
Date:   Wed, 13 Sep 2023 15:27:45 +0300
Message-Id: <20230913122748.29530-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use FIELD_GET() to extract PCIe capability register fields instead of
custom masking and shifting. Also remove the unnecessary cast to u8,
the value in those fields always fits to u8.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/scsi/esas2r/esas2r_ioctl.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 055d2e87a2c8..3f7c1d131ec3 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -41,6 +41,8 @@
  * USA.
  */
 
+#include <linux/bitfield.h>
+
 #include "esas2r.h"
 
 /*
@@ -792,16 +794,10 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
 			pcie_capability_read_dword(a->pcid, PCI_EXP_LNKCAP,
 						   &caps);
 
-			gai->pci.link_speed_curr =
-				(u8)(stat & PCI_EXP_LNKSTA_CLS);
-			gai->pci.link_speed_max =
-				(u8)(caps & PCI_EXP_LNKCAP_SLS);
-			gai->pci.link_width_curr =
-				(u8)((stat & PCI_EXP_LNKSTA_NLW)
-				     >> PCI_EXP_LNKSTA_NLW_SHIFT);
-			gai->pci.link_width_max =
-				(u8)((caps & PCI_EXP_LNKCAP_MLW)
-				     >> 4);
+			gai->pci.link_speed_curr = FIELD_GET(PCI_EXP_LNKSTA_CLS, stat);
+			gai->pci.link_speed_max = FIELD_GET(PCI_EXP_LNKCAP_SLS, caps);
+			gai->pci.link_width_curr = FIELD_GET(PCI_EXP_LNKSTA_NLW, stat);
+			gai->pci.link_width_max = FIELD_GET(PCI_EXP_LNKCAP_MLW, caps);
 		}
 
 		gai->pci.msi_vector_cnt = 1;
-- 
2.30.2

