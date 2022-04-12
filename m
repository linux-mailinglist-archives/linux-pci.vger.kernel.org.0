Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4434FEAD9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 01:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiDLXZ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 19:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiDLXYb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 19:24:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910AC2183C
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 15:44:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so2653847b3.12
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hi3AFMxd4lntnLY/VQnmQFojrvZ1/71m51waZccMBqI=;
        b=VSfz0n9nJ2lR6P4G1ocNVOqrsqdiqSq5veHYoIkdL2cPgyxU3+U9LcU9Zkt/L/espf
         NmwSsO4+O135IPaW1U4SpRbUoVTI6czXTZTUQVOfP4GB6t9DP51zByHNa3ErVrq6PdQX
         vhvq0g4vS1ppV6+ekIZN/hh4KMwYNcbvxHa4fY5rwjDS25nFDqBqYQNIxVq2N+qkdI5P
         tOm7zxWSH0otzyH/4jZINtMt3bMcfFxWkRewzcq0hIZY65SE1OIMXyyLfG6ujnRWmYHB
         uo8WBsGjShsN2CT5NZo9aXr/G162d6Vf+fOdGvQ5whNcumFtjtuA8KUq/+ekNeiJMXPM
         AbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hi3AFMxd4lntnLY/VQnmQFojrvZ1/71m51waZccMBqI=;
        b=JQeqQW80nGWq2JeGUpEcq5HlH7DxZiF4e2G6PayoK7hFVpS0ObA0SHuK/PKVTPxMPn
         6aC3pL56KJhB0c8a8WQ54bKMKdwJw3FhAvg1EBsA3hwjluxW2g29IJhu1B/TSMVTfu0z
         7iie8o3tf9qrn12GmHm09/VpRWzpSS2pebtZfHe1mMKrSuX7/5jTTwyNP6irN2swRP9G
         8eJe2avZ5zKrq+PkGNRvaZiDTtrnPeJ5E9wWIJwVliZWa7acvo0xi5JkoHe/DjcbXfhI
         y3X2PqTJIXLVSv/Pp/eaSw3hxOqyxy535xmtimdAWKjT2CZbPFtVs+5s4RlJU94CNK0J
         jxaQ==
X-Gm-Message-State: AOAM530QRf7biR0fZ+LT43BSH1GOxSFLslCrg/HGkKblLbrW6i9+iuM0
        YiEvk0jEJrkYstX7iUcoqTgk56RkX7UyK08=
X-Google-Smtp-Source: ABdhPJxBsxbpOMmVxsT/oTTD7ilgxR9LQI/XCGpqtElVe+HELVc1DLqgy7IThzRYQurYCsg7OyK4RdKoUJkOazA=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:8573:aa64:c3e8:ebc])
 (user=tansuresh job=sendgmr) by 2002:a5b:a0c:0:b0:633:6489:7e3a with SMTP id
 k12-20020a5b0a0c000000b0063364897e3amr28515611ybq.71.1649803446833; Tue, 12
 Apr 2022 15:44:06 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:43:47 -0700
In-Reply-To: <20220412224348.1038613-2-tansuresh@google.com>
Message-Id: <20220412224348.1038613-3-tansuresh@google.com>
Mime-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com> <20220412224348.1038613-2-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 2/3] PCI: Support asynchronous shutdown
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
 drivers/pci/pci-driver.c | 20 ++++++++++++++++----
 include/linux/pci.h      |  4 ++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4ceeb75fc899..63f49a8dff8e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -501,16 +501,28 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
-static void pci_device_shutdown(struct device *dev)
+static void pci_device_async_shutdown_start(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	if (drv && drv->async_shutdown_start)
+		drv->async_shutdown_start(pci_dev);
+	else if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
+}
+
+static void pci_device_async_shutdown_end(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->async_shutdown_end)
+		drv->async_shutdown_end(pci_dev);
+
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
@@ -521,7 +533,6 @@ static void pci_device_shutdown(struct device *dev)
 	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
 		pci_clear_master(pci_dev);
 }
-
 #ifdef CONFIG_PM
 
 /* Auxiliary functions used for system resume and run-time resume. */
@@ -1625,7 +1636,8 @@ struct bus_type pci_bus_type = {
 	.uevent		= pci_uevent,
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
-	.shutdown	= pci_device_shutdown,
+	.async_shutdown_start	= pci_device_async_shutdown_start,
+	.async_shutdown_end	= pci_device_async_shutdown_end,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b957eeb89c7a..bbdf7d52e87b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -881,6 +881,8 @@ struct module;
  *		Useful for enabling wake-on-lan (NIC) or changing
  *		the power state of a device before reboot.
  *		e.g. drivers/net/e100.c.
+ * @async_shutdown_start:	This starts the asynchronous shutdown
+ * @async_shutdown_end:	This completes the started asynchronous shutdown
  * @sriov_configure: Optional driver callback to allow configuration of
  *		number of VFs to enable via sysfs "sriov_numvfs" file.
  * @sriov_set_msix_vec_count: PF Driver callback to change number of MSI-X
@@ -905,6 +907,8 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*async_shutdown_start)(struct pci_dev *dev);
+	void (*async_shutdown_end)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.36.0.rc0.470.gd361397f0d-goog

