Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3216D6BF021
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 18:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCQRvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQRvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 13:51:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3376E5012
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2023 10:51:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b20so3594939pfo.6
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2023 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679075475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=43JEK5+W42TYEVE1MBp+nwf6FlyScDxxoIeOAiKETT4=;
        b=at5KvBs/SsIFLhrCajDj+2ic58nt7EptrKDtknXhQyBiYh/rAUI3ogSmrYqt6r3Gzn
         bHrDDY5UIhKRqNAowpUUTxn0EYu+FC9AqeqqAFiQKIDeAas23IEFiA67dTSaXCdSBU9l
         ItdKt7AaQIyuqKDwisBPlp2zCArEIOipSriZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43JEK5+W42TYEVE1MBp+nwf6FlyScDxxoIeOAiKETT4=;
        b=G64Kzv8+I6VAgdu1ValHnkYMzBSk1LzZeMDts4labCYWKJoIChmWEllTGoLAdJE63r
         ZKfOblAsvF9amVjUlty1vRele4lsIwQyBx14iWWzLmXdiBwhP4jq5BkBpKhdMf3Qdz8E
         TMSxZqSmmXNutRqEFeXCxxYAl5PYDuQz2YiaOlL/dAVwElDrK3zSZ2wleBF5Ml3O2cD3
         +c3os5KEQY16kOZ/lu8xxqEJckNiklqIuBTcdOJ41lFh/bq2ViHt0T2glxa/MfhBgyMb
         eNcEKn4oIliMbirYKYUisAe0RlMYqnqAvZnSISVe0ncjOPfdhe2BPaMNSjX2nDoH9Kkf
         CbBA==
X-Gm-Message-State: AO0yUKXdRB2gyjKfL7BWbURco24AaTUM0Sp1fH46+Ny2WVZ5vt3MdMHP
        c0vesmDC9zF35MFCGBKEazZ+TA==
X-Google-Smtp-Source: AK7set/sYgh4Viredkz8vxjuTOp+i2zpVLHfDM0VoUKo3EbkAWqX4wGgB33MW0KiGOp4ARCopur8Ew==
X-Received: by 2002:a62:6105:0:b0:626:237c:bcfe with SMTP id v5-20020a626105000000b00626237cbcfemr3032153pfb.8.1679075475442;
        Fri, 17 Mar 2023 10:51:15 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id q20-20020a62e114000000b0061949fe3beasm1848113pfh.22.2023.03.17.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:51:15 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O \ 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCHv2 pci-next 1/2] PCI/AER: correctable error message as KERN_INFO
Date:   Fri, 17 Mar 2023 10:51:08 -0700
Message-Id: <20230317175109.3859943-1-grundler@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/pci/pcie/aer.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..cb6b96233967 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -687,23 +687,29 @@ static void __aer_print_error(struct pci_dev *dev,
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
-	const char *level, *errmsg;
 	int i;
 
 	if (info->severity == AER_CORRECTABLE) {
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
+		pci_info(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
+			info->status, info->mask);
 	} else {
 		strings = aer_uncorrectable_error_string;
-		level = KERN_ERR;
+		pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
+			info->status, info->mask);
 	}
 
 	for_each_set_bit(i, &status, 32) {
-		errmsg = strings[i];
+		const char *errmsg = strings[i];
+
 		if (!errmsg)
 			errmsg = "Unknown Error Bit";
 
-		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
+		if (info->severity == AER_CORRECTABLE)
+			pci_info(dev, "   [%2d] %-22s%s\n", i, errmsg,
+				info->first_error == i ? " (First)" : "");
+		else
+			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
 	pci_dev_aer_stats_incr(dev, info);
@@ -724,7 +730,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
+	level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
 
 	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
@@ -797,14 +803,17 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
 
-	if (aer_severity != AER_CORRECTABLE)
+	if (aer_severity == AER_CORRECTABLE) {
+		pci_info(dev, "aer_layer=%s, aer_agent=%s\n",
+			aer_error_layer[layer], aer_agent_string[agent]);
+	} else {
+		pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
+			aer_error_layer[layer], aer_agent_string[agent]);
 		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
 			aer->uncor_severity);
+	}
 
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
-- 
2.40.0.rc1.284.g88254d51c5-goog

