Return-Path: <linux-pci+bounces-42793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81670CAE128
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C3CB30C1B58
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC832E7F3F;
	Mon,  8 Dec 2025 19:24:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E62EA14E;
	Mon,  8 Dec 2025 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221882; cv=none; b=XE5SkGo5sra5/Dou4tOjQtl+LbDlpuuQkDrOHhQgtK7oRSkKP2V0cA4K78ZDwgNshuJpKBposfllbF2PxraZ1BY9+ls4JbBX56bf3KxiMfe6ZVNIsPedPQTX/57k/iiF9E3KwqyrdPeajCh7wiWe3eoYQJ/WV9bHPHgkJSrrEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221882; c=relaxed/simple;
	bh=pJIeVypI8WC4BYC5AAD07Xo2jqPRBE7f4h5QeAIO8tY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xza7it17WdtmM297nRQM21f+ScncsdrECKSzNp4rlrsCvGT5Ugp7hUlwDq3tVmNpi4Qf15stURXNZn7fVXnghjnjJ/q/aKw1iLY8CpP8P6wzwNyyAL9+UaLi9HHoSBWwn8NQRszhn72MWJ0pEB3fIyXvhQ0k+EVSqxzRPSDNfj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id F15E29200B4; Mon,  8 Dec 2025 20:24:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EBC1B9200B3;
	Mon,  8 Dec 2025 19:24:38 +0000 (GMT)
Date: Mon, 8 Dec 2025 19:24:38 +0000 (GMT)
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
Subject: [PATCH v2 3/3] PCI: Bail out early for 2.5GT/s devices in PCIe failed
 link retraining
In-Reply-To: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2512080356070.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

There's no point in retraining a failed 2.5GT/s device at 2.5GT/s, so 
just don't and return early.  While such devices might be unlikely to 
implement Link Active reporting, we need to retrieve the maximum link 
speed and use it in a conditional later on anyway, so the early check 
comes for free.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/pci/quirks.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

linux-pcie-failed-link-retrain-speed-cap-early.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -101,6 +101,10 @@ int pcie_failed_link_retrain(struct pci_
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
 		return ret;
 
+	speed_cap = pcie_get_speed_cap(dev);
+	if (speed_cap <= PCIE_SPEED_2_5GT)
+		return ret;
+
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
@@ -110,10 +114,8 @@ int pcie_failed_link_retrain(struct pci_
 			goto err;
 	}
 
-	speed_cap = pcie_get_speed_cap(dev);
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
-	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    speed_cap > PCIE_SPEED_2_5GT) {
+	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
 		ret = pcie_set_target_speed(dev, speed_cap, false);
 		if (ret)

