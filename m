Return-Path: <linux-pci+bounces-24079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E2BA6871C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747C03B84D3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235DB15A85A;
	Wed, 19 Mar 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+/SJRPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986E2512CA
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373686; cv=none; b=TYZ/q0dkMnk5QMsWfmvfx+CK+IG/Uq8kC4bqqXKxB3xXT3lkvms4+SuhUAsfU6KPb4Nkd7wB1efY3zQ/MIOkjIiZ3M1OQYgykyIedzmGkEuBBKr3YC2ItXpSJKHhyLeXPXLOlCBjNBUhe7VSKPlfYIW5w6Swn2whsivOzgD/06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373686; c=relaxed/simple;
	bh=TeZWUSpOCB32n9u2riK5ylRB52pVDGMKNkNlCeSVlKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7hmiEK3ilPDit6TU+geQLWGZ5v34dpGheI8fUDFll/SNjNzAk1Up8Nr1Wzy74w0U55t5Siw/Koikl6SxOIvgXGvL27Hcn+KQqW/Thw+8WwjsMrFSEZ+thNWqX/Zhj/rfdhjq6zW93lXMEueJ3a9HbI10CZWVDXp2IujcmO5beQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+/SJRPX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso9829798a91.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373683; x=1742978483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nCretJnBS2nY1fAHRYQJG5aABzBDIWxITv1PzKj408=;
        b=P+/SJRPXsmDwNiwI4Yvd10OhTcUMCQSCdCtfj42REK9dsdWrxJctCyERkT8OWjBOtF
         Noz+iOf0JgxHdN8DHeYIPDwHMQp2eaMZ7yDT6Vw3xIrjlqPTsmFmphSxAP+qkz+IQ5aA
         /Lu9sK9C0pqlrnbIw6dQUi3T802T5tB+ctPHaeM+Usos8rqcxN44ekfGVXtVHkOYpfne
         4DrnQSLsIIqffCZM3BlDxSmAalnCb/lqr6ywgXOEIcmDhlgRPd4HgwxgjkXGJM5RNC5Y
         hhAQlCS6sQ5N8ezhW1N3LGRmBB4iKL08TbxhRGnqM6v+4hO3uWGC7aisJD8Vx79ixBOe
         5D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373683; x=1742978483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nCretJnBS2nY1fAHRYQJG5aABzBDIWxITv1PzKj408=;
        b=tjX6REdv9mp3yUkR/6KJmbcAzFpUgyHqGVlep+hvDhsHSFGIRkJ91gpxrxRBCxwo2I
         KO07GFrUF1lvCjff3zeOmatxKNp00/tlWnxGjL/n898G5zF0ovEGA34wQ+Nd3mxo1G/+
         Wg/YoBM70ivUhEdmpQp5hVPzRkYiX+dhmYRi98tpZDstlHVLPMNSoeeCIlv1BCHuSRdb
         kFeRS24HmDeyEZJsWPYzLXQMQoXg+eTbjr94fKpzCHmR69CFAvyYqGLI7rk48lcWawEw
         G01scEOBk/kDW5k3QcW66qkb3SXaW0fUSMwXicV1ao1UsoivH9FaH/bfjaRX11WbmhVo
         GFOQ==
X-Gm-Message-State: AOJu0Yw3hBj5i1y6TmtVg+Ew0Vb/fKZ2lUE0TunT+vQZOZDEMLEnL6JB
	zNraVytITaKWF7XWAVCybPwkIX/MHMjaK5zCl/3JohN0TZ6JHZX0JOX+ED+/Rij2BwacbVTtRjX
	/9w==
X-Google-Smtp-Source: AGHT+IHwiKQl2w0+23EJxQRXLKrhn47bFKCcSOG31ydtjbQtLc987QyphmoyXLRf3p/hjzwCjGEmU23AtmI=
X-Received: from pgbcp13.prod.google.com ([2002:a05:6a02:400d:b0:af5:6a6:3cfd])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:594:b0:1f5:7b6f:f8e8
 with SMTP id adf61e73a8af0-1fbeae9141bmr3327172637.6.1742373683624; Wed, 19
 Mar 2025 01:41:23 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:48 -0700
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-8-pandoh@google.com>
Subject: [PATCH v3 7/8] PCI/AER: Add sysfs attributes for log ratelimits
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

Allow userspace to read/write log ratelimits per device (including
enable/disable). Create aer/ sysfs directory to store them and any
future aer configs.

Tested using aer-inject[1]. Configured correctable log ratelimit to 5.
Sent 6 AER errors. Observed 5 errors logged while AER stats
(cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) shows 6.

Disabled ratelimiting and sent 6 more AER errors. Observed all 6 errors
logged and accounted in AER stats (12 total errors).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 .../testing/sysfs-bus-pci-devices-aer_stats   | 34 +++++++
 Documentation/PCI/pcieaer-howto.rst           |  3 +
 drivers/pci/pci-sysfs.c                       |  1 +
 drivers/pci/pci.h                             |  1 +
 drivers/pci/pcie/aer.c                        | 93 +++++++++++++++++++
 5 files changed, 132 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index d1f67bb81d5d..4561653fdbde 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -117,3 +117,37 @@ Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_NONFATAL messages reported to rootport.
+
+PCIe AER ratelimits
+-------------------
+
+These attributes show up under all the devices that are AER capable.
+They represent configurable ratelimits of logs per error type.
+
+See Documentation/PCI/pcieaer-howto.rst for more info on ratelimits.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_log_enable
+Date:		March 2025
+KernelVersion:	6.15.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Writing 1/0 enables/disables AER log ratelimiting. Reading
+		gets whether or not AER is currently enabled. Enabled by
+		default.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_in_5secs_cor_log
+Date:		March 2025
+KernelVersion:	6.15.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Ratelimit burst for correctable error logs. Writing a value
+		changes the number of errors (burst) allowed per interval
+		(5 second window) before ratelimiting. Reading gets the
+		current ratelimit burst.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_in_5secs_uncor_log
+Date:		March 2025
+KernelVersion:	6.15.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Ratelimit burst for uncorrectable error logs. Writing a
+		value changes the number of errors (burst) allowed per
+		interval (5 second window) before ratelimiting. Reading
+		gets the current ratelimit burst.
diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 896d2a232a90..b45a2e18d1cf 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -96,6 +96,9 @@ type (correctable vs. uncorrectable).
 AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
 DEFAULT_RATELIMIT_INTERVAL (5 seconds).
 
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
index 9d63d32f041c..34633fe12201 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -889,6 +889,7 @@ void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
+extern const struct attribute_group aer_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0bd20c4993d4..13227a94c9f9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -631,6 +631,99 @@ const struct attribute_group aer_stats_attr_group = {
 	.is_visible = aer_stats_attrs_are_visible,
 };
 
+/*
+ * Ratelimit enable toggle uses interval value of
+ * 0: disabled
+ * DEFAULT_RATELIMIT_INTERVAL: enabled
+ */
+static ssize_t ratelimit_log_enable_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool enable = pdev->aer_report->cor_log_ratelimit.interval != 0;
+
+	return sysfs_emit(buf, "%d\n", enable);
+}
+
+static ssize_t ratelimit_log_enable_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool enable;
+	int interval;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	if (enable)
+		interval = DEFAULT_RATELIMIT_INTERVAL;
+	else
+		interval = 0;
+
+	pdev->aer_report->cor_log_ratelimit.interval = interval;
+	pdev->aer_report->uncor_log_ratelimit.interval = interval;
+	return count;
+}
+static DEVICE_ATTR_RW(ratelimit_log_enable);
+
+/*
+ * Ratelimits are doubled as a given error produces 2 logs (root port
+ * and endpoint) that should be under same ratelimit.
+ */
+#define aer_ratelimit_burst_attr(name, ratelimit)			\
+	static ssize_t							\
+	name##_show(struct device *dev, struct device_attribute *attr,	\
+		    char *buf)						\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	return sysfs_emit(buf, "%d\n",					\
+			  pdev->aer_report->ratelimit.burst / 2);	\
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
+	pdev->aer_report->ratelimit.burst = burst * 2;			\
+	return count;							\
+}									\
+static DEVICE_ATTR_RW(name)
+
+aer_ratelimit_burst_attr(ratelimit_in_5secs_cor_log, cor_log_ratelimit);
+aer_ratelimit_burst_attr(ratelimit_in_5secs_uncor_log, uncor_log_ratelimit);
+
+static struct attribute *aer_attrs[] = {
+	&dev_attr_ratelimit_log_enable.attr,
+	&dev_attr_ratelimit_in_5secs_cor_log.attr,
+	&dev_attr_ratelimit_in_5secs_uncor_log.attr,
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
2.49.0.rc1.451.g8f38331e32-goog


