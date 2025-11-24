Return-Path: <linux-pci+bounces-41957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88344C81867
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F99B3A2E6A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792B315D2D;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVskwYr5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781BF314A63;
	Mon, 24 Nov 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001264; cv=none; b=O8Km9uKkr0H+8n8zZ5Nspp/VoADxzwnlC2bTe0gZN9GirebhW6lrH1VuFguawDWNhct6lpExuYpYr1trrWRESjkOg1k8iiufQh1Rf+VTbnWfgnUzR0Rlkq0fJzlvgBLg89BkQNoUsLcWqYyvzAg9wkGH84idru6SegggDBRdG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001264; c=relaxed/simple;
	bh=hj0W70plhEe4m1xw3Pm9LugNFa+BQ7eFwiLsZvfg92o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiF2ueMNj40IZysS3MNrw46vbFTFLA5xOS6x8VDaXKcSxXkfAlPAhkloUFJpH2l779zmBKaVW7WytKOk2CnhOihM1k4JKKynQOc1j7JcyHGxYzMZTTXYxH86FVV9yHOjDhIntV2TgjsnkvNfsJQArVZTqIDsoEg8Y3VEh4np4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVskwYr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBF8CC19425;
	Mon, 24 Nov 2025 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764001264;
	bh=hj0W70plhEe4m1xw3Pm9LugNFa+BQ7eFwiLsZvfg92o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QVskwYr5gJ6iejEbV9hfZ664itEqtii0Y5UD1jxvRN08XCBs0tcV4lEL2o+kYSC1i
	 mtwAUMhGPO2E3Hm1Rru04IW8xwMc845pOqUKVf/ylDt3IOk23tWZY3bybj9RCIs+GO
	 0WmCJ2iN0b0TNPN2Edk4mFFlaVE0oLhJzO+OXLJtOyn/v23f44sRn1lYImxSFfbkLa
	 WwxAPrtNMURu0sRB0hkPctzfmJ8cluIHD+L/xZHJw41egWK2RzcMcLPjEXCA4lj9Vv
	 GiqBBAudilaSPuHuZYGrLUZOuYUJ8Xsvx3EGa69DmAu7Ob2o9LUMVC36aMgb4r1hbu
	 5GJLR4nbmQiWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C4BCFD31D;
	Mon, 24 Nov 2025 16:21:03 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 24 Nov 2025 21:50:45 +0530
Subject: [PATCH 2/5] PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}'
 callbacks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-pci-pwrctrl-rework-v1-2-78a72627683d@oss.qualcomm.com>
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6293;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=6deGnX1CPbvEiEx2HgwsKZt+v6TUHFgUyDrenVaupTY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJIXrGXndG74cMO1Hd7xDpblwiN6OUVi/XKe+s
 DK2u/TK/I6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSSF6wAKCRBVnxHm/pHO
 9S6kB/sG1Cn+iSU+3yUfjQEfdBWW32DohrGeCJdphfyNPqVL2BzBtXVt9kfS8yf1xC2FVo14irO
 19VlWJz4piCuxuUlHk1z/EtEnxdUJU6MckI4xRMtyOjoESTIO2V1nxSFuZxQj/d2BNkKC2d+s4q
 Zp1zBV3TBtv4gdx4M0TylqAl2sn/HZxMHULeGVKBl7Yazo6y/jVNVYlugr3gnUPqmWOAen6T8te
 EKrFKmvt7/hMgpzuUloWmnt6KPdxsN/srNw/M03qnSoK6UCKTof7C1IDs3siONISBm6+ZMHqQ7P
 EZPPRPOYzVp4DvPHCb8zG14y/TLbDjcfqL1u5ozQJKtohxkU
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

To allow the pwrctrl core to control the power on/off sequences of the
pwrctrl drivers, add the 'struct pci_pwrctrl::power_{on/off}' callbacks and
populate them in the respective pwrctrl drivers.

The pwrctrl drivers still power on the resources on their own now. So there
is no functional change.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 27 +++++++++++++++---
 drivers/pci/pwrctrl/slot.c               | 48 ++++++++++++++++++++++----------
 include/linux/pci-pwrctrl.h              |  4 +++
 3 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index 4e664e7b8dd2..0fb9038a1d18 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -52,11 +52,27 @@ static const struct pci_pwrctrl_pwrseq_pdata pci_pwrctrl_pwrseq_qcom_wcn_pdata =
 	.validate_device = pci_pwrctrl_pwrseq_qcm_wcn_validate_device,
 };
 
+static int pci_pwrctrl_pwrseq_power_on(struct pci_pwrctrl *ctx)
+{
+	struct pci_pwrctrl_pwrseq_data *data = container_of(ctx, struct pci_pwrctrl_pwrseq_data,
+							    ctx);
+
+	return pwrseq_power_on(data->pwrseq);
+}
+
+static void pci_pwrctrl_pwrseq_power_off(struct pci_pwrctrl *ctx)
+{
+	struct pci_pwrctrl_pwrseq_data *data = container_of(ctx, struct pci_pwrctrl_pwrseq_data,
+							    ctx);
+
+	pwrseq_power_off(data->pwrseq);
+}
+
 static void devm_pci_pwrctrl_pwrseq_power_off(void *data)
 {
-	struct pwrseq_desc *pwrseq = data;
+	struct pci_pwrctrl_pwrseq_data *pwrseq_data = data;
 
-	pwrseq_power_off(pwrseq);
+	pci_pwrctrl_pwrseq_power_off(&pwrseq_data->ctx);
 }
 
 static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
@@ -85,16 +101,19 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
 				     "Failed to get the power sequencer\n");
 
-	ret = pwrseq_power_on(data->pwrseq);
+	ret = pci_pwrctrl_pwrseq_power_on(&data->ctx);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to power-on the device\n");
 
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
-				       data->pwrseq);
+				       data);
 	if (ret)
 		return ret;
 
+	data->ctx.power_on = pci_pwrctrl_pwrseq_power_on;
+	data->ctx.power_off = pci_pwrctrl_pwrseq_power_off;
+
 	pci_pwrctrl_init(&data->ctx, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d8..14701f65f1f2 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -17,13 +17,36 @@ struct pci_pwrctrl_slot_data {
 	struct pci_pwrctrl ctx;
 	struct regulator_bulk_data *supplies;
 	int num_supplies;
+	struct clk *clk;
 };
 
-static void devm_pci_pwrctrl_slot_power_off(void *data)
+static int pci_pwrctrl_slot_power_on(struct pci_pwrctrl *ctx)
 {
-	struct pci_pwrctrl_slot_data *slot = data;
+	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
+	int ret;
+
+	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
+	if (ret < 0) {
+		dev_err(slot->ctx.dev, "Failed to enable slot regulators\n");
+		return ret;
+	}
+
+	return clk_prepare_enable(slot->clk);
+}
+
+static void pci_pwrctrl_slot_power_off(struct pci_pwrctrl *ctx)
+{
+	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
 
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
+	clk_disable_unprepare(slot->clk);
+}
+
+static void devm_pci_pwrctrl_slot_release(void *data)
+{
+	struct pci_pwrctrl_slot_data *slot = data;
+
+	pci_pwrctrl_slot_power_off(&slot->ctx);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
 
@@ -31,7 +54,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 {
 	struct pci_pwrctrl_slot_data *slot;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
 	int ret;
 
 	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
@@ -46,23 +68,21 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	}
 
 	slot->num_supplies = ret;
-	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
-		regulator_bulk_free(slot->num_supplies, slot->supplies);
-		return ret;
-	}
 
-	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_release,
 				       slot);
 	if (ret)
 		return ret;
 
-	clk = devm_clk_get_optional_enabled(dev, NULL);
-	if (IS_ERR(clk)) {
-		return dev_err_probe(dev, PTR_ERR(clk),
+	slot->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(slot->clk))
+		return dev_err_probe(dev, PTR_ERR(slot->clk),
 				     "Failed to enable slot clock\n");
-	}
+
+	pci_pwrctrl_slot_power_on(&slot->ctx);
+
+	slot->ctx.power_on = pci_pwrctrl_slot_power_on;
+	slot->ctx.power_off = pci_pwrctrl_slot_power_off;
 
 	pci_pwrctrl_init(&slot->ctx, dev);
 
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 4aefc7901cd1..bd0ee9998125 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -31,6 +31,8 @@ struct device_link;
 /**
  * struct pci_pwrctrl - PCI device power control context.
  * @dev: Address of the power controlling device.
+ * @power_on: Callback to power on the power controlling device.
+ * @power_off: Callback to power off the power controlling device.
  *
  * An object of this type must be allocated by the PCI power control device and
  * passed to the pwrctrl subsystem to trigger a bus rescan and setup a device
@@ -38,6 +40,8 @@ struct device_link;
  */
 struct pci_pwrctrl {
 	struct device *dev;
+	int (*power_on)(struct pci_pwrctrl *pwrctrl);
+	void (*power_off)(struct pci_pwrctrl *pwrctrl);
 
 	/* private: internal use only */
 	struct notifier_block nb;

-- 
2.48.1



