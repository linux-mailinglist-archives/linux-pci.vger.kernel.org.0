Return-Path: <linux-pci+bounces-42796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42BCAE12E
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF4773095CC3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC942EA732;
	Mon,  8 Dec 2025 19:25:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EEA2EA480;
	Mon,  8 Dec 2025 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221930; cv=none; b=ALBoNgN2efpci/gHIPiUysUVEUWq+bd3Id09kdfqB0xI1kWIAIbDZ9AtUBk0McHLtIfztm6REs76hIZl3e3I3z22Gq18DaWZMHj1n5vfYPeTRFWYmO/ZNcyfjr9FpSbbNwLltXvO+x4hTBK3jzbwp+qPTAPTPD1EhwsIr/mOgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221930; c=relaxed/simple;
	bh=owFAs4V/+FdP8sM+xEufHVAZYZTCqnn0O1JX0Xztyys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lgb16LEASjFJHsXbJDyl9drOJlqqNu9oc/h2LYtrIdZH07Y5+uH+wHUbN50ewC8OhmTYqA5M5O1eufLrmfUP1wM4/mevIaiV3WUqkvyoAyZ0vHE3SedXXljUkS2liwCZPn5CoAtYt7nBwNDDJbRtgmSZdoPoTomwcXdyo4umO8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E870792009E; Mon,  8 Dec 2025 20:25:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E542392009B;
	Mon,  8 Dec 2025 19:25:26 +0000 (GMT)
Date: Mon, 8 Dec 2025 19:25:26 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: ahuang12@lenovo.com, alok.a.tiwari@oracle.com, ashishk@purestorage.com, 
    Bjorn Helgaas <bhelgaas@google.com>, guojinhui.liam@bytedance.com, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    jiwei.sun.bj@qq.com, linux-kernel@vger.kernel.org, 
    linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    msaggi@purestorage.com, sconnor@purestorage.com, sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
In-Reply-To: <20251204183036.39649-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2512080029210.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk> <20251204183036.39649-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Dec 2025, Matthew W Carlis wrote:

> For what its worth I have a particular Gen5 device in my lab here that gets stuck
> in an infinite link up-down loop when you force the speed to Gen2 when also combined
> with a specific downstream port... I'm sure there is another device somewhere else
> in the world that has the same issue when you force it to Gen1.

 Well, it's an erratum vs another erratum case.  Then should such a device 
at its maximum link speed trigger the workaround somehow, with this fix in 
place any temporary clamp will be lifted anyway and the link retrained, so 
it will recover from the link up-down loop.  So no functional regression.

> The kernel should assume a PCIe link will automatically train to the best
> speed that the devices can achieve & if the link fails to train then it should
> be up to the user space to decide what to do with it in my opinion.

 It might be tough where you have your rootfs device down the problematic 
link.

 Thank you for your input.

  Maciej

