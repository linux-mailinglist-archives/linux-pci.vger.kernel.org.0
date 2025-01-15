Return-Path: <linux-pci+bounces-19841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9B4A11B2F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2F3168C60
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9FA22F847;
	Wed, 15 Jan 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yb1Gf3gW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD222F84F
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927012; cv=none; b=mSM112YQ/9QI7HHRd3YsTSoSyBhG/Mh2fOU2knNkqYZ9RFeR1KDPFWcy+SGQbvE6PC0c8fUiqmFo3LQfQsg1JfzSwECGi+ThjLTsdM71HGl4yLpb0w5+3XLzQc482fXoGfE55qzCztcEVkg9iABTzxCSXl7cD1dXlx+9CY43rH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927012; c=relaxed/simple;
	bh=DnVlNVZntTNB75ypAXjHLmMddAEJeIDtG2Y6om/Gu2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jYRLMirjwtCQxpy2h2dQBD5pmF0xFSTHyYl9DtZxVKKRaXdSzk5CSO5MvjxJlvquds4ptAYLvpDMFJCpG6V2MPHbm35XXCg/+5bZ61H2XicvY+CWVjddqHKXk8FTmCf+/7gxKKr1WeY+KckmBfwNBP1/GbK/oFe4sD3wFAXDUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yb1Gf3gW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166e907b5eso122527585ad.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927010; x=1737531810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZAgiyHyFBPyDef19tcdRpdqCs2mXbDbvlAtOLxsTFI=;
        b=yb1Gf3gW3fC02Xfok4vUlf6AVotC4W/OB0/rC3ALdUTDIEd7jR1EorfFWuaQ0vDps2
         TCUcUfAPTdzhrpA7bt6hpKTPHheEUMbbxVfSNgwZZSIw3JyN+Csx5/6u72Fj9uxhLKud
         Y21+mVpXPGStZeYlBEaB4OYdx16TUjY2dyNoB/+5WnIDZPWy7G3OxEcof28z9zI+FjW5
         6LN/Zh60Ibvx9+u1LbKaD25xne1mbrUlS9s7ivFa2O+GCinBoZiUN7hAfHyCYSefCaD9
         OUBz21NZBPxC71lsbPpr2eN8TA+xivd5TiokVpWjjDR8Y3Pw/bDe5MXAGScm4p8FjeVx
         YDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927010; x=1737531810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZAgiyHyFBPyDef19tcdRpdqCs2mXbDbvlAtOLxsTFI=;
        b=K/UpzJUCj9R7vdgxxQZG1WW9MhMJKyZp+Y642CGU2paiGKcqhmTXw433iRr8cMQLLg
         rCQi21FOAL5U2VnrE40JU1W+gWGpjIJzw7fdNxoUE7+CsJj/6gTXTx0k3puEU8hqDYg4
         iOV7taTh5hD08B0JSYeNmBhqExWDfaLZ2rZa5FCN4YMQqVPk0vbDxhdjd32pSnNYBSU5
         iEasgxr68Vs4326SQwV/DxN4242KZ3o3izv7Xc1ko4Pkz9EBxt9+rnEDCQxQ1T4WWnxa
         HpWT94+Qry5JIYeVSiYTf/GLb+JpDSuPTfAQ8BpXjmZeFFwxKuCE7Wix4DSJgl45Clcn
         juiA==
X-Gm-Message-State: AOJu0Yxp2stHkJ2Ne4XNfAxPkl7al+C9ftZIuFUKY2VSttFKTrBsRyQw
	qdpSZCowj1Netvp7tLmG7o1zDDaiLaUCAwA0T18xBbE/r8pbKJPNBjL5pE/teKka8ki6WzeW7LB
	KIg==
X-Google-Smtp-Source: AGHT+IFG5rIz0GU4Z1fM2b75ItRedG9R3nHu5Xp3eIOsZFzh+MaNBsX1Z+w/bsXJOIs0jBcxKptSVXkredg=
X-Received: from pgox11.prod.google.com ([2002:a63:aa4b:0:b0:7fd:4497:f282])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a6:b0:1e6:5323:58d3
 with SMTP id adf61e73a8af0-1e88cfdc67amr44670780637.23.1736927010431; Tue, 14
 Jan 2025 23:43:30 -0800 (PST)
Date: Tue, 14 Jan 2025 23:42:58 -0800
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-7-pandoh@google.com>
Subject: [PATCH 6/8] PCI/AER: Add AER sysfs attributes for ratelimits
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow userspace to read/write ratelimits per device. Create aer/ sysfs
directory to store them and any future aer configs.

Tested using aer-inject[1] tool. Configured correctable log/irq ratelimits
to 5/10 respectively. Sent 12 AER errors. Observed 5 errors logged while
AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) shows 11
(1 masked).

Before: CEMsk: BadTLP-
After:  CEMsk: BadTLP+.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 .../testing/sysfs-bus-pci-devices-aer_stats   | 32 +++++++++++
 Documentation/PCI/pcieaer-howto.rst           |  4 +-
 drivers/pci/pci-sysfs.c                       |  1 +
 drivers/pci/pci.h                             |  1 +
 drivers/pci/pcie/aer.c                        | 56 +++++++++++++++++++
 5 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index d1f67bb81d5d..c680a53af0f4 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -117,3 +117,35 @@ Date:		July 2018
 KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_NONFATAL messages reported to rootport.
+
+PCIe AER ratelimits
+----------------------------
+
+These attributes show up under all the devices that are AER capable. Provides
+configurable ratelimits of logs/irq per error type. Writing a nonzero value
+changes the number of errors (burst) allowed per 5 second window before
+ratelimiting. Reading gets the current ratelimits.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_cor_irq
+Date:		Jan 2025
+KernelVersion:	6.14.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	IRQ ratelimit for correctable errors.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_uncor_irq
+Date:		Jan 2025
+KernelVersion:	6.14.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	IRQ ratelimit for uncorrectable errors.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_cor_log
+Date:		Jan 2025
+KernelVersion:	6.14.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Log ratelimit for correctable errors.
+
+What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_uncor_log
+Date:		Jan 2025
+KernelVersion:	6.14.0
+Contact:	linux-pci@vger.kernel.org, pandoh@google.com
+Description:	Log ratelimit for uncorrectable errors.
diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index d41272504b18..4d5b0638f120 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -89,7 +89,9 @@ AER Ratelimits
 -------------------------
 
 Errors, both at log and IRQ level, are ratelimited per device and error type.
-This prevents spammy devices from stalling execution.
+This prevents spammy devices from stalling execution. Ratelimits are exposed
+in the form of sysfs attributes and configurable. See
+Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 
 AER Statistics / Counters
 -------------------------
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7679d75d71e5..41acb6713e2d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1693,6 +1693,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 	&pcie_dev_attr_group,
 #ifdef CONFIG_PCIEAER
 	&aer_stats_attr_group,
+	&aer_attr_group,
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..9d0272a890ef 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -881,6 +881,7 @@ void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
+extern const struct attribute_group aer_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1db70ae87f52..e48e2951baae 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -630,6 +630,62 @@ const struct attribute_group aer_stats_attr_group = {
 	.is_visible = aer_stats_attrs_are_visible,
 };
 
+#define aer_ratelimit_attr(name, ratelimit)				\
+	static ssize_t							\
+	name##_show(struct device *dev, struct device_attribute *attr,	\
+		     char *buf)						\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	return sysfs_emit(buf, "%u errors every %u seconds\n",	\
+			  pdev->aer_info->ratelimit.burst,		\
+			  pdev->aer_info->ratelimit.interval / HZ);	\
+}									\
+									\
+	static ssize_t							\
+	name##_store(struct device *dev, struct device_attribute *attr,	\
+		     const char *buf, size_t count)				\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	int burst;							\
+									\
+	if (kstrtoint(buf, 0, &burst) < 0)				\
+		return -EINVAL;						\
+									\
+	pdev->aer_info->ratelimit.burst = burst;			\
+	return count;							\
+}									\
+static DEVICE_ATTR_RW(name)
+
+aer_ratelimit_attr(ratelimit_cor_irq, cor_irq_ratelimit);
+aer_ratelimit_attr(ratelimit_uncor_irq, uncor_irq_ratelimit);
+aer_ratelimit_attr(ratelimit_cor_log, cor_log_ratelimit);
+aer_ratelimit_attr(ratelimit_uncor_log, uncor_log_ratelimit);
+
+static struct attribute *aer_attrs[] __ro_after_init = {
+	&dev_attr_ratelimit_cor_irq.attr,
+	&dev_attr_ratelimit_uncor_irq.attr,
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
+	if (!pdev->aer_info)
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
 static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 				   struct aer_err_info *info)
 {
-- 
2.48.0.rc2.279.g1de40edade-goog


