Return-Path: <linux-pci+bounces-38022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 140CCBD82FB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D8794F992B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1229ACD1;
	Tue, 14 Oct 2025 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI/lA1AX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C916F265;
	Tue, 14 Oct 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430736; cv=none; b=BbiQvwzXxb/1QmuibsfKAyN1vgk9iDlBW0Vfniq3dR83mj3Xw2nme7cm6TIgFVR6A34mzjaa3XY4oiJeHx3Rda46/VGOM/iGvno42rWUsLfCiq+PYT/tH5IXTk7IuTdqShMqrYNvlo2IJMm3JoefYlR7uMqTcbqhcNK0P3IigkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430736; c=relaxed/simple;
	bh=79Z8WAUQAlqHzUnTiERxYcnCSSAkZtyqlEAok9nIYMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvLi1Cv0orER606hQNW5EuDxRFzMrQptYECHYZTPZEAX6DGK+t75NAzYuLispif+JgIPFB1fdmX7nbyesLpLFjvieEjjYpA5FnIOCBQC7wU7D6svBo/JHhO4eHA8Se7ufazwYiZIcTzQWCyIjXqcLSCoy8z8GfYM5XLeED3NQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI/lA1AX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE77C4CEE7;
	Tue, 14 Oct 2025 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760430735;
	bh=79Z8WAUQAlqHzUnTiERxYcnCSSAkZtyqlEAok9nIYMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rI/lA1AXn1hCQJhcNCyjkW6MrbFzQpLG/WieRsxB3RryypZMk0rg8ehuoUNNU/cVT
	 z/uoM6yqvb+aXmPBFY/uGJXxxHFFTQqn+U3UwllHJcOgtYga61iGqbaItiDSaQpg6p
	 mcs/hTyRceLNhu1nh1vYS3oX6BjoSbvtrpIR4U7Npsf4nRVXLsfW1A2oullTcm7aHG
	 Wge1rcRAMbRPt5h87r2Dy3GRDnlC1Ve+o6XRrR5M80qYjZhXUr2mqMzIY6t4nkzrGh
	 0Cykwzn3STulKiQTj97e25y7FPPQ/hauvlrwcIkjZQOoWEUAsmxWv8vHuChFUGUswA
	 X5BRd7pqSBqtg==
Date: Tue, 14 Oct 2025 01:32:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH] PCI: rcar-host: Avoid objtool no-cfi warning in
 rcar_pcie_probe()
Message-ID: <20251014083209.GA2696801@ax162>
References: <20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org>
 <CAMuHMdXZvoTyWcgRp6TnkybnKY4ekfO9aB33iumPVaR7wvEXkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXZvoTyWcgRp6TnkybnKY4ekfO9aB33iumPVaR7wvEXkw@mail.gmail.com>

Hi Geert,

On Tue, Oct 14, 2025 at 09:16:58AM +0200, Geert Uytterhoeven wrote:
> On Mon, 13 Oct 2025 at 20:26, Nathan Chancellor <nathan@kernel.org> wrote:
> > ---
> > Another alternative is to make this driver depend on CONFIG_OF since it
> > clearly requires it but that would restrict compile testing so I went
> > with this first.
> > ---
> >  drivers/pci/controller/pcie-rcar-host.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> > index 213028052aa5..15514c9c1927 100644
> > --- a/drivers/pci/controller/pcie-rcar-host.c
> > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > @@ -981,7 +981,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >                 goto err_clk_disable;
> >
> >         host->phy_init_fn = of_device_get_match_data(dev);
> > -       err = host->phy_init_fn(host);
> > +       err = host->phy_init_fn ? host->phy_init_fn(host) : -ENODEV;
> >         if (err) {
> >                 dev_err(dev, "failed to init PCIe PHY\n");
> >                 goto err_clk_disable;
> 
> I am afraid you're playing a big game of whack-a-mole, since we tend
> to remove these checks, as they can never happen in practice (driver
> is probed from DT only, and all entries in rcar_pcie_of_match[] have
> a non-NULL .data member)...

Thanks for the input! Yeah, that is fair, as I alluded to in the scissor
area. We could just do

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 41748d083b93..d8688abc5b27 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -243,6 +243,7 @@ config PCI_TEGRA
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe controller (host mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on OF
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
 	help

since it is required for the driver to function. Another alternative
would be something like either:

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 213028052aa5..c237e04392e6 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -941,6 +941,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	u32 data;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_OF))
+		return -ENODEV;
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
 	if (!bridge)
 		return -ENOMEM;

or

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 213028052aa5..2aee2e0d9a1d 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -980,8 +980,12 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto err_clk_disable;
 
-	host->phy_init_fn = of_device_get_match_data(dev);
-	err = host->phy_init_fn(host);
+	if (IS_ENABLED(CONFIG_OF)) {
+		host->phy_init_fn = of_device_get_match_data(dev);
+		err = host->phy_init_fn(host);
+	} else {
+		err = -ENODEV;
+	}
 	if (err) {
 		dev_err(dev, "failed to init PCIe PHY\n");
 		goto err_clk_disable;

to keep the ability to compile test the driver without CONFIG_OF while
having no impact on the final object code and avoiding the NULL call. I
am open to other thoughts and ideas as well.

Cheers,
Nathan

