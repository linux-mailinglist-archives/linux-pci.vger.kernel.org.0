Return-Path: <linux-pci+bounces-28302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B6AC17DA
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79F51889B69
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879782DFA40;
	Thu, 22 May 2025 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuFMI6pN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A52DFA3B;
	Thu, 22 May 2025 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956248; cv=none; b=bCFNptb2LfDy30Hqv8uNpZLLjIVNAdLF3MomD67a3/DWJT/ouC0SP1djJ7iUhMMpRO8I1ZMGmi3MawpW5ZN57TUk1Bxu7AYgXFUPWQ/ZQQHIF02b6O7V4z4A5L/T18XuD8eC0vA3MsUV97b2uGCOPz2kpcLgjXJzxYf4NjWkR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956248; c=relaxed/simple;
	bh=uCaCiY9efxgBJv60ZVH+iXqmS5SwXzJNsYZZZlxW8Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkD7sxj0ik1U9UtmwqfUs+b4Z7FABljqavmJaEBdtwuVjfE5B5hTLUjsuZe2SqhjWO19NXCuCunDss3sJANzxgQuwMUNgX5wkI+mQwy+6bZoK1jntb01jmlv8rOWvSpa/GJFanstTnshBaZ5d1kq1tn5eBThZplhLYP12dRVAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuFMI6pN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC17C4CEE4;
	Thu, 22 May 2025 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956248;
	bh=uCaCiY9efxgBJv60ZVH+iXqmS5SwXzJNsYZZZlxW8Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuFMI6pNvBwxaiXADTIiIT5zzfUox287pGwjzSX/imejHVXxRc3c1yBRJnC3dabHz
	 SufYtEg5Z23unijQZfQ3XZiLLwxwSKdUlIXoOVmnnQgQZITY1RvFyFXve3U3bNhGhb
	 6jIuZDX2+DDrY/3UG6j9xKo89qJeiFxqiTGKMcLXsTUHh86QdX1siP/wSZSvq5SY2O
	 OvYFR+/PdiXE3+FPakkO6xPRa7I9qvVV4HojF7EfF0DeqZqd4BwjFirOjo9VQXfmxY
	 OMYmnUbZNnNLG2BFyPG336jNiQS+F8Ew916msdNaacP1zAs0eBwXucJsvQVjWeyoQm
	 bKNxTEaRvm89Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v8 15/20] PCI/AER: Rename struct aer_stats to aer_info
Date: Thu, 22 May 2025 18:21:21 -0500
Message-ID: <20250522232339.1525671-16-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Karolina Stolarek <karolina.stolarek@oracle.com>

Update name to reflect the broader definition of structs/variables that are
stored (e.g. ratelimits). This is a preparatory patch for adding rate limit
support.

[bhelgaas: "aer_report" -> "aer_info"]

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250520215047.1350603-15-helgaas@kernel.org
---
 drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++---------------------
 include/linux/pci.h    |  2 +-
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 16779f281b2f..787a953fb331 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -54,8 +54,8 @@ struct aer_rpc {
 	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
 };
 
-/* AER stats for the device */
-struct aer_stats {
+/* AER info for the device */
+struct aer_info {
 
 	/*
 	 * Fields for all AER capable devices. They indicate the errors
@@ -377,7 +377,7 @@ void pci_aer_init(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return;
 
-	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+	dev->aer_info = kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
 
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
@@ -398,8 +398,8 @@ void pci_aer_init(struct pci_dev *dev)
 
 void pci_aer_exit(struct pci_dev *dev)
 {
-	kfree(dev->aer_stats);
-	dev->aer_stats = NULL;
+	kfree(dev->aer_info);
+	dev->aer_info = NULL;
 }
 
 #define AER_AGENT_RECEIVER		0
@@ -537,10 +537,10 @@ static const char *aer_agent_string[] = {
 {									\
 	unsigned int i;							\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	u64 *stats = pdev->aer_stats->stats_array;			\
+	u64 *stats = pdev->aer_info->stats_array;			\
 	size_t len = 0;							\
 									\
-	for (i = 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
+	for (i = 0; i < ARRAY_SIZE(pdev->aer_info->stats_array); i++) {	\
 		if (strings_array[i])					\
 			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
 					     strings_array[i],		\
@@ -551,7 +551,7 @@ static const char *aer_agent_string[] = {
 					     i, stats[i]);		\
 	}								\
 	len += sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,	\
-			     pdev->aer_stats->total_field);		\
+			     pdev->aer_info->total_field);		\
 	return len;							\
 }									\
 static DEVICE_ATTR_RO(name)
@@ -572,7 +572,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 		     char *buf)						\
 {									\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);	\
+	return sysfs_emit(buf, "%llu\n", pdev->aer_info->field);	\
 }									\
 static DEVICE_ATTR_RO(name)
 
@@ -599,7 +599,7 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (!pdev->aer_stats)
+	if (!pdev->aer_info)
 		return 0;
 
 	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
@@ -623,25 +623,25 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
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
@@ -653,19 +653,19 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
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
index 0e8e3fd77e96..81a81dbfc873 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -346,7 +346,7 @@ struct pci_dev {
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
-	struct aer_stats *aer_stats;	/* AER stats for this device */
+	struct aer_info	*aer_info;	/* AER info for this device */
 #endif
 #ifdef CONFIG_PCIEPORTBUS
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
-- 
2.43.0


