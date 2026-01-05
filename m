Return-Path: <linux-pci+bounces-44026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CCCF3F81
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 14:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 029263004844
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4553168F2;
	Mon,  5 Jan 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/VeN30q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197A2C11CA;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621366; cv=none; b=AHcX1Ds8j4l7hK0sPUj3AfFO3+aQX+WzV8ycIBRrVFmZFJynxMS+6B30kge9KDwwn4+MGy/jxBiQYWEC9mCEarwBdRatitCV+tkP6bd13EmOo78KwCGm8wFOlzjgvJ8caHlv0tUdBdGDB5XyKJMjRZkbYZj+fHFjwWFa+cl3OEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621366; c=relaxed/simple;
	bh=EV5QrWGkig2YkqQcwqpy9xrJBzO9BBKdu7LlEuXELtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Asbsul37pxOJJx5T3+K+PoTUNZUlUXoOuw00Tbqqoylt980zEM/LQJFtrPRX0a2O4+hdLvrsTd1OrBUX9g7nig7EklGdb//q4bdFf/YHEmgPucCZfbRUWWy5FTStpbj0p58xQISC0YbIluKjeNLGZwpA3ZuV1fu97KD47pf/tfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/VeN30q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66A4CC16AAE;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621365;
	bh=EV5QrWGkig2YkqQcwqpy9xrJBzO9BBKdu7LlEuXELtg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s/VeN30qvR31CzafjknnZFpce1Mn5J1nbjbEIktwxfoL4EueMs8wczWF+ILeZYrE0
	 NQhiT3EfmGgD1Ufw4Ncibk0iuhM1vGGU8F5ZBLBDpZbHvXLLfqQZ67tng8Fn5JfBjD
	 jkIDGKNJom7jPl96iySyvajBy/oen/El3G9KfrXIcZC8jdB7pyyoK/g730dxzSS4Ic
	 KMWq/PCfdmTGTGYPHXLquKYv/jYCT3knqI0KP+y1Ep5EG81Rw8mPymNC4XiwKiZZ5F
	 zhF1m4tgJKmY86Fo9SEScO0guDHgA+zMXJljWTe80sYOANS8aWjTHJgnksOBK8XAqr
	 Iz12cICBOq0KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540A5C79F90;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 05 Jan 2026 19:25:41 +0530
Subject: [PATCH v4 1/8] PCI/pwrctrl: tc9563: Use put_device() instead of
 i2c_put_adapter()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pci-pwrctrl-rework-v4-1-6d41a7a49789@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=uRiBY5lL1lc1Lvu1lsi1RLw6Jbau7l8e4J6XHZ91N/0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpW8LyrTB1/7xYHSK+ITndk1QFsfhU23hYFIvL7
 TBl9/IH+36JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVvC8gAKCRBVnxHm/pHO
 9SxbCACE8dPrXxT6b8mvBa1KwOqhv2aM1gSQjgA4iFsR2qhsm/9KNgzdFO1p2DzSd3pIU4INsMk
 gMQrUPnL6/O4ZwBlakP41dSbtG+Zja+aJuoH1o5mOvUhaZdiT0mGLZzC06WN1F1RPTLjnwtK8CW
 Y5M3/YoZ/dG/vCG+jTlOdOXkzMX74ogpnqkoIdxmSVHrY9TEAGBTz1ZojR1/gM4eLD34hRxiN3c
 sz6DI3o6ikjFEgqYM0NdElK1m3v2bdVJ6lrU2+UCuQK2y0P1T83A9kcbBNyi/tWIDvuMhBva1h2
 xk3Vs/n/dyeaaf3cVgPd9bkC7ra6CaKHvQi0HUbuJdUHTkR6
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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
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



