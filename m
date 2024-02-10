Return-Path: <linux-pci+bounces-3319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2818501D1
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 02:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04581C22EE5
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 01:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882775C99;
	Sat, 10 Feb 2024 01:44:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5F9443F;
	Sat, 10 Feb 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707529440; cv=none; b=OlSvyn8wjt16tihq5cWVRxti2vz0SYyM2DqUktN4CN5dGH6/mQvMMdpj+RfFRkJm/Xz0O/FPeQCs1loCUWEqmgO7zFF09du8k9BMf6Zo//y7+iMWh88hUpCqXavgg8wX5McqdLL/4j+onCE77F7R5GTPCuTqrrjAaAwXR10hy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707529440; c=relaxed/simple;
	bh=ypgalr47NyKd3kk8vG+pac3NhdZUcsYOC4TTXs6GuPM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tLFlZBap3/HhVOexYwLZzu8czqJuoXA4ljCGztuhSn4A7ty8uE+bbQV5gphYsfhSp/KXvMLjvcKs1wBLN13dG5Xu5m94ypTjh3Y+Tsy6mPrM/djGKluRhKrWZA3yMGDc7KhE4w2IcE97oz3bYB2P8ilHMTq6PtlE8awxQvonEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7C32392009D; Sat, 10 Feb 2024 02:43:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7524092009B;
	Sat, 10 Feb 2024 01:43:50 +0000 (GMT)
Date: Sat, 10 Feb 2024 01:43:50 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: Correct error reporting with PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Only return successful completion status from `pcie_failed_link_retrain' 
if retraining has actually been done, preventing excessive delays from 
being triggered at call sites in a hope that communication will finally 
be established with the downstream device where in fact nothing has been 
done about the link in question that would justify such a hope.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v6.5+
---
 drivers/pci/quirks.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

linux-pcie-failed-link-retrain-status-fix.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -74,7 +74,8 @@
  * firmware may have already arranged and lift it with ports that already
  * report their data link being up.
  *
- * Return TRUE if the link has been successfully retrained, otherwise FALSE.
+ * Return TRUE if the link has been successfully retrained, otherwise FALSE,
+ * also when retraining was not needed in the first place.
  */
 bool pcie_failed_link_retrain(struct pci_dev *dev)
 {
@@ -83,10 +84,11 @@ bool pcie_failed_link_retrain(struct pci
 		{}
 	};
 	u16 lnksta, lnkctl2;
+	bool ret = false;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
-		return false;
+		return ret;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
@@ -98,9 +100,10 @@ bool pcie_failed_link_retrain(struct pci
 		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		if (pcie_retrain_link(dev, false)) {
+		ret = pcie_retrain_link(dev, false) == 0;
+		if (!ret) {
 			pci_info(dev, "retraining failed\n");
-			return false;
+			return ret;
 		}
 
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
@@ -117,13 +120,14 @@ bool pcie_failed_link_retrain(struct pci
 		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		if (pcie_retrain_link(dev, false)) {
+		ret = pcie_retrain_link(dev, false) == 0;
+		if (!ret) {
 			pci_info(dev, "retraining failed\n");
-			return false;
+			return ret;
 		}
 	}
 
-	return true;
+	return ret;
 }
 
 static ktime_t fixup_debug_start(struct pci_dev *dev,

