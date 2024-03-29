Return-Path: <linux-pci+bounces-5402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E86B891C6A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288F3B247D5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1118523E;
	Fri, 29 Mar 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXteeCvF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF0185237;
	Fri, 29 Mar 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716125; cv=none; b=gn9IJUmlk/Mw4Nuzcl/c2nEEBcRBOPwKOop90ShHZe9P9DZFNAHmehROj5PLPFERM2vPxuT6bXBnRyDfgBcyo3ZAjHtmECjmpYpCK/J98sx8zrjhVqGQx3QKiSYhaQ7u1pB36OcyeVnlSefDarKx4uXxTsxg+Jdmu0CtpSRPUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716125; c=relaxed/simple;
	bh=fbR+5U4rESsw5v4xXsfCY68N3QJWqm7u3XMhqCXZziY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+rOrSSCwIEs3oPSwsGgbwzp7LNzIw5MlFDc9YlIzzGTGbByL7kZglS7AcsiHeuoJIe1UB9G6Ebi1bydpeLzh3OzS2rs2+fcjc/TEE5QSgzD1iNy/6Jb/noIeKqQwDfOPtBzQE3wJdpfS18Y/VSybdncfWFo80RrpZ7VRrW7cGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXteeCvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FA6C433C7;
	Fri, 29 Mar 2024 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716125;
	bh=fbR+5U4rESsw5v4xXsfCY68N3QJWqm7u3XMhqCXZziY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXteeCvFmjI8ppeGdtjGpsj/IrW6F9GloqXBtF81nOiUFgKxTZPpnXOuGFMV+r1VE
	 HIQIlEf11Trph7Hbk6nJ18lntcsylWlzbcMOyhDctBf+KP2B9JuTTNOjuaKDlvh3w/
	 +UzUjGgLrnbTTB01UYNRebQIQRIMTXnZR30v10kPHyZo2951Bdf0IDDjQS3eBJlCnF
	 cxKLx+a4i8JnsTNOr51wwcdWUn4gMwIM6hznul8t/KSP1r5gyuMQ5HN+l8GKcwbxXJ
	 KYwmNfpMFmG+ZGdWfny2dr9vnoEbQ/T6ZM1nAbnBmCCJpYQARrJpuZ+rAV72wSw5ty
	 4ULIMiPbVHWXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Drake <drake@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 67/98] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
Date: Fri, 29 Mar 2024 08:37:38 -0400
Message-ID: <20240329123919.3087149-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Daniel Drake <drake@endlessos.org>

[ Upstream commit cdea98bf1faef23166262825ce44648be6ebff42 ]

The Asus B1400 with original shipped firmware versions and VMD disabled
cannot resume from suspend: the NVMe device becomes unresponsive and
inaccessible.

This appears to be an untested D3cold transition by the vendor; Intel
socwatch shows that Windows leaves the NVMe device and parent bridge in D0
during suspend, even though these firmware versions have StorageD3Enable=1.

The NVMe device and parent PCI bridge both share the same "PXP" ACPI power
resource, which gets turned off as both devices are put into D3cold during
suspend. The _OFF() method calls DL23() which sets a L23E bit at offset
0xe2 into the PCI configuration space for this root port.  This is the
specific write that the _ON() routine is unable to recover from. This
register is not documented in the public chipset datasheet.

Disallow D3cold on the PCI bridge to enable successful suspend/resume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Link: https://lore.kernel.org/r/20240228075316.7404-1-drake@endlessos.org
Signed-off-by: Daniel Drake <drake@endlessos.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/pci/fixup.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index f347c20247d30..b33afb240601b 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -907,6 +907,54 @@ static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
 
+/*
+ * Disable D3cold on Asus B1400 PCI-NVMe bridge
+ *
+ * On this platform with VMD off, the NVMe device cannot successfully power
+ * back on from D3cold. This appears to be an untested transition by the
+ * vendor: Windows leaves the NVMe and parent bridge in D0 during suspend.
+ *
+ * We disable D3cold on the parent bridge for simplicity, and the fact that
+ * both parent bridge and NVMe device share the same power resource.
+ *
+ * This is only needed on BIOS versions before 308; the newer versions flip
+ * StorageD3Enable from 1 to 0.
+ */
+static const struct dmi_system_id asus_nvme_broken_d3cold_table[] = {
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.304"),
+		},
+	},
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.305"),
+		},
+	},
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.306"),
+		},
+	},
+	{
+		.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.307"),
+		},
+	},
+	{}
+};
+
+static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
+{
+	if (dmi_check_system(asus_nvme_broken_d3cold_table) > 0)
+		pci_d3cold_disable(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
-- 
2.43.0


