Return-Path: <linux-pci+bounces-12079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478FD95C94D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 11:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB8B1F21A18
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B243157465;
	Fri, 23 Aug 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GProBBiS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458314B97B
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405618; cv=none; b=tUtRwO0V+7FuJESkYEBSdmTgPfORJQrd3OYA0JQugVpqwiZCu/tdWbzoZYtl+6Oop8ZNSzcualrXRnPMx2txtfO+uXEQhFslZmpG96nDUiROYELK/UINLpBP+Omgd4wMuvtJw/ejOylw94YPbXcaHb+3BrZOeoIdPPl+2w+y+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405618; c=relaxed/simple;
	bh=VlEWS+I2qBUoAZu3MZiZFqikaq4uXZWuP6/ITJZxiQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chZgT1Ntl9hGrbCvi3I7uhysNKpV3dfMAietzPyZXhu81NTA+CZ9f48K12olsQ4kcne3jVbzhT0oqD/llCKkO6Oe7AZ4pabY8iR/rT+TSDdK+DSvL+DNUSPyyfDZ0iQFiy8BdhZgoBqrzl7Q8J5H42DSEWwa2u620KVCmDQ8UEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GProBBiS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso17555255e9.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724405616; x=1725010416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns4EUZZ3nTL5odSKliuQhTwD1CbjvkOmQ7rToMzAA/s=;
        b=GProBBiSE10kSUudTPOUq83MZLnurR8SZLXlzMtQjWYn72Hd1C5o+Mh2ZhzBxYv6Oj
         xYhVMCxw8k4i8pZSc9UR7DH+gqgAzm4PoD5u9EMumGDFsVghYtxe6CzAuOWiBk54dXTu
         EC/GZ6XHOU/eQ32Oh+5NtVeVbmzdX2SMkSM2vGni1Zo+TvpiXpuuGB2NkcWUO8pN0J0U
         E8k0dYTuIKoz27Q1GOH3B3jpo7kb8kPCCmDRA+ZVz7L/hhQPZF6PVoruCRbAkNmIHRZT
         uY1szmYClOEf8D3+xXi3Aq+HNnn5rA+/gHKpR0tkP+aBfr4nQBZBLobu6Dxx1HEdd7rt
         Gy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405616; x=1725010416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns4EUZZ3nTL5odSKliuQhTwD1CbjvkOmQ7rToMzAA/s=;
        b=DD2p+u8x4RpnRb4wTdSJnMbSVRIVK2WAISMeUFVlst1yggu3eLmZLP1SxfkhrknTy1
         zsQxUlvuunoA+Dnxb7XghfTQKy7CHB0ngHbalyEA1Ph9WHweyw0WZ1ABqGeafAXKmUDJ
         KGrTcWagjItSSX2ljGbnLv73myluv9HmQJwm+Os13vTrkIDVZD76XGaLSFjlRTa5o/de
         dC4t58uSS4Tx/YOr+yf5b2cTY3KpYYl0kLW65c/bHMaCH+8dj2jtR7GvrFCuIdssuGHY
         G39A5PDSNIf1dom21AYw0znYYLEX0eH1HGa7pfT1pj2pqS3Bb+PoNKPGmpAXD164e7XQ
         3bkw==
X-Gm-Message-State: AOJu0Yzc+fnoYS4sq+3QtPfzhkHbj4o1C5wy0JMfxM3kfKcnAFmPzKK9
	Q5wVvMGyzvvHhZRGpZSalpSABevcYfCmPu8B6RayA2WHGlSnVvY4WBmTh2cquHh/W/eOH/RUrqL
	QLEI=
X-Google-Smtp-Source: AGHT+IFDN6ciVAxxG2thf6jNJ/OndV0vdP06G8DkZr6xUCbixfP6dzAPR8cgPbEm9FRU4nH0OyFf6g==
X-Received: by 2002:a05:600c:35cd:b0:428:15b0:c8dd with SMTP id 5b1f17b1804b1-42acd57c113mr12461705e9.20.1724405615130;
        Fri, 23 Aug 2024 02:33:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58fc:2464:50b0:90c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86d5esm87612035e9.15.2024.08.23.02.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:33:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v3 2/2] PCI/pwrctl: put the bus rescan on a different thread
Date: Fri, 23 Aug 2024 11:33:23 +0200
Message-ID: <20240823093323.33450-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823093323.33450-1-brgl@bgdev.pl>
References: <20240823093323.33450-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If we trigger the bus rescan from sysfs, we'll try to lock the PCI
rescan mutex recursively and deadlock - the platform device will be
populated and probed on the same thread that handles the sysfs write.

Add a workqueue to the pwrctl code on which we schedule the rescan for
controlled PCI devices. While at it: add a new interface for
initializing the pwrctl context where we'd now assign the parent device
address and initialize the workqueue.

Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
 include/linux/pci-pwrctl.h             |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
index feca26ad2f6a..01d913b60316 100644
--- a/drivers/pci/pwrctl/core.c
+++ b/drivers/pci/pwrctl/core.c
@@ -48,6 +48,28 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_DONE;
 }
 
+static void rescan_work_func(struct work_struct *work)
+{
+	struct pci_pwrctl *pwrctl = container_of(work, struct pci_pwrctl, work);
+
+	pci_lock_rescan_remove();
+	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
+	pci_unlock_rescan_remove();
+}
+
+/**
+ * pci_pwrctl_init() - Initialize the PCI power control context struct
+ *
+ * @pwrctl: PCI power control data
+ * @dev: Parent device
+ */
+void pci_pwrctl_init(struct pci_pwrctl *pwrctl, struct device *dev)
+{
+	pwrctl->dev = dev;
+	INIT_WORK(&pwrctl->work, rescan_work_func);
+}
+EXPORT_SYMBOL_GPL(pci_pwrctl_init);
+
 /**
  * pci_pwrctl_device_set_ready() - Notify the pwrctl subsystem that the PCI
  * device is powered-up and ready to be detected.
@@ -74,9 +96,7 @@ int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
 	if (ret)
 		return ret;
 
-	pci_lock_rescan_remove();
-	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
-	pci_unlock_rescan_remove();
+	schedule_work(&pwrctl->work);
 
 	return 0;
 }
diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
index c7a113a76c0c..f07758c9edad 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -50,7 +50,7 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->ctx.dev = dev;
+	pci_pwrctl_init(&data->ctx, dev);
 
 	ret = devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
 	if (ret)
diff --git a/include/linux/pci-pwrctl.h b/include/linux/pci-pwrctl.h
index 45e9cfe740e4..0d23dddf59ec 100644
--- a/include/linux/pci-pwrctl.h
+++ b/include/linux/pci-pwrctl.h
@@ -7,6 +7,7 @@
 #define __PCI_PWRCTL_H__
 
 #include <linux/notifier.h>
+#include <linux/workqueue.h>
 
 struct device;
 struct device_link;
@@ -41,8 +42,10 @@ struct pci_pwrctl {
 	/* Private: don't use. */
 	struct notifier_block nb;
 	struct device_link *link;
+	struct work_struct work;
 };
 
+void pci_pwrctl_init(struct pci_pwrctl *pwrctl, struct device *dev);
 int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl);
 void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl);
 int devm_pci_pwrctl_device_set_ready(struct device *dev,
-- 
2.43.0


