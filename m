Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E93EF17B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhHQSKj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhHQSKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:10:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B374CC0613C1;
        Tue, 17 Aug 2021 11:10:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so145770pjb.2;
        Tue, 17 Aug 2021 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SX96UrA0W9XHWdk8mZPQ+YM8rKvM93ApBGVAx7lWswA=;
        b=OxURf0jNmahJgv2Ntnu/GbXrfSaqoQF/zAystq8VgNnuQUHLvMbj0iIC4RAZ54ZYzw
         l9IlEU/3hHGrmu3syJd7O1bfYDRBpIwVpvQ8KbzABfwrg9vxjIzxik+S9ZB5c3E9sNaK
         /jT7oNCv+n9IRnkebjRI2DuR+vqtIdrB3XEm3o4Kgjq5rvB0DP7StMZzD9QKvkRSXEjX
         6kBRLYe3U779LYSAa/j3j1Rh2lReqD03YqdZBuQHPGctJc1SoRs3YXDQdH3XtYJQBw0/
         mrW9zv/fwa94L+Ub6cBZts063sxb/yQjAVjpxRRLlDgROS7e19MH6eXqD99K8NWVNEbK
         l0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SX96UrA0W9XHWdk8mZPQ+YM8rKvM93ApBGVAx7lWswA=;
        b=qYLu8ImrwQwuBMT9a+qTMl26CQobF8PoPRJxmSiRfyxpXw1VMSZD1vwMBOW9zUWhh3
         bt9F1maJRN5WMCY1Dj0wddE7IOEY3rdvW+7HG8NjN0ELrxGZ/pcWOG4Z1Rg9KfCfPUh8
         YD1erhVUe5dvIWRqW9fN0iRV/f0UfeLn5QjtXih/KCv1pxENJlLua9rrfNjjpEr+bIZ6
         88EuuHLv2dmG/nh5RxbqdEAKZLtffJV3689gfNxfOU5CPwbTiTzSJZG5h/0oroYqatbX
         BmNggnNJBw7h+r4MqnBOLbCnZZ+01wCZFLgktrhc7O23lCCcw39dswyNcxMCQTKLuV/x
         kV2Q==
X-Gm-Message-State: AOAM530hBn+pOvChKmede7akAbbEJNruuLog/kly0Ej+lYl1bejtl8dl
        m2RxoAafhqxqa8zku2WgK/8=
X-Google-Smtp-Source: ABdhPJy+tBdRfB9HJes97SFZL0WpMgld+R3pcbZDHwTX3JHvgBXQKzE++QwNpBc2mwM9w38DuS4pGw==
X-Received: by 2002:a17:90a:c7cc:: with SMTP id gf12mr4736870pjb.152.1629223804321;
        Tue, 17 Aug 2021 11:10:04 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id d18sm4011306pgk.24.2021.08.17.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:10:04 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v16 4/9] PCI: Remove reset_fn field from pci_dev
Date:   Tue, 17 Aug 2021 23:39:32 +0530
Message-Id: <20210817180937.3123-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180937.3123-1-ameynarkhede03@gmail.com>
References: <20210817180937.3123-1-ameynarkhede03@gmail.com>
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
index 67eab3d29..8a516e9ca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5235,7 +5235,7 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_lock(dev);
@@ -5271,7 +5271,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_save_and_disable(dev);
@@ -5294,7 +5294,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	if (!pci_dev_trylock(dev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5d8ad230f..379e85037 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2406,7 +2406,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
-	dev->reset_fn = pci_reset_supported(dev);
 }
 
 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b48e7ef8b..0db5dac3d 100644
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
index d1a9a232d..94d74fd59 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -431,7 +431,6 @@ struct pci_dev {
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
-	unsigned int	reset_fn:1;
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
-- 
2.32.0

