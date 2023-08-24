Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094827870A6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbjHXNms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbjHXNmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:42:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD6C1BCC;
        Thu, 24 Aug 2023 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884516; x=1724420516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2++8yCZGRSSz4uOxVbgjndMH1wIP9iMn3E11M0dDVTs=;
  b=N5GAAJO5svxn+vczWGxSAYDIOHCdqJZdTNV/7Gq7CkCQiqzsiDTLwmR/
   Fhgzb87epTr8VHc+oxmXROV2Mpy8bXCKHd8/N9j61xy+xYvvTJmfhIdft
   ZIWGdMQitAkzCcc6khc3eq+oPl2GxBJ6GKXs6yJIGD08ch0qiirNT3L6h
   vAP4vCJlWnOx3xNrCXsmiHw6r0duV8QX96YNRD9eXIcuC8ryoN2ZnLZni
   eANY5wT1+hZW3l51uHqWXogl8XlYgWmV9thGn5R4oGcDflGv+osDXlcHa
   8BMF4MajbSeVC2YhICrmReX2X8oxY8y1yAwQaUkk1eSeBrdP3Am3Gkjt8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792587"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802540062"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802540062"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:28 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/14] scsi: ipr: Do PCI error checks on own line
Date:   Thu, 24 Aug 2023 16:28:30 +0300
Message-Id: <20230824132832.78705-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of if conditions with line splits, use the usual error handling
pattern with a separate variable to improve readability.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/scsi/ipr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 4e13797b2a4a..81e3d464d1f6 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -761,12 +761,14 @@ static void ipr_mask_and_clear_interrupts(struct ipr_ioa_cfg *ioa_cfg,
 static int ipr_save_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 {
 	int pcix_cmd_reg = pci_find_capability(ioa_cfg->pdev, PCI_CAP_ID_PCIX);
+	int rc;
 
 	if (pcix_cmd_reg == 0)
 		return 0;
 
-	if (pci_read_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
-				 &ioa_cfg->saved_pcix_cmd_reg) != PCIBIOS_SUCCESSFUL) {
+	rc = pci_read_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
+				  &ioa_cfg->saved_pcix_cmd_reg);
+	if (rc != PCIBIOS_SUCCESSFUL) {
 		dev_err(&ioa_cfg->pdev->dev, "Failed to save PCI-X command register\n");
 		return -EIO;
 	}
@@ -785,10 +787,12 @@ static int ipr_save_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 static int ipr_set_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 {
 	int pcix_cmd_reg = pci_find_capability(ioa_cfg->pdev, PCI_CAP_ID_PCIX);
+	int rc;
 
 	if (pcix_cmd_reg) {
-		if (pci_write_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
-					  ioa_cfg->saved_pcix_cmd_reg) != PCIBIOS_SUCCESSFUL) {
+		rc = pci_write_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
+					   ioa_cfg->saved_pcix_cmd_reg);
+		if (rc != PCIBIOS_SUCCESSFUL) {
 			dev_err(&ioa_cfg->pdev->dev, "Failed to setup PCI-X command register\n");
 			return -EIO;
 		}
-- 
2.30.2

