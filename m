Return-Path: <linux-pci+bounces-24077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A1EA6871A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980BA420A7A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340315A85A;
	Wed, 19 Mar 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouQFgVTM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98E2512CA
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373679; cv=none; b=YACYsZzKME8pw68fcG6iL399wr4y5HFEP5VLA8+bPS8f174EaqGksc04bhpq9saH2XJt6KToXE1WK8KrqDNQKMtE8qs58TgWmBbDWlpEVtQra+7rqfPRnpizcG44e0RTiUYjW4q3vT8qANvNulqIjXLokgR+rVflbalUGS4CiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373679; c=relaxed/simple;
	bh=4BqYa0/0oXdc6SPaifaRtyqnxny/BmNJJ7mbfCOVHP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ae0ZcCNVkTyMVqF8iAhHGTIw2zjGXkFXMdm7uFD0Q6i3TrezeF3PRlCWo21S/KQUvkOvyaNl95MfvkzkCH8ix6MdEt6DW7RMS5Z/v05eUKm25IFLzxhKTNpu2CUlNxdJ+ll+OIAxfX+SrhN++Ou4Xp5DhHuFWR7maDeErYENME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouQFgVTM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so6659640a91.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373677; x=1742978477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLzk6ISOkNU8YIV8p78bs7GVSG1SmH6Q9dWTWI4n6qA=;
        b=ouQFgVTMCn3u7Uzb3Or/xhYemx6BGmwQlcTo6VOlD3u4tbiGHh6VcBjnAhm07yC4OX
         iLayZIrmdZk5hqsDQstnf6eBq/WxBx+QvpE2L0S84+Smnu5DownTf+cOZu5Ik83O7KbQ
         SySuz/tAeacCag1a1hhkq44vAaRaNvGaRBLtPo2Xj0Mq6jsH4DwcSqmriMXQLGhNV8vS
         s6BdpvTfXkrzg9QJMy/IJT4edt1qOruwBAjIiYh/vJgs+wJKVrDpi2wj4wJqBmBqnljb
         E+3eXsTiUhwoR8pyjpTzhFbDUTLfCzhxtwWEKjQ/tRPxgQppO1i1mF/801V0rPBj8VZW
         bbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373677; x=1742978477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLzk6ISOkNU8YIV8p78bs7GVSG1SmH6Q9dWTWI4n6qA=;
        b=I4hz6kvQe86ZKcGTvc7TO0LSDA9OgLB3/MoVkQti27Y9OzXrHfYao8wWoM9GOkS3vh
         MQk4ojTT3vG82aQi8+8DEh2YDIx6HB7C7ZlOuveU6+ju25UD1QsTyZTpFz7Y2was5mna
         e0uPebPKi54gTMOH2PssHAtFQJA7w8UOLqROpka5yAGzbw/a3el2tMmh84oAdoTMfMRd
         IPXTp1eDsX09nA/Ls8pvSo1N6StNQX5RvggQ1a5CVu1PHVTsW7f7s3MYkt5VipyspUXv
         FP2NZQHBRS9j3wTQDgrmqRA4KSi5KOdICD9CX869TCeMhNvhuMTDFdMxWJwLGflC6qiK
         QRPQ==
X-Gm-Message-State: AOJu0Ywr9ndxOZemkpoBKgJJ8iGYkr9MjRjTQ40o/2FGL5xqfCOa0+wm
	cVexJBKeTmhammFLfRjyvopQMNxQzhE36UxrSffphMjbgm7mLsNUl3rtQHnCrxdBd3hHCIWeCNN
	tJg==
X-Google-Smtp-Source: AGHT+IFGOiJdDZA3OIo7vckkOXp5z6xoBNcsDNMWbpjR4pKJdk5V2KFe13GjIjaTSAOxnI+19EGml+ryRpc=
X-Received: from pjbnd6.prod.google.com ([2002:a17:90b:4cc6:b0:2ea:aa56:49c])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8f:b0:2ee:d433:7c50
 with SMTP id 98e67ed59e1d1-301be1fff3bmr2512307a91.23.1742373677720; Wed, 19
 Mar 2025 01:41:17 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:46 -0700
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-6-pandoh@google.com>
Subject: [PATCH v3 5/8] PCI/AER: Introduce ratelimit for error logs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Spammy devices can flood kernel logs with AER errors and slow/stall
execution. Add per-device ratelimits for AER correctable and uncorrectable
errors that use the kernel defaults (10 per 5s).

Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
true count of 11.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 drivers/pci/pcie/aer.c | 76 +++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3a12980f7dd7..0bd20c4993d4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/kfifo.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
@@ -88,6 +89,10 @@ struct aer_report {
 	u64 rootport_total_cor_errs;
 	u64 rootport_total_fatal_errs;
 	u64 rootport_total_nonfatal_errs;
+
+	/* Ratelimits for errors */
+	struct ratelimit_state cor_log_ratelimit;
+	struct ratelimit_state uncor_log_ratelimit;
 };
 
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
@@ -379,6 +384,15 @@ void pci_aer_init(struct pci_dev *dev)
 
 	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
 
+	/*
+	 * Ratelimits are doubled as a given error produces 2 logs (root port
+	 * and endpoint) that should be under same ratelimit.
+	 */
+	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST * 2);
+	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST * 2);
+
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
 	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
@@ -697,6 +711,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 {
 	int layer, agent;
 	int id = pci_dev_id(dev);
+	struct ratelimit_state *ratelimit;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -704,6 +719,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 		goto out;
 	}
 
+	if (info->severity == AER_CORRECTABLE)
+		ratelimit = &dev->aer_report->cor_log_ratelimit;
+	else
+		ratelimit = &dev->aer_report->uncor_log_ratelimit;
+
+	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+			info->severity, info->tlp_header_valid, &info->tlp);
+
+	if (!__ratelimit(ratelimit))
+		return;
+
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
@@ -722,21 +748,33 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
-
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
-			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
 static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 {
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
+	struct ratelimit_state *ratelimit;
+	struct pci_dev *endpoint;
+	int i;
 
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
+	/* extract endpoint device ratelimit */
+	for (i = 0; i < info->error_dev_num; i++) {
+		endpoint = info->dev[i];
+		if (info->id == pci_dev_id(endpoint))
+			break;
+	}
+	if (info->severity == AER_CORRECTABLE)
+		ratelimit = &endpoint->aer_report->cor_log_ratelimit;
+	else
+		ratelimit = &endpoint->aer_report->uncor_log_ratelimit;
+
+	if (__ratelimit(ratelimit))
+		pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
+			 info->multi_error_valid ? "Multiple " : "",
+			 aer_error_severity_string[info->severity],
+			 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -761,12 +799,15 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	u32 status, mask;
 	const char *level;
 	struct aer_err_info info;
+	struct ratelimit_state *ratelimit;
 
 	if (aer_severity == AER_CORRECTABLE) {
+		ratelimit = &dev->aer_report->cor_log_ratelimit;
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 		level = KERN_WARNING;
 	} else {
+		ratelimit = &dev->aer_report->uncor_log_ratelimit;
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
@@ -784,6 +825,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	pci_dev_aer_stats_incr(dev, &info);
 
+	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+			aer_severity, tlp_header_valid, &aer->header_log);
+
+	if (!__ratelimit(ratelimit))
+		return;
+
 	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info, level);
 	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
@@ -795,9 +842,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
-
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
@@ -1301,10 +1345,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info);
 
-		if (find_source_device(pdev, &e_info))
+		if (find_source_device(pdev, &e_info)) {
+			aer_print_port_info(pdev, &e_info);
 			aer_process_err_devices(&e_info, level);
+		}
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -1321,10 +1366,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, &e_info);
 
-		if (find_source_device(pdev, &e_info))
+		if (find_source_device(pdev, &e_info)) {
+			aer_print_port_info(pdev, &e_info);
 			aer_process_err_devices(&e_info, level);
+		}
 	}
 }
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


