Return-Path: <linux-pci+bounces-18316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1130F9EF2F5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9704A189AB02
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA016240395;
	Thu, 12 Dec 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtbmSYAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EA240390;
	Thu, 12 Dec 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021391; cv=none; b=FWqF6Ni/wgU0zh5Bn8CjvPZ+lIn37PsoBy4qik1cnUaq/2kYGDT8J04Wwu04iJwBIwDAkUDfGTYisltZbhs0F7X5lZWCcGgrsz0SArD3d9MojOpMgsBwRtcqR5l8hpEd1ij+ZOSy1/ML+2gBKoRcc3PdOhhcbQ10NfY2syffA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021391; c=relaxed/simple;
	bh=E3xkzPKQE86qPNc4Bb6mCGp+0y2yz5hGOppGcN76hyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pTh7Sps9r4jm9eKWHhK5FIVw7pb+oE/uouU7oWiSLfkeoxlINmcP3VyEW3VyaSCNaZq7G+uIUCIcm9jzalM3jlHIUtAb4Lm6n4qTopq68kRb9hfclB0gdQ/XRxEXJoT8sn/cNZRQK9XGD4BKy/O756HeNEJhWruty1waRSc8G/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtbmSYAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA83C4CECE;
	Thu, 12 Dec 2024 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021391;
	bh=E3xkzPKQE86qPNc4Bb6mCGp+0y2yz5hGOppGcN76hyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UtbmSYAvD1MjeeOilJvFuD7uHQ6s/uTeCtFGJbvIopLXIngNQPv/STwMZd1l/2g4t
	 aBdHO+mGcTNejsBxQAqkNOaj96Yq+X3TpIVOV1ZVacjW5URKi8oBK+LTYuHNZ/+hs0
	 +bymAZ7gYAq2V1NNl5YHJXGWYjVjxp182WJzfiVLJ/m+B6G6BgpikhGq6GWvjcrJIm
	 wJ13UV0bHMnTORRNV04UJq13rZowMnHHHZAB8eEZaHN9NTuBQ/z9e+UFV8JCDioToS
	 z/P/Z6vky1UpuJ5yLBY2pAlrQ7W0u11J/3HN8k5Xlt+0DVdfm7uba62ldfMxM7x0n/
	 98Fn7qpRUi1Sw==
Date: Thu, 12 Dec 2024 10:36:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: guilherme giacomo simoes <trintaeoitogc@gmail.com>
Cc: scott@spiteful.org, bhelgaas@google.com, namcao@linutronix.de,
	ngn@ngn.tf, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: remove already resolved TODO
Message-ID: <20241212163629.GA3346193@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212110233.787581-1-trintaeoitogc@gmail.com>

On Thu, Dec 12, 2024 at 08:02:33AM -0300, guilherme giacomo simoes wrote:
> The get_power and set_power fields is used, and only hardware_test is
> really not used. So, after commit
> 5b036cada481a7a3bf30d333298f6d83dfb19bed ("PCI: cpcihp: Remove unused
> struct cpci_hp_controller_ops.hardware_test") this TODO is completed.

The entire 40-char SHA-1 is overkill; use 12:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.12#n204

I see a test and call for .get_power() and .set_power(), but no actual
implementations, so I think they can be removed as well, can't they?
If so, I'll wait for that removal before applying this patch.

> Signed-off-by: guilherme giacomo simoes <trintaeoitogc@gmail.com>

In
https://lore.kernel.org/r/20241014131917.324667-1-trintaeoitogc@gmail.com,
you capitalized your names.  What's your preference?  I'd like to use
your name correctly and consistently.

> ---
>  drivers/pci/hotplug/TODO | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
> index 92e6e20e8595..7397374af171 100644
> --- a/drivers/pci/hotplug/TODO
> +++ b/drivers/pci/hotplug/TODO
> @@ -2,10 +2,6 @@ Contributions are solicited in particular to remedy the following issues:
>  
>  cpcihp:
>  
> -* There are no implementations of the ->hardware_test, ->get_power and
> -  ->set_power callbacks in struct cpci_hp_controller_ops.  Why were they
> -  introduced?  Can they be removed from the struct?
> -
>  * Returned code from pci_hp_add_bridge() is not checked.
>  
>  cpqphp:
> -- 
> 2.34.1
> 

