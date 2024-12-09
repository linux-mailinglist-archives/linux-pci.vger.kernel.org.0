Return-Path: <linux-pci+bounces-17963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF8E9E9FD3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F74B281D7E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0021552E4;
	Mon,  9 Dec 2024 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="YW/2w0dJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7113B280;
	Mon,  9 Dec 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773566; cv=none; b=crsC0Wapjif4xvifUqRJXUSmF6dOjLjtpBU9rXBJjweyOKMC2Fz71DQNzjTO0MV/ddR+T7HXQHOlPFmDIokQdLY4GDDNdozr0LvZH+GVYgr7QbsM5efysJStGKaYS+KDNzbgqlZFRinmWjVwYiVKN7WLLYsT2mNo1G8k1i3QTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773566; c=relaxed/simple;
	bh=QjbXti7K+0IB0k7gxNqu/XvSi8QguMPMyzhRe7aPbXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTu4NkVBiP/2d5XSA5cRox0OlXwjyAtbUHik/1MPszXv8vvEHZGgjHBVq+NiGN5dyTOH7db4Lug9CQLbKbmHdZyZd+eUZNGPVVgRDtpTst2KF9TqkUfGAXaA45/q5FRBlsYzPC3ZjXLznsOWShqkrYzW289LcInnE9eRwrTjSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=YW/2w0dJ; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 9D3232FC0052;
	Mon,  9 Dec 2024 20:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1733772994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qSiKqKv789f7Hfxm0LW86cuxIrfh1k2c7Xok95aj+Nc=;
	b=YW/2w0dJvhK4fTlIgL9kAVeCNS23kKGGlE5CjfmDBXy44HyumlIPlnfVnkbpF+W7ESKF+n
	AH5YGgmbo/PXWfIiEjOLUna+HCAQHo4IhTB4HIjQ0Dpa5fHn5yg9FrjCdRXEtYP0xDWPOw
	N1nNJmbtN9WSJ5UEnwnF7BZMqB3C3IM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Avoid putting some root ports into D3 on some Ryzen chips
Date: Mon,  9 Dec 2024 20:36:11 +0100
Message-ID: <20241209193614.535940-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
sets the policy that all PCIe ports are allowed to use D3.  When
the system is suspended if the port is not power manageable by the
platform and won't be used for wakeup via a PME this sets up the
policy for these ports to go into D3hot.

This policy generally makes sense from an OSPM perspective but it leads
to problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with
an unupdated BIOS.

- On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
  interrupt.
- On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.

On the affected Device + BIOS combination, add a quirk for the PCI device
ID used by the problematic root port on both chips to ensure that these
root ports are not put into D3hot at suspend.

This patch is based on
https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com/
but with the added condition both in the documentation and in the code to
apply only to the TUXEDO Sirius 16 Gen 1 with the original unpatched BIOS.

Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org # 6.1+
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/quirks.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 76f4df75b08a1..2226dca56197d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3908,6 +3908,37 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_poweroff_thunderbolt);
+
+/*
+ * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
+ * may cause problems when the system attempts wake up from s2idle.
+ *
+ * On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
+ * interrupt.
+ * On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
+ *
+ * This fix is still required on the TUXEDO Sirius 16 Gen1 with the original
+ * unupdated BIOS.
+ */
+static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "APX958"),
+			DMI_MATCH(DMI_BIOS_VERSION, "V1.00A00"),
+		},
+	},
+	{}
+};
+
+static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
+{
+	if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
+	    !acpi_pci_power_manageable(pdev))
+		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
 #endif
 
 /*
-- 
2.43.0


