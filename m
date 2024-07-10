Return-Path: <linux-pci+bounces-10105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E3992DA76
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E92284C3C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B31991AC;
	Wed, 10 Jul 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8GgV4WG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF521990DE;
	Wed, 10 Jul 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645130; cv=none; b=Xm/VfmGRxaRf6T+U49F6OLqDSZ1VXboNnJlMxeudTzGHwTpUuNiqE5p5OZUf6Of00Eq5S06z5ORg4+V3phlPWVZYMu5XRybZxKGBoMxKt/aV7KV0Pu64meBLFJkvdywyj3kaanxXlIcNwlDOUnqSPG16lYH1jxhMBGQ73r2YcCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645130; c=relaxed/simple;
	bh=XkyMbsI6TVShd93USRG6pyg6b357zF8DKYVQEt0c2Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv4nIy5htB2Fs8Uh1RnQvQnWKdQGO3MzNHwWGKbyeMFpE87F/uz/I2+NP0ZBkRNYIvU7ygcVgMWm2imUG4pzaBD5gRFPGG+Ewd9z2NeqEAyDQ86FJ8hwpPwqvTn0vTDYDELUNZ2dsZter+tB+FW8RHXES0fhEnQX5Mq1LbyFovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8GgV4WG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F68FC32781;
	Wed, 10 Jul 2024 20:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720645130;
	bh=XkyMbsI6TVShd93USRG6pyg6b357zF8DKYVQEt0c2Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8GgV4WG96JgK0PhhmJFp/U0GkQtLyOsnP0ZMpA31/8j5tp+klw5pD45ZAcCcfq6l
	 UsYonROQGU7Hy6RPaZ/LvdjDXAt5q1XjSwJxErXG6dPChp3Wyoeyi6JqnlsT6x2fZa
	 wIZzabFQKIIlNHqUY7/tysN+rCIFZvSF2b8619L9dEXehQPIqRs1hCLgTVHGmAo0H1
	 GvfUpGmhZTbVrgIfdrAu702IuFVkfmvV9tKCWkQYpT8Z0yfDWYjQLyJb1JN2vieSNW
	 lwgvQi5CgTkgs2o5DLXRILtj5/KW3eNkdwzwggWPLZjuc2W3MwMftHV1DUcPQWEvO3
	 4SGeP3AfvNhxA==
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
Subject: [PATCH v2 3/4] PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
Date: Wed, 10 Jul 2024 15:58:37 -0500
Message-ID: <20240710205838.2413465-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710205838.2413465-1-superm1@kernel.org>
References: <20240710205838.2413465-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

As the PCI core now waits for D0 after D3cold exit, the Ryzen XHCI
controllers that were quirked to not use D3cold and to add a delay
on D3hot no longer need these quirks.

Drop both the PCI and XHCI sets of quirks.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/quirks.c        | 17 -----------------
 drivers/usb/host/xhci-pci.c | 11 -----------
 drivers/usb/host/xhci.h     | 11 +++++------
 3 files changed, 5 insertions(+), 34 deletions(-)

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
index 018f242d09104..1c3c8378e6ddb 100644
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
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 78d014c4d884a..137955311313a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1622,12 +1622,11 @@ struct xhci_hcd {
 #define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD_S2I	BIT_ULL(41)
-#define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
-#define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
-#define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
-#define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
+#define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(41)
+#define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(42)
+#define XHCI_RESET_TO_DEFAULT	BIT_ULL(43)
+#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(44)
+#define XHCI_ZHAOXIN_HOST	BIT_ULL(45)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.43.0


