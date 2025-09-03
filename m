Return-Path: <linux-pci+bounces-35356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F70B415FA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545A65E812A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570E92DA767;
	Wed,  3 Sep 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hidk4h3w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8022D94AF;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883614; cv=none; b=oRZKEG/tl2O+OklJlhCu+vejD/OfiE/ZDyFjlGvRzyOpyDB2ZS6Cz7e1J8BUoELtiglHYJDeAz6hHw8QUhjn96YSe24K/tgo4XgUS3TIB0AWOeOiUKcmN5n4iRk3iSPjlyqmJR4B63JvnmK7Fs5LM4G12h0F2W4jxJNNhuuAXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883614; c=relaxed/simple;
	bh=w8gq1jN0KiRRbkHHXaDjSTc4CGx+3z84B6Oc0xZb3Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDQwthgw+1JGi7XjoEO7tZFLNGEyuFASlmyKWB/3GP3D/3rxNBcXCFMUYEFOFh04i+EeoLs3uBYY8aYtJRthHUFHjDiXOaGaBMEFamOS28DfduM4Nnt2LzPRZA2ll2XbOFOn5laOvLv/wnt0WdrgERwrpX3v+FiLK/N1RWDqzGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hidk4h3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A80F9C4CEFA;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756883613;
	bh=w8gq1jN0KiRRbkHHXaDjSTc4CGx+3z84B6Oc0xZb3Z4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Hidk4h3wUwL7NN0tIlgeZSF0+SQX3Z9CsduLUGnjHVz4NBf9suV3+mQIbAGH5CYbB
	 89f+YsYPgnaDyVzBkYL5eVrdm9cxU8EzaHs0222zMqAldJyjJfFdCjiLZCipbP/Q5s
	 LnkmGAP+lZmXDdItYUJDC2SNxmLTa0+NieAmvHGfPXOziesmdv1w2weJ82jBLdZ/Lc
	 XO3vTs77qnK0GQDyot26krUMXWkkOIlKg17UCTo9dCuVNhiYThmxiB0No5LEa1VQh5
	 yy2qJmRUJdca3C07yxcij/j0pPqtwZkT7/Z5m6NSpN3K1DJkGQ/LOeCZgw9wyPUwXI
	 i3G0+DRHUp7Aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9696DCA1012;
	Wed,  3 Sep 2025 07:13:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 03 Sep 2025 12:43:24 +0530
Subject: [PATCH v2 2/5] PCI/pwrctrl: Move pci_pwrctrl_init() before turning
 ON the supplies
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-pci-pwrctrl-perst-v2-2-2d461ed0e061@oss.qualcomm.com>
References: <20250903-pci-pwrctrl-perst-v2-0-2d461ed0e061@oss.qualcomm.com>
In-Reply-To: <20250903-pci-pwrctrl-perst-v2-0-2d461ed0e061@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBot+qbO/xAACNP9KEFSGn85ypDyLWrklnda6PLW
 A/JAA7/dF2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaLfqmwAKCRBVnxHm/pHO
 9a/oB/9cLJ/bC8+2232mXn53qeplk4yY1tuKr3ytZ4bABj//fCdG3P3vCCRDdcK1h/cEJTaTwFe
 WFo8qg4ztA2dZ44hYfAsMTuBxQevynq+o3D3aCZFFBgfNka4o79kUljSLOgw8PiBmgtaCIo5KQf
 PkpV0pWqoLid6lJyjGzEYLUCFi5XLwBNH8/Rjhxh7nO/i6Mt0XRPFGgBwSxY7PMftEg1EWmUBo6
 u3tHO73tWhyPNIn0ni6o4NW2pGXKfTl9z8a8gy5+ea4tGN4w9Jlrj0xRGI0weKG+FTvosjGtrPF
 fZ0uT7oIiuOiFd+9B5SYQuu7HpaRXLncvPkJDdAOj3YVrtjv
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



