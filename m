Return-Path: <linux-pci+bounces-11534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B7E94D12B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA2C2835B6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375F194C93;
	Fri,  9 Aug 2024 13:24:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE1A194C7A;
	Fri,  9 Aug 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209894; cv=none; b=Ov3JAq3LG04cYIRtUoIzk5qPKnU4mLENKscQyUxO57t8LtoFRVAJ2rTFcqUPx2OrL1P+Ka9jDBTZBKIHZR2h8kM26Z85J3o161wjN0Dh5wlX374tqieyxtOkJqHtxRzRCOkh+VcrR/PkGY+FSsxncbpnwX9yAQdCtBaPahXTLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209894; c=relaxed/simple;
	bh=u6rCZzVYDmS1EgHib/U42ns/paYCkHwdsSBnS1g3Z0A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZAEQvJZlHiB9ltbExxVLMiJKpOy+N7cDSFBChHlgwlCz0MjI5iCV4skEaebYtQhD8VPDDNqGnlmfKEgkTYLFhEMrgV+ec2xEz3JUqbvRDHawCFaeEBk+b4nUM7cHQbYEZkH7CfmTp5JNFntpxzAI8TawbaDbDGgRvgNugyZQ9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6822B92009E; Fri,  9 Aug 2024 15:24:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 624FA92009D;
	Fri,  9 Aug 2024 14:24:51 +0100 (BST)
Date: Fri, 9 Aug 2024 14:24:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] PCI: Revert to the original speed after PCIe failed
 link retraining
In-Reply-To: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2408091204580.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk>
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
place has failed.  Retrain the link again afterwards to remove any 
residual state, ignoring the result as it's supposed to fail anyway.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Reported-by: Matthew W Carlis <mattc@purestorage.com>
Link: https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.com/
Link: https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v6.5+
---
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
+			pcie_retrain_link(dev, false);
 			return false;
 		}
 

