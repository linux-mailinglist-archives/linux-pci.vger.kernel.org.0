Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452BE79BD23
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjIKVjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbjIKMPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:15:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BABC198;
        Mon, 11 Sep 2023 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694434541; x=1725970541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSuO90qdNTyz15lAqW8X8DjHjSx7W+4UYOBcDEz33uM=;
  b=AW5IVT+blUQ9HTa14kLKxgWONaiia9Y4mhETVMty1F0btvv7SZQyelc6
   6QjJaYwz0b24F+VhIAl3Qni73UgpFRQT9+fwE6XlLQ7gl8+Jirda5zkmz
   cI1xdrxdgaUxrt85STTu7N0LWknjb64UFXNlXtqPl7blDFHfL2tWOzyv9
   ZabNEN08hiQOOkxb7R7Mow8L6U/DPuY1RTvgyrhdFSD2ynfuO8WH2a6N6
   b9UgYIyXBJcfYPwGTxuQ577b7sA1MWYFj4D/cz7+WoHV9SH/p8Jj5wsu7
   0O3EH3XIVcJi/FpEFv//h+RTMD09d5WbixmCK2V0TNOngEcu+5WtB/vZe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381863606"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="381863606"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746383382"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="746383382"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:37 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 8/8] scsi: qla2xxx: Use FIELD_GET() to extract Link Width
Date:   Mon, 11 Sep 2023 15:15:01 +0300
Message-Id: <20230911121501.21910-9-ilpo.jarvinen@linux.intel.com>
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

Use FIELD_GET() to extract PCIe Maximum Link Width field instead of
custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 877e4f446709..0c97a5e4249c 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5,6 +5,7 @@
  */
 #include "qla_def.h"
 
+#include <linux/bitfield.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
@@ -632,7 +633,7 @@ qla24xx_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
 
 		pcie_capability_read_dword(ha->pdev, PCI_EXP_LNKCAP, &lstat);
 		lspeed = lstat & PCI_EXP_LNKCAP_SLS;
-		lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;
+		lwidth = FIELD_GET(PCI_EXP_LNKCAP_MLW, lstat);
 
 		switch (lspeed) {
 		case 1:
-- 
2.30.2

