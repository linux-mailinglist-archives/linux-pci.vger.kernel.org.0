Return-Path: <linux-pci+bounces-11650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30882950CEC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD35E286987
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E111A7045;
	Tue, 13 Aug 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KeIE104k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937691A4F39
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576295; cv=none; b=EAqldfEIoa7khoxX2aAywuED8J/3fp4R4h9b8p36o5S3NtR8y88d7oSZbm9kSLwUYFwyImigsiBtTk13PAcpIUARYKbDYd1IYTP7NwoMkHS5EMoopA7sLZ4Djl58hARckmdTFtT1zkChw4A7B/vkkPBv4iIJ8+QqI7RrRN8QLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576295; c=relaxed/simple;
	bh=VlEWS+I2qBUoAZu3MZiZFqikaq4uXZWuP6/ITJZxiQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3KK+PY68IOqJNAJBdE+/Fa3LiFCdt2ofVl03uU0fzCmTZp23GjhxUXNreav7gdhvmiXAGgMuyizESRFuOtQfi/DJj+BfeKG9xyL+WRBXkaILFsPfJQzMe7bSF7TVq0EFP/aiLXo7ugekrDrPADfHTLdu3xLH8JDkdg5PWNxpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KeIE104k; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so7791665e87.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576292; x=1724181092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns4EUZZ3nTL5odSKliuQhTwD1CbjvkOmQ7rToMzAA/s=;
        b=KeIE104k0MD+98/9MRSadoHuI4TX3AeyclfFDTXqkdImmNnlHfZAVSL8JMOn91GubK
         RDm2c/ByPZmHd8prc5zKYHWHJvYQLblC8iCufDP72C5PROmKAtKjPuhPXFQdaZgzDTdv
         Y1abW3L0VmzYeRkSC1IMwSgqacYTRBDo92PIUFw77Q8cShAFck3iueeL+h1gaguzLlLh
         mrUBEtlsNKi8XpR1XkNX2Y6qsi/cLN5MYoN72lKXrgCY1uD+AIVn5CZQQgYzG8OahJc4
         ql02f+3HFnL8UFYWNfF7xv8+3Att5y71chOZNxmPJ1vWmqCM5tI4CnIh7lR2UARm37jQ
         qbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576292; x=1724181092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns4EUZZ3nTL5odSKliuQhTwD1CbjvkOmQ7rToMzAA/s=;
        b=F9IGBmbk4hJyFpCILkLLUu69qpIix2s6Nhl0lS3augh/YWBiamPBw8EyH852hK+ntS
         i/F9OtY7rpaVAASQGAu0dqTDBnNqd8SzngMMQRm/JX/0C70nggIj+ngEwCWFOhcxFTmL
         hB0vocCKFxP80s88JlO9iGEQ63sEzWeQl2ftr+bA7lIpXmRP6Tcs/6EoJAnUm4P2u7q+
         xeT/IGmKN9cg7aPcLWShsgegU1CpR1AeslUCK8x42fzVYqK7260fk4NpCbKKXcXPPfIR
         9fiAgggLojI6a2BFzwqwqb8MSCCcm99KynQjF8G8R8Geu1i/UNgG3ehSmPZGSdx6f/iH
         UJLw==
X-Gm-Message-State: AOJu0YzyqK0AgjxiwP+q/GjHpd6X8rx9ia9kHMh9lM/UKMk6UObmlYvd
	APd8RLIos9qwo7C3Z/kM4yqSriKUgmHu2GmJLpjm0udNfKwTsnD2z5VMVJCeLZw=
X-Google-Smtp-Source: AGHT+IEaG5qL+48HD+ToLdhBsaWWHAg9Y7cW8RYNV07QZZNy1UgbvfAPhuohNo07mQICyOp3KP0bYw==
X-Received: by 2002:a05:6512:2347:b0:52c:e030:144e with SMTP id 2adb3069b0e04-532edbbc97fmr224018e87.47.1723576291477;
        Tue, 13 Aug 2024 12:11:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7734595sm147511405e9.36.2024.08.13.12.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:11:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 2/2] PCI/pwrctl: put the bus rescan on a different thread
Date: Tue, 13 Aug 2024 21:11:18 +0200
Message-ID: <20240813191119.155103-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813191119.155103-1-brgl@bgdev.pl>
References: <20240813191119.155103-1-brgl@bgdev.pl>
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


