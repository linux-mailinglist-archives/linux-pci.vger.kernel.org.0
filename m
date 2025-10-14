Return-Path: <linux-pci+bounces-38061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970BBD9946
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7034119A2DD0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6563148BA;
	Tue, 14 Oct 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUwjqM/S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C70313540;
	Tue, 14 Oct 2025 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446991; cv=none; b=smiQCcmOYc0DudJ5+Zfc11P04NLKkgT+u3z328aM5Amv4E19dnAG+pAhl2nZLDat1+PIf5wrrySDvvGrN/MThPjWrPIx1l3j4B2YQ90K4ClqfguSC+Qc38XqNhXjdVKrdUrHhQAlsznEd6BTwUsbaKWyX6sbFzwsd/vNiGsCvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446991; c=relaxed/simple;
	bh=0v37jZyYyYbs1da6KxGG2cFegI9umxnQEvbsHhkFM28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt0V9yKlN96fi9fZt3MNdkR4NzChxkmwKwgBO+wLPEBH62w5Vy7yXyRrdlpjRmEYUEFSAJ+Ciq3r+Opijq+WbjrCHUcEb5AU7yiSbSZEhwEPGXiTLSslnApQMd6OIkdWMPKjh07Ted+dNjKUUTafgLGC8cko2XSJbKXwLZ8D+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUwjqM/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B06C113D0;
	Tue, 14 Oct 2025 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760446989;
	bh=0v37jZyYyYbs1da6KxGG2cFegI9umxnQEvbsHhkFM28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUwjqM/Sp7OkEWnxQ5EJqSzP//ahSQwGJ/3PIjk6jR+DkLYwOzYfX/z5GFKsvASfA
	 nAQB75EFZ3pqVL5V1s0cRCTPZf994kcLHYtcjtxtgCsLdYCi0WKYZbEyRICnLGBmbS
	 RSzd3zqn2NJfBH1MAoGqwh8tSjd4cnmlPTk06dv0i94pFfAOtYX1hLvUiSg8yEB+oq
	 5KQamKGczN9IpOXVNd1BEVwDrTYJzmqAp8fGFiaYBBSPY5PlQIQxMYKUxqZU7d3unU
	 vRyi1QMSY4bUicB5hLQSA/mYL5rTPKn7JsevbDqdUlklpDVB4bIB64/yEeCVLwX6sF
	 JJM0cdAuM1Q6Q==
Date: Tue, 14 Oct 2025 18:32:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Kees Cook <kees@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH] PCI: rcar-host: Avoid objtool no-cfi warning in
 rcar_pcie_probe()
Message-ID: <uebexl7d5gfjopb26gstftahu2ouab3ekonw4dzgegw3on5cwr@vqc2zmxiluvt>
References: <20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org>
 <CAMuHMdXZvoTyWcgRp6TnkybnKY4ekfO9aB33iumPVaR7wvEXkw@mail.gmail.com>
 <20251014083209.GA2696801@ax162>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014083209.GA2696801@ax162>

On Tue, Oct 14, 2025 at 01:32:09AM -0700, Nathan Chancellor wrote:
> Hi Geert,
> 
> On Tue, Oct 14, 2025 at 09:16:58AM +0200, Geert Uytterhoeven wrote:
> > On Mon, 13 Oct 2025 at 20:26, Nathan Chancellor <nathan@kernel.org> wrote:
> > > ---
> > > Another alternative is to make this driver depend on CONFIG_OF since it
> > > clearly requires it but that would restrict compile testing so I went
> > > with this first.
> > > ---
> > >  drivers/pci/controller/pcie-rcar-host.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> > > index 213028052aa5..15514c9c1927 100644
> > > --- a/drivers/pci/controller/pcie-rcar-host.c
> > > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > > @@ -981,7 +981,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> > >                 goto err_clk_disable;
> > >
> > >         host->phy_init_fn = of_device_get_match_data(dev);
> > > -       err = host->phy_init_fn(host);
> > > +       err = host->phy_init_fn ? host->phy_init_fn(host) : -ENODEV;
> > >         if (err) {
> > >                 dev_err(dev, "failed to init PCIe PHY\n");
> > >                 goto err_clk_disable;
> > 
> > I am afraid you're playing a big game of whack-a-mole, since we tend
> > to remove these checks, as they can never happen in practice (driver
> > is probed from DT only, and all entries in rcar_pcie_of_match[] have
> > a non-NULL .data member)...
> 
> Thanks for the input! Yeah, that is fair, as I alluded to in the scissor
> area. We could just do
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 41748d083b93..d8688abc5b27 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -243,6 +243,7 @@ config PCI_TEGRA
>  config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe controller (host mode)"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on OF
>  	depends on PCI_MSI
>  	select IRQ_MSI_LIB
>  	help
> 
> since it is required for the driver to function. Another alternative
> would be something like either:
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 213028052aa5..c237e04392e6 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -941,6 +941,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	u32 data;
>  	int err;
>  
> +	if (!IS_ENABLED(CONFIG_OF))
> +		return -ENODEV;
> +
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
>  	if (!bridge)
>  		return -ENOMEM;
> 
> or
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 213028052aa5..2aee2e0d9a1d 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -980,8 +980,12 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_clk_disable;
>  
> -	host->phy_init_fn = of_device_get_match_data(dev);
> -	err = host->phy_init_fn(host);
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		host->phy_init_fn = of_device_get_match_data(dev);
> +		err = host->phy_init_fn(host);
> +	} else {
> +		err = -ENODEV;
> +	}
>  	if (err) {
>  		dev_err(dev, "failed to init PCIe PHY\n");
>  		goto err_clk_disable;
> 
> to keep the ability to compile test the driver without CONFIG_OF while
> having no impact on the final object code and avoiding the NULL call. I
> am open to other thoughts and ideas as well.
> 

TBH, I hate both of these CONFIG_OF checks as most of the controller drivers
are just OF drivers. If we were to sprinkle CONFIG_OF check, then it has to be
done in almost all controller drivers (except VMD, Hyper-V).

If compiler is getting smart enough to detect these NULL invocations, then it
may start to trigger the same issue for other OF APIs as well. So I'd prefer to
have the OF dependency in Kconfig, sacrificing COMPILE_TEST on non-OF configs.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

