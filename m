Return-Path: <linux-pci+bounces-31928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E300B01D2B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA4D7664EE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C76C2D322D;
	Fri, 11 Jul 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qupdx5Sp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78302D321A;
	Fri, 11 Jul 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239744; cv=none; b=Y3IwSV6ab+yc5myRKkW2JSYxI+CG4IrnVIeAiqqUIEsOFizJdDXyJRrFonH9AtCCUJ+gimqDgji6hEt7AOLYJV5X7H1aCO12jkM1y8kqGj5Kr8lEHgfCJl9CvOIHsYsEs+1qpTE8pOAO8zi7TxschDvTJ/ZIFwLAatbHentxmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239744; c=relaxed/simple;
	bh=it0bnDa8F7e60yuE2i2eFmsF5hMzpIwxDA3DtF27AzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU1tvDUR9jizBq8PgM4j2VfIQCH23m2iK4IQzc6A1m4LUHzfMjHS3irxGYMsRDayhtJU4EPKXhj7Z9WeKD6sZnBusArSZ523tzpr5VJwR9LxRduutnno7MDQMeJ3up1R64O7NE5SkSrog11QaSa/aot3h+yZVL0n5VviQOgT+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qupdx5Sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BFFC4CEED;
	Fri, 11 Jul 2025 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752239744;
	bh=it0bnDa8F7e60yuE2i2eFmsF5hMzpIwxDA3DtF27AzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qupdx5SpGRdyUvXe6gp/CdkpZYk4jUDMUEfFKPTc3yp9VLkQ9bBKAewo6b4ybZw8r
	 GRP0tkqKIRw9vdNdkgcynvPgPTXvVsBcEzjHldMZ76BdAxJAY//2S6iAmZwRpOApgv
	 lhguTjOq6EBm+OE8dTxPWOmI7u0G1TAIcKC306uBMZDbBTHVdI5ubpjFKqbglv+vd1
	 GqI897WmjIoqTgYEWEvCuGBlLh7xeeKd/WDdAT/9p8Ge8ICLIfOcp998B55rpTwv8r
	 GkjigXqyO+aSjrPnw8Qw37a7/Ynu0Pjw/tZfdUed221451RTZjl3/YTusE+sdIDsaa
	 3LGM0y9Ex54IA==
Date: Fri, 11 Jul 2025 15:15:36 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Toan Le <toan@os.amperecomputing.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 13/13] cpu/hotplug: Remove unused cpuhp_state
 CPUHP_PCI_XGENE_DEAD
Message-ID: <aHEOeF6PKl1xO7ZR@lpieralisi>
References: <20250708173404.1278635-1-maz@kernel.org>
 <20250708173404.1278635-14-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708173404.1278635-14-maz@kernel.org>

On Tue, Jul 08, 2025 at 06:34:04PM +0100, Marc Zyngier wrote:
> Now that the XGene MSI driver has been mostly rewritten and doesn't
> use the CPU hotplug infrastructure, CPUHP_PCI_XGENE_DEAD is unused.
> 
> Remove it to reduce the size of cpuhp_hp_states[].
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/cpuhotplug.h | 1 -
>  1 file changed, 1 deletion(-)

Hi Thomas,

I would upstream this patch through the PCI tree please let me know if that's OK.

Thanks,
Lorenzo

> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index df366ee15456b..eaca70eb6136b 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -90,7 +90,6 @@ enum cpuhp_state {
>  	CPUHP_RADIX_DEAD,
>  	CPUHP_PAGE_ALLOC,
>  	CPUHP_NET_DEV_DEAD,
> -	CPUHP_PCI_XGENE_DEAD,
>  	CPUHP_IOMMU_IOVA_DEAD,
>  	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
>  	CPUHP_PADATA_DEAD,
> -- 
> 2.39.2
> 

