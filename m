Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4324E33951F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 18:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhCLRgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 12:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhCLRgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 12:36:50 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091AC061574;
        Fri, 12 Mar 2021 09:36:50 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x7so2329138pfi.7;
        Fri, 12 Mar 2021 09:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vt+ZfXxgHIj6pX3xDrY5HBJPS+3eP7j5LuBWZFkBTOA=;
        b=H2sNtGKCYEmqPUML4+/kHtIv1LlbJvgctbPkS2MYqDMWom+h5/VXskL+DEPMvI06lv
         0QoXA74fkSQXICpWq6JlsNoUQYp9COv9zZeD77a/Mz0hGlB30ItamI60CIvgWC7nPBFa
         Kp4SbQ4d2DEFnUnUD7weK0KGB5cFcaXB7kRRirUjPUKoUgLJAefM7ltQR5Tjb669i+cH
         zJGrzDeLnnMMBHKhHzdQ7T2UaDpCjIGXSIvYb0IPHbS3KJ0/cqYLtDk91A4odOAuG5lJ
         qqgB4ppuFoowIR5sx2lRJO3w75RgbCYu8AZL4bAThsJ6ZOheVo32GfvHHYDEpTgntR46
         goAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vt+ZfXxgHIj6pX3xDrY5HBJPS+3eP7j5LuBWZFkBTOA=;
        b=aOfbegz/28+Xi3AMt+YOmXlOlvTUTfu9RgEJFDfsiggJQcteBFyKn5F/NEsenZjg3m
         ZW0kLaWD3JewwGAdobsYTOS/gZHEv1hG8drPRQFznXxxJ+PvkFoSrCMoRINzE5EJKp28
         di+ZtdesCJCXO+pRMRVE+aC3LfcwJhVgU/NFgKwC1J0kdLlWG/AkdUxCfURQFfrKpPhm
         Kk3ba8k4mYKTqkxLBoofOgyZmF5K3ynLHE0IgvGQ1UqoTf/oikc9/T9Qfyrf1tMq9FCV
         6AGah3C7eagxFwCNkYaK1sP6Unp0Pp7XSJT9fer58UcfsgzQeiuB/sbCytx+E0tN6I2B
         skGQ==
X-Gm-Message-State: AOAM531O0CQC/ows46l0fiFwSw83iqb2DqW78xlNaE8Ej5bCsDYSPwqr
        4X9L2dXBIUTKniqS5+rSapDxin+DbGS/Wg==
X-Google-Smtp-Source: ABdhPJzrExl+qGpImolq4qic6CUqHJrgmZub1I8cG7jRSDb78aB90sabNbclv3+zcuD4U/hEZJMEwA==
X-Received: by 2002:a62:5b43:0:b029:1ef:21ad:846 with SMTP id p64-20020a625b430000b02901ef21ad0846mr13544573pfb.51.1615570609987;
        Fri, 12 Mar 2021 09:36:49 -0800 (PST)
Received: from localhost.localdomain ([103.248.31.144])
        by smtp.googlemail.com with ESMTPSA id l10sm180045pfc.125.2021.03.12.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:36:49 -0800 (PST)
From:   ameynarkhede03@gmail.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH 3/4] PCI: Remove reset_fn field from pci_dev
Date:   Fri, 12 Mar 2021 23:04:51 +0530
Message-Id: <20210312173452.3855-4-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312173452.3855-1-ameynarkhede03@gmail.com>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

reset_fn field is used to indicate whether the
device supports any reset mechanism or not.
Deprecate use of reset_fn in favor of new
reset_methods bitmap which can be used to keep
track of all supported reset mechanisms of a device.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
 drivers/pci/pci-sysfs.c                            | 6 ++----
 drivers/pci/pci.c                                  | 6 +++---
 drivers/pci/probe.c                                | 1 -
 drivers/pci/quirks.c                               | 2 +-
 include/linux/pci.h                                | 1 -
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 9b9d305c6..3e2c49e08 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			oct->irq_name_storage = NULL;
 		}
 		/* Soft reset the octeon device before exiting */
-		if (oct->pci_dev->reset_fn)
+		if (oct->pci_dev->reset_methods)
 			octeon_pci_flr(oct);
 		else
 			cn23xx_vf_ask_pf_to_do_flr(oct);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f8afd54ca..78d2c130c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1334,7 +1334,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)

 	pcie_vpd_create_sysfs_dev_files(dev);

-	if (dev->reset_fn) {
+	if (dev->reset_methods) {
 		retval = device_create_file(&dev->dev, &dev_attr_reset);
 		if (retval)
 			goto error;
@@ -1417,10 +1417,8 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	pcie_vpd_remove_sysfs_dev_files(dev);
-	if (dev->reset_fn) {
+	if (dev->reset_methods)
 		device_remove_file(&dev->dev, &dev_attr_reset);
-		dev->reset_fn = 0;
-	}
 }

 /**
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 407b44e85..b7f6c6588 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5175,7 +5175,7 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;

-	if (!dev->reset_fn)
+	if (!dev->reset_methods)
 		return -ENOTTY;

 	pci_dev_lock(dev);
@@ -5211,7 +5211,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;

-	if (!dev->reset_fn)
+	if (!dev->reset_methods)
 		return -ENOTTY;

 	pci_dev_save_and_disable(dev);
@@ -5234,7 +5234,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;

-	if (!dev->reset_fn)
+	if (!dev->reset_methods)
 		return -ENOTTY;

 	if (!pci_dev_trylock(dev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 01dd037bd..4764e031a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2404,7 +2404,6 @@ static void pci_init_capabilities(struct pci_dev *dev)

 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
-	dev->reset_fn = !!dev->reset_methods;
 }

 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0a3df84c9..20a81b1bc 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5535,7 +5535,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)

 	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
 	    pdev->subsystem_device != 0x222e ||
-	    !pdev->reset_fn)
+	    !pdev->reset_methods)
 		return;

 	if (pci_enable_device_mem(pdev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 56d6e4750..a2f003f4e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -437,7 +437,6 @@ struct pci_dev {
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
-	unsigned int	reset_fn:1;
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
--
2.30.2
