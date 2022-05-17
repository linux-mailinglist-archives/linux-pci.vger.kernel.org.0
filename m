Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAE052ADD9
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiEQWIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 18:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiEQWIf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 18:08:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBE5377FA
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 15:08:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p5-20020a254205000000b0064da2110759so308129yba.12
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zm0DqW+BoHKP/acD7zIvmyyRPadAhJ70kej4mteuoVA=;
        b=AsNbs7wnDoomcBDBtfoCOElE6jNniS5QhqV6pIza4jl4lpHIHoIYTtS9hAoHBuc1P5
         Lai81UoqAapTGV+EhVeBkb9ifvYs4rS3/UM04qTmqwbuktXpET6Zr8lur6zjXKSJaDYw
         JrAu/bjtVVQCKzKgvkPerJoZcyc/wAI3pKA7B3S2FvC6tHkHMFB33Y8FGIKJVRhU9Fvq
         VXoLxEyN6Zuu+gbZk8aUKRbh2CbfJd5zJjM4WNL+YDervkJkXdgRDNW82FG9uJVWj1US
         bI3ndM7Dlh7Tc/WbUDlpdK80LuSSQuPZmwdVDBcPS5Xq1OQBpuUWpp81khbnmmAAbegu
         xmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zm0DqW+BoHKP/acD7zIvmyyRPadAhJ70kej4mteuoVA=;
        b=t9DnZdtlYlb567373TTx824CO0jRvhtbZBgs+AT2YVhqumrfUKaSmfmdkpPc8SR5Hu
         yVrO0uNPoPzwXHrhEZSeyPww8Qwe+HOisnmMQf5wKyfgiongkdEKQHG6UFAetK6rtOJS
         697jdAx33f4M8RkTjGnvw/gVFjTDzzDt+WwnKHBZv7Yy07OsWF3kwNU4HjtQZxwQnYg8
         JmKXhQG46S/IXbKoR4ZB6618MmvlBI1gUJ+qDJ0+6/PsIaICAkblcT6UOszTXBrdg1yl
         62Quo+8cxfZof3FrsdOOuI0r8dFsTaGj1FVNXiPqJGYDQFHS81bYdqzb+uH0mxqKlxGu
         xtqw==
X-Gm-Message-State: AOAM530j9hbh/uvl+/RvB+hs9kaqX/cujnklspL9BO9FrjaKU++8uOpK
        DvIxx0bfsymUOKxLm8vWs0uTKWRIZ1h3sPk=
X-Google-Smtp-Source: ABdhPJzdJAzeV7gm8AS0Ny+YavQ8JOhwxUevF3poLXIh2oE3WhHG+lRupAn6BASD11L0wQDazBgiZye60KwAhw4=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:3c9b:5345:708:1378])
 (user=tansuresh job=sendgmr) by 2002:a5b:481:0:b0:649:d872:d521 with SMTP id
 n1-20020a5b0481000000b00649d872d521mr24676650ybp.73.1652825311407; Tue, 17
 May 2022 15:08:31 -0700 (PDT)
Date:   Tue, 17 May 2022 15:08:15 -0700
In-Reply-To: <20220517220816.1635044-2-tansuresh@google.com>
Message-Id: <20220517220816.1635044-3-tansuresh@google.com>
Mime-Version: 1.0
References: <20220517220816.1635044-1-tansuresh@google.com> <20220517220816.1635044-2-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 2/3] PCI: Support asynchronous shutdown
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
index 60adf42460ab..ef5500c18fed 100644
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
2.36.0.550.gb090851708-goog

