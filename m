Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62267389A25
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 01:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhESX4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 19:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhESX4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 19:56:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9DCC061574;
        Wed, 19 May 2021 16:54:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l70so10595056pga.1;
        Wed, 19 May 2021 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3+Y0zXhw6oRbh1m+BJ3zWP7Qr31tk01wHFVmcRZ4wE=;
        b=KRzjISu0Nz5xgIhnyRtdixkLfZx2emIynOYwQ8r8BpC5RIbbZNSVRAw3ia7789u6G8
         Yd8Wv9VJX/lXXQk8f381qURyRUk0WNyftGO4sRQl+x0uVEMsjOjAtLwjAt9FJmEfzT8S
         bIGFuvrkuT6JVmoFAL+ozCmFhQJqYGM6JvPrv55f78Zr7bbzCBWEoKRxDUpmNRT7gNY3
         hgpcgB6UVxcICX3jWYx5eV2gjAsYETJBWHSvvVt/CiXDduAjKnIJcgjrrKVIawgJ0ZoL
         pJNf0ZUVHrbhsEHLzc81TxhHOotLMpJhTuy3et8nBW8V8F/2TGwxVNDvGK+wvXz2x5AY
         eVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3+Y0zXhw6oRbh1m+BJ3zWP7Qr31tk01wHFVmcRZ4wE=;
        b=aHBvhu1Ut381d+bCfS8qSDvMg5eXlMEQvTySX2rkBih9rLmMbGtv0iuNYoag8OlQLP
         /1gMvfAiSA9MtqAFYxopTbVjuUeqmWZ3ImeF1dA0GYPVsbA6aHj8pLFNS3dAtS8leqfN
         /wuLjJMU7F+etHNpRttR/M3YiqZ2rZnIO4FPpW63Vk0dMxXKJUZ+FB2wMtc2rvtcMjpi
         zue/6y6ywcR4fSuGxz6wYy5A/FIWXjo7v4g7NZ58mWvyy/ritekxTVvwASnCKDJttaZ6
         e3Zg9Z7akqoszEg2m+WtwXdBouoX0eHDwl8CBwmV0NOwlqBQlt+Ndb2T6p1C0qe1wkLu
         /pHw==
X-Gm-Message-State: AOAM531WDXIFq8jMWw/fVRmZe85qgiAYBp+UnXZqDYmLNlIkEclPkRV3
        nAyR/DYIeU3bp/9Zu880JZI=
X-Google-Smtp-Source: ABdhPJyLdXRtmhxMAFQnHk7I+ShuC5vbdeyKNFDpnb9jFXefDAscxVobX8fksgxqxan/FEOUoyYPlg==
X-Received: by 2002:a63:f248:: with SMTP id d8mr1630436pgk.219.1621468491967;
        Wed, 19 May 2021 16:54:51 -0700 (PDT)
Received: from localhost.localdomain ([94.140.8.39])
        by smtp.googlemail.com with ESMTPSA id z12sm397670pfk.45.2021.05.19.16.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:54:51 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH RESEND v2 4/7] PCI: Remove reset_fn field from pci_dev
Date:   Thu, 20 May 2021 05:24:23 +0530
Message-Id: <20210519235426.99728-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519235426.99728-1-ameynarkhede03@gmail.com>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

reset_fn field is used to indicate whether the
device supports any reset mechanism or not.
Deprecate use of reset_fn in favor of new
reset_methods array which can be used to keep
track of all supported reset mechanisms of a device
and their ordering.
The octeon driver is incorrectly using reset_fn field
to detect if the device supports FLR or not. Use
pcie_reset_flr to probe whether it supports
FLR or not.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
 drivers/pci/pci-sysfs.c                            | 6 ++----
 drivers/pci/pci.c                                  | 6 +++---
 drivers/pci/probe.c                                | 1 -
 drivers/pci/quirks.c                               | 2 +-
 include/linux/pci.h                                | 1 -
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 516f166ce..336d149ee 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			oct->irq_name_storage = NULL;
 		}
 		/* Soft reset the octeon device before exiting */
-		if (oct->pci_dev->reset_fn)
+		if (!pcie_reset_flr(oct->pci_dev, 1))
 			octeon_pci_flr(oct);
 		else
 			cn23xx_vf_ask_pf_to_do_flr(oct);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f8afd54ca..388895099 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1334,7 +1334,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 
 	pcie_vpd_create_sysfs_dev_files(dev);
 
-	if (dev->reset_fn) {
+	if (pci_reset_supported(dev)) {
 		retval = device_create_file(&dev->dev, &dev_attr_reset);
 		if (retval)
 			goto error;
@@ -1417,10 +1417,8 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	pcie_vpd_remove_sysfs_dev_files(dev);
-	if (dev->reset_fn) {
+	if (pci_reset_supported(dev))
 		device_remove_file(&dev->dev, &dev_attr_reset);
-		dev->reset_fn = 0;
-	}
 }
 
 /**
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ca46a55c7..664cf2d35 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5192,7 +5192,7 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_lock(dev);
@@ -5228,7 +5228,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_save_and_disable(dev);
@@ -5251,7 +5251,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	if (!pci_dev_trylock(dev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c5cfdd239..4764e031a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2404,7 +2404,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
-	dev->reset_fn = pci_reset_supported(dev);
 }
 
 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5318833f3..8f47d139c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5535,7 +5535,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 
 	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
 	    pdev->subsystem_device != 0x222e ||
-	    !pdev->reset_fn)
+	    !pci_reset_supported(pdev))
 		return;
 
 	if (pci_enable_device_mem(pdev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5c5925ecf..9f8347799 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -429,7 +429,6 @@ struct pci_dev {
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
-	unsigned int	reset_fn:1;
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
-- 
2.31.1

