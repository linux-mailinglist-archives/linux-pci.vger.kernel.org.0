Return-Path: <linux-pci+bounces-24076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19FA68719
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29000188E8A1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95973211484;
	Wed, 19 Mar 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NK9BOLlk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EDE15A85A
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373678; cv=none; b=GpBo/tBAViZXgDPgw+QHgwjeRxUIyVibtlSUBE+489saspGNtMooQ+RIhPJqs1BHg9mJ7kPQLLsAut2uM+5k47HY/PN0x8sQlSbNeKKk7awwukrtrqL6pF/OXtyFBZgn/Ioj3VykWJy3EKZP+oxbjVM2IvNj1K3u3LMFLtjAWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373678; c=relaxed/simple;
	bh=D52k/V2+ySBp35k3r/sRpXOjOyawcpoPAzRXcEaRxTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rfgHQpXqT6oINM856GEffjEi9FWjTTaIn1SbXNXRU/HlPWnKIua5tkJRxX4IzjJynF+vZf9DEBFDRyZhShZY2ImYPsFnrML2bgtSnpljgZNNSApbewKOC5wspeRfmZpPAORGTZGiyF1d0Vi/Xi1Z3mPJL0VPel4SxHuThUSDE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NK9BOLlk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241ae15dcbso145307965ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373675; x=1742978475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylRFZdS+00GELz/E0NJuN4dLw4/VfSWwgK2tlYwfNAQ=;
        b=NK9BOLlkNgpgdk3B3AA0wX+jWKJNJn3y00WYhFo7ZsGCtpDhi99NzcAE9qf9dX8nal
         R9vE/pY472QMa23H+XZD+E9x44kKbbpZWcotN0rPEYgISQwVmsiWvmqqo5ObLWYtZFND
         K1VzaKKxtldasEWuiGP1D5FHyJIaYGBv28rKumUVJkbtL9AebTUI120kzut9Q+qI2uSa
         Ad7zWSR7vIVCT/gLMjtvAzpXnx7fhwaj4BaFf0DpX4Dp4GfXEloLPY/0nvIwiKHzWRUj
         GDbEYYhWAS3RNQyp1PiwqDdOmL1tKFpWzam0YTJc3RCIPa1Vfd4NRLfMn2vJI9c1QQdO
         nFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373675; x=1742978475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylRFZdS+00GELz/E0NJuN4dLw4/VfSWwgK2tlYwfNAQ=;
        b=UblEbAJK7olrKUNQLuoj0JWsMOmekf5cWWTAZ4mf5MteTcXiO3Y0a0O/0zIh/oFumz
         xtnwJJott8i4GrknOPxyl8VlpdZ6h2Gs5aElOBhwGsVVz+ojLURP6aXG9mr6Zz3r/UnQ
         Dypo8nKRWESAK48xXf04wjr4GjNGNYGXYbvuCFRD49cMk25j1Yp1TOUz5bE+2RKq33Kb
         2cyr+QObpHkPN76xMZUmMdoxXTG2e0GK81Bh1jbVBWINxLS9dvK10MRxA7NyRtb+ZkPL
         oUh8B+fOsG7ot+NthNEh5hoZszRX71ECCFLbOZVLJngIa1cS9s3tvjJaOSWvJMjeVO3E
         sNzA==
X-Gm-Message-State: AOJu0Yzalb/eNl64A9FZIWgu5PcTnQk/fgZ9DzxVVxnU/yIyJ+Bg7ju+
	vtVdiU680zVko9UhFHG7lONleOiOsT+aLBLASoUBnmMXx3H8G8ffRHwUd2nIxmnMsV9KwGs7282
	q7A==
X-Google-Smtp-Source: AGHT+IGEKT1sevi4fpK2NcNRqNySKuy0ss1KXf2MvZO+d1ckoTJCmGWl7S+vPpPHNdqiBNKiU3uFw0XnctA=
X-Received: from pfbna11.prod.google.com ([2002:a05:6a00:3e0b:b0:730:4672:64ac])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d4a:b0:736:a77d:5412
 with SMTP id d2e1a72fcca58-7376d633ae0mr2718307b3a.12.1742373675149; Wed, 19
 Mar 2025 01:41:15 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:45 -0700
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-5-pandoh@google.com>
Subject: [PATCH v3 4/8] PCI/AER: Rename struct aer_stats to aer_report
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

Update name to reflect the broader definition of structs/variables that
are stored (e.g. ratelimits).

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
 include/linux/pci.h    |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8e4d4f9326e1..3a12980f7dd7 100644
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
2.49.0.rc1.451.g8f38331e32-goog


