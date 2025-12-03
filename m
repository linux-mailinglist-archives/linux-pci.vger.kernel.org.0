Return-Path: <linux-pci+bounces-42588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD5CA1891
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 21:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB3553007E4F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1161312820;
	Wed,  3 Dec 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="wsKVSbze"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B230F552;
	Wed,  3 Dec 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764792977; cv=none; b=cUjbO1lVv844hNQgo55f29Zp9+BQ4Z9TxUJUEM0MSeZD8sX9FYNSXzYsymigbZJ94Qq9GLfNS8ipYE1QUT0n8Q0+LBwVFfoX/u3JqRmARi4xdnl/74ruhwG+ELPvTaSkSRfSR+57jyP16JIT5fmfBlyIQWt917dElgf5Ve5HVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764792977; c=relaxed/simple;
	bh=TWZzihrQMoEAE73/KIfTh14r7XyMHtEzn+z7CaTe4/s=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=niq9os6ITT0w+oCZ2mWe94Pa3pGnQEG4Tt3EveHua9x2vBJ1s0IE5neGYIQRza+MUlmH3oOHzi7qiH6+iowF896f57pJ5T8Fp2bttGBCmjdYWD1U4XZMkrPboFoX+UX2a5+Y+jdvCt014Bd4LHBCGd8//4dHrdJc4k1f3lCa8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=wsKVSbze; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xz5n12EIfMWK/0JQFgyxPDTaEIWLWjG9k90BceQwhc4=; b=wsKVSbzeO9ik+mAyOJlQfljVWc
	KtQd/L2Cwm7Pk51ytttusu5bCPAQ+ZKSSbMkyTaVNxAV6iawrHThds13+dNIgI/pQU9uQwKF6jn/y
	BaPbmhFyPofRjwH+CodGCrhmBhAPLrn3Gbj0vNfyWgI/xsATCkV3syxR/wXFJd8lLu0yf3+YcDFWd
	hzZAJhmoFVkt97/IoN09nuHQouDv2U7G09Xf6WYqqgL7jBtAZgIKaL1JpPO5FvMiwKQwWK0Vgt5Rh
	f7HFLmTnzv3wvqrYKOHvwXvvz+DIEXQhdgimh5PGDQcT3iTFGUOAumwM9wSPJIcZTQ/PBQ3w7+daR
	rN0hqjFQ==;
Date: Wed, 03 Dec 2025 21:16:12 +0100 (CET)
Message-Id: <20251203.211612.2136559080137113794.rene@exactco.de>
To: glaubitz@physik.fu-berlin.de
Cc: linux-pci@vger.kernel.org, rafael@kernel.org,
 mika.westerberg@linux.intel.com, lukas@wunner.de,
 briannorris@chromium.org, helgaas@kernel.org,
 linux-kernel@vger.kernel.org, riccardo.mottola@libero.it, mani@kernel.org,
 mario.limonciello@amd.com
Subject: Re: [PATCH V2] PCI: Fix PCI bridges not to go to D3Hot on SPARC64
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <541bb4f91ab1d4145a2bd2891546649a9ed3ec4d.camel@physik.fu-berlin.de>
References: <20251203.200526.1986895588669292863.rene@exactco.de>
	<541bb4f91ab1d4145a2bd2891546649a9ed3ec4d.camel@physik.fu-berlin.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 03 Dec 2025 20:31:58 +0100, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Rene,
> 
> On Wed, 2025-12-03 at 20:05 +0100, René Rebe wrote:
> > Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
> > non-x86") was bisected to break some SPARC64 systems, see two oopses
> > below. Fix by not allowing D3Hot on sparc64 while this is being
> > further analyzed.
> 
> I think your summary is still misleading as at least to me it sounds
> like you are providing a patch that fixes the D3Hot state on SPARC64
> while in reality you're actually blacklisting the D3 power state on
> the platform.
> 
> I suggest something like:
> 
> "pci: Don't allow D3 power state on sparc64"

But, my subject was exactly "Fix PCI bridges _not to go to D3Hot on SPARC64_"

and the text says:

Fix (this commit regression) by _not allowing D3Hot on sparc64_

I would rather move on debugging this, ...

  René

> This would also match the description of pci_bridge_d3_possible():
> 
> /**
>  * pci_bridge_d3_possible - Is it possible to put the bridge into D3
>  * @bridge: Bridge to check
>  *
>  * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
>  *
>  * Return: Whether it is possible to move the bridge to D3.
>  *
>  * The return value is guaranteed to be constant across the entire lifetime
>  * of the bridge, including its hot-removal.
>  */
> 
> The function pci_bridge_d3_possible() determines whether D3 is allowed
> on a certain platform and by adding CONFIG_SPARC64 to the list, you are
> explicitly disallowing the use of this power state.
> 
> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

