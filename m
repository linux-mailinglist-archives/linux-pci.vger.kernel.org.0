Return-Path: <linux-pci+bounces-6334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C258A76E4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 23:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829CA1F215D1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 21:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0C5D905;
	Tue, 16 Apr 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAdahx+m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8D13C3D4;
	Tue, 16 Apr 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303495; cv=none; b=QSOB+dT2HqVJEs5ImgZccc8D11pFKc/DvuA2BIPhqQiRZ8wEU986oUk7tl6ko6Z1LhPvkB0wFm40xr872eXV9eZ1GEODE4MJoWfW20f2vMoLzu4+AWgCkqxrKgU+1eZ9qVADWcGv3v0ZxDS+A8INNQ9rgoHGYFnRqrSq1KWzqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303495; c=relaxed/simple;
	bh=oMEQPBhuR+5m61X3N1NL0mGibefYxaOomLDvfvv/nFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lBm+WSBiYvCvNHh4vF0Q60bMoRnnOrFtxaQixEEJVzeLE+kfNdbb8hYG2WEZGvvuPs8hq5CgO0iL0UCpBFIkwBPGfEdldfWnTUKFu5z31EmuvNsZMvcKqcud+g+XO1Hf1i13749m1Wn1uyTpWKYayC4rru4WmrGul/LFxNNtV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAdahx+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D3C113CE;
	Tue, 16 Apr 2024 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713303495;
	bh=oMEQPBhuR+5m61X3N1NL0mGibefYxaOomLDvfvv/nFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iAdahx+mkQo1rGSBYVb7JvQHFLTCCiKX7GIgnl7L60b2LGuzn/h2fgeeWOaLmbnv6
	 4qXbo765wPlp9iTJ9eLoICORZq+tNaqdvlDjYPdMxvMIS2MW5yIODhsMCzzn/3WA0I
	 D4F8z1yTlA88Y8eSEFkiyXc5SebrK15naI3vSimS6pNhwK8wZeDIOTQImDhoN4Izlu
	 m3AhY7V+AxjMAoHObXddxoPT5ylsk4e7xyiXOwXjniVKSRU2QOrimcAZAE1ENJucZG
	 qzQSYgsJ5uG3HJBQt/aQSsk5v/mD+OErnVtJ5PcRQdtwVJ2zjM55WyPkdLm+8V3mxF
	 sgbCiRyUOW/kA==
Date: Tue, 16 Apr 2024 16:38:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 52/74] x86/cpu/vfm: Update drivers/pci/pci-mid.c
Message-ID: <20240416213813.GA171111@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416212219.9643-1-tony.luck@intel.com>

[+cc Andy]

On Tue, Apr 16, 2024 at 02:22:19PM -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Possibly consider updating subject line with a hint about what
"update" refers to, since every commit is an update.  I guess "vfm" is
some kind of a hint, but I don't know what it means.  I suppose it is
for "vendor, family, model".

> ---
>  drivers/pci/pci-mid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> index fbfd78127123..bed9f0755271 100644
> --- a/drivers/pci/pci-mid.c
> +++ b/drivers/pci/pci-mid.c
> @@ -38,8 +38,8 @@ pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
>   * arch/x86/platform/intel-mid/pwr.c.
>   */
>  static const struct x86_cpu_id lpss_cpu_ids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
> +	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_MID, NULL),
> +	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
>  	{}
>  };
>  
> -- 
> 2.44.0
> 

