Return-Path: <linux-pci+bounces-20156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF15A16EF9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 16:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 791C87A04B7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 15:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1F1E47BC;
	Mon, 20 Jan 2025 15:05:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097481E47C2;
	Mon, 20 Jan 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385509; cv=none; b=tgxnt7E2Rv0mP+d10N2lfcTBLyBTHOE7aLTgdOr9bs+1PWdWSs9kEgjgwE8uXSxXs0oRE9AdyXTtjdwMxNxkHO1Tn1SUBX2ZH5SiHXHSIUKM49TiCEe1iXObblB1Xec1aW57CciaOd0NjwKA0rBNNd4dvOLyM4Bo6UETF9qGrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385509; c=relaxed/simple;
	bh=KjPZMACyuIQpSIAFdsh2F0+xtwjhko25HdTmvvn59TY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VyUZQIvCpVjAeWHW+1ZwlryQ4DBQamURPVDEtbU9m8+xXAUhE3YOD6cGSNZdEkIQDUHeqXumEm7hzoDVzAODP0lHw5xbyw5PWtJaraxFP6I9d5VzBQoqQbL3gvZ0gPoYzqk2upg60Roi96tUkHZunMmtgCusDX9URlOcFEvulBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3C24C92009C; Mon, 20 Jan 2025 16:05:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 36F5892009B;
	Mon, 20 Jan 2025 15:05:05 +0000 (GMT)
Date: Mon, 20 Jan 2025 15:05:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jiwei <jiwei.sun.bj@qq.com>
cc: Jiwei Sun <sjiwei@163.com>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, helgaas@kernel.org, 
    Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    sunjw10@outlook.com
Subject: Re: [PATCH v2 2/2] PCI: reread the Link Control 2 Register before
 using
In-Reply-To: <tencent_DBC0851ABE9B45D70B4BA098F876F5F10609@qq.com>
Message-ID: <alpine.DEB.2.21.2501201441590.27432@angie.orcam.me.uk>
References: <20250115134154.9220-1-sjiwei@163.com> <20250115134154.9220-3-sjiwei@163.com> <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com> <417720e7-c793-4c36-a542-a7e937e5a3cf@163.com> <alpine.DEB.2.21.2501180101360.27432@angie.orcam.me.uk>
 <tencent_DBC0851ABE9B45D70B4BA098F876F5F10609@qq.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Jan 2025, Jiwei wrote:

> >> However, within this section of code, lnkctl2 is not modified (after 
> >> reading from register on line 111) at all and remains 0x5. This results 
> >> in the condition on line 130 evaluating to 0 (false), which in turn 
> >> prevents the code from line 132 onward from being executed. The removing
> >> 2.5GT/s downstream link speed restriction work can not be done.
> > 
> >  It seems like a regression from my original code indeed.
> 
> Sorry, I am confused by this sentence.

 Sorry to be unclear, it refers to the paragraph quoted.

> IIUC, there is no regression regarding the lifting 2.5GT/s restriction in
> the commit a89c82249c37 ("PCI: Work around PCIe link training failures").

 That's my original code we have regressed from.

> However, since commit de9a6c8d5dbf ("PCI/bwctrl: Add 
> pcie_set_target_speed() to set PCIe Link Speed"), the code to lift the 
> restriction is no longer executed. Therefore, commit de9a6c8d5dbf 
> ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed") can be
> considered a regression of commit a a89c82249c37 ("PCI: Work around PCIe
> link training failures").

 Yes, that accurately reflects the intent of what I wrote above.

> So, this fix patch(PCI: reread the Link Control 2 Register before using) 
> is required, right?

 Original code just fiddled with `lnkctl2' already retrieved.  With that 
replaced by a call to `pcie_set_target_speed' I think rereading from Link 
Control 2 is probably the best fix, however I'd suggest to clean up all 
the leftovers from old code on this occasion, along the lines of the diff 
below (untested).

  Maciej

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 76f4df75b08a..84267d7f847d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -108,13 +108,13 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
 		return ret;
 
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
-		u16 oldlnkctl2 = lnkctl2;
+		u16 oldlnkctl2;
 
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 		if (ret) {
 			pci_info(dev, "retraining failed\n");
@@ -126,6 +126,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	}
 
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
 	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
 	    pci_match_id(ids, dev)) {

