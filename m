Return-Path: <linux-pci+bounces-11772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02E295509B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 20:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B1128792A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640DF1C37B3;
	Fri, 16 Aug 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISzqxNJY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C71C37AD;
	Fri, 16 Aug 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832103; cv=none; b=aEjG8WkN9dS0a0nVdmXIoTydIE8+4B433m+CVlagriGQ1gHKnMco6SQKmBQCM97Zva+sSW0zmjIkalJrxn01ddTCy35oRG5L2dAVHmo2J5xYhi2ssN3tXh5/Tbwn1CZyZqHsLA2Y27FAlv/3BfcZ0/QP5MhwPSeV5qIvGeTXNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832103; c=relaxed/simple;
	bh=MPaxgKSJ0dt6fc/76U2yEOjWmyHDvuaEFwK8jMqY6Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mbDbOh+tsDlAleEn80ajfRVnFmAK5Qy/dPWRh+nPIJZ8J9GfpKSezLHdsNuJ2ooQcnd7Ly8Q1PojceaGu8TxiVfNS5ziqRGsgH/C3mRqjrJMvJ0JUskVnZCwwB9K601QV1eP6MSp392n3R8l+OtoAEsue50hhES/eavFPnDqQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISzqxNJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FD3C32782;
	Fri, 16 Aug 2024 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723832102;
	bh=MPaxgKSJ0dt6fc/76U2yEOjWmyHDvuaEFwK8jMqY6Gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ISzqxNJYddmRWWWiNmH7cMLSjANJyDrivO8wJDXMuVVuqj2jtgp/Qr33wI8nm5wDI
	 zHexfalc9MWdVwBL3gcSaBX5jdcx3Pz9akPNDm4S67LPyksTXHNNFN27sOUtNfAjq6
	 QbJOa5SFLHPaa4cXAsVvvHE146kFPJgW1RCx9exo9sNwonNru9a8KNUth3lFwIIOed
	 suv2K1HTSKv3WUsG4cK6Yp+4C3lBXgrOaG8t82XfMebhn4hofJUY2bmvI2UZabDuok
	 FgwWjZr8K14cul9KcH6+2aOfP6BG4i2OgWFymioROOXvA8gJiCMZtRROBrH8gprnL7
	 Rf5KdYqECP7JA==
Date: Fri, 16 Aug 2024 13:15:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/4] MAINTAINERS: drop NXP LAYERSCAPE GEN4 CONTROLLER
Message-ID: <20240816181500.GA69082@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr+H3gHZ/B7zTKBW@lizhi-Precision-Tower-5810>

On Fri, Aug 16, 2024 at 01:09:50PM -0400, Frank Li wrote:
> On Fri, Aug 16, 2024 at 11:12:31AM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Aug 15, 2024 at 03:15:52PM -0600, Rob Herring wrote:
> > > On Thu, Aug 15, 2024 at 9:53 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > On Thu, Aug 08, 2024 at 12:02:17PM -0400, Frank Li wrote:
> > > > > LX2160 Rev1 use mobivel PCIe controller, but Rev2 switch to designware
> > > > > PCIe controller. Rev2 is mass production chip. Rev1 will not be maintained
> > > > > so drop maintainer information for that.
> > > >
> > > > Instead of suddenly removing the code and breaking users, you can just mark the
> > > > driver as 'Obsolete' in MAINTAINERS. Then after some point of time, we could
> > > > hopefully remove.
> > >
> > > Is anyone really going to pay attention to that? It doesn't sound like
> > > there's anyone to really care, and it is the company that made the h/w
> > > asking to remove it. The only thing people use pre-production h/w for
> > > once there's production h/w is as a dust collector.
> > >
> > > If anyone complains, it's simple enough to revert these patches.
> >
> > My comment was based on the fact that Bjorn was not comfortable in removing the
> > driver [1] unless no Rev1 boards are not in use and Frank said that he was not
> > sure about that [2].
> >
> > But I think if Frank can atleast guarantee that the chip never made into mass
> > production or shared with customers, then we can remove the driver IMO. But that
> > is up to the discretion of Bjorn.
> 
> I think Bjorn's request is impossible task. Generally chip company send
> out some evaluted sample to parter, which use these sample to built up
> some small quantity production. Chip company have not responsibility to
> call back this samples. There are always some reasons to drop mobivel and
> switch designware, it may be caused by some IP issues which can't match
> mass production's requirememnt. Such informaiton already removed from
> nxp.com. Only Rev2 left.

If you're reasonably confident that nobody will notice the removal of
support for Rev1, we can include that in the commit log and just
remove it.

The original commit log basically said "we don't want to support Rev1"
without any indication of where those parts went or whether anybody
might care about them.  But if Rev1 only went to partners for
evaluation and we don't expect end users to have them, I think it's
reasonable to say that and remove the code.

Bjorn

