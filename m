Return-Path: <linux-pci+bounces-13944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8F992802
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 11:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1285D1C2246D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03B018E365;
	Mon,  7 Oct 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zyKmT66y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FD18BBBD
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293096; cv=none; b=kep2iNBYdpj+uJqS3eQ15KB9nwguWB2TXosyoeNUzEg3tIvSE9njlWDFHBmqj0yoR93po1TuqvNQZoFSw7ttwnIugySEt2+Uux246pGIMHGTNQOqYuCi+AAEtvup8z8Fwq1pRqncTgW+hbprfMDJrY9WtoBWoAiN5TNGpAHZyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293096; c=relaxed/simple;
	bh=AvmMfwjUYGEhE+/+nT1wa6qD1E6h3pKbXaJ6n81G0e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRPFty1cmy8nTqEjIMO23plzJm7Hbd++UP1DeMrhMfcfdLl3+yaeq0YXp50zYn4QGaIBY2k+IiAqGQ8NWHZWL7oNhdxkeEnDI4eGftj/XQ2I6nvnytQT283otFl0xfinMMpphuznrLS93Czdkqwd9w6kBFng3PJgC7raaJdnDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zyKmT66y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so42182075e9.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2024 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728293091; x=1728897891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5NZ2mdUyRucLT/JATyvJkdNJOl2aRlHNwGrXPFp7mc=;
        b=zyKmT66yYPWYsjMMiiCFWYTMUzY1poAxKe8kEeine4J7JGL1Xlw9p7Dh5RqV8LsWB2
         IcGNNX4i4wRg87geszBPdgDSAFXyY9T2J/psn/rHsdTDYJX6OwVZUfRmEzN/4OjkhIY+
         yDEGtVjiv8cKLp+J0EyymovGH7YNqGUVz3ObLXrg4Wm4XenMZaasxSIH1vb8cySzgR4g
         GpUv0OnU9A5aHpifGQkFf7y3qDP/SrC9NLRDZ9FLc9coNfN236sX7U6drOIGa5/+Tw5F
         wEww8yjJqCVIz52V0uSg1VCufZKRFYxHPmmLKQVAkwSz7FCMpPXprJRmquw8F07OhmX9
         ZreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728293091; x=1728897891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5NZ2mdUyRucLT/JATyvJkdNJOl2aRlHNwGrXPFp7mc=;
        b=W6GPDS7AXngNE68xGuUT676B3IZF3/6VhzNosCUvj1U7IMV5FeI1eb1eFqVc56Hw+U
         633+JOU03VPoouLMH+lr2wRpwJFkndRUujyxzcBFNNmvGuCGIYYuZh53YLKzMIf2GFIO
         IqvLgqOitoZr69Tf25awT9Hxatvu517E6nGUPr/Sf4cuSGvIgUi7ohkXVcpsW1vaZ65O
         3rSgWm+vKppR0aliFIfn8UMIVTEGdv/A9XQuByaA+5mlu4M5B1MWZ0OcGNSS1akAO3Ra
         YzRzWr+dbx8ywBj3ifImffEB/m6yWb2j2ORvoMwRfV+hY7u3vM1zFyOwCJnWQWaWkB7a
         pm5A==
X-Gm-Message-State: AOJu0YyOYSxeQT3wAvKRMEYHjg3R1iP5xkp/QF8/v0UjMUOfmk/mmYUs
	QWTT/GmXDrfXCCxcZFTfDtZNh4xdjcNKmy1Y4U69cE4H2ZIOsosgdRVCa0Hzb5o=
X-Google-Smtp-Source: AGHT+IEUi4NDQb5SEliuoPQ4ndZko98fjaVQHki7BAjNOTcETYoLl6TpcKBdDMryjEhc2qPrNFEEtg==
X-Received: by 2002:a05:600c:350f:b0:42f:75e0:7829 with SMTP id 5b1f17b1804b1-42f85af0288mr82286475e9.30.1728293091160;
        Mon, 07 Oct 2024 02:24:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1698c188sm5246713f8f.112.2024.10.07.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 02:24:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] PCI/pwrctl: pwrseq: abandon QCom WCN probe on pre-pwrseq device-trees
Date: Mon,  7 Oct 2024 11:24:46 +0200
Message-ID: <20241007092447.18616-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Old device trees for some platforms already define wifi nodes for the WCN
family of chips since before power sequencing was added upstream.

These nodes don't consume the regulator outputs from the PMU and if we
allow this driver to bind to one of such "incomplete" nodes, we'll see
a kernel log error about the infinite probe deferral.

Let's extend the driver by adding a platform data struct matched against
the compatible. This struct will now contain the pwrseq target string as
well as a validation function called right after entering probe(). For
Qualcomm WCN models, we'll check the existence of the regulator supply
property that indicates the DT is already using power sequencing and
return -ENODEV if it's not there, indicating to the driver model that
the device should not be bound to the pwrctl driver.

Fixes: 6140d185a43d ("PCI/pwrctl: Add a PCI power control driver for power sequenced devices")
Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/all/Zv565olMDDGHyYVt@hovoldconsulting.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- make the fix more generic, add a platform data struct matched against
  the compatible and use it to store a device-specific validation
  callback

 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 55 +++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
index a23a4312574b..e331a73a1b0c 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -6,9 +6,9 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pci-pwrctl.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwrseq/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -18,6 +18,40 @@ struct pci_pwrctl_pwrseq_data {
 	struct pwrseq_desc *pwrseq;
 };
 
+struct pci_pwrctl_pwrseq_pdata {
+	const char *target;
+	/*
+	 * Called before doing anything else to perform device-specific
+	 * verification between requesting the power sequencing handle.
+	 */
+	int (*validate_device)(struct device *dev);
+};
+
+static int pci_pwrctl_pwrseq_qcm_wcn_validate_device(struct device *dev)
+{
+	/*
+	 * Old device trees for some platforms already define wifi nodes for
+	 * the WCN family of chips since before power sequencing was added
+	 * upstream.
+	 *
+	 * These nodes don't consume the regulator outputs from the PMU and
+	 * if we allow this driver to bind to one of such "incomplete" nodes,
+	 * we'll see a kernel log error about the indefinite probe deferral.
+	 *
+	 * Let's check the existence of the regulator supply that exists on all
+	 * WCN models before moving forward.
+	 */
+	if (!device_property_present(dev, "vddaon-supply"))
+		return -ENODEV;
+
+	return 0;
+}
+
+static const struct pci_pwrctl_pwrseq_pdata pci_pwrctl_pwrseq_qcom_wcn_pdata = {
+	.target = "wlan",
+	.validate_device = pci_pwrctl_pwrseq_qcm_wcn_validate_device,
+};
+
 static void devm_pci_pwrctl_pwrseq_power_off(void *data)
 {
 	struct pwrseq_desc *pwrseq = data;
@@ -27,15 +61,26 @@ static void devm_pci_pwrctl_pwrseq_power_off(void *data)
 
 static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
 {
+	const struct pci_pwrctl_pwrseq_pdata *pdata;
 	struct pci_pwrctl_pwrseq_data *data;
 	struct device *dev = &pdev->dev;
 	int ret;
 
+	pdata = device_get_match_data(dev);
+	if (!pdata || !pdata->target)
+		return -EINVAL;
+
+	if (pdata->validate_device) {
+		ret = pdata->validate_device(dev);
+		if (ret)
+			return ret;
+	}
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
+	data->pwrseq = devm_pwrseq_get(dev, pdata->target);
 	if (IS_ERR(data->pwrseq))
 		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
 				     "Failed to get the power sequencer\n");
@@ -64,17 +109,17 @@ static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
 	{
 		/* ATH11K in QCA6390 package. */
 		.compatible = "pci17cb,1101",
-		.data = "wlan",
+		.data = &pci_pwrctl_pwrseq_qcom_wcn_pdata,
 	},
 	{
 		/* ATH11K in WCN6855 package. */
 		.compatible = "pci17cb,1103",
-		.data = "wlan",
+		.data = &pci_pwrctl_pwrseq_qcom_wcn_pdata,
 	},
 	{
 		/* ATH12K in WCN7850 package. */
 		.compatible = "pci17cb,1107",
-		.data = "wlan",
+		.data = &pci_pwrctl_pwrseq_qcom_wcn_pdata,
 	},
 	{ }
 };
-- 
2.30.2


