Return-Path: <linux-pci+bounces-42795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C366CAE146
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF2033099632
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB52BEC4E;
	Mon,  8 Dec 2025 19:25:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408C2E88BB;
	Mon,  8 Dec 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221911; cv=none; b=EiyR7Zx3mxEVbk99vjzNjiUYSkpL8hRVFsC6OuPaKLV9eJ8BHbgc6OfHa3JfFm1dJ55JrPppjpqK4MYMUovkyITbbDmu5weQrtUhP9twa4kHEUAbWx44B7DcQwnCrdjVY4W+GaUsHq7fdOXcIM9B39f0mfoA3T/vQLMMIm9kbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221911; c=relaxed/simple;
	bh=A7rhyweEANoZyBE0VCRB3HMAzeXBlRYycsyoZS893iA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FGftCz8XJ/Hk2wa27KkFsHT/0GVaSm42c3ZjIY7QFcD6SiUTseXsb6SnG7+w9LBKiyWGgaSS4/h1sIBgDbRJi+qYp3u3kxAlQKCCAlKs7GJ6T/c8fq/DbdYJxS95cKURrLiVEkGJTr0mRMvys8wq3qQAvhLBpFr2lWP4Z/Zv8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0830392009D; Mon,  8 Dec 2025 20:25:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 00F1292009B;
	Mon,  8 Dec 2025 19:25:04 +0000 (GMT)
Date: Mon, 8 Dec 2025 19:25:04 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    ALOK TIWARI <alok.a.tiwari@oracle.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, ashishk@purestorage.com, 
    msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, Jiwei <jiwei.sun.bj@qq.com>, 
    guojinhui.liam@bytedance.com, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] : [PATCH] PCI: Always lift 2.5GT/s restriction in
 PCIe failed link retraining
In-Reply-To: <alpine.DEB.2.21.2512031836150.49654@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2512080114150.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk> <3be03057-2a83-46e5-b120-bb041208c694@oracle.com> <b92ab615-75f6-8606-cb3b-75fe03a1d9a9@linux.intel.com> <alpine.DEB.2.21.2512031836150.49654@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Dec 2025, Maciej W. Rozycki wrote:

>  Since I'm going to wait for further feedback and respin anyway, I will 
> check if there are critical dependencies required that are missing on the 
> stable branches and list any along with the backport request.  Then any 
> remaining syntactic sugar can, as you say, be handled on a case by case 
> basis in the backport process.

 I've gone through the relevant active stable branches and there's no fix 
required to be additionally backported to either 6.6 or 6.12.  There are 
only mechanical updates needed, which I've included in the change below, 
and which works for me with 6.12.  Also nothing extra is needed for 6.17 
as the code is the same as in the trunk.

  Maciej
---
 drivers/pci/quirks.c |   53 ++++++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -68,11 +68,10 @@
  * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
  * request a retrain and check the result.
  *
- * If this turns out successful and we know by the Vendor:Device ID it is
- * safe to do so, then lift the restriction, letting the devices negotiate
- * a higher speed.  Also check for a similar 2.5GT/s speed restriction the
- * firmware may have already arranged and lift it with ports that already
- * report their data link being up.
+ * If this turns out successful, or where a 2.5GT/s speed restriction has
+ * been previously arranged by the firmware and the port reports its link
+ * already being up, lift the restriction, in a hope it is safe to do so,
+ * letting the devices negotiate a higher speed.
  *
  * Otherwise revert the speed to the original setting and request a retrain
  * again to remove any residual state, ignoring the result as it's supposed
@@ -83,23 +82,19 @@
  */
 int pcie_failed_link_retrain(struct pci_dev *dev)
 {
-	static const struct pci_device_id ids[] = {
-		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
-		{}
-	};
-	u16 lnksta, lnkctl2;
+	u16 lnksta, lnkctl2, oldlnkctl2;
 	int ret = -ENOTTY;
+	u32 lnkcap;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
 		return ret;
 
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
+	lnkctl2 = oldlnkctl2;
 	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
 	    PCI_EXP_LNKSTA_LBMS) {
-		u16 oldlnkctl2 = lnkctl2;
-
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
@@ -107,36 +102,30 @@ int pcie_failed_link_retrain(struct pci_
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
 		ret = pcie_retrain_link(dev, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
-						   oldlnkctl2);
-			pcie_retrain_link(dev, true);
-			return ret;
-		}
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if (ret)
+			goto err;
 	}
 
-	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    pci_match_id(ids, dev)) {
-		u32 lnkcap;
-
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
+	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
 		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
 		ret = pcie_retrain_link(dev, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			return ret;
-		}
+		if (ret)
+			goto err;
 	}
 
 	return ret;
+err:
+	pci_info(dev, "retraining failed\n");
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, oldlnkctl2);
+	pcie_retrain_link(dev, true);
+	return ret;
 }
 
 static ktime_t fixup_debug_start(struct pci_dev *dev,

