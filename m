Return-Path: <linux-pci+bounces-42791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2DCAE10A
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AC230210D4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5462DC320;
	Mon,  8 Dec 2025 19:24:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D282D8797;
	Mon,  8 Dec 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221878; cv=none; b=Lr1y9iELVW8PCAaqyBOP1HDdZLHVu1HPl+wftDGDM6v1ysDrIgmJ+9Ai3YBhRZogAQ9vNNirkhdmzn9WnrlpBgzGNRhrIZMNuUQDfnoF+xyh0q3rODFHzaJArYCssrX0i7FkH5ncoT3Y6IRfHCutJnNNgimSo7O8cT1qTbcmjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221878; c=relaxed/simple;
	bh=qzBomRVkdx6gOEMDtQNKxBJ5V74dgUdI3wmV3uyrbco=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iGb7u8sLVqIl/WpTLaA0hEZgSlHFGe3JoWGfV8n9QD+nptuv/02/ZAYRqO2sBfwc/DkFGFcnW00e+Q8yIr+pWI7FSeeataIpvcoeTo6kxOKPNVH6Clp459LT+oVRY9bniwF1lqRReKSYe0OZY+B1T0mRmaULPA2acpj322vxHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1D4D492009E; Mon,  8 Dec 2025 20:24:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 167B292009B;
	Mon,  8 Dec 2025 19:24:34 +0000 (GMT)
Date: Mon, 8 Dec 2025 19:24:34 +0000 (GMT)
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
Subject: [PATCH v2 2/3] PCI: Use pcie_get_speed_cap() in PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2512080348310.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Rewrite a check for the maximum link speed in the Link Capabilities 
register in terms of pcie_get_speed_cap().  No functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/pci/quirks.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

linux-pcie-failed-link-retrain-get-speed-cap.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -94,8 +94,8 @@ static bool pcie_lbms_seen(struct pci_de
 int pcie_failed_link_retrain(struct pci_dev *dev)
 {
 	u16 lnksta, lnkctl2, oldlnkctl2;
+	enum pci_bus_speed speed_cap;
 	int ret = -ENOTTY;
-	u32 lnkcap;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
@@ -110,12 +110,12 @@ int pcie_failed_link_retrain(struct pci_
 			goto err;
 	}
 
+	speed_cap = pcie_get_speed_cap(dev);
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+	    speed_cap > PCIE_SPEED_2_5GT) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
+		ret = pcie_set_target_speed(dev, speed_cap, false);
 		if (ret)
 			goto err;
 	}

