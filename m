Return-Path: <linux-pci+bounces-25547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 128B3A820E7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 11:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F0B19E8337
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72E2594;
	Wed,  9 Apr 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk6RplNs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2625A62C
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190347; cv=none; b=m6pXvEQpgbyUfvkWIDc2J1G0+ALJafyIpeaCusz7EHBjStBWtzKSxYxV4kyhv4zojksTYVsFTb45TtfsonDwsePeRaGmPxBoi2Hx7mBYqzNmebprtX2nKGxlE4iJ+YrpVHfk6JuWf3KAdPtCTaTV/h2fn0pnVGPOCh+vUjOmOjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190347; c=relaxed/simple;
	bh=xIdfVkfEMheXajfoX8bSuDYovCWOHxRP/hPk7KxSxc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS146sxSh9nU3l3W54T6vk2Xr7RQ8yuARwIsamZDAkernxehbLrQN3ip605C8UDSYU2QJp/MtXbK/x6/gfSsvJGOlhtrNEdH3CjcvVC/75C1crZc/QhKygNzbWymDz8gjd634EP02pS0BR8EU0uDcbugLSMqJ6wR0zHo99m4zbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk6RplNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED9EC4CEE3;
	Wed,  9 Apr 2025 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744190347;
	bh=xIdfVkfEMheXajfoX8bSuDYovCWOHxRP/hPk7KxSxc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tk6RplNsnJU8ekqnpays0RwVhnuYxpWFheA7OGqyvI8/7UTKiz0bNKrOxizqt8Pyo
	 MfzcoxgYgD0WTZPwRvkBN2zF3fOlGTMDM6uEpsn4yKY55GurxGC57MwsChiiQXOiRb
	 V6lx+2OxYizluQTFvbQm5uU8BziuGeSHiCPBnLhnuesn7TjYA4tjyBQeEenxMo9NcH
	 KLredw9GIVLR9EbJReyvWyJrk5Nh6m5dOBKvRXNbX8eJT7OFd0de1WUGT8uzdRGumx
	 PV7NAl32N/Cb2WrrXyppNrSzgQl5ax0qOljGrOWuUvegij9DqwABNw1hzOBbszkOjp
	 b9GR2GwewtS+Q==
Date: Wed, 9 Apr 2025 11:19:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()
Message-ID: <Z_Y7h1vzVCCEiXK6@ryzen>
References: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_YwNt6WUuijKTjt@ryzen>
 <38e69551-cc40-11a9-191f-de9a193c5e51@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38e69551-cc40-11a9-191f-de9a193c5e51@rock-chips.com>

Hello Shawn,

On Wed, Apr 09, 2025 at 05:09:38PM +0800, Shawn Lin wrote:
> 在 2025/04/09 星期三 16:30, Niklas Cassel 写道:
> > On Wed, Apr 09, 2025 at 02:40:33PM +0800, Shawn Lin wrote:
> > 
> > Is there any advantage of using a rockchip specific way to read link up,
> > rather than just reading link up via the DWC PCIE_PORT_DEBUG1 register?
> 
> This is a very good question which we tried but made real products
> suffer from it for a long time, and finally we found the reason and
> discarded it.
> 
> Quoted from DWC databook, section 8.2.3 AXI Bridge Initialization,
> Clocking and Reset:
> 
> "In RC Mode, your AXI application must not generate any MEM or I/O
> requests, until the host software has enabled the Memory Space Enable
> (MSE), and IO Space Enable (ISE) bits respectively. Your RC application
> should not generate CFG requests until it has confirmed that the link is
> up by sampling the smlh_link_up and rdlh_link_up outputs."
> 
> Quoted from DWC databook, section 5.50 SII: Debug Signals
> "[36]: smlh_link_up: LTSSM reports PHY link up or LTSSM is in
> Loopback.Active for Loopback Master" which refers to
> PCIE_PORT_DEBUG1_LINK_UP per code.
> 
> The timing in dwc core is drving smlh_link_up->L0->rdlh_link_up->FC
> init(a fixed delay) from IC simulation when linking up.
> 
> The dw_pcie_link_up() wasn't reliably work as expected by massive test.
> The problem is clear from our ASIC view, that cxpl_debug_info from DWC
> core is missing rdlh_link_up. cxpl_debug_info[32:63] is indentical to
> PCIE_PORT_DEBUG1, So reading PCIE_PORT_DEBUG1 and check
> smlh_link_up isn't enough.
> 
> The problem was introduced by commit 1 and fixed by commit 2 but not to
> the end. And finally commit 3 rename the register but not fix anything.
> 
> It was broken from the first time. Any dwc controllers should not be use
> the buggy default method to check link up state from our view.
> So this's the whole story for it, which may help you understand the
> indeed problem and why we reinvent rockchip_pcie_link_up() here.
> 
> [1]. commit dac29e6c5460 ("PCI: designware: Add default link up check if
>     sub-driver doesn't override")
> 
> [2]. commit 01c076732e82 ("PCI: designware: Check LTSSM training bit
>     before deciding link is up")
> 
> [3]. commit 60ef4b072ba0 ("PCI: dwc: imx6: Share PHY debug register
>     definitions")

Thank you for the detailed answer.

It seems like we should really add a warning and a comment in
dw_pcie_link_up(), so that others don't get hit by this hard to debug issue!

(Especially since dw_pcie_link_up() was added by someone with a @synopsys.com
email).


Kind regards,
Niklas

