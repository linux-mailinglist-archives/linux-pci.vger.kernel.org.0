Return-Path: <linux-pci+bounces-12177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518D95E3AC
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3D4B21DBF
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6631537A4;
	Sun, 25 Aug 2024 13:48:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D9329CEF;
	Sun, 25 Aug 2024 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593725; cv=none; b=PuCqT3eHscU9VKhnA7mlcrar71fYbJhCGj2My0O6JKvLZaM9pRr1A4Um4Q5UmhWJdjDh7bTKLfwq57099UsDBnpuQKkUjTWiwCxywVhuGuTVgWGFKw/qb+kB15eitno8G8vAvjJi7EJS/TOseTWoc3l/dG1QAov8KArhgGo9+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593725; c=relaxed/simple;
	bh=Uga7DlG+kesjDq58lDmqPjtykncu8meM1Bl0Qx8vBE4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BZKXdqdL+BRLlucC70eInVUFQ2wJ3uamgz12cQ+LL6rDh6emBHwei/ihCRiTWHONRVlVzi1zQf7L1SNghbLMXhqOmSqGmCleRi82DeEOsJGhPdtcUEIWPpcmeGTv1vwJaS0dSoUknUPGs0do7CtXRrbrMdfs+L6cgMVPYodfA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 691FB92009E; Sun, 25 Aug 2024 15:48:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6363792009B;
	Sun, 25 Aug 2024 14:48:42 +0100 (BST)
Date: Sun, 25 Aug 2024 14:48:42 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: Revert to the original speed after PCIe
 failed link retraining
In-Reply-To: <58809d75-34c1-fc4f-3884-76301a8b5976@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2408250151050.30766@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk> <alpine.DEB.2.21.2408091204580.61955@angie.orcam.me.uk> <58809d75-34c1-fc4f-3884-76301a8b5976@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 22 Aug 2024, Ilpo Järvinen wrote:

> > linux-pcie-failed-link-retrain-fail-unclamp.diff
> > Index: linux-macro/drivers/pci/quirks.c
> > ===================================================================
> > --- linux-macro.orig/drivers/pci/quirks.c
> > +++ linux-macro/drivers/pci/quirks.c
> > @@ -100,6 +106,9 @@ bool pcie_failed_link_retrain(struct pci
> >  
> >  		if (pcie_retrain_link(dev, false)) {
> >  			pci_info(dev, "retraining failed\n");
> > +			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
> > +						   oldlnkctl2);
> > +			pcie_retrain_link(dev, false);
> 
> Hi again all,
> 
> While rebasing the bandwidth controller patches, I revisited this line and 
> realized using false for use_lt is not optimal here.
> 
> It would definitely seem better to use LT (true) in this case because it 
> likely results in much shorter wait. In hotplug cases w/o a peer device, 
> DLLLA will just make the wait last until the timeout, whereas LT would 
> short-circuit the training almost right away I think (mostly guessing with 
> limited knowledge about LTSSM). We are no longer even expecting the link 
> to come up at this point so using DLLLA seems illogical.

 Good point, I haven't given this part much thought and just pasted the 
same call to `pcie_retrain_link' as above.  At worst we'll hit the same 
timeout, but as you write we don't expect DLLLA to ever come up at this 
point and LT may come down long before the timeout (and if it oscillates 
and we probe at the wrong moments, then we'll hit the timeout anyway).

> Do you agree?

 I do.  Thank you for your suggestion, I have posted v3 now with your
suggested update only.

  Maciej

