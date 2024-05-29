Return-Path: <linux-pci+bounces-8008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FE88D318D
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A204D1C23E6F
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330D16D306;
	Wed, 29 May 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOwVFbbe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31D16C451;
	Wed, 29 May 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971399; cv=none; b=c9dng8pq3kwalexeIz9srQtr8GxG8nFkwL3/MwwUgcKq9BNIa/ugH+Mv7xkwZvvnqDsDkpdxQOjxz74OyctuGcsiu0Qh6hjCfptadLzC+/SgUcFn034Br9vqRlFZUUOblQO67JQo2VKUku9NDpgJtigQfOBtVpOIR9694NmxvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971399; c=relaxed/simple;
	bh=RLD5Nn+8JjuWpy1BZvj15mTHLVP0CnrW2Huj0XxmdF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5X29/Qa7fL5TxKGxWUNINj1jFX3z8Y4JOPjokTo/Q+9USQ8Mdn1XAadKV7d6I2aMNx6MYvJuwo1wFMe2XPjIrrmCWjKiGJUlM1DVwW8J+rAl0CBQzDVyP7emrnhJ9lWC9c9Zf3ox764gDZGkXk9ICCEVqOV1minxhdo3RrO9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOwVFbbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA183C32781;
	Wed, 29 May 2024 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971399;
	bh=RLD5Nn+8JjuWpy1BZvj15mTHLVP0CnrW2Huj0XxmdF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pOwVFbbeGA2yhuzOQzBEs5rWojusiFmM6z5sC1QVRvrocGA7/kvhrcy3lHRPrHF5u
	 mel2+xeU3zzF6HWp967e/EeTxcyhZPSnwWv2F6ifp8SA7luneQV+LdccCAykmlqjxm
	 TmH8ApCQ81dchGVfMZYJ9WtwW4rEAucVNbopJpkRHJ1B2MsIuy1QQmI8LJFEJ5MKaS
	 3Wnng2VIMI/2HO2arZ3FMcbfbaUCQmUypnQTR57Xfw6zS6GataXxaqaSiZ/CKS2QYp
	 Ehc80hB+MXn3DdxPbiaX1ubaf/YVwp1pGebS5Xl+U0LoZVoEIumDxv8heP40Jscg7P
	 wEzox/S2VtWuA==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 29 May 2024 10:29:05 +0200
Subject: [PATCH v4 11/13] misc: pci_endpoint_test: Add support for rockchip
 rk3588
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-rockchip-pcie-ep-v1-v4-11-3dc00fe21a78@kernel.org>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=cassel@kernel.org;
 h=from:subject:message-id; bh=RLD5Nn+8JjuWpy1BZvj15mTHLVP0CnrW2Huj0XxmdF4=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLCnofmxn15sEJFrm1X1KlpVW49e49d6DUvPLFueW/Yf
 N35VnJ7OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRtkxGhlUV04K/dTpa+CX0
 Mlv7sHq9EM4WOsjS2uvbnb3LNS6wlpHhQOvs7Vc1td/HXXWz2n217lvZ1bq1B97MfTj7rETzESk
 lNgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Rockchip rk3588 requires 64k alignment.
While there is an existing device_id:vendor_id in the driver with 64k
alignment, that device_id:vendor_id is am654, which uses BAR2 instead of
BAR0 as the test_reg_bar, and also has special is_am654_pci_dev() checks
in the driver to disallow BAR0. In order to allow testing all BARs, add a
new rk3588 entry in the driver.

We intentionally do not add the vendor id to pci_ids.h, since the policy
for that file is that the vendor id has to be used by multiple drivers.

Hopefully, this new entry will be short-lived, as there is a series on the
mailing list which intends to move the address alignment restrictions from
this driver to the endpoint side.

Add a new entry for rk3588 in order to allow us to test all BARs.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/misc/pci_endpoint_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 4f3ec1f2ba9f..0ffc8e02b863 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -85,6 +85,9 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
+#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
+#define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -1006,6 +1009,11 @@ static const struct pci_endpoint_test_data j721e_data = {
 	.irq_type = IRQ_TYPE_MSI,
 };
 
+static const struct pci_endpoint_test_data rk3588_data = {
+	.alignment = SZ_64K,
+	.irq_type = IRQ_TYPE_MSI,
+};
+
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
 	  .driver_data = (kernel_ulong_t)&default_data,
@@ -1043,6 +1051,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721S2),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_ROCKCHIP, PCI_DEVICE_ID_ROCKCHIP_RK3588),
+	  .driver_data = (kernel_ulong_t)&rk3588_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);

-- 
2.45.1


