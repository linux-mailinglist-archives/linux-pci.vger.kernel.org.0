Return-Path: <linux-pci+bounces-24206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E56A6A12E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA268461D6E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51414221702;
	Thu, 20 Mar 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2pzt+TqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903712147F2
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458887; cv=none; b=lLRZVIYTDsbUEoX9oTMU3G2hZb4Hbs2hQ/VMdDBcauJYQW+VdZPSxuRgYFPayiAasTeaY0q4c1WOPY+J2Aa2uXdkHTwSkIsysnSm6nINEQBnRvDD9JQGoO/rrCU1SUyUq87GSvAorYxR7sSuEdfHHm/+vZW4rf2D+zPuMH3QfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458887; c=relaxed/simple;
	bh=xdltEGRe17x2bp495kQj40chIiK971GRkExttHDR7Fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nXSFgEbOguTzm6cvhoIhR4MPYPu9rjx7RtUk94pE0KoAJd6SGVpyQWUtVumXiSv2x0eK2Jz2yuWxrqg/TTdB+6OHGnO3E+NhFveEi18siXovYpW3nruSW73NeOiSerDvLmL9jk1EZdXUbxgbsJrCvXjbS7hJM17Hy22Ei7p+5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2pzt+TqP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so788849a91.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742458885; x=1743063685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LU07lXbfAEByCHteAOwpMx7zwIFvsoURBPSsuNNzglk=;
        b=2pzt+TqPvDWSFb/32gofq+UY1VZWmhLcLS7+M9yMOIwOm70Mh1WNYwJaxi4jO77GYk
         bk8hEPqaap4vnomGYKdvEqsjuXCKKPqMN+unjwyO8z7dF6OOkMtDEWQM7mhR22m+D54s
         lOwrJRTZtafzCJsVB7G5/AXVuL33EewyGljuKbsxEVOdOxSdd6v77yYupPMUVQaOmi0V
         sGTr5kk6EHBbJ/mbvws3kAe8tIfdAO5aBz1irAes9FwtWQT0m6F6yF4KG1rR2gw7PdRB
         yDiOAziT70aZX70JcfItmlGC8fa85ACZe3OKIbc3/3H2NNDp8XsfRw1OXot8i8M8aIXD
         W3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458885; x=1743063685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LU07lXbfAEByCHteAOwpMx7zwIFvsoURBPSsuNNzglk=;
        b=i4akkmo0Y06BbQv/N+g+6TClnyMaw8fXFYw7R3rL2KdVhkBaxck1eDWbMktXUE6YSe
         hxSfBD4QVDbX8KSdGUlkBM03+NaPnKBBsKc1X09i9Y9gqQ8SubtNGvGcz/W1r7MD32xk
         xZgB0QxI8RMRszYlhYsx2d9V72oiWiGjxrRlaxS3clYXQZV6pp97/EQmyK+PuO3vtYVw
         YATY7yBLdJX+617cAyEpI4ET9WUkWw0TVxF7f2/ROqZ0CK6N+o/9OZuAHfV7CmqwROyh
         0yy9VQZnljzI+bkvAlz75j43Up34LXJRY/EXuH/qmX+JvPGRdRZWA0ako6CK7ZsCFny6
         c12Q==
X-Gm-Message-State: AOJu0YyJgTSESkypEuwS4Gu4w6n9HtN8MHA8MoiNlcg5RYeaPMalxDYA
	8sTdFNrKQsIB0sRuB6BJHAAlRg2r1ktkZS6/Er46i2+4dpCQOlz35HXPg1swyETrvb6zl3/BWJY
	xWw==
X-Google-Smtp-Source: AGHT+IHYKe4djvpr5f6Q3K6QRdFWl9uokY3qngraGVSiVq0wN8OWdSC/HDWEPnfn1H5NdELaT1oG3AI2rEU=
X-Received: from pjk7.prod.google.com ([2002:a17:90b:5587:b0:301:2679:9d9])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b44:b0:2ee:dd9b:e402
 with SMTP id 98e67ed59e1d1-301d50b08d6mr4044793a91.12.1742458884957; Thu, 20
 Mar 2025 01:21:24 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:20:57 -0700
In-Reply-To: <20250320082057.622983-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320082057.622983-8-pandoh@google.com>
Subject: [PATCH v4 7/7] PCI/AER: Add sysfs attributes for log ratelimits
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
index d1f67bb81d5d..4561653fdbde 100644
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
index 081cef5fc678..f84ae1872fa3 100644
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


