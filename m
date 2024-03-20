Return-Path: <linux-pci+bounces-4941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686AD880DE9
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FE5282034
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D526F38DE8;
	Wed, 20 Mar 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svykZRpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A0D38F87;
	Wed, 20 Mar 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924800; cv=none; b=XORFvZ5W4slC1/rsu3cCr1U20PsZ1loYLuH6JeRUgWfBFX9frucv39NftOgmbtUMJ9NgERL/HPAos2UL9NfkQLK4a6G/8gsjY75l4J/zIxxwT/B4H8ckF0LCbDpt5Mg/zd92AVuQN9bkQeNOiNtlUJXx8m1K2ltwYN14De7fBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924800; c=relaxed/simple;
	bh=Hm2riJtd650UaySoI5zk2/Fz4N5cO62JP24YUJdeUFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov1M2vhL6dzLThrz7HI/iLzzqqUgtzC+qWLjPHZDncVUfxtkT5uMHi2MKrqpLyny1Ei4jGsXXEIM96wL9nAh3gxEgG0+r9vSO2HZQ6ib74GTW82g7sifukGZLB+Tw8DYZRsl3otoqUMm3/nn1yhRuosUmXag/u6odpG0wwy3BG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svykZRpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CE8C433C7;
	Wed, 20 Mar 2024 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710924800;
	bh=Hm2riJtd650UaySoI5zk2/Fz4N5cO62JP24YUJdeUFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svykZRpU4KKqc2BI9hhjROoJQvQX+adJEzBEJQogM9CzMFfwi51Lb3qN7cM+l0Yq9
	 uO8W+G8fURfyMf0bqCQ9jtdwcVTCuaRiEgWb+LMb507VXhi9si6HPAuENby7dNd7Nn
	 E6ruFi0wK0ahIxkVK+fbLrm8k0/47aMz4/KKlypzdGGUhapz6CbaBGAvQckzVjwZdo
	 lKW7RoTePwUyUTYl8qoxdMvV/Z5B+ffK+dHR7tnswe3/5svHtaDOH9+QIUmzhPblgf
	 LbfDovXAU15Vp5yr/tqWsqjFAhkf/3tx+2HF5EN5DXuaUpMx37z7XFYfxICRbl60aq
	 bonsoz3/1HMqg==
Date: Wed, 20 Mar 2024 09:53:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: mani@kernel.org, kw@linux.com
Cc: niklas.cassel@wdc.com, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <Zfqj-mvpG442eyt2@ryzen>
References: <20240304224616.1238966-1-Frank.Li@nxp.com>
 <ZfGJUDoGnFXKBoG0@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfGJUDoGnFXKBoG0@ryzen>

On Wed, Mar 13, 2024 at 12:09:04PM +0100, Niklas Cassel wrote:
> On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > dw_pcie_ep_inbound_atu()
> > {
> > 	...
> > 	if (!ep->bar_to_atu[bar])
> > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > 	else
> > 		free_win = ep->bar_to_atu[bar];
> > 	...
> > }
> > 
> > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > will return 6 when second time call into this function if atu is 0. Suppose
> > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > 
> > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > it have not allocate atu to the bar.
> > 
> > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> Any chance of this fix being picked up?

Gentle ping.


Kind regards,
Niklas

