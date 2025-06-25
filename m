Return-Path: <linux-pci+bounces-30625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35147AE83CC
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 15:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A0167C63
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E32261595;
	Wed, 25 Jun 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP67WiGn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FB261585;
	Wed, 25 Jun 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856993; cv=none; b=m4T3lrj1ggXqcaq/4lg7ptSgKCwoP8hIsBnw+n1FhX7Dxs3lWGd40uWmS3zI+eCpGpRuycVRhfzI2LwxQFluP/B9UedjFcxxywbYlOuC8GTtpFUnpgPsAyat3MFodLFEVrjdwiJ2f+wWWCBd3FcwDqWXzha495gAyD/TTSesoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856993; c=relaxed/simple;
	bh=T9ZXwJirupaKaXo4ecAOelspdWpyR5VZVpCl4hYbx3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be0vR3O6f1tDl6JLr3AspsbrnoMkyXTNoMg6v0WMfw7woysbMMaY+WSVvv9oTAgloP/LFrwgWIOqO45DJn/OEpcZ8/hqhXZJRD/dcjLv0di2lYRIiauKljNfREDAsnHENZxGPqLMLBGWYNUzo+uJh+SIDfgbEquzsbFSw7aKj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP67WiGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ABCC4CEEE;
	Wed, 25 Jun 2025 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750856993;
	bh=T9ZXwJirupaKaXo4ecAOelspdWpyR5VZVpCl4hYbx3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP67WiGnasC0Vt6bloul/aKmhoNifBCSM8pWwrvq07m5W/NrxA5Is8Jk0xU5rXvl3
	 k34sCBKYmNhH+BKq3Dz7jz1NZIamMubN/ojAwL9j+ZwqdhT6smK7YfV9ublG/xcH7M
	 1xTG8MEYfG9mkNkmI3eXi6cl2FAof5xOgH4pfI8/5GUf/MmsQOb1NRRA53pv1HRgqN
	 wjA2aK1lttJMfmW5TW4UNQMTbgU9wt7zIf468QG7yNcHvEIVDK5sBhX0xoyAqH91p6
	 4F/Wo8ARnZk18CcjSNRM+bdo9oOmiIH0HiVSWvPk4uRDAoAGKtmu/FzeFGzzaABapE
	 GaIq3TrPVpOXw==
Date: Wed, 25 Jun 2025 07:09:49 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
	johan+linaro@kernel.org, cassel@kernel.org, shradha.t@samsung.com, 
	thippeswamy.havalige@amd.com, quic_schintav@quicinc.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v12 0/9] Add STM32MP25 PCIe drivers
Message-ID: <bybl3ss5z6jgbhjqny5qwh25a5khhcvixoknrzqsnmennzcfdv@46j4grd35mx5>
References: <175068078778.15794.15418191733712827693.b4-ty@kernel.org>
 <20250624222206.GA1537968@bhelgaas>
 <3bmw76gzqjq2nmjvj7tb6gi5x233zzfrhv44uyjopl2lxyzbkh@zg5skeu62nbh>
 <01dbb6cf-3ab4-4922-b301-661464c9e56d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01dbb6cf-3ab4-4922-b301-661464c9e56d@foss.st.com>

On Wed, Jun 25, 2025 at 12:18:16PM +0200, Christian Bruel wrote:
> 
> 
> On 6/25/25 06:00, Manivannan Sadhasivam wrote:
> > On Tue, Jun 24, 2025 at 05:22:06PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Jun 23, 2025 at 06:13:07AM -0600, Manivannan Sadhasivam wrote:
> > > > On Tue, 10 Jun 2025 11:07:05 +0200, Christian Bruel wrote:
> > > > > Changes in v12;
> > > > >     Fix warning reported by kernel test robot <lkp@intel.com>
> > > > > 
> > > > > Changes in v11;
> > > > >     Address comments from Manivanna:
> > > > >     - RC driver: Do not call pm_runtime_get_noresume in probe
> > > > >                  More uses of dev_err_probe
> > > > >     - EP driver: Use level triggered PERST# irq
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied, thanks!
> > > > 
> > > > [1/9] dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
> > > >        commit: 41d5cfbdda7a61c5d646a54035b697205cff1cf0
> > > > [2/9] PCI: stm32: Add PCIe host support for STM32MP25
> > > >        commit: f6111bc2d8fe6ffc741661126a2174523124dc11
> > > > [3/9] dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
> > > >        commit: 203cfc4a23506ffb9c48d1300348c290dbf9368e
> > > > [4/9] PCI: stm32: Add PCIe Endpoint support for STM32MP25
> > > >        commit: 8869fb36a107a9ff18dab8c224de6afff1e81dec
> > > > [5/9] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
> > > >        commit: 003902ed7778d62083120253cd282a9112674986
> > > 
> > > This doesn't build for me with the attached config:
> > > 
> > >    $ make drivers/pci/controller/dwc/pcie-stm32.o
> > >      CALL    scripts/checksyscalls.sh
> > >      DESCEND objtool
> > >      INSTALL libsubcmd_headers
> > >      CC      drivers/pci/controller/dwc/pcie-stm32.o
> > >    drivers/pci/controller/dwc/pcie-stm32.c: In function ‘stm32_pcie_suspend_noirq’:
> > >    drivers/pci/controller/dwc/pcie-stm32.c:83:16: error: implicit declaration of function ‘pinctrl_pm_select_sleep_state’ [-Werror=implicit-function-declaration]
> > >       83 |         return pinctrl_pm_select_sleep_state(dev);
> > > 	|                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    drivers/pci/controller/dwc/pcie-stm32.c: In function ‘stm32_pcie_resume_noirq’:
> > >    drivers/pci/controller/dwc/pcie-stm32.c:96:24: error: ‘structdevice’ has no member named ‘pins’
> > >       96 |         if (!IS_ERR(dev->pins->init_state))
> > > 	|                        ^~
> > >    drivers/pci/controller/dwc/pcie-stm32.c:97:23: error: implicit declaration of function ‘pinctrl_select_state’ [-Werror=implicit-function-declaration]
> > >       97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> > > 	|                       ^~~~~~~~~~~~~~~~~~~~
> > >    drivers/pci/controller/dwc/pcie-stm32.c:97:47: error: ‘structdevice’ has no member named ‘pins’
> > >       97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> > > 	|                                               ^~
> > >    drivers/pci/controller/dwc/pcie-stm32.c:97:61: error: ‘structdevice’ has no member named ‘pins’
> > >       97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> > > 	|                                                             ^~
> > >    drivers/pci/controller/dwc/pcie-stm32.c:99:23: error: implicit declaration of function ‘pinctrl_pm_select_default_state’ [-Werror=implicit-function-declaration]
> > >       99 |                 ret = pinctrl_pm_select_default_state(dev);
> > > 	|                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > 
> > Hmm... I see two issues here. First is, wrong pinctrl header used. The correct
> > one is:
> > 
> > #include <linux/pinctrl/consumer.h>
> 
> ah yes, the missing pinctrl_pm_select_default_state() should indeed be fixed
> by using the correct header.
> 

I've fixed it in the branch.

> > 
> > Second issue is the driver accessing "struct device::pins" directly. The "pins"
> > member won't be available if CONFIG_PINCTRL is not set (which is what your
> > .config has). So either the member should not be accessed directly or the
> > driver has to depend on CONFIG_PINCTRL. The latter one is not acceptable.It
> > also looks weird that only this driver is accessing the "pins" member directly
> > apart from the pinctrl core. So I think this part needs a revisit.
> > 
> > Christian?
> The pinctrl "init" and "default" configurations are managed effectively by
> the probing code. The same approach is required in
> stm32_pcie_resume_noirq().
> 
> In this case, would introducing a new helper function,
> pinctrl_pm_select_init_state(), be preferable, even if we are the only
> consumer?
> 

Sounds reasonable. If you end up creating an API, get it acked by the pinctrl
maintainer so that I can merge it (and the use of it in this driver) through
the PCI tree to avoid cross tree dependency.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

