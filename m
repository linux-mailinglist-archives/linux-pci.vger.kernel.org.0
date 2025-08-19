Return-Path: <linux-pci+bounces-34248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BC2B2BA66
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846687B1863
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D428489A;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYLek3Vk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAD26CE12;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587700; cv=none; b=e2QgZsVU9s0xwv6au4BoesNIJy0UgzE/WAO8Ty+N8Ca7O5Oxo7atazMhLbLKSnNKaYT/cz6yc/H+nXoaqdxXcDmvrJ78ndv27ItPGKbd6nZny1GK+s2xg6FnlKbPvS24kPgokUmP75t7Iu7jdXuwIsK7CWXWhFHZepH4xlPiOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587700; c=relaxed/simple;
	bh=w8gq1jN0KiRRbkHHXaDjSTc4CGx+3z84B6Oc0xZb3Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wx55lGwmdU20Fd6afLgPklX6BsKjqpfsgREj04+f3wbcfMN0/sJ/zIOyEKOMi32dEnLtrCOPoHzJCg/82kj1inWgV7WEooAD4BO2cb5gJPwveD1qSp0Jsc/xcf4Aj9uTAryOJYbqdNa6ZfLUJeuO6odREJgHqawLr3N4/ToObsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYLek3Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D02D1C4CEF4;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755587699;
	bh=w8gq1jN0KiRRbkHHXaDjSTc4CGx+3z84B6Oc0xZb3Z4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VYLek3Vk2rdCqp7d0jAFGMLTam9oq/giUaplgVJku+w/9uEazdmbopTR+wbzB/fT8
	 rNgVciqVXRO93tvs86mScsCyuJYw19opzatzrtgd4/UXwkhtjkB63ztqnM9XgECTlX
	 PveUSLDHglI/yEh5OCGPjxsSH8KsEy98EGwtLYm/KyxUEPxI3Vklpn97aZaefWYWe4
	 ZiYSY1y7KclqwOmH7eHbo7ub72FnZMN9In0OfeG6v6rTVIo/f6mDyFEMp+AIJcnFoa
	 EX+frPfQjvdtv9MlAISFB/OVCn9kg7nYbfIw0xxQECTHHTyzGPTfEhdt0J3qIpoHIj
	 aM5W51zUJin3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E01CA0EF5;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 19 Aug 2025 12:44:51 +0530
Subject: [PATCH 2/6] PCI/pwrctrl: Move pci_pwrctrl_init() before turning ON
 the supplies
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-pci-pwrctrl-perst-v1-2-4b74978d2007@oss.qualcomm.com>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
In-Reply-To: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=R+1x069ihDCZtvKq09JWHM41uYbGfvNk9pQz/Px8wHE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBopCRwWISsLEKBCJ//ZxObCZSQPRynr8EU/ahBG
 ZI3wrnYgNSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKQkcAAKCRBVnxHm/pHO
 9Uu/CACOo+9U0xKUKbd/DVRPzA8CPx7kVN2ETJZoSPycSzIiwn8AyUSaB/qvCNuC8VcXLm+eIik
 kDtSfeqY4a1C5kJCdFy2kfb+KbZwAEYjrTT6u1JZAndVIU6H/sPKT4dFiVDBu/aNfXq8YAdOynq
 F5RFG7R5KRCoBJeLuKdoZJ8gSHiqYD8QYP5ofRE4LGtE2lnvT19sZcA7XC9KsioDPlpYyD/znfF
 CwAqZ/OciBf7Ebq32/BnL+riknmV4xmE2emeC92GvU4QYbnwr/yhgjjeFgnKK41+iEhME6BEBwG
 VfBV0gwZ/wyJNsYo8zKMMTxy1tKMyjHuXW06fF688/ztq8Qg
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

To allow pwrctrl core to parse the generic resources such as PERST# GPIO
before turning on the supplies.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 4 ++--
 drivers/pci/pwrctrl/slot.c               | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index 4e664e7b8dd23f592c0392efbf6728fc5bf9093f..b65955adc7bd44030593e8c49d60db0f39b03d03 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -80,6 +80,8 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	pci_pwrctrl_init(&data->ctx, dev);
+
 	data->pwrseq = devm_pwrseq_get(dev, pdata->target);
 	if (IS_ERR(data->pwrseq))
 		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
@@ -95,8 +97,6 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pci_pwrctrl_init(&data->ctx, dev);
-
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
 	if (ret)
 		return dev_err_probe(dev, ret,
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 6e138310b45b9f7e930b6814e0a24f7111d25fee..b68406a6b027e4d9f853e86d4340e0ab267b6126 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -38,6 +38,8 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	if (!slot)
 		return -ENOMEM;
 
+	pci_pwrctrl_init(&slot->ctx, dev);
+
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
 					&slot->supplies);
 	if (ret < 0) {
@@ -63,8 +65,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 				     "Failed to enable slot clock\n");
 	}
 
-	pci_pwrctrl_init(&slot->ctx, dev);
-
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");

-- 
2.45.2



