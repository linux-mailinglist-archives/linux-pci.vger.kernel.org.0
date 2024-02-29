Return-Path: <linux-pci+bounces-4245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A986C8B9
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03EF1C21613
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685E7CF0C;
	Thu, 29 Feb 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1ShDzzz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC07C6CD;
	Thu, 29 Feb 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208201; cv=none; b=ZQ6RQAhB/umnPleqq+MWYIuBxVZUa+tRCqKrvSIQ7tvow42XoWEM/sXEtgfxdW9Ncm5NFNsLsfxQW88XVKicB5AC6QyFFvaVpuA+jg2dlSFAA//rvCxqVUFqjZ1X30pyHWy9Fk1ZeyItXcka0TA+ALavNr3s0AIOQw2ygYxhbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208201; c=relaxed/simple;
	bh=MO1I6BRIe1jdPOHgt6kCxCyKZVY5TplB/mzeOM1PvPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRozHjgLDA8RrMd1R+ilFR9RQWxR3nFchV+LnK+iVRcCwmdjQZTD+JoGNWYQnVaxXH8j3FKX/YImQslpYisVtDYezg80cYP4bGGqC6li/4seTrqbVtVEWmtZjWTpxq9/ZxlxZnJp6Ty8UyhQLnMtlqOoT5ZPlOTVysWRukMSJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1ShDzzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2952DC433F1;
	Thu, 29 Feb 2024 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709208201;
	bh=MO1I6BRIe1jdPOHgt6kCxCyKZVY5TplB/mzeOM1PvPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1ShDzzzfN+xUuHbXC9aizECOmGkGJG/LFclCDl4pYN5UpX/yGUpfTlPMaImiUNKM
	 oj9a92rO4VCDu9Hwd2aWTWsPo3RM3Hup0gfJycu+xaAmRLekbhAGg2H1YV17dvyDz3
	 ZmK9g1u1qaSuidr3FZsOPHoURQO9EqfMf5ZGo9MYL8RbA6x/nLhKVY74k8f8GpzCvQ
	 YX9s3hMbmmnuKHmTW3XMmtv3oOQFyVoTYzmIc6mWTZJRgnLb/YqMy2vQxZ3NJANPvj
	 2vVQNDlONLU6lmHldLabcg9x/fNocjtwTV/fXkuY0+cdlSBUuQsigsfssfN1xt1YXk
	 n6zxLUn+A880A==
Date: Thu, 29 Feb 2024 13:03:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	"open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Message-ID: <ZeBygq5FngE2vlL-@fedora>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <ZZ1Pj3MvhQNMnP8M@x1-carbon>
 <ZbFEafUmqmE0nrPx@lizhi-Precision-Tower-5810>
 <20240130062938.GB32821@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130062938.GB32821@thinkpad>

On Tue, Jan 30, 2024 at 11:59:38AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jan 24, 2024 at 12:10:01PM -0500, Frank Li wrote:
> > On Tue, Jan 09, 2024 at 01:52:15PM +0000, Niklas Cassel wrote:
> > > Hello Frank,
> > > 
> > > On Tue, Dec 19, 2023 at 03:38:33PM +0100, Niklas Cassel wrote:
> > > > On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> > > > > On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > > > > > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > > > > > dw_pcie_ep_inbound_atu()
> > > > > > > {
> > > > > > > 	...
> > > > > > > 	if (!ep->bar_to_atu[bar])
> > > > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > > > 	else
> > > > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > > > 	...
> > > > > > > }
> > > > > > > 
> > > > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > > > 
> > > > > > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
> > > > > > > not allocate atu to the bar.
> > > > > > > 
> > > > > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > > > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > > 
> > > > > > > Notes:
> > > > > > >     @Niklas:
> > > > > > >     	I have not test your case. I should be equal to previous's fix in
> > > > > > >     mail list.
> > > > > > 
> > > > > > Hello Frank,
> > > > > > 
> > > > > > Thank you for sending a proper fix for this!
> > > > > > 
> > > > > > Personally, I slightly prefer your fix that saves the iatu index + 1, and
> > > > > > keeps 0 to mean unused. That way, you don't need the memset, and you don't
> > > > > > need to change the type to signed, but either way is fine by me, so:
> > > > > 
> > > > > index + 1 don't match hardware iATU index. It will be confused because
> > > > > other parts is 0 based.
> > > > > 
> > > > > So I choose "-1" as free iATU.
> > > > 
> > > > A s8 can hold a max value of 127.
> > > > CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.
> > > > 
> > > > Since the DWC code can be synthesized with 256 iATUs,
> > > > your code will not work on systems with 128 or more iATUs.
> > > > 
> > > > If we continue to use a u8, and offset the saved value by one,
> > > > we will at least be able to support 255-1 == 254 iATUs.
> > > 
> > > Do you plan to send out a v2?
> > 
> > @mani:
> > 	Do you have any comments about this fixes except u8's problem?
> 
> IMO, the core issue lies in the EPF driver. It calls set_bar() during init, but
> it is not clearing the BARs with clear_bar() during LINK_DOWN.
> 
> If the BARs were cleared properly, then we would not see this issue.
> 
> I'm planning to do a cleanup of the behavior of EPF with core_init_notifier and
> it should get addressed there.

Hello Mani, Frank,

Please reconsider respinning this.

I think that the invalid usage of find_first_zero_bit() is very bad,
because other people might copy the find_first_zero_bit() usage here.


find_first_zero_bit() can (and will) return 0, so this check is just bad:

if (!ep->bar_to_atu[bar])
        free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);

...

ep->bar_to_atu[bar] = free_win;
set_bit(free_win, ep->ib_window_map);



No matter which code Mani adds that cleans up the BARs, will not change that
the logic is this function is just broken.


Kind regards,
Niklas

