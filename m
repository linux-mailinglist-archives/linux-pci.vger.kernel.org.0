Return-Path: <linux-pci+bounces-44899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD8D22D1D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A69743023B63
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1C32B98E;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQhcgLeq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE7328B63;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=kG7g0NjkgHRzaOvpzXixbm9nf5p96hE3Oms7nRoA4QNr7e8/j1e0ubTMY/IMdmFvH7+MTmJ4e0dLtdyEcopU5VYqIwXho+b649XLKNMXBBULTpXivvoua6pzvB16o+OqzH07XDvn4iRDHeHEx1XPzjzY71YSzJuXuFubcNhsnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=p4sUg8EF8ZsKr22SYHzPeOH1mUOOZ4BQ4g2aYw6+X8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmMu/uNepPCeEvLdI/DvBRRs+QXXpQrudF8jEo55jBjI4tlRGxt7KVS7vCH+9zGCr84jDcmhP4B3Jm/sAGRFbHqzXFw7Zl3jSO1ujpVp77yYyM3yhAQbGeEKZJlpoZyKCXcxc+RLdxVf+ABpgYY42Jydp0zf4ZSmDCw4rfggcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQhcgLeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97660C2BCB7;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=p4sUg8EF8ZsKr22SYHzPeOH1mUOOZ4BQ4g2aYw6+X8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fQhcgLeq+y0srpiY/wbtarXT2qXqhJAavUHhBlZKPJhD1xIVwOh/DUVD6WKlNfWiM
	 7XjAf9QAw/G7ArC7vm+f76xYTxkqubkIZUh+MEzXug4DuszBcWBzqTV2yi/XrwPoxN
	 NO/7hdVTEsaQ9JD6detsExhEYX3hfpzYrucv+NTYaBBt2aRkZ9+CdAfpe1XvWv/Qn3
	 PsbUA/Vo9ymJfBq85vaDNoOSvD8m4aVX57usZPk4dT1bjPCVyJ0iwnMZxwvo6940mB
	 F6uQzGEOZFB/AtjKpBqSagY+Ck5zjePJIAAYpIA8WCH93p7qmJcs2bxXRE3fTED8cV
	 wCt1+rPlEnTIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6DBD3CCB8;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:58:57 +0530
Subject: [PATCH v5 05/15] PCI/pwrctrl: tc9563: Add local variables to
 reduce repetition
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-5-9d26da3ce903@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4095;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=eYaEHFlmQ+woaivP3WfGUoZ4cZZwo/rZUMqDu6RaHLk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdB82yOoj/O6aiEDK4yK0T98sYlbKcj9lMmP
 sZG4UqZ/lSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQQAKCRBVnxHm/pHO
 9WMZCACrA9g4kMXDkDVfTDfy2iinN4q+exISmFNT898VAOb307ybVwY0EtisyMSQxF6uDKjF/Zb
 ZVkTNRrmvjMz38PI5UFc9Qac7xYMca3iHjXRYAN4uBqrzcD9msShuzKk3jzFRxsITQ9islorbR7
 VLhLwn5h6Kk2tKPN8SJjQjGxmzjl+NUI2dX2jkxKaCNMibnquHVEeGlTzHxWrDLj2bqnDGJ/S7h
 1kGMeyp8PTra/7p4g/fIo8doGuR94vmsXHy05GyhUOd9enOcPULA+9L5AK8kZ6msU5OoVzsxRw5
 FWFvybnLWANcyLFfH/Rykodcv1HZg/JX9sqKYWc3EeC41bqK
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Bjorn Helgaas <bhelgaas@google.com>

Add local struct device * and struct device_node * variables to reduce
repetitive pointer chasing.  No functional changes intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index efc4d2054bfd..90480e35e968 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -459,12 +459,13 @@ static void tc9563_pwrctrl_power_off(struct tc9563_pwrctrl_ctx *ctx)
 
 static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
 {
+	struct device *dev = ctx->pwrctrl.dev;
 	struct tc9563_pwrctrl_cfg *cfg;
 	int ret, i;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 	if (ret < 0)
-		return dev_err_probe(ctx->pwrctrl.dev, ret, "cannot enable regulators\n");
+		return dev_err_probe(dev, ret, "cannot enable regulators\n");
 
 	gpiod_set_value(ctx->reset_gpio, 0);
 
@@ -478,37 +479,37 @@ static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
 		cfg = &ctx->cfg[i];
 		ret = tc9563_pwrctrl_disable_port(ctx, i);
 		if (ret) {
-			dev_err(ctx->pwrctrl.dev, "Disabling port failed\n");
+			dev_err(dev, "Disabling port failed\n");
 			goto power_off;
 		}
 
 		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
 		if (ret) {
-			dev_err(ctx->pwrctrl.dev, "Setting L0s entry delay failed\n");
+			dev_err(dev, "Setting L0s entry delay failed\n");
 			goto power_off;
 		}
 
 		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
 		if (ret) {
-			dev_err(ctx->pwrctrl.dev, "Setting L1 entry delay failed\n");
+			dev_err(dev, "Setting L1 entry delay failed\n");
 			goto power_off;
 		}
 
 		ret = tc9563_pwrctrl_set_tx_amplitude(ctx, i);
 		if (ret) {
-			dev_err(ctx->pwrctrl.dev, "Setting Tx amplitude failed\n");
+			dev_err(dev, "Setting Tx amplitude failed\n");
 			goto power_off;
 		}
 
 		ret = tc9563_pwrctrl_set_nfts(ctx, i);
 		if (ret) {
-			dev_err(ctx->pwrctrl.dev, "Setting N_FTS failed\n");
+			dev_err(dev, "Setting N_FTS failed\n");
 			goto power_off;
 		}
 
 		ret = tc9563_pwrctrl_disable_dfe(ctx, i);
 		if (ret) {
-			dev_err(ctx->pwrctrl.dev, "Disabling DFE failed\n");
+			dev_err(dev, "Disabling DFE failed\n");
 			goto power_off;
 		}
 	}
@@ -525,6 +526,7 @@ static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
 static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *bridge = to_pci_host_bridge(pdev->dev.parent);
+	struct device_node *node = pdev->dev.of_node;
 	struct pci_bus *bus = bridge->bus;
 	struct device *dev = &pdev->dev;
 	enum tc9563_pwrctrl_ports port;
@@ -536,7 +538,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
-	ret = of_property_read_u32_index(pdev->dev.of_node, "i2c-parent", 1, &addr);
+	ret = of_property_read_u32_index(node, "i2c-parent", 1, &addr);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to read i2c-parent property\n");
 
@@ -572,7 +574,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	pci_pwrctrl_init(&ctx->pwrctrl, dev);
 
 	port = TC9563_USP;
-	ret = tc9563_pwrctrl_parse_device_dt(ctx, pdev->dev.of_node, port);
+	ret = tc9563_pwrctrl_parse_device_dt(ctx, node, port);
 	if (ret) {
 		dev_err(dev, "failed to parse device tree properties: %d\n", ret);
 		goto remove_i2c;
@@ -583,7 +585,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	 * The first node represents DSP1, the second node represents DSP2,
 	 * and so on.
 	 */
-	for_each_child_of_node_scoped(pdev->dev.of_node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		port++;
 		ret = tc9563_pwrctrl_parse_device_dt(ctx, child, port);
 		if (ret)

-- 
2.48.1



