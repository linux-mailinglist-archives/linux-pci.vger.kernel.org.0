Return-Path: <linux-pci+bounces-6882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA618B754D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DA21C22664
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DCF140E3D;
	Tue, 30 Apr 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc2VNkSu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0413D2A6;
	Tue, 30 Apr 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478568; cv=none; b=gFRH8p88sum2kcjNiNHMviEdTqDK+UNwPJE0dszOfWFhM9SsKcMpf8n2pSJGSOUrnylnU0wB6raVGmrt66c2jR2eq47Z+WDjSoafBWZhibGu8E8dcG5WveMfrXJZnZQ7eCiu2o5jYsSN/r975uZIooCiAqq3m7lpvpyjX3OzR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478568; c=relaxed/simple;
	bh=xz35v8bxYvqgegncoSCGyIO3ONqjFxudlkCESFdUVaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIBHrnDCewT0/1XbMC6WtyuDoTl4d0EbS2qehCQRc9+LFzLeDTQGRHCegk+pUJ0Y8TQmifYsIci5qo2uT6RuDAY8D3JDLxU3KM6K0cogMMNKUIJ7THKaGZ10CFDR7eiHXr1O5H9c1hhHJWB4Wf1p0Ufn8pa0appqyHfVzjgCsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc2VNkSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9F1C4AF18;
	Tue, 30 Apr 2024 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478567;
	bh=xz35v8bxYvqgegncoSCGyIO3ONqjFxudlkCESFdUVaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yc2VNkSuE7HFl+WPcKW2rKl6MknP7M5cKkRq10sOeLEMY2hLHek353uXhl6lVNlrX
	 RtktzsP3QWQlT/vEjkkQCmC7QBRItzxX81gB8fgV/hpzUukn8hphbYi1p0Z9H3cdky
	 a/85YK803ONUf5Ct51pEHuv6iLoYDkqV+/0UXHaIwwqNVlGmBeyyLk/WFDSDpEoEVw
	 X2gaKux4AzInTCDOu9ttgyhvK7tcRvRH5n5TWdAxMmwz5tjdq9aULGoOQikfi2GNy9
	 PNp5gDEW9U94e/XTZhmwZPqpD7bk78wCiLAVvYAcp+9wZts2248htW7mIMFevM/uQ9
	 twE/BG/o50FTw==
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 30 Apr 2024 14:01:09 +0200
Subject: [PATCH v2 12/14] misc: pci_endpoint_test: Add support for rockchip
 rk3588
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rockchip-pcie-ep-v1-v2-12-a0f5ee2a77b6@kernel.org>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=cassel@kernel.org;
 h=from:subject:message-id; bh=xz35v8bxYvqgegncoSCGyIO3ONqjFxudlkCESFdUVaA=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIM7m7YEHKXM1//Y8si07YXJfdu6LRc7MnX/RQa+u+17
 8WDL+f7dpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiWzIYGZocdtnpfFi01zZZ
 1Crk9711OzY/efb/akWoXVNY+vGtqiaMDGu/RDM6pQRGX7e6KBabV3Gwa29JkMitWdcPn9vyfH7
 ZZlYA
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
---
 drivers/misc/pci_endpoint_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c38a6083f0a7..a7f593b4e3b3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -84,6 +84,9 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
+#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
+#define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -980,6 +983,11 @@ static const struct pci_endpoint_test_data j721e_data = {
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
@@ -1017,6 +1025,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
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
2.44.0


