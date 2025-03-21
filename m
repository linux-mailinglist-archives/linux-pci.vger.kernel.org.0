Return-Path: <linux-pci+bounces-24294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3DA6B2C5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1907818931DA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF91E0DE3;
	Fri, 21 Mar 2025 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlYoWdFi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E13F9461
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522314; cv=none; b=eIjXHKl19A1UJe2ifrFs4vWvTxfoEaa8aQ2aeG0nZnyFdneF6uBm5BOaiR0ztJIdWYEhv4EIYcAAdylZ6LBRHlV8+EgPIxX5OdbxcX1wR4dcCAS/CuQKu0xR3N8gonZzPcXHr542g9sFrwJ40IatLolD9kwIme/zG24bE1ey0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522314; c=relaxed/simple;
	bh=Dv0OrT1aOp/AiyKeGrJdOxYHIy8emc6M//R/VqR35jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJ+kimg1E9/nmxwkdbQxKXRz4cdeu2FGgAzuy+FwiFrqSjpQ4UKbUP1Gk3ZwzqnD0J6yyS0FaMMTfyOC3m46Qo3x3m5SZ5/AAt73QBPcO+j4ejD9j86hM8XhiuDL8InpPiL90qvN3dNk7CK/BAGQ+RnKidDE9Vi0bBQJt8nOSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlYoWdFi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2265a09dbfcso37777235ad.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522311; x=1743127111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IT7oOIT1hV+oLCjRgsylPtWxCIwotQg+2TsJM4XByJk=;
        b=PlYoWdFi7pf5AbcskCbUXjlciSaAj/m2qd/VA2sgfX+z+ykFTqPX73dYZ6XGNXe7NP
         AKau6VOQ02rcMrJIPMk6GlfLN9AtEXdnvFaoL8jOZotO3Jo5/3+UOkyIRZsT7GWbJlGT
         6r282yOnphxJQ4RYSgZCsBKjd/uwPg+GqLGXDT/lYt4Sz/Ks7kW2Jw4om5SKEgyx3t9L
         V/Aey7dC0TpYMVlzv9Pn2duBEB/4XrUPdHt3eUPriBuYoLssepENR9RUzC/EtX59baaE
         Qqa/2aFN6bB4rsk/Kxa4F1Eb/4xIXcMWMrck9adamtOTPCzE9js6tS5Oibe/wp6Vnhm+
         +9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522311; x=1743127111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IT7oOIT1hV+oLCjRgsylPtWxCIwotQg+2TsJM4XByJk=;
        b=qYKBvxiy5Fyax6ieHpxu27VLuU9d6wT4LPNLoe/IgXEyR2j5VbnocwYSxFkh3F7sg/
         Dmlf7jwEiScMK9G8i/gdL/WUrtcFDyWkbviU7388n78ZNl2YQldiq2xKPIodMOiApXW2
         13yDefGe/DYrInR6iKFk5CYL5Ke58YSoTygMqc2stGjtnbrW9Va1XsI5si/dWz4sF1Z8
         pfM/bYKB94gIt0gahYR7/kRUTdYZOBlX5Jlp2qmnaAG1QFxzMAfhg9LiqEZOYHR5VT3r
         GauLqAkCBtGcZH2PIR3JntWmGlCDom3VNfh8mHiF/BI8XrZ4fVM38aZQX3sthl6ZwhUF
         +Tew==
X-Gm-Message-State: AOJu0Yz6Onb74PVBe92l3D61jjr0N09kMZIlmVHmW7u5H8cYCJ2+s95g
	hzA95QaxH6M4KbGtOzPD6Rz35HvnuJmuo/UUGZvWL6EyTxq/JF9EOtfmXoxH+xyuxxLZZlzdvki
	bfg==
X-Google-Smtp-Source: AGHT+IHe+RHDLdx0PBYYg/Fnx/HxJfWs7d2gEk6Z04w/el2dAKqaJqQ/8mXWdx3UoU3YfxP15GppmbUq7RY=
X-Received: from pfbna38.prod.google.com ([2002:a05:6a00:3e26:b0:736:a70b:53c7])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84d:b0:21f:164d:93fe
 with SMTP id d9443c01a7336-22780e25e01mr20969205ad.53.1742522310836; Thu, 20
 Mar 2025 18:58:30 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:58:04 -0700
In-Reply-To: <20250321015806.954866-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-7-pandoh@google.com>
Subject: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Spammy devices can flood kernel logs with AER errors and slow/stall
execution. Add per-device ratelimits for AER correctable and uncorrectable
errors that use the kernel defaults (10 per 5s).

Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
true count of 11.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reported-by: Sargun Dhillon <sargun@meta.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
 drivers/pci/pci.h      |  4 +-
 drivers/pci/pcie/aer.c | 87 ++++++++++++++++++++++++++++++++----------
 drivers/pci/pcie/dpc.c |  2 +-
 3 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9d63d32f041c..f709290e9e00 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
 
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
+	bool ratelimited[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
 
 	unsigned int id:16;
@@ -552,7 +553,8 @@ struct aer_err_info {
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
+		     const char *level, bool ratelimited);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f657edca8769..e0f526960134 100644
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
@@ -379,6 +384,11 @@ void pci_aer_init(struct pci_dev *dev)
 
 	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
 
+	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
 	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
@@ -668,6 +678,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
+static bool aer_ratelimited(struct pci_dev *dev, unsigned int severity)
+{
+	struct ratelimit_state *ratelimit;
+
+	if (severity == AER_CORRECTABLE)
+		ratelimit = &dev->aer_report->cor_log_ratelimit;
+	else
+		ratelimit = &dev->aer_report->uncor_log_ratelimit;
+
+	return !__ratelimit(ratelimit);
+}
+
 static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info,
 			      const char *level)
@@ -693,11 +715,17 @@ static void __aer_print_error(struct pci_dev *dev,
 }
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
-		     const char *level)
+		     const char *level, bool ratelimited)
 {
 	int layer, agent;
 	int id = pci_dev_id(dev);
 
+	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+			info->severity, info->tlp_header_valid, &info->tlp);
+
+	if (ratelimited)
+		return;
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -722,21 +750,31 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
-
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
-			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
 static void aer_print_rp_info(struct pci_dev *rp, struct aer_err_info *info)
 {
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
+	struct pci_dev *dev;
+	bool ratelimited = false;
+	int i;
 
-	pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
+	/* extract endpoint device ratelimit */
+	for (i = 0; i < info->error_dev_num; i++) {
+		dev = info->dev[i];
+		if (info->id == pci_dev_id(dev)) {
+			ratelimited = info->ratelimited[i];
+			break;
+		}
+	}
+
+	if (!ratelimited)
+		pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
+			 info->multi_error_valid ? "Multiple " : "",
+			 aer_error_severity_string[info->severity],
+			 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -784,6 +822,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	pci_dev_aer_stats_incr(dev, &info);
 
+	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+			aer_severity, tlp_header_valid, &aer->header_log);
+
+	if (aer_ratelimited(dev, aer_severity))
+		return;
+
 	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info, level);
 	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
@@ -795,9 +839,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
-
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
@@ -808,8 +849,12 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
  */
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
-	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
-		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
+	int dev_idx = e_info->error_dev_num;
+	unsigned int severity = e_info->severity;
+
+	if (dev_idx < AER_MAX_MULTI_ERR_DEVICES) {
+		e_info->dev[dev_idx] = pci_dev_get(dev);
+		e_info->ratelimited[dev_idx] = aer_ratelimited(dev, severity);
 		e_info->error_dev_num++;
 		return 0;
 	}
@@ -1265,7 +1310,8 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info,
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
 			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
-			aer_print_error(e_info->dev[i], e_info, level);
+			aer_print_error(e_info->dev[i], e_info, level,
+					e_info->ratelimited[i]);
 		}
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
@@ -1299,10 +1345,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_rp_info(pdev, &e_info);
 
-		if (find_source_device(pdev, &e_info))
+		if (find_source_device(pdev, &e_info)) {
+			aer_print_rp_info(pdev, &e_info);
 			aer_process_err_devices(&e_info, KERN_WARNING);
+		}
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -1318,10 +1365,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_rp_info(pdev, &e_info);
-
-		if (find_source_device(pdev, &e_info))
+		if (find_source_device(pdev, &e_info)) {
+			aer_print_rp_info(pdev, &e_info);
 			aer_process_err_devices(&e_info, KERN_ERR);
+		}
 	}
 }
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 81cd6e8ff3a4..42a36df4a651 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -290,7 +290,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		pci_dev_aer_stats_incr(pdev, &info);
-		aer_print_error(pdev, &info, KERN_ERR);
+		aer_print_error(pdev, &info, KERN_ERR, false);
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
 	}
-- 
2.49.0.395.g12beb8f557-goog


