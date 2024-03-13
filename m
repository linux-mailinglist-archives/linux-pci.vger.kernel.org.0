Return-Path: <linux-pci+bounces-4784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BC487A6CB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 12:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B991F23A9A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3EA44369;
	Wed, 13 Mar 2024 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/Ctlpie"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DF3FB28;
	Wed, 13 Mar 2024 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328150; cv=none; b=EQQvhpd8vxU08M43rU62MZMEcCWONhsH6hFgXgm4sPi99NMaWY6OBl0WfgWiIJVXwQv2e9pNDGCk46ACNOCsLw7dyzBGBCfdvx0wBH0nIWmo62ko441FoxtLjKNjcpHit33M6dnbxJf2aERvQV5Jte88Xsg2sCjBjuwsGLzCnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328150; c=relaxed/simple;
	bh=+7KhbQ0r4aTSlFz/9H9ebVTA5rD0wSrH9ITpUsZtlHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8iWNqhkQgyAY44/FT48955Nhwj44Hdl38RoqQCCZaQvT6s7JJrgMGQYbuNUBajHYa6lJa9AkHr6x2/moZi3IYMaGNs+mWxfQLVTsOPkePSGScVC3E3RyesRKAIHeuBOyoROQq3X2t74Em92igY9YbQ8cNCGrKtJLcEqz2O+lqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/Ctlpie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5F8C433C7;
	Wed, 13 Mar 2024 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710328150;
	bh=+7KhbQ0r4aTSlFz/9H9ebVTA5rD0wSrH9ITpUsZtlHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/CtlpieknVFQYr4x2MZ3ye177KlniREQXVlwK8NkYauHntJt+8KndE+A0q9c0oh1
	 OiyApAA9yuQJU0b410kl3Mxp1LDyqdaE97Ba/iD4JzeB1y/309LtwffLJPFqDy4VhI
	 6hHlAST9iBjsNn5+aO/SnGOFeBgCtR4j8kh62DzImjig9hmBJL1GRQAgrRlhxuNayU
	 NoJ8oMUmRDtvPwSEg6rF1VI/ex1LrEKi6hNMZ6nu62jL015I/g80xOUcQ82H5As1kJ
	 M6vG9juryrDQlkF8LevmX4oEVzatxs+gzKCW5RKfR0I5+52iitsQZgikBDyXx3nPGy
	 L2/9UrwmAEH/A==
Date: Wed, 13 Mar 2024 12:09:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: mani@kernel.org, kw@linux.com
Cc: niklas.cassel@wdc.com, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <ZfGJUDoGnFXKBoG0@ryzen>
References: <20240304224616.1238966-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304224616.1238966-1-Frank.Li@nxp.com>

On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> dw_pcie_ep_inbound_atu()
> {
> 	...
> 	if (!ep->bar_to_atu[bar])
> 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> 	else
> 		free_win = ep->bar_to_atu[bar];
> 	...
> }
> 
> The atu index 0 is valid case for atu number. The find_first_zero_bit()
> will return 6 when second time call into this function if atu is 0. Suppose
> it should use branch 'free_win = ep->bar_to_atu[bar]'.
> 
> Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> it have not allocate atu to the bar.
> 
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Any chance of this fix being picked up?


Kind regards,
Niklas

