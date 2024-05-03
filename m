Return-Path: <linux-pci+bounces-7062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4528BB6E2
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE19281692
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB555914C;
	Fri,  3 May 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILhKzxu7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E38364AC;
	Fri,  3 May 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774377; cv=none; b=mrgHFSKP2q+Az/vHi6rKjobdFhDIj6RS94TbhFh24a82wIr7Ue5RNkWkVXAj/vXSqtR2BGeO1ps8d2fbeQXK9EdZmSHKehoeu86dxuNbkIVF9l3vZmyv5r7+sZBz+Vxgyp51vGlt+Pcnd3LKjFEQQ4R2j+I+sfkkXPqW2+qiSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774377; c=relaxed/simple;
	bh=YkP2K6jpxNEQf4lXAwpJOOcHT6UPDCIc3FFQpwklXDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GX3XvNhbofPl/AaxxHUIygHfZYwgwr474zVRLHXHHrcefqTFQ+OOfWFwQqDtOgglAZ6FwA8IxBGR43JEOWOMkf2VGULpm1CR1WmTU/tN7HV6ihHsk2332z92/hC70aU/4TmcfFt3ZhZFp6EpTtBjtiUsbpiO/kV4NeyL22bneTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILhKzxu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A857EC116B1;
	Fri,  3 May 2024 22:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714774376;
	bh=YkP2K6jpxNEQf4lXAwpJOOcHT6UPDCIc3FFQpwklXDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ILhKzxu7oUwgRZMSb5FgKI+skcjYd8K+c+U9i5uDdl07ql6s35NefExj3VJiRt0M+
	 nZDQnRX8dY9Q6Q+YU5yyzBBiFAkA0Y2j9PsQwj6nKx+RQGH7fzGIS4rwA7cvIndaT6
	 fV89eLej03eDgVvxwWmnWkqsXMiReHz7+7j9ExwfuaC2g1VlTsUGzpt04Uf472L3fJ
	 sqwrkSMWan41jm/wREC5pG8br2+kbd2Qx7DPA0UrK20MrQ9vW8dT4iWC7q036iDVl+
	 5HJq/nA+ogSZzOc9a9x+gurcR9NosBuL12k7FelkACuMKbVElrkQJ8EY8ASSVDP4oy
	 vNmdUKkWcndZQ==
Date: Fri, 3 May 2024 17:12:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH] x86: Code cleanup for ehci_hdr
Message-ID: <20240503221254.GA1607085@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125030623.513902-1-chentao@kylinos.cn>

[+cc Andres, author of 3ef0e1f8cad0]

On Thu, Jan 25, 2024 at 11:06:23AM +0800, Kunwu Chan wrote:
> This part was commented from commit 3ef0e1f8cad0
> ("x86: olpc: add One Laptop Per Child architecture support")
> in about 16 years before.
> 
> If there are no plans to enable this part code in the future,
> we can remove this dead code.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied to pci/misc for v6.10, thanks.

> ---
>  arch/x86/pci/olpc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/pci/olpc.c b/arch/x86/pci/olpc.c
> index f3aab76e357a..4b18c6404363 100644
> --- a/arch/x86/pci/olpc.c
> +++ b/arch/x86/pci/olpc.c
> @@ -154,9 +154,6 @@ static const uint32_t ehci_hdr[] = {  /* dev f function 4 - devfn = 7d */
>  	0x0,	0x40,	0x0,	0x40a,			/* CapPtr INT-D, IRQA */
>  	0xc8020001, 0x0, 0x0,	0x0,	/* Capabilities - 40 is R/O, 44 is
>  					   mask 8103 (power control) */
> -#if 0
> -	0x1,	0x40080000, 0x0, 0x0,	/* EECP - see EHCI spec section 2.1.7 */
> -#endif
>  	0x01000001, 0x0, 0x0,	0x0,	/* EECP - see EHCI spec section 2.1.7 */
>  	0x2020,	0x0,	0x0,	0x0,	/* (EHCI page 8) 60 SBRN (R/O),
>  					   61 FLADJ (R/W), PORTWAKECAP  */
> -- 
> 2.39.2
> 

