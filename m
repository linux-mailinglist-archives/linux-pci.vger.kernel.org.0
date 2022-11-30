Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B763E331
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 23:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiK3WLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 17:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiK3WLY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 17:11:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562D88B49;
        Wed, 30 Nov 2022 14:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669846283; x=1701382283;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BymSKzCpbzbCIvKTwZkXq+pn4uDfZlWqFPzeSroI6BA=;
  b=YplqjnG/9/Uy6GRzvRoX+hxc0K2I/SvtxXrVD4otHProNWUgJX9vev8e
   pLq/JW2Sx3KAHnFqCXEttF3hcrCCP2JbFLjAQWX4Mt+OQHLJrRnS5nafC
   dHGEHmpmwDcHB6rBEsCqkVLvHc/8qHoovKJGPNWVlSoTR3tFn9OS0BLhF
   UuNruFmSedFi90X/0XtIxwHYOYaG7pZqLEo9pSJzLiefUMM2ZZQ0wR/9F
   4tqO2Ir6y65X0ixmScBoh+GlBiY+OdwOlvJTT1TbcasRVcv9LZA4kV8cy
   +pL0SzWatxOeClFzjKL95QIjDv4wNKl6kKAYj9j+Ix6Iq7uiwhABdCL0T
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="298895583"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="298895583"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:11:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707818014"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707818014"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:11:22 -0800
Subject: [v5 10/11 PATCH] PCI/AER: Add optional logging callback for
 correctable error
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com
Date:   Wed, 30 Nov 2022 15:11:21 -0700
Message-ID: <166984619233.2804404.3966368388544312674.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20221130194521.GA829038@bhelgaas>
References: <20221130194521.GA829038@bhelgaas>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
CXL RAS capability structure correctable error status register in order to
clear the unmasked correctable errors. See CXL spec rev3.0 8.2.4.16.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v5:
- Change cor_error_log() to cor_error_detected(). (Bjorn)
- Expand CE to correctable error. (Bjorn).
- Add details on exactly which register is written to. (Bjorn)

 Documentation/PCI/pci-error-recovery.rst |    7 +++++++
 drivers/pci/pcie/aer.c                   |    8 +++++++-
 include/linux/pci.h                      |    3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 187f43a03200..bdafeb4b66dc 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -83,6 +83,7 @@ This structure has the form::
 		int (*mmio_enabled)(struct pci_dev *dev);
 		int (*slot_reset)(struct pci_dev *dev);
 		void (*resume)(struct pci_dev *dev);
+		void (*cor_error_detected)(struct pci_dev *dev);
 	};
 
 The possible channel states are::
@@ -422,5 +423,11 @@ That is, the recovery API only requires that:
    - drivers/net/cxgb3
    - drivers/net/s2io.c
 
+   The cor_error_detected() callback is invoked in handle_error_source() when
+   the error severity is "correctable". The callback is optional and allows
+   additional logging to be done if desired. See example:
+
+   - drivers/cxl/pci.c
+
 The End
 -------
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e2d8a74f83c3..625f7b2cafe4 100644
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
+			    pdrv->err_handler->cor_error_detected)
+				pdrv->err_handler->cor_error_detected(dev);
 			pcie_clear_device_status(dev);
+		}
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
 	else if (info->severity == AER_FATAL)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 575849a100a3..1f81807492ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -844,6 +844,9 @@ struct pci_error_handlers {
 
 	/* Device driver may resume normal operations */
 	void (*resume)(struct pci_dev *dev);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_detected)(struct pci_dev *dev);
 };
 
 


