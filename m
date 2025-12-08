Return-Path: <linux-pci+bounces-42792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCCECAE119
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B7E30AC661
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E52E7621;
	Mon,  8 Dec 2025 19:24:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572012E54A1;
	Mon,  8 Dec 2025 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221879; cv=none; b=boBAyGXoonqWkqfcPXUP3q2CXrycOLJx9BXYWKb7BqoiH65phKAn8bqqUAC2SKDLXJ0uRjTI18FkiEG00dUgcoAn5BvtCMnhcmRrn62r25VsnZC5f/3fcvaoolsPlIxbeQA1JEQVvQnyMm+z480LBs4BL0fAk0ZcUmCoJtOUxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221879; c=relaxed/simple;
	bh=6IjfMBTJWFmGSjstibRxrG5M6HEjKOTigduvz8gde1g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FntAuP3dGAcGpUnQAt0kW/xPUN4nsW8vU9ah3Bk0yM28U0bd9EhgLqI4YpVDsNq9OvIsgdGj80hav+ETAjA2+K/2+6MmOfiVsyWDi8FGdwMWxBpN1ycg3pqr4IF6Oovy4ta8JcEex8DXJBOfd3Su6I0b6bnt0c2lbzmABSPmCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 537F692009D; Mon,  8 Dec 2025 20:24:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4CDCF92009B;
	Mon,  8 Dec 2025 19:24:29 +0000 (GMT)
Date: Mon, 8 Dec 2025 19:24:29 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    ALOK TIWARI <alok.a.tiwari@oracle.com>
cc: ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com, 
    ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: Always lift 2.5GT/s restriction in PCIe failed
 link retraining
In-Reply-To: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2512080331530.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Discard Vendor:Device ID matching in the PCIe failed link retraining 
quirk and ignore the link status for the removal of the 2.5GT/s speed 
clamp, whether applied by the quirk itself or the firmware earlier on.  
Revert to the original target link speed if this final link retraining 
has failed.

This is so that link training noise in hot-plug scenarios does not make 
a link remain clamped to the 2.5GT/s speed where an event race has led 
the quirk to apply the speed clamp for one device, only to leave it in 
place for a subsequent device to be plugged in.

Refer to the Link Capabilities register directly for the maximum link 
speed determination so as to streamline backporting.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Tested-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: <stable@vger.kernel.org> # v6.5+
---
Changes from v1:

- Remove a leftover empty line (out of an overlong line confusion).

- Justify the choice to use the Link Capabilities register.
---
 drivers/pci/quirks.c |   51 ++++++++++++++++++---------------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

linux-pcie-failed-link-retrain-unclamp-always.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -79,11 +79,10 @@ static bool pcie_lbms_seen(struct pci_de
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
@@ -94,52 +93,38 @@ static bool pcie_lbms_seen(struct pci_de
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
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
-		u16 oldlnkctl2;
-
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
-					      true);
-			return ret;
-		}
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if (ret)
+			goto err;
 	}
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
-
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
 		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
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
+	pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2), true);
+	return ret;
 }
 
 static ktime_t fixup_debug_start(struct pci_dev *dev,

