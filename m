Return-Path: <linux-pci+bounces-17713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D19E48BF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E191625BD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694141AE876;
	Wed,  4 Dec 2024 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfY7YeTL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E819DFB4
	for <linux-pci@vger.kernel.org>; Wed,  4 Dec 2024 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354664; cv=none; b=VOn+FjOjBSQTZ3A0ReXI4U55/Vb1p4tUdfWBtMokMjZT0RAlb9Yfl+bZzFMAa+xZDgt9Tsh4pvrog/K8JBW+rHoSYMk44OR6ZyP+OPbhbAFFD7m2Is+/zEjYSQYNW79Pkjg1HvM06E/9VtL51C11V/RklmXcCtHeAphE1lXLMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354664; c=relaxed/simple;
	bh=+9AI+rMMgHRCt+EBap5GONiFWkgoLxWThPoitwPQODE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JOmd00/rk/s0auGyda8JGO84Ebk9v1q68Lu8dT4/mNCTZaxUfrZy12/S0NtA+8DISUC2zi2B8bS2EaUd8++sh05NKO0QU/V4+0305bvvX81kdl92/DCnfOOFj+4RzjG1usKBoUK0F/0xrEdZCuidZK5ENroT/dzodJPRdDA0jPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfY7YeTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0F1C4CECD;
	Wed,  4 Dec 2024 23:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354664;
	bh=+9AI+rMMgHRCt+EBap5GONiFWkgoLxWThPoitwPQODE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JfY7YeTLkeZFoKUax964CjKq05GEbcYuB1qdg5b5JAaMwADaOffNEbiiB42YmE/B/
	 u4zA8fH1elVXpQO/MmI19Jv2kFNFyfFJPNoxRB8dIrL1sRk5CJ7kbisUvnRh+LEZb4
	 gSL0VFX4xKtgw6s5TpXyQhaoPSj2PpmNr2LeBdIzJ9qUfvVm9o5xZKp5CBaolx2v0I
	 1dYHE3dp/AwibWkYr5hN4vH56cw3wcD3PaLsBGZu0DPeJ8FU1Y6+X/jqvRhInTsNbD
	 mhD+RD+i4GTzdIlsZvtDpJfHACDLCgHUVvslVzqI2D27DxVu8amFOLHqeFAt9GFcue
	 dnKnALeVbUVxw==
Date: Wed, 4 Dec 2024 17:24:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: alucerop@amd.com
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	alison.schofield@intel.com
Subject: Re: [PATCH] resource: harden resource_contains
Message-ID: <20241204232422.GA3027254@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129091512.15661-1-alucerop@amd.com>

On Fri, Nov 29, 2024 at 09:15:12AM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> While resource_contains checks for IORESOURCE_UNSET flag for the
> resources given, if r1 was initialized with 0 size, the function
> returns a false positive. This is so because resource start and
> end fields are unsigned with end initialised to size - 1 by current
> resource macros.
> 
> Make the function to check for the resource size for both resources
> since r2 with size 0 should not be considered as valid for the function
> purpose.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>

Seems reasonable to me.  FWIW,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/ioport.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6e9fb667a1c5..6cb8a8494508 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -264,6 +264,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
>  /* True iff r1 completely contains r2 */
>  static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>  {
> +	if (!resource_size(r1) || !resource_size(r2))
> +		return false;
>  	if (resource_type(r1) != resource_type(r2))
>  		return false;
>  	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
> -- 
> 2.17.1
> 

