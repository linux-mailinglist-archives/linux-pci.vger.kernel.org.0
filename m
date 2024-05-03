Return-Path: <linux-pci+bounces-7048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80898BB12E
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 18:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0500F1C21312
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F5156C5F;
	Fri,  3 May 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCEkbtNt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2591553AB;
	Fri,  3 May 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754815; cv=none; b=AZVH8VHo/PrX9xnAz4fiJt8IdvGxZ3tsJjgaLUUsVWBDt+XaH/3SnSS7lRL11SnOT9g3ly+j8fR1QHDX4pA6x/Aw6cMr3o6jdL96bY4d55CUf+ptnrTvQ3FGwMtTv8fvvQPK/9KL7MWv8t5iIaghijIruYSafqFuE7uMAy7tt3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754815; c=relaxed/simple;
	bh=yaoak1fDrAn4w0OANSfpsDyPIMFRb3UXg/GPuhk8clo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pn93sos3vjGbNN0L3hfgBlgFjoCj+CjAT0jji25NfgcGveIzS7j36ecrZvAqGaIg6Rv41NayxsWsTEZzWDAc54/Ursa2JYMdpbLfpF+6t9a9SqY1oSQQ7B4+sWIo35h/isRLD4HjrdsQB8WRbMhS55w17LIZYAe3zJWI2s2onTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCEkbtNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57789C116B1;
	Fri,  3 May 2024 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714754815;
	bh=yaoak1fDrAn4w0OANSfpsDyPIMFRb3UXg/GPuhk8clo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nCEkbtNtZSdq6TKait39WmTLlH8jAt71b123/YWjzOJIBVajJtZocGe+ptGtKk8aM
	 9X0JlGKCV0nHcEFCduyZfMAvcqfR55yn00SipAq9P8AUoT0XOmzcCzskeCsU4561gj
	 MxCyOyWLiujwx9/yASPIBiabfEQSEoJaX1v1JClxR/Cx/XWkTtd56w0NKr6Vh9zMrW
	 ZunoULnPiSCjLzV41UF/RsSdItKEesviHUUIt+EyRHTfsFADJnAnbPe2ljbMIj1J8j
	 9PxdqKBqCPMtU9obJyjMWH5XiHGwVokVKgugM33JdFYMLcxJbJ3PYEVg7IJ2mI/b0v
	 U0vdXR/it/4FA==
Date: Fri, 3 May 2024 11:46:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ajay Agarwal <ajayagarwal@google.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Clarify that pcie_aspm=off means leave ASPM
 untouched
Message-ID: <20240503164653.GA1584406@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429191821.691726-1-helgaas@kernel.org>

On Mon, Apr 29, 2024 at 02:18:21PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously we claimed "pcie_aspm=off" meant that ASPM would be disabled,
> which is wrong.
> 
> Correct this to say that with "pcie_aspm=off", Linux doesn't touch any ASPM
> configuration at all.  ASPM may have been enabled by firmware, and that
> will be left unchanged.  See "aspm_support_enabled".
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied with David's Reviewed-by to for-linus for v6.9, thanks, David!

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bb884c14b2f6..4bc281d6e8d3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4590,9 +4590,10 @@
>  		norid		[S390] ignore the RID field and force use of
>  				one PCI domain per PCI function
>  
> -	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
> +	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
>  			Management.
> -		off	Disable ASPM.
> +		off	Don't touch ASPM configuration at all.  Leave any
> +			configuration done by firmware unchanged.
>  		force	Enable ASPM even on devices that claim not to support it.
>  			WARNING: Forcing ASPM on may cause system lockups.
>  
> -- 
> 2.34.1
> 

