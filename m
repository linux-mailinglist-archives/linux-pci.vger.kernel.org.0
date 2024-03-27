Return-Path: <linux-pci+bounces-5268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EEB88EADA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 17:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F641C31CAD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFA2130A55;
	Wed, 27 Mar 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIrjaLmZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5937162
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555838; cv=none; b=IPfzcJf7lP+7Wfz2DmBNS2GOgegUd7fkyHRwVhactD3/6KCiye772bQCta1WNAoFNeAW+oEBfjr3vjbllniPxhIDOGAucJ7280oJyuj8g5eb4FZTvWA4sMOjAI5Yrwc9wKnNXJ0R14sZ8AbX+lcQdm8os5HWNsEJoyNf6Ydr/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555838; c=relaxed/simple;
	bh=3FkcEXwz29GPNoM2dZ9Um0E/527u3UrFvQi/HfcWpOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+9Kjo8M0TknloNw27KHNNoVGFhpndNSo7FMAOnq+uhtiNBa9Wfhn148jnmwqdNBnLddFxFcc6EMOLBSgErqbG9LtMZczn6MICQ4QXNOq9MJ9D/8YlGXoN5MzONplNaXn6menAF0a99T9xZgN6x0mDdHzlhB5uGlpzUuZcmLj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIrjaLmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E844DC433F1;
	Wed, 27 Mar 2024 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711555837;
	bh=3FkcEXwz29GPNoM2dZ9Um0E/527u3UrFvQi/HfcWpOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIrjaLmZLxyNXxUYsBPbpWt0AP1W4TE1BGJwjREtyf/ntHYZZPVG494nEDU9qQMbq
	 WaIhZB2p5OezF2C5vwaYCncSQt4D4Vg7Hun11A7V0p0tsHYq/ob6trYTm3Cjk6hpqj
	 cDnDfoZgMCatSpDmt0ll/aAvrtEAbHwLkFTvxJhuV4PKTvcEKNtE0hwEgpmhQzK0Zl
	 ZhihFgyfdiNRs1n5QQ3CXBNzQT9DGak2Ou4YOmz7UARx2/3rdXmBW/vqrU4iiA6aAV
	 u2fkjKW5Fs0y8/2uALlU0lseKeJ5GdPMN7jAyF5+hnTQM4P5pr9skQ75Zpfxz+fn68
	 LTdO/KL0RYHKQ==
Date: Wed, 27 Mar 2024 17:10:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Remove superfluous code
Message-ID: <ZgRE-B2RnABfZkjU@ryzen>
References: <20240325142356.731039-1-cassel@kernel.org>
 <ZgMaQcRsdHvSEGUD@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgMaQcRsdHvSEGUD@lizhi-Precision-Tower-5810>

On Tue, Mar 26, 2024 at 02:56:01PM -0400, Frank Li wrote:
> On Mon, Mar 25, 2024 at 03:23:55PM +0100, Niklas Cassel wrote:
> > There are two things that made me read this code multiple times:
> > 
> > 1) There is a parenthesis around the first conditional, but not
> > around the second conditional. This is inconsistent, and makes
> > you assume that the return value should be treated differently.
> > 
> > 2) There is no need to explicitly write != 0 in a conditional.
> > 
> > Remove the superfluous parenthesis and != 0.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index bf64d3aff7d8..1005dfdf664e 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -854,8 +854,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> >  	init_completion(&test->irq_raised);
> >  	mutex_init(&test->mutex);
> >  
> > -	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
> > -	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
> > +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) &&
> > +	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
> 
> Actaully above orginal code is wrong. If 
> dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) failure, 
> dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) must be failure.
> Needn't retry 32bit.
> 
> https://lore.kernel.org/linux-pci/925da248-f582-6dd5-57ab-0fadc4e84f9e@wanadoo.fr/

To be honest, I do not really understand how this works,
and I don't want to spend time reading the DMA-API code
to understand why it can't fail.

Feel free to send a patch that you think is better than
the one in $subject. (No need to give me any credit.)


> 
> I am also strange where 48 come from. It should be EP side access windows
> capiblity. Idealy, it should read from BAR0 or use device id to decide
> dma mask. If EP side only support 32bit dma space.

Yes, I agree that it depends on the EP's capability.
(and I also wonder where 48 came from :) )

Namely the outbound iATUs on the EP side.
(and the eDMA's capability on the EP side).

At least the iATU in DWC controller can map a 64-bit address target address.
(Regardless if the EP has configured its BARs as 32-bit or 64-bit).

However, this feels like a bigger patch than just fixing some
stylistic changes.

If you feel like you want to tacle this problem, feel free to send
a patch series. (It is outside the scope of what I wanted to fix,
which is to just make the existing code more readable.)


Kind regards,
Niklas

> 
> dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48) still return
> success because host side may support more than 48bit DMA cap.
> 
> endpoint_test will set > 4G address to EP side. EP actaully can't access
> it.
> 
> Most dwc ep controller it should be 64.
> 
> //64bit mask never return failure.
> dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)); 
> 
> if (drvdata.flags & 32_BIT_ONLY)
>     if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))
> 	err_code..
> 
> Or
> 
> if (dma_set_mask_and_coherent(&pdev->dev, drvdata.dmamask))
> 	err_code;
> 
> Frank
> 
> >  		dev_err(dev, "Cannot set DMA mask\n");
> >  		return -EINVAL;
> >  	}
> > -- 
> > 2.44.0
> > 

