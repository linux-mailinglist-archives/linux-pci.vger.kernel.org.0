Return-Path: <linux-pci+bounces-28318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A8AC1D71
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 09:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574347ABF68
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 07:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BC11A0BE0;
	Fri, 23 May 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7VypC0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077319C554
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747983763; cv=none; b=kgRMP/p/VWlil6zzVXZ4rDHzL1gKMOvL1fve+XbTpkAG2HvFT0GB1+hKnfvq/2Qyc3PytJYu1R8ucpBGyLGK7XashDYu/vchJjZbTMMMUZ5+oonmlhAv7xt/qra7EJjQQvujO89XbO57bqqdzaJe8+xhp2EpUlh1KRm7jFtBIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747983763; c=relaxed/simple;
	bh=8r9Hi1gIyfVoTRlx/Tn8V/O9/Gd9U8ajp1fOgP9tvqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmthIxDsKaD2PS7BY4jMPWG+ZSQQw5GabLyK7883EVBAy31LLe26qmD7z9TTDhjDt8qbb3jMDw72U32tbkEoPhlD+jD+di8RzJWjDfMnvi7PPQ3geGzq+sJSeesUEUcv8BWfKiSIIfEFPax44PHUL5/+THh3RO4+6/vpFHuEWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7VypC0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72507C4CEE9;
	Fri, 23 May 2025 07:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747983762;
	bh=8r9Hi1gIyfVoTRlx/Tn8V/O9/Gd9U8ajp1fOgP9tvqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7VypC0+9B8QVZQIpk5LceZtLwlO11iVcVRN4XMp4ucopeqzikvpP1dhvOKGs5Fvx
	 1TcyaXlJpnR84Hx7sIRWOTEmR1l1kDiHLCn2l9JhhflsFN/dUhm+sPUz++QOPAPujC
	 GjRJDACA5nB+mjfvCE/lu6V0zCW6FJgLFImTlg0lUrdcw1PFmG7NVgDqFksB0CCmGu
	 wlwleAwMEJHl2qP+Bcb+wxEsXZ9JaNFz53KMDWGuhsaG1VxPBa/m/vE3uQzOpHq0xm
	 jseKAwy2mlnTr1XFI2GJMR8649jpRl80H4p+uTWTa/QOwb2KKERT9XOmyifNH9Xpa1
	 9hlaoB5/hgo3Q==
Date: Fri, 23 May 2025 09:02:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <aDAdjie1jGBQ-mKf@ryzen>
References: <aC9OrPAfpzB_A4K2@ryzen>
 <aDAInK0F0Qh7QTiw@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDAInK0F0Qh7QTiw@wunner.de>

On Fri, May 23, 2025 at 07:33:16AM +0200, Lukas Wunner wrote:
> On Thu, May 22, 2025 at 06:19:56PM +0200, Niklas Cassel wrote:
> > As you know the reset_slot() callback patches were merged recently.
> > 
> > Wilfred and I (mostly Wilfred), have been debugging DMA issues after the
> > reset_slot() callback has been invoked. The issue is reproduced when MPS
> > configuration is set to performance, but might be applicable for other
> > MPS configurations as well. The problem appears to be that reset_slot()
> > feature does not respect/restore the MPS configuration.
> 
> The Device Control register (and thus the MPS setting) is saved via:
> 
>   pci_save_state()
>     pci_save_pcie_state()
> 
> So either you're missing a call to pci_restore_state() after reset,
> or you're missing a call to pci_save_state() after changing MPS,
> or MPS is somehow overwritten after pci_restore_state().
> Which one is it?

I kind of liked the earlier revision of Mani's series where we kicked the
devices off the bus, that way, we would re-use the exact same code paths
as when doing the initial enumeration.

Also, by removing the device, the exact same solution works fine both for
link-down (since the device might never come back again), and for a sysfs
initiated reset.


Anyway, I'm happy with whatever solution that works.

Adding pci_save_state() + pci_restore_state() seems fine, but since things
are not working, I assume that those calls are missing, at least of the
bridge.

Are we also missing similar pci_save_state() + pci_restore_state() calls
for the EP?


Kind regards,
Niklas

