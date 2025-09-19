Return-Path: <linux-pci+bounces-36522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22794B8A9B9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDC17E1262
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C0531DDA4;
	Fri, 19 Sep 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgP6y6Ez"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7E2BE053;
	Fri, 19 Sep 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300051; cv=none; b=OdRc+5gf666JPCerIBjGHY6XfMnH+OGN15DPcqLi645eUEOB6YzIG7a34ZvPGo2cR+c33eSl194IwJMpdtsPmTirKAWYMTDn2FCqtjzzpKgNDdVHrBPuYt5i7r8Pov3TcWZXv0F6HlX9o2Km+cJRmeC8GRwNnTdifYSSJHERFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300051; c=relaxed/simple;
	bh=ND3X9NDiOIPWu7TWds7NdPiahkgN7R0iPqBW7LrkSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W99qaVPBjSNO31yhlg7W3ejivx0X6K/xk44P70clafbHsYY8ce8JPJG58YigiKkA7F87el+3AZX6l5XqCJJTJ31CrmazIQCYtkVMrrU8z/kpmnXdA9nbhA2RaAw95BK/O2J9k+XHIhV5rJtmMn5ej9qh4dx9yO/SY9XmoN7nPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgP6y6Ez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298FBC4CEF0;
	Fri, 19 Sep 2025 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300051;
	bh=ND3X9NDiOIPWu7TWds7NdPiahkgN7R0iPqBW7LrkSRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgP6y6EzqpdE8+SVBQvpUoWLhmbgFkKfZZ4oeUTgeGRAU7cNawGUF0C+lWuhPw7tO
	 xm/R4ITWKMlTYcUCalZqjtNgJabHo8TQlSzti70bqlaJQMpCzII2qXwZfpqEJo5Yh5
	 0jfcwG1U0cS9HH2n7K/kfcG25lefyDWcbpMzZs/ktCZft68/RaM/BptyYP4HjFzFc2
	 CvN2T021j0GtFKKrkC6ShnCWyEdv+cUIpPcoW+Vdilu0c5NozMQmQz+7G7zlZCsV7o
	 PwSidl7parKFqT4KA4pGCHSrBwb6AKzNC2aLffS9yol2/Qtq5zp/wLPpeT/AdrWKRZ
	 JWgto6lfUBX1Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v1 1/3] PM: runtime: Add auto-cleanup macros for
 pm_runtime_resume_and_get()
Date: Fri, 19 Sep 2025 18:35:51 +0200
Message-ID: <2390247.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5049058.31r3eYUQgx@rafael.j.wysocki>
References: <5049058.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is generally useful to be able to automatically drop a device's
runtime PM usage counter incremented by pm_runtime_resume_and_get() [1].

To that end, add two DEFINE_CLASS() macros allowing pm_runtime_put()
and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
those cases.

Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_runtime.h |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -533,6 +533,30 @@ static inline int pm_runtime_resume_and_
 }
 
 /**
+ * pm_runtime_resume_and_get_dev - Resume device and bump up its usage counter.
+ * @dev: Target device.
+ *
+ * Resume @dev synchronously and if that is successful, increment its runtime
+ * PM usage counter.
+ *
+ * Return:
+ * * 0 if the runtime PM usage counter of @dev has been incremented.
+ * * Negative error code otherwise.
+ */
+static inline struct device *pm_runtime_resume_and_get_dev(struct device *dev)
+{
+	int ret;
+
+	ret = __pm_runtime_resume(dev, RPM_GET_PUT);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+
+/**
  * pm_runtime_put - Drop device usage counter and queue up "idle check" if 0.
  * @dev: Target device.
  *
@@ -606,6 +630,25 @@ static inline int pm_runtime_put_autosus
 	return __pm_runtime_put_autosuspend(dev);
 }
 
+/*
+ * The way to use the classes defined below is to define a class variable and
+ * use it going forward for representing the target device until it goes out of
+ * the scope.  For example:
+ *
+ * CLASS(pm_runtime_resume_and_get, active_dev)(dev);
+ * if (IS_ERR(active_dev))
+ *         return PTR_ERR(active_dev);
+ *
+ * ... do something with active_dev (which is guaranteed to never suspend) ...
+ */
+DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
+	     pm_runtime_resume_and_get_dev(dev), struct device *dev)
+
+DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
+	     pm_runtime_resume_and_get_dev(dev), struct device *dev)
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.




