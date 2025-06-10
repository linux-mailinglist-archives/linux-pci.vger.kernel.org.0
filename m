Return-Path: <linux-pci+bounces-29318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42990AD354D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA0F3A8B66
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BE21CA02;
	Tue, 10 Jun 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoSQwOzl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ABF155322;
	Tue, 10 Jun 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556103; cv=none; b=WV8Asf+KimXhgRT2ObWUfDx9dTnxOdrcdiIbzzfvWDFKpoUbBIGxrmNsjV1UQVJpUCYHFiRwmgJGlOORBmSfOw1yj9d7oJhlZSuby7GsNFlAYD3+LLgk9ppqdzh2iBkpmLgA8bC85o8EfWo3MOuRVotZZtM+4il054wQbBPcPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556103; c=relaxed/simple;
	bh=OeGToYR8xZLuZGczfxVSGBhX3xOeRUbH2r4olBPQ0to=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=COt/lKVL2s1DqHF/ZgDIh5y82DaAuoX7VMIBmQeznqXdajtv8NmF+Wsv+VIVVIIvXj7CAkdf4fwgot2e1TTP4nysn+cWJRmHtH0yhVWxxHI1DNU4VOYYMVBVdO3JipNgkrAlYM/YopPIDSH7uddK/tmz/0cWqLP2QuugnK3AGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoSQwOzl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749556099; x=1781092099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OeGToYR8xZLuZGczfxVSGBhX3xOeRUbH2r4olBPQ0to=;
  b=QoSQwOzlTaDTjEip47P9x5BHEFTRGjcP992VeZb3HTMu9oaxRYgWLnQB
   LIFwL4KTaAMltcXh76ipdkcg6Q76RkJpRD6mRxBaV/zRMHNgr2qEcOI1l
   0a5WfK0aKMfemqrdi7qFGzB2nS/RIu5ZVFaMI7Lsn7J+GuRQWMKhWiaPK
   56CjTe0n5gzMGlRMzfRPfLis36FXG2J+NqiZCKnMf0W1NPRt2lUO3HD16
   BdSot1fs5Dm51uaZN10xCZMk5HUf2zCVJVR4NiHfD9yvvT/kfZNXJYOJ0
   U+y1joo6tmttIY/ljkFAW0sSyuEdiIClaB4B+yRdcS0dSOFSQ5GcFZ+UW
   g==;
X-CSE-ConnectionGUID: qSSYKRIwRx619XS5NgNy8g==
X-CSE-MsgGUID: ANvMQOQORQeAYe8EfEeJEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51802454"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51802454"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:48:18 -0700
X-CSE-ConnectionGUID: yw92APc5QFaiSc4S3YA70w==
X-CSE-MsgGUID: JS5djz8uQKGK0r6U7dbviQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="177734029"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:48:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Date: Tue, 10 Jun 2025 14:48:02 +0300
Message-Id: <20250610114802.7460-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
Tag Requester (note: there is currently no 10-Bit Tag support in the
kernel). While those can be configured to the recommended values by FW,
kernel may decide to overwrite the initial values.

Add a quirk that disallows enabling Extended Tags and setting MRRS
larger than 128B for devices under Xeon 6 Root Ports if the Root Port
is bifurcated to x2. Use the host bridge's enable_device hook to
overwrite MRRS if it's set to >128B for the device to be enabled.

The earlier attempts to implement this quirk polluted PCI core code
with the checks necessary to support this quirk. Using the
enable_device hook keeps the quirk well-contained, away from the PCI
core code.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Ingo gave his Ack on v2 but since the used approach has once again
changed, I didn't add his Ack.

Mani did express his concern on using enable_device hook but suggested
I send the patch anyway.

We're also looking into using _HPX Type 3 (suggested by Bjorn) eventually
for this class of problems where FW settings get overwritten by the
kernel (but it will take time to make it the sanctioned solution). In
the meantime, this is a real problem for Xeon 6 out there so it warrants
adding the quirk (which is now pretty well-contained).

v3:
- Use enable_device hook to overwrite MRRS to 128B if needed. (Lukas)
- Typo fix to comment (Ingo)

v2:
- Explain in changelog why FW cannot solve this on its own
- Moved the quirk under arch/x86/pci/
- Don't NULL check value from pci_find_host_bridge()
- Added comment above the quirk about the performance degradation
- Removed all setup chain 128B quirk overrides expect for MRRS write
  itself (assumes a sane initial value is set by FW)


 arch/x86/pci/fixup.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e7e71490bd25..38369124de45 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -294,6 +294,46 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk);
 
+/*
+ * PCIe devices underneath Xeon6 PCIe Root Port bifurcated to 2x have slower
+ * performance with Extended Tags and MRRS > 128B. Work around the performance
+ * problems by disabling Extended Tags and limiting MRRS to 128B.
+ *
+ * https://cdrdv2.intel.com/v1/dl/getContent/837176
+ */
+static int limit_mrrs_to_128(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	int readrq = pcie_get_readrq(pdev);
+
+	if (readrq > 128)
+		pcie_set_readrq(pdev, 128);
+
+	return 0;
+}
+
+static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+	u32 linkcap;
+
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
+	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
+		return;
+
+	bridge->no_ext_tags = 1;
+	bridge->enable_device = limit_mrrs_to_128;
+	pci_info(pdev, "Disabling Extended Tags and limiting MRRS to 128B (performance reasons due to 2x PCIe link)\n");
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db0, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db1, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db2, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db3, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db6, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db7, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db8, quirk_pcie2x_no_tags_no_mrrs);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db9, quirk_pcie2x_no_tags_no_mrrs);
+
 /*
  * Fixup to mark boot BIOS video selected by BIOS before it changes
  *

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.39.5


