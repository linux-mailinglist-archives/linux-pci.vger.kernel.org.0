Return-Path: <linux-pci+bounces-31645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369CCAFBE75
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 01:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872E84A20D9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5381F4168;
	Mon,  7 Jul 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkWkvw1u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A91DE89B
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929302; cv=none; b=lL2tephZqr6vH8+4IykSuTniQstlIOdcCqaZvGKoncmGV3UHmaEXxixASg9PpiLtrJXaLiEkc/aYAa2PUOBOhp1hZKk6ZA+KG1AfQ/YfG+lsoxuG5v/IL64DPCzR5+GyShVjmNTWzN2aHFUQQUB2FAnMfLZ+eLVudt+s/7Xdrq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929302; c=relaxed/simple;
	bh=20XYc04w1H8H6Wa2jSu/5CS2biD5515weaTKphOHlHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NzzxGXoDdAamUaTQ1722LFABi8UbHET470NgEFx4mixhIKjIc3LPTQL6/F8UpY/P2TdzAgZhxFRqaEptiGzt3tR5NkO4Wx7NOBXQC+ptEI1gMNELRE/3nbG1Q6zSG50c9deLpgceb0MwbEPh2EAwh2r09lnwfM+Plss02YrqWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkWkvw1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E4BC4CEE3;
	Mon,  7 Jul 2025 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751929302;
	bh=20XYc04w1H8H6Wa2jSu/5CS2biD5515weaTKphOHlHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PkWkvw1u5+rC9NXh4VVRrwJ0czGfWmw1jB74PfWS/4+nbnHxQ8KbNaB4D0pWDzER0
	 MnSdTNG6xmf9xwu7/PUkTEMSllBQfkifV2SbqCSQC24TKoYDoGEwE2GD97oMJVcm9x
	 WdOJbBEL3k33EzsitIitOfnjvmGP7UN/q6qBfbuvavOrApbFsjJKKyMUbvfqk+SYkr
	 boDZI444/ILWStwbk5drJ1yBgDrm/6PEls75HSZ4EbrUIswR9KEa416fIKVha56XRl
	 onrb+UbEYNK8YapcziBTiWRr7BvsXhFzdFjAi14i0YyEmAxToX1ViQ/MGawxh5d31k
	 eN98BxS8hKGxg==
Date: Mon, 7 Jul 2025 18:01:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <20250707230139.GA2122052@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hhyxhxvohmeqzjdu3amabcpf3e4ufi4ps5xd2uia4ea6i2u5oj@sxyjavqyqc7m>

On Wed, Jul 02, 2025 at 08:17:44PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 02, 2025 at 11:43:11AM GMT, Niklas Cassel wrote:
> > On Tue, Jul 01, 2025 at 11:38:44AM -0500, Bjorn Helgaas wrote:
> > > > 
> > > > No. The PERST# delay should be handled by the glue drivers since
> > > > they are the ones controlling the PERST# line. Doing an
> > > > unconditional wait for both the cases in DWC core, seems wrong to
> > > > me.
> > > 
> > > It ends up being a little bit weird that the delay is in the DWC core
> > > (dw_pcie_wait_for_link()) for ports that support fast links, and in
> > > the glue drivers otherwise.  It would be easier to verify and maintain
> > > if the delay were always in the DWC core.
> > > 
> > > If we had a dw_pcie_host_ops callback for PERST# deassertion, the
> > > delay could be in the DWC core, but I don't know if there's enough
> > > consistency across drivers for that to be practical.
> > 
> > Currently, there is not much consistency between the glue drivers,
> > so adding a DWC core API to assert/deassert PERST# sounds like a
> > good idea to me. The callback could even be supplied a struct
> > gpio_desc pointer.
> 
> +1 for consolidating the PERST# handling. But just FYI, I'm going to
> move the PERST# deassert handling from controller drivers to pwrctrl
> drivers as once pwrctrl drivers are used to control the power
> supplies, they should control PERST# as well. Currently, this is the
> missing piece for pwrctrl framework.
> 
> Also, we cannot entirely get rid of the PERST# handling in
> controller drivers, since they need to assert PERST# before
> resetting the RC during init.

I thought pwrctrl was optional.  The PERST# management is not
optional, is it?

Bjorn

