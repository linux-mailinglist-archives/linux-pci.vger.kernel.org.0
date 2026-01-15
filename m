Return-Path: <linux-pci+bounces-44894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA79D22CDE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3EF8300DB99
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE2328260;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMS1DprT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C83271E0;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462151; cv=none; b=VZdLeA6TtFpqICNM5akiRvdsnWNJxDHOJpwr5r1cgb0rAXFP24JdwNcPtVKDaEapUSEswpb3AsYkXgsQ4ycT+BXaAVZTnMy7ISgeQVWRK+BANT860QiDzeT7+3zwLld0T3/95REDV5iGlsvLhM4ygYPjeJZG32m/moMSBwnwhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462151; c=relaxed/simple;
	bh=w8kKfcICrrRimzqM8aAp2OtMgT2/yXrkaYvrlp46AME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKqSkppNPvys8YFKlA/1Hukz/SzgkbGMbgory2xsmPbocOjRKFDngyg5Q5ml+3a1mlMkxSKyu520UQJiXbxG9hskV2WDIbcri1azQC5yYB/LRoT1Uf/Ul8XzozrDaZzW8XZEtiLE3uU+QqXkRXLneIRDhCpzOv0PxQU9AI3rPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMS1DprT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E6C5C4AF09;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=w8kKfcICrrRimzqM8aAp2OtMgT2/yXrkaYvrlp46AME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XMS1DprT8VeJG40IQqpYfTCwtrgM2i+6TOZUoLVsSbVkyepdi28ISI2BCRNNYSbpA
	 bHUwYFgaDUQmYs3JSLQokVUzbgfKQCrkXvRRp1X34DreytQRTGGEx+2a4ujw9mhQHa
	 Z2jfCa5h+SQoBlgnXp1x0ehYB65bK6Ix5f7rsDufTwDeD9I42jgfalsfwHGF+9lAM2
	 ZO0HKcb2VTtxkyKbWquB5FvBbP5VE1vfbn81rO8BPNWPwDmMkrzWYKd5NI6S7uyQaz
	 ZFNOMYrotYpzXVNDOAMJrq8iokRYZpKEOohP2AjfBFLq0DJOoC1pUtIhYrTGqOnIF7
	 9S1McOjjQ/JBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717EFD3CCBB;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:58:55 +0530
Subject: [PATCH v5 03/15] PCI/pwrctrl: tc9563: Use put_device() instead of
 i2c_put_adapter()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-3-9d26da3ce903@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=IWMozgMnaMljrI9/K1oAYaHIcX8Y2LJhp+Wln908Neo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdBUla5R2xNUdzHYiNI94k/Alk5+0fVu8MGa
 f5sFEDQe1+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQQAKCRBVnxHm/pHO
 9c78B/9XenCvfN2XksYLtpgIozlIyaqCL8y6C52h0KO0i4kzreoDbtR7GzTMcayoDNzPEoiZOGX
 /x4TaPdM11PRmmbNfS8AJ1/Td62PEPDtIn9MhXpZXhOw9VExbNmsFsyj4y+P3pfh1ufbUYIcjBv
 z3rQ0bFpBbtzCpVAAfJcyzXJYLvdwfBakIQyiqNc8t3+QuTL7k/oCFyZsIMCvZ+yC2VqEp0au+O
 PSuiQ7lm22Vm/ecxyoctwmfMWNox6CIwA0Fx0SpiEnCNEo3jhatmcb9kQWrBDnBBRaAGpRNlRRN
 V9XZ1r5794h0oEJfikO4Iq5XzVRYBIO13llHqMawJooHpYKB
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The API comment for of_find_i2c_adapter_by_node() recommends using
put_device() to drop the reference count of I2C adapter instead of using
i2c_put_adapter(). So replace i2c_put_adapter() with put_device().

Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index ec423432ac65..0a63add84d09 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -533,7 +533,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	ctx->client = i2c_new_dummy_device(ctx->adapter, addr);
 	if (IS_ERR(ctx->client)) {
 		dev_err(dev, "Failed to create I2C client\n");
-		i2c_put_adapter(ctx->adapter);
+		put_device(&ctx->adapter->dev);
 		return PTR_ERR(ctx->client);
 	}
 
@@ -613,7 +613,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	tc9563_pwrctrl_power_off(ctx);
 remove_i2c:
 	i2c_unregister_device(ctx->client);
-	i2c_put_adapter(ctx->adapter);
+	put_device(&ctx->adapter->dev);
 	return ret;
 }
 
@@ -623,7 +623,7 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 
 	tc9563_pwrctrl_power_off(ctx);
 	i2c_unregister_device(ctx->client);
-	i2c_put_adapter(ctx->adapter);
+	put_device(&ctx->adapter->dev);
 }
 
 static const struct of_device_id tc9563_pwrctrl_of_match[] = {

-- 
2.48.1



