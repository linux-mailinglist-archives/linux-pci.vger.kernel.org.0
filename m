Return-Path: <linux-pci+bounces-21412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F7A354C5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137603AC169
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F87E0E8;
	Fri, 14 Feb 2025 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ula34NDc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE1C2EF
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500571; cv=none; b=ER/lfevhP2TZDv6IeH1S75gch1eGIcXlyqq7pzMvlybD1GtO5EH9DB9WczGUzNAUK9NmIIvD73+zRqYQo1shtFWNMAq6/qZclLRSM6jtXV4HuzArgsZoNkiYomBpR5ZQ/ukhfsJupZA+zrcm+kLAWWzaxPbbB0kLQ+2MqJtAlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500571; c=relaxed/simple;
	bh=VTTLIbqD93j3gEw0ixYhYa1LOotH74ztlOXG+Booe/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V7d9qmtILWYiXdfJZ0Svx5a/ewHJpuaKhcQ+GsbFC3L1YjMxttBPTEQB8JIzkFmhDd0zm9FzFhShZMYlAK3yeh9Nck3lfNrp2/3wxdotCZ8jt1MG1h+BUoMVrIEoG6sz01xE2iUrxQLu3IJUbVBf6ggZJ6NxpklZn7ih3jnvH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ula34NDc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa6793e8b8so3788406a91.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500569; x=1740105369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6DnEV3CPo8T10VipgQF2oA8JBGrjoBd8ykisKiCS7Q=;
        b=ula34NDcSnJIOVz3A04WaYXHAZw30cUb24tESdiqFJlkBFnYkLIFLgjkbBbB874F61
         N0rGGDwXRDDloY6Jxm5GoJ0Rj1U77JRDNHDVKaoerk/IfrqKA/eZUrzHjzGFT1uW41HN
         e0YKAoht7wvXVqcWPQsM3ozelZVkltVjEr5N0spf/BCW/ghn0RP/4PZwK5Cdseaqv6nN
         ctlqpWXIlANONAVpLRQuPwNgTFYUeIh4/KKpUw1JRGOeMxLqfZxJS2PAGsDQLxB+vCoO
         GkgfYZEIZ54UnUhFIRNrG78/EDUsI4/+F072jkWqOwDqHV3aN+NWUKTW1lR58/CtS7tO
         /LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500569; x=1740105369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6DnEV3CPo8T10VipgQF2oA8JBGrjoBd8ykisKiCS7Q=;
        b=hjlrNeYkUPTlzFLzONJDxGr3f59SbhmIDhBX1qxY9Arva1/EABzSskgRhrRoIle3eN
         C4dwl/2W4mWEgrJNh7E3wLTd8xAIEBab3+TPHDnnGKa3WCIQV3QSEM3BgKvRB5JY9xDx
         00hNlPGcQgJJTSxAg9u9wRcTXpwKXSm1UAw6jpHT5aZOJ8ux90A6bXNOnUCoAlbZP4G0
         /O9ueZn6wB+83TsgXMjaNndLrDxUcJ0KJXvxcGIZLOYraTPmwkM2qNqSzNagf/Kc8mIh
         l+sEnaRsZlEA/xzzVr+4PNDWcLbaGmVg2cR/C3D7iM5ga8yhJhnpAmNNaGXl4iJgGG3R
         iTxQ==
X-Gm-Message-State: AOJu0YyGDxdTmT77RhIKYSbGDiTFS1OHkDafa8DRQaY6mq8lDWR/iOjh
	NfZ78Zlhe77CXkTwqdQMFM8XrxOYqOmVuX3dyEFqO+QZ6F+EDfkHUF3deiW+7LBng8kICgwAeFN
	VrA==
X-Google-Smtp-Source: AGHT+IFxNcRd+Bizj2VPFq517kiqItT3K/Zz3LTjSU4h5J6xWUo0Smlmeg3ya9M9QLtaB+25f4abhkPkpvo=
X-Received: from pgmp34.prod.google.com ([2002:a63:1e62:0:b0:ada:48e3:831f])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3996:b0:1e1:afa9:d39b
 with SMTP id adf61e73a8af0-1ee5e530b58mr18640487637.7.1739500568749; Thu, 13
 Feb 2025 18:36:08 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:37 -0800
In-Reply-To: <20250214023543.992372-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-3-pandoh@google.com>
Subject: [PATCH v2 2/8] PCI/AER: Use the same log level for all messages
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Karolina Stolarek <karolina.stolarek@oracle.com>

When reporting an AER error, we check its type multiple times
to determine the log level for each message. Do this check only
in the top-level function and propagate the result down the call
chain. Make aer_print_port_info output to match the level of the
reported error.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Reviewed-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pci.h      |  2 +-
 drivers/pci/pcie/aer.c | 43 ++++++++++++++++++++++--------------------
 drivers/pci/pcie/dpc.c |  2 +-
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..8cb816ee5388 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -550,7 +550,7 @@ struct aer_err_info {
 };
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, struct pcie_tlp_log *log);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9a8cc81d01e4..f1fdaa052cf6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -670,20 +670,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 }
 
 static void __aer_print_error(struct pci_dev *dev,
-			      struct aer_err_info *info)
+			      struct aer_err_info *info,
+			      const char *level)
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
-	const char *level, *errmsg;
+	const char *errmsg;
 	int i;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == AER_CORRECTABLE)
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
-	} else {
+	else
 		strings = aer_uncorrectable_error_string;
-		level = KERN_ERR;
-	}
 
 	for_each_set_bit(i, &status, 32) {
 		errmsg = strings[i];
@@ -696,11 +694,11 @@ static void __aer_print_error(struct pci_dev *dev,
 	pci_dev_aer_stats_incr(dev, info);
 }
 
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
+		     const char *level)
 {
 	int layer, agent;
 	int id = pci_dev_id(dev);
-	const char *level;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -711,8 +709,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
-
 	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
@@ -720,7 +716,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		   dev->vendor, dev->device, info->status, info->mask);
 
-	__aer_print_error(dev, info);
+	__aer_print_error(dev, info, level);
 
 	if (info->tlp_header_valid)
 		pcie_print_tlp_log(dev, &info->tlp, dev_fmt("  "));
@@ -753,15 +749,18 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
+	const char *level;
 	struct aer_err_info info;
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
+		level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
+		level = KERN_ERR;
 	}
 
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
@@ -773,13 +772,13 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
+	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	__aer_print_error(dev, &info, level);
+	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
+		aer_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
 			aer->uncor_severity);
 
 	if (tlp_header_valid)
@@ -1244,14 +1243,15 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	return 1;
 }
 
-static inline void aer_process_err_devices(struct aer_err_info *e_info)
+static inline void aer_process_err_devices(struct aer_err_info *e_info,
+					   const char *level)
 {
 	int i;
 
 	/* Report all before handle them, not to lost records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
-			aer_print_error(e_info->dev[i], e_info);
+			aer_print_error(e_info->dev[i], e_info, level);
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
@@ -1269,6 +1269,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 {
 	struct pci_dev *pdev = rpc->rpd;
 	struct aer_err_info e_info;
+	const char *level;
 
 	pci_rootport_aer_stats_incr(pdev, e_src);
 
@@ -1279,6 +1280,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
 		e_info.id = ERR_COR_ID(e_src->id);
 		e_info.severity = AER_CORRECTABLE;
+		level = KERN_WARNING;
 
 		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
 			e_info.multi_error_valid = 1;
@@ -1286,11 +1288,12 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 0;
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+			aer_process_err_devices(&e_info, level);
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
 		e_info.id = ERR_UNCOR_ID(e_src->id);
+		level = KERN_ERR;
 
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
 			e_info.severity = AER_FATAL;
@@ -1303,7 +1306,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 0;
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+			aer_process_err_devices(&e_info, level);
 	}
 }
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 242cabd5eeeb..f06fad95f2eb 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -287,7 +287,7 @@ void dpc_process_error(struct pci_dev *pdev)
 	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
-		aer_print_error(pdev, &info);
+		aer_print_error(pdev, &info, KERN_ERR);
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
 	}
-- 
2.48.1.601.g30ceb7b040-goog


