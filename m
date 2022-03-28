Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FDD4EA366
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 01:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiC1XCM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 19:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiC1XCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 19:02:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8126131
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 16:00:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e68c93bb30so130428717b3.18
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PjCJgoS657I/tk8eQdlHI01Sy2nbJ1vs0eOca3BDeMA=;
        b=YrW1oHI6OeNS97qb0yJLiWsmS/O0yisj3J+4OLHulXFrVW++E6+RYQOIE9kRM8gvPl
         nYVOVSMnQ38vUWHmvPhbD7Di+LW8cxAlhFJk6rylh8ho4c7W6RbVgiqFR3kqbUGal79N
         AnGraxxjbZ/qEIuvv/3hskPbqVzITszKNTauorm3U5A10LAz33yyLW+qRHr39PSjgZEc
         gFxP0vIK4JjSTg72HAxnLs1TerTNewB0WjKzK2tZmdEGrsphjP+GpJ/8nRfVGtQ6/6oh
         8DnJjPZ35lUPzzKkyIyhHXn9zk+j+m6UjTXpgJYAHJ8LEDsxYZSRsjbEB7hd4MEVv7fE
         U7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PjCJgoS657I/tk8eQdlHI01Sy2nbJ1vs0eOca3BDeMA=;
        b=IvdtviJqqhw41R0j9ynipyw7TNgZGZ4MQsALjws2Cc7eATLszFbYT4ebzspHnQjZcL
         DGf+nFOORpCOGzMyaYoZgH0nlXleyFnBCTDP9KZKACM7y3YVsQ/84NEogR+aVgmRaxGe
         oOHVGZZV2ah+SVAVCT4aPSx5ZpuwZkE4yoA8BduSUAOZBy526gNJ1y8ygkL5DdWKfBBp
         S1pugVY3ackIfd//oP1uJpFruX3DV3lylvwWaBGJRazSDbcY2sCI9PvHQkr0cMSLGCOk
         AA9Dq7ZAcy6sGULcZWEjaWEumwolwcS7gfF4Te/Qrpwj8UyJPMq8uD0ZzcZ88fq40jS9
         v/DA==
X-Gm-Message-State: AOAM532gYIe4kRTeD6Ats036WJAbtT3T6TG4kTZzMWq3erMpBO3oJ27q
        NuIgPNU6RVTxio8DfZlwaHgIsrh3vVXpFjg=
X-Google-Smtp-Source: ABdhPJzCP0I8+FlderVfuOTtetUSRQ7p5Ej5WF/C0Zw2u46sRNYBzp8kbYF//zgxfxG0NFdnd84urn2FfzqAcr0=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:3dbb:6bbc:98be:a31e])
 (user=tansuresh job=sendgmr) by 2002:a81:c02:0:b0:2e5:b6af:2c8 with SMTP id
 2-20020a810c02000000b002e5b6af02c8mr29031195ywm.190.1648508422372; Mon, 28
 Mar 2022 16:00:22 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:00:07 -0700
In-Reply-To: <20220328230008.3587975-2-tansuresh@google.com>
Message-Id: <20220328230008.3587975-3-tansuresh@google.com>
Mime-Version: 1.0
References: <20220328230008.3587975-1-tansuresh@google.com> <20220328230008.3587975-2-tansuresh@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v1 2/3] PCI: Support asynchronous shutdown
From:   Tanjore Suresh <tansuresh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
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
index b957eeb89c7a..19047fcb3c8a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -905,6 +905,8 @@ struct pci_driver {
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

