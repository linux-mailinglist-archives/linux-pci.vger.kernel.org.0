Return-Path: <linux-pci+bounces-24170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A1A69B2B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F022A8A7AC9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C814AD29;
	Wed, 19 Mar 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm0dCD0o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2918E25;
	Wed, 19 Mar 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420826; cv=none; b=C0HTebhAWTARy+z+dwjCkY+qjZw+3aqIXPH+fJ5QawgEXNZI6LPkVeP5AIs/4ZLna9uw4Jud0FwLLTIscHZGULA+wn4LlhWyQrV/fhikt6M0NpGMavKLC/xIPlnQNz3Ek8tD3mMRSlfv2S2Y6x+fRVAYJVYMpRScV0Mmt2I+i+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420826; c=relaxed/simple;
	bh=drBqWStFtF8fJz5puTxFYQoOOJCqEbVWvwRSaDvN58M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QdqWScG2n6ySPHCe4USKwGu7Fg1WNeLjFsSIMaQm0PrlnxVix3d2z3rjamvkQMfwj8bndL9YvPe+wM1Unjobxfc56nZaS8XB43Q8OukM/O3Ja0Pogerfd9gZdYOcxjNKibj3ABRD/WzoaUPAZbTbu5Qt2ovtCIvjvAhy8INbRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm0dCD0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A6AC4CEE4;
	Wed, 19 Mar 2025 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742420825;
	bh=drBqWStFtF8fJz5puTxFYQoOOJCqEbVWvwRSaDvN58M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Xm0dCD0omSTxjAHMhO2aCDrHF4OL0oUW03WsmS63kOo+nrVE92vq0u+IrO49LTgZ6
	 oiDT3okdGGexg//TTw60rEeA1mpFG+8ldm1dN92QbUwLJ3oSywYBzDpmqRUTtIUoMX
	 fgtpSeqAJJ/jkX7jWK5m8ltWAhpPVfJPewqVHMm6sTj9Ik4ngVDlSWAP4JxkSxOgek
	 a0F3JGhWoAJRArQtt91EgztdUyqzdifJskQOqBpr888lbJ7vHIw/4V0KsiXyTuWC3X
	 l3OwmU9ZqHpaK+2mTiOTLkb6Y5vDh5CiFQcSy2WHtLZhDQn5+YnXoONVWQkWbj9pkB
	 eE6jc/YUBWnWQ==
Date: Wed, 19 Mar 2025 16:47:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: PCIE_AMD_MDB should depend on ARM64
Message-ID: <20250319214704.GA1064668@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaef1dea7edcf146aa377d5e5c5c85a76ff56bae.1742306383.git.geert+renesas@glider.be>

On Tue, Mar 18, 2025 at 03:00:54PM +0100, Geert Uytterhoeven wrote:
> The AMD MDB Versal2 PCIe controller is only present on AMD Versal2
> ARM64-based SoCs.  Hence add a dependency on ARM64, to prevent asking
> the user about this driver when configuring a kernel for a different
> architecture than ARM64.
> 
> Fixes: e229f853f5b277a5 ("PCI: amd-mdb: Add AMD MDB Root Port driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Squashed into e229f853f5b277a5, thanks, Geert!

> ---
> To be replaced by ARCH_VERSAL, if/when it ever appears for real.
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 39b1a89cb6b7ee80..48f1e3c7825b55e0 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -39,6 +39,7 @@ config PCIE_AL
>  
>  config PCIE_AMD_MDB
>  	bool "AMD MDB Versal2 PCIe controller"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
> -- 
> 2.43.0
> 

