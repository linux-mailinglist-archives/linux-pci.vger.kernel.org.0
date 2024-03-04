Return-Path: <linux-pci+bounces-4464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93983870922
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEFBB2175A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7162169;
	Mon,  4 Mar 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpdtfwsL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9726293;
	Mon,  4 Mar 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575815; cv=none; b=pxO+BCPOEFUo1tmWhSH8TrAntXCiRnbsjozUsPRI/+GKFn764N8qkfoajDB6N+tKwia+MBS2rq2UA0VI9WgpTiM2Ua2FsC8nx+uERKY7mDMdQ6fk05i/aJRrNLxcLCAcAuK6m7nOIdhKaa4DFBLCiSCoxz9fs08hKY4lfk0PZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575815; c=relaxed/simple;
	bh=YJmIavFMR6say4T2gPlCdP0mAQxdfMHCADJvcoW5zqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0vihvZYE888dZiP69rPN5PfeOEhohM1b0CaIGy6SVs3T9xSdkbPpLvOgCWiN84nQAZNQA81Rw9FrDq3DmsmiBZKOtI2XoQiOTtC9Y6ASO/fUH7NEuyLC3W2zC+8zM/6jGNAF2jhzbqXE9/EaNP+MFmnKvZtdrThimHgbRlls6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpdtfwsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2576C433C7;
	Mon,  4 Mar 2024 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709575814;
	bh=YJmIavFMR6say4T2gPlCdP0mAQxdfMHCADJvcoW5zqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpdtfwsL+h7P/b/UfpLI59LGVNwrjGuTCEz0J4woBogOwVsfggwUqNoh7D7+/63V2
	 jFu+B6IS60gR+oubc1ompfOWcqHLG7HS9fP1PgPwf1rkB7P0sfJIuD4Md8djdhLSud
	 +i0W+3JawL/DkHwMLwq1Tsr2/5J3O+fGVS+6sKRkFODemceB3FpR8JjjBWyDmqdTeA
	 5kDxgmy7OpGg/xxFgnE0eaATfw+Hpp+4KlWdXy/Uq7pm3qER92kzmuV+lNotBfNeNk
	 ZzY0w9NV6RPgIj8Z9i43IWTBP4zz6Ea838Y1a/BLWNNKb2xXLG/M8rd/wBQoENu3au
	 NfvzmlkKmtvQQ==
Date: Mon, 4 Mar 2024 23:40:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
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
Message-ID: <20240304181005.GF31079@thinkpad>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <20240304084841.GJ2647@thinkpad>
 <ZeX7KDuwLWxwb5Kw@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeX7KDuwLWxwb5Kw@lizhi-Precision-Tower-5810>

On Mon, Mar 04, 2024 at 11:47:36AM -0500, Frank Li wrote:
> On Mon, Mar 04, 2024 at 02:18:41PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Dec 19, 2023 at 02:38:34PM +0000, Niklas Cassel wrote:
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
> > > 
> > 
> > Agree. I cannot suggest a better alternative. So let's go with this. But please
> > add a comment before bar_to_atu assignment to make it clear. Like,
> > 
> > 	/*
> > 	 * Always increment free_win before assignment, since value 0 is used to
> > 	 * identify unallocated mapping.
> > 	 */
> > 	ep->bar_to_atu[bar] = free_win + 1;
> 
> This patch already change to use "-1" as free. Only issue for this patch is
> that use 's16' instead of 's8' becasue max ATU number is 255.
> 

Niklas's initial suggestion of keeping u8 for the array and 0 as the unallocated
placeholder sounds good to me. Please use that instead.

Even though iATU window index starts from 0, the comment I suggested will
clarify what this bar_to_atu[] does.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

