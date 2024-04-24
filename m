Return-Path: <linux-pci+bounces-6642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1838B0DD9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70771F232CF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49015FD01;
	Wed, 24 Apr 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlaffCXj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8B15FCEA;
	Wed, 24 Apr 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971841; cv=none; b=NQXCTv7Yqq+v8Gh9w4szjeG8ZKbz0k5WJieiKyWh72UMmt2oaVh713ow2D1jOw5SbUaisnPXXo+XlMBrOxavv4BfGCrWfmqcMP0YIhg29bKsruihfogwKqXy2bVFk3bicuIfv5vzrfv2Qc9lF02ZZK2zjvAFF8rPhcUkz1nsEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971841; c=relaxed/simple;
	bh=xz35v8bxYvqgegncoSCGyIO3ONqjFxudlkCESFdUVaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WooTNRA23A/XN5YALVOtJUEHHqIW7hMktpLL88tjjT+ZKZa0du4pWjwcVrBBUGWjD+A+DE/Qz3UgPYnkND/W3aAtlioP3Ffv7I98OYkVqfozfuK2tEXXdoIlAdWuXWvY4x1o++RaU81yuhJx6VV1BiJj84E7Zwql888LVsyS8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlaffCXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D715C32783;
	Wed, 24 Apr 2024 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971841;
	bh=xz35v8bxYvqgegncoSCGyIO3ONqjFxudlkCESFdUVaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hlaffCXjdjg1D20jPk717ey4uyxieVmJsgBJxQxhkCjgp6D0JG9kxQ8YnJ24INtZ1
	 /19ZhsPUaKmsTRbFswg0nFTn0O1XcALYH0RgR1hnK5l6OxMfnyKZY+D3Oeo9Ks/Q90
	 pSuknVlDe9VwbMq/9rUKQmxSuHzUEjYSEOPfRoswA7bCSclxFgdvb5znYETRcIc66T
	 SpmSkAQPqg5YveHyTGp77q/vq9SMXO0O4+5y1gXwf6WNFy+Kd3BLvGRWv20BtCC3dS
	 26d3HnsBahHR0/8it/G5VryZzzklYeM1zCwUW001rXnx5QS38oXAKq+uFsElgW/dUv
	 kVHlYX4AeA4dw==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:28 +0200
Subject: [PATCH 10/12] misc: pci_endpoint_test: Add support for rockchip
 rk3588
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-10-b1a02ddad650@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
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
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYJut8zPOOpuf+26xgFZ070SmxzO3nCstZvDsyOu/
 N3rGXP/dZSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAi1cKMDLtnJYZOPaXr/tK/
 J7DrFpvZrd/T1ghkrDpXVStT+izPZTEjwyKehrygO5s98paqaWkHOsh3vjLflpKqdS3SSpRnxhQ
 xXgA=
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


