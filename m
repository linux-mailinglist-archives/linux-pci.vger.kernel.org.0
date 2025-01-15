Return-Path: <linux-pci+bounces-19843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977AA11B31
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D97188AC96
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029135944;
	Wed, 15 Jan 2025 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9ZyrnQA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95C22F84A
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927017; cv=none; b=Ar+DY1eUY54lbwmXIFOgL2GLa6KcYE4jhVgM2nCQvWSZPJj/1qUkHaqn6nskt84lfFTVdL+i4hTsN0uLgWjH+dtC1gcgEpnjdxBvHvSO+CPzO11wy/ANe4yMZa+RUOlA3lBAMy4fkQsAhk8Jy26wP8GUhhsdEEgtxTcVWlp6u/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927017; c=relaxed/simple;
	bh=AmX3sj84Axy3Te5hRUYWAisKnHDQ42FvBLSN/lQmFAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B2ptWko+UGH2rjxbHi0nodAgesY1hB1M6OCEiHS5MC4sa6qYO8XOHc+kQXN/jc7DHeW2XZzzb/04er1WsyqT43rZ7C/TwoAjxJ3ojq5xAA37DVxLbIgJjbciIbwXHW3+rxxykUmvaqhlmjDfrm+tZFiBL/p82cyzQy9yZXvkseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9ZyrnQA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21648c8601cso107676125ad.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927015; x=1737531815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DL5cB9M1yphXMlMTohz+ovJ0iS53nDSxYYcxqM/vlWE=;
        b=v9ZyrnQAud5iMfujDgiWMFIrI6liwntG0Mve85tTKnVDNDEAqNwywl1zUPjytViKKY
         nJ+M/xrlYHcz4K3lSDdZM8/XSAvnIYpvmdT9M+eMm2vf9MsYsnSQUkimb3K1JVufVxrz
         2s+cLONiouorLdg4jazweX4IhdgvAlGgMP/EoGBQl84sAnI6inTqY1UvByEftdlr4pk5
         ANUCRpQuzprccOoTny9cud2FVzccOockF4PW8jCpdOVORyKwWPPSYGS2DHwlgLl9TbpI
         O1oFM2cpEuvlzEfc2gBf8t9v+9XLBqQejHL6YhYdzpX6wYPRnNnrWAzNVtZ/dwNbycO+
         bEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927015; x=1737531815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DL5cB9M1yphXMlMTohz+ovJ0iS53nDSxYYcxqM/vlWE=;
        b=aHI3NbqlqrCEsvrB+NRV2/t6QtLrSZqV5qA8Pd0Mb2M8bjp322crYVy7Ai46LFm/EQ
         my4ZvW4cKHIFUyOXR4nUk4/F3QNtxLMaqVbxbgJOOvX0COY6+xOf5LjpjWzLnGA2SCKR
         pvz2p/Nmd1xeNksOV9gT6E7y755ebUAlZ3TR2dWbHBRVtr3yMRVd2DFYWdfdAkFgrjrA
         h8/nB1alLgNuy97CKbCLDT0cgPTIIgMIAGPRhCayGMMJUvJkmuxbEy1HubOI8dGWlxB3
         k/lvSzmvESQImkzKse4LbRlScJ4IhEtdqxiuoKVRZogtEHi5UK0b242r0EN9GDasdBdO
         b7Sg==
X-Gm-Message-State: AOJu0YylLzDt3rqzwR/LnSza5TIa9jxKJmGzWuFqQKJJjo9XNM4Nufv2
	cmVeDhemIMRRMzLXOR+82yoZKQ36RIysgnTgPylYppHAScaa4LkLzmsP7+Nzrqn3zA64aNtX0zl
	7ow==
X-Google-Smtp-Source: AGHT+IHxjYgc/3qBkaeexQjj9Cur+QV9IrZxJ8Ce9HjFjRciZpckF6E6Q6S3n31iXUVFkebt2mM84Ahxi3M=
X-Received: from pgpj10.prod.google.com ([2002:a65:428a:0:b0:7fd:de44:ec7d])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7284:b0:1e0:eb49:b81b
 with SMTP id adf61e73a8af0-1e88d09c97emr49185248637.31.1736927014705; Tue, 14
 Jan 2025 23:43:34 -0800 (PST)
Date: Tue, 14 Jan 2025 23:43:00 -0800
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-9-pandoh@google.com>
Subject: [PATCH 8/8] PCI/AER: Move AER sysfs attributes into separate directory
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepare for the addition of new AER sysfs attributes (e.g. ratelimits)
by moving them into their own directory. Update naming to reflect
broader definition and for consistency.

/sys/bus/pci/devices/<dev>/aer_dev_correctable
/sys/bus/pci/devices/<dev>/aer_dev_fatal
/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
/sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
/sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
/sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
->
/sys/bus/pci/devices/<dev>/aer/err_cor
/sys/bus/pci/devices/<dev>/aer/err_fatal
/sys/bus/pci/devices/<dev>/aer/err_nonfatal
/sys/bus/pci/devices/<dev>/aer/rootport_total_err_cor
/sys/bus/pci/devices/<dev>/aer/rootport_total_err_fatal
/sys/bus/pci/devices/<dev>/aer/rootport_total_err_nonfatal

Tested using aer-inject[1] tool. Sent 1 AER error. Observed AER stats
correctedly logged (cat /sys/bus/pci/devices/<dev>/aer/dev_err_cor).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 .../ABI/testing/sysfs-bus-pci-devices-aer     | 18 +++---
 drivers/pci/pci-sysfs.c                       |  1 -
 drivers/pci/pci.h                             |  1 -
 drivers/pci/pcie/aer.c                        | 64 +++++++------------
 4 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
index c680a53af0f4..e1472583207b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
@@ -9,7 +9,7 @@ errors may be "seen" / reported by the link partner and not the
 problematic endpoint itself (which may report all counters as 0 as it never
 saw any problems).
 
-What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
+What:		/sys/bus/pci/devices/<dev>/aer/err_cor
 Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -19,7 +19,7 @@ Description:	List of correctable errors seen and reported by this
 		TOTAL_ERR_COR at the end of the file may not match the actual
 		total of all the errors in the file. Sample output::
 
-		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_correctable
+		    localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # cat err_cor
 		    Receiver Error 2
 		    Bad TLP 0
 		    Bad DLLP 0
@@ -30,7 +30,7 @@ Description:	List of correctable errors seen and reported by this
 		    Header Log Overflow 0
 		    TOTAL_ERR_COR 2
 
-What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
+What:		/sys/bus/pci/devices/<dev>/aer/err_fatal
 Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -40,7 +40,7 @@ Description:	List of uncorrectable fatal errors seen and reported by this
 		TOTAL_ERR_FATAL at the end of the file may not match the actual
 		total of all the errors in the file. Sample output::
 
-		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_fatal
+		    localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # cat err_fatal
 		    Undefined 0
 		    Data Link Protocol 0
 		    Surprise Down Error 0
@@ -60,7 +60,7 @@ Description:	List of uncorrectable fatal errors seen and reported by this
 		    TLP Prefix Blocked Error 0
 		    TOTAL_ERR_FATAL 0
 
-What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer/err_nonfatal
 Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -70,7 +70,7 @@ Description:	List of uncorrectable nonfatal errors seen and reported by this
 		TOTAL_ERR_NONFATAL at the end of the file may not match the
 		actual total of all the errors in the file. Sample output::
 
-		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_nonfatal
+		    localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # cat err_nonfatal
 		    Undefined 0
 		    Data Link Protocol 0
 		    Surprise Down Error 0
@@ -100,19 +100,19 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
+What:		/sys/bus/pci/devices/<dev>/aer/rootport_total_err_cor
 Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
+What:		/sys/bus/pci/devices/<dev>/aer/rootport_total_err_fatal
 Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer/rootport_total_err_nonfatal
 Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 41acb6713e2d..e16b92edf3bd 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1692,7 +1692,6 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 	&pci_bridge_attr_group,
 	&pcie_dev_attr_group,
 #ifdef CONFIG_PCIEAER
-	&aer_stats_attr_group,
 	&aer_attr_group,
 #endif
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9d0272a890ef..a80cfc08f634 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -880,7 +880,6 @@ static inline void of_pci_remove_node(struct pci_dev *pdev) { }
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
-extern const struct attribute_group aer_stats_attr_group;
 extern const struct attribute_group aer_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e48e2951baae..68850525cc8d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -569,13 +569,13 @@ static const char *aer_agent_string[] = {
 }									\
 static DEVICE_ATTR_RO(name)
 
-aer_stats_dev_attr(aer_dev_correctable, dev_cor_errs,
+aer_stats_dev_attr(err_cor, dev_cor_errs,
 		   aer_correctable_error_string, "ERR_COR",
 		   dev_total_cor_errs);
-aer_stats_dev_attr(aer_dev_fatal, dev_fatal_errs,
+aer_stats_dev_attr(err_fatal, dev_fatal_errs,
 		   aer_uncorrectable_error_string, "ERR_FATAL",
 		   dev_total_fatal_errs);
-aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
+aer_stats_dev_attr(err_nonfatal, dev_nonfatal_errs,
 		   aer_uncorrectable_error_string, "ERR_NONFATAL",
 		   dev_total_nonfatal_errs);
 
@@ -589,47 +589,13 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 }									\
 static DEVICE_ATTR_RO(name)
 
-aer_stats_rootport_attr(aer_rootport_total_err_cor,
+aer_stats_rootport_attr(rootport_total_err_cor,
 			 rootport_total_cor_errs);
-aer_stats_rootport_attr(aer_rootport_total_err_fatal,
+aer_stats_rootport_attr(rootport_total_err_fatal,
 			 rootport_total_fatal_errs);
-aer_stats_rootport_attr(aer_rootport_total_err_nonfatal,
+aer_stats_rootport_attr(rootport_total_err_nonfatal,
 			 rootport_total_nonfatal_errs);
 
-static struct attribute *aer_stats_attrs[] __ro_after_init = {
-	&dev_attr_aer_dev_correctable.attr,
-	&dev_attr_aer_dev_fatal.attr,
-	&dev_attr_aer_dev_nonfatal.attr,
-	&dev_attr_aer_rootport_total_err_cor.attr,
-	&dev_attr_aer_rootport_total_err_fatal.attr,
-	&dev_attr_aer_rootport_total_err_nonfatal.attr,
-	NULL
-};
-
-static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
-					   struct attribute *a, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	if (!pdev->aer_info)
-		return 0;
-
-	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
-	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
-	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
-	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
-	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
-		return 0;
-
-	return a->mode;
-}
-
-const struct attribute_group aer_stats_attr_group = {
-	.attrs  = aer_stats_attrs,
-	.is_visible = aer_stats_attrs_are_visible,
-};
-
 #define aer_ratelimit_attr(name, ratelimit)				\
 	static ssize_t							\
 	name##_show(struct device *dev, struct device_attribute *attr,	\
@@ -662,6 +628,14 @@ aer_ratelimit_attr(ratelimit_cor_log, cor_log_ratelimit);
 aer_ratelimit_attr(ratelimit_uncor_log, uncor_log_ratelimit);
 
 static struct attribute *aer_attrs[] __ro_after_init = {
+	/* Stats */
+	&dev_attr_err_cor.attr,
+	&dev_attr_err_fatal.attr,
+	&dev_attr_err_nonfatal.attr,
+	&dev_attr_rootport_total_err_cor.attr,
+	&dev_attr_rootport_total_err_fatal.attr,
+	&dev_attr_rootport_total_err_nonfatal.attr,
+	/* Ratelimits */
 	&dev_attr_ratelimit_cor_irq.attr,
 	&dev_attr_ratelimit_uncor_irq.attr,
 	&dev_attr_ratelimit_cor_log.attr,
@@ -670,13 +644,21 @@ static struct attribute *aer_attrs[] __ro_after_init = {
 };
 
 static umode_t aer_attrs_are_visible(struct kobject *kobj,
-				     struct attribute *a, int n)
+					   struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (!pdev->aer_info)
 		return 0;
+
+	if ((a == &dev_attr_rootport_total_err_cor.attr ||
+	     a == &dev_attr_rootport_total_err_fatal.attr ||
+	     a == &dev_attr_rootport_total_err_nonfatal.attr) &&
+	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
+		return 0;
+
 	return a->mode;
 }
 
-- 
2.48.0.rc2.279.g1de40edade-goog


