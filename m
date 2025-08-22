Return-Path: <linux-pci+bounces-34540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EFBB312B1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 11:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8841CE6003
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6CB28852E;
	Fri, 22 Aug 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGp9XNeT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F82D46C4;
	Fri, 22 Aug 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854160; cv=none; b=MYHSZSJ+IcsCv5rsTJAdftzyOt85HHK1Ze+VOE76d1MeBBIr27Ur8n8KNNruypSB78TATQn9JqigkgqZqQY5KAi+G9cYY+PyXXD6iiMMSUYzgXG3a+JYVoTv626zOc5M5qlvoK6bjjkI/0j+r2R14Onep/oEOv4GqiAnd++Rnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854160; c=relaxed/simple;
	bh=z8zbkUUqq89bepUoHJqZI8/S5RfXwWWhDEqDbowwr2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RJsd4NAHVfCnvL6XrOqH2CfYACa8o6zD9pyDJLoOUIHAOaSMIBeKKL76unVOMoMwYucNDQ+uQxj+3KbR7nD2Sgo/nNC54+mcVgHPgt5iQm7aSlZnyYemiu0XC8rbwJboHN2Hi2MCTi6V/XJrk5rt6w42a2MWXbdyAtPu6FrYp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGp9XNeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EB75C4CEF4;
	Fri, 22 Aug 2025 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755854159;
	bh=z8zbkUUqq89bepUoHJqZI8/S5RfXwWWhDEqDbowwr2c=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qGp9XNeTRVV8XCrO6I214plLlDHtf/hibXmaZL6HCig/glprBCbxDaxX89cAhCpj5
	 cIRaS+x6+q68F5fuH1EuxsK5Dlbb4DpNUGhUYtXSrmeLou8Zo4B97E+pqms4Aa8mki
	 SnstwxOSADnMIcrBaivYse1ya4askMUxaNJmM4a6Wit3l6PfUd9gFnoULVO3mWMi4L
	 cJA8pyfPu5MofsYVw6BlONCecSmz+oQcfLebZEpXEbGr1713WIHRK4GV2G/PCeviEB
	 zfa+AubDXoFsxgKpFliy3NCdWKaTnzZFTnmWXdO3Pww2fgW4F/IrHD+gV30pgiEzh3
	 vuyuby9mHqvOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD9BCA0FE1;
	Fri, 22 Aug 2025 09:15:59 +0000 (UTC)
From: Ziyao via B4 Relay <devnull+liziyao.uniontech.com@kernel.org>
Date: Fri, 22 Aug 2025 17:15:58 +0800
Subject: [PATCH RESEND] PCI: Override PCIe bridge supported speeds for
 older Loongson 3C6000 series steppings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAE01qGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMj3Zz8/Lz04vw83YLkTENdk5TUFIMUc4s0w6QkJaCegqLUtMwKsHn
 RSkGuwa5+LkqxtbUAxRNBqmcAAAA=
X-Change-ID: 20250822-loongson-pci1-4ded0d78f1bb
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, niecheng1@uniontech.com, zhanjun@uniontech.com, 
 guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Lain Fearyncess Yang <fsf@live.com>, Mingcong Bai <jeffbai@aosc.io>, 
 Ayden Meng <aydenmeng@yeah.net>, Ziyao <liziyao@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854158; l=2862;
 i=liziyao@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=7xgYquKCBWgLgcwEUYsMzaOeKqJ2pkwi5F04w/83CmQ=;
 b=4SQnoM5gRY/+gdNOKjlnMONV5R8RlOLqacb/Px3bQrAeMEACvDqhac2rM4vmbswmwm2afAwZQ
 0+S2BqiB5bRD4RXfwBUD0v6nMPOSh+K19IIE2TFDYzG24aEYM7r/8Qq
X-Developer-Key: i=liziyao@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for liziyao@uniontech.com/20250730 with
 auth_id=471
X-Original-From: Ziyao <liziyao@uniontech.com>
Reply-To: liziyao@uniontech.com

From: Ziyao <liziyao@uniontech.com>

Older steppings of the Loongson 3C6000 series incorrectly report the
supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
up to 16 GT/s.

As a result, certain PCIe devices would be incorrectly probed as a Gen1-
only, even if higher link speeds are supported, harming performance and
prevents dynamic link speed functionality from being enabled in drivers
such as amdgpu.

Manually override the `supported_speeds` field for affected PCIe bridges
with those found on the upstream bus to correctly reflect the supported
link speeds.

This patch is found from AOSC OS[1].

Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
Tested-by: Lain Fearyncess Yang <fsf@live.com>
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Ziyao <liziyao@uniontech.com>
---
PCI: Override PCIe bridge supported speeds for older Loongson 3C6000
 series steppings
---
 drivers/pci/quirks.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d97335a401930fe8204e7ca91a8474b6b02554c1..8d29b130f45854d2bff8c47e6529a41a3231221e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1956,6 +1956,30 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
 
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
 
+/*
+ * Older steppings of the Loongson 3C6000 series incorrectly report the
+ * supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
+ * only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
+ * up to 16 GT/s.
+ */
+static void quirk_loongson_pci_bridge_supported_speeds(struct pci_dev *pdev)
+{
+	switch (pdev->bus->max_bus_speed) {
+	case PCIE_SPEED_16_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
+	case PCIE_SPEED_8_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
+	case PCIE_SPEED_5_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
+	case PCIE_SPEED_2_5GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
+	default:
+		break;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, quirk_loongson_secondary_bridge_supported_speeds);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, quirk_loongson_secondary_bridge_supported_speeds);
+
 /*
  * HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
  * actually on the AMBA bus. These fake PCI devices can support SVA via

---
base-commit: 3957a5720157264dcc41415fbec7c51c4000fc2d
change-id: 20250822-loongson-pci1-4ded0d78f1bb

Best regards,
-- 
Ziyao <liziyao@uniontech.com>



