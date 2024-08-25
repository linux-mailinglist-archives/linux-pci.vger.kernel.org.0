Return-Path: <linux-pci+bounces-12176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B90A95E3A6
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3809F1F217AE
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B8816C69F;
	Sun, 25 Aug 2024 13:47:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830E155727;
	Sun, 25 Aug 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593667; cv=none; b=bjQzglQ1SzuS/C1GMz0Ivpza94GQ64S9JKXTfvxbOFlmH+cB9FqxnRsvv/NC0mQnwXUIyl0R0A0crYsLvKPCx5xC2t2IWGKwgxiRoOh9NT+AZ+XZ5FENuUtK4aAePraGu/UKZoWkDG+DcHMguasx8f/votazN/XhHtmfK8yW6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593667; c=relaxed/simple;
	bh=bIzM3uWDDV2Xj7QItaFOLiOTUVZ6W104VSZEtoQ9mkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g49h+BJcMyqlXuveIk1xMS1Ol1pQLemiPiBUObG5U8a9NbC2fgXgD4AX1fZMM1TRBhtOVOPrNa1KmYKIbe4kdAvKFiC2Gw3iKa8hnQjcfW6wdkDEhA/PGtSNKtQJK4lti5sJaMs0K5M5EqnA81pVkoxN2HG/APnEKqK3JhpwNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2453892009D; Sun, 25 Aug 2024 15:47:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1F1D792009B;
	Sun, 25 Aug 2024 14:47:45 +0100 (BST)
Date: Sun, 25 Aug 2024 14:47:45 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] PCI: Use an error code with PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2408251426310.30766@angie.orcam.me.uk>
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

Given how the call place in `pcie_wait_for_link_delay' got structured 
now, and that `pcie_retrain_link' returns a potentially useful error 
code, convert `pcie_failed_link_retrain' to return an error code rather 
than a boolean status, fixing handling at the call site mentioned.  
Update the other call site accordingly.

Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org # v6.5+
---
Changes from v2:

- Regenerate following changes to 2/4, no functional change.

Changes from v1 (superseding 2/2):

- Regenerate following changes to 3/4, no functional change.
---
 drivers/pci/pci.c    |    2 +-
 drivers/pci/pci.h    |    6 +++---
 drivers/pci/quirks.c |   20 ++++++++++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

linux-pcie-failed-link-retrain-status-int.diff
Index: linux-macro/drivers/pci/pci.c
===================================================================
--- linux-macro.orig/drivers/pci/pci.c
+++ linux-macro/drivers/pci/pci.c
@@ -1324,7 +1324,7 @@ static int pci_dev_wait(struct pci_dev *
 		if (delay > PCI_RESET_WAIT) {
 			if (retrain) {
 				retrain = false;
-				if (pcie_failed_link_retrain(bridge)) {
+				if (pcie_failed_link_retrain(bridge) == 0) {
 					delay = 1;
 					continue;
 				}
Index: linux-macro/drivers/pci/pci.h
===================================================================
--- linux-macro.orig/drivers/pci/pci.h
+++ linux-macro/drivers/pci/pci.h
@@ -606,7 +606,7 @@ void pci_acs_init(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
-bool pcie_failed_link_retrain(struct pci_dev *dev);
+int pcie_failed_link_retrain(struct pci_dev *dev);
 #else
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 					       u16 acs_flags)
@@ -621,9 +621,9 @@ static inline int pci_dev_specific_disab
 {
 	return -ENOTTY;
 }
-static inline bool pcie_failed_link_retrain(struct pci_dev *dev)
+static inline int pcie_failed_link_retrain(struct pci_dev *dev)
 {
-	return false;
+	return -ENOTTY;
 }
 #endif
 
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -78,21 +78,21 @@
  * again to remove any residual state, ignoring the result as it's supposed
  * to fail anyway.
  *
- * Return TRUE if the link has been successfully retrained.  Return FALSE
+ * Return 0 if the link has been successfully retrained.  Return an error
  * if retraining was not needed or we attempted a retrain and it failed.
  */
-bool pcie_failed_link_retrain(struct pci_dev *dev)
+int pcie_failed_link_retrain(struct pci_dev *dev)
 {
 	static const struct pci_device_id ids[] = {
 		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
 		{}
 	};
 	u16 lnksta, lnkctl2;
-	bool ret = false;
+	int ret = -ENOTTY;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
-		return false;
+		return ret;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
@@ -106,13 +106,13 @@ bool pcie_failed_link_retrain(struct pci
 		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		ret = pcie_retrain_link(dev, false) == 0;
-		if (!ret) {
+		ret = pcie_retrain_link(dev, false);
+		if (ret) {
 			pci_info(dev, "retraining failed\n");
 			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
 						   oldlnkctl2);
 			pcie_retrain_link(dev, true);
-			return false;
+			return ret;
 		}
 
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
@@ -129,10 +129,10 @@ bool pcie_failed_link_retrain(struct pci
 		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		ret = pcie_retrain_link(dev, false) == 0;
-		if (!ret) {
+		ret = pcie_retrain_link(dev, false);
+		if (ret) {
 			pci_info(dev, "retraining failed\n");
-			return false;
+			return ret;
 		}
 	}
 

