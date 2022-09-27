Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52EA5EC835
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiI0Pjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiI0Pi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 11:38:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540651CE629
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so2744004pjh.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Q86dpO4MZD0CA12jM08xWGYyYtYWODVJgw7gnIuH5Tk=;
        b=IMIPIN6w3MO7MCbD7V3ThsGSRsp1g0IjueBKGf/11rJ6MD5qN4UR3XGmJipX9CK++6
         eiOchrYYinPyoOBn+0Y+rDP0uVRFImrpBNU1UDXtOMNUxPlRqmop3RFvpzPbyEybSG5F
         CRDPQ1enPFC99WOwYFVY2QZDmn8jSfY/zTlBpgKJUVPQ+lpJjVT0rmsBeR4eYvaQSxZK
         dvTm2obycBfI5P1tTJ+khPgiPLQGLeUoFr7m2HgOHrjHsPGgqHpQ2Yy3mDC88pmtuxyB
         YdSpANeZeOxf58GtYGN2R1FOht2o+Xmi4V/D1Ny4qiePO8a/2BpFtrT8iUKZBeNMTtOh
         RWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q86dpO4MZD0CA12jM08xWGYyYtYWODVJgw7gnIuH5Tk=;
        b=OE1D4HPOmEuFwUvCksAXLCg/INlyHIWGo4zsU9g5uIfNyiPxW48kZ5I+UF3/pHziRP
         mPUDR0S9zhcho1KqY7t9MW2AE8ef06MNmC9QXfzTiU1V9kGua59BYcmWdzJY5h6GBCHe
         VMzBPpgCkAZwPWOIuyAXjygCACZ00z76UodLWJijeDAKpJMLFBwfuxUbD1HkvjWjQmD8
         j1LAct45fo6Fs/U/8SkclKYOK4NT5KrQZllWJiUWMSksipq8yQ39+ZD9pCsqCPLWI663
         /Y6hixp/4ujhvAg5tDL4wIVnx+S4OCqYCsalN8GDROmq4z7qrc+dn/Klpx/J5vuvXmXu
         DHtA==
X-Gm-Message-State: ACrzQf2j7lEZhpEeyVDw7Hbaxqm7oSrN4Ancu0fA6rsmE+Ye91fvZq2s
        l+nz8QCm9Hm4XcNcUGi3ks2V1Q==
X-Google-Smtp-Source: AMsMyM5RaT7WFGyUZHFYqoVH6SiLBpf6gppnLFccPidOBspFk2OpmdxZsinWDsz9SjngtrgXs1RPug==
X-Received: by 2002:a17:90b:17cf:b0:202:95a2:e310 with SMTP id me15-20020a17090b17cf00b0020295a2e310mr5447237pjb.76.1664292992706;
        Tue, 27 Sep 2022 08:36:32 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:32 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 2/9] PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear uncorrectable error status
Date:   Tue, 27 Sep 2022 23:35:17 +0800
Message-Id: <20220927153524.49172-3-chenzhuo.1@bytedance.com>
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

Use pci_aer_clear_nonfatal_status() in dpc_process_error(), which has
no functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3e9afee02e8d..7942073fbb34 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_uncorrect_error_status(pdev);
 	}
 }
 
-- 
2.30.1 (Apple Git-130)

