Return-Path: <linux-pci+bounces-19735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE5A10C5C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6A71885606
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A567819F13C;
	Tue, 14 Jan 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="kk6s2Med"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DD1662F6;
	Tue, 14 Jan 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872453; cv=none; b=ktHaO8pYc9vd5LELpb+RJ0J+jzIlrRXbY5N+DsBKSKRrVcOoxkhHnuDl9c6lY3UkKw6B2fxppw9eW8IfS+0cNXzlIq5xltJu6Due01CVWo4S8yU5ir/PoRUSVsF18HVT1TU6x2n/lWxTd89m9I00U7TUw40YScIwxthiQbN0INY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872453; c=relaxed/simple;
	bh=67iJyBwsL5ZabbvMYBIa72sRML/dISEStJ7DIqhIqeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sls0IyZ/f7OIjOrK0TVqDY05JrzACvVlBBkBnTs9hQ/wQpxHT3Rq+8cC/TWJzpYndWD71ET+3SYEBWsEv7CRqLvmgqvyd0AXuIuRS9PpA+rx0Kxkini1S7wunDeQuGiBXaLcyV/80whe4HVs5DSDIp6lLzf12VBJsEOyMO2zfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=kk6s2Med; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (pd9e5946e.dip0.t-ipconnect.de [217.229.148.110])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 3AE802FC005B;
	Tue, 14 Jan 2025 17:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1736872447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RPC5KtCfrtxcxyWvhaCtq0pdbU8ttsv67ggUXV4Xazs=;
	b=kk6s2Med/tLzLfK8geRIa6eNuWb/st2tlHg3e4+g0nzCDJCEBUn2nYWvY/XnT/mGt0NrK8
	kNh5qmUX3xe0zNNj83o4LyfSBMxEZ7R+mmKbQyx1EvOIB9GxKMhlL5d7k++HDZzlNfqfJP
	JbScjjVLT0baBeSXa8CLNgfcGM5HiWE=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] PCI: Avoid putting some root ports into D3 on TUXEDO Sirius Gen1
Date: Tue, 14 Jan 2025 17:32:35 +0100
Message-ID: <20250114163403.704404-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") sets the
policy that all PCIe ports are allowed to use D3.  When the system is
suspended if the port is not power manageable by the platform and won't be
used for wakeup via a PME this sets up the policy for these ports to go
into D3hot.

This policy generally makes sense from an OSPM perspective but it leads to
problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
specific old BIOS. This manifests as a system hang.

On the affected Device + BIOS combination, add a quirk for the root port of
the problematic controller to ensure that these root ports are not put into
D3hot at suspend.

This patch is based on
https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com/
but with the added condition both in the documentation and in the code to
apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS and only
the affected root ports.

Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: stable@vger.kernel.org # 6.1+
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 arch/x86/pci/fixup.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 0681ecfe34300..6aabc393321f3 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1010,4 +1010,34 @@ DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_suspend);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_resume);
 DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_suspend);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_resume);
+
+/*
+ * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
+ * may cause problems when the system attempts wake up from s2idle.
+ *
+ * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this manifests as
+ * a system hang.
+ */
+static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
+		},
+	},
+	{}
+};
+
+static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
+{
+	struct pci_dev *root_pdev;
+
+	if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table)) {
+		root_pdev = pcie_find_root_port(pdev);
+		if (root_pdev)
+			root_pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_ryzen_rp_d3);
 #endif /* CONFIG_SUSPEND */
-- 
2.43.0


