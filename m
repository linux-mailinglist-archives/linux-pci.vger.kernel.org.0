Return-Path: <linux-pci+bounces-44902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F2D22D47
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E14F301D500
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9A632B9AC;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byAYKz7d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977532A3EC;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=IgaHmImPFy8h5YqM3Pqy8T13MD5BTjASBHAyPP6q0hT01kbWBuAlQKWmLRneqGRBa9mGO2XSpwgYTmARvTNy9tbe4w2cDn1J028hKXgPfA9U7CwPR5Ug4K7/bXgYnifmdrVf3zZugTaZcJ86EgrxlNN79sY6Uw2vp1h9XgZ6wUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=SE57ZO376JEaiHrQbVaxGZM+k0OKXQjv5b4dTULQ9PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmQZO5ULIWveP9SDw2h3Ohitryzp22B7BtoekqHi7l5Xis++Ify4A/rrt5ooXAxCZ4op7ZdP3Znl9oR3Isoyf12gNTyNXbCc3hJAWqaIk5lfuwMPob0X3DAAdCfXH95KgY+K9d39EP9QXB/+PDkOZTDmTm3BLA8kGJMNtKnNj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byAYKz7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCDADC2BD04;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=SE57ZO376JEaiHrQbVaxGZM+k0OKXQjv5b4dTULQ9PA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=byAYKz7dFJ8jm/eAt5hmeDDm2qrfLq/5WnNL2iAr33n9SKmY5EFQQ5INPo5OPxdmx
	 z4DIjeZRrwatxBeClQmlp1qut4I/jcwD5G9Lt3l/CFrHeqd4JYq8ijDQmRSGq39b3+
	 hfilmccRByBfrVDIxjVLV0ANdcrS2ufhblXCvdpbzBpL18YHodNdG314p4ST76U3lW
	 GJBLrq6lZ2FZqv5r/2NVdSvTMg1XxuN5hKHg59A2TUEnk4lhELnso8yZsU9hpI3Q7U
	 wTZZbQsbOp5+Du6wyjh/xb77oLRpR7MNrKO8GO8A0wcZ50Jsvf4JEnd7mNJBa6WUjF
	 1tkde2LFpOD3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D58D3CCB8;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:59:00 +0530
Subject: [PATCH v5 08/15] PCI/pwrctrl: pwrseq: Factor out power on/off code
 to helpers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-8-9d26da3ce903@oss.qualcomm.com>
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=JHrbYm0MBMvXv/ITz+NZpdT3DemZUsxJlhMJ+bLoqgI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdCLg0hv0wiCQQY+RrdABbaInR/UH4Tr6q28
 Rz0i3rRUlGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQgAKCRBVnxHm/pHO
 9WZqCACp7B8c29oI68xxUbwuzdig4zsUerAKiA8nHS4Sss8isxZkq1Zwa3ciXn7YroEnovDGY+/
 WsVPO0oyACmZi8mM5BsU3ieMxX9aG2clktFWzaQxMDHRTxs4L7rlGOAErWta1LPlOdJ49XuJJ96
 5+E5iEnSjSX1l1axWfZPNDq+a9uRy6LeLc/rj7qeGAoMcb6CCyHfm0pb7Gqdyh33RzK6jtllZ59
 4IG+6HU/gVCk9ggO2LfDX6k8y5a26+bqxQXYOGWeFuzcMakn7rjDQ9T1C0otSNo1SmL0HjtfP12
 tiDPPOQxtL0iyof5EGTy5MpQygd0EUUL1S+3Wa2VEizBZG8D
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

In order to allow the pwrctrl core to control the power on/off logic of the
pwrctrl pwrseq driver, move the power on/off code to
pci_pwrctrl_pwrseq_power_{off/on} helper functions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index c0d22dc3a856..d2c261b09030 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -52,11 +52,27 @@ static const struct pci_pwrctrl_pwrseq_pdata pci_pwrctrl_pwrseq_qcom_wcn_pdata =
 	.validate_device = pci_pwrctrl_pwrseq_qcm_wcn_validate_device,
 };
 
+static int pci_pwrctrl_pwrseq_power_on(struct pci_pwrctrl *pwrctrl)
+{
+	struct pci_pwrctrl_pwrseq *pwrseq = container_of(pwrctrl,
+					    struct pci_pwrctrl_pwrseq, pwrctrl);
+
+	return pwrseq_power_on(pwrseq->pwrseq);
+}
+
+static int pci_pwrctrl_pwrseq_power_off(struct pci_pwrctrl *pwrctrl)
+{
+	struct pci_pwrctrl_pwrseq *pwrseq = container_of(pwrctrl,
+					    struct pci_pwrctrl_pwrseq, pwrctrl);
+
+	return pwrseq_power_off(pwrseq->pwrseq);
+}
+
 static void devm_pci_pwrctrl_pwrseq_power_off(void *data)
 {
-	struct pwrseq_desc *pwrseq = data;
+	struct pci_pwrctrl_pwrseq *pwrseq = data;
 
-	pwrseq_power_off(pwrseq);
+	pci_pwrctrl_pwrseq_power_off(&pwrseq->pwrctrl);
 }
 
 static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
@@ -85,13 +101,13 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pwrseq->pwrseq),
 				     "Failed to get the power sequencer\n");
 
-	ret = pwrseq_power_on(pwrseq->pwrseq);
+	ret = pci_pwrctrl_pwrseq_power_on(&pwrseq->pwrctrl);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to power-on the device\n");
 
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
-				       pwrseq->pwrseq);
+				       pwrseq);
 	if (ret)
 		return ret;
 

-- 
2.48.1



