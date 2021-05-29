Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8688C394DDD
	for <lists+linux-pci@lfdr.de>; Sat, 29 May 2021 21:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhE2T1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 May 2021 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhE2T1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 May 2021 15:27:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC04C061760;
        Sat, 29 May 2021 12:25:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ot16so4377494pjb.3;
        Sat, 29 May 2021 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gbH+EkegZ9klFCOPnjCh9VGgD5fmMtWOgu8Ht+xJEI=;
        b=hb/4h3ZDpYFUbhzImSKp0+kdhvjhFoqum9bpCoiM9MtfpWBdAsndYS1N+vQMWGN3J6
         csod1L6ViFhmEsIWPldfvdNG1hotqNpc0kzI88Vzp9cEdLuj1oUIRCn5GFB1elvsk6oT
         T+0WFzJA0a3ZU1a8kxtc9K44RpJAMMYUGtNuPX0Ux8EzEjyebapaQOaUcm48xoAW+LBg
         R8W9kjifxtjx/Wh1NeRrsedS5iFFSlF4aSp4/0M6SWgGNEOWjDLECzlEDmCTdwr0BrN4
         g5gjJ3u1UDtl/ZugUvPtvlRcRrG0ciU9Zjn8h8aPdY8KFlIWNJaJD8bBjOuc9D9KuRfF
         H1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gbH+EkegZ9klFCOPnjCh9VGgD5fmMtWOgu8Ht+xJEI=;
        b=cDILAqm2I+6XbjGqx3tvB1PSwotSl6RupKRx5r7+uZ2/AoY2NaE/sNKY+z1xstIXLg
         TqdLHf6hExB3uP+8dcVXL+/4lMR2LrbOdTmzbqSjZzX+kfpDCHBbruo+J0K7J6QItfW2
         Ih+N9S48BNCeZWn2mcnMsYVeHrExlTxW5Io7UiZI4dJJH1BWYvml5Qj13MSeGGB4aZNV
         PdXXamnBuYC40VE5rF/m7D86er0/WS28nivMv4Fd6XeujbIP8AHV7oCsJak4KyocBP6o
         ELupWhGHGL9x///yWkr/8IYOX2/kDIEnsgzmPm6pHRbkaZXR/w55nvdRoILQ/7cBnWHt
         12iQ==
X-Gm-Message-State: AOAM5315Kz2GMjhSPOInW+4dkn/sQsBLuXwScz5Keheq5pG5gJOAR0a/
        LrzO9fRZsP6taI1if43307I=
X-Google-Smtp-Source: ABdhPJwMq3QNQFcQbpge39ElWOodmxtNsPV3i7u+GcdC1pCXAaDnA02ft/fgai1eSDvoR43dmj2zpg==
X-Received: by 2002:a17:902:9886:b029:f9:c8d6:4cee with SMTP id s6-20020a1709029886b02900f9c8d64ceemr13435850plp.82.1622316344872;
        Sat, 29 May 2021 12:25:44 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.172])
        by smtp.googlemail.com with ESMTPSA id ge5sm7286754pjb.45.2021.05.29.12.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 12:25:44 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v5 3/7] PCI: Remove reset_fn field from pci_dev
Date:   Sun, 30 May 2021 00:55:23 +0530
Message-Id: <20210529192527.2708-4-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529192527.2708-1-ameynarkhede03@gmail.com>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
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
index 67a2605d4..bbed852d9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5231,7 +5231,7 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_lock(dev);
@@ -5267,7 +5267,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_save_and_disable(dev);
@@ -5290,7 +5290,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	if (!pci_dev_trylock(dev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8cf532681..90fd4f61f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2405,7 +2405,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
-	dev->reset_fn = pci_reset_supported(dev);
 }
 
 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f977ba79a..e86cf4a3b 100644
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
index 0955246f8..6e9bc4f9c 100644
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

