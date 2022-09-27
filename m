Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8755EC83D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 17:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiI0PkD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiI0PjP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 11:39:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170BF1CE61A
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b5so9736376pgb.6
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pu5CUxxvzQDPV1MrZt0eySYk5qcgDQDMRS6x862FR3M=;
        b=hpOlDxF35EkFZOgnZUEUpb7bfMeNXlEs/6zeqAK6eTGvVycSXxN5mhIMc9S8WfoaF/
         cwWs267qASx0e+WT1TwXng5S9nSyp1dRWH7rUpDXZLoP8jh/myCkq/Dpt9Ocv61bMCrX
         KCVkGQ/DsIqrtNOayppyBxQYmf/6pDTp8loAtnshKT2GVLI7NiICfkvNXNmQwARXA4ba
         w7biRtQ/LR4lB7JOHBHhVgKhVaVGPDngj0vRuIKmH6akrigtDtDlTjL6PpQqW/lzhXea
         fBVQ0A2O0oriv/fWIVwEeR77bbp0SvmTpT9sZNgGsqs2ciLylmpapoYCcXrGggb+tFGz
         ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pu5CUxxvzQDPV1MrZt0eySYk5qcgDQDMRS6x862FR3M=;
        b=iuA4yyWREoGwS+dhr7l939dopEJvFNgTCsLQOPJhV0NfU44ysxrXjAHX6kGvYqhAZD
         folUSlQmyazKYQlyf+YUhJNMBkF+gLMUmKd6BBtGlFXvZmbXXpRtKGkmkXThhPVzPGja
         OtDpm7szWTa3I8iyzyxV/uryj5RE04DybJp0DGSGZFzoBH9FQWFhDnjxEZxF3JWRvBx6
         gfpYaKOu66dhqf6+z4rkWG6nQpySIDKi7y3RfyY7DVRJcKSeo2m323Ll21AuiITwhGQ2
         8/W/LGNe1lD7Qhgdn4zmvmU82LqIJE5D5G62Puy1ypFyej3jW+N3Vc1mDh0OUgY6HDzj
         ISfA==
X-Gm-Message-State: ACrzQf3R6o0TVKbjmJJQ33VLrkOHijDdNwIPjjzFAy8UiGCn0hHhfsPC
        9sSke1TP+PazHwm2stl9CQYYHQ==
X-Google-Smtp-Source: AMsMyM5Rm9HIrz8bymvsH/euOjrFQJ4/XBJHdRa6nFHuOBrWJvQLmhDheo/pfwZ79K47Gzo473rdQw==
X-Received: by 2002:aa7:8c4e:0:b0:54e:fa98:5031 with SMTP id e14-20020aa78c4e000000b0054efa985031mr29740531pfd.44.1664293002852;
        Tue, 27 Sep 2022 08:36:42 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:42 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 3/9] NTB: Change to use pci_aer_clear_uncorrect_error_status()
Date:   Tue, 27 Sep 2022 23:35:18 +0800
Message-Id: <20220927153524.49172-4-chenzhuo.1@bytedance.com>
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

Status bits for ERR_NONFATAL errors only are cleared in
pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
error status in idt_init_pci(), so we change to use
pci_aer_clear_uncorrect_error_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 0ed6f809ff2e..d5f0aa87f817 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2657,8 +2657,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	ret = pci_enable_pcie_error_reporting(pdev);
 	if (ret != 0)
 		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
-	else /* Cleanup nonfatal error status before getting to init */
-		pci_aer_clear_nonfatal_status(pdev);
+	else /* Cleanup uncorrectable error status before getting to init */
+		pci_aer_clear_uncorrect_error_status(pdev);
 
 	/* First enable the PCI device */
 	ret = pcim_enable_device(pdev);
-- 
2.30.1 (Apple Git-130)

