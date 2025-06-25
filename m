Return-Path: <linux-pci+bounces-30569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E1DAE7597
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 06:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1223AC8CD
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0B145355;
	Wed, 25 Jun 2025 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBr5dcep"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05086AD58;
	Wed, 25 Jun 2025 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750824044; cv=none; b=VXLW2M8FpLQ3PY54PbW+wb4d+pAIv318ity6G+YRhRZePk1/dz7pk0DDBKYRMlb1vt2txaJ4KD88ldZ5vKkD6Bkudg9OzObZk8RdeYnLomtDCbRiAuSpDefItF8v+1jX4x6qawUcCKQruCwMBfmd84eBT0MNTd/2s7iK/hy5mpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750824044; c=relaxed/simple;
	bh=3knVkmzjeB1aYkBJciYzDKyPEWCxuge1R6dKhWJvBcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeEO2G6RUdBPBsghziM1bf8E9toFK7h+yhISiLZ2+EqM2EZmXrwuR+UgpEpN+js4ARDf7gbWvG4ES8h+1qHJ5LrnwMaRYzttWFtmpS2B5kQwkOUfPwX4hLO4I5pl1OMwytjUW+sDXpM8CZ6lxQko1yLrnRH4gjKKbmsHwkG8ntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBr5dcep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19BCC4CEEA;
	Wed, 25 Jun 2025 04:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750824042;
	bh=3knVkmzjeB1aYkBJciYzDKyPEWCxuge1R6dKhWJvBcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBr5dcepNEQgPiRg3aaI/tOgzPBOPr6ZvrJJamIx77DLo+9nA/3P0YctklKIDpPgk
	 GVgjcQZPPDQo8k/1JJWkLGuYvOHk2Ec3sWXraK+bXtoLMKw/NBYJnrE5XgpNoBXNRM
	 +SA1hpeV+Cv/l0SzOmGGHtFioAgWm9GbHdatVZtm1IYur/9FCnDMr50my/rQ8JPTzk
	 VOXoKAkPCtBWdsfe+Yld1NzyP7dmRUN+R1+h5q6keBuzDwQUMCfnhCEkWtS2aYrRpu
	 emtMVAvw6xPvsun4VXM0pkq19W9i4LIX8GqygUiSuq5BVoS5Vz72U9+9zVLN/DeiMH
	 H2UjHxxWO23CQ==
Date: Tue, 24 Jun 2025 22:00:31 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
	johan+linaro@kernel.org, cassel@kernel.org, shradha.t@samsung.com, 
	thippeswamy.havalige@amd.com, quic_schintav@quicinc.com, 
	Christian Bruel <christian.bruel@foss.st.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v12 0/9] Add STM32MP25 PCIe drivers
Message-ID: <3bmw76gzqjq2nmjvj7tb6gi5x233zzfrhv44uyjopl2lxyzbkh@zg5skeu62nbh>
References: <175068078778.15794.15418191733712827693.b4-ty@kernel.org>
 <20250624222206.GA1537968@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624222206.GA1537968@bhelgaas>

On Tue, Jun 24, 2025 at 05:22:06PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 23, 2025 at 06:13:07AM -0600, Manivannan Sadhasivam wrote:
> > On Tue, 10 Jun 2025 11:07:05 +0200, Christian Bruel wrote:
> > > Changes in v12;
> > >    Fix warning reported by kernel test robot <lkp@intel.com>
> > > 
> > > Changes in v11;
> > >    Address comments from Manivanna:
> > >    - RC driver: Do not call pm_runtime_get_noresume in probe
> > >                 More uses of dev_err_probe
> > >    - EP driver: Use level triggered PERST# irq
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/9] dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
> >       commit: 41d5cfbdda7a61c5d646a54035b697205cff1cf0
> > [2/9] PCI: stm32: Add PCIe host support for STM32MP25
> >       commit: f6111bc2d8fe6ffc741661126a2174523124dc11
> > [3/9] dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
> >       commit: 203cfc4a23506ffb9c48d1300348c290dbf9368e
> > [4/9] PCI: stm32: Add PCIe Endpoint support for STM32MP25
> >       commit: 8869fb36a107a9ff18dab8c224de6afff1e81dec
> > [5/9] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
> >       commit: 003902ed7778d62083120253cd282a9112674986
> 
> This doesn't build for me with the attached config:
> 
>   $ make drivers/pci/controller/dwc/pcie-stm32.o
>     CALL    scripts/checksyscalls.sh
>     DESCEND objtool
>     INSTALL libsubcmd_headers
>     CC      drivers/pci/controller/dwc/pcie-stm32.o
>   drivers/pci/controller/dwc/pcie-stm32.c: In function ‘stm32_pcie_suspend_noirq’:
>   drivers/pci/controller/dwc/pcie-stm32.c:83:16: error: implicit declaration of function ‘pinctrl_pm_select_sleep_state’ [-Werror=implicit-function-declaration]
>      83 |         return pinctrl_pm_select_sleep_state(dev);
> 	|                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/pci/controller/dwc/pcie-stm32.c: In function ‘stm32_pcie_resume_noirq’:
>   drivers/pci/controller/dwc/pcie-stm32.c:96:24: error: ‘struct device’ has no member named ‘pins’
>      96 |         if (!IS_ERR(dev->pins->init_state))
> 	|                        ^~
>   drivers/pci/controller/dwc/pcie-stm32.c:97:23: error: implicit declaration of function ‘pinctrl_select_state’ [-Werror=implicit-function-declaration]
>      97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> 	|                       ^~~~~~~~~~~~~~~~~~~~
>   drivers/pci/controller/dwc/pcie-stm32.c:97:47: error: ‘struct device’ has no member named ‘pins’
>      97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> 	|                                               ^~
>   drivers/pci/controller/dwc/pcie-stm32.c:97:61: error: ‘struct device’ has no member named ‘pins’
>      97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> 	|                                                             ^~
>   drivers/pci/controller/dwc/pcie-stm32.c:99:23: error: implicit declaration of function ‘pinctrl_pm_select_default_state’ [-Werror=implicit-function-declaration]
>      99 |                 ret = pinctrl_pm_select_default_state(dev);
> 	|                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

Hmm... I see two issues here. First is, wrong pinctrl header used. The correct
one is:

#include <linux/pinctrl/consumer.h>

Second issue is the driver accessing "struct device::pins" directly. The "pins"
member won't be available if CONFIG_PINCTRL is not set (which is what your
.config has). So either the member should not be accessed directly or the
driver has to depend on CONFIG_PINCTRL. The latter one is not acceptable. It
also looks weird that only this driver is accessing the "pins" member directly
apart from the pinctrl core. So I think this part needs a revisit.

Christian?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

