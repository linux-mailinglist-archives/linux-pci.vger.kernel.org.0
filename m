Return-Path: <linux-pci+bounces-44587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF1BD17235
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 08:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBBF03017C75
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498E3112D2;
	Tue, 13 Jan 2026 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi3q0Skc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018326F2B9;
	Tue, 13 Jan 2026 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291130; cv=none; b=qQD8xF+cze5rcO/FjgR2AxF5T7vKpQYif1CDK5P6P0DG7M6Eib0PovW8wvs9HAwJjt4HHTZ9R9nRzk9739pQ7N4AZETFPL2PKTUuWmOfrmczSxgwR97CD5rD6xHN+3y7J7FdV2W1GU3OEVMfJk0VO5d6jq37RJ7i1HoqOt8FvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291130; c=relaxed/simple;
	bh=n7al2zJlu/imxnIL4dUi9H5BMNfDDPOy1fzae83W3jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p/zKUTfFDVPEX3qD7vzPjcZx0wP0uorl4oczA9ouV6sykf2KMnDsIRyx2sBEWXT5C3d8OttU/DRqvJIRt/zIXrfyPpoYQoXbQ6D4pwC1tmZ7qyICpNxUZkXOc3cnTTLen18CAwJbzN+sGurjUQbGyT1aAQBILiIDpZKHmGTIeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi3q0Skc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B13CAC19421;
	Tue, 13 Jan 2026 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768291129;
	bh=n7al2zJlu/imxnIL4dUi9H5BMNfDDPOy1fzae83W3jM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Oi3q0SkcvYxKdtGE6sy3da76Je4g3Zue9BIFQ/o//ARQpMn8ZeN49i9Xu2UxtJbAP
	 JtJFFD4laKNPliFwPvG5ya0HInYbFbe+BSCpCO5n/i1Se15faAUdn016qZILr9TitF
	 Y4QTm2c2y9w+DR8bMfRHkP6QzUyRDkks2f3ZobmdBtNSEeDL5Rb1tADYzKU2qAjEoJ
	 ed/rblaCA0auxRRXYQX7pSjEbMJAs0yGBvcd16wZrQ66syoSgO1HDHaHgUKESk/t30
	 I00DN70uSamIIav+8vW0NHOYKNZkoGj/z7cLzESMsHUuupzV9bjQmG4Kqmavo5EDvN
	 yh5B6urRX8Ifg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1111D29DE2;
	Tue, 13 Jan 2026 07:58:49 +0000 (UTC)
From: Ziyao Li via B4 Relay <devnull+liziyao.uniontech.com@kernel.org>
Date: Tue, 13 Jan 2026 15:58:48 +0800
Subject: [PATCH v5] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-loongson-pci1-v5-1-264c9b4a90ab@uniontech.com>
X-B4-Tracking: v=1; b=H4sIADf7ZWkC/3XOTWrDMBCG4asEraOi0Y9tddV7lCwkzSgWNJKxU
 pMQfPcogUIw6fL9YB7mxirNiSr73N3YTEuqqeQWZr9jYXT5SDxhayaFNGKQkv+Uko+1ZD6FBFw
 jocB+iOA9azfTTDFdnt73ofWY6rnM1ye/wGP9T1qAA1fWOe8RIHr8+s3tlzOF8SOUE3toi/wTO
 gFCbwXZBAQDZHrfURzeCepVsFtBNcEgBuNIeWfVO0G/CKC2gm4CWAnY6d5G0lthXdc70bg3cXQ
 BAAA=
X-Change-ID: 20250822-loongson-pci1-4ded0d78f1bb
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: niecheng1@uniontech.com, zhanjun@uniontech.com, 
 guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 stable@vger.kernel.org, Lain Fearyncess Yang <fsf@live.com>, 
 Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>, 
 Xi Ruoyao <xry111@xry111.site>, Ziyao Li <liziyao@uniontech.com>, 
 Huacai Chen <chenhuacai@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768291128; l=4487;
 i=liziyao@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=Hl7/CSJcQmXMBHxIa1mIHhAus0jXJU5lALHCfw50FBg=;
 b=OejsaQ8AveoPLToGMsvyxDDYWhDIGbSTlb11V1OBXdRNcJ/dYe80rqBBi1aCjwfoobQ7+fuPg
 q4Mrb/vYChKBs+XTo7FjhEV29YgLnSBmeUODzkm/eicP7fH5l/tKW/q
X-Developer-Key: i=liziyao@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for liziyao@uniontech.com/20250730 with
 auth_id=471
X-Original-From: Ziyao Li <liziyao@uniontech.com>
Reply-To: liziyao@uniontech.com

From: Ziyao Li <liziyao@uniontech.com>

Older steppings of the Loongson-3C6000 series incorrectly report the
supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
as only 2.5 GT/s, despite the upstream bus supporting speeds from
2.5 GT/s up to 16 GT/s.

As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
than one speed is supported"), bwctrl will be disabled if there's only
one 2.5 GT/s value in vector `supported_speeds`.

Also, amdgpu reads the value by pcie_get_speed_cap() in amdgpu_device_
partner_bandwidth(), for its dynamic adjustment of PCIe clocks and
lanes in power management. We hope this can prevent similar problems
in future driver changes (similar checks may be implemented in other
GPU, storage controller, NIC, etc. drivers).

Manually override the `supported_speeds` field for affected PCIe bridges
with those found on the upstream bus to correctly reflect the supported
link speeds.

This patch was originally found from AOSC OS[1].

Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
Tested-by: Lain Fearyncess Yang <fsf@live.com>
Tested-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
[Xi Ruoyao: Fix falling through logic and add kernel log output.]
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73175a17f493454
[Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-loongson.c]
Signed-off-by: Ziyao Li <liziyao@uniontech.com>
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
Changes in v5:
- style adjust
- Link to v4: https://lore.kernel.org/r/20260113-loongson-pci1-v4-1-1921d6479fe4@uniontech.com

Changes in v4:
- rename subject
- use 0x3c19/0x3c29 instead of 3c19/3c29
- Link to v3: https://lore.kernel.org/r/20260109-loongson-pci1-v3-1-5ddc5ae3ba93@uniontech.com

Changes in v3:
- Adjust commit message
- Make the program flow more intuitive
- Link to v2: https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com
- Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongson.c
- Fix falling through logic and add kernel log output by Xi Ruoyao
---
 drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index bc630ab8a283..a4250d7af1bf 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -176,6 +176,42 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
 
+/*
+ * Older steppings of the Loongson-3C6000 series incorrectly report the
+ * supported link speeds on their PCIe bridges (device IDs 0x3c19,
+ * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
+ * from 2.5 GT/s up to 16 GT/s.
+ */
+static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
+{
+	u8 old_supported_speeds = pdev->supported_speeds;
+
+	switch (pdev->bus->max_bus_speed) {
+	case PCIE_SPEED_16_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
+		fallthrough;
+	case PCIE_SPEED_8_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
+		fallthrough;
+	case PCIE_SPEED_5_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
+		fallthrough;
+	case PCIE_SPEED_2_5GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
+		break;
+	default:
+		pci_warn(pdev, "unexpected max bus speed");
+
+		return;
+	}
+
+	if (pdev->supported_speeds != old_supported_speeds)
+		pci_info(pdev, "fixing up supported link speeds: 0x%x => 0x%x",
+			 old_supported_speeds, pdev->supported_speeds);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;

---
base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
change-id: 20250822-loongson-pci1-4ded0d78f1bb

Best regards,
-- 
Ziyao Li <liziyao@uniontech.com>



