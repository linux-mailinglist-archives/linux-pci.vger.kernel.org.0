Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5708D3B761F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhF2QGE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhF2QE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 12:04:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7D2C0617A6;
        Tue, 29 Jun 2021 09:02:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso2747834pjp.5;
        Tue, 29 Jun 2021 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmC2HQiMnnxVfbqBDEQcZmYeQRlUWT+c79ix/+lqaDY=;
        b=J0U/8Er19rRzkp0qRa+urWGSZO4YQdOCx002poVSqkK0fP6+ieNt34OZ4PX8F5JJmM
         VV2m/bTk7YCJuXlCfPITjw/p0fq3omYjb/ysxjpylZl/Q+p/LaAY8SvfWviMstaO9+CG
         yBNA/khYvLw1bZVqZuJvOd4yw7kCFrEkUbfzrNbF8V1lpvB5abfO9P2eOSHZhsxN4LVa
         ZjNSoVrVm1dUo+9BXHz9w6LI6ZOSCikHiKabTUVcOCT6EUP0j++NpbP/T2yZGwDa2RLf
         HN03QLnQX91tZPbhuBCCPdeODZBj0kby4OjmBRBI7gwEYF42wM1oj0JAqR9GL80PF1NA
         sffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmC2HQiMnnxVfbqBDEQcZmYeQRlUWT+c79ix/+lqaDY=;
        b=mA0EXaxGF/z6UkwyDlOf8r9lw/M0Gy1oiKPKLDYUcrE6FdDioD1yQHSPkDCJH2bOAt
         sKMAXkYgDQ4h4r7HMSeHifBo4VaFvK0GDvMIcEFPJBGhY4UAsZTyIhPQmnux4rr7fgJF
         jk5+uKncAqPc4+kyW9E6OjrTb3R/eO7UFPDuqj5ta8m0/LO0UXl2ZFq+DTKdfEsmJRua
         xVqufrttH3MFz7j1E/JFgWBB7RMZ+TAv7D4XKudPBequA2xrP5Eeoaf8JaE4KPlIgV6L
         pbHbfGA66MSnfFh84S3pRa+s5Mzx/RUpAQE5ksWIhOVpm930VFlcFmYkis7EWn1t1jzO
         QGjg==
X-Gm-Message-State: AOAM530kgXGiwqcS+30Gu2WEQPPwZSkFhK8TyAoMc9wJXW+wYVNK45wg
        tIq7EVeg8gu+/zHrFqkjRDM=
X-Google-Smtp-Source: ABdhPJzV7APJRvpTXxXaO51KwcH/zsE+ytysrJCNXAxBgnyhoZ6N5MnnnRyvG2hhl9saix+ut5/gNA==
X-Received: by 2002:a17:90a:ea8a:: with SMTP id h10mr7861180pjz.61.1624982528747;
        Tue, 29 Jun 2021 09:02:08 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.119])
        by smtp.googlemail.com with ESMTPSA id m14sm19166240pgu.84.2021.06.29.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:02:08 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v8 3/8] PCI: Remove reset_fn field from pci_dev
Date:   Tue, 29 Jun 2021 21:30:59 +0530
Message-Id: <20210629160104.2893-4-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629160104.2893-1-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

reset_fn field is used to indicate whether the device supports any reset
mechanism or not. Remove the use of reset_fn in favor of new reset_methods
array which can be used to keep track of all supported reset mechanisms of
a device and their ordering.

The octeon driver is incorrectly using reset_fn field to detect if the
device supports FLR or not. Use pcie_reset_flr() to probe whether it
supports FLR or not.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
 drivers/pci/pci-sysfs.c                            | 2 +-
 drivers/pci/pci.c                                  | 6 +++---
 drivers/pci/probe.c                                | 1 -
 drivers/pci/quirks.c                               | 2 +-
 drivers/pci/remove.c                               | 1 -
 include/linux/pci.h                                | 1 -
 7 files changed, 6 insertions(+), 9 deletions(-)

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
index beb8d1f4f..316f70c3e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1367,7 +1367,7 @@ static umode_t pci_dev_reset_attr_is_visible(struct kobject *kobj,
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (!pdev->reset_fn)
+	if (!pci_reset_supported(pdev))
 		return 0;
 
 	return a->mode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1932c7ec4..90f0b35e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5221,7 +5221,7 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_lock(dev);
@@ -5257,7 +5257,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_save_and_disable(dev);
@@ -5280,7 +5280,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	if (!pci_dev_trylock(dev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7355769f8..750ba53fb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2407,7 +2407,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
-	dev->reset_fn = pci_reset_supported(dev);
 }
 
 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1efdc4e5a..db6d9a61a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5589,7 +5589,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 
 	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
 	    pdev->subsystem_device != 0x222e ||
-	    !pdev->reset_fn)
+	    !pci_reset_supported(pdev))
 		return;
 
 	if (pci_enable_device_mem(pdev))
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index dd12c2fcc..4c54c7505 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -19,7 +19,6 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-		dev->reset_fn = 0;
 
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bce3d3e52..a295e621f 100644
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
2.32.0

