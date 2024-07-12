Return-Path: <linux-pci+bounces-10216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E37930054
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABB31C20B33
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52617DA20;
	Fri, 12 Jul 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwErQmZk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F417D373;
	Fri, 12 Jul 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807977; cv=none; b=AILqG2Aoc4s4LfEBbCwolFFVEv3QaiMlCILgQAcKt7KLXrGpBOKxzWMJmnFAiop3KmQJ/DRM5RWTxtY8XyNfqvMPzKux5m5WohlSeexwSa4n3UJcqTSOGRSzEjvRfvV46gDbC+pM5QX+lPYmVQBwcRJUcFLl5PzX3/rAsu5pbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807977; c=relaxed/simple;
	bh=OW3Vxq0AOIhs0nIM51oiQFN+ssUmHJ7uh7zPe/sF3Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frsVRCIikVN6RgL0SCyAcp/q0OiH40/OnaeEg954OwyEpax+ezMoevqoULxRn8LUFr4eLBgUrM8IafSEg3sjM/2M+btAP31a/fBqFMU/9SYQp07rePwsuUFJy7XTK2MkksExTcWOErRAX9Z27ViaIaxrWTY8b5JC0cBzG3Jd8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwErQmZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE7C4AF16;
	Fri, 12 Jul 2024 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807976;
	bh=OW3Vxq0AOIhs0nIM51oiQFN+ssUmHJ7uh7zPe/sF3Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwErQmZkd/Ll6aC+yt9yfpzMQIEUW8BuJ+TBjPXV7/mxsa8lY9qJrATEp8VMJFCrZ
	 t+QVYLVT+JcdA9pygxRY7SfHscCxP5WoFxQtQ4CaCs2WILFlZ3kcbqw35CUuWwSosF
	 KMAaIuxmMRbPHEcQu/rqdfXQwjFt0KOkaB+IJNG4JhQeqd1yyXH+YRubETzzixH5vl
	 7EeMrc7MBJe5Wo0hkEUNFNgkpdOIpxXlKk43zyxwCXtWxdUkMglPKjlOHmrqPBM7UE
	 xklKyMRrsYATk5gG1dc8C3CIVkkLf+95CINYKB9DSVa53Xw02bjhMpqcVRNIrWXkuW
	 5aYDXclNFCb5w==
From: superm1@kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 4/5] PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
Date: Fri, 12 Jul 2024 13:12:45 -0500
Message-ID: <20240712181246.811044-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712181246.811044-1-superm1@kernel.org>
References: <20240712181246.811044-1-superm1@kernel.org>
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
index 568410e64ce64..942d0fe12cb1a 100644
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
index 05881153883ec..8eb7abf6be1ac 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -315,10 +315,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		(pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_1)))
 		xhci->quirks |= XHCI_U2_DISABLE_WAKE;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
-		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_XHCI)
-		xhci->quirks |= XHCI_BROKEN_D3COLD_S2I;
-
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 		xhci->quirks |= XHCI_INTEL_HOST;
@@ -750,13 +746,6 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
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


