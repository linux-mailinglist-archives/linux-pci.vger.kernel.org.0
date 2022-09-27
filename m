Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6375EC852
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiI0PlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiI0PkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 11:40:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78341481C3
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n7so691429plp.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jrue3xDv2fahH0oRb0ZfoidxKvGLRwE7ZIzpUZAJ4Nw=;
        b=t97e6+ByJ/znAh9op7r/0INVD9/ePdia6obzzM84V/fa4k0PkB8CTggLpqdkmQSQxw
         jPd7dB99HsoumE0BHyoTkal01PjHX2wkJpeP/6HmLwxHhvMSpGCr5ibn6dD8EZ7Sj/rn
         04VNNXm7c68IcpJ6T3+yeEWknEZodWqZ3I31OZesH5Zmc7YMzL/EcDynSOKl5JP9zdPe
         V6dsr5jfhPndCyvIe921MSiKUupw6yBVmtvJgVplkpl+lgCfgsl+uXky/HN/txddQC8i
         QRxcmp/RPPC82K6CC8WaHFIjjhjraR6rlUGNHe5BKYQPpOqfKmOPFXtuNA/EangO43bl
         K+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jrue3xDv2fahH0oRb0ZfoidxKvGLRwE7ZIzpUZAJ4Nw=;
        b=Eyq3ZPdgnqi99ju4x9HFhiF+EyBxYyx+bSAG/p0+qiBUD5mkOeJdlx0w8peVYoM7ji
         m3kIhAHmCzoK9/8Qk3ra3ijTb63na73wxMnEhybdbfxJoQ17j6n5mCbW0rIcxivmTb1u
         NlEcdrR+o7zpjv3AZUjxj8F+TtzMiMC3gPIjIU/O/uJW5QmKsjtelIR0YmUcWJR67rCH
         zpW1kKQIiSTJrElZ/4b0AklGtp/2WfamsAvY/Fx/sJgl9wqPHuSFZwO6beg+D5HwO7uN
         3V+Fo6B6szPpk+sRO1azEYopYALp/PolBurPUMmpob8aMJ/68ItcvyE/wUWGz7vxbE4x
         0f8w==
X-Gm-Message-State: ACrzQf1FdjaV0dZRsn39kWNicr/VR/MveONqhg5JoUuE1VDOQ1ExS4Nt
        /BUkx6kXIg2iLgA2d/kKlQ0KV+OnxBQ+Mg==
X-Google-Smtp-Source: AMsMyM4mzGSMzMrGQb4AEYHMI3z1A4zjn9jLaUxhhhISN8nn4Omuv8b/L9w4e1lSWVjTg9NQtpY+TA==
X-Received: by 2002:a17:903:32cf:b0:178:3d49:45b0 with SMTP id i15-20020a17090332cf00b001783d4945b0mr27706370plr.5.1664293046628;
        Tue, 27 Sep 2022 08:37:26 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.37.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:37:26 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 9/9] PCI/AER: Refine status clearing process with api
Date:   Tue, 27 Sep 2022 23:35:24 +0800
Message-Id: <20220927153524.49172-10-chenzhuo.1@bytedance.com>
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

Statements clearing status in aer_enable_rootport() is functionally
equivalent with pcie_clear_device_status() and pci_aer_clear_status().
So we replace them, which has no functional changes.

After commit 20e15e673b05 ("PCI/AER: Add pci_aer_raw_clear_status()
to unconditionally clear Error Status"), pci_aer_raw_clear_status()
is only used by the EDR path, so we add note in function comment.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/aer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a6d29269ccf2..bd5ecfa4860f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -306,6 +306,8 @@ EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);
  * Clearing AER error status registers unconditionally, regardless of
  * whether they're owned by firmware or the OS.
  *
+ * Used only by the EDR path. Other paths should use pci_aer_clear_status().
+ *
  * Returns 0 on success, or negative on failure.
  */
 int pci_aer_raw_clear_status(struct pci_dev *dev)
@@ -1277,24 +1279,17 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 {
 	struct pci_dev *pdev = rpc->rpd;
 	int aer = pdev->aer_cap;
-	u16 reg16;
 	u32 reg32;
 
 	/* Clear PCIe Capability's Device Status */
-	pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &reg16);
-	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
+	pcie_clear_device_status(pdev);
 
 	/* Disable system error generation in response to error messages */
 	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
 	/* Clear error status */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
+	pci_aer_clear_status(pdev);
 
 	/*
 	 * Enable error reporting for the root port device and downstream port
-- 
2.30.1 (Apple Git-130)

