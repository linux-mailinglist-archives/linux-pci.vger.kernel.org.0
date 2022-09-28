Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212E25EDB03
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 13:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiI1LCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 07:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiI1LBI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 07:01:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C0FD33
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 04:01:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s206so11905410pgs.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8Z/ugyVP4SSiBNTqiEXPWybAg+NaSbXcSQ5EW7ChSt4=;
        b=FHnm2AaDgGGL3Qb4S5rvtHWuJoHeyMlhpER41MQux4jSSHMRLmSauxip2U8Ls1Dd+Y
         19x3//5jQZghMH2wT1Gw9kAIothGyal7qXRDEfQmW+eZEnJwwIr6prp5dMhpipz8eGFX
         1MvRVNMEPcMMj1ZUz797NlbPTWYbgcHrYvxxJErlM36QkHTtLH55iGoTR9CKNc9+qxuC
         Jzc8mdsAQjxdzZsdZ5rdbM//fGbWf75NhkKFVlQTDRy4xtMVB9EbLMCogwmPXICPTXhj
         WtcORu4EtFGUkcjXR6FH4O8OTeKcf18OfFNznmBsUNtZx+rl204eixa8gkxPN5E//vcE
         b/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8Z/ugyVP4SSiBNTqiEXPWybAg+NaSbXcSQ5EW7ChSt4=;
        b=XIhE7p+Yf2NMunyx3eQQr3sW5MVei98x371ryxXmicmcsJ8AXX9WwvkRrkFle9ffmC
         MvoGWuGh9x3HF4PuNgSoQKVao76V4rg/BWhYBJtfTJ/O7SP4Ry3myISQVrva2n5+i7XN
         GqlDSs9q1iDcQaavnSXPqD4RpdgzxOoUXDeQ0JGgwU6jN9+ChvA/RS3J496UfR032BO7
         DAkxIMTncDshluYow9hmd6NCI3z00aSQjK6LHzB17Eh3Y9yYFiIcI6D+w1TwYrHzXRTW
         zRsbxuP5eWNtY6EuHPGI5OLd84f8uxbf/5Zm3Buw1HkUu+vd2NUgmGv/kDFrNuafI0KX
         F8Gw==
X-Gm-Message-State: ACrzQf1gg90xAeQGuGEaD+IqKslfg18VYu5BIUjf2OcaohaTe8wzW6Uz
        /KugL99zsIEzY0as70WRyMkrEQ==
X-Google-Smtp-Source: AMsMyM4ofQZRkpGFxs4XD0rXBl1JIn4/vMVBWhueuGH3CSuShGbXwzXsRpudhK5toT82OfIWlzxVcg==
X-Received: by 2002:a65:6d8d:0:b0:43c:9bcd:41ab with SMTP id bc13-20020a656d8d000000b0043c9bcd41abmr16631977pgb.303.1664362859624;
        Wed, 28 Sep 2022 04:00:59 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.00.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:00:59 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v3 8/9] PCI/ERR: Clear fatal error status when pci_channel_io_frozen
Date:   Wed, 28 Sep 2022 18:59:45 +0800
Message-Id: <20220928105946.12469-9-chenzhuo.1@bytedance.com>
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

When state is pci_channel_io_frozen in pcie_do_recovery(), the
severity is fatal and fatal error status should be cleared.
So add pci_aer_clear_fatal_status().

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

