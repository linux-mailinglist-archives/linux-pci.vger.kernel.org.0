Return-Path: <linux-pci+bounces-28999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BACACE479
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 20:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B42B1895F12
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C036C149C55;
	Wed,  4 Jun 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjzuDRyF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990CD17548
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749062687; cv=none; b=hJlyowid0A2Jt9d6YGo+EdlNVAaQWsX11NAjFxg/oM/PJDUMTUmzefo181zKbE253zX8IsZN5RXhcDiYJZLnJFd/agBTFnbXiHIC/n9h4E8ZYCVg4FN9mmq4mGGTQrahr85DEhZqqhqka3XUf7lowbiIdjPJT/F1fNVfNgOdje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749062687; c=relaxed/simple;
	bh=EcqIEu76v+ExmEM3HZKzLHuCykcVPoooykubp6BZ/ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bh2SqQI95wHwsokeRavCuGYTyCCQSMRKN5hAkNewrmHt9/vM2bI0yQRbEc8TIk9zXTlQ5mjrmNSck5sXmoOoGlv/MLKYcYggvWLdpz9A+vOgZgtWfmrMajiURxh8Cw3p9Er3VBsEt8FsWZJ2IBTJNbQD7sySxui/cveBR7eCxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjzuDRyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFED0C4CEE4;
	Wed,  4 Jun 2025 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749062687;
	bh=EcqIEu76v+ExmEM3HZKzLHuCykcVPoooykubp6BZ/ZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AjzuDRyFDhGTPH+X9h2Ta/0pCqmctmhSUIprVyPMBEqgy2MQOwKw2j2ZEindiLvD+
	 6uoQoM5wj74hm3gdfCVATatJnv9j0I9bgM2ukVJFU7csL83JjCmxfkI+ayLPjTPm8v
	 qX+egtay6PWa1zCxMmpcHbCThv51rh9XGZhDm5g6nAkJA0/RVlVR71BoOvmTvDArec
	 tYu58pfh+sVFLTjfT21fHfcTRwslgv6bnol52OOE93VhUpuFkc6pd6vGmICW6rRhhy
	 jqN9X1GGhlCakLtpheFNDOlAIrtM8MS+O/e8Ntxl2yVPJMJi+3xxHJmGO5EOIrZ4Q6
	 kz92/sUS4lnhg==
Date: Wed, 4 Jun 2025 13:44:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250604184445.GA567382@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rrtrcwajj4vjvbqzosskdnroqnijzaafncgckoh2dlk3c4njvs@twop3vyidmh7>

On Wed, Jun 04, 2025 at 10:40:09PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 04, 2025 at 01:40:52PM +0200, Niklas Cassel wrote:
> > On Tue, Jun 03, 2025 at 01:12:50PM -0500, Bjorn Helgaas wrote:
> > > 
> > > Hmmm, sorry, I misinterpreted both 1/4 and 2/4.  I read them as "add
> > > this delay so the PLEXTOR device works", but in fact, I think in both
> > > cases, the delay is actually to enforce the PCIe r6.0, sec 6.6.1,
> > > requirement for software to wait 100ms before issuing a config
> > > request, and the fact that it makes PLEXTOR work is a side effect of
> > > that.
> > 
> > Well, the Plextor NVMe drive used to work with previous kernels,
> > but regressed.
> > 
> > But yes, the delay was added to enforce "PCIe r6.0, sec 6.6.1"
> > requirement for software to wait 100ms, which once again makes
> > the Plextor NVMe drive work.
> > 
> > > The beginning of that 100ms delay is "exit from Conventional Reset"
> > > (ports that support <= 5.0 GT/s) or "link training completes" (ports
> > > that support > 5.0 GT/s).
> > > 
> > > I think we lack that 100ms delay in dwc drivers in general.  The only
> > > generic dwc delay is in dw_pcie_host_init() via the LINK_WAIT_SLEEP_MS
> > > in dw_pcie_wait_for_link(), but that doesn't count because it's
> > > *before* the link comes up.  We have to wait 100ms *after* exiting
> > > Conventional Reset or completing link training.
> > 
> > In dw_pcie_wait_for_link(), in the first iteration of the loop, the link
> > will never be up (because the link was just started),
> > dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS (90 ms),
> > before trying again.
> > 
> > Most likely the link training took way less than 100 ms, so most of those
> > 90 ms will probably be after link training has completed.
> > 
> > That is most likely why Plextor worked on older kernels (which does not
> > use the link up IRQ).

Definitely seems plausible.

> > If we add a 100 ms sleep after wait_for_link(), then I suggest that we
> > also reduce LINK_WAIT_SLEEP_MS to something shorter.
> 
> No. The 900ms sleep is to make sure that we wait 1s before erroring out
> assuming that the device is not present. This is mandated by the spec. So
> irrespective of the delay we add *after* link up, we should try to detect the
> link up for ~1s.

I think it would be sensible for dw_pcie_wait_for_link() to check for
link up more frequently, i.e., reduce LINK_WAIT_SLEEP_MS and increase
LINK_WAIT_MAX_RETRIES.

If LINK_WAIT_SLEEP_MS * LINK_WAIT_MAX_RETRIES is for the 1.0s
mentioned in sec 6.6.1, seems like maybe we should make a generic
#define for it so we could include the spec reference and use it
across all drivers.  And resolve the question of 900ms vs 1000ms.

Bjorn

