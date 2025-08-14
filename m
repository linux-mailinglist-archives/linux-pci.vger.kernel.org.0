Return-Path: <linux-pci+bounces-34076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC29B270CF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 23:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509F81C862AD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E42275AF8;
	Thu, 14 Aug 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFpMfi2Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D399253B73;
	Thu, 14 Aug 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206755; cv=none; b=ekBnLJJK4T7NFwVDxUu+QLj2upkGFrkEErs9+z5tMFd89rOKLG503uC7mI6vpVN5OLkbDUPhILXYAuAI8hTFihTPDJSkVzlM3kYWKYZTLTCuuDhGoiQBQ/GPxigx07R4vZIJ2cbu5jSTR01PxP7i8qNt0S4vZOMCAQOk19D9uNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206755; c=relaxed/simple;
	bh=WajXZtnlj27kJPiSaJTPsLMMbAmVlyEz4ntqoWowU2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UYpRxibf0nMxhIIfAZcp4BvPh6GkFb1FH0gqoF24hgBgV18A0bFQMe+v61sbu9bOsbzQbHXBHz5PLsFJqiwEL7m7fdB5cfVHm/YlymWNRyNV7IlaNdy391QHyeLHpoVMsN6RNO2FdFtXDRV3hsWqT4Jj3mTjbFxrtTrZq4l3fVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFpMfi2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0ABC4CEED;
	Thu, 14 Aug 2025 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755206755;
	bh=WajXZtnlj27kJPiSaJTPsLMMbAmVlyEz4ntqoWowU2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XFpMfi2Z9/ekH0iMejgBzpvsksmiDdTjg8r0pqWtZqhXxE5VYCH1uWrZng2WGriFJ
	 abLC/rfevlP3tIQvsPZ9Xu5YZSDypoR2PpawdZ2dudfKDvNG+NOs/R8KZNxU8JpkO4
	 yHzA2xQTYRKlGK7o32AjzykB6/hTLopdfQ8JICESGrfBISnI60WQXfJnUYQG9Pr45K
	 FxrrvaC4G/S2d8t356WHHYj7lI63Vlqa10PK47NWPuk8oOQ0BZoc2+D333ZjZi9slw
	 p2Ah2v6csm0g8aWzHegio0p4Tkif4Fy4k4FmpG4FqPLoReI1EQvMN1GE850+fm9cy3
	 +8lbm19TbV75w==
Date: Thu, 14 Aug 2025 16:25:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/13] PCI: cadence: Add support for modules for
 cadence controller builds
Message-ID: <20250814212553.GA349461@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813042331.1258272-2-hans.zhang@cixtech.com>

No need to repeat "cadence" in the subject.  Something like this would
be sufficient:

  PCI: cadence: Add module support for platform controller driver

On Wed, Aug 13, 2025 at 12:23:19PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Add support for building PCI cadence platforms as a module.
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -178,3 +178,7 @@ static struct platform_driver cdns_plat_pcie_driver = {
>  	.shutdown = cdns_plat_pcie_shutdown,
>  };
>  builtin_platform_driver(cdns_plat_pcie_driver);

Do you need any change here, e.g., to module_platform_driver()?  I'm
not an expert in the module machinery, so just a question.

> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Cadence PCIe controller platform driver");
> +MODULE_AUTHOR("Manikandan K Pillai <mpillai@cadence.com>");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index 70a19573440e..5603f214f4c7 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -279,6 +279,7 @@ const struct dev_pm_ops cdns_pcie_pm_ops = {
>  	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
>  				  cdns_pcie_resume_noirq)
>  };
> +EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Cadence PCIe controller driver");
> -- 
> 2.49.0
> 

