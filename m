Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAABE6A6783
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 07:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCAGFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 01:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCAGFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 01:05:03 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340A637F00
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2023 22:05:02 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso6985897ota.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2023 22:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7kVT/oItrmYbZ6vjI5pXv35SY2pScZG5pla4txXLGUY=;
        b=PQl3CKAcs5i1UuCdr43Q0EBCuIOFz0kxigPphBJQy0Fc1oosErTNFQBOy0uFTzq7Mp
         6we6/MWuXVzgzTDB2BvRXd3pTL+hDBecMULY0T7vrYcXWZ2D8CBllogx22dlZF+Wjg6A
         AYh4Fe0vyRU/4l6aRAz5q+L2I6+UiAWEKLSyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kVT/oItrmYbZ6vjI5pXv35SY2pScZG5pla4txXLGUY=;
        b=sA91Usq/NlqZ4RtuRUHv87S8ztGiXEBM0y0Y/PsgQxnrjctOaIiViBUPsjTmh1KYZ9
         fzhiEtslxG0aOKsuJunId4K6rsKY/MA6QOvmyW1nQ/DgBtoUZAXEVXDka5EZMHHHKKkD
         DMg6IymV5jknKLfmC9Vw0U82dHklqYGnHSqfstggRWN2WoTqrFswRgf7QqVpoJ7o9rZx
         kFrPLFUj1wIqcjKUmtTyjwn2ulIuMtA+thHLWmCCNTOcKc8hd3vEk5I/9FHoDPMzNSIz
         Hb7x1/AxRDNA7B3ZXgQS23qgLjF9R9g66cLUliouQCpfkcYzS1OjKk4S1z42YSAgbWbp
         kH5g==
X-Gm-Message-State: AO0yUKV6xXgdEwAHCfZS8mXiAwpyT6Aky/aqr8zqitLEi7U7hGPu+Fcm
        x0sCje3R9eNthx2MbBOnYggYhQ==
X-Google-Smtp-Source: AK7set8ZnCu/zmySz52YJsLN8IT9WjXKXUtbDOsW2C0cBroFnnvstBXnX4kQoVqUGCDznnm2HGc3DQ==
X-Received: by 2002:a05:6830:4414:b0:68b:dfcc:bed with SMTP id q20-20020a056830441400b0068bdfcc0bedmr3489242otv.15.1677650701532;
        Tue, 28 Feb 2023 22:05:01 -0800 (PST)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id g21-20020a056830309500b0068bc48c61a5sm4599539ots.19.2023.02.28.22.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 22:05:01 -0800 (PST)
From:   Grant Grundler <grundler@chromium.org>
To:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O \ 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH] PCI/AER: correctable error message as KERN_INFO
Date:   Tue, 28 Feb 2023 22:04:53 -0800
Message-Id: <20230301060453.4031503-1-grundler@chromium.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since correctable errors have been corrected (and counted), the dmesg output
should not be reported as a warning, but rather as "informational".

Otherwise, using a certain well known vendor's PCIe parts in a USB4 docking
station, the dmesg buffer can be spammed with correctable errors, 717 bytes
per instance, potentially many MB per day.

Given the "WARN" priority, these messages have already confused the typical
user that stumbles across them, support staff (triaging feedback reports),
and more than a few linux kernel devs. Changing to INFO will hide these
messages from most audiences.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
This patch will likely conflict with:
  https://lore.kernel.org/all/20230103165548.570377-1-rajat.khandelwal@linux.intel.com/

which I'd also like to see upstream. Please let me know to resubmit mine if Rajat's patch lands first. Or feel free to fix up this one.

 drivers/pci/pcie/aer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..e4cf3ec40d66 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -692,7 +692,7 @@ static void __aer_print_error(struct pci_dev *dev,
 
 	if (info->severity == AER_CORRECTABLE) {
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
+		level = KERN_INFO;
 	} else {
 		strings = aer_uncorrectable_error_string;
 		level = KERN_ERR;
@@ -724,7 +724,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
+	level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
 
 	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
-- 
2.39.2.722.g9855ee24e9-goog

