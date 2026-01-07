Return-Path: <linux-pci+bounces-44181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD0CFDB39
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 13:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AED83311C00C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD431353C;
	Wed,  7 Jan 2026 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkGk6XqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41058F49;
	Wed,  7 Jan 2026 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789125; cv=none; b=J0b2PjCfjJopP9osph3ACd89XGjhmB+DWvaUCbS3UcEg1QVuYek8gvuhcwhwXzY46d9z5mBgM1fxMT588FGB5E+rifXwRm5pm4AwCqwdb+/iBgUhVYP+uyCAz2pPSdr48STISOerGpCrvaDqoqMdRBlj3u3Rot+qDuSvHtzBC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789125; c=relaxed/simple;
	bh=sfYlyiZoeUZcVn7NwfS5gMgyWT0pMwsrWiexLPWG+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG7zBLOL8Sa38Kd9Lw5AXBHKt8+6deQ8Gh9OAyDuagPMdPV4bjGCW9u/qtV0XDtXI/Qg6yJkbtcVZsCqnU74BqxPAvtq8V2d7OJ9jollj3jiNltsMcERz29Ki72gEtkcrnNLCtzZgWR3Jyg7Y5cue+pW/6BJH/7hn0q2hiJBuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkGk6XqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A34EC4CEF7;
	Wed,  7 Jan 2026 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789125;
	bh=sfYlyiZoeUZcVn7NwfS5gMgyWT0pMwsrWiexLPWG+Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkGk6XqKLaGl/8j/tUCkvHRUPu5FGXepJy0ojmFTNwzNgDtZLbY42vyoyRm8ZEM4B
	 91dywEkuqYf+i7YOFLywI8jwoJeO0ARjqIOZQ/R8OcBK1EY0JcXRGUMp7KelNJQTdx
	 BepyMOchxH7/DqNmQGJiphOUtpskRIjSh7wjC/YphZ11lVghKdhVVdrFPPq5npC2qP
	 bTXpfYMTuEcWvSW409C5JF1kRiFXeNuCFp+GMefGV8i2fkI6GtxbgKruLxJ/1NOtGJ
	 cHOqiYvJa26ydKn34QsC8rh0WpC0Y+cg+fwTROdmKdLrNCjuLKa8FvuhD9d4hBr7gw
	 7Wsqff3rWNJCQ==
Date: Wed, 7 Jan 2026 18:01:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v4 5/5] power: sequencing: Add the Power Sequencing
 driver for the PCIe M.2 connectors
Message-ID: <pqix44ld4icxhmvaranezas7j77wcrmkfpj4xyxgxir3tmfwx7@fswnr25k2f43>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
 <20251228-pci-m2-v4-5-5684868b0d5f@oss.qualcomm.com>
 <CAMRc=MfPq7+ZbWTp7+H388hqHoX27qbbHsLHO+xeLaceTwZLVA@mail.gmail.com>
 <z33axfsiox73f2lklhiaulekjnqxnqtkycfylybwqnqxtx2fck@3qtas4u6mfnz>
 <CAMRc=McS8a-1cH_y+kpze=zj2-PksHDO3SE=p3XnbEueUQt9xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McS8a-1cH_y+kpze=zj2-PksHDO3SE=p3XnbEueUQt9xA@mail.gmail.com>

On Wed, Jan 07, 2026 at 10:51:11AM +0100, Bartosz Golaszewski wrote:
> On Wed, Jan 7, 2026 at 10:39 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > > > +
> > > > +static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
> > > > +{
> > > > +       struct device *dev = &pdev->dev;
> > > > +       struct pwrseq_pcie_m2_ctx *ctx;
> > > > +       struct pwrseq_config config = {};
> > > > +       int ret;
> > > > +
> > > > +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > > > +       if (!ctx)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       ctx->of_node = dev_of_node(dev);
> > >
> > > Since you're storing the node address for later, I'd suggest using
> > > of_node_get() to get a real reference.
> > >
> >
> > If CONFIG_OF_DYNAMIC is not enabled, then of_node_get() will just return the
> > passed pointer. I always prefer using dev_of_node() since it has the CONFIG_OF
> > and NULL check. Though, the checks won't apply here, I used it for consistency.
> >
> 
> I think it's just more of a good practice to take a reference to any
> resource whenever you store keep it for longer than the duration of
> the function even if the actual reference counting is disabled in some
> instances.

Good practice you inherited from writing Rust code :)

> If ever we switch to fwnodes, the circumstances may be
> different than static devicetree.
> 
> You can also do "ctx->of_node = of_node_get(dev_of_node(dev));", all
> the NULL-checks are there.
> 

This may not be needed. I can use of_node_get() here, but the APIs are just
fragile such that neither dev_of_node() nor of_node_get() increments the
refcount always.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

