Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7497235F3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 05:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjFFDyx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 23:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjFFDyw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 23:54:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70CB18E
        for <linux-pci@vger.kernel.org>; Mon,  5 Jun 2023 20:54:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53063897412so5220522a12.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Jun 2023 20:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686023690; x=1688615690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zl0xSYFVXihxlFwU2GI1A7DmXGMBSodJ+vcgxYeTY0Q=;
        b=c6TZBnZm4tjQlimIKuxQRIpQb8QaOyqNIC3Ybs3R1I6QmAUHBdQ6VrOpRmH5sJzlHl
         yNmYpXjlJeKbgoxlirqPmoAAXwNKYE025hH6CtoReVgEIf39AnRgPxBYn8s75U2Dz/3p
         LMG/pkrnhM1SXB7U+oq9nukDzv5jxXZm9PchQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686023690; x=1688615690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zl0xSYFVXihxlFwU2GI1A7DmXGMBSodJ+vcgxYeTY0Q=;
        b=huI0xLUxfFiQvXMq9+sp2y1S/XvYGmVOPZ80ChGxyPtvrrCRx4Ci2AjcxrtDP+5t11
         sF8tOscYGT3VRMKUC1TrcUEFtSm/8Iy3p5kovB5CnkAmvb5v1VieHC0Idvlr8zJnnK5o
         jq06BPKrdNYAKnnlhvmSvKcc+6sZz9YtF6LEyhRcXuVndP7rlEb3EqxKbP1dwt/cXCnu
         wq2XaCXxKkRXNZjoamxhsTAtojPY4iv1rPofEOeXXIwXKNFCDjFs4OJRWDaNUZNYQ9gw
         51UwdDubDGk7ZCl/28Stb0BaJ8uDqGhNpr5n6hsOrOjTisqs2T1wTPyQ9pqI6Am1FP2m
         OsIg==
X-Gm-Message-State: AC+VfDw8F6D0hifxVgO1+m8jPKYrfvr2vzR9acOX+cXnpoMuJ/QC8ZR5
        uI/JlJ60sSBOKDFagz2UMohpUA==
X-Google-Smtp-Source: ACHHUZ7/CrXntbChZr3gqIpdTn+xlRnOrx/HP0LFPjZRwolM/ohxcYZ6OUGoLPPIj8t4jX8e+O5LZQ==
X-Received: by 2002:a05:6a20:d806:b0:101:73a9:1683 with SMTP id iv6-20020a056a20d80600b0010173a91683mr1218950pzb.33.1686023690390;
        Mon, 05 Jun 2023 20:54:50 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001ac5b0a959bsm7346636plh.24.2023.06.05.20.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 20:54:50 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O \ 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCHv3 pci-next 2/2] PCI/AER: Rate limit the reporting of the correctable errors
Date:   Mon,  5 Jun 2023 20:54:42 -0700
Message-ID: <20230606035442.2886343-2-grundler@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230606035442.2886343-1-grundler@chromium.org>
References: <20230606035442.2886343-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/pci/pcie/aer.c | 80 +++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d7bfc6070ddb..830f5a1261c9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -686,26 +686,36 @@ static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info)
 {
 	const char **strings;
+	char aer_msg[512];
 	unsigned long status = info->status & ~info->mask;
-	const char *level, *errmsg;
 	int i;
 
-	if (info->severity == AER_CORRECTABLE) {
-		strings = aer_correctable_error_string;
-		level = KERN_INFO;
-	} else {
-		strings = aer_uncorrectable_error_string;
-		level = KERN_ERR;
-	}
+	memset(aer_msg, 0, sizeof(*aer_msg));
+	snprintf(aer_msg, sizeof(*aer_msg), "aer_status: 0x%08x, aer_mask: 0x%08x\n",
+			info->status, info->mask);
+
+	strings = (info->severity == AER_CORRECTABLE) ?
+		aer_correctable_error_string : aer_uncorrectable_error_string;
 
 	for_each_set_bit(i, &status, 32) {
-		errmsg = strings[i];
+		const char *errmsg = strings[i];
+		char bitmsg[64];
+		memset(bitmsg, 0, sizeof(*bitmsg));
+
 		if (!errmsg)
 			errmsg = "Unknown Error Bit";
 
-		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
-				info->first_error == i ? " (First)" : "");
+		snprintf(bitmsg, sizeof(*bitmsg), "   [%2d] %-22s%s\n", i, errmsg,
+			    info->first_error == i ? " (First)" : "");
+
+		strlcat(aer_msg, bitmsg, sizeof(*aer_msg));
 	}
+
+	if (info->severity == AER_CORRECTABLE)
+		pci_info_ratelimited(dev, "%s", aer_msg);
+	else
+		pci_err(dev, "%s", aer_msg):
+
 	pci_dev_aer_stats_incr(dev, info);
 }
 
@@ -713,7 +723,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
 	int id = ((dev->bus->number << 8) | dev->devfn);
-	const char *level;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -724,14 +733,19 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
-
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
-		   aer_error_layer[layer], aer_agent_string[agent]);
-
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+	if (info->severity == AER_CORRECTABLE) {
+		pci_info_ratelimited(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n"
+				"  device [%04x:%04x] error status/mask=%08x/%08x\n",
+				     aer_error_severity_string[info->severity],
+				     aer_error_layer[layer], aer_agent_string[agent],
+				     dev->vendor, dev->device, info->status, info->mask);
+	} else {
+		pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
+			"  device [%04x:%04x] error status/mask=%08x/%08x\n",
+			aer_error_severity_string[info->severity],
+			aer_error_layer[layer], aer_agent_string[agent],
+			dev->vendor, dev->device, info->status, info->mask);
+	}
 
 	__aer_print_error(dev, info);
 
@@ -751,11 +765,19 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
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
@@ -798,7 +820,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
 	if (aer_severity == AER_CORRECTABLE)
-		pci_info(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+		pci_info_ratelimited(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	else
 		pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 
@@ -808,9 +830,9 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		pci_info(dev, "aer_layer=%s, aer_agent=%s\n",
 			aer_error_layer[layer], aer_agent_string[agent]);
 	} else {
-		pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-			aer_error_layer[layer], aer_agent_string[agent]);
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
+		pci_err(dev, "aer_layer=%s, aer_agent=%s,"
+			" aer_uncor_severity=0x%08x\n",
+			aer_error_layer[layer], aer_agent_string[agent],
 			aer->uncor_severity);
 	}
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

