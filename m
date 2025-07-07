Return-Path: <linux-pci+bounces-31632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58536AFBA84
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 20:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8F216C530
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266B264F96;
	Mon,  7 Jul 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqqGuki1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D021ABAA;
	Mon,  7 Jul 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912335; cv=none; b=py+BBCiovYWOkiF0tabSPRT9u3PAlwAGuk4+sE0lXoq4EN8RehSxRr7BiytHesz5aqOgyHCz0TZqeRdTN3YxSqjFGmI21mECPrZgkETbZHRqBy4/XchiAYxr7NM55KPSglzHRXJ64itZvpe9zP7lLGl0ZFZd125Kce2O/yaHVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912335; c=relaxed/simple;
	bh=5TKIYPnUQKbeAnvSQAVm79+gv2kW1++eF+Dk/A7iOcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMRHeixJzPP8jGl3tmSpGOzCLir9H6yGAKYdqcghs/lrwCdGY/ihJPNnereLy8pJe8CGfat4KORCO9d1hTK1Fxbske0rTCPELl0hHgxUNxCgkoQRRe9fo583NiA6l84Ne0pl6f1tJsiW/1YyJHpD8UI9z9Uwf/mHA39u87JX7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqqGuki1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE8AC4CEE3;
	Mon,  7 Jul 2025 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751912334;
	bh=5TKIYPnUQKbeAnvSQAVm79+gv2kW1++eF+Dk/A7iOcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jqqGuki1FzE4S8DwVB5HjBH3os1vxlzUoVwODhOVFDKhNsyhbQYbkOKOBY1cxDf4k
	 QM+kunvnTOLZLHlrLdn2W1Kw04sQE1Qd9VJnqznxhwDhyyfgKvlJjaht73UPqarkGL
	 mISCe+RMpvqyY13MMKx/GQPCCX24wvIXITw4lyHN0lcvnnVTC46B5wsMbjMewW+3wL
	 rrSd1lCjcvxZfEK7KVuafqUNrJaEJijFowMKtFeTjw8ZGygTsly8mc035gvDDMprJF
	 nGR3UaPaeSdk5u0rCliWFxpxKLhSienNE/RP9cfQC9kf13jDXtWEwYIwfQRPODC3im
	 e10v1v6gLO1Cw==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Mon, 07 Jul 2025 23:48:38 +0530
Subject: [PATCH RFC 1/3] PCI/pwrctrl: Move pci_pwrctrl_init() before
 turning ON the supplies
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-pci-pwrctrl-perst-v1-1-c3c7e513e312@kernel.org>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=mani@kernel.org;
 h=from:subject:message-id; bh=5TKIYPnUQKbeAnvSQAVm79+gv2kW1++eF+Dk/A7iOcA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBobA+F92C2H8qZ7ynDGaAqG/QekmUJ0w3hs/o4/
 OqCziRLkP2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaGwPhQAKCRBVnxHm/pHO
 9eh2CACak0Kl10CL3Y9i9EWGibwu/QEEB/gnZ0AJog7PtoCPJVoWmV1pxtd7KOqsLreVMiX2rND
 +NIA5sznCT6vPr3v1UkHUddvbJKQy6rPyJUvZXe4iZhpSBpEP6hWYd1iOFfJyyIjHZUfFg7mlCU
 JK1ax3midwgJUDOofm66JTUOE+Ua9r1t4FJIhIHaf1fE9/2VJOkEDz11uRDFavZNmUSQqYOW4BX
 sz0YqKFXlAVSeq4VYgJaqouO6xF+B4hwBLbnjnV0ZEmlXMQt4Kq6elpc83vkdS8Ll1curDy47wL
 IRdSKHVdmyF1fm4ntvlL/R3D2obktHL9BtEHnKduqLHPjh5b
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

To allow pwrctrl core to parse the generic resources such as PERST# GPIO
before turning on the supplies.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
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
index 18becc144913e04709783be43efe09c33ed2b502..97170c85d6f58f0812321716cb57e1fd8856572f 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -36,6 +36,8 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	if (!slot)
 		return -ENOMEM;
 
+	pci_pwrctrl_init(&slot->ctx, dev);
+
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
 					&slot->supplies);
 	if (ret < 0) {
@@ -55,8 +57,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_regulator_disable;
 
-	pci_pwrctrl_init(&slot->ctx, dev);
-
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");

-- 
2.45.2


