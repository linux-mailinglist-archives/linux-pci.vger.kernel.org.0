Return-Path: <linux-pci+bounces-24293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B5A6B2C9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E40B484BE0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9091DF979;
	Fri, 21 Mar 2025 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNXzMXxj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD51E0DE3
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522312; cv=none; b=N1Vi/HqJDUEM7Xd1rNFCdhvWWkwWKw9mZLAzFfXKRHaiXrtnsA1G30YMsDqKZAc37jJ4kq+UR2iB5NPgCMzbomfsGjizfEJ+n3NgsAZkfJL9XiD4LoIJmS44qFz8o2uAKOKE4e6CFI/IoOsadr5AVTtwC0BlU4K2O6BQSpgb5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522312; c=relaxed/simple;
	bh=eBDlw3kYxKBsIrrLfYRs4hkA241Bq3t/M760Hvx7rhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FHO89i8u9NDDKB5UFrdW8Rt+ewA6xQ8OahzMHpEvmMm+x9VtXht6v3LraUlNlMeKfzVD4+v5hY1gAdx9hfiUlGjJNJGFTQf9SQGM91qClod0C4cHPPDXkQeC+7KFI2+41bB/RewDALnVw1Fbpzwdvex8XhXCFucyYhePFL5S8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNXzMXxj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so2145078a91.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522308; x=1743127108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSlDRCpgl37U9figS6TqEc6twssN3tdNNFoHohbnql0=;
        b=KNXzMXxjel8hMfBhn6QcKXqXziqTyiupKgepXc3aJtJqTEu4JjU1SlG6Tj0HMa9i58
         obiEuyiSUHJ/jLnuUhuSbm6fTy1tCimifsVEaBZ5ZHR/uFH+IvpmJiWfQq+lyiBnalE5
         LQzTCtiUoG7B9vvcns80IrvOh/ZQ9WT21la1PPF+oCum5KrLmW8jTGri03nAp92wd99K
         TGke3Q0iBI1THOWTRdvpUh4d4wAqjZR6z8C+0g66qkDQhqbw3T2za2JO3ITEf/d89Tyh
         VMKxiWLvxgr/oL+YQnhDIh85nUkqsxlNvYOhSDzwdDyBzdb7xMQIf5ErhOsZFb9g1ze5
         oZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522308; x=1743127108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSlDRCpgl37U9figS6TqEc6twssN3tdNNFoHohbnql0=;
        b=VIDtBCMBcKBK881qC4uyIO9yiFhQAUdE9RPMatoexoESh3/pOKKYeF2VPj3p+UgmRK
         qDZlnPeMUsnAyif3Fqbcm33HsTIPgSxro2bBM2gSpPS94L9qp9qKqwO/g0BhTJmpuXX6
         xb+iY0CGQsj71CmUCp0ygF3Lh9J659L6mH12Elbc6Kzn8gWQI9ZyC8YGF5OJA+BIf54z
         lDx76cYgyeEWl23mXoVb2XrvgPlxFK262cwzi5gs6JjPzWqaKYq2rHAX5136ldweTDOJ
         GzeKZ4gRj/KMg0wq+wGeS3OlPmNYqoL/O7W9CIsY2+HP1ZouctOezKz/Wx+xK3LSiPJO
         zGNA==
X-Gm-Message-State: AOJu0Ywakknxzm5olR8q/7SUG0DwWC4FbkCtrlmrteCPi2DhyDWU98WG
	vircWuCLW51NSXcqchdpURd9ydWwdXDeFWq5j2Tj6We9kJ6ZrcW+zY/41EgRGyY9eRutvWRoemM
	jhg==
X-Google-Smtp-Source: AGHT+IHk5Z2jgxcqta/SZb+1nluywN8KlkoF4GjKvueD2//+gFmaBcTddVKcDcp9+ykg1z+1s3QBGHHOkPw=
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:2ea:46ed:5d3b])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ed0:b0:2fe:b470:dde4
 with SMTP id 98e67ed59e1d1-3030fe8bcb9mr2785653a91.12.1742522308600; Thu, 20
 Mar 2025 18:58:28 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:58:03 -0700
In-Reply-To: <20250321015806.954866-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-6-pandoh@google.com>
Subject: [PATCH v5 5/8] PCI/AER: Rename struct aer_stats to aer_report
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

Update name to reflect the broader definition of structs/variables that
are stored (e.g. ratelimits). This is a preparatory patch for adding rate
limit support.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reported-by: Sargun Dhillon <sargun@meta.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
 include/linux/pci.h    |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3c63a6963608..f657edca8769 100644
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
+	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
 
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
index e4bf67bf8172..900edb6f8f62 100644
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
2.49.0.395.g12beb8f557-goog


