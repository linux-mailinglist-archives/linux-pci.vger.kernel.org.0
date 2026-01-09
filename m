Return-Path: <linux-pci+bounces-44316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB36D0701B
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 04:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 533F73014BDC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 03:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECC523BD05;
	Fri,  9 Jan 2026 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UudThjRc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D76235BE2;
	Fri,  9 Jan 2026 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929832; cv=none; b=fBx3QRKyvA2gGwgtpoxmHNSR1xorPPCGt8Nhm0JsFBDOBMV98t5+GAkEJrHXVFReTncM2nf7F41DA4wr9Z22n3W3gIaWpAt1RagBzKTQZPotdDrsxzpUtP3a2ve+iB15Bb+iabT5pbdtGsgGxH6AfALepwyF9NIH/BBCY5FysQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929832; c=relaxed/simple;
	bh=UzCHgaOdbN806X+suNom7v2Hf7jRxYEHOHHzxuw5dug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UBGEtetmQpim863y0j/JjU3PF/gFz5lijBuj77v36Lww+OGzGbn1JhL/+NgaQ9s2rrDvDEvSwM5qSygg6sKdHPQqNBX3EO+Blbs4XrdCeHzgTupIzBfdrjXQXQS+rU5bUYMNm6SB7ceec4mNEjQg28Mm7H620oCdb1qxdpqMVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UudThjRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C01EEC4CEF7;
	Fri,  9 Jan 2026 03:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767929831;
	bh=UzCHgaOdbN806X+suNom7v2Hf7jRxYEHOHHzxuw5dug=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UudThjRcnWPCIrqgBdo0my3dNrnYeYKEwY7cZhK8nGsO7WSOlzgCRlJnfYr1T/4mO
	 M8TnDmxZbpJmWROxPAsiXhDu64u9f+z68yyEhqp3r40fHXUQFldcpeKI9+lsZ3ZvVn
	 a1YoFCxo41PobtKdTaiAnJ8czQYInD0I8MnEpmJsXhD4+2/4+IwOhyye0pNvYLFxJ8
	 U2JXfE6v9cDAQaCVmKu1K8oOd/KTVXw0nKLTb+69IbbpUFw1dtNhNTo/IvIms4kKoZ
	 T8a+Lz27FcA8Tc0p0z2OT9TNODO8gd27TMH2aPryu8C0XGBloZFrnkbe3nP178EstL
	 96D8ZpbMuP9FA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC078D232CC;
	Fri,  9 Jan 2026 03:37:11 +0000 (UTC)
From: Ziyao Li via B4 Relay <devnull+liziyao.uniontech.com@kernel.org>
Date: Fri, 09 Jan 2026 11:36:58 +0800
Subject: [PATCH v3] PCI: loongson: Override PCIe bridge supported speeds
 for older Loongson 3C6000 series steppings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-loongson-pci1-v3-1-5ddc5ae3ba93@uniontech.com>
X-B4-Tracking: v=1; b=H4sIANl3YGkC/3XOTQrCMBCG4atI1kYy6a+uvIe4aDKTNqBJSWpQS
 u9uWnBTcPl+MA8zs0jBUmSXw8wCJRutdzmK44HpoXM9cYu5mRSyEq2U/OG966N3fNQWeImEApv
 WgFIs34yBjH1v3u2ee7Bx8uGz8QnW9Z+UgAMvzl2nFAIYhdeXy79MpIeT9k+2akn+hFqAKPeCz
 AJCBVQ1qibT7oVlWb5N0d5r8AAAAA==
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
 Lain Fearyncess Yang <fsf@live.com>, Ayden Meng <aydenmeng@yeah.net>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
 Ziyao Li <liziyao@uniontech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767929829; l=4136;
 i=liziyao@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=oMHSSUNney/eskB1K6w/DmvTz2ry8+yQZ5lOuXaB2is=;
 b=bsb8AjnxdcUhPFca5e11Q1ysRRyqUV8kU2lrpnIy2JlQgjXcp20ZD3ireEHdqbYYnf5XxGXXI
 4Wdlvc/IKYMAi49A2GoFRlrK6aOPYCIFXiB7uNmUSWvecPNcXAwOUBQ
X-Developer-Key: i=liziyao@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for liziyao@uniontech.com/20250730 with
 auth_id=471
X-Original-From: Ziyao Li <liziyao@uniontech.com>
Reply-To: liziyao@uniontech.com

From: Ziyao Li <liziyao@uniontech.com>

Older steppings of the Loongson 3C6000 series incorrectly report the
supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
up to 16 GT/s.

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
---
Changes in v3:
- Adjust commit message
- Make the program flow more intuitive
- Link to v2: https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com
- Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongson.c
- Fix falling through logic and add kernel log output by Xi Ruoyao
---
 drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index bc630ab8a283..67a6d99b9e82 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -176,6 +176,44 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
 
+/*
+ * Older steppings of the Loongson 3C6000 series incorrectly report the
+ * supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
+ * only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
+ * up to 16 GT/s.
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
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19,
+			 loongson_pci_bridge_speed_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29,
+			 loongson_pci_bridge_speed_quirk);
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



