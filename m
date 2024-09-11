Return-Path: <linux-pci+bounces-13035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E419754D0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E61F274D8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697C1885A8;
	Wed, 11 Sep 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RI3s4akc"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181218858A;
	Wed, 11 Sep 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063006; cv=none; b=lqJ0+RKs36Vug7yRMkqCptOwerSuy/k7JAhmMD4FNszuq5oLjLmGH67ldsJKrepbw6Gtv51l0Ao0mY/8Z8FhWUoow/eoAlkZT2tOH3KSMxfSub5zmdqNd8Dfhh4Nb4q/R1jn+XSadQEtdvVu7Bihd8y0Hmklo+deGlTcS8kfaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063006; c=relaxed/simple;
	bh=rnG1XAmeLzZbIuNU9ea+WDg3olR8HLpIqPVclH6bgVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eyc8hgXnb7WFPk6fmr9N30eDZpevR0kGWh078CEYgmtATBiA/VC/2a7HUFbYVLofV3kvHVpPHnGG+urQFupWLWbgAxa5t0qoPy8IQxXf84FOE8TIhQoYkxXa1pcrUF9rFAY7BbU970YeCIn6HALwhz4+fK5nj8ogvi1c++qZUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RI3s4akc; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=r6aQ1WXtd90PQJj++CLrWpIqL9HJXpQOp3tVxsDl4kM=;
	b=RI3s4akcbf8yp+2cpfwaUslF/VK2Rnbq1mbn8+klN0IKet22OcDT00yClalGQJ
	i/zkW/HOK/x4Lphtblb5P3hb/ErV6b96jLwBq59GGVQUH7tFfp7UYazOWqbOJXqM
	aSKOqp4npC0fmQe89W6bDRq7GdWMKp38uhxTtbml1pkDY=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wDXuJ1xoeFmm6+yDQ--.8490S2;
	Wed, 11 Sep 2024 21:56:01 +0800 (CST)
Date: Wed, 11 Sep 2024 21:56:01 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
	james.quinlan@broadcom.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Fix control flow issue
Message-ID: <ZuGhcdPGCjhQKiii@iZbp1asjb3cy8ks0srf007Z>
References: <20240911025058.51588-1-qianqiang.liu@163.com>
 <20240911134436.GA628842@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911134436.GA628842@bhelgaas>
X-CM-TRANSID:_____wDXuJ1xoeFmm6+yDQ--.8490S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW5Aw45ZF43CFW8Xw17Awb_yoW8XFyfpr
	Z8Jay7AF4rtayYg39I9as5Xr1fuwsIyryqv3srKwnrZFnIvFyjg34FgFyFvrsFyr4kJr1j
	yF17JF1DWF43KFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSpB-UUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRdXamXAo2U2GgAAsg

On Wed, Sep 11, 2024 at 08:44:36AM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 11, 2024 at 10:50:59AM +0800, Qianqiang Liu wrote:
> > The type of "num_inbound_wins" is "u8", so the less-than-zero
> > comparison of an unsigned value is never true.
> 
> I think this was fixed slightly differently but with the same effect;
> please check this to make sure:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-brcmstb.c?h=controller/brcmstb#n1034
> 
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 55311dc47615..3e4572c3eeb1 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -1090,9 +1090,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
> >  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
> >  
> > -	num_inbound_wins = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> > -	if (num_inbound_wins < 0)
> > -		return num_inbound_wins;
> > +	ret = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	num_inbound_wins = (u8)ret;
> >  
> >  	set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
> >  
> > -- 
> > 2.39.2
> > 

Yes, they have the same effect.

-- 
Best,
Qianqiang Liu


