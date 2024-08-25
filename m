Return-Path: <linux-pci+bounces-12174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB6395E3A2
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C51E1C20B60
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9515573C;
	Sun, 25 Aug 2024 13:47:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531DB156F5D;
	Sun, 25 Aug 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593657; cv=none; b=VkIxFPMcoejQG+2PRwu9j0WVPSkLeh/uUekIvRMFpbyVZdXL3XRoJvJEm3RyifOpZWVSssYnaCm1nwnuQgH4ENy534Vs3OYloUNpcEyL9i8+tP1WcJUBOoYzspGcv0Kp3qoRMYhVc2H/d75GPVgt31Ob9oIsDPlh4j7hqSDM6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593657; c=relaxed/simple;
	bh=43V8fSOAt4n23KEKHNBs62n3AClRL2dxS4yXIf/NKUk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DKvxv5IHgqOUAWcIDpgWa6RUEElERJTptXnHlvkGqvFxwbsDQwNtc9v8KrvlqdW+Q5rVlzjevgGNspSN5uJLTANNjdA8/s750iqdcyo4lqULP9EqBPMrmOoPzgHTHBvCZaFa7R4+QEaaLy+7N9hDXKsYB1Pl9AgkqXoKJs+nzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 317FC92009C; Sun, 25 Aug 2024 15:47:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2E05D92009B;
	Sun, 25 Aug 2024 14:47:34 +0100 (BST)
Date: Sun, 25 Aug 2024 14:47:34 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] PCI: Revert to the original speed after PCIe failed
 link retraining
In-Reply-To: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2408251412590.30766@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

When `pcie_failed_link_retrain' has failed to retrain the link by hand 
it leaves the link speed restricted to 2.5GT/s, which will then affect 
any device that has been plugged in later on, which may not suffer from 
the problem that caused the speed restriction to have been attempted.  
Consequently such a downstream device will suffer from an unnecessary 
communication throughput limitation and therefore performance loss.

Remove the speed restriction then and revert the Link Control 2 register 
to its original state if link retraining with the speed restriction in 
place has failed.  Retrain the link again afterwards so as to remove any 
residual state, waiting on LT rather than DLLLA to avoid an excessive 
delay and ignoring the result as this training is supposed to fail anyway.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Reported-by: Matthew W Carlis <mattc@purestorage.com>
Link: https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.com/
Link: https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v6.5+
---
Changes from v2:

- Wait on LT rather than DLLLA with clean-up retraining with the speed 
  restriction lifted, so as to avoid an excessive delay as it's supposed 
  to fail anyway.

New change in v2.
---
 drivers/pci/quirks.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

linux-pcie-failed-link-retrain-fail-unclamp.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -66,7 +66,7 @@
  * apply this erratum workaround to any downstream ports as long as they
  * support Link Active reporting and have the Link Control 2 register.
  * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
- * request a retrain and wait 200ms for the data link to go up.
+ * request a retrain and check the result.
  *
  * If this turns out successful and we know by the Vendor:Device ID it is
  * safe to do so, then lift the restriction, letting the devices negotiate
@@ -74,6 +74,10 @@
  * firmware may have already arranged and lift it with ports that already
  * report their data link being up.
  *
+ * Otherwise revert the speed to the original setting and request a retrain
+ * again to remove any residual state, ignoring the result as it's supposed
+ * to fail anyway.
+ *
  * Return TRUE if the link has been successfully retrained, otherwise FALSE.
  */
 bool pcie_failed_link_retrain(struct pci_dev *dev)
@@ -92,6 +96,8 @@ bool pcie_failed_link_retrain(struct pci
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
 	    PCI_EXP_LNKSTA_LBMS) {
+		u16 oldlnkctl2 = lnkctl2;
+
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
@@ -100,6 +106,9 @@ bool pcie_failed_link_retrain(struct pci
 
 		if (pcie_retrain_link(dev, false)) {
 			pci_info(dev, "retraining failed\n");
+			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
+						   oldlnkctl2);
+			pcie_retrain_link(dev, true);
 			return false;
 		}
 

