Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1E5EDAE5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiI1LBQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 07:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiI1LAt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 07:00:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9285487F95
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 04:00:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso3074780pjq.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/lUorqWHVGRnAT88EYIdYelQLnJZ6JU0rZvIuXw4R/I=;
        b=eFgcRFG8rZyt+ZzLjBVqt80mtlecZJilGFgBqp58JU1Th4+tjpU45u+gTrJURz6bU5
         PZAKAIfYGUPeGJVCZmJg3vuzIfVwjnpOKC5ZUeOa4l5p7zXBugRQL+YNsLY/0707Lyn9
         +qi4Uy0poKd8Sa4di3uUH+bWu2LaE4sKFOthWF/BkPiaa60pme+zM70DdJ8bi5BHQRrd
         zTgZFxfVJ1KS7X/LARzkICgCaD/+fH3z7w2NTbKIQJuAcpKztxzFV3FqhvJxhvv9Ztsp
         m+we2ILuvR+mw7GbnzjEDY/mut4/9s5b7+B54gO+wZHygWoM1S92vyJYtTH4k9+Pr7DT
         h49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/lUorqWHVGRnAT88EYIdYelQLnJZ6JU0rZvIuXw4R/I=;
        b=2sCscAOvkNjiuWm8SG9HA83tUHS+XMANUsIy/YK+e9x/c6o7ykLYwC8bxbG5XR/wwJ
         5l57SHETJm4kVsZQ7qFGYlcuO/MZRXFUfBZpXKJGzgjYThtxv5jxW4B3MQC2bB7aWxKb
         9nD7u1r/urScpYI+xp1G4C48iKO4PpA562UCH2l5iPwtbh0+9N36DYO2SiKOU5f78AEC
         Pp7rU7XOB+IXmuRBmrmDlsO5pEV0IeBNOpL1KD/TYnCHDpi2Fm74zqrpTjLgGYEcaHwB
         8bjAdWdSsDN8Srz1BIUefAWeEFcjAU7tfxoP9PHWaBo1dkVLfVoe6gjwd2v5FPNcYzHe
         xCrg==
X-Gm-Message-State: ACrzQf3iP2gpZe79w9HD9LLH5didjKj16nvx4k4Bh2nLgCDBGjZuy+yo
        CpmtRe8943uWUaBBI7McqAxJXQ==
X-Google-Smtp-Source: AMsMyM7nBvyxUePl2eO0BDL+QbLpFrILFxB/8WP0FtnmYokq9Cgk3HqUDyZWcIKuWIYPint1G/hLIg==
X-Received: by 2002:a17:902:e154:b0:17a:606:6431 with SMTP id d20-20020a170902e15400b0017a06066431mr1417596pla.107.1664362806820;
        Wed, 28 Sep 2022 04:00:06 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.00.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:00:06 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v3 1/9] PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
Date:   Wed, 28 Sep 2022 18:59:38 +0800
Message-Id: <20220928105946.12469-2-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In lpfc_aer_cleanup_state(), uncorrectable error status needs to be
cleared, which can be done by calling pci_aer_clear_nonfatal_status()
and pci_aer_clear_fatal_status(). Meanwhile they can be combined in
one function (the same in dpc_process_error). So add
pci_aer_clear_uncorrect_error_status() function to PCI core and
export symbol to other modules which wants to use it.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/aer.c | 16 ++++++++++++++++
 include/linux/aer.h    |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e2d8a74f83c3..4e637121be23 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -286,6 +286,22 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
 
+int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 status;
+
+	if (!pcie_aer_is_native(dev))
+		return -EIO;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
+	if (status)
+		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);
+
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
  * @dev: the PCI device
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 97f64ba1b34a..154690c278cb 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -45,6 +45,7 @@ struct aer_capability_regs {
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
@@ -60,6 +61,10 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 static inline void pci_save_aer_state(struct pci_dev *dev) {}
 static inline void pci_restore_aer_state(struct pci_dev *dev) {}
 #endif
-- 
2.30.1 (Apple Git-130)

