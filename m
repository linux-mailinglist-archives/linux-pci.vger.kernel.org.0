Return-Path: <linux-pci+bounces-8646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C82904E02
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C21C24A03
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7C16D9C3;
	Wed, 12 Jun 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2DcswdaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84716D9DF
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180442; cv=none; b=MqJbBw4aXNXRCWyiO/AQmIn9dqGGr4AfLN9kWGlngNxTU9VJZtClvVe90Pel5ItRKcu2kNPUaPT+BuvOiJl9HXy9kLYJnstsIkgNa72gXb91GaR3tjaRqmVVX5tw08IATN3i5seBmevtNHvTcBjArYF/uULhS8duzd338vdpGr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180442; c=relaxed/simple;
	bh=5vtUivy1WsDU2PhTRIW8MACVGYRRPVmSCnZVpABDwUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2KqMLTTWvv9Jiatfv2CAVUAD4Ug1FLV+2E55hENWrknEraeIwYzo4Cu9KjsqD7sh5XtIISmBStWWFwzubeirO9vjuaUmlRLxqnDa+sAVI2lmHPdwopmMANgW/KvmowGoJFPaHVfEYgRGhrdsnbg2vAhu2NMN2U6PloVnayOfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2DcswdaS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so19886995e9.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718180439; x=1718785239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cFlU09skU5ebmY9aZrVFHQpziQipb3LWw7NexBUGMI=;
        b=2DcswdaSS6aZygc0pVThMlOZ9iOPckBFvB4vKU2FNRN/t1YpZ/WEbZOahc6aYhwqdA
         kIAEvAUVXKJYjAk030svcnbAHlPLQMRmd6Q6gBfO41nEzZfqSkgMqXPUc09xUSfSsYcY
         3RaqvhMcuLYqA7BcXSCh4JD4Yr/eKQiOkPZFZudqLYhebKC4Ihfgr5PN7jtKv7+l2l0v
         DocbMezNCrVx4uF4uYfNcyC+1qvbR/p13ytPm1iyy2p73nOZpKg6+t18Qm0zuZFVvX4v
         neRM5OqubD8vBmnVL1Ogo7q4QUrSubadDKw3C0/kVNiWMgQzJUnbu9JOGRppZm/u2Tou
         zJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180439; x=1718785239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cFlU09skU5ebmY9aZrVFHQpziQipb3LWw7NexBUGMI=;
        b=SofGWWt5/ogqupQ/JYqqqipJGCG16vaBskwHOA9qBa7HYT4pKoxuSPKfDXSqk2BKN6
         B3/2WVrN0IU2yf6tuG/sFj5rtVNQrMcUq3oQEdDpxpNeM4ivPTVyN6b1Ee+7c3d5ScC3
         Xyj4sn7iiOrdlfDCZty6cRs585PU3eMdybBKEbJVwB0302zXYcPipFmyEbWPMRLz/7Bj
         +olWEMFzfSUz8/2YIbtIHcMvkvFXnj+8/v0KG+iopFdOenZ1kCcPlnPTEkw3PszRJywF
         ocp5RVp2kgiCzVXhl/u2E83bwSxXoBj8UlHg5Nb/FjIPn0DshrJGso5H/lKcg2YPJShs
         Lzvw==
X-Forwarded-Encrypted: i=1; AJvYcCWbAVq5Wc5K+92L4hO0vC4jBdEaIfm2Mj2n/1aQlk7pkEVvsWaztnRCeof/rVmbxfpjIb5hv9pWpgx6m+6Emu9GItnnwF/P8NLo
X-Gm-Message-State: AOJu0Yx+5xWKMM9FqD4zCHw5cqZfZXIVpsEL0/KOcvZQqYbXNVM15tlJ
	Muu7gGcSbPlROAGOoFP4JNZMworiU3Oy1KSs/zyHrFrI6TwaDXFhOikQMe0Uae8=
X-Google-Smtp-Source: AGHT+IG8D07JiT1OikPRU9OM3y52o+XEz5z7NSHVHfr6c9/AiaBnLF01R6R5X1X6UseMtXKeogHU9g==
X-Received: by 2002:a05:600c:358b:b0:422:6765:2726 with SMTP id 5b1f17b1804b1-422865ad68fmr9616235e9.30.1718180439724;
        Wed, 12 Jun 2024 01:20:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229207d1a7sm6011775e9.1.2024.06.12.01.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:20:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v9 5/5] PCI/pwrctl: Add a PCI power control driver for power sequenced devices
Date: Wed, 12 Jun 2024 10:20:18 +0200
Message-ID: <20240612082019.19161-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612082019.19161-1-brgl@bgdev.pl>
References: <20240612082019.19161-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI power control driver that's capable of correctly powering up
devices using the power sequencing subsystem. The first users of this
driver are the ath11k module on QCA6390 and ath12k on WCN7850. These
packages require a certain delay between enabling the Bluetooth and WLAN
modules and the power sequencing subsystem takes care of it behind the
scenes.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/Kconfig             |  9 +++
 drivers/pci/pwrctl/Makefile            |  2 +
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 89 ++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index 96195395af69..f1b824955d4b 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -5,4 +5,13 @@ menu "PCI Power control drivers"
 config PCI_PWRCTL
 	tristate
 
+config PCI_PWRCTL_PWRSEQ
+	tristate "PCI Power Control driver using the Power Sequencing subsystem"
+	select POWER_SEQUENCING
+	select PCI_PWRCTL
+	default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)
+	help
+	  Enable support for the PCI power control driver for device
+	  drivers using the Power Sequencing subsystem.
+
 endmenu
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
index 52ae0640ef7b..d308aae4800c 100644
--- a/drivers/pci/pwrctl/Makefile
+++ b/drivers/pci/pwrctl/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
 pci-pwrctl-core-y			:= core.o
+
+obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
new file mode 100644
index 000000000000..c7a113a76c0c
--- /dev/null
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/platform_device.h>
+#include <linux/pwrseq/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct pci_pwrctl_pwrseq_data {
+	struct pci_pwrctl ctx;
+	struct pwrseq_desc *pwrseq;
+};
+
+static void devm_pci_pwrctl_pwrseq_power_off(void *data)
+{
+	struct pwrseq_desc *pwrseq = data;
+
+	pwrseq_power_off(pwrseq);
+}
+
+static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
+{
+	struct pci_pwrctl_pwrseq_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
+	if (IS_ERR(data->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
+				     "Failed to get the power sequencer\n");
+
+	ret = pwrseq_power_on(data->pwrseq);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to power-on the device\n");
+
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctl_pwrseq_power_off,
+				       data->pwrseq);
+	if (ret)
+		return ret;
+
+	data->ctx.dev = dev;
+
+	ret = devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register the pwrctl wrapper\n");
+
+	return 0;
+}
+
+static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
+	{
+		/* ATH11K in QCA6390 package. */
+		.compatible = "pci17cb,1101",
+		.data = "wlan",
+	},
+	{
+		/* ATH12K in WCN7850 package. */
+		.compatible = "pci17cb,1107",
+		.data = "wlan",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pci_pwrctl_pwrseq_of_match);
+
+static struct platform_driver pci_pwrctl_pwrseq_driver = {
+	.driver = {
+		.name = "pci-pwrctl-pwrseq",
+		.of_match_table = pci_pwrctl_pwrseq_of_match,
+	},
+	.probe = pci_pwrctl_pwrseq_probe,
+};
+module_platform_driver(pci_pwrctl_pwrseq_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("Generic PCI Power Control module for power sequenced devices");
+MODULE_LICENSE("GPL");
-- 
2.40.1


