Return-Path: <linux-pci+bounces-44028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6ECF404C
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 15:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9788309EE17
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648C332692A;
	Mon,  5 Jan 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM5Knto8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421F315764;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621366; cv=none; b=uQErM/e5T3MgpxlcuRt28Y3u+UM8w0X6FQgTXcvOX0QvmvIaZPIHZLz4DByadkgLMq0whFqnAh/mcqOuSMjB9RRLmM8qhhe83jJzywsva3/o/+iItTtwX2li1kV4/GQzRgYOY1jcIK6QdFXy9aA9KjT0wWreNlEjI/ksh5IQFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621366; c=relaxed/simple;
	bh=Ntgzo3Vph+kP0OsAhSnb+mpngFnLkvv+Qtv5ogIVlWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crW24vUSvE+YB7M8dgLKYkNuHRiNbUyMrPVRXOULjq1nifr/Tq40uARBtbG0ad6AeR/SpIec+J3TmT6jCfvOuJaKqaE0e0HmhPa24F59JwnFu+eGKzoSdERCW7hSAeTq8syHYavT1etbvs7KJ3oFwi4FKlMeZLxB0Qob4ML9JY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM5Knto8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71C32C19424;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621365;
	bh=Ntgzo3Vph+kP0OsAhSnb+mpngFnLkvv+Qtv5ogIVlWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RM5Knto83GnocxcisPWnvmvjIM1waWl1JG88LO3XfFmBcA5/aTF5bVh6OHkMjFCnU
	 b9OA+2/8S058GskKivpZ6JGkp7mXiaF41c5kq9jtpuMm80Vz7bycN8LQXIk3VrlfUU
	 xFdCIpcxKQITL+T6xjc1Q+Tf9xaROhdqtKURLNvSXDsbKGHSkmsJJBZTgKhCDnWfA+
	 xTtmfK9EAYhsnqg03C9zabTn/peZjtLpBnX1pBC2X2XFehA2vnkESYX2HEShScONQJ
	 /bw3TVN2SHn5xf+yRylGvDgDgnN5OdbKLEV0qN84g2ZvSTxAuw0hZ4MxudnZEh409B
	 0OEsPJHq08fng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6250BC79F9A;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 05 Jan 2026 19:25:42 +0530
Subject: [PATCH v4 2/8] PCI/pwrctrl: Add 'struct
 pci_pwrctrl::power_{on/off}' callbacks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pci-pwrctrl-rework-v4-2-6d41a7a49789@oss.qualcomm.com>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8818;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Y2lIq8uxsjGR+WtNehymfHn7dVjmFrK7/YgN9bRdcL8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpW8LyOIGStqYxyUDpWvFaoTJfWSrKT0poSKort
 6cXJrqjLLSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVvC8gAKCRBVnxHm/pHO
 9Wk3B/42I26fQhS89kqJwvNC17RtyhuK/o7KWfh/XCYKSO0kWxmWTvFq/6K0mgAsmcyn0/R4zjo
 jBdLOUZFKx4Ckcs0zQPGJrvOVPGe6arJK7SW+QqoRUz9wp9gFZqlxYV4KPjVfwlooJrqqvruYeV
 AoCci4nvjeCE4/FOYRIIVBP9E8Sg3twrK24+Z3+33+TuPhDf5UeWt0/pSpp5JjZaVjsoE8P5C4n
 ZCknW3Ohkn9BaEbBdkwIuPK0fz/jdvwdgeNbJAJmzvFlMjV+cGZJgOlobWDkrsnZ6HmQjqyDU20
 fRoXxMToJqGbcGyaNmNppN7BcWZqKuoloPf6cQR0TF7C4U1O
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 27 ++++++++++++++---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 22 ++++++++++----
 drivers/pci/pwrctrl/slot.c               | 50 +++++++++++++++++++++++---------
 include/linux/pci-pwrctrl.h              |  4 +++
 4 files changed, 79 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index 4e664e7b8dd2..7e7093cbff3c 100644
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
+static int pci_pwrctrl_pwrseq_power_off(struct pci_pwrctrl *ctx)
+{
+	struct pci_pwrctrl_pwrseq_data *data = container_of(ctx, struct pci_pwrctrl_pwrseq_data,
+							    ctx);
+
+	return pwrseq_power_off(data->pwrseq);
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
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 0a63add84d09..616d3caedb34 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -434,15 +434,22 @@ static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl_ctx *ctx, struct
 	return 0;
 }
 
-static void tc9563_pwrctrl_power_off(struct tc9563_pwrctrl_ctx *ctx)
+static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 {
+	struct tc9563_pwrctrl_ctx *ctx = container_of(pwrctrl,
+					struct tc9563_pwrctrl_ctx, pwrctrl);
+
 	gpiod_set_value(ctx->reset_gpio, 1);
 
 	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+
+	return 0;
 }
 
-static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
+static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 {
+	struct tc9563_pwrctrl_ctx *ctx = container_of(pwrctrl,
+					struct tc9563_pwrctrl_ctx, pwrctrl);
 	struct tc9563_pwrctrl_cfg *cfg;
 	int ret, i;
 
@@ -502,7 +509,7 @@ static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
 		return 0;
 
 power_off:
-	tc9563_pwrctrl_power_off(ctx);
+	tc9563_pwrctrl_power_off(&ctx->pwrctrl);
 	return ret;
 }
 
@@ -591,7 +598,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 			goto remove_i2c;
 	}
 
-	ret = tc9563_pwrctrl_bring_up(ctx);
+	ret = tc9563_pwrctrl_power_on(&ctx->pwrctrl);
 	if (ret)
 		goto remove_i2c;
 
@@ -601,6 +608,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 			goto power_off;
 	}
 
+	ctx->pwrctrl.power_on = tc9563_pwrctrl_power_on;
+	ctx->pwrctrl.power_off = tc9563_pwrctrl_power_off;
+
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &ctx->pwrctrl);
 	if (ret)
 		goto power_off;
@@ -610,7 +620,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	return 0;
 
 power_off:
-	tc9563_pwrctrl_power_off(ctx);
+	tc9563_pwrctrl_power_off(&ctx->pwrctrl);
 remove_i2c:
 	i2c_unregister_device(ctx->client);
 	put_device(&ctx->adapter->dev);
@@ -621,7 +631,7 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 {
 	struct tc9563_pwrctrl_ctx *ctx = platform_get_drvdata(pdev);
 
-	tc9563_pwrctrl_power_off(ctx);
+	tc9563_pwrctrl_power_off(&ctx->pwrctrl);
 	i2c_unregister_device(ctx->client);
 	put_device(&ctx->adapter->dev);
 }
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d8..9f91f04b4ae0 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -17,13 +17,38 @@ struct pci_pwrctrl_slot_data {
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
+static int pci_pwrctrl_slot_power_off(struct pci_pwrctrl *ctx)
+{
+	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
 
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
+	clk_disable_unprepare(slot->clk);
+
+	return 0;
+}
+
+static void devm_pci_pwrctrl_slot_release(void *data)
+{
+	struct pci_pwrctrl_slot_data *slot = data;
+
+	pci_pwrctrl_slot_power_off(&slot->ctx);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
 
@@ -31,7 +56,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 {
 	struct pci_pwrctrl_slot_data *slot;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
 	int ret;
 
 	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
@@ -46,23 +70,21 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
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
index 4aefc7901cd1..435b822c841e 100644
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
+	int (*power_off)(struct pci_pwrctrl *pwrctrl);
 
 	/* private: internal use only */
 	struct notifier_block nb;

-- 
2.48.1



