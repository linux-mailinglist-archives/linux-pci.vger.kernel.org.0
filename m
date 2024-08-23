Return-Path: <linux-pci+bounces-12126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C803C95D207
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03F3B2BE12
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558B31922E9;
	Fri, 23 Aug 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7D5BNAk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A91922DA;
	Fri, 23 Aug 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427640; cv=none; b=HZmE4GaLqDTdzKfKDBe4Tao2Bz1a8/dYRIgO+7ATNw2C+pyvUNQ4M/1mJnBzn+DbClEUs5CUAbTqzo35/6FPnJXyBilJ3kl/jYr5V8ak8aVxIMApEkqHHmENSfoyE5eqUx2qSke+GG5IrSAVJNIa6NPzJdTRdrjqFx/27DwZHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427640; c=relaxed/simple;
	bh=JWSRlz8uRX9VxLn24AvyMy0LwzF2iYqEImctSnL1LEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1qy4/UnaqUVsbht6hcSAmfC/n0nJ9aA+BHi0oBri/qjFfgFUo/pmuvPUwRO/ITEjZ+eGbgdFSUgGj4Ar79GlGPAkXO1GsMuCicr8KeO5i+sJ8sRPXLoVzhyPoHv1/WyrNyezVvz/VqFydO+lEwfUmpvoiuiqDjQYx5pQr2q6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7D5BNAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7346C4AF09;
	Fri, 23 Aug 2024 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427639;
	bh=JWSRlz8uRX9VxLn24AvyMy0LwzF2iYqEImctSnL1LEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7D5BNAkww4RHwj1geA+tvLT1y0kMHkp6UTmal1kX5VWSAQCRQ21aS63yLPEcGnpB
	 zuI6nVHIvS3IRwPHp2qVtnY9X6z922BcFrLf5EkjJ8EF2xjHCSrLyMB8EXPaMxhb0X
	 PPRhOq8dSotJNLSJmZhbXetvdC+Dg+hli4jMzMzSHGU+68W1WI2hNFCZ8BR8925WAl
	 NMTN6QuvhwC9nR2g8+E/lEZlSuJ03TvleAUbXaiR+9eWO+jx3BUdhUvx5mVywYY1sg
	 tEHadAC7eZUqD5JER8XeWnmDinDtF0s27BQyVySSWuwifxmdblsaCOVJg2tTV+UGuN
	 pYEUwrQloI/yw==
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
Subject: [PATCH v5 4/5] PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
Date: Fri, 23 Aug 2024 10:40:22 -0500
Message-ID: <20240823154023.360234-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823154023.360234-1-superm1@kernel.org>
References: <20240823154023.360234-1-superm1@kernel.org>
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


