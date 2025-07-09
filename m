Return-Path: <linux-pci+bounces-31753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD766AFE07E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 08:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD99E4E3B5B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9540426B747;
	Wed,  9 Jul 2025 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoymiDiR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C6143756;
	Wed,  9 Jul 2025 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043721; cv=none; b=FdboyPySNanp4W3eQDrvOt3+jtTiul2YQ1qCdf3SQ+Et6drYccWskx32jPN7GVDEA1v3PyaFZMlur8Z73FQOh05bvI8POqBBrASUnnayuT4nz14P0hnYGVoeRMN8MMYaw3DZqnqX1l1pQfvzhfGeRMezoyeCjXkHMWMYvwgiR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043721; c=relaxed/simple;
	bh=VNAGZ1HGw7/vQHL73ipyc64dCgwXk5Rbfn6GM+OV4A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZwzdHiN+tEbkaTmu78Mh5gxfYbejHKGZcdETNvGalifJ1V5ZZWXNT0zbS4Q2Z7KxXRFKCAJVPqxOxmO3bd5Bfi7eGw/Law2k3PAYROJjT+i5W4vnlLiax28NVM/5iLAmlK45ULbsb/U9wbvLVDcNQrpsmy27HDKmeplHs8LkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoymiDiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B05C4CEF0;
	Wed,  9 Jul 2025 06:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752043721;
	bh=VNAGZ1HGw7/vQHL73ipyc64dCgwXk5Rbfn6GM+OV4A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoymiDiRHhcAcVjYE9mU6+jATJF7b8TdxtKx3lFwe60XaMCcBsbdYkJ9pEU+3yumK
	 clviLZan7ypTmIvqnKYTQaJfBGYM7slFMsMqBx4u6mozKulJT81g526Zax65MudrMX
	 e2BfD0j81OwNvZFl7UclDKsveLEljWe0PV6hNpaiq1m+4wNzRDPGYIMwBE1kh8cUkl
	 n9MmEA2EU960sGSV520xNtZeeNuaZBhMP1KaDr1jpHPnIiRbEWWfN+FIV0ftrbClnB
	 ULFPqAhLyCCTsmIPvOIBXYv6HPdM/3Y7kfxC/Pbf3IF5s2i8deo7bwyJKb/nBciXah
	 ivS9YcfB/+TOQ==
Date: Wed, 9 Jul 2025 12:18:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 0/3] PCI/pwrctrl: Allow pwrctrl framework to control
 PERST# GPIO if available
Message-ID: <kj6kilhjynygioxyo7iogvgwqbr7tluryir3f7vqeowk6wd6qn@sop5ubotfcug>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <aG3IWdZIhnk01t2A@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG3IWdZIhnk01t2A@google.com>

On Tue, Jul 08, 2025 at 06:39:37PM GMT, Brian Norris wrote:
> Hi Manivannan,
> 
> Thanks for tackling this!
> 
> On Mon, Jul 07, 2025 at 11:48:37PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This series is an RFC to propose pwrctrl framework to control the PERST# GPIO
> > instead of letting the controller drivers to do so (which is a mistake btw).
> > 
> > Right now, the pwrctrl framework is controlling the power supplies to the
> > components (endpoints and such), but it is not controlling PERST#. This was
> > pointed out by Brian during a related conversation [1]. But we cannot just move
> > the PERST# control from controller drivers due to the following reasons:
> > 
> > 1. Most of the controller drivers need to assert PERST# during the controller
> > initialization sequence. This is mostly as per their hardware reference manual
> > and should not be changed.
> > 
> > 2. Controller drivers still need to toggle PERST# when pwrctrl is not used i.e.,
> > when the power supplies are not accurately described in PCI DT node. This can
> > happen on unsupported platforms and also for platforms with legacy DTs.
> > 
> > For this reason, I've kept the PERST# retrieval logic in the controller drivers
> > and just passed the gpio descriptors (for each slot) to the pwrctrl framework.
> 
> How sure are we that GPIOs (and *only* GPIOs) are sufficient for this
> feature? I've seen a few drivers that pair a GPIO with some kind of
> "internal" reset too, and it's not always clear that they can/should be
> operated separately.
> 
> For example, drivers/pci/controller/dwc/pci-imx6.c /
> imx_pcie_{,de}assert_core_reset(), and pcie-tegra194.c's
> APPL_PINMUX_PEX_RST. The tegra case especially seems pretty clear that
> its non-GPIO "pex_rst" is resetting an endpoint.
> 

Right. But GPIO is the most commonly used approach for implementing PERST# and
it is the one supported on the platform I'm testing with. So I just went with
that. For sure there are other methods exist and the PCIe spec itself doesn't
define how PERST# should be implemented in a form factor. It merely defines
PERST# as an 'auxiliary signal'. So yes, other form of PERST# can exist. But for
the sake of keeping this proposal simple, I'm considering only GPIO based
PERST# atm.

Also, Tegra platforms are not converted to use pwrctrl framework and I don't
know if the platform maintainers are interested in it or not. But if they start
using it, we can tackle this situation by introducing a callback that
asserts/deasserts PERST# (yes, callbacks are evil, but I don't know any other
sensible way to support vendor specific PERST# implementations).

Oh and do take a look at pcie-brcmstb driver, which I promised to move to
pwrctrl framework for another reason. It uses multiple callbacks per SoC
revisions for toggling PERST#. So for these usecases, having a callback in
'struct pci_host_bridge' would be a good fit and I may introduce it after this
series gets in.

> > This will allow both the controller drivers and pwrctrl framework to share the
> > PERST# (which is ugly but can't be avoided). But care must be taken to ensure
> > that the controller drivers only assert PERST# and not deassert when pwrctrl is
> > used. I've added the change for the Qcom driver as a reference. The Qcom driver
> > is a slight mess because, it now has to support both new DT binding (PERST# and
> > PHY in Root Port node) and legacy (both in Host Bridge node). So I've allowed
> > the PERST# control only for the new binding (which is always going to use
> > pwrctrl framework to control the component supplies).
> > 
> > Testing
> > =======
> > 
> > This series is tested on Lenovo Thinkpad T14s laptop (with out-of-tree patch
> > enabling PCIe WLAN card) and on RB3 Gen2 with TC9563 switch (also with the not
> > yet merged series [2]). A big take away from this series is that, it is now
> > possible to get rid of the controversial {start/stop}_link() callback proposed
> > in the above mentioned switch pwrctrl driver [3].
> 
> This is a tiny bit tangential to the PERST# discussion, but I believe
> there are other controller driver features that don't fit into the
> sequence model of:
> 
> 1. start LTSSM (controller driver)
> 2. pwrctrl eventually turns on power + delay per spec
> 3. pwrctrl deasserts PERST#
> 4. pwrctrl delays a fixed amount of time, per the CEM spec
> 5. pwrctrl rescans bus
> 
> For example, tegra_pcie_dw_start_link() notes some cases where it needs
> to take action and retry when the link doesn't come up. Similarly, I've
> seen drivers with retry loops for cases where the link comes up, but not
> at the expected link rate. None of this is possible if the controller
> driver only gets to take care of #1, and has no involvement in between
> #3 and #5.
> 

Having this back and forth communication would make the pwrctrl driver a lot
messier. But I believe, we could teach pwrctrl driver to detect link up (similar
to dw_pcie_wait_for_link()) and if link didn't come up, it could do retry and
other steps with help from controller drivers. But these things should be
implemented only when platforms like Tegra start to show some love towards
pwrctrl.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

