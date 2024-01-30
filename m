Return-Path: <linux-pci+bounces-2763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26781841BF8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 07:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C4A1C21C0A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 06:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA2B2030A;
	Tue, 30 Jan 2024 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdNNbh7W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9383CF64;
	Tue, 30 Jan 2024 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596187; cv=none; b=CJR7lirMbf4+uO3AmcYB1hpx5d8XMYbYRfWP9otLEdxcCWDCbXtgh9P7EWSUYfxQoT9+1anPrAD7jqVzWcL8bjOC+MHngZv5YXlQyGnDtxPIF8DP+D4Xu6Zn+An2JHCIyOtc2BrxOqldUwhIXYCbzTyHZOiYRBol5YGBsB0vzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596187; c=relaxed/simple;
	bh=4RXiLjjCpdwVPEn44o+e/R+yfwydJCtTihSGXtdQwu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBD4CsAHHIaVIKyLCGWaxSvmrp1ns4kMjunQwrOhuu9k+zJXvo81N9VcNbcaTwAwGxolhbAd5tjDdJUGPWvkB7dhvFXMC6dtyacqAntBych2bdLOIXIAjZEDdOPpYT3Kyn1qt9ZOOyYKahcZC2fuKOTk3lJqmfCHeSqKIG+zYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdNNbh7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0A1C433C7;
	Tue, 30 Jan 2024 06:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706596187;
	bh=4RXiLjjCpdwVPEn44o+e/R+yfwydJCtTihSGXtdQwu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdNNbh7W2uOcizdj3SrTaKbXwq2095hJeN9iP9VBCdYuCFxLoDAheLVxBbBxXPtLo
	 MlfBlJNZU+cqUxQTEfHiVJkhl7ly+9qXwpf26JqTKsWrE0TxRmE+Bb9BsVskd5Lqsz
	 2s8rlz7v2xYmHntJIeDC+1yF/ognq0CbWR6OlmCkkxQh0Bti6iDKPcppl5om1mWq+X
	 0kdlynLncDbPOw2ERhhXTjleaKT7PeV/WvR5/a78pedJJbGBJuNNkb3Al+Dsb+4PYF
	 vRJfkegN7KzJlHijqo7r8+c/0/De/M1eFoTYWMUf0XziiCz+UzNkMMsmZF7k1IjqjC
	 fXGqBXTlHgJiA==
Date: Tue, 30 Jan 2024 11:59:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	"open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Message-ID: <20240130062938.GB32821@thinkpad>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <ZZ1Pj3MvhQNMnP8M@x1-carbon>
 <ZbFEafUmqmE0nrPx@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbFEafUmqmE0nrPx@lizhi-Precision-Tower-5810>

On Wed, Jan 24, 2024 at 12:10:01PM -0500, Frank Li wrote:
> On Tue, Jan 09, 2024 at 01:52:15PM +0000, Niklas Cassel wrote:
> > Hello Frank,
> > 
> > On Tue, Dec 19, 2023 at 03:38:33PM +0100, Niklas Cassel wrote:
> > > On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> > > > On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > > > > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > > > > dw_pcie_ep_inbound_atu()
> > > > > > {
> > > > > > 	...
> > > > > > 	if (!ep->bar_to_atu[bar])
> > > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > > 	else
> > > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > > 	...
> > > > > > }
> > > > > > 
> > > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > > 
> > > > > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
> > > > > > not allocate atu to the bar.
> > > > > > 
> > > > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > > 
> > > > > > Notes:
> > > > > >     @Niklas:
> > > > > >     	I have not test your case. I should be equal to previous's fix in
> > > > > >     mail list.
> > > > > 
> > > > > Hello Frank,
> > > > > 
> > > > > Thank you for sending a proper fix for this!
> > > > > 
> > > > > Personally, I slightly prefer your fix that saves the iatu index + 1, and
> > > > > keeps 0 to mean unused. That way, you don't need the memset, and you don't
> > > > > need to change the type to signed, but either way is fine by me, so:
> > > > 
> > > > index + 1 don't match hardware iATU index. It will be confused because
> > > > other parts is 0 based.
> > > > 
> > > > So I choose "-1" as free iATU.
> > > 
> > > A s8 can hold a max value of 127.
> > > CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.
> > > 
> > > Since the DWC code can be synthesized with 256 iATUs,
> > > your code will not work on systems with 128 or more iATUs.
> > > 
> > > If we continue to use a u8, and offset the saved value by one,
> > > we will at least be able to support 255-1 == 254 iATUs.
> > 
> > Do you plan to send out a v2?
> 
> @mani:
> 	Do you have any comments about this fixes except u8's problem?

IMO, the core issue lies in the EPF driver. It calls set_bar() during init, but
it is not clearing the BARs with clear_bar() during LINK_DOWN.

If the BARs were cleared properly, then we would not see this issue.

I'm planning to do a cleanup of the behavior of EPF with core_init_notifier and
it should get addressed there.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

