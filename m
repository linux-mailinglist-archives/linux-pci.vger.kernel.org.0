Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9977A672E51
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjASBei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjASBak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7453B14;
        Wed, 18 Jan 2023 17:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091735; x=1705627735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TeaiRTr0nE3XGyPN3OH2Cm6fN99UPz2BR1FgceW1lYE=;
  b=UTEROJI5YJnorU80L4J+TSeW052c63YIkcl+1N6G+ubVTnoeVblhVLi0
   AvuKqXdpyTwnCNZLHzFws7fqt3dmwSK6+raTDIk3P8VBh+1SIRNQDiuT9
   ecjyj/KnWYb045mMm+NIohGyTLk+etdvf6kD1FdSbArZTDeoBqgTGZnnS
   0SyJ4F5pgupw/l7mu3EUBBhxCOvWX20j5xpCowX/I6KrxoyIgGtOHZKxj
   kUNQ3pDz0QrrS0t2+Nb8vZmpmPUliKAlImFJBcZjhOVlvY0BC1XhliF4p
   Z/9b16tCCqLum8nKHMtaF45nsZ6wjVMYHpxua3o2DfCx3lR14OwcDiLcE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847584"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847584"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995692"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995692"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:49 -0800
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, gregkh@linuxfoundation.org,
        matthew.gerlach@linux.intel.com
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 09/12] fpga: dfl: remove non-reserved devices
Date:   Wed, 18 Jan 2023 20:35:59 -0500
Message-Id: <20230119013602.607466-10-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a new concept of non-reserved devices and reserved devices
on DFL bus. Reserved devices mean that devices under DFL bus will be
reserved before triggering the image load, because those devices are
provided a communication link to BMC during the trigger, for example
SPI/NIOS private feature device on Intel PAC N3000 card, security
update device. On the other hand, the reset of devices are
non-reserved devices, which will be removed before triggering the
image load.

After loading a new image, all of reserved and non-reserved devices
will be removed.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c | 18 +++++++++++++
 drivers/fpga/dfl.c     | 58 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h     |  2 ++
 3 files changed, 78 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 0409cb30e563..64cf6c623a5a 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -42,7 +42,24 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
+static int dfl_hp_prepare(struct fpgahp_manager *mgr)
+{
+	struct pci_dev *pcidev = mgr->priv;
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_cdev *cdev = drvdata->cdev;
+	struct platform_device *fme = to_platform_device(cdev->fme_dev);
+
+	/* remove all of non-reserved fme devices of PF0 */
+	dfl_reload_remove_non_reserved_devs(fme, mgr->bmc.device);
+
+	/* remove all AFU devices of PF0 */
+	dfl_reload_remove_afus(cdev);
+
+	return 0;
+}
+
 static const struct fpgahp_manager_ops fpgahp_ops = {
+	.hotplug_prepare = dfl_hp_prepare,
 };
 
 static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
@@ -529,3 +546,4 @@ MODULE_DESCRIPTION("FPGA DFL PCIe Device Driver");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(FPGAHP);
+MODULE_IMPORT_NS(DFL_CORE);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b9aae85ba930..613a8fef47d8 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -486,6 +486,60 @@ EXPORT_SYMBOL(dfl_driver_unregister);
 
 #define is_header_feature(feature) ((feature)->id == FEATURE_ID_FIU_HEADER)
 
+static void dfl_devs_remove_non_reserved(struct dfl_feature_platform_data *pdata,
+					 struct device *trigger_dev)
+{
+	struct dfl_feature *feature;
+
+	dfl_fpga_dev_for_each_feature(pdata, feature) {
+		if (!feature->ddev)
+			continue;
+
+		/* find and skip reserved dfl device */
+		if (device_is_ancestor(&feature->ddev->dev, trigger_dev))
+			continue;
+
+		device_unregister(&feature->ddev->dev);
+		feature->ddev = NULL;
+	}
+}
+
+void dfl_reload_remove_non_reserved_devs(struct platform_device *pdev, struct device *trigger_dev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature *feature;
+
+	dfl_devs_remove_non_reserved(pdata, trigger_dev);
+
+	dfl_fpga_dev_for_each_feature(pdata, feature) {
+		if (feature->ops) {
+			if (feature->ops->uinit)
+				feature->ops->uinit(pdev, feature);
+			feature->ops = NULL;
+		}
+	}
+}
+EXPORT_SYMBOL_NS_GPL(dfl_reload_remove_non_reserved_devs, DFL_CORE);
+
+void dfl_reload_remove_afus(struct dfl_fpga_cdev *cdev)
+{
+	struct dfl_feature_platform_data *pdata, *ptmp;
+
+	mutex_lock(&cdev->lock);
+
+	list_for_each_entry_safe(pdata, ptmp, &cdev->port_dev_list, node) {
+		struct platform_device *port_dev = pdata->dev;
+		enum dfl_id_type type = feature_dev_id_type(port_dev);
+		int id = port_dev->id;
+
+		list_del(&pdata->node);
+		platform_device_unregister(port_dev);
+		dfl_id_free(type, id);
+	}
+	mutex_unlock(&cdev->lock);
+}
+EXPORT_SYMBOL_NS_GPL(dfl_reload_remove_afus, DFL_CORE);
+
 /**
  * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
  * @pdev: feature device.
@@ -1376,6 +1430,10 @@ static int remove_feature_dev(struct device *dev, void *data)
 	enum dfl_id_type type = feature_dev_id_type(pdev);
 	int id = pdev->id;
 
+	/* pdev has been released */
+	if (!device_is_registered(&pdev->dev))
+		return 0;
+
 	platform_device_unregister(pdev);
 
 	dfl_id_free(type, id);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 898c05c269fb..3cbe1b21f001 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -485,6 +485,8 @@ struct dfl_fpga_cdev {
 struct dfl_fpga_cdev *
 dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info);
 void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev);
+void dfl_reload_remove_afus(struct dfl_fpga_cdev *cdev);
+void dfl_reload_remove_non_reserved_devs(struct platform_device *pdev, struct device *trigger_dev);
 
 /*
  * need to drop the device reference with put_device() after use port platform
-- 
2.38.1

