Return-Path: <linux-pci+bounces-15663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F8A9B705F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 00:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF39281AFE
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6B1CFEBF;
	Wed, 30 Oct 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7eX305r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45EA1C4617;
	Wed, 30 Oct 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330299; cv=none; b=ZbPD9Rd+J+BpUtT5Oq0VgVjAZ1bplka0uh644iWuAxnsnifWm6Y+ObeN+3CvpCY/GAdrQzgNPWmCHRJuC8c4dCIwJtSKYYO5ZKf89R0A+xA1o26HvSpMT+D26C1RTl8dLvZe4Q+zRnboNMOCSOqAICG6lwtL0C2ytm70hoS6LBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330299; c=relaxed/simple;
	bh=4E4tBAkqdhy0E489K98odwYZ5EoI6YSDjaZyuL/9XH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDzvqfvcWC+6/ItjKDpAtZITiQKfWdfDoBXNeGeE/XoUVyK5YzZxTnPB+z8e4CTSVryXQcaPiD9I6GeI/gA1PNU+nz/SXzYOV1r9u5hsmhnUIaOpgKvb/7KlMUXUqNQ1bI/P5WRA0PxcRPjRd/2BACYkoO9UBYbnQFwGXrBToNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7eX305r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC748C4CECE;
	Wed, 30 Oct 2024 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730330298;
	bh=4E4tBAkqdhy0E489K98odwYZ5EoI6YSDjaZyuL/9XH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7eX305r0jTOtWcBBi5zRBGsUb4aU7Ei/DxltYsD0pwaCqvjpUoitth6jVAgVCGG/
	 mppWG+7yLcTLOdITm79VyFoVEtmCUIRHIccwshlMjoBE2fDJAe1kmKhdIa33BeXGdk
	 Rv1AmIHD1sgOmxWZd8qL/nGF4GKhi6hmERXOQvnz4ihaJveg+NpNioZc7WvxVJRKJ7
	 Im5FtuKo7hljEH98BnVS6ald8voHMiP+yWrKGdOA/Y06M6ITyAdd1CyTHsQ52hk06x
	 fHE9G0CT8hIiG5cBRSAW+3nWy/sl2HJK7KCcJHR5N/jbuhObyv/ng84KOycxTeUkzu
	 RQm1opTupnIfA==
Date: Wed, 30 Oct 2024 17:18:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI/sysfs: Use __free() in reset_method_store()
Message-ID: <ZyK-typQQqk0KKPf@kbusch-mbp.dhcp.thefacebook.com>
References: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
 <20241028174046.1736-3-ilpo.jarvinen@linux.intel.com>
 <Zx_Pt2ObNKIS8cu2@kbusch-mbp>
 <8862b34b-26b3-af75-5d23-d765fb41b5d4@linux.intel.com>
 <d07973e2-0ac1-d3e0-25f0-7b1270ca4a15@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d07973e2-0ac1-d3e0-25f0-7b1270ca4a15@linux.intel.com>

On Mon, Oct 28, 2024 at 08:18:39PM +0200, Ilpo Järvinen wrote:
> I went to archives and found out it had already made itself into 
> include/linux/cleanup.h which now says this:
> 
> "
>  * Now, when a function uses both __free() and guard(), or multiple
>  * instances of __free(), the LIFO order of variable definition order
>  * matters. GCC documentation says:
>  *
>  * "When multiple variables in the same scope have cleanup attributes,
>  * at exit from the scope their associated cleanup functions are run in
>  * reverse order of definition (last defined, first cleanup)."
>  *
>  * When the unwind order matters it requires that variables be defined
>  * mid-function scope rather than at the top of the file.
> 
> [...snip examples...]
> 
>  * Given that the "__free(...) = NULL" pattern for variables defined at
>  * the top of the function poses this potential interdependency problem
>  * the recommendation is to always define and assign variables in one
>  * statement and not group variable definitions at the top of the
>  * function when __free() is used.
> "
> 
> After reading the documentation for real now myself :-), I realized it's
> not just about maintainer preferences but about order of releasing things, 
> so it's a BAD PATTERN to put those declarations into the usual place when
> using __free().

Okay, I can't argue against that... It still looks unpleasant. :)

