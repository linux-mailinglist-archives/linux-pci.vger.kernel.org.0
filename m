Return-Path: <linux-pci+bounces-40341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C0C35459
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 12:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD12A34D579
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 11:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B130F545;
	Wed,  5 Nov 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb1higuk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D630F539;
	Wed,  5 Nov 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340419; cv=none; b=GjjFeQBzZBiDUrK1kAUjXCBi2yo+eUqHZWS3ejG+RrvzlLfQCOtdel5TVt1EnyzhgakiYGb+d0FODaz+9REWFfovJMlNQ2jn4Ig7wL+E+P6BthS3LtyUyYIIiSe7bCx2ScWL1I9uJrhEpb5MuGh1cImNu+1ls7fArUqEg0gjP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340419; c=relaxed/simple;
	bh=B+4pOh83F8unCV02t+zRv+dq7jLqx/Ju8WvlRa4iwIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXDL/He0W0LCmxbR9/Ok+JXPiSiB8+0bqtma1khx8QOVHUpIJeVA5I4IuMSv9QhDe+hBVLlOFvWX50iGApFKrRlD1yyTKjMtN4Ad4VQKPVkHPG521bqts/a2J2TVvFxERn8hc1kaBOygUkg+E1FEH4rc41+LqSfHegvsHgKZWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb1higuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D59EC4CEF8;
	Wed,  5 Nov 2025 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762340419;
	bh=B+4pOh83F8unCV02t+zRv+dq7jLqx/Ju8WvlRa4iwIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb1higukqPOJoexZHUEDVn6rdv63fY6hwZ3LV4uK9zfaqjIuKOMWH7LZ4d0ei9f6i
	 +Egjj7f7HKarz2VVvZFrRKdipbZCs+gjsHMTO/1Q8LUrz0zUhTV5XVBL3pohY5XmHu
	 RysFQqMm2Isu9fWxUx2TjLmXekMKFPGNnX0QFn3oEI7OyfZt3sv6P0bdlxlGaO0i9V
	 P/E4gdoX5HoPqW2RoSwNAE9CLBeXGYyQl+5WI6HlAHVwhNjGJDIdAQEsDQLbnfQzBZ
	 qTAvA4Jc11XR+uK5HGEm/v7qUH+IwW7fYLF3eo0KdMaV6ttUikGFpjQCV0FDT5y/9P
	 Sis0E2ZpiD/0A==
Date: Wed, 5 Nov 2025 12:00:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <aQsuO5WaYPK0KbVw@ryzen>
References: <20251022174309.1180931-4-vincent.guittot@linaro.org>
 <20251022190402.GA1262472@bhelgaas>
 <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>
 <aQsmtKsTEmf7e7Sd@ryzen>
 <bf3b2d2a-ce3e-87af-4154-abd022c6a3b4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf3b2d2a-ce3e-87af-4154-abd022c6a3b4@linux.intel.com>

On Wed, Nov 05, 2025 at 12:43:09PM +0200, Ilpo Järvinen wrote:
> On Wed, 5 Nov 2025, Niklas Cassel wrote:
> 
> > On Fri, Oct 24, 2025 at 08:50:46AM +0200, Vincent Guittot wrote:
> > > On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > > > +
> > > > > +     val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> > > > > +     val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > > > > +     dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> > > > > +
> > > > > +     /*
> > > > > +      * Set max payload supported, 256 bytes and
> > > > > +      * relaxed ordering.
> > > > > +      */
> > > > > +     val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> > > > > +     val &= ~(PCI_EXP_DEVCTL_RELAX_EN |
> > > > > +              PCI_EXP_DEVCTL_PAYLOAD |
> > > > > +              PCI_EXP_DEVCTL_READRQ);
> > > > > +     val |= PCI_EXP_DEVCTL_RELAX_EN |
> > > > > +            PCI_EXP_DEVCTL_PAYLOAD_256B |
> > > > > +            PCI_EXP_DEVCTL_READRQ_256B;
> > > > > +     dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> > > >
> > > > MPS and relaxed ordering should be configured by the PCI core.  Is
> > > > there some s32g-specific restriction about these?
> > > 
> > > I will check with the team why they did that
> > 
> > Most likely, the reason is that, the PCI core does not set the MPS to the
> > maximum supported MPS for the root port.
> 
> PCI core set/doesn't set MPS based on config. Perhaps try with 
> CONFIG_PCIE_BUS_PERFORMANCE.

Sorry, I should have been more clear.

Since a lot of PCIe controller drivers have similar code to the above,
it is obvious that a lot of controller drivers want to increase the MPS
regardless of PCIE_BUS_* bus config value.

With the current PCI code, MPS for root ports will not be touched if
PCIE_BUS_TUNE_OFF or PCIE_BUS_DEFAULT.

After the above series, MPS for root ports will be set to max supported
also for PCIE_BUS_DEFAULT.


Kind regards,
Niklas

