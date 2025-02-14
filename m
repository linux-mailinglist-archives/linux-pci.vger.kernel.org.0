Return-Path: <linux-pci+bounces-21417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475B4A354CA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCDC16DF10
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21E2AE97;
	Fri, 14 Feb 2025 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+ZzaWcN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F9136326
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500585; cv=none; b=e+2qqwiWJR0/bklPdbRBdnPfRk12+m+DaGRSCgPm7sC2AnySULQQWKxi3XcJR+ad7e8J8R1KfZCBZfKEztNoA8vxIHitf3j9BTgqQf2yvRo0SvGb4gkz4ZLbGmePOETaQ+2yXkiRvZZNu3enVMKaH45aH/XOSlXO44/M3MbNreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500585; c=relaxed/simple;
	bh=zHNPwjvqMbYWPRe/BLv8C6Omqisj5M1d3E76jv1VA8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hrih9f3iBLsh9QNT87gYUjMBxZ3EByTkv8inNdMuMl+ZE+xFaTFv6NtqRvIHyAfTuJRV23Bxs6B32qM+z+rXoU9/b+uAPH5QTso1eBAdkK7hwtHAali0d5xy5XGNyQCdcQlwkV+w4A4Yferr/4/wNk2hFgj3BX1UYEWfOfCxtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+ZzaWcN; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5fa6a278c85so1234668eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500583; x=1740105383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pNKB3I7BbHswYn15akFQPmWXBgHAWIqEvH/mkoVFIs=;
        b=q+ZzaWcNKICpnoUSBnYE4hurClRg79mtD++cxNMM8nwe1q7bsRiye9t5tCmtP0Zcqo
         /aXqhic8nkLEgOs8A8KdH7bZuTzo0Y8Mp6nRQWNyZ4gEFi+hPRwzsFNSbnT5M0YRZgr5
         JZvkG/b/QA79FOOlKrkrSfXrCvmr5NX6aYa5x0PLTtzUEBEWp9r9Iu+16PoaqfWuvOz4
         hni7uWcd2Qs9I1o4QYqn8GR9cKfTxTjYTRLAYNuLD363e0UQdNmXizk8GDWt0fJOzrq0
         jZzl4lAGlJ9LoWuwt/V9R6OD4iRX0SMk4+F/a9xx66A15+9iFGKDi0GxewT5SCx1+ddQ
         /0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500583; x=1740105383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pNKB3I7BbHswYn15akFQPmWXBgHAWIqEvH/mkoVFIs=;
        b=fdcuZDjaIW5Ap2Ir5shT5D4UpPNNIfLiFjuRbZD1VJBYJ9FgIdi7QQbadre85juTI+
         g2nTsh+YGQvQSgR6a6RnIe80g8ChJLjH8bSfwpYpzB2UoEvhm6vjS/ahleB+MNc81FD+
         K3cPInfh4inHA+1nFLWxnWux9I3ZZEQMqA2ypxGltdA1xpeimLtRFHqPAN+MFD/IDtPj
         xJ7xvfBYEb58j8LXOObaWVPJbfGjP8do/kAMdzjVajfYlGErP/8ovL1Oi/G7g99r4Boc
         b4u9xccUrjMC8UzrURRTNQiz5+F8iZpmFEjsZSS+AwTVsMzjLPFNdo1nr+UKJylxtw/W
         JF2g==
X-Gm-Message-State: AOJu0Yw0HITcYGO7MHRUMQsubAAOiZeFK/IF2TZlxZcRoQs5w54QWRuF
	rquv2I6cPYBvplzZjQReMk5RpRjMJWq5vxMDMQT+5hJd2yJVKroldsvkfEwKhKgEuMvyKRu4N6V
	dVA==
X-Google-Smtp-Source: AGHT+IETEcb+HqvPWWcqKtpyXb7igRCn39lwXsrDdowGWQWVHtaKFahmg+pSv5Z0oMC7HkZucD5yjjeo90Q=
X-Received: from oabdy38.prod.google.com ([2002:a05:6870:c7a6:b0:2bc:757d:e145])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:e393:b0:296:5928:7a42
 with SMTP id 586e51a60fabf-2b8dad8de41mr5414220fac.22.1739500583033; Thu, 13
 Feb 2025 18:36:23 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:42 -0800
In-Reply-To: <20250214023543.992372-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-8-pandoh@google.com>
Subject: [PATCH v2 7/8] PCI/AER: Add AER sysfs attributes for log ratelimits
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow userspace to read/write log ratelimits per device. Create aer/ sysfs
directory to store them and any future aer configs.

Tested using aer-inject[1]. Configured correctable log ratelimits to 5.
Sent 6 AER errors. Observed 5 errors logged while AER stats
(cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) shows 6.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 .../testing/sysfs-bus-pci-devices-aer_stats   | 20 +++++++
 Documentation/PCI/pcieaer-howto.rst           |  3 ++
 drivers/pci/pci-sysfs.c                       |  1 +
 drivers/pci/pci.h                             |  1 +
 drivers/pci/pcie/aer.c                        | 52 +++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index d1f67bb81d5d..c1221614c079 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -117,3 +117,23 @@ Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_NONFATAL messages reported to rootport.
+
+PCIe AER ratelimits
+-------------------
+
+These attributes show up under all the devices that are AER capable.
+Provides configurable ratelimits of logs/irq per error type. Writing a
+nonzero value changes the number of errors (burst) allowed per 5 second
+window before ratelimiting. Reading gets the current ratelimits.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_cor_log
+Date:		March 2025
+KernelVersion:	6.15.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Log ratelimit for correctable errors.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_uncor_log
+Date:		March 2025
+KernelVersion:	6.15.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Log ratelimit for uncorrectable errors.
diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 167c0b277b62..ab5b0f232204 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -93,6 +93,9 @@ spammy devices from flooding the console and stalling execution. Set the
 default ratelimit to DEFAULT_RATELIMIT_BURST over
 DEFAULT_RATELIMIT_INTERVAL (10 per 5 seconds).
 
+Ratelimits are exposed in the form of sysfs attributes and configurable.
+See Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats.
+
 AER Statistics / Counters
 -------------------------
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b46ce1a2c554..16de3093294e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1801,6 +1801,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 	&pcie_dev_attr_group,
 #ifdef CONFIG_PCIEAER
 	&aer_stats_attr_group,
+	&aer_attr_group,
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 26104aee06c0..26d30a99c48b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -887,6 +887,7 @@ void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
+extern const struct attribute_group aer_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c5b5381e2930..1237faee6542 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -626,6 +626,58 @@ const struct attribute_group aer_stats_attr_group = {
 	.is_visible = aer_stats_attrs_are_visible,
 };
 
+#define aer_ratelimit_attr(name, ratelimit)				\
+	static ssize_t							\
+	name##_show(struct device *dev, struct device_attribute *attr,	\
+		    char *buf)						\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	return sysfs_emit(buf, "%u errors every %u seconds\n",		\
+			  pdev->aer_report->ratelimit.burst,		\
+			  pdev->aer_report->ratelimit.interval / HZ);	\
+}									\
+									\
+	static ssize_t							\
+	name##_store(struct device *dev, struct device_attribute *attr,	\
+		     const char *buf, size_t count)			\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	int burst;							\
+									\
+	if (kstrtoint(buf, 0, &burst) < 0)				\
+		return -EINVAL;						\
+									\
+	pdev->aer_report->ratelimit.burst = burst;			\
+	return count;							\
+}									\
+static DEVICE_ATTR_RW(name)
+
+aer_ratelimit_attr(ratelimit_cor_log, cor_log_ratelimit);
+aer_ratelimit_attr(ratelimit_uncor_log, uncor_log_ratelimit);
+
+static struct attribute *aer_attrs[] __ro_after_init = {
+	&dev_attr_ratelimit_cor_log.attr,
+	&dev_attr_ratelimit_uncor_log.attr,
+	NULL
+};
+
+static umode_t aer_attrs_are_visible(struct kobject *kobj,
+				     struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pdev->aer_report)
+		return 0;
+	return a->mode;
+}
+
+const struct attribute_group aer_attr_group = {
+	.name = "aer",
+	.attrs = aer_attrs,
+	.is_visible = aer_attrs_are_visible,
+};
+
 void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
 {
 	unsigned long status = info->status & ~info->mask;
-- 
2.48.1.601.g30ceb7b040-goog


