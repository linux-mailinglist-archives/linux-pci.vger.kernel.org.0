Return-Path: <linux-pci+bounces-11533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96FF94D129
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B615B23327
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D2D195FE3;
	Fri,  9 Aug 2024 13:24:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9A195F0D;
	Fri,  9 Aug 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209890; cv=none; b=a0qTYWDyiYtyxamgOx+xPpcp8Af5Irb7BDHuDBdyds5qocXWpEcn+8cPl6TD61pH4JOCwTqaZcdwTEQFXC74KCCfye2YDdlcHOckolaSx8yzwqYQv4rsnHV5etz8PWHs2vvsg6rfIyCXTgNhHCr2K0xoudWAA1nMcHbUh+CbHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209890; c=relaxed/simple;
	bh=Sce8NZSG+ZRrji36seXJJlUurv4MBemLC4XmM0+abh0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yrj3Jf6+isqlg5j7jxbG7oicu+J6BVfOmTKXV6fEm6Mqm+dOKclKR60A3c3Wj1KRJ3CBbY0X+Sbjc7FTSR65hG3P4NpV/0NHiRaZXIHA8xp2PuliU1z3yYwzWhkbTlNX+bKrv992ll0tBDlKLnQrf0h880oLENh0+VxwOrm8ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 94E4E92009E; Fri,  9 Aug 2024 15:24:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8F3D392009D;
	Fri,  9 Aug 2024 14:24:46 +0100 (BST)
Date: Fri, 9 Aug 2024 14:24:46 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: Clear the LBMS bit after a link retrain
In-Reply-To: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2408091133140.61955@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

The LBMS bit, where implemented, is set by hardware either in response 
to the completion of retraining caused by writing 1 to the Retrain Link 
bit or whenever hardware has changed the link speed or width in attempt 
to correct unreliable link operation.  It is never cleared by hardware 
other than by software writing 1 to the bit position in the Link Status 
register and we never do such a write.

We currently have two places, namely `apply_bad_link_workaround' and 
`pcie_failed_link_retrain' in drivers/pci/controller/dwc/pcie-tegra194.c 
and drivers/pci/quirks.c respectively where we check the state of the 
LBMS bit and neither is interested in the state of the bit resulting 
from the completion of retraining, both check for a link fault.

And in particular `pcie_failed_link_retrain' causes issues consequently, 
by trying to retrain a link where there's no downstream device anymore 
and the state of 1 in the LBMS bit has been retained from when there was 
a device downstream that has since been removed.

Clear the LBMS bit then at the conclusion of `pcie_retrain_link', so 
that we have a single place that controls it and that our code can track 
link speed or width changes resulting from unreliable link operation.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Reported-by: Matthew W Carlis <mattc@purestorage.com>
Link: https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.com/
Link: https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v6.5+
---
New change in v2.
---
 drivers/pci/pci.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

linux-pcie-retrain-link-lbms-clear.diff
Index: linux-macro/drivers/pci/pci.c
===================================================================
--- linux-macro.orig/drivers/pci/pci.c
+++ linux-macro/drivers/pci/pci.c
@@ -4718,7 +4718,15 @@ int pcie_retrain_link(struct pci_dev *pd
 		pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
 	}
 
-	return pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+
+	/*
+	 * Clear LBMS after a manual retrain so that the bit can be used
+	 * to track link speed or width changes made by hardware itself
+	 * in attempt to correct unreliable link operation.
+	 */
+	pcie_capability_write_word(pdev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
+	return rc;
 }
 
 /**

