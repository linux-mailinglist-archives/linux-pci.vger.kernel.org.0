Return-Path: <linux-pci+bounces-3361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6B851AE8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7897F1F2A593
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C053F8E2;
	Mon, 12 Feb 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFVYlR2x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F83F8C8;
	Mon, 12 Feb 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757686; cv=none; b=b0TFolxFC0q+1fakTJYHCGH1y9xrRYc70sV8vPhVtyraUZ88m0ualV5oPU8nMXj7jNrOXL1sLtMwp4e4NXoEvqawKgYUnZmdR8Jg/IiM5zgKYi+2NCG9/tz6ujOIDa6oVOwU4VoRbdvdC34lPjZz1WzGup/XYICq7juQDhyPJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757686; c=relaxed/simple;
	bh=9HZMZgHwLXt49jjZnE2ZXTxsiReon/osa+40vsvm75o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FH8uxfDpUVyQhXkJapIoreSqeq7bXVMl+C6pFhRbE4B2O5mqBEX1VZFKhuJtVaCMvIHdLBzJVxeKbqZVLcaQ/SO5iM+UFYl8uaLwtl6LnCFh0g6U6ray+vMQgWr6XaS8PhU0yCPX9bpavaQoNH2tObHiwBhut3lZ0XRrRCbnBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFVYlR2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA9C43390;
	Mon, 12 Feb 2024 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707757685;
	bh=9HZMZgHwLXt49jjZnE2ZXTxsiReon/osa+40vsvm75o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oFVYlR2xdJVCtTklBpWt8l1h+8I8bSTrJyo5VcsuBbliAycfHdmnY9MrFAXrH2IWe
	 ulRJK6YpChdkkJ56qLCXGoZWlTrERg6/xflEIbyc2xuLKwZP9//6kwbdKrseTXCXzM
	 HfLPGlcqGXBPFBGV2YGXgz7DCeQhp/M2Sc4WQJ9h55p4TG7/Jnp8JUSYYYzjydGwr/
	 iEJYfNPB9fCcqQ45k4kmgUXDOFYtuUlfVaDjAiIxpBgP3kCsNFMvQTsB4dr07oopyX
	 9UejbXmNY6BgadJjNroHLossStua/42CcF6BAUNtU/noFHgF38bvcoh4T91QeDBfbA
	 uD2+GjpzUxVYg==
Date: Mon, 12 Feb 2024 11:08:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Docu: fix build warnings for PCI
Message-ID: <20240212170804.GA1135652@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212150934.24559-1-pstanner@redhat.com>

On Mon, Feb 12, 2024 at 04:09:34PM +0100, Philipp Stanner wrote:
> drivers/pci/iomap.c was accidentally added to the Documentation
> generation at two places.
> 
> Remove it from Documentation/driver-api/device-io.rst to resolve the
> collision.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20240205160908.6df5e790@canb.auug.org.au/
> Fixes: 025bbeb5c880 ("lib: move pci_iomap.c to drivers/pci/")
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Squashed into pci/devres, thanks!

> ---
> As discussed with Bjorn; this will be squashed into the series that
> caused the problem, in PCI.
> ---
>  Documentation/driver-api/device-io.rst | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
> index d9ba2dfd1239..5c7e8194bef9 100644
> --- a/Documentation/driver-api/device-io.rst
> +++ b/Documentation/driver-api/device-io.rst
> @@ -517,6 +517,3 @@ Public Functions Provided
>  
>  .. kernel-doc:: arch/x86/include/asm/io.h
>     :internal:
> -
> -.. kernel-doc:: drivers/pci/iomap.c
> -   :export:
> -- 
> 2.43.0
> 

