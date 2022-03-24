Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F294E6A5B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 22:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355171AbiCXVkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 17:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354206AbiCXVkO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 17:40:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8562FA
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 14:38:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a12-20020a25938c000000b0063467614126so4561182ybm.13
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iKkzGcGXHNcNBC8QzCNubVd1VUuqnCpLdh8zslocqU0=;
        b=JVbOmq76XrgynnBO5Yhxuas50bYdBiMTf7e2IRWZzuXOwZnZDGqhmUDVmzJ/ZkYW9C
         ikB/1e4diohU0+QBEeuTLaRtpmtN56uFgGKJxf0sleQIO2brQqw1GNfXU2vGCCr0QOPS
         hAp92VeJiPj93PD3VRCf0Xze5IEsn/t1UdAr9vr9ZZF0Gdxdwum1c3Nfp5AVn0GhW5xA
         kzkEkISLYgP/gYhc/cWYUWCi/ozbgfwwZukixDEcO4Mbuj+zCQ3YgTxzG/Mje1mORDHq
         ZAWAEF2hXJ56RT0BKDiP33cUzznaD3L/baMvqQAPGb7BWkPoCyz2nsln57WD90fRxYj1
         mdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iKkzGcGXHNcNBC8QzCNubVd1VUuqnCpLdh8zslocqU0=;
        b=mJGnC4Aak4AVrRVy5wp2Itv7Gb5Fa2zRcJhlHT2IPP4/YDfUck6tIfHARveInFWCH5
         DgneADoX0Li2bzdB/hJQrWb9CvFDQvszvxDKAyh3mJRji8sm1FejMNYZ+vjf39P4loHq
         yUGoQHScxsD3+vdvAdeHNi2pjmn51+Kw63NuS9fICWqTbNuotIu6TkLgAot6uR1kcWGf
         9ylim1WecbkuVHNm0CvIIX/8wYo8UDHCh9lHRZBMNou58ehq6pjeqgt/8SnotTdcZzab
         ec0JJwhPSrbSjC5M3gSz2QIW/mEqYeLuefe7aFBvXtXPI2dyJvMbwLDkCOPgSOYug6dY
         MEAA==
X-Gm-Message-State: AOAM533ma+qv69u0gFyVXSeBlevd8HAsqaPSLHVkYmU7cOQqsoYkIL6+
        MOropbvuiLjZeds76Gu+oxXI2uWsBLgkBTI=
X-Google-Smtp-Source: ABdhPJxTr1QrHSXm1+rYF8oG4K+DdHiIEldvDy9VQkzZg+de7iMSrqbdS1scNMr0ut5PICcY5RvxcTwXgt/GceE=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:849f:5cb9:7db8:508a])
 (user=tansuresh job=sendgmr) by 2002:a05:6902:1d1:b0:636:fa07:4b9a with SMTP
 id u17-20020a05690201d100b00636fa074b9amr6337359ybh.590.1648157920886; Thu,
 24 Mar 2022 14:38:40 -0700 (PDT)
Date:   Thu, 24 Mar 2022 14:38:33 -0700
Message-Id: <20220324213833.3056034-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 2/3] PCI: Support asynchronous shutdown
From:   Tanjore Suresh <tansuresh@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enhances the base PCI driver to add support for asynchronous
shutdown.

Assume a device takes n secs to shutdown. If a machine has been
populated with M such devices, the total time spent in shutting down
all the devices will be M * n secs, if the shutdown is done
synchronously. For example, if NVMe PCI Controllers take 5 secs
to shutdown and if there are 16 such NVMe controllers in a system,
system will spend a total of 80 secs to shutdown all
NVMe devices in that system.

In order to speed up the shutdown time, asynchronous interface to
shutdown has been implemented. This will significantly reduce
the machine reboot time.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/pci/pci-driver.c | 17 ++++++++++++++---
 include/linux/pci.h      |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4ceeb75fc899..0d0b46d71e88 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -501,14 +501,16 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
-static void pci_device_shutdown(struct device *dev)
+static void pci_device_shutdown_pre(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	if (drv && drv->shutdown_pre)
+		drv->shutdown_pre(pci_dev);
+	else if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
 	/*
@@ -522,6 +524,14 @@ static void pci_device_shutdown(struct device *dev)
 		pci_clear_master(pci_dev);
 }
 
+static void pci_device_shutdown_post(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->shutdown_post)
+		drv->shutdown_post(pci_dev);
+}
 #ifdef CONFIG_PM
 
 /* Auxiliary functions used for system resume and run-time resume. */
@@ -1625,7 +1635,8 @@ struct bus_type pci_bus_type = {
 	.uevent		= pci_uevent,
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
-	.shutdown	= pci_device_shutdown,
+	.shutdown_pre	= pci_device_shutdown_pre,
+	.shutdown_post	= pci_device_shutdown_post,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60d423d8f0c4..bdd3a4d65a19 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -904,6 +904,8 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*shutdown_pre)(struct pci_dev *dev);
+	void (*shutdown_post)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.35.1.1021.g381101b075-goog

