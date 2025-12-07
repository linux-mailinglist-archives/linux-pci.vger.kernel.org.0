Return-Path: <linux-pci+bounces-42739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D8FCAB61D
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 351F530014C4
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94825189F20;
	Sun,  7 Dec 2025 14:32:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCCE242925;
	Sun,  7 Dec 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765117923; cv=none; b=AbX+7IUYPKfcNtpBA8Un14wGhkNBuq97WXMn22KpTL4HZAN7/dUzCvE/rT97IPBVxpLWjTrCppFfHVlOi1YieWm9Au6XoVCkpTRtYGrwSiwsjpWOtgOhUcFonLkZFfBacPIyUJDISMMYhO74HMzAjQMV4jMwYJtqMpDFsPE/zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765117923; c=relaxed/simple;
	bh=M/Ly9Cd9R7eRwKJW1muPou6dWEnDowBSAxrG7XIRDfQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IBEGbLKYOIzPo90WKXpBtJUVEayeKe0z/S0HBYgwjmmuqnk+iShQY59N4yUpfJDPVwM8JgXZjEloxERqswqdphPc0QiMdSe195yGGv86fOOsHuCzTvDlBcZnS81qNg+kBMIoU/ib9VPc6ZA7aQAUkVbDB9IYLl2gnnQFVDCE19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0F66B92009C; Sun,  7 Dec 2025 15:31:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 005F492009B;
	Sun,  7 Dec 2025 14:31:50 +0000 (GMT)
Date: Sun, 7 Dec 2025 14:31:50 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
cc: glaubitz@physik.fu-berlin.de, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    riccardo.mottola@libero.it
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
In-Reply-To: <6FB48A2F-A8E9-4E1D-8052-568FB1E72643@exactco.de>
Message-ID: <alpine.DEB.2.21.2512071429180.49654@angie.orcam.me.uk>
References: <20251202.174007.745614442598214100.rene@exactco.de> <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de> <20251202.180451.409161725628042305.rene@exactco.de> <alpine.DEB.2.21.2512050237490.49654@angie.orcam.me.uk>
 <6FB48A2F-A8E9-4E1D-8052-568FB1E72643@exactco.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 6 Dec 2025, René Rebe wrote:

> > So this seems like something that needs to be keyed off perhaps the 
> > capabilities of the system controller/host bridge?  If you give me a shell 
> > recipe to trigger the issue you came across, then I can see what happens 
> > with some of my MIPS systems.  I've got a bunch of options with PCI-PCIe 
> > reverse bridges and PCIe switches I could try.
> 
> Just booting a kernel with or since a5fb3ff63287 ("PCI: Allow PCI bridges to go
> to D3Hot on all non-x86”) should be enough. The systems that fail for me do
> so instantly booting, usually earlier than later. e.g. when a storage, network or
> system controller driver initializes.

 I booted 6.18 as released last week on my Malta and saw no issues in this 
area.

  Maciej

