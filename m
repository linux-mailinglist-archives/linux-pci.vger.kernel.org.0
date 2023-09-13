Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7CB79E803
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 14:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjIMMbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbjIMMbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 08:31:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191941BE9;
        Wed, 13 Sep 2023 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694608257; x=1726144257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mu9Ph5F+vByInHmgU9mzAsly58jmdXUJoUDkh08q/ug=;
  b=JAvIhe8oBLKfmvI9HXmfC/i4MUtzb0+pztsqyPCJ/ImY8YSzZB0uNgE3
   vlCxwYd0FgmMGAcm42qTEvaSqX6/gS/D+VgwS1qmwQRmFqqIL4Xk0P4C8
   3Z/zlbDGjjt1UI/5BVOnbPswv+IRlohbnwb8OEfrNW9GWMVbxAO2zjuME
   dZhqjT79uquVosQqbIE1qyHdRqijbiP6NBnYCpIT9+x/jHLni1XSGJHa3
   ah27Az1P09XIqwwFRPbtUP8gOQpJ3Xn9CXXbUByjz1DTk7BTmy5gAzZYu
   bCa0PdYAXX3agSWxHZSsB7ROYogQrev3+Amx5BEpeXZ5OcpDo/j1MPHei
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="368912589"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368912589"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693836663"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693836663"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.45.213])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/10] scsi: qla2xxx: Use FIELD_GET() to extract PCIe capability fields
Date:   Wed, 13 Sep 2023 15:27:46 +0300
Message-Id: <20230913122748.29530-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use FIELD_GET() to extract PCIe capability registers field instead of
custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 50db08265c51..7e103d711825 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5,6 +5,7 @@
  */
 #include "qla_def.h"
 
+#include <linux/bitfield.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
@@ -633,8 +634,8 @@ qla24xx_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
 		const char *speed_str;
 
 		pcie_capability_read_dword(ha->pdev, PCI_EXP_LNKCAP, &lstat);
-		lspeed = lstat & PCI_EXP_LNKCAP_SLS;
-		lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;
+		lspeed = FIELD_GET(PCI_EXP_LNKCAP_SLS, lstat);
+		lwidth = FIELD_GET(PCI_EXP_LNKCAP_MLW, lstat);
 
 		switch (lspeed) {
 		case 1:
-- 
2.30.2

