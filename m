Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD56BF023
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 18:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCQRvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCQRvV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 13:51:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE3EE503A
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2023 10:51:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so6037820pjz.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2023 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679075476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r1WhvyKSBCJVCHAYDyDm94/mvsRvq4dBSf7I61xoxs=;
        b=UBRYAWa0HLHlLIh4eOYDdiXjSbkgBB4MZb4Mq2Gnlmscik1Joax9SF47VL6Y38yV62
         5WJzPjjlS7dcbf0MpfP7wKFbNGvCB52nxOljJWMjdRcpPuGr2NU993xreY7wp1sRmhMe
         M6k+jXQ/2Paj5NEdkF39VTDAmrUuQL59IT9ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r1WhvyKSBCJVCHAYDyDm94/mvsRvq4dBSf7I61xoxs=;
        b=dYELI/TY1L21bt26OA/vty4PIyeo7cbmPQTlXZNHstJeTXCrlI/EL9xXuPqJxg2790
         jRroOkSsIOps9gqbchs0pPEHqS2uAtFw4FqRvRItLCnkbrVXB4bInaiYhWVgeF5E9qFp
         EIp2EobwXTnkLvczpApPMdv04e+s4y2f7JOqoFRMgRVti0bhi+W51F5ajj4gOqPodYZv
         qqoSWKkvRV1SLga9qcgnCyTVRTL+EhndZAPdoBvbvhRa3rBi0+MPCTqmfu43HG/KX0R4
         AryVpV4Jd9L+JP1UapnIBCDY8UVnvTE3anleLgk9B7BN/W1TFHzJrg0cViThBeni0fXU
         uzvg==
X-Gm-Message-State: AO0yUKV2LFKch11ZobhI34Z2MiccMGPxAO5HOBPXfBWdhOi43gStvTaq
        lmbMs0RpopxEdFYjCp/OEUCxaA==
X-Google-Smtp-Source: AK7set/sQyoWYUEGFHlwyoIs+exsMbHe/kPJa4crxSUkdewCyt37oTeNx3BFtEY/Jq6XDcZaojzADw==
X-Received: by 2002:a05:6a20:6699:b0:cd:832c:f9c6 with SMTP id o25-20020a056a20669900b000cd832cf9c6mr8447401pzh.1.1679075476474;
        Fri, 17 Mar 2023 10:51:16 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id q20-20020a62e114000000b0061949fe3beasm1848113pfh.22.2023.03.17.10.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:51:16 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O \ 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCHv2 pci-next 2/2] PCI/AER: Rate limit the reporting of the correctable errors
Date:   Fri, 17 Mar 2023 10:51:09 -0700
Message-Id: <20230317175109.3859943-2-grundler@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317175109.3859943-1-grundler@chromium.org>
References: <20230317175109.3859943-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>

There are many instances where correctable errors tend to inundate
the message buffer. We observe such instances during thunderbolt PCIe
tunneling.

It's true that they are mitigated by the hardware and are non-fatal
but we shouldn't be spamming the logs with such correctable errors as it
confuses other kernel developers less familiar with PCI errors, support
staff, and users who happen to look at the logs, hence rate limit them.

A typical example log inside an HP TBT4 dock:
[54912.661142] pcieport 0000:00:07.0: AER: Multiple Corrected error received: 0000:2b:00.0
[54912.661194] igc 0000:2b:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
[54912.661203] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001100/00002000
[54912.661211] igc 0000:2b:00.0:    [ 8] Rollover
[54912.661219] igc 0000:2b:00.0:    [12] Timeout
[54982.838760] pcieport 0000:00:07.0: AER: Corrected error received: 0000:2b:00.0
[54982.838798] igc 0000:2b:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
[54982.838808] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001000/00002000
[54982.838817] igc 0000:2b:00.0:    [12] Timeout

This gets repeated continuously, thus inundating the buffer.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/pci/pcie/aer.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index cb6b96233967..b592cea8bffe 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -706,8 +706,8 @@ static void __aer_print_error(struct pci_dev *dev,
 			errmsg = "Unknown Error Bit";
 
 		if (info->severity == AER_CORRECTABLE)
-			pci_info(dev, "   [%2d] %-22s%s\n", i, errmsg,
-				info->first_error == i ? " (First)" : "");
+			pci_info_ratelimited(dev, "   [%2d] %-22s%s\n", i, errmsg,
+					     info->first_error == i ? " (First)" : "");
 		else
 			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
@@ -719,7 +719,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
 	int id = ((dev->bus->number << 8) | dev->devfn);
-	const char *level;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -730,14 +729,21 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
+	if (info->severity == AER_CORRECTABLE) {
+		pci_info_ratelimited(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
+				     aer_error_severity_string[info->severity],
+				     aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
-		   aer_error_layer[layer], aer_agent_string[agent]);
+		pci_info_ratelimited(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
+				     dev->vendor, dev->device, info->status, info->mask);
+	} else {
+		pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
+			aer_error_severity_string[info->severity],
+			aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+		pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
+			dev->vendor, dev->device, info->status, info->mask);
+	}
 
 	__aer_print_error(dev, info);
 
@@ -757,11 +763,19 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
+	if (info->severity == AER_CORRECTABLE)
+		pci_info_ratelimited(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+				     info->multi_error_valid ? "Multiple " : "",
+				     aer_error_severity_string[info->severity],
+				     pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+				     PCI_FUNC(devfn));
+	else
+		pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+			 info->multi_error_valid ? "Multiple " : "",
+			 aer_error_severity_string[info->severity],
+			 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
+
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
-- 
2.40.0.rc1.284.g88254d51c5-goog

