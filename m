Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB65672E2B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjASBbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjASBai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520214903B;
        Wed, 18 Jan 2023 17:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091718; x=1705627718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUExVLrrHvppHIaV2qBfwGoE2alj2nO9APdfx3eq+jA=;
  b=S4moSG0ym34U+hnnxDK+RV3LjoqM7hQ0o5KF8uwQ3ku5P53cVP1RnlsE
   OzrlYlRTQ0Ee5sMi6D283YD2F35nGKYfH2got7oX2TEve8SNhl56pe74V
   GMSjxdgkrm8BwIgMmqyjsv+gWRgWP16YXJiUYmx5AraFcdKy6Jjt6KHGI
   2I9TGXkuD8JS8iUZj+BWJwaXGOG31LM2zfBX8s3QZefIj63YSuASuqzyE
   hFHt7edDIEX8ewKwtozsPvteRnnshBxF4Ft+O6rsdh4AJogtb45/maRiA
   hUCHDyWZl74Eqkl7HLaFw0gp7r9JC0tyn0eZwqu/iNGO7E2gJx6ZBntJS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847521"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995651"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995651"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:32 -0800
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
Subject: [PATCH v1 06/12] driver core: expose device_is_ancestor() API
Date:   Wed, 18 Jan 2023 20:35:56 -0500
Message-Id: <20230119013602.607466-7-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Exposes device_is_ancestor() API which can be used
for check the device is the target device's ancestor or not.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c    | 3 ++-
 include/linux/device.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..597192b38198 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -262,7 +262,7 @@ static void device_link_remove_from_lists(struct device_link *link)
 }
 #endif /* !CONFIG_SRCU */
 
-static bool device_is_ancestor(struct device *dev, struct device *target)
+bool device_is_ancestor(struct device *dev, struct device *target)
 {
 	while (target->parent) {
 		target = target->parent;
@@ -271,6 +271,7 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 	}
 	return false;
 }
+EXPORT_SYMBOL_GPL(device_is_ancestor);
 
 /**
  * device_is_dependent - Check if one device depends on another one
diff --git a/include/linux/device.h b/include/linux/device.h
index 44e3acae7b36..35e35982d9a5 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -909,6 +909,7 @@ int device_move(struct device *dev, struct device *new_parent,
 int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
 const char *device_get_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
 			       kgid_t *gid, const char **tmp);
+bool device_is_ancestor(struct device *dev, struct device *target);
 int device_is_dependent(struct device *dev, void *target);
 
 static inline bool device_supports_offline(struct device *dev)
-- 
2.38.1

