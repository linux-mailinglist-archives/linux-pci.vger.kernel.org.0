Return-Path: <linux-pci+bounces-12175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E4895E3A4
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339401C20CF3
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17D1537A4;
	Sun, 25 Aug 2024 13:47:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55507155C93;
	Sun, 25 Aug 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593663; cv=none; b=MnYWTaxzMavp7VyBBo+JO0fQOln8HvQktf536EEindU/3ebQJAHtp6LKLQFJAZg9UZsccaGZAx0hSQsqYxh4mxsCWCDQfXthENYISND2x+pKAEIDcyIVjHU5GKFTCgmQSwVJ1zV0bk99ROEdh4vaHygAkM/LztPeloapJTlEZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593663; c=relaxed/simple;
	bh=HXenWO0mvS6SJdnD9Sh0kToK3+6VoC+91twZpxSvFHg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YdouFKfSfnJSok5w2vmirg0Qadh80V4n9hD1gOFNsuYab/AWNA6xsQe15CwgIucg7SjU1Hog3aLn7QZGuj4Gv3ooF6qGYejpEBuhEUs9aPyjCsI0D4fzIgriPoZApQCjUj87FhfClirfRlAErjc9LMYB31WO07nolL/MREu97pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id F365192009D; Sun, 25 Aug 2024 15:47:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id ED6CB92009B;
	Sun, 25 Aug 2024 14:47:39 +0100 (BST)
Date: Sun, 25 Aug 2024 14:47:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] PCI: Correct error reporting with PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2408251424480.30766@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org # v6.5+
---
No changes from v2.

Changes from v1 (superseding 1/2):

- Regenerate on top of 2/4.

- Reword the comment update for clarity.

- Go back to returning explicit FALSE rather than `ret' where it is known 
  that we failed.
---
 drivers/pci/quirks.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

linux-pcie-failed-link-retrain-status-fix.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -78,7 +78,8 @@
  * again to remove any residual state, ignoring the result as it's supposed
  * to fail anyway.
  *
- * Return TRUE if the link has been successfully retrained, otherwise FALSE.
+ * Return TRUE if the link has been successfully retrained.  Return FALSE
+ * if retraining was not needed or we attempted a retrain and it failed.
  */
 bool pcie_failed_link_retrain(struct pci_dev *dev)
 {
@@ -87,6 +88,7 @@ bool pcie_failed_link_retrain(struct pci
 		{}
 	};
 	u16 lnksta, lnkctl2;
+	bool ret = false;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
@@ -104,7 +106,8 @@ bool pcie_failed_link_retrain(struct pci
 		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		if (pcie_retrain_link(dev, false)) {
+		ret = pcie_retrain_link(dev, false) == 0;
+		if (!ret) {
 			pci_info(dev, "retraining failed\n");
 			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
 						   oldlnkctl2);
@@ -126,13 +129,14 @@ bool pcie_failed_link_retrain(struct pci
 		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		if (pcie_retrain_link(dev, false)) {
+		ret = pcie_retrain_link(dev, false) == 0;
+		if (!ret) {
 			pci_info(dev, "retraining failed\n");
 			return false;
 		}
 	}
 
-	return true;
+	return ret;
 }
 
 static ktime_t fixup_debug_start(struct pci_dev *dev,

