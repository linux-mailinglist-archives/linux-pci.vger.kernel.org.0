Return-Path: <linux-pci+bounces-11608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4D94F898
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 22:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6629E1C21FF8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 20:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5911953BA;
	Mon, 12 Aug 2024 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqk1YA28"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B371953B9
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495922; cv=none; b=JH9tRqMLqLJ2PSjEKhOrEva0TdKnCDjedzQEnOEpheiABSklmOBm3VIFMOxacSeavp1JOLWd7PRwTgk2ZPZAz+TwOn3jR1msG/hVp5BlqlpquMdx/urRtMo1ytCvUGpwNIeHmDzoOiv3j+iph0GWJ8NQvN+7jJz1jGFN1I+yhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495922; c=relaxed/simple;
	bh=DZ0hQS/c94qn/XFsawd7xcd49Yafc+HqB7hz6RNUVaI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N5metRrHkWIqyEb02bIYsx1IxkgotzwQVFCyUWcjUmnC+boCbu8erG9/OURGiCGWtEQrIPTpgn+7JND7+L4x/pyaOojRtKNtbH9MbVI69fk6wMueZPG0ZA9PTkSi6XefOP0huG3NcKrEGIKft4XPdKBDqpNJnZF2Vo6cSDystPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqk1YA28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF7C32782;
	Mon, 12 Aug 2024 20:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723495921;
	bh=DZ0hQS/c94qn/XFsawd7xcd49Yafc+HqB7hz6RNUVaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aqk1YA28LFMEHIfh9LgcAq//yJBKCZX/bb+j3tYACVOE9+0X00BJoK3rW8Cf+XsDM
	 DuHOP4UcCb4gl2kve25iAtE6tjGr+tFZgN4wH4ROfOyI1+bA3W+MZGB0jskfiMZMxp
	 7uC5xVns+7PObufvvb+vVmyaGwGInbbwT0kkY5RiipYa2t58GDaMinv7M2JC7DJ3sn
	 OEL1rx//961hamhtGPHv6DK6f8l4dDqA+OI0UuIJ5AWG6bemMpyddhhN8Jf8l3Itm8
	 3Kfbgecv5zJgICk5y8zG78YaKIA6ML5y3czy+Ik2xNX1aiHyWylICZ1/QXZvBnyzzp
	 7hu8KVtz3X3lQ==
Date: Mon, 12 Aug 2024 15:51:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/PCI: Fix Null pointer dereference after call to
 pcie_find_root_port()
Message-ID: <20240812205159.GA294028@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812202659.1649121-1-samasth.norway.ananda@oracle.com>

[+cc Mario, 7d08f21f8c63 author]

On Mon, Aug 12, 2024 at 01:26:59PM -0700, Samasth Norway Ananda wrote:
> If pcie_find_root_port() is unable to locate a root port, it will return
> NULL. This NULL pointer needs to be handled before trying to dereference.
> 
> Fixes: 7d08f21f8c63 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  arch/x86/pci/fixup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b33afb240601..98a9bb92d75c 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -980,7 +980,7 @@ static void amd_rp_pme_suspend(struct pci_dev *dev)
>  		return;
>  
>  	rp = pcie_find_root_port(dev);
> -	if (!rp->pm_cap)
> +	if (!rp || !rp->pm_cap)

Seems reasonable.  I suspect we haven't seen problems because these
quirks are limited to Device IDs that are all PCIe, but I think we
should check on principle and because it may be copied elsewhere where
it *does* matter.

>  		return;
>  
>  	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
> @@ -994,7 +994,7 @@ static void amd_rp_pme_resume(struct pci_dev *dev)
>  	u16 pmc;
>  
>  	rp = pcie_find_root_port(dev);
> -	if (!rp->pm_cap)
> +	if (!rp || !rp->pm_cap)
>  		return;
>  
>  	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
> -- 
> 2.45.2
> 

