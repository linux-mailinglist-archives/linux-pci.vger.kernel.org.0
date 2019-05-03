Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFD126A3
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 06:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfECEAa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 00:00:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40206 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfECEA0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 00:00:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id w6so4153241otl.7
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/LOTiXEeUAfPkAgUbsTAKp8w078GVOXeJxP9ge1byF8=;
        b=XPNLyukTjtUR1G5C31oqERX/VOGrqG8DcQcBrRJG6f6svZDbARMyBVLoY2RQ7XP3H5
         dn+CQGhJ4qPQN1fAjcc/EyONtUj1g8bzZaN8cN62JG5g9IQX78lsdB4xMOwy9XibQLw/
         +rQYpwujO4bNYWWQmTEu5eVnpiY5ke3Jmea8tb2GUAtkoi6mXPkn3FNdI89YvYXAGIuF
         kbQiT6+N3f2g8PzPkUubXXunxMBm5o0c8fivT6YdrmSGedvrsRqqX7NQSgmC8jIzgW+B
         O71qBgrr7hSvt7jUpbjUiq0u0ladrZoTcPSKKhPVYw/5WmrXslxysNtoBneQIPVL08TP
         xoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/LOTiXEeUAfPkAgUbsTAKp8w078GVOXeJxP9ge1byF8=;
        b=k7WiMZaZwaoCmhKSZvMumJ9o8UZSgHPRrAXxlUwMHvCnByHaFxUDyiaNaKxHccNhCy
         NKQUq2RkALmEFCmlE6ylf6X8SA3FBBr5YTrxKZHj5D6hc8DJ3+Zu6TFGJzuqSsKjq+9B
         LrzgdvVo+9DRZrlx5CnqRLYlrTJsP+fquoH23bsLCaQvJErRKUufym9gKcIAtZVOJRLd
         CtXExz7DTShlO1WbvqbVENmNi25zLZ/FDCyJXDaGVG1s+YSh2nMPZgp6s11aGNyZyJcK
         DZX1ieHdReW/2MVDz1/kaZKh9Pvu28rvBiAofVccxuX3hlBD8CNcD5imM/rt6venTf9C
         Ju+w==
X-Gm-Message-State: APjAAAU9Z6rqu3tsKQjZgrdDxgnPodUcyVGXSFQoRDa0DMpgywxuLrmN
        pxh4NNLaCjj1gQnB5ptyIYLv/w==
X-Google-Smtp-Source: APXvYqyfPPmFNQcODBf5kR720aUXI7NwjTYQBV3YUQ7HVat65zmo8DoiqA8XMNbvn2APOVCm0w4sJg==
X-Received: by 2002:a05:6830:1251:: with SMTP id s17mr1398446otp.186.1556856026086;
        Thu, 02 May 2019 21:00:26 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id f17sm430149oto.5.2019.05.02.21.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:25 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 5/9] PCI/AER: Prefix dmesg logs with PCIe service name
Date:   Thu,  2 May 2019 22:59:42 -0500
Message-Id: <20190503035946.23608-6-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prefix dmesg logs with PCIe service name.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/aer.c        | 10 +++++++---
 drivers/pci/pcie/aer_inject.c |  6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 82eb45335b6f..e603084b8fc1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -12,6 +12,9 @@
  *    Andrew Patterson <andrew.patterson@hp.com>
  */
 
+#define pr_fmt(fmt) "AER: " fmt
+#define dev_fmt pr_fmt
+
 #include <linux/cper.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
@@ -1377,24 +1380,25 @@ static int aer_probe(struct pcie_device *dev)
 	int status;
 	struct aer_rpc *rpc;
 	struct device *device = &dev->device;
+	struct pci_dev *port = dev->port;
 
 	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc) {
 		return -ENOMEM;
 	}
-	rpc->rpd = dev->port;
+	rpc->rpd = port;
 	set_service_data(dev, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
 					   IRQF_SHARED, "aerdrv", dev);
 	if (status) {
-		dev_err(device, "request AER IRQ %d failed\n",
+		pci_err(port, "request AER IRQ %d failed\n",
 			dev->irq);
 		return status;
 	}
 
 	aer_enable_rootport(rpc);
-	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
+	pci_info(port, "AER enabled with IRQ %d\n", dev->irq);
 	return 0;
 }
 
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 95d4759664b3..d4f6d49acd0c 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -12,6 +12,8 @@
  *     Huang Ying <ying.huang@intel.com>
  */
 
+#define dev_fmt(fmt) "AER: " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -460,12 +462,12 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (device) {
 		edev = to_pcie_device(device);
 		if (!get_service_data(edev)) {
-			dev_warn(&edev->device,
+			pci_warn(edev->port,
 				 "aer_inject: AER service is not initialized\n");
 			ret = -EPROTONOSUPPORT;
 			goto out_put;
 		}
-		dev_info(&edev->device,
+		pci_info(edev->port,
 			 "aer_inject: Injecting errors %08x/%08x into device %s\n",
 			 einj->cor_status, einj->uncor_status, pci_name(dev));
 		local_irq_disable();
-- 
2.17.1

