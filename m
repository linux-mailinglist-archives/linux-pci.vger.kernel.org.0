Return-Path: <linux-pci+bounces-28904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB50ACCCAD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 20:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582241890140
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78B24A069;
	Tue,  3 Jun 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTRLQ9RA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CAB1E570D
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974372; cv=none; b=EXFJJGyZtaDGQEPjYzlhKMK5RTyL9q+psLcZ3sQfSR4NZW5uKsL1ZmbUUmk1lZg3hHWqsr1CjRpMpgsEZGMNf6xwzzN8VBd3a8Ds/Z7an2+loYlIZqP75myeRbhybuNG2xHfxdeFykLicJsXbzdF6JreKuWZxDWEj/08vD2M0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974372; c=relaxed/simple;
	bh=l7hazKp9x8Xzw0tllu2vo2pbAlO+wqbtKbXlvyCvQbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F6vZXHFzjWWmh7ClGH2vJ1GYQIc0yW5gEiBZthujJDGgOdPpT0eY9vLj4H8oLFTwhXoav0DG2mXQg7y4PIn86tslVeIF0ukh4FQwfsoZgPzyWDo+GG8W68KC0T3DWOpg+hzSKsrrCndPSckK/tKm6rT+RBj/B37zDjMB7iYc6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTRLQ9RA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F5CC4CEED;
	Tue,  3 Jun 2025 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748974371;
	bh=l7hazKp9x8Xzw0tllu2vo2pbAlO+wqbtKbXlvyCvQbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lTRLQ9RAjg2032UQ3WcGEkJraC27pGea5D0O1+9saGh01CsKarRaOhO9GnaSzW7RP
	 dBT90A1Stsb5fvRCythAVMy/raiTRdQYEYlTZJ7H+h/NaeO+R67lbnVxJ8JpWLz5dG
	 /Mymjs1NOGHedhNSaGEWGa/C/gADuBZivMkFjPyts10XrpDw/q8Tvafx+xHWOpn9zQ
	 PhAvcHi85CaYsiu8h2nt1/1VYHmf7f9AFoySdft6nwylSsvej1uO0WDsK9wtAqAIna
	 Ve0W6oOVQLByKO22AfW6bq4bpJ9RkWkOQv/MGcWKQNTyhZVbV5iub6Md3L/Fw+HHx3
	 H+nELnSQSBctQ==
Date: Tue, 3 Jun 2025 13:12:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <20250603181250.GA473171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD8Bz4CkdnAd8Col@ryzen>

On Tue, Jun 03, 2025 at 04:08:15PM +0200, Niklas Cassel wrote:
> On Sat, May 31, 2025 at 12:17:43PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, May 30, 2025 at 02:43:47PM -0500, Bjorn Helgaas wrote:
> > > On Fri, May 30, 2025 at 07:24:53PM +0200, Niklas Cassel wrote:
> > > > On 30 May 2025 19:19:37 CEST, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > >I think all drivers should wait PCIE_T_RRS_READY_MS (100ms) after exit
> > > > >from Conventional Reset (if port only supports <= 5.0 GT/s) or after
> > > > >link training completes (if port supports > 5.0 GT/s).
> > > > >
> > > > >> So I don't think this is a device specific issue but rather
> > > > >> controller specific.  And this makes the Qcom patch that I dropped a
> > > > >> valid one (ofc with change in description).
> > > > >
> > > > >URL?
> > > > 
> > > > PATCH 4/4 of this series.
> > > 
> > > If you mean
> > > https://lore.kernel.org/r/20250506073934.433176-10-cassel@kernel.org,
> > > that patch merely replaces "100" with PCIE_T_PVPERL_MS, which doesn't
> > > fix anything and is valid regardless of this Plextor-related patch
> > > ("PCI: dw-rockchip: Do not enumerate bus before endpoint devices are
> > > ready").
> > 
> > It is patch 2/4:
> > https://lore.kernel.org/all/20250506073934.433176-8-cassel@kernel.org
> 
> Hello all,
> 
> I'm getting some mixed messages here.
> 
> If I understand Bjorn correctly, he would prefer a NVMe quirk, and looking
> at pci/next, PATCH 1/4 has been dropped.

Hmmm, sorry, I misinterpreted both 1/4 and 2/4.  I read them as "add
this delay so the PLEXTOR device works", but in fact, I think in both
cases, the delay is actually to enforce the PCIe r6.0, sec 6.6.1,
requirement for software to wait 100ms before issuing a config
request, and the fact that it makes PLEXTOR work is a side effect of
that.

The beginning of that 100ms delay is "exit from Conventional Reset"
(ports that support <= 5.0 GT/s) or "link training completes" (ports
that support > 5.0 GT/s).

I think we lack that 100ms delay in dwc drivers in general.  The only
generic dwc delay is in dw_pcie_host_init() via the LINK_WAIT_SLEEP_MS
in dw_pcie_wait_for_link(), but that doesn't count because it's
*before* the link comes up.  We have to wait 100ms *after* exiting
Conventional Reset or completing link training.  

We don't know when the exit from Conventional Reset was, but it was
certainly before the link came up.  In the absence of a timestamp for
exit from reset, starting the wait after link-up is probably the best
we can do.  This could be either after dw_pcie_wait_for_link() finds
the link up or when we handle the link-up interrupt.

Patches 1 and 2 would fix the link-up interrupt case.  I think we need
another patch for the dwc core for dw_pcie_wait_for_link().

I wish I'd had time to spend on this and include patches 1 and 2, but
we're up against the merge window wire and I'll be out the end of this
week, so I think they'll have to wait.  It seems like something we can
still justify for v6.16 though.

This also means I don't think we should need an NVMe quirk.

> If I understand Mani correctly, he thinks that we should queue up PATCH 1/4
> and PATCH 2/4 (although with modified commit messages).
>
> As you know, I do not have the (problematic) Plextor drive, so we go with
> the quirk option, then we would need to ask Laszlo nicely to retest.
> (And to provide the PCI device and PCI vendor ID of his NVMe device so we
> can write a quirk.)

