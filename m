Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736635EC82F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiI0PjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 11:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiI0Pir (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 11:38:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22B32D9B
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i6so5833825pfb.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OZfre6y8X3/4B07M8P4xvAZ/uXgSTWwdP6iF0eyc3Zo=;
        b=YVcw949RLQi6Vfxd9RBhsqjutTBGdVXDLCQrkleFHhddmkubwCvSGUjPp0jeYq8Okg
         nJSYRH2sk1mcsoapike4+TaRCyx8YSaw7BdQixbWZ+thcLplPRoc1aBayBTGIMTkCFjw
         58eyoMPFXFPMdUjzWXc6rTo/1vGs0aeV1kH3U8kF7LeRm+dCl25y9vJ6bSsz945iKXHR
         NdLjSpJnKBAm4hDkglg9/VXszQY/55+n3HlgTW9JKkPu6//OUNPvItdkV8oXMloIBdcQ
         Hgut1qRS/C+SJVxhHL+gTiwlvD0kAqQZUL215+tVDqpLxRn/fFNl+JUyrtPYuNDpOxxA
         NqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OZfre6y8X3/4B07M8P4xvAZ/uXgSTWwdP6iF0eyc3Zo=;
        b=ohbKHjErKMVfzUVT8J9l3hS20eXSOnyH9Yncwn1peow9RqVyMinMcs5LH3k5tH4VSg
         TIrXqoUAOTS43atCUhC/Q/IkaqIlPh6061afMO/sCh/4yXsOW4xgldeVJlTfl/Q0nT0j
         SriX5HN0g366tDCw+d6Y0ovHQjtyJbrm7iGAoMjTrgdlNNSyZ+zmOseCVPmySLXDAzxB
         WHXEJWwjWtbSifuXrCL3TpAnbs8md+wZg9NW7oLyPOLEp+JA+vd9KWg5DQW3A1eh5SQS
         t3HJ7GlzcfE8YnikQbfn/p68CSnEGjmn65SI/PIp3O6AD9p79+gfYJ+1Aqu4V17hycqr
         QG1w==
X-Gm-Message-State: ACrzQf3NUHlQI6mz/G3YJvpf0J6NrwSdBHLnhli4+UfBICdeX02NpujX
        iTpMzeSFw11WQJ1nHTECCDkuHg==
X-Google-Smtp-Source: AMsMyM7JgdxUN14V+KfxWlGjID9VjX0OjfSmFJ7PAvXH/UM5YQylgL4IzPthUMyFBJcrYlhpHwiIPQ==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr25336792pgw.599.1664292983110;
        Tue, 27 Sep 2022 08:36:23 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:22 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 1/9] PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
Date:   Tue, 27 Sep 2022 23:35:16 +0800
Message-Id: <20220927153524.49172-2-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sometimes we need to clear aer uncorrectable error status, so we add
pci_aer_clear_uncorrect_error_status() to PCI core.

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

