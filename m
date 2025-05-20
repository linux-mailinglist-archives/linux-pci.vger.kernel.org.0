Return-Path: <linux-pci+bounces-28161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F3CABE677
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6291F4C2A4C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7867727A47F;
	Tue, 20 May 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+CHOYSs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF14265CCD;
	Tue, 20 May 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777873; cv=none; b=JinXR5RpmBtleV0rqqjE+r1emfTPkBgF4mgPm3TUez4UiU4ycrrnfmNhPJSSlUhb94hAGhUR7k+GUgcsxFdrBDSg7ez+kCMdsRYu5+zZRucazpZhIF6Uxr6MQ3COXNR76RUnuKmlOw9L/m3M7Y7VwyPsUO/GN/2pjn/4v0bn5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777873; c=relaxed/simple;
	bh=g9hFqpf6tjCCHuP/6hTqf4eWjLuEo8f/FguQjUZa0Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6q1kzmHEWY62rgVOHgeh5I8TsQIKi+zP7AeYyDeRFHzHCClNT6LId4AZAfwPQ3d1kXiGHyzYtUJxdfJuSQ/A/xiu+rf5iTXN1xj883BOrcUDJiBmTkYpoWJgIeW36Tfa210gyzkSGSa3Fvi8XTPWqAgZZ58yShvdHvqDJwTPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+CHOYSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B70C4CEE9;
	Tue, 20 May 2025 21:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777873;
	bh=g9hFqpf6tjCCHuP/6hTqf4eWjLuEo8f/FguQjUZa0Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+CHOYSs7ipXELdPOFnBn0pnX7Qmg/MND5wQXOQcBYifLdkPWYy7ZQxiXfvRWXcUF
	 YkAsNqb+qLxDAr1t2IqRHGB44RsgckVl9Scas0qsC2PkOwDtk926l8YKFqtFk6LFpc
	 CSuhzxyHKCDXThNbYGo1jLSABQp6WTeVEXetSXBFbNtuq4MjcZvaleLZOjW5tqR3R4
	 4/FlSTVRFfrb21NIYHdLvXlQKn6RFNe8hsJJOPhsKoQEDBJVn2w/FRz98BCZ4+REhB
	 1qMjyGGgSVI1jkMnFVhfhm/W8hQLjf3J+JH/EOSAk/Dg/Wf11cXYtEAQ2/oKSz75KP
	 iVPxjs77O8IKQ==
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
Subject: [PATCH v7 14/17] PCI/AER: Rename struct aer_stats to aer_info
Date: Tue, 20 May 2025 16:50:31 -0500
Message-ID: <20250520215047.1350603-15-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520215047.1350603-1-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
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
---
 drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++---------------------
 include/linux/pci.h    |  2 +-
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4cdcf0ebd86d..4f1bff0f000f 100644
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
@@ -623,28 +623,28 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 	unsigned long status = info->status & ~info->mask;
 	int i, max = -1;
 	u64 *counter = NULL;
-	struct aer_stats *aer_stats = pdev->aer_stats;
+	struct aer_info *aer_info = pdev->aer_info;
 
 	trace_aer_event(pci_name(pdev), (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 
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
@@ -656,19 +656,19 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
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


