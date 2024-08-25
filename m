Return-Path: <linux-pci+bounces-12173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF795E3A0
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 15:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990E2B21469
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D082E1537A4;
	Sun, 25 Aug 2024 13:47:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896C13F458;
	Sun, 25 Aug 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593653; cv=none; b=t/L/0aMMMsPlznpiUca8jy9txAfDmtzoTnOZPmMed3/mahzecglI1seHnLH7n9GEM9dv9jM9oo2nHfrSnM4R1Tz0DRqi+l+5x8niBcONfjjpVlWjdrJsSk3pv4YiANTaAfWhG0krIKxlk+VGow/XidLh1e28rmuzrfu3RpCnz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593653; c=relaxed/simple;
	bh=mYwbke1zdDrcretydAP2RY06U0kSmkFoCcERsWUTMVo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZtuqCrsw60WDujl1VGgx6rCfs8FDkPxBGzFhNzpdl8+gFzzjqGtAX1NiSNTDcyYZB43tZ5z8yhoBy+4yY/j8Ek68xDXuNqNaHxXNEpGRDGwq5nlum0exE2vE7FnerT6Sjmh9K+6dkeDflo//lXksJOeeiFi+UCsybC636bqdD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 667A892009C; Sun, 25 Aug 2024 15:47:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6475D92009B;
	Sun, 25 Aug 2024 14:47:29 +0100 (BST)
Date: Sun, 25 Aug 2024 14:47:29 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] PCI: Clear the LBMS bit after a link retrain
In-Reply-To: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2408251408160.30766@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
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
No change from v2.

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

