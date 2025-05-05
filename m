Return-Path: <linux-pci+bounces-27138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC9AA8F6D
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F5E17531F
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699B1F5841;
	Mon,  5 May 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HmlQMGOs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F751F5834;
	Mon,  5 May 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437010; cv=none; b=OfdLKsvO1lFZzN8i4gQqBFp23f4AtpTwhPl1e38xvxp7LRfyedaBkI4bLirYtxv/GsIMzzanzDBMJVQ6MLbYnMDs0FSbWHLECa+vx99UsX1g2n2U39BSqPIAvBKrPhrIFybesD0h/EG50Sa4X9drKiiVeLoMbxUg7I4yTKEQHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437010; c=relaxed/simple;
	bh=C99pIPS/Le/Uc5zQTrHdjaFOVpjg2ZkEJmloZkMXtvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/bTDXyFX4b/7yiOwVAzR7nYcoCgHPC+9QFCgl9x7zD+k9uwq6RnVfDZzK7EkwaHwjjSC0aeAGl3WoTKEkLNJg81VHWGjCZNfuKOgK7e3Ba1AhaT69jL2Egi5TmqW/bRbMGM2+Do+Y15ahhEl1wQz3VeXuA+HVrEneEuj54sDF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HmlQMGOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3ABC4CEE4;
	Mon,  5 May 2025 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746437009;
	bh=C99pIPS/Le/Uc5zQTrHdjaFOVpjg2ZkEJmloZkMXtvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmlQMGOskHitUpXLg3pc7uXpmnlQTSlMEfkOnyD+/gghhkuc5IVmW4GmUZ4+AsUWx
	 xL5lJ87B2bQ/4Dw3hMpluec6UrhMPBHAeBDW0rZv3PTM+QheZvNjA246lcMRwcrETm
	 q2ZS+1VlRKVuhN/WJ+2PThWQgOZ7jRm2OELWABzg=
Date: Mon, 5 May 2025 11:23:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryan Matthews <ryanmatthews@fastmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 6.6 0/2] PCI: imx6: Fix i.MX7D controller_id backport
 regression
Message-ID: <2025050512-dice-brick-529d@gregkh>
References: <20250504191356.17732-1-ryanmatthews@fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504191356.17732-1-ryanmatthews@fastmail.com>

On Sun, May 04, 2025 at 03:13:54PM -0400, Ryan Matthews wrote:
> Hello,
> 
> This fixes an i.Mx 7D SoC PCIe regression caused by a backport mistake.
> 
> The regression is broken PCIe initialization and for me a boot hang.
> 
> I don't know how to organize this. I think a revert and redo best captures
> what's happening.
> 
> To complicate things, it looks like the redo patch could also be applied to
> 5.4, 5.10, 5.15, and 6.1. But those versions don't have the original
> backport commit. Version 6.12 matches master and needs no change.
> 
> One conflict resolution is needed to apply the redo patch back to versions
> 6.1 -> 5.15 -> 5.10. One more resolution to apply back to -> 5.4. Patches
> against those other versions aren't included here.

If you want to submit patches for those branches, I'll gladly take them,
thanks!

greg k-h

