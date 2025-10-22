Return-Path: <linux-pci+bounces-38987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2EBFB67F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A51C4E99BD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6D309F06;
	Wed, 22 Oct 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dil/Jr0w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC6302758
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128967; cv=none; b=cFpMnHFoYs198BEOg56Ar7osGu8Sft4TrVcwfYD1gc6XTKtTSM7JYkdXC5is6QaaL74vuWQyWUbEqpfZToppWfJKiHcWRYcdCa5Ip6kvQm45ilYkHBF4nBnycM5g6S3UFxiCrB9J2kjwPipuoYS0IJVertHH2cauw4oOhUM8pfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128967; c=relaxed/simple;
	bh=C0gZbgVqkm3bGIqOXkxHNgEAYxEJV3OPgvoksyc1eKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZhaaUbzDHwdtbmec0tUo8AFxYtOcyReOeVFKPHx7lhV5dA4jLQ/V3KldbV7d9t6s8nBAzS86h6hGhoQ7+HHHSHL1GIPcQQq/rTl/XUU0FnFiJsgDB7s+crI9Qzqznx/FQs1v/VjPv2QYUXL0j+mrVjrLMIFsVhqYzcEPV1Wh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dil/Jr0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BC0C4CEE7;
	Wed, 22 Oct 2025 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761128967;
	bh=C0gZbgVqkm3bGIqOXkxHNgEAYxEJV3OPgvoksyc1eKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dil/Jr0wwrEuqcUbUldTFqDgdufiJwFs5b9tWoQmtzwVb2Z67wOtBqMpUgrROVkFi
	 wuFeFzaTSxJT1DNGXX0P+FKLXkOeCk0cdLZZEzr0j1C64I8XzaYpnRRpjjN5xVWM0m
	 kZu1tA88i0MqYmGjykYhk/b1gEofXzRWafDEbwkqpWAdZ7+X2CjuZ8sO9XrTu2rMcj
	 U4G+3faSRHU3Kb/yMDkzTC2jca8cHa9GUTIUMuxt35c/LdO0+51JVG+uJmtz0NjFsK
	 AMvQq6A3cJ01856vcHbPXxwTsRdpa5jVSa1ISjHrl/JDAgJytfN2I658TDPsiSNZwk
	 jPTeXV28qXf7g==
Date: Wed, 22 Oct 2025 15:59:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-rockchip@lists.infradead.org, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
Message-ID: <a3ky7mynu6p7noyx7d3frxhwsq7izlh6sgkbbnyg5txx3kufke@nvftvg4l5gzk>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-2-git-send-email-shawn.lin@rock-chips.com>
 <eorncfyktfdc33md7ogqccy5z2lsye7ew32wdy4sbegvjo2rdl@qp2zy7u75jqg>
 <be96bc56-c84f-4dac-a4a0-5b3d1b43f505@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be96bc56-c84f-4dac-a4a0-5b3d1b43f505@rock-chips.com>

On Wed, Oct 22, 2025 at 06:13:59PM +0800, Shawn Lin wrote:
> Hi Mani
> 
> 在 2025/10/22 星期三 18:02, Manivannan Sadhasivam 写道:
> > On Tue, Oct 21, 2025 at 03:48:24PM +0800, Shawn Lin wrote:
> > > of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
> > > is properly connected and could enable L1.1/L1.2 support.
> > > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > ---
> > >   drivers/pci/of.c  | 18 ++++++++++++++++++
> > >   drivers/pci/pci.h |  6 ++++++
> > >   2 files changed, 24 insertions(+)
> > > 
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index 3579265f1198..52c6d365083b 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
> > >   	return 0;
> > >   }
> > >   EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> > > +
> > > +/**
> > > + * of_pci_clkreq_present() - Check if the "supports-clkreq" is present
> > 
> > I don't see a benefit of this API, tbh. The API name creates an impression that
> > the API will check for the presence of CLKREQ# signal in DT, but it checks
> > for the presence of the 'supports-clkreq' property. Even though the presence of
> > the property implies that the CLKREQ# routing is available, I'd prefer to check
> > for the property explicitly instead of hiding it inside this API.
> 
> It makes sense.
> 
> Will the name of_pci_supports_clkreq_present() look good? Or we just
> drop it and let host drivers to explicitly check supports-clkreq inside
> their code?
> 

I'd prefer to drop the API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

