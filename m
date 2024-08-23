Return-Path: <linux-pci+bounces-12062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3995C42D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 06:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3746228527B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 04:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49813AD06;
	Fri, 23 Aug 2024 04:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjRJO7c7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9013AA2A;
	Fri, 23 Aug 2024 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387161; cv=none; b=EcKlougeCqacojgj4GU5gbzIxmtS4BMO1ZOJxb6Xuh6wVBPOMVOAF7FpOEnm6jH8qx062w0dGpab8fVBN/5qkgp317ioGejQOfdPy74OLbSFt+/wYUuW6YYxknxNVCTM77Wdq9Bo1xlY8y86DAreA6MQEQoIqJersL2pfO4kg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387161; c=relaxed/simple;
	bh=JWSRlz8uRX9VxLn24AvyMy0LwzF2iYqEImctSnL1LEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJT/9kpBvqxYXMPlhSFLR1BGZR/sHNC8zHlu+g9/lwa6w089TQsGoGoNbzzteKrBjOfpr1vab2FeKU7jExh/cYY9x5dL/vAenri13XAlipuZW/Md7dspcWMPW0i4+XQxmPxSC63bg2AxIZqFzKJBWCzuerZDeSa8Ajgn534N+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjRJO7c7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE819C4DDEE;
	Fri, 23 Aug 2024 04:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724387160;
	bh=JWSRlz8uRX9VxLn24AvyMy0LwzF2iYqEImctSnL1LEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjRJO7c76lM86qsTNCrtqG8/jdXa2IHrSc4V/YTA5BsumkSszZ4hu6cWVAd5Fe1N3
	 z1Qe3A49AzC0ep5BYiuSfINfLktqfXARIVGFNfMduP6e7S264msH6F5FpKw48mZ27h
	 A8Hjln0IrFyzc0NPZe96JkGAti3qU/VFaO5D0bDuRUhrT3TdrpOm2zS4H7ll9II4Xt
	 boDTHLbJzI4Lhh9GJOKYGR14++oaRUFG4DL/OWlfD2c66YO8TpKrqyiMtEphHFm8W1
	 XeLqJKL5uGDvhf0JZRX5vdKMrpHBoFZ4kKArdcuBBS1ji2MaerQ1QaOu9+2LWdbaCZ
	 oQbmJ7bRNUaqA==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 4/5] PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
Date: Thu, 22 Aug 2024 23:25:07 -0500
Message-ID: <20240823042508.1057791-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823042508.1057791-1-superm1@kernel.org>
References: <20240823042508.1057791-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

As the PCI core now has a delay after D3cold exit, the Ryzen XHCI
controllers that were quirked to not use D3cold and to add a delay
on D3hot no longer need these quirks.

Drop both the PCI and XHCI sets of quirks.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/quirks.c        | 17 -----------------
 drivers/usb/host/xhci-pci.c | 11 -----------
 2 files changed, 28 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5a..3480a0445ff50 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2059,23 +2059,6 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8,
 			      quirk_nvidia_hda_pm);
 
-/*
- * Ryzen5/7 XHCI controllers fail upon resume from runtime suspend or s2idle.
- * https://bugzilla.kernel.org/show_bug.cgi?id=205587
- *
- * The kernel attempts to transition these devices to D3cold, but that seems
- * to be ineffective on the platforms in question; the PCI device appears to
- * remain on in D3hot state. The D3hot-to-D0 transition then requires an
- * extended delay in order to succeed.
- */
-static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
-{
-	quirk_d3hot_delay(dev, 20);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
-
 #ifdef CONFIG_X86_IO_APIC
 static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
 {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dc1e345ab67ea..d726810a04838 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -316,10 +316,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		(pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_1)))
 		xhci->quirks |= XHCI_U2_DISABLE_WAKE;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
-		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_XHCI)
-		xhci->quirks |= XHCI_BROKEN_D3COLD_S2I;
-
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 		xhci->quirks |= XHCI_INTEL_HOST;
@@ -752,13 +748,6 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	if (xhci->quirks & XHCI_COMP_MODE_QUIRK)
 		pci_d3cold_disable(pdev);
 
-#ifdef CONFIG_SUSPEND
-	/* d3cold is broken, but only when s2idle is used */
-	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
-	    xhci->quirks & (XHCI_BROKEN_D3COLD_S2I))
-		pci_d3cold_disable(pdev);
-#endif
-
 	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
 		xhci_pme_quirk(hcd);
 
-- 
2.43.0


