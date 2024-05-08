Return-Path: <linux-pci+bounces-7237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE28BFE4A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF1C2840DA
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4082E82C63;
	Wed,  8 May 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE8G/vSj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FE6FE2A;
	Wed,  8 May 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174067; cv=none; b=SnVZUqtL5woS6xdHbHV81yaobCmseaudxzbsHfVqU/ZcyaaFiV6WBcVckCI/vlkQYGcckI1vCMnKXKEp+N29+j/TwRH0/9pzUTgDOfsDjc0Mt3PkI3++Cg8fhSG/UluXMo+Gry492FBFzkSJB5A+1AUHgp4lQDGqOKW1zpZf4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174067; c=relaxed/simple;
	bh=C4BXtDtnPo3XQ7NV1y/rceBvVT8N7ly3fImlpXG2wtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMk62vvBMSlpr9TYqWxvxGbD9SNbuTUmNa+W6646l1R+5oQB/+LA/ac6KjNcfDSqgoBbpCVSvf3So40dpnbrhdWrNPy9lRjGASuZS9HqQ2bpYaoDnSNC7Vs9i6gKxc/fzDaTh0D/hUPShsbHYcQafBe64GOmAHDclJxiO7P/xHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE8G/vSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2073C4AF17;
	Wed,  8 May 2024 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174066;
	bh=C4BXtDtnPo3XQ7NV1y/rceBvVT8N7ly3fImlpXG2wtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JE8G/vSj4VJEpp4n0d/Z7Cq8kp35Ap2uimu1wOTNgIUeTWuMsWOjZouuGK0muqUbL
	 yJ8xVXx1iMrHSXn3V5ByH2MMA5q//7JebvOb2A0x0w/cJVKdOJFQQ5fCht7F+it2TY
	 M5+CZSo7v8K5au3t1cfZfU6UE9UNiGyhJDWV0XP8/+xIEm5dGm8p4Qdb4s/FSRgvvN
	 lmD4dxLeLbydbV+UTacIwktDnZHSbMzYShgBB407xogu0h7tqF5+eZndOyMZBnIKrL
	 IwARebg15bHkx4v0p2D064KlbdwUrJ11/YvgHE59v3LJIflvKivo6qao0Nz8k50Vil
	 6UYYaKLRUUD2w==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:42 +0200
Subject: [PATCH v3 11/13] misc: pci_endpoint_test: Add support for rockchip
 rk3588
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-11-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; i=cassel@kernel.org;
 h=from:subject:message-id; bh=C4BXtDtnPo3XQ7NV1y/rceBvVT8N7ly3fImlpXG2wtA=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKsq+pbP8heOhh5LsXQMUviX4jrTdvEuzs6D8W9TC97N
 V9O78zJjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkeTrDX4Hl7a3b9KfzuSpw
 HRPV+f227dCW0H1ZKl9rn93ydnaeYsvI0LNpi8x1ztlJSo5WGS6nTwbMNPIR3Rx1N7jp4DyXqyJ
 N/AA=
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


