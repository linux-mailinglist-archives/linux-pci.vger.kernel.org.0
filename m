Return-Path: <linux-pci+bounces-21414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54580A354C6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4C63AD2ED
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4698C2EF;
	Fri, 14 Feb 2025 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpHfOWjV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CB13B592
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500576; cv=none; b=vAAlyQh1fxGpZs37xu1vjTV2pLJ2yk3DQpRFcI0x9MClfcJhw0PYs1zRymuV4oq2nvXsFhoOjjpJQ+RzTELLELI7Vza5l6d2i6iQ0t+fMgTsNyUzJUHL8oQUkP79BMqzuapQW8VrTD/yfMzm/SGsmWSqmzWpQrUDhdCX6d+GnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500576; c=relaxed/simple;
	bh=9FvMqsfOCHYzIest4Kkdkzdcs9PwzdyFvtsSIllgA+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JpQXQT2GTctRo0h1h2GkExhiKfOjJYc/G8TbtESBBDv3LkG2BBKK4fFrZrWQVzLn7R+yBbb6E8zPXhiCk62tiLDBNhep0ZEAJzCaMv0FzDA8v4iF+Ljpw5L7/mAPGfEeDaKje4RHzlq3oKYOZY+HRnM00YQ+MofemzIOOM9RNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpHfOWjV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so3322131a91.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500574; x=1740105374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/J8FPPeyiF/y9KPB4qL0TgAFGSjHczh1/T/MLVMcmZM=;
        b=EpHfOWjVPteKq5NYSuyzF/wfPFbD/RXySmAEvDvyRw7hdQihR27K5rngeTvs/wuf6P
         uyIMZGsxpA6qzHkV2gRAJ0HA0aMZm3U24as4VZ1vhn7vJbSRe312H3ivCSqBk1+SVEGS
         oP54nNFAIhvJcOWCA/2uJavVci4QoKOShCQCQs1nVQcEXWsLP0YEF7MQ60XQF8pgVxZN
         DU6wZFBPYrnKQqNJBVLLyoGsUlTx35669q8uI1uftj7Z3F+dbNYmuhLa7GFQuWDZ5QhG
         fEAkdiA8TB+Fr6O712pEE6vv8B7veVfEN6seNVJBiXV6oXlPtaS7/10f/bG6tNwFCPVP
         8YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500574; x=1740105374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/J8FPPeyiF/y9KPB4qL0TgAFGSjHczh1/T/MLVMcmZM=;
        b=JoDz25OLtgibJBOjpmjaFlCHwY/xpDuPfDSML10y7Ceaknt/dWJo0SQqfEUQzvqoIb
         OrqnX4AGgUz4fe4myvX/uescA50bsCQRBwX1TOASLd7NRix6JksU3/L/Uvy+k98GgX3y
         rKVxmHeDQWH8sxiXvcWXenf1YMetTnLJIlTi5gQQkaItuiCOe7n5nF/8dsxYr6kIoGLw
         Ea+PqfteURKxe8UTb0d8EUsOYUo8OfvyQNkH3B+ky3NJLV9kGJW+j+bJK4q+js8MkPH1
         LadZMdJQ04odAlHGAkorV40DCciDc7hpnUdYWmNaovopLV/Ooe9ldt5aXnKHUznJi1xj
         xyUg==
X-Gm-Message-State: AOJu0YyOkTV+xr3mrR9NB9DnrdotYdeFRUDH1213JL07haJNXBA1bKA3
	BgrpQrvPu/IBQAx3MVghs+yyfEA6rpfE3D+qHt31XlBdFpd7/84p247WThBQ5jqzzpc7N8iKfzg
	1AA==
X-Google-Smtp-Source: AGHT+IHNFtGLfDb7fOFkAOf7Vp2+E6j3GmY66aXRD4KBwbFbqG5nPsptgB2ti+wn8mHR7Q2cLl7wJOvwbuM=
X-Received: from pjbqn11.prod.google.com ([2002:a17:90b:3d4b:b0:2fa:15aa:4d1e])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da83:b0:2ee:7698:e565
 with SMTP id 98e67ed59e1d1-2fbf5bece56mr14606450a91.8.1739500574348; Thu, 13
 Feb 2025 18:36:14 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:39 -0800
In-Reply-To: <20250214023543.992372-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-5-pandoh@google.com>
Subject: [PATCH v2 4/8] PCI/AER: Rename struct aer_stats to aer_report
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Update name to reflect the broader definition of structs/variables that
are stored (e.g. ratelimits).

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
 include/linux/pci.h    |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d6edb95d468f..b4f902fd5ef6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -54,11 +54,11 @@ struct aer_rpc {
 	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
 };
 
-/* AER stats for the device */
-struct aer_stats {
+/* AER report for the device */
+struct aer_report {
 
 	/*
-	 * Fields for all AER capable devices. They indicate the errors
+	 * Stats for all AER capable devices. They indicate the errors
 	 * "as seen by this device". Note that this may mean that if an
 	 * end point is causing problems, the AER counters may increment
 	 * at its link partner (e.g. root port) because the errors will be
@@ -80,7 +80,7 @@ struct aer_stats {
 	u64 dev_total_nonfatal_errs;
 
 	/*
-	 * Fields for Root ports & root complex event collectors only, these
+	 * Stats for Root ports & root complex event collectors only, these
 	 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
 	 * messages received by the root port / event collector, INCLUDING the
 	 * ones that are generated internally (by the rootport itself)
@@ -377,7 +377,7 @@ void pci_aer_init(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return;
 
-	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+	dev->aer_report = kzalloc(sizeof(struct aer_report), GFP_KERNEL);
 
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
@@ -398,8 +398,8 @@ void pci_aer_init(struct pci_dev *dev)
 
 void pci_aer_exit(struct pci_dev *dev)
 {
-	kfree(dev->aer_stats);
-	dev->aer_stats = NULL;
+	kfree(dev->aer_report);
+	dev->aer_report = NULL;
 }
 
 #define AER_AGENT_RECEIVER		0
@@ -537,10 +537,10 @@ static const char *aer_agent_string[] = {
 {									\
 	unsigned int i;							\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	u64 *stats = pdev->aer_stats->stats_array;			\
+	u64 *stats = pdev->aer_report->stats_array;			\
 	size_t len = 0;							\
 									\
-	for (i = 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
+	for (i = 0; i < ARRAY_SIZE(pdev->aer_report->stats_array); i++) {\
 		if (strings_array[i])					\
 			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
 					     strings_array[i],		\
@@ -551,7 +551,7 @@ static const char *aer_agent_string[] = {
 					     i, stats[i]);		\
 	}								\
 	len += sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,	\
-			     pdev->aer_stats->total_field);		\
+			     pdev->aer_report->total_field);		\
 	return len;							\
 }									\
 static DEVICE_ATTR_RO(name)
@@ -572,7 +572,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 		     char *buf)						\
 {									\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);	\
+	return sysfs_emit(buf, "%llu\n", pdev->aer_report->field);	\
 }									\
 static DEVICE_ATTR_RO(name)
 
@@ -599,7 +599,7 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (!pdev->aer_stats)
+	if (!pdev->aer_report)
 		return 0;
 
 	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
@@ -622,25 +622,25 @@ void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
 	unsigned long status = info->status & ~info->mask;
 	int i, max = -1;
 	u64 *counter = NULL;
-	struct aer_stats *aer_stats = pdev->aer_stats;
+	struct aer_report *aer_report = pdev->aer_report;
 
-	if (!aer_stats)
+	if (!aer_report)
 		return;
 
 	switch (info->severity) {
 	case AER_CORRECTABLE:
-		aer_stats->dev_total_cor_errs++;
-		counter = &aer_stats->dev_cor_errs[0];
+		aer_report->dev_total_cor_errs++;
+		counter = &aer_report->dev_cor_errs[0];
 		max = AER_MAX_TYPEOF_COR_ERRS;
 		break;
 	case AER_NONFATAL:
-		aer_stats->dev_total_nonfatal_errs++;
-		counter = &aer_stats->dev_nonfatal_errs[0];
+		aer_report->dev_total_nonfatal_errs++;
+		counter = &aer_report->dev_nonfatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
 	case AER_FATAL:
-		aer_stats->dev_total_fatal_errs++;
-		counter = &aer_stats->dev_fatal_errs[0];
+		aer_report->dev_total_fatal_errs++;
+		counter = &aer_report->dev_fatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
 	}
@@ -652,19 +652,19 @@ void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
 static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 				 struct aer_err_source *e_src)
 {
-	struct aer_stats *aer_stats = pdev->aer_stats;
+	struct aer_report *aer_report = pdev->aer_report;
 
-	if (!aer_stats)
+	if (!aer_report)
 		return;
 
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV)
-		aer_stats->rootport_total_cor_errs++;
+		aer_report->rootport_total_cor_errs++;
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
-			aer_stats->rootport_total_fatal_errs++;
+			aer_report->rootport_total_fatal_errs++;
 		else
-			aer_stats->rootport_total_nonfatal_errs++;
+			aer_report->rootport_total_nonfatal_errs++;
 	}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3c2c8d8eb1fd..7f55009a626b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -346,7 +346,7 @@ struct pci_dev {
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
-	struct aer_stats *aer_stats;	/* AER stats for this device */
+	struct aer_report *aer_report;	/* AER report for this device */
 #endif
 #ifdef CONFIG_PCIEPORTBUS
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
-- 
2.48.1.601.g30ceb7b040-goog


