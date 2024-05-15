Return-Path: <linux-pci+bounces-7482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463B78C624A
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 09:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7725A1C20BE6
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 07:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5591B3D3BF;
	Wed, 15 May 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wln+llPp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27968374D1;
	Wed, 15 May 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759805; cv=none; b=dOeCwoG4gIDBWxwCeGX/J2i6RybOhs8Ytj7lsPZgnaLX80mDn8a4JQirc9Mn7OYNRvYj0vCE7duIBtuRfL6iAb2ccMsNDXvbmRH/HCPf2xPt3+zoX6vbWuJo9FRKYK+r5/dO0cqiArVrHQY8ASUE26hbshixeWalikLQ8g1iqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759805; c=relaxed/simple;
	bh=Y0XlzNbxDtavlVNRzIsISWqhEfC8KQa5L0AjukAbp60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk0m77YscB8tpCEyCibjQA6xQfqZGwEhvJIsSt47JdT4R7T4GXArW/0FDHJNMGrWqA/ArVK8QRCjdy/r13UxldCGtRJGoKrzyRjRu/A7cgSrlunCpNNn/wlExOj+jnZGwW2d38Tozme0cwmgQl9B6JRfFaqDeUgkcWkdWHor4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wln+llPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BC1C116B1;
	Wed, 15 May 2024 07:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715759804;
	bh=Y0XlzNbxDtavlVNRzIsISWqhEfC8KQa5L0AjukAbp60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wln+llPpVG9vKFnLWPQa0pWmj/2zc+/TgoFJN1+sDrsxWU2w5INYB0pa6giuWvSQV
	 dxNqksE8e6vupQFn8ZaqOAM+j62OMf8szaulSdNQG2lUsFJXJtYJcLeTCuGrIaaNo1
	 O3O48bs/Yxv7l9jL1GhIJERgAxHum0krJue6X7WS4I41+h/sJRFvUeMCuCGG7ZEClc
	 oMKKd1bWhaFyOJl0HMUgnVOidKamycHK3o0YqUek35MaRkCtDYT76l4zfj+tNW1N44
	 G102wOunWFgdvDvycwvNbopiYGXBuGK+1GfoXymPJ5A2gBm/qCsElzCykZVh0sbHMk
	 EEYzEFFRYYgzQ==
Date: Wed, 15 May 2024 09:56:38 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 4/7] PCI: rcar-gen4: Add rcar_gen4_pcie_drvdata
Message-ID: <20240515075638.GA4488@thinkpad>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-5-yoshihiro.shimoda.uh@renesas.com>
 <20240511072702.GD6672@thinkpad>
 <CAMuHMdVTGev4GmX9LFwXx1gn+69ZJFGLB+vsaJou5eLMMa7pkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVTGev4GmX9LFwXx1gn+69ZJFGLB+vsaJou5eLMMa7pkw@mail.gmail.com>

On Mon, May 13, 2024 at 11:20:56AM +0200, Geert Uytterhoeven wrote:
> Hi Mani,
> 
> On Sat, May 11, 2024 at 9:37 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > On Mon, Apr 15, 2024 at 05:11:32PM +0900, Yoshihiro Shimoda wrote:
> > > In other to support future SoCs such as r8a779g0 and r8a779h0 that
> > > require different initialization settings, let's introduce SoC
> > > specific driver data with the initial member being the device mode.
> > > No functional change.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > One nitpick below. With that addressed,
> >
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> 
> > > @@ -437,9 +441,9 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
> > >  /* Common */
> > >  static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
> > >  {
> > > -     rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
> > > +     rcar->drvdata = of_device_get_match_data(&rcar->pdev->dev);
> >
> > Even though rcar->drvdata won't be NULL, the lack of NULL check will cause
> > folks to send fixup patch later. So please add a NULL check here itself.
> 
> I tend to disagree: this can never return NULL.
> Less than half of the callers of of_device_get_match_data() check for
> a NULL pointer, and many of them do so because they are used both
> with and without DT.
> 

As I said, there is no way it can be NULL. But folks tend to send the 'fix'
patches as the automated tools report these kind of non-existent issues. And I
agree that we can decide not to accept those patches, but I just wanted to avoid
that noise. As a maintainer, I try to avoid seeing those kind of patches if
there is a way we can avoid it.

But no strong preference here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

