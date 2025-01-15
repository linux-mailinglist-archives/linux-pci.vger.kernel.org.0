Return-Path: <linux-pci+bounces-19838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D77EA11B2C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F298B3A7FAE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3222F847;
	Wed, 15 Jan 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+GhFUw9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4935944
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927006; cv=none; b=OgpsAxXo4iz138If3BNymzI1Ld1Ns9Y+5PKPIJcXaW35b99wIC0z+1B/4ltpJWMFKEP10FE3cfzPuk675POyIFosAW1Mu3Wgoh+BeIy41CjwP7UoHoBpTHy9d1arE+m5qyF0IfxyYuPGGJqm5w7MfWmpw0KWaQWQKJrH1BHs0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927006; c=relaxed/simple;
	bh=jbbciFKr4lpWzVTPwRRUH0gti5k1BFus+usyKRHjipw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLlto6zwoODuWnEQWjQbJ2qxLudU5thzIlGwIy9RoDfKKa7gC4nlDq6/mzTPFmTDC2JFm5jX9UtYVZ+ftJoq/W0ko5FWSgdXW4ZjesA/4IYKqPMC3bgPwrStSyyDsvccEHBNJdxQrBQbets8pjiMhQiKZj9sZt2pNRDuU91Nu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+GhFUw9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21632eacb31so77567835ad.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927004; x=1737531804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TucB/r+uGQd5ERcyy2UEFhzZ73Y9fQ1zg8lqsEqfHE=;
        b=w+GhFUw9FSHYf+o2D3H0xQxcvUzgLtjNMHJFKKScLKEr2HCFqBG7mXvMvkvzwketcW
         UXiiSciItD2JaBLO8NUx4tKuvdyzJosCl9OlJincnRS9nMghNedh3nndIldSlRYT/v+o
         P7pDq+dI7EEXK24duFfoSGYCDh8XB1KJNJled0E72BkSCDmzy5EYVkw5fZrr39piJ6cF
         fSyBBFWJFcvhN7azMZJe6xHPOEiptrPyNvwd+r8gKxEVQnThv2XQ836GTobFSFre5pZm
         uc8WgxoZo0F6nBN6sCfy9dPKJsci0tfULPoeutqWdXrOPt6h9p2zt5AujN1TgCbCTvrz
         S5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927004; x=1737531804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TucB/r+uGQd5ERcyy2UEFhzZ73Y9fQ1zg8lqsEqfHE=;
        b=saxwC0jjKhCI5DshRjidc9nLSccjSNHPz4xQgZKOQxjXhCcXUpcq/uhjF7YxycAwv7
         At0vM/vqVANzilI2AkgEI6PWpSgt66+8dSdV0daZRl4sg/9BlhjKzE9DHb1dXhIAfSk+
         Lwyy8P/eh3xquD2HygH1nASURzwjgNCuj7osgWMijG6om8k/MjSefSDTcyHjHsuZ8zQq
         RSr9OPdDyQaQnzxr4XywO/ssS17CbMZGzwPcsHI1cjKUQYI1UE++ggX4Ea2OxmIcwwLO
         fPWyFXRz//vzVc4wlU6FWIrqioLVSpeWhDVO1pXEkK/L3iEpGjuYoPkd8lqmqP4qeYFw
         3lQg==
X-Gm-Message-State: AOJu0YwXjuZVjeioxu/wRBXftTlONi94LcEeoOGPUXvb+iR0hKl7J1y5
	YnhfCmNbmyDYgpy2yEceX/CIN64eq4EPpsHTakqMb14vikNJXUaI0wguqiO5VH0Ooq9SHThbFNw
	+iA==
X-Google-Smtp-Source: AGHT+IGq6M2yvrzEbN9fc6D2kZjbUSNpgwq1zNbRj2fM8biGYkBsPt7bKTkRqQP8DqzTwj2ymJJ0Qpz/gac=
X-Received: from plaw1.prod.google.com ([2002:a17:902:c781:b0:21a:7dbb:d6d9])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120b:b0:215:a190:ba10
 with SMTP id d9443c01a7336-21a83f54ec2mr394361145ad.15.1736927004125; Tue, 14
 Jan 2025 23:43:24 -0800 (PST)
Date: Tue, 14 Jan 2025 23:42:55 -0800
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-4-pandoh@google.com>
Subject: [PATCH 3/8] PCI/AER: Rename struct aer_stats to aer_info
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Update name to reflect the broader definition of structs/variables that
are stored (e.g. ratelimits).

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
 include/linux/pci.h    |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4bb0b3840402..5ab5cd7368bc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -50,11 +50,11 @@ struct aer_rpc {
 	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
 };
 
-/* AER stats for the device */
-struct aer_stats {
+/* AER info for the device */
+struct aer_info {
 
 	/*
-	 * Fields for all AER capable devices. They indicate the errors
+	 * Stats for all AER capable devices. They indicate the errors
 	 * "as seen by this device". Note that this may mean that if an
 	 * end point is causing problems, the AER counters may increment
 	 * at its link partner (e.g. root port) because the errors will be
@@ -76,7 +76,7 @@ struct aer_stats {
 	u64 dev_total_nonfatal_errs;
 
 	/*
-	 * Fields for Root ports & root complex event collectors only, these
+	 * Stats for Root ports & root complex event collectors only, these
 	 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
 	 * messages received by the root port / event collector, INCLUDING the
 	 * ones that are generated internally (by the rootport itself)
@@ -373,7 +373,7 @@ void pci_aer_init(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return;
 
-	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+	dev->aer_info = kzalloc(sizeof(struct aer_info), GFP_KERNEL);
 
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
@@ -394,8 +394,8 @@ void pci_aer_init(struct pci_dev *dev)
 
 void pci_aer_exit(struct pci_dev *dev)
 {
-	kfree(dev->aer_stats);
-	dev->aer_stats = NULL;
+	kfree(dev->aer_info);
+	dev->aer_info = NULL;
 }
 
 #define AER_AGENT_RECEIVER		0
@@ -533,10 +533,10 @@ static const char *aer_agent_string[] = {
 {									\
 	unsigned int i;							\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	u64 *stats = pdev->aer_stats->stats_array;			\
+	u64 *stats = pdev->aer_info->stats_array;			\
 	size_t len = 0;							\
 									\
-	for (i = 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
+	for (i = 0; i < ARRAY_SIZE(pdev->aer_info->stats_array); i++) {\
 		if (strings_array[i])					\
 			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
 					     strings_array[i],		\
@@ -547,7 +547,7 @@ static const char *aer_agent_string[] = {
 					     i, stats[i]);		\
 	}								\
 	len += sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,	\
-			     pdev->aer_stats->total_field);		\
+			     pdev->aer_info->total_field);		\
 	return len;							\
 }									\
 static DEVICE_ATTR_RO(name)
@@ -568,7 +568,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 		     char *buf)						\
 {									\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);	\
+	return sysfs_emit(buf, "%llu\n", pdev->aer_info->field);	\
 }									\
 static DEVICE_ATTR_RO(name)
 
@@ -595,7 +595,7 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (!pdev->aer_stats)
+	if (!pdev->aer_info)
 		return 0;
 
 	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
@@ -619,25 +619,25 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 	unsigned long status = info->status & ~info->mask;
 	int i, max = -1;
 	u64 *counter = NULL;
-	struct aer_stats *aer_stats = pdev->aer_stats;
+	struct aer_info *aer_info = pdev->aer_info;
 
-	if (!aer_stats)
+	if (!aer_info)
 		return;
 
 	switch (info->severity) {
 	case AER_CORRECTABLE:
-		aer_stats->dev_total_cor_errs++;
-		counter = &aer_stats->dev_cor_errs[0];
+		aer_info->dev_total_cor_errs++;
+		counter = &aer_info->dev_cor_errs[0];
 		max = AER_MAX_TYPEOF_COR_ERRS;
 		break;
 	case AER_NONFATAL:
-		aer_stats->dev_total_nonfatal_errs++;
-		counter = &aer_stats->dev_nonfatal_errs[0];
+		aer_info->dev_total_nonfatal_errs++;
+		counter = &aer_info->dev_nonfatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
 	case AER_FATAL:
-		aer_stats->dev_total_fatal_errs++;
-		counter = &aer_stats->dev_fatal_errs[0];
+		aer_info->dev_total_fatal_errs++;
+		counter = &aer_info->dev_fatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
 	}
@@ -649,19 +649,19 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 				 struct aer_err_source *e_src)
 {
-	struct aer_stats *aer_stats = pdev->aer_stats;
+	struct aer_info *aer_info = pdev->aer_info;
 
-	if (!aer_stats)
+	if (!aer_info)
 		return;
 
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV)
-		aer_stats->rootport_total_cor_errs++;
+		aer_info->rootport_total_cor_errs++;
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
-			aer_stats->rootport_total_fatal_errs++;
+			aer_info->rootport_total_fatal_errs++;
 		else
-			aer_stats->rootport_total_nonfatal_errs++;
+			aer_info->rootport_total_nonfatal_errs++;
 	}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eef..72e6f5560164 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -346,7 +346,7 @@ struct pci_dev {
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
-	struct aer_stats *aer_stats;	/* AER stats for this device */
+	struct aer_info *aer_info;	/* AER info for this device */
 #endif
 #ifdef CONFIG_PCIEPORTBUS
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
-- 
2.48.0.rc2.279.g1de40edade-goog


