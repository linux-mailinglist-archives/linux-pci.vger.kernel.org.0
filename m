Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C331126A5
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 06:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbfECEAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 00:00:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38682 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfECEAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 00:00:16 -0400
Received: by mail-oi1-f196.google.com with SMTP id t70so3472038oif.5
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 21:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rUTSw74gexjNwzq9ZLmaaBHpeJsduJxpcMlGupfmHG4=;
        b=ZI/oDJADO4rOIoCDUnEV0PbQiau5ydorvrx+xZUz6wqYvpFKXYpKjD09gcXjvLJpdH
         2cQCCQkAcf+0n06uPKjdHDUPcXEiKHbg9eHm4XK5AKX46KEiyP+pPzgBnYQefV/+vyFh
         cKwAIAGh1P4P5VUSJXf4iQx4iVu1ouPvCqcGu2oL9SU61i14VDndeWAEL2v38AtIDuwz
         NfC49wl8dxQpI9tFDfxwSsZT0qZQ84eYQLUd8B2wLOvZph01gOCgwANcJvzZ1M9yJi2X
         QFstesEHaDZOYE2n1xzsV0Y0VgXBrnuSBUuBnbB9Zukz/1DEfi6xPsaduTPskGLbajRv
         KE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rUTSw74gexjNwzq9ZLmaaBHpeJsduJxpcMlGupfmHG4=;
        b=jXUc4VQKGuHGr/DTpfoDzFOldCuLPZJVi47uhGsQr7ApzfcRnCrbJonBGb4gpnlve3
         x4yMxjZ9pNMCHC5g+Fdos8dUUvKpfTEdgMIvdqTQ96CnPGRjk6P6rmprDVLCnpNy5qV9
         IxEQ/3QcxsHlFdPTgP8nwhGrjosbPeFuZGXASD/xDMEt0kyVOdS+RVe0ogFovtFdkBHC
         aN7mKVoUiHgHHHqDl/6YfCXqY+ou0rDpcTSiEO8ja9gmckpNGtwllQpSYF32FTvPOVMD
         sicH/hlNNiGgU+ag2812beSMEgdE924qV6B5y1NjLUp8xC85o3R3SkDOgHSxtjea+hN5
         yMOQ==
X-Gm-Message-State: APjAAAVc+Gu8sUwMQjEOImz0USFqBDjJoE+vsYy32kUQIGIUzf0wnLyZ
        glM6D8cr6xBBU0lkVyhP5IVfZg==
X-Google-Smtp-Source: APXvYqytlEstswINkPkyIA6Dj4cZY6kaWgFkfd4RiLPYDmMNxSqqtMj7RyWp3JbDg58d1b+iaPcNAA==
X-Received: by 2002:aca:5b85:: with SMTP id p127mr4620755oib.90.1556856015507;
        Thu, 02 May 2019 21:00:15 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id 20sm622436oty.58.2019.05.02.21.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:14 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 1/9] PCI/AER: Cleanup dmesg logs
Date:   Thu,  2 May 2019 22:59:38 -0500
Message-Id: <20190503035946.23608-2-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cleanup dmesg logs.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/aer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f8fc2114ad39..82eb45335b6f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -964,8 +964,8 @@ static bool find_source_device(struct pci_dev *parent,
 	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
-			   e_info->id);
+		pci_info(parent, "can't find device of ID%04x\n",
+			 e_info->id);
 		return false;
 	}
 	return true;
@@ -1380,7 +1380,6 @@ static int aer_probe(struct pcie_device *dev)
 
 	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc) {
-		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
 		return -ENOMEM;
 	}
 	rpc->rpd = dev->port;
@@ -1389,8 +1388,8 @@ static int aer_probe(struct pcie_device *dev)
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
 					   IRQF_SHARED, "aerdrv", dev);
 	if (status) {
-		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
-			   dev->irq);
+		dev_err(device, "request AER IRQ %d failed\n",
+			dev->irq);
 		return status;
 	}
 
@@ -1419,7 +1418,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
 	rc = pci_bus_error_reset(dev);
-	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
+	pci_info(dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-- 
2.17.1

