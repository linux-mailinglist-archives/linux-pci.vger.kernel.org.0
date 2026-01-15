Return-Path: <linux-pci+bounces-44898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99ED22D38
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 361103019875
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDD32AACF;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwXN/CzP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E23328B52;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=LeKHOl9toeUh7g1Nii0X+ZNKYG5yk3yLhowPeCIQwoBZos1mnxlF1qqUjFLJh2qSu/D3SGOlgOhmQB1ohuqb9x89i8swzR+MuRtVi+lH1Xmt2bwZ6k/wL6Dp2zVcGoOo+ZmSP8EUIgdlD2gCJgYKF+OKqz2wr3QFMtzN8vIB34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=3JYZjw/ZAh5w5G62kYD3nnn5B9uNp78oxSenKqU5H3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Coa+0DWyJnnJrEz6tzURJ7WwMQSyZ2lwuq9HjD3tInYdl7w/zmDWuQPTco7iDw6hElEP+jDDbgDhqhbu8zfnbWTSTzRKmjmxYCUiKwXbPnZnCyX6rZMik3On+0MyQcoXwMt0YyXBWPRp8R5A0Zymtdc+QeQUM6xs3svdOoolQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwXN/CzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC74C2BCB0;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=3JYZjw/ZAh5w5G62kYD3nnn5B9uNp78oxSenKqU5H3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CwXN/CzPtoOqKfdjXeL9dyAawTSfjKkKFeeivbn//swpQgx3cQfggWZa0Ut470ICl
	 szvSTq40FL4lImKPzf2ixEufuRIO80aqQLB+i2cW69II0mPXvikuAm+Z6SoziSq98q
	 MqurhPPGMd9cCXO30favP4xKWkcb14P6grjvGWLY8nrkV3r0n7iBaMEgL+/6RzCXWN
	 zS33msBP+8E3LR4QHoSP5ZpBIctM9ixrp49Xy6QTHc0MXk3otZRoyzjyS8oe2SgJzy
	 xetMnEn0lmiIF/PM1mvINyHxQFytoMv7to2xRRih+Opyg8QfnVn8gAtzWeheQOph+s
	 273xZrTDwIWSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F764D3CCB3;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:58:56 +0530
Subject: [PATCH v5 04/15] PCI/pwrctrl: tc9563: Clean up whitespace
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-4-9d26da3ce903@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7141;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=MpBEhzsl31WZThO8tK8CunXFQlrjrY0SrObfkwJWMJ0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdBJrWfAQB5XD1rr6eeGXI/27AgzGoXlVfDc
 fAAri5Xz/SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQQAKCRBVnxHm/pHO
 9UeAB/9oVWRB8kRxN0JLBf9vkp++KwdxOsg7Qd+zhaSPVksTRnIQ0/jzfL0RrwRIvHbydj38lxd
 Nr+WHzh7YtyjRGU/bTdQkKry3KNIwmY7AR6zVZ67rP+YRRoxGXx+m+drIPlE9Lc/exAzecRm9HE
 n6/7s4gf9ykryqkCjG04l0esBqBYcvj9k2ZyUT5wWdRiR2k4XE+ZSIEDDqa91xGBrFiYWJMFrFC
 atZ/SfwoVGQ8VUqrIUN7gnED1Pybzppfrke0FNXqeLjJ5uGLfPWzMPQ1aMb/RhBRzybPxUrscAg
 bwOIhMqWIcJt6RuMIOO7mebfLszuOSFrGUyzo/AXZqNDFFaq
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Bjorn Helgaas <bhelgaas@google.com>

Most of pci-pwrctrl-tc9563.c fits in 80 columns.  Wrap lines that are
gratuitously longer.  Whitespace changes only.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 65 +++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 0a63add84d09..efc4d2054bfd 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -59,7 +59,7 @@
 #define TC9563_POWER_CONTROL_OVREN	0x82b2c8
 
 #define TC9563_GPIO_MASK		0xfffffff3
-#define TC9563_GPIO_DEASSERT_BITS	0xc  /* Bits to clear for GPIO deassert */
+#define TC9563_GPIO_DEASSERT_BITS	0xc  /* Clear to deassert GPIO */
 
 #define TC9563_TX_MARGIN_MIN_UA		400000
 
@@ -69,7 +69,7 @@
  */
 #define TC9563_OSC_STAB_DELAY_US	(10 * USEC_PER_MSEC)
 
-#define TC9563_L0S_L1_DELAY_UNIT_NS	256  /* Each unit represents 256 nanoseconds */
+#define TC9563_L0S_L1_DELAY_UNIT_NS	256  /* Each unit represents 256 ns */
 
 struct tc9563_pwrctrl_reg_setting {
 	unsigned int offset;
@@ -217,7 +217,8 @@ static int tc9563_pwrctrl_i2c_read(struct i2c_client *client,
 }
 
 static int tc9563_pwrctrl_i2c_bulk_write(struct i2c_client *client,
-					 const struct tc9563_pwrctrl_reg_setting *seq, int len)
+				const struct tc9563_pwrctrl_reg_setting *seq,
+				int len)
 {
 	int ret, i;
 
@@ -252,12 +253,13 @@ static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl_ctx *ctx,
 	if (ret)
 		return ret;
 
-	return tc9563_pwrctrl_i2c_bulk_write(ctx->client,
-					    common_pwroff_seq, ARRAY_SIZE(common_pwroff_seq));
+	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, common_pwroff_seq,
+					     ARRAY_SIZE(common_pwroff_seq));
 }
 
 static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl_ctx *ctx,
-						 enum tc9563_pwrctrl_ports port, bool is_l1, u32 ns)
+						 enum tc9563_pwrctrl_ports port,
+						 bool is_l1, u32 ns)
 {
 	u32 rd_val, units;
 	int ret;
@@ -269,24 +271,32 @@ static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl_ctx *ctx,
 	units = ns / TC9563_L0S_L1_DELAY_UNIT_NS;
 
 	if (port == TC9563_ETHERNET) {
-		ret = tc9563_pwrctrl_i2c_read(ctx->client, TC9563_EMBEDDED_ETH_DELAY, &rd_val);
+		ret = tc9563_pwrctrl_i2c_read(ctx->client,
+					      TC9563_EMBEDDED_ETH_DELAY,
+					      &rd_val);
 		if (ret)
 			return ret;
 
 		if (is_l1)
-			rd_val = u32_replace_bits(rd_val, units, TC9563_ETH_L1_DELAY_MASK);
+			rd_val = u32_replace_bits(rd_val, units,
+						  TC9563_ETH_L1_DELAY_MASK);
 		else
-			rd_val = u32_replace_bits(rd_val, units, TC9563_ETH_L0S_DELAY_MASK);
+			rd_val = u32_replace_bits(rd_val, units,
+						  TC9563_ETH_L0S_DELAY_MASK);
 
-		return tc9563_pwrctrl_i2c_write(ctx->client, TC9563_EMBEDDED_ETH_DELAY, rd_val);
+		return tc9563_pwrctrl_i2c_write(ctx->client,
+						TC9563_EMBEDDED_ETH_DELAY,
+						rd_val);
 	}
 
-	ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT, BIT(port));
+	ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT,
+				       BIT(port));
 	if (ret)
 		return ret;
 
 	return tc9563_pwrctrl_i2c_write(ctx->client,
-				       is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY, units);
+			is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY,
+			units);
 }
 
 static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl_ctx *ctx,
@@ -321,7 +331,8 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl_ctx *ctx,
 		{TC9563_TX_MARGIN, amp},
 	};
 
-	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_SIZE(tx_amp_seq));
+	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, tx_amp_seq,
+					     ARRAY_SIZE(tx_amp_seq));
 }
 
 static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl_ctx *ctx,
@@ -364,8 +375,8 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl_ctx *ctx,
 		{TC9563_PHY_RATE_CHANGE_OVERRIDE, 0x0},
 	};
 
-	return tc9563_pwrctrl_i2c_bulk_write(ctx->client,
-					    disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
+	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, disable_dfe_seq,
+					     ARRAY_SIZE(disable_dfe_seq));
 }
 
 static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl_ctx *ctx,
@@ -381,18 +392,22 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl_ctx *ctx,
 	if (!nfts[0])
 		return 0;
 
-	ret =  tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT, BIT(port));
+	ret =  tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT,
+					BIT(port));
 	if (ret)
 		return ret;
 
-	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
+	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, nfts_seq,
+					     ARRAY_SIZE(nfts_seq));
 }
 
-static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl_ctx *ctx, bool deassert)
+static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl_ctx *ctx,
+						bool deassert)
 {
 	int ret, val;
 
-	ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_GPIO_CONFIG, TC9563_GPIO_MASK);
+	ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_GPIO_CONFIG,
+				       TC9563_GPIO_MASK);
 	if (ret)
 		return ret;
 
@@ -401,7 +416,8 @@ static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl_ctx *ctx,
 	return tc9563_pwrctrl_i2c_write(ctx->client, TC9563_RESET_GPIO, val);
 }
 
-static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl_ctx *ctx, struct device_node *node,
+static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl_ctx *ctx,
+					  struct device_node *node,
 					  enum tc9563_pwrctrl_ports port)
 {
 	struct tc9563_pwrctrl_cfg *cfg = &ctx->cfg[port];
@@ -540,7 +556,8 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	for (int i = 0; i < ARRAY_SIZE(tc9563_supply_names); i++)
 		ctx->supplies[i].supply = tc9563_supply_names[i];
 
-	ret = devm_regulator_bulk_get(dev, TC9563_PWRCTL_MAX_SUPPLY, ctx->supplies);
+	ret = devm_regulator_bulk_get(dev, TC9563_PWRCTL_MAX_SUPPLY,
+				      ctx->supplies);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to get supply regulator\n");
 		goto remove_i2c;
@@ -563,7 +580,8 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 
 	/*
 	 * Downstream ports are always children of the upstream port.
-	 * The first node represents DSP1, the second node represents DSP2, and so on.
+	 * The first node represents DSP1, the second node represents DSP2,
+	 * and so on.
 	 */
 	for_each_child_of_node_scoped(pdev->dev.of_node, child) {
 		port++;
@@ -574,7 +592,8 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 		if (port == TC9563_DSP3) {
 			for_each_child_of_node_scoped(child, child1) {
 				port++;
-				ret = tc9563_pwrctrl_parse_device_dt(ctx, child1, port);
+				ret = tc9563_pwrctrl_parse_device_dt(ctx,
+								child1, port);
 				if (ret)
 					break;
 			}

-- 
2.48.1



