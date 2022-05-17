Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A7052ADD8
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiEQWIp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 18:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiEQWIi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 18:08:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC8637AB7
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 15:08:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x3-20020a25b3c3000000b0064e03a85ccbso328759ybf.5
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sUFcKVd5mQylxNWANG3jpkv2FlMsca8kAE4xpeCEJf0=;
        b=aIxa/I42w535claG/lW2XsGiWQff1K+xoXMPx6bOH8I5yrWsu7Rkm5FMzZ9IsFqUXK
         ebSMCh201NcRhTsuw7xr/mv3k1qIZtvcyO8Tzw65vsbN1MiIgbhrPjG4X2hY0/CJ6cLG
         YQ0m/XK2CRM1//uhFXgE488iEYVwEZfW8rGOsC3ppkTwwDgj/Jt3m9Oj/pR3BPNVmR7A
         rFsfEBwGrPbLWFR5uIzosFaX4d32oyMEwlkgSXhaeidG5TTAM6br1bNyZBj9YfETNMo6
         TzWNyP06Ljgvr16iwwTHion0unZdgQmlYhuGCvqq4Fn0vOV9Gkdp4wYFpmSech6MeON/
         332A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sUFcKVd5mQylxNWANG3jpkv2FlMsca8kAE4xpeCEJf0=;
        b=8Ne0DOywbFMrn05BfzFm9J7sklip/sUmIgMgdw+bLCt9X/smh92D7RRO7ppBNIiwit
         +u4tMdamxGxSOlf+/36qZUPAeKYzB2iA+mK4LkTIroVzlSzWkHrS+UGlkrpWfNPjw5hN
         kg3gCmpC8EdRcr8AN7vmVmfpwLfytU0EPZ6bP6pUUSpfyMLD3E8eYpDLceAczoGSfm7+
         L++DixXo392FuZ4SmatxJg1gvu2UGDPFX2YwMfnEGLWT4aeHyDlRVKReyGhHdFjGzuHe
         ddkOP0ibtDfP0JnlG219IDe2rwDOTcq7xVt9fnmYXXn2fGu+4xmmHClstvBzWC6q39jt
         sCMA==
X-Gm-Message-State: AOAM532f8qX8Q1uUpiuQWEYs1fd3nCVm8F+7RYluAqrCCUfenesVvWkP
        eedTJezvP6awZyp502g65Rj1KXz+RkgDQgU=
X-Google-Smtp-Source: ABdhPJwJndPxiZpo8HoH7GmaDggY9zxdEyZMeeT+SjZw0CJObzVfZY0QnKKLPFR4XXhzP3ArpKkIWOQOsdzQlTQ=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:3c9b:5345:708:1378])
 (user=tansuresh job=sendgmr) by 2002:a25:8a8a:0:b0:648:4d85:1331 with SMTP id
 h10-20020a258a8a000000b006484d851331mr24748418ybl.643.1652825315404; Tue, 17
 May 2022 15:08:35 -0700 (PDT)
Date:   Tue, 17 May 2022 15:08:16 -0700
In-Reply-To: <20220517220816.1635044-3-tansuresh@google.com>
Message-Id: <20220517220816.1635044-4-tansuresh@google.com>
Mime-Version: 1.0
References: <20220517220816.1635044-1-tansuresh@google.com>
 <20220517220816.1635044-2-tansuresh@google.com> <20220517220816.1635044-3-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 3/3] nvme: Add async shutdown support
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

This works with the asynchronous shutdown mechanism setup for the PCI
drivers and participates to provide both pre and post shutdown
routines at pci_driver structure level.

The shutdown_pre routine starts the shutdown and does not wait for the
shutdown to complete.  The shutdown_post routine waits for the shutdown
to complete on individual controllers that this driver instance
controls. This mechanism optimizes to speed up the shutdown in a
system which host many controllers.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/nvme/host/core.c | 28 ++++++++++----
 drivers/nvme/host/nvme.h |  8 ++++
 drivers/nvme/host/pci.c  | 80 +++++++++++++++++++++++++---------------
 3 files changed, 80 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e1846d04817f..f2fc62e1176e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2188,16 +2188,30 @@ EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
-	unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);
-	u32 csts;
 	int ret;
 
+	ret = nvme_shutdown_ctrl_start(ctrl);
+	if (ret)
+		return ret;
+	return nvme_wait_for_shutdown_cmpl(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
+
+int nvme_shutdown_ctrl_start(struct nvme_ctrl *ctrl)
+{
+
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
-	if (ret)
-		return ret;
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+}
+EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl_start);
+
+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
+{
+	unsigned long deadline = jiffies + (ctrl->shutdown_timeout * HZ);
+	u32 csts;
+	int ret;
 
 	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
@@ -2206,7 +2220,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 		msleep(100);
 		if (fatal_signal_pending(current))
 			return -EINTR;
-		if (time_after(jiffies, timeout)) {
+		if (time_after(jiffies, deadline)) {
 			dev_err(ctrl->device,
 				"Device shutdown incomplete; abort shutdown\n");
 			return -ENODEV;
@@ -2215,7 +2229,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
+EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);
 
 static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2b53ca63335..a8706a0f32f2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -175,6 +175,12 @@ enum {
 	NVME_REQ_USERCMD		= (1 << 1),
 };
 
+enum shutdown_type {
+	DO_NOT_SHUTDOWN = 0,
+	SHUTDOWN_TYPE_SYNC = 1,
+	SHUTDOWN_TYPE_ASYNC = 2,
+};
+
 static inline struct nvme_request *nvme_req(struct request *req)
 {
 	return blk_mq_rq_to_pdu(req);
@@ -677,6 +683,8 @@ bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
+int nvme_shutdown_ctrl_start(struct nvme_ctrl *ctrl);
+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aacf1c0d5a5..a0ab2e777d44 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -107,7 +107,7 @@ MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static void nvme_dev_disable(struct nvme_dev *dev, int shutdown_type);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
 /*
@@ -1357,7 +1357,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_DONE;
 	}
@@ -1392,7 +1392,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 		return BLK_EH_DONE;
 	case NVME_CTRL_RESETTING:
 		return BLK_EH_RESET_TIMER;
@@ -1410,7 +1410,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 		nvme_reset_ctrl(&dev->ctrl);
 
 		return BLK_EH_DONE;
@@ -1503,11 +1503,13 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
 		nvme_suspend_queue(&dev->queues[i]);
 }
 
-static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
+static void nvme_disable_admin_queue(struct nvme_dev *dev, int shutdown_type)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
 
-	if (shutdown)
+	if (shutdown_type == SHUTDOWN_TYPE_ASYNC)
+		nvme_shutdown_ctrl_start(&dev->ctrl);
+	else if (shutdown_type == SHUTDOWN_TYPE_SYNC)
 		nvme_shutdown_ctrl(&dev->ctrl);
 	else
 		nvme_disable_ctrl(&dev->ctrl);
@@ -2669,7 +2671,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_dev_disable(struct nvme_dev *dev, int shutdown_type)
 {
 	bool dead = true, freeze = false;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
@@ -2691,14 +2693,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead && shutdown && freeze)
+	if (!dead && (shutdown_type != DO_NOT_SHUTDOWN) && freeze)
 		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_disable_io_queues(dev);
-		nvme_disable_admin_queue(dev, shutdown);
+		nvme_disable_admin_queue(dev, shutdown_type);
 	}
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(&dev->queues[0]);
@@ -2710,12 +2712,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	blk_mq_tagset_wait_completed_request(&dev->tagset);
 	blk_mq_tagset_wait_completed_request(&dev->admin_tagset);
 
-	/*
-	 * The driver will not be starting up queues again if shutting down so
-	 * must flush all entered requests to their failed completion to avoid
-	 * deadlocking blk-mq hot-cpu notifier.
-	 */
-	if (shutdown) {
+	if (shutdown_type == SHUTDOWN_TYPE_SYNC) {
+		/*
+		 * The driver will not be starting up queues again if shutting down so
+		 * must flush all entered requests to their failed completion to avoid
+		 * deadlocking blk-mq hot-cpu notifier.
+		 */
 		nvme_start_queues(&dev->ctrl);
 		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
 			nvme_start_admin_queue(&dev->ctrl);
@@ -2723,11 +2725,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
+static int nvme_disable_prepare_reset(struct nvme_dev *dev, int type)
 {
 	if (!nvme_wait_reset(&dev->ctrl))
 		return -EBUSY;
-	nvme_dev_disable(dev, shutdown);
+	nvme_dev_disable(dev, type);
 	return 0;
 }
 
@@ -2785,7 +2787,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 	 */
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
@@ -2810,7 +2812,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * moving on.
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 	nvme_sync_queues(&dev->ctrl);
 
 	mutex_lock(&dev->shutdown_lock);
@@ -3151,7 +3153,7 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
 	 * state as pci_dev device lock is held, making it impossible to race
 	 * with ->remove().
 	 */
-	nvme_disable_prepare_reset(dev, false);
+	nvme_disable_prepare_reset(dev, DO_NOT_SHUTDOWN);
 	nvme_sync_queues(&dev->ctrl);
 }
 
@@ -3163,13 +3165,32 @@ static void nvme_reset_done(struct pci_dev *pdev)
 		flush_work(&dev->ctrl.reset_work);
 }
 
-static void nvme_shutdown(struct pci_dev *pdev)
+static void nvme_async_shutdown_start(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_disable_prepare_reset(dev, true);
+	nvme_disable_prepare_reset(dev, SHUTDOWN_TYPE_ASYNC);
 }
 
+static void nvme_async_shutdown_end(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	mutex_lock(&dev->shutdown_lock);
+	nvme_wait_for_shutdown_cmpl(&dev->ctrl);
+
+	/*
+	 * The driver will not be starting up queues again if shutting down so
+	 * must flush all entered requests to their failed completion to avoid
+	 * deadlocking blk-mq hot-cpu notifier.
+	 */
+	nvme_start_queues(&dev->ctrl);
+	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
+		nvme_start_admin_queue(&dev->ctrl);
+
+	mutex_unlock(&dev->shutdown_lock);
+
+}
 static void nvme_remove_attrs(struct nvme_dev *dev)
 {
 	if (dev->attrs_added)
@@ -3191,13 +3212,13 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 	nvme_remove_attrs(dev);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
@@ -3259,7 +3280,7 @@ static int nvme_suspend(struct device *dev)
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
-		return nvme_disable_prepare_reset(ndev, true);
+		return nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 
 	nvme_start_freeze(ctrl);
 	nvme_wait_freeze(ctrl);
@@ -3302,7 +3323,7 @@ static int nvme_suspend(struct device *dev)
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be rediscovered then.
 		 */
-		ret = nvme_disable_prepare_reset(ndev, true);
+		ret = nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 		ctrl->npss = 0;
 	}
 unfreeze:
@@ -3314,7 +3335,7 @@ static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 
-	return nvme_disable_prepare_reset(ndev, true);
+	return nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 }
 
 static int nvme_simple_resume(struct device *dev)
@@ -3351,7 +3372,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
@@ -3488,7 +3509,8 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
-	.shutdown	= nvme_shutdown,
+	.async_shutdown_start   = nvme_async_shutdown_start,
+	.async_shutdown_end  = nvme_async_shutdown_end,
 #ifdef CONFIG_PM_SLEEP
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
-- 
2.36.0.550.gb090851708-goog

