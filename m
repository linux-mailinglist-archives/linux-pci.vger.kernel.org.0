Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0275C3943D6
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhE1OJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbhE1OJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 10:09:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A024C061574;
        Fri, 28 May 2021 07:08:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 22so3307979pfv.11;
        Fri, 28 May 2021 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akBlPiWHD54eFlP2beyMx41zh4qBgkL9tchdaD+JxHE=;
        b=Wr3MfgTtC3S+LO1as/bdIrVxuqG5cEOduuR4004WGgHXYIjg3tQOykRUiLGwhiUXL5
         /ubPLr4xPm2GgRO+iIxaQFQlZzwnVwUtNuaGW0FxjJ3dJTjOHhf/FR/KdvvhBRezg6Ca
         JEdAZm2B8P5jo27rP49sfwIrezERJYKWBIHt2d+CbpwRP4HOT7VkCK2LhV53uuMJM9OU
         llup7+gQlqgIfp3lOQiLc66KYrsET6Tyf/6AtGc7uxFBHT7XnioGNjBExX1jqdLCZxvW
         cAuPz1yfuzHfrvBFYLPLMYu13TLhBJA6apWAnnlZLH1PR9dAlQC6KtjyroLg8r/tPmtq
         VO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akBlPiWHD54eFlP2beyMx41zh4qBgkL9tchdaD+JxHE=;
        b=Iuii591T/u+dJ6w7LInJHLHreACgtZt1mpACciLeStPHhJI8saSUMrAuNdEQk1u9i5
         laBBRf/Osj30sBZyznDCZGcp06y79n/2Os3bFcvdcGHFyOzg1gzUlvny2wMN3VSjllYs
         d3J36V1K1LxzvJfNdvtqu9mqBgNXXU5VxgbzIWJCcFwGEUr4DIciM+llh6DtXIJzo3SH
         hDS8ta2cYfbg4XsHdbjfvxg7y2h6M104Dr2Eiz1lqWzlpiQacYoBXaBPdV9PVVJRF9Qu
         5a9IqzqEBTsRd172K6539lVkPIXWm+LyIB22+vuMgCbsBk2BF4mE6LT8TeOmqL1pSeEy
         Lz3w==
X-Gm-Message-State: AOAM530g5AWtcyvhM6Efo7INOUc/bMIsPn34B9gt9XciXQw+TE+Oprq1
        cO3Jz1N0Vyd2jNr4zD0inn8=
X-Google-Smtp-Source: ABdhPJwKmKrdthwVjSDM57qdkCu8M+LwOtWPt8kOwMyQ3XjdIjclgQndtJQPzT1bE5A9QUp4JtrpdA==
X-Received: by 2002:a63:514f:: with SMTP id r15mr9009206pgl.374.1622210894169;
        Fri, 28 May 2021 07:08:14 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id j3sm4607841pfe.98.2021.05.28.07.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:08:13 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v4 3/7] PCI: Remove reset_fn field from pci_dev
Date:   Fri, 28 May 2021 19:37:51 +0530
Message-Id: <20210528140755.7044-4-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528140755.7044-1-ameynarkhede03@gmail.com>
References: <20210528140755.7044-1-ameynarkhede03@gmail.com>
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
index cbdb5bd0d..fad209c5f 100644
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
index 738c0cadb..e9603d638 100644
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

