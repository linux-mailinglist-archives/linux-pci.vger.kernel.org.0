Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0363C6DA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 18:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiK2Ryn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbiK2Ryf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 12:54:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516FF32041;
        Tue, 29 Nov 2022 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744474; x=1701280474;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dBzFJZbFhNILeotZmnucEP1RHjoc1ZShFvJdf0neUIU=;
  b=aoiweLBGRLHVj38qmBZx++YQ9bsH27KsbEBXehckxQ3PFMdDcGh5MALT
   zdH3bVWloZnn5gipOrl2W+fgqmZabNLH71mYyVUzQboS54HBPVUzxwCc5
   oknP1kWa41DGOXFwCD7QfF71Z7TTq01zj956iKYY11f0zRPxuyU0vaAhq
   pzvY08BUKi1E3vwncZPO7xMK8bO7AGsn4iXwtBXPPxPyjXlwjYdlsWyPN
   tA9amTZrGdbG/6QjmXUlkze+tvfBk6PR3pRlLKiSnhmP4fstLJWMlf6uG
   7ZrVf8ahB13UAYtSu7AN+nlFf5igQGfOmctY4o00bKyRunfCmI/a3OuJD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317038195"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317038195"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:49:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="749957259"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="749957259"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:49:05 -0800
Subject: [PATCH v4 10/11] PCI/AER: Add optional logging callback for
 correctable error
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:49:05 -0700
Message-ID: <166974414546.1608150.4142682712102935008.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
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

Some new devices such as CXL devices may want to record additional error
information on a corrected error. Add a callback to allow the PCI device
driver to do additional logging such as providing additional stats for user
space RAS monitoring.

For CXL device, this is actually a need due to CXL needing to write to the
device AER status register in order to clear the unmasked CEs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/PCI/pci-error-recovery.rst |    7 +++++++
 drivers/pci/pcie/aer.c                   |    8 +++++++-
 include/linux/pci.h                      |    3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 187f43a03200..690220255d5e 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -83,6 +83,7 @@ This structure has the form::
 		int (*mmio_enabled)(struct pci_dev *dev);
 		int (*slot_reset)(struct pci_dev *dev);
 		void (*resume)(struct pci_dev *dev);
+		void (*cor_error_log)(struct pci_dev *dev);
 	};
 
 The possible channel states are::
@@ -422,5 +423,11 @@ That is, the recovery API only requires that:
    - drivers/net/cxgb3
    - drivers/net/s2io.c
 
+   The cor_error_log() callback is invoked in handle_error_source() when
+   the error severity is "correctable". The callback is optional and allows
+   additional logging to be done if desired. See example:
+
+   - drivers/cxl/pci.c
+
 The End
 -------
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e2d8a74f83c3..af1b5eecbb11 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -961,8 +961,14 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		if (aer)
 			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 					info->status);
-		if (pcie_aer_is_native(dev))
+		if (pcie_aer_is_native(dev)) {
+			struct pci_driver *pdrv = dev->driver;
+
+			if (pdrv && pdrv->err_handler &&
+			    pdrv->err_handler->cor_error_log)
+				pdrv->err_handler->cor_error_log(dev);
 			pcie_clear_device_status(dev);
+		}
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
 	else if (info->severity == AER_FATAL)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 575849a100a3..54939b3426a9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -844,6 +844,9 @@ struct pci_error_handlers {
 
 	/* Device driver may resume normal operations */
 	void (*resume)(struct pci_dev *dev);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_log)(struct pci_dev *dev);
 };
 
 


