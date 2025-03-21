Return-Path: <linux-pci+bounces-24296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC8A6B2C6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA651890C3B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F911DF979;
	Fri, 21 Mar 2025 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wS4g56oP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B91DFE09
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522319; cv=none; b=pVMiVIOw8+6FI8/S+GuWmaagR3t72C5rGsyscqoMTpmUMfT/sxhYYMZbIH7zxtPPvB0OtVzsW7H9FvB2rYjEiDuao2L88KYT5OaaKTHOclTkGAw+CK/vjEl9lr91Gvq3tu1F/lYCvVcvNYSAsFxbIoUtDffuv2X6lqqKRlHD+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522319; c=relaxed/simple;
	bh=Cyc+iGcTMC7PbEtu/AWAoorbDdcoNPH909ihUE8z8y0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U5cVVbtoINbFenic5Lpf2QsrBTlq9NyqCgry3I56evOo80URSiVWQMJfNzhvCZZlHAwXS3oRgyHENJ+WQekwG8EwjOdl9pLDCKnAcSK4YXGOqcIeNRUUyys6uh94qJWhCZNLuj31hCwNl8KKNj5z9PblkAapEASBNxtXMHF70Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wS4g56oP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-223fd6e9408so31218705ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522316; x=1743127116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfbKQmTZJ7P0U94YU6LPwlYihNVjzFy2qGlkfDxqDUw=;
        b=wS4g56oPKfWty/Vr2ogMkVezCRIH9q8Kck6wlzV9OK98PuJxA3RRgF59QNRpl+LG1R
         2+r2EaNB89a3NS6ER2GhvQynBuba0kNcPmBA7QJDVUtfiMfcgShq0BStqa5ckgVwmuWE
         IHQbc/a6zIeb+GSYC9zGGoK9wus4XvqMKVAQ4m4P5Nt8r8oqiJosa3KBlJpkeh4B/2Os
         uP8GQH4GScaCz0UuXi38MvQMmmbEuDi9fEkIwIrf1Ryjj4rkivZzbRJInt8bjiUqAG9X
         8mgR5P5v9dZ360aYYOuVJ2zMZmepo79QphO4zKqKcYv+7EmT6ACQ0VfYMZs683M8zZza
         +Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522316; x=1743127116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfbKQmTZJ7P0U94YU6LPwlYihNVjzFy2qGlkfDxqDUw=;
        b=AgulZASNCDBbGNnwLApMsQeBJBz0AUbZwUKQSRvxLdOZoAlF/Q9+NGxHMpbzxzG3ee
         hf99inzeYFDhdcuA9o1C6YbWfxYrsXa3qwc0yyzO/8/EhLLs2gArmd3E6YFXYySvJrZx
         VgMUPI2pi5M4MhkL2f3uY72seEys4QJJ4PYj1kTtn2CzAp1YJTMVwnvtkcmwdxYc67e8
         QKO0yoVYegn9JNhQNDWA7o1mQXu7PbrJJxVyu4tX3pzxtjUkNqTK0jye6ylqGhmcxslr
         Ik0g1RCzz3WC+zYfk8VJDtLRiYTeKqZ7XadzD7SyNGWAMgoIDpk/AxCK3CyIxqTHRdKz
         377Q==
X-Gm-Message-State: AOJu0Yw9oixKsBWfXyBaF51Y8/LKqpEqePVoCjRC5BbNV2kgxriV64GC
	Zzhiu8bDB1tyU4LFFIADC20JXQtz6Cg072A09PO1Ofrss1oyhmncH5oWnTen9tl1SRt8MHvbpDb
	0kQ==
X-Google-Smtp-Source: AGHT+IFUhPFz6Qx4a/nyLTmNCrBaqSNFwX7hnbSAgXoyTwNl0auHjQkKFoZ1EukIvXvGzBfmVCEnLC7T/wQ=
X-Received: from pfhx7.prod.google.com ([2002:a05:6a00:1887:b0:739:9e9:feea])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14d3:b0:736:476b:fccc
 with SMTP id d2e1a72fcca58-73905a05232mr2884251b3a.8.1742522315774; Thu, 20
 Mar 2025 18:58:35 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:58:06 -0700
In-Reply-To: <20250321015806.954866-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-9-pandoh@google.com>
Subject: [PATCH v5 8/8] PCI/AER: Add sysfs attributes for log ratelimits
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

Allow userspace to read/write log ratelimits per device (including
enable/disable). Create aer/ sysfs directory to store them and any
future aer configs.

Update AER sysfs ABI filename to reflect the broader scope of AER sysfs
attributes (e.g. stats and ratelimits).

Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats ->
Documentation/ABI/testing/sysfs-bus-pci-devices-aer

Tested using aer-inject[1]. Configured correctable log ratelimit to 5.
Sent 6 AER errors. Observed 5 errors logged while AER stats
(cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) shows 6.

Disabled ratelimiting and sent 6 more AER errors. Observed all 6 errors
logged and accounted in AER stats (12 total errors).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reported-by: Sargun Dhillon <sargun@meta.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
 ...es-aer_stats => sysfs-bus-pci-devices-aer} | 34 +++++++
 Documentation/PCI/pcieaer-howto.rst           |  5 +-
 drivers/pci/pci-sysfs.c                       |  1 +
 drivers/pci/pci.h                             |  1 +
 drivers/pci/pcie/aer.c                        | 93 +++++++++++++++++++
 5 files changed, 133 insertions(+), 1 deletion(-)
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
similarity index 77%
rename from Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
rename to Documentation/ABI/testing/sysfs-bus-pci-devices-aer
index d1f67bb81d5d..771204197b71 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
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
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_burst_cor_log
+Date:		March 2025
+KernelVersion:	6.15.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Ratelimit burst for correctable error logs. Writing a value
+		changes the number of errors (burst) allowed per interval
+		(5 second window) before ratelimiting. Reading gets the
+		current ratelimit burst.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_burst_uncor_log
+Date:		March 2025
+KernelVersion:	6.15.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Ratelimit burst for uncorrectable error logs. Writing a
+		value changes the number of errors (burst) allowed per
+		interval (5 second window) before ratelimiting. Reading
+		gets the current ratelimit burst.
diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 896d2a232a90..043cdb3194be 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -96,12 +96,15 @@ type (correctable vs. uncorrectable).
 AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
 DEFAULT_RATELIMIT_INTERVAL (5 seconds).
 
+Ratelimits are exposed in the form of sysfs attributes and configurable.
+See Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
+
 AER Statistics / Counters
 -------------------------
 
 When PCIe AER errors are captured, the counters / statistics are also exposed
 in the form of sysfs attributes which are documented at
-Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
 
 Developer Guide
 ===============
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
index f709290e9e00..a356640fdb3f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -891,6 +891,7 @@ void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
+extern const struct attribute_group aer_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e0f526960134..ee3c285c26a6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -627,6 +627,99 @@ const struct attribute_group aer_stats_attr_group = {
 	.is_visible = aer_stats_attrs_are_visible,
 };
 
+/*
+ * Ratelimit enable toggle
+ * 0: disabled with ratelimit.interval = 0
+ * 1: enabled with ratelimit.interval = nonzero
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
+
+	return count;
+}
+static DEVICE_ATTR_RW(ratelimit_log_enable);
+
+#define aer_ratelimit_burst_attr(name, ratelimit)			\
+	static ssize_t							\
+	name##_show(struct device *dev, struct device_attribute *attr,	\
+		    char *buf)						\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+									\
+	return sysfs_emit(buf, "%d\n",					\
+			  pdev->aer_report->ratelimit.burst);		\
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
+									\
+	return count;							\
+}									\
+static DEVICE_ATTR_RW(name)
+
+aer_ratelimit_burst_attr(ratelimit_burst_cor_log, cor_log_ratelimit);
+aer_ratelimit_burst_attr(ratelimit_burst_uncor_log, uncor_log_ratelimit);
+
+static struct attribute *aer_attrs[] = {
+	&dev_attr_ratelimit_log_enable.attr,
+	&dev_attr_ratelimit_burst_cor_log.attr,
+	&dev_attr_ratelimit_burst_uncor_log.attr,
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
+
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
2.49.0.395.g12beb8f557-goog


