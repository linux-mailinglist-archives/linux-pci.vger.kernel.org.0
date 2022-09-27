Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B545EC834
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiI0Pji (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiI0Piz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 11:38:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487141CEDF8
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso1102295pjh.4
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AFdCbuK2STwU1a0Nvf1lTDCDj1ToB//H9Q+bBUP1Qko=;
        b=NvRgdBCT61Gudxqofirgx5th8IhGdXVH8ploDF6qA3ooguYlkZg71QV76whvsg9N6l
         R4KzgPkWN0h5/4Wa+jfAUT3X64/ZrWIc657LewcLsRa8odQNcnMLsWGTFDRG8vyEoBXq
         TJavhn1JY3shjpKopxaVJH4TRh6fLbyxkkYpmDlWls5S86f+jRYvc4HcSKwwjuTZetKu
         nRDD15OmlhogeMrBS17ayxlWc9/04/Cg6th9rUmLkxtuPjumSS559ESr/I/y3Z9c7fIn
         wpKIHX66ByA5ce2JXGh+pHeaqv7pxm0/5tBguNnJcxWHUMej+FaDDZah39r9lluVzFcQ
         XCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AFdCbuK2STwU1a0Nvf1lTDCDj1ToB//H9Q+bBUP1Qko=;
        b=1OjahSHb+eiRoSYQxAjgM/W44P8807fP2lqo+dOT51f/8LdNISv4rVd/Arg69PKhKd
         Msa5xuSvwOu4N/INmJaaR7+T4Afm/JiMC69CbUygj3hsnVtqSmQsQubj4j55CkKJYdFg
         3nU7DgrAzHwPlrb6I0W7/2UOLDj667nFifx6ivJ8g3OwifwWRVBMZEs0T6e9tfN7weX9
         3AKCT7jfQnQsmsTF/1QybSppqgqpisDUG29DN80qhhrZSglzTxLmPO2N4TY3yXJQ7iX5
         Cg4fCPDVQ0upvaLjb+TEBxpxNR9vM3ykc8UWkS1HMJeq6dJqKf06Pt2jNP0JL8homsvu
         4a+w==
X-Gm-Message-State: ACrzQf1a8rhzRqEZD2TQaq3Eq6zxMo+wreAVVHaywmQjVCTAIhmVy7ck
        ldQvD47jUcB35sz3JGr0eJziNw==
X-Google-Smtp-Source: AMsMyM5jyEmlaQH+Y1BsFMdvCalgfAKFQCnd9GdR1AeXlRDMfov29pS4+9anTO+gz3gmL+s4K9nTMQ==
X-Received: by 2002:a17:90a:6405:b0:203:6eaa:4999 with SMTP id g5-20020a17090a640500b002036eaa4999mr5266575pjj.8.1664293039489;
        Tue, 27 Sep 2022 08:37:19 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.37.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:37:19 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 8/9] PCI/ERR: Clear fatal status when pci_channel_io_frozen
Date:   Tue, 27 Sep 2022 23:35:23 +0800
Message-Id: <20220927153524.49172-9-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
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

When state is pci_channel_io_frozen in pcie_do_recovery(),
the severity is fatal and fatal status should be cleared.
So we add pci_aer_clear_fatal_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/err.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f80b21244ef1..b46f1d36c090 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -241,7 +241,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_walk_bridge(bridge, report_resume, &status);
 
 	pcie_clear_device_status(dev);
-	pci_aer_clear_nonfatal_status(dev);
+	if (state == pci_channel_io_frozen)
+		pci_aer_clear_fatal_status(dev);
+	else
+		pci_aer_clear_nonfatal_status(dev);
 
 	pci_info(bridge, "device recovery successful\n");
 	return status;
-- 
2.30.1 (Apple Git-130)

