Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83399421101
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhJDOLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhJDOLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:11:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB98C0613EC;
        Mon,  4 Oct 2021 07:09:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a73so13709617pge.0;
        Mon, 04 Oct 2021 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pWZxY1yQdsUwMEG6Is0voI7d8xdXhwobuZZscOdeBw=;
        b=Js7Xodu0nHhuvSavGENRD7gNVR5pT8HpUmkI/DCIAemabFBiB2j8txmoJi60UN2wz7
         SplCKi1ivWiqz5DQU22S3UdHDUHlnjT50HUj57rb6cHL8lv1FIQ+tk0TtBFT/aSdngIM
         PLPwGvq3+XePTs1Ct0w5u2n7g1U3huhkAl5C2b3msfBXagXusMaGsOqVsqik9AHNCQ/V
         Uzya6SJ483hXPTgTNhFV9AoCaBADy1Q1hYjvMF2EtTGqPrHPWs+vMD/hzYDrfbM5xY5x
         eIcH1co5ByBIMW8+kZJkl1tpY+QoDvdpmB9lycLskfFBmiAAzj1W8URYEw5OfPRpcsIM
         qvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pWZxY1yQdsUwMEG6Is0voI7d8xdXhwobuZZscOdeBw=;
        b=h5cyBmbdV051zQIctqLytUE1FpMdvPPZBTYapgWroinjcRTGb4xPloNICG6FaxomnO
         q2CaII1Mpt38AAwaXy/6Sw/btwUGNLuoAtQyKilFuT+Jqm4nDbxVly/NQTJmqFj6sWjq
         HFzPS43N49vYtyQYddbHazoKiJDWo8Pq5AL/Kdo2A0/XTAw9UKKvdQ4fXVhJcfNCiFfK
         ZCr24HK/Br8rRxCW3+aBeSmaa8taxjVcAlb8DJmiJbiZ1GKCUo+T0nmBKKNlKrCjUICw
         A/wa4r1DCi/WAX1FcLOhCm8mliHtw1XMWZ8FXAGyUduiHe5OuA+yX4MhTB7otjrHc8kO
         CeMg==
X-Gm-Message-State: AOAM533w/2tZA+1ClXtvlEGJb1x0TAzDzMM8TDeghvUnCBF2XIWMuiIg
        Ew/D4dRyBxpp2ScWFkaRPDE=
X-Google-Smtp-Source: ABdhPJxnSXAXJi5hIp0lOUtzf1x/yRQWj+SNX87vbBVD0ZjCAXsG4FzalqJCMIQUHnpIX3Je5Wswcw==
X-Received: by 2002:a63:a112:: with SMTP id b18mr11069605pgf.387.1633356557863;
        Mon, 04 Oct 2021 07:09:17 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id p2sm15274135pgd.84.2021.10.04.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:09:17 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH 8/8] PCI/AER: Include DEVCTL in aer_print_error()
Date:   Mon,  4 Oct 2021 19:36:34 +0530
Message-Id: <e39df4392e514bae8dbd373a3c92d994d8c2ae49.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Print the contents of Device Control Register of the device which
detected the error. This might help in faster error diagnosis.

Sample output from dummy error injected by aer-inject:

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000, devctl=0x000f
  pcieport 0000:00:03.0:    [ 6] BadTLP

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index eb88d8bfeaf7..48ed7f91113b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -437,6 +437,8 @@ struct aer_err_info {
 	u32 status;		/* COR/UNCOR Error Status */
 	u32 mask;		/* COR/UNCOR Error Mask */
 	struct aer_header_log_regs tlp;	/* TLP Header */
+
+	u16 devctl;
 };
 
 /* Preliminary AER error information processed from Root port */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 91f91d6ab052..42cae01b6887 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -729,8 +729,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x, devctl=%#06x\n",
+		   dev->vendor, dev->device, info->status, info->mask, info->devctl);
 
 	__aer_print_error(dev, info);
 
@@ -1083,6 +1083,12 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	if (!aer)
 		return 0;
 
+	/*
+	 * Cache the value of Device Control Register now, because later the
+	 * device might not be available
+	 */
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &info->devctl);
+
 	if (info->severity == AER_CORRECTABLE) {
 		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 			&info->status);
-- 
2.25.1

