Return-Path: <linux-pci+bounces-44900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E5D22D23
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CE343024744
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7659C32B98C;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2EkOAP4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC13329C40;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=RgaTHFR5Jsog+jjLkQ1X3qHr4j7az5KcUiGFKh7MhAcpu5DskkoW4JDRIQyCXxQFlHkbuariGnqtZnW3uc8T1O29lC+ZBAhraQJwh+sjmXRbXEKMe25n0f8u3DcP4kOCCPR5OAV6imr1PqcZDbPJxLfqyWXhbzfTfyec2AkguO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=vxnLR+SkY1H4WOO/IJ+Ue4TlngmNzbRBt0/de2MBvzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBEFza4uAHzACxKkPH05XlZpQ1SfvWXC7unlC+xrlRAxchP2rPel2hK9YYikHNn9bbW/lgJVNF6mBHjzKG6MwLBw1zrAi1yRldFXgKfv72yoqHN6L895gA1asM4s02nve6ejZvo4OCYTcILTTqlIyFzBGxECpncHBvWh/8D8jRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2EkOAP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A524CC2BCF6;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=vxnLR+SkY1H4WOO/IJ+Ue4TlngmNzbRBt0/de2MBvzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T2EkOAP4C7R0qXb5nIPPxo5rYq6gEcq8RIQoy73FG4QOkSMfUzosyEPUjM6yDMhq6
	 CaQE//M41wwRItrcnXF+otX5doDrQPTGpgpE09O32CAC6qMq2RbsU8HOXwTt34Xn2N
	 UzpW7f1RdHzh7KAoiand0y0CAl4ylVMef4PAnODXG6qr+J+upJPUG/UgVfdqeYuLWP
	 Ee32PAZLX6QygYyRZYNZ9Fg78aCpTpINmT2dd1eATr+n6sZ9bKlJ+w1CwZfcUTZiPJ
	 Pv1gK/2jWVBbd2KueftWo4Opzfi/0OQ5zENRs4K9pQNcc9D8rHHeTI59kYhDpVkDaD
	 mGUlEow+61d0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98570D3CCBD;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:58:58 +0530
Subject: [PATCH v5 06/15] PCI/pwrctrl: tc9563: Rename private struct and
 pointers for consistency
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-6-9d26da3ce903@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15284;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=h+7FkkIQQuPbmNWHJA9UVX6QbxZYeXC89Z0sh7Nk1kI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdB89FXR9V2sL32AeWSoPkD3oL/V36f4fj5G
 JLem3otJ6GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQQAKCRBVnxHm/pHO
 9THzCACEbHAcqcwHnQ2xHj3AehWP6ifRhX946B45DSocuvo7NrNcbILQjbOPgT7TlGoNOQouwoF
 771jCdYdmvzUN8D9NVH95nRq4WAsBqJL8ib/sSRtPoKsfWau5Ae4b0+Ylb/oubCwOzKKQ3L3G3U
 Ia0CsUKROS55+2YVOKN4vtbMJFBWudUmcws69WPwL3wSxJrPxolizosk9002o5R8jLDeRWa01mc
 OPf24IiHv3OAUQviwqx0bvfLQcdv79LOKyKUsOTXR3qAJBsdww6coLvbHQ9qPIWq/uVxMm88M9i
 wVv6Fdz4mI0JZBs3bKAV/jp9wMBXq5ZDtue0m6klsAr8UlGv
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the pwrseq, tc9563, and slot pwrctrl drivers used different
naming conventions for their private data structs and pointers to them,
which makes patches hard to read:

  Previous names                         New names
  ------------------------------------   ----------------------------------
  struct pci_pwrctrl_pwrseq_data {       struct pci_pwrctrl_pwrseq {
    struct pci_pwrctrl ctx;                struct pci_pwrctrl pwrctrl;
  struct pci_pwrctrl_pwrseq_data *data   struct pci_pwrctrl_pwrseq *pwrseq

  struct tc9563_pwrctrl_ctx {            struct pci_pwrctrl_tc9563 {
  struct tc9563_pwrctrl_ctx *ctx         struct pci_pwrctrl_tc9563 *tc9563

  struct pci_pwrctrl_slot_data {         struct pci_pwrctrl_slot {
    struct pci_pwrctrl ctx;                struct pci_pwrctrl pwrctrl;
  struct pci_pwrctrl_slot_data *slot     struct pci_pwrctrl_slot *slot

Rename "struct tc9563_pwrctrl_ctx" to "pci_pwrctrl_tc9563".

Move the struct pci_pwrctrl member to be the first element in struct
pci_pwrctrl_tc9563, as it is in the other drivers.

Rename pointers from "struct tc9563_pwrctrl_ctx *ctx" to
"struct pci_pwrctrl_tc9563 *tc9563".

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 143 ++++++++++++++++---------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 90480e35e968..8ae27abdf362 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -105,13 +105,13 @@ static const char *const tc9563_supply_names[TC9563_PWRCTL_MAX_SUPPLY] = {
 	"vddio18",
 };
 
-struct tc9563_pwrctrl_ctx {
+struct pci_pwrctrl_tc9563 {
+	struct pci_pwrctrl pwrctrl;
 	struct regulator_bulk_data supplies[TC9563_PWRCTL_MAX_SUPPLY];
 	struct tc9563_pwrctrl_cfg cfg[TC9563_MAX];
 	struct gpio_desc *reset_gpio;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client;
-	struct pci_pwrctrl pwrctrl;
 };
 
 /*
@@ -231,10 +231,10 @@ static int tc9563_pwrctrl_i2c_bulk_write(struct i2c_client *client,
 	return 0;
 }
 
-static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl_ctx *ctx,
+static int tc9563_pwrctrl_disable_port(struct pci_pwrctrl_tc9563 *tc9563,
 				       enum tc9563_pwrctrl_ports port)
 {
-	struct tc9563_pwrctrl_cfg *cfg = &ctx->cfg[port];
+	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
 	const struct tc9563_pwrctrl_reg_setting *seq;
 	int ret, len;
 
@@ -249,15 +249,15 @@ static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl_ctx *ctx,
 		len = ARRAY_SIZE(dsp2_pwroff_seq);
 	}
 
-	ret = tc9563_pwrctrl_i2c_bulk_write(ctx->client, seq, len);
+	ret = tc9563_pwrctrl_i2c_bulk_write(tc9563->client, seq, len);
 	if (ret)
 		return ret;
 
-	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, common_pwroff_seq,
+	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, common_pwroff_seq,
 					     ARRAY_SIZE(common_pwroff_seq));
 }
 
-static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl_ctx *ctx,
+static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct pci_pwrctrl_tc9563 *tc9563,
 						 enum tc9563_pwrctrl_ports port,
 						 bool is_l1, u32 ns)
 {
@@ -271,7 +271,7 @@ static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl_ctx *ctx,
 	units = ns / TC9563_L0S_L1_DELAY_UNIT_NS;
 
 	if (port == TC9563_ETHERNET) {
-		ret = tc9563_pwrctrl_i2c_read(ctx->client,
+		ret = tc9563_pwrctrl_i2c_read(tc9563->client,
 					      TC9563_EMBEDDED_ETH_DELAY,
 					      &rd_val);
 		if (ret)
@@ -284,25 +284,25 @@ static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl_ctx *ctx,
 			rd_val = u32_replace_bits(rd_val, units,
 						  TC9563_ETH_L0S_DELAY_MASK);
 
-		return tc9563_pwrctrl_i2c_write(ctx->client,
+		return tc9563_pwrctrl_i2c_write(tc9563->client,
 						TC9563_EMBEDDED_ETH_DELAY,
 						rd_val);
 	}
 
-	ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT,
+	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
 				       BIT(port));
 	if (ret)
 		return ret;
 
-	return tc9563_pwrctrl_i2c_write(ctx->client,
+	return tc9563_pwrctrl_i2c_write(tc9563->client,
 			is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY,
 			units);
 }
 
-static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl_ctx *ctx,
+static int tc9563_pwrctrl_set_tx_amplitude(struct pci_pwrctrl_tc9563 *tc9563,
 					   enum tc9563_pwrctrl_ports port)
 {
-	u32 amp = ctx->cfg[port].tx_amp;
+	u32 amp = tc9563->cfg[port].tx_amp;
 	int port_access;
 
 	if (amp < TC9563_TX_MARGIN_MIN_UA)
@@ -331,14 +331,14 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl_ctx *ctx,
 		{TC9563_TX_MARGIN, amp},
 	};
 
-	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, tx_amp_seq,
+	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, tx_amp_seq,
 					     ARRAY_SIZE(tx_amp_seq));
 }
 
-static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl_ctx *ctx,
+static int tc9563_pwrctrl_disable_dfe(struct pci_pwrctrl_tc9563 *tc9563,
 				      enum tc9563_pwrctrl_ports port)
 {
-	struct tc9563_pwrctrl_cfg *cfg = &ctx->cfg[port];
+	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
 	int port_access, lane_access = 0x3;
 	u32 phy_rate = 0x21;
 
@@ -375,14 +375,14 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl_ctx *ctx,
 		{TC9563_PHY_RATE_CHANGE_OVERRIDE, 0x0},
 	};
 
-	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, disable_dfe_seq,
+	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, disable_dfe_seq,
 					     ARRAY_SIZE(disable_dfe_seq));
 }
 
-static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl_ctx *ctx,
+static int tc9563_pwrctrl_set_nfts(struct pci_pwrctrl_tc9563 *tc9563,
 				   enum tc9563_pwrctrl_ports port)
 {
-	u8 *nfts = ctx->cfg[port].nfts;
+	u8 *nfts = tc9563->cfg[port].nfts;
 	struct tc9563_pwrctrl_reg_setting nfts_seq[] = {
 		{TC9563_NFTS_2_5_GT, nfts[0]},
 		{TC9563_NFTS_5_GT, nfts[1]},
@@ -392,35 +392,35 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl_ctx *ctx,
 	if (!nfts[0])
 		return 0;
 
-	ret =  tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT,
+	ret =  tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
 					BIT(port));
 	if (ret)
 		return ret;
 
-	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, nfts_seq,
+	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, nfts_seq,
 					     ARRAY_SIZE(nfts_seq));
 }
 
-static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl_ctx *ctx,
+static int tc9563_pwrctrl_assert_deassert_reset(struct pci_pwrctrl_tc9563 *tc9563,
 						bool deassert)
 {
 	int ret, val;
 
-	ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_GPIO_CONFIG,
+	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_GPIO_CONFIG,
 				       TC9563_GPIO_MASK);
 	if (ret)
 		return ret;
 
 	val = deassert ? TC9563_GPIO_DEASSERT_BITS : 0;
 
-	return tc9563_pwrctrl_i2c_write(ctx->client, TC9563_RESET_GPIO, val);
+	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_RESET_GPIO, val);
 }
 
-static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl_ctx *ctx,
+static int tc9563_pwrctrl_parse_device_dt(struct pci_pwrctrl_tc9563 *tc9563,
 					  struct device_node *node,
 					  enum tc9563_pwrctrl_ports port)
 {
-	struct tc9563_pwrctrl_cfg *cfg = &ctx->cfg[port];
+	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
 	int ret;
 
 	/* Disable port if the status of the port is disabled. */
@@ -450,76 +450,77 @@ static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl_ctx *ctx,
 	return 0;
 }
 
-static void tc9563_pwrctrl_power_off(struct tc9563_pwrctrl_ctx *ctx)
+static void tc9563_pwrctrl_power_off(struct pci_pwrctrl_tc9563 *tc9563)
 {
-	gpiod_set_value(ctx->reset_gpio, 1);
+	gpiod_set_value(tc9563->reset_gpio, 1);
 
-	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	regulator_bulk_disable(ARRAY_SIZE(tc9563->supplies), tc9563->supplies);
 }
 
-static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
+static int tc9563_pwrctrl_bring_up(struct pci_pwrctrl_tc9563 *tc9563)
 {
-	struct device *dev = ctx->pwrctrl.dev;
+	struct device *dev = tc9563->pwrctrl.dev;
 	struct tc9563_pwrctrl_cfg *cfg;
 	int ret, i;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	ret = regulator_bulk_enable(ARRAY_SIZE(tc9563->supplies),
+				    tc9563->supplies);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "cannot enable regulators\n");
 
-	gpiod_set_value(ctx->reset_gpio, 0);
+	gpiod_set_value(tc9563->reset_gpio, 0);
 
 	fsleep(TC9563_OSC_STAB_DELAY_US);
 
-	ret = tc9563_pwrctrl_assert_deassert_reset(ctx, false);
+	ret = tc9563_pwrctrl_assert_deassert_reset(tc9563, false);
 	if (ret)
 		goto power_off;
 
 	for (i = 0; i < TC9563_MAX; i++) {
-		cfg = &ctx->cfg[i];
-		ret = tc9563_pwrctrl_disable_port(ctx, i);
+		cfg = &tc9563->cfg[i];
+		ret = tc9563_pwrctrl_disable_port(tc9563, i);
 		if (ret) {
 			dev_err(dev, "Disabling port failed\n");
 			goto power_off;
 		}
 
-		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
+		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(tc9563, i, false, cfg->l0s_delay);
 		if (ret) {
 			dev_err(dev, "Setting L0s entry delay failed\n");
 			goto power_off;
 		}
 
-		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
+		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(tc9563, i, true, cfg->l1_delay);
 		if (ret) {
 			dev_err(dev, "Setting L1 entry delay failed\n");
 			goto power_off;
 		}
 
-		ret = tc9563_pwrctrl_set_tx_amplitude(ctx, i);
+		ret = tc9563_pwrctrl_set_tx_amplitude(tc9563, i);
 		if (ret) {
 			dev_err(dev, "Setting Tx amplitude failed\n");
 			goto power_off;
 		}
 
-		ret = tc9563_pwrctrl_set_nfts(ctx, i);
+		ret = tc9563_pwrctrl_set_nfts(tc9563, i);
 		if (ret) {
 			dev_err(dev, "Setting N_FTS failed\n");
 			goto power_off;
 		}
 
-		ret = tc9563_pwrctrl_disable_dfe(ctx, i);
+		ret = tc9563_pwrctrl_disable_dfe(tc9563, i);
 		if (ret) {
 			dev_err(dev, "Disabling DFE failed\n");
 			goto power_off;
 		}
 	}
 
-	ret = tc9563_pwrctrl_assert_deassert_reset(ctx, true);
+	ret = tc9563_pwrctrl_assert_deassert_reset(tc9563, true);
 	if (!ret)
 		return 0;
 
 power_off:
-	tc9563_pwrctrl_power_off(ctx);
+	tc9563_pwrctrl_power_off(tc9563);
 	return ret;
 }
 
@@ -530,12 +531,12 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	struct pci_bus *bus = bridge->bus;
 	struct device *dev = &pdev->dev;
 	enum tc9563_pwrctrl_ports port;
-	struct tc9563_pwrctrl_ctx *ctx;
+	struct pci_pwrctrl_tc9563 *tc9563;
 	struct device_node *i2c_node;
 	int ret, addr;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
+	tc9563 = devm_kzalloc(dev, sizeof(*tc9563), GFP_KERNEL);
+	if (!tc9563)
 		return -ENOMEM;
 
 	ret = of_property_read_u32_index(node, "i2c-parent", 1, &addr);
@@ -543,38 +544,38 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to read i2c-parent property\n");
 
 	i2c_node = of_parse_phandle(dev->of_node, "i2c-parent", 0);
-	ctx->adapter = of_find_i2c_adapter_by_node(i2c_node);
+	tc9563->adapter = of_find_i2c_adapter_by_node(i2c_node);
 	of_node_put(i2c_node);
-	if (!ctx->adapter)
+	if (!tc9563->adapter)
 		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n");
 
-	ctx->client = i2c_new_dummy_device(ctx->adapter, addr);
-	if (IS_ERR(ctx->client)) {
+	tc9563->client = i2c_new_dummy_device(tc9563->adapter, addr);
+	if (IS_ERR(tc9563->client)) {
 		dev_err(dev, "Failed to create I2C client\n");
-		put_device(&ctx->adapter->dev);
-		return PTR_ERR(ctx->client);
+		put_device(&tc9563->adapter->dev);
+		return PTR_ERR(tc9563->client);
 	}
 
 	for (int i = 0; i < ARRAY_SIZE(tc9563_supply_names); i++)
-		ctx->supplies[i].supply = tc9563_supply_names[i];
+		tc9563->supplies[i].supply = tc9563_supply_names[i];
 
 	ret = devm_regulator_bulk_get(dev, TC9563_PWRCTL_MAX_SUPPLY,
-				      ctx->supplies);
+				      tc9563->supplies);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to get supply regulator\n");
 		goto remove_i2c;
 	}
 
-	ctx->reset_gpio = devm_gpiod_get(dev, "resx", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->reset_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "failed to get resx GPIO\n");
+	tc9563->reset_gpio = devm_gpiod_get(dev, "resx", GPIOD_OUT_HIGH);
+	if (IS_ERR(tc9563->reset_gpio)) {
+		ret = dev_err_probe(dev, PTR_ERR(tc9563->reset_gpio), "failed to get resx GPIO\n");
 		goto remove_i2c;
 	}
 
-	pci_pwrctrl_init(&ctx->pwrctrl, dev);
+	pci_pwrctrl_init(&tc9563->pwrctrl, dev);
 
 	port = TC9563_USP;
-	ret = tc9563_pwrctrl_parse_device_dt(ctx, node, port);
+	ret = tc9563_pwrctrl_parse_device_dt(tc9563, node, port);
 	if (ret) {
 		dev_err(dev, "failed to parse device tree properties: %d\n", ret);
 		goto remove_i2c;
@@ -587,14 +588,14 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	 */
 	for_each_child_of_node_scoped(node, child) {
 		port++;
-		ret = tc9563_pwrctrl_parse_device_dt(ctx, child, port);
+		ret = tc9563_pwrctrl_parse_device_dt(tc9563, child, port);
 		if (ret)
 			break;
 		/* Embedded ethernet device are under DSP3 */
 		if (port == TC9563_DSP3) {
 			for_each_child_of_node_scoped(child, child1) {
 				port++;
-				ret = tc9563_pwrctrl_parse_device_dt(ctx,
+				ret = tc9563_pwrctrl_parse_device_dt(tc9563,
 								child1, port);
 				if (ret)
 					break;
@@ -612,7 +613,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 			goto remove_i2c;
 	}
 
-	ret = tc9563_pwrctrl_bring_up(ctx);
+	ret = tc9563_pwrctrl_bring_up(tc9563);
 	if (ret)
 		goto remove_i2c;
 
@@ -622,29 +623,29 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 			goto power_off;
 	}
 
-	ret = devm_pci_pwrctrl_device_set_ready(dev, &ctx->pwrctrl);
+	ret = devm_pci_pwrctrl_device_set_ready(dev, &tc9563->pwrctrl);
 	if (ret)
 		goto power_off;
 
-	platform_set_drvdata(pdev, ctx);
+	platform_set_drvdata(pdev, tc9563);
 
 	return 0;
 
 power_off:
-	tc9563_pwrctrl_power_off(ctx);
+	tc9563_pwrctrl_power_off(tc9563);
 remove_i2c:
-	i2c_unregister_device(ctx->client);
-	put_device(&ctx->adapter->dev);
+	i2c_unregister_device(tc9563->client);
+	put_device(&tc9563->adapter->dev);
 	return ret;
 }
 
 static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 {
-	struct tc9563_pwrctrl_ctx *ctx = platform_get_drvdata(pdev);
+	struct pci_pwrctrl_tc9563 *tc9563 = platform_get_drvdata(pdev);
 
-	tc9563_pwrctrl_power_off(ctx);
-	i2c_unregister_device(ctx->client);
-	put_device(&ctx->adapter->dev);
+	tc9563_pwrctrl_power_off(tc9563);
+	i2c_unregister_device(tc9563->client);
+	put_device(&tc9563->adapter->dev);
 }
 
 static const struct of_device_id tc9563_pwrctrl_of_match[] = {

-- 
2.48.1



