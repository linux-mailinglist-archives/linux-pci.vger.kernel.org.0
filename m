Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7535A711
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhDITZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhDITZ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 15:25:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD4C061762;
        Fri,  9 Apr 2021 12:25:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q26so6647632wrz.9;
        Fri, 09 Apr 2021 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3+Y0zXhw6oRbh1m+BJ3zWP7Qr31tk01wHFVmcRZ4wE=;
        b=mkQSThEZfyeAPw06c7DMzM5EEgibhy4V9KCNpQCte2cTJc6YpLNFBJjL6L0X7a75yL
         4cjtkHzDUlDlIx0HuQzG57PmIgvAhAw8x17eWVyRMfbSJZzZJivOPxDKmiLRtCZ+6tL8
         eEhloqeTUzquHW7A8jwkAx0ssutjAfzZsUt0Oj6m04xj8kSWl7XrnckjgHUyKJN54db+
         CxqgqMmdROZMknWJoqH0ot2F3H9NYoyfQwrNTMXG3rmkn6aRyOAVs2DMtT8zqUNJJr+U
         mfGD4W5dLAVW5xI7omqDAdfVLrYCdU7ULPpI9Fwp1IJadOy4H6gmx3KpLDaerGg5DQ+F
         DP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3+Y0zXhw6oRbh1m+BJ3zWP7Qr31tk01wHFVmcRZ4wE=;
        b=KnZAtDm8NO1+tTzZ6v1YHQyCpkB/D6Ia5+OoEEAD8r4lcw2qyKmwyDV2VMffUsZQDJ
         9eZZNhnwBp0tNtU0FHFL+V0GCj9g85j6/EFRiquSzMyPKLV7VBkN4YmsIXAUifG/ejT8
         LdPPXD1fiTFlxCsM87UkTL0smiWPMeEx0nP+NY7PXM3MxsXnCA7WhMSP/YWImfeQhrYK
         cRLU5UoL9fsb94ywUpeQX3MfIvcbL8wLSkxlf3Db7qqybIetd+SgSvNQYEORcE2YXTM2
         YMcyZqLRlrId6iqLMlA1v7BuZz0yZhvDARAGE7pk6c1QtRCKhtr8XRFzpOaL7rO5sXEs
         +P7Q==
X-Gm-Message-State: AOAM531Vnqx0y9phEriYU5xGB0vppFBpn+NJTqe2jCpnjsPYvS9hOIOW
        GX7WdrpjSNED4NA86CVduLY=
X-Google-Smtp-Source: ABdhPJwUr1d7mwgqrnSmxAZgy3rcozEGbA8mSu6OKy7mdU9+MeyjfnBBix2fO98wLrRBJuIfqYZkGw==
X-Received: by 2002:adf:f40f:: with SMTP id g15mr2274414wro.46.1617996311306;
        Fri, 09 Apr 2021 12:25:11 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.176])
        by smtp.googlemail.com with ESMTPSA id j6sm6618573wru.18.2021.04.09.12.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:25:11 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2 4/5] PCI: Remove reset_fn field from pci_dev
Date:   Sat, 10 Apr 2021 00:53:23 +0530
Message-Id: <20210409192324.30080-5-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210409192324.30080-1-ameynarkhede03@gmail.com>
References: <20210409192324.30080-1-ameynarkhede03@gmail.com>
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

