Return-Path: <linux-pci+bounces-44690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D3D1C13E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 03:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB326301E593
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 02:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393C82F28FF;
	Wed, 14 Jan 2026 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPl4BP11"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116492F25FB;
	Wed, 14 Jan 2026 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356400; cv=none; b=ZpdEiLSgbdSxXuqPNDrqGzM/PDUU4B22uVqmj7oWbL2e/qnTsu78geQpZbsEjPyhURytS3g4tgwc1p3y54VbPQpbfYfwlVr37CupTNJnZYNtPblnj/8N7/1xvFTKNjAD0mlMRwq1Q0wjPfaN+nPZVTL1tZ9oKjiBpArgnWGvq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356400; c=relaxed/simple;
	bh=uuLr/j8r2wPQDPeI3/LDBsXy44v02x81XisruRF7Wo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q7jOtTetCu+2zJP884ZQCsHlWqNBTk22tH7zEGX5/FVMyB3VqHoa/c7W4MIjEefgPnkT8Or6oTF5vGao1WV30d2pzvsrWyAm1TCub2dTB6NyPelfAnQQYrYISV+appBhPdgrpc0XJMYBJwkijpPZomBDEPLN19dG+JiIFDu4HKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPl4BP11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85929C116C6;
	Wed, 14 Jan 2026 02:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768356399;
	bh=uuLr/j8r2wPQDPeI3/LDBsXy44v02x81XisruRF7Wo0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=gPl4BP11xBYFA9FvQ2g9ZImlgtJh1zHXH632Dbe+7yTvDAacB/n7YZ1LXldxbJZFu
	 20GofxINix8p8NWWoVJWi60ZxGoXZW5VfYVK/GH067uxgZtfbcGOhCIceSxtf0gGXD
	 8qYXfPRTnWvCmu3E3pX6fOZ7fnFv/G/jGrzUuM1c3JWM9Gd5DJb5RkR11X43NYJXc0
	 ZqlHU3RqXX/99Ws83MdiWBgx+8WBmXZYnr/OcdCGgEgs7RRdiSYif74IXZqCU672vH
	 UnHK8YgOOLrgWIttRpt0maOWuijrmPQ87R0PbvxfRJJLvwFbveUSpNW71x5hpTlyUp
	 Agg+SYwLVzV+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F59D31A05;
	Wed, 14 Jan 2026 02:06:39 +0000 (UTC)
From: Ziyao Li via B4 Relay <devnull+liziyao.uniontech.com@kernel.org>
Date: Wed, 14 Jan 2026 10:05:45 +0800
Subject: [PATCH v6] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAPj5ZmkC/33OTWrDMBCG4asEraui0Z+trHqP0oWkGcWCVgpWa
 lqC714lUAjG7fL9YB7myhrNmRo7Hq5spiW3XEsP+3RgcfLlRDxjbyaFNGKUkr/XWk6tFn6OGbh
 GQoHDmCAE1m/OM6X8dfde33pPuV3q/H3nF7itf0kLcODKeR8CAqSAL5+l/3KhOD3H+sFu2iJ/B
 StA6K0gu4BggMwQLKVxT1CPgtsKqgsGMRpPKnin9gT9IIDaCroL4CSg1YNLpPcE869guiCtji5
 o74QPW2Fd1x+5ktCOtgEAAA==
X-Change-ID: 20250822-loongson-pci1-4ded0d78f1bb
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: niecheng1@uniontech.com, zhanjun@uniontech.com, 
 guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, kernel@uniontech.com, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lain Fearyncess Yang <fsf@live.com>, Ayden Meng <aydenmeng@yeah.net>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
 Ziyao Li <liziyao@uniontech.com>, stable@vger.kernel.org, 
 Huacai Chen <chenhuacai@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768356398; l=4664;
 i=liziyao@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=NQB5kuvj5NMBxTAmoWUFNc7QxvL1OvGSuDPC180t0ro=;
 b=YZcYmCnnZHg6jd7Ql8ij+njUe18BYwIVeGyn9DE4bpxHuv4/xh5oiyda8MZAuIMcnYKnhrTx1
 69ZJtbc2VgFDLp4aXajeECo/gZQ+ADavZpaB3i+MEn0f8bSQD9XtVBS
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

Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
clocks and lanes in power management. We hope this can prevent similar
problems in future driver changes (similar checks may be implemented
in other GPU, storage controller, NIC, etc. drivers).

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
Cc: stable@vger.kernel.org
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
Changes in v6:
- adjust commit message
- Link to v5: https://lore.kernel.org/r/20260113-loongson-pci1-v5-1-264c9b4a90ab@uniontech.com

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



