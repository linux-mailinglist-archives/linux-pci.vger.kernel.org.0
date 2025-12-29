Return-Path: <linux-pci+bounces-43812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39319CE7BD5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F374530169BD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9B330B16;
	Mon, 29 Dec 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlUFPEML"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19E27A107;
	Mon, 29 Dec 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029226; cv=none; b=gH3YbPzhTbReW8l26R1f2J8oyStGhEIjqmKYFogkSQAFXnTjwDMCCL+rmSEYxR2ynTpXu8cz6v4RCOJT25145979ivj1wzslElPt2JK2z/hLK4Cf25eYZ304aCrhrv4Slci33fz7XdmFJMa7696ouJo+Cdqf7T/TFGCFJr0G5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029226; c=relaxed/simple;
	bh=qTc5SaA61ig61zVNW7D9hWn6aBTF/l4gXSKl4hc/NQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDd2+r0QIzrh61R1Yi9hVtL2eAJfn4X2LJj2mIJ+bYh7TuQgOZ3WyK8Uert7UIYvV16oucsEOCq5eez7vtnsOEQKF86IyLyhrf6aAeqg+wTNFaYiuIl3/z6ex2ioBSqUfRqpQPJK1RDSd4X1J0dxSwTA0hfRkiMSg2RdJXXzoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlUFPEML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E36CC19423;
	Mon, 29 Dec 2025 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767029225;
	bh=qTc5SaA61ig61zVNW7D9hWn6aBTF/l4gXSKl4hc/NQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JlUFPEMLzZ3hOunB4Z00NwTj5v317h1eCOay870n//tZnG3SQRnpHbuhsVZpt5lIz
	 8JxS759MXAc9EqIWsEaUyRrG44R/e6FXeeIBYT5y3WFrwRxiwisQNKPREjwS6lAHie
	 dl/rj8jIiW2QAtk9z1TxpxrKh0DuGKo91IaGgvb+ncdGta4X8dDw+IeN+yIMLHeHHW
	 1etGXsGh2K8Jt0rYecY+I+ePz4lWW5Ad1lzXc3X4Id7xqAfRrwaLhPLfR5Zf5rKVr/
	 gZF297l3AfEY0lCwZ/mVWKwDCKlN4mB7TaCEAsMLtuVVmaywGTODiv4WFrtfOze6r4
	 9nvJNo3s3KEaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B506E92733;
	Mon, 29 Dec 2025 17:27:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 29 Dec 2025 22:56:52 +0530
Subject: [PATCH v3 1/7] PCI/pwrctrl: tc9563: Use put_device() instead of
 i2c_put_adapter()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-pci-pwrctrl-rework-v3-1-c7d5918cd0db@oss.qualcomm.com>
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=8t2SQeMKMKhDKWeUnGaK47mbYO4MIS6FUHdrtMxCfJY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUrnlpVI8Wey3qog7gIOmuF4I8KZkiamm+aBDW
 BztCf8ui8aJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVK55QAKCRBVnxHm/pHO
 9dYgB/0e4FpTYWfOGHu+fNjssaPt0KVbNbLGRbttlkDnUVrDoR7U0xXUFIkFATalU3TdOKcOwHX
 nBis7bJhHpwl7nLtR3pvN7J9zO7VMFfgRhsnBDXFrc/kmUYzoUGxAnjQYmzwM8bQ65CPzure6YF
 ygLEg5K+eFKqxfeQoKoAkEYwlyG3domxX5RQVUmdfsaFfk4n6inayhdhtctI3pRlPNoiOeLwnmN
 GEZvbMmfKX1cRSojXcRZl4mqlJ7Ml8IR3rmVfsMRH2bQuekzCWdHgdqi8+3JQk4KY8KYMVP/teP
 gQ4lAycGXTdWoUP79H97XIO7TJHIz5/4Qrj6q/RAQbi6Bs2e
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



