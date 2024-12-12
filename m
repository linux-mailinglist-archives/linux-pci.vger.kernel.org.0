Return-Path: <linux-pci+bounces-18298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF69EF079
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5D1173025
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED12215799;
	Thu, 12 Dec 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTdDZxGM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA6213E6B
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019865; cv=none; b=SiBOCYrTyHRyFHX4DL5vmyN5qoqQQI0WtUfwkvNHcEv4tpsTuQHI7/TCjOfBkrQQanTjkk1Il89wknjyUgznLk3YRjb1UgnHdIRZ0UH3pkUCEstsXCt8OeamdQ0QzQVKj8EsNDpq5dTJmSWflHrNQ9uQ6YDTORTQzc1DdZOiIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019865; c=relaxed/simple;
	bh=E3D+QdYMi6KPEAa20JW+O8s3X1NXZNoBuZGpQsgzv5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pfnNALEP6JsgqGJvWk2uH7tddJygzANLCrHD/D7TmEzlRazwdT3zxUtK9G8+/qQhcKP4wZSkv7akjTI2xAwif8Lcxc7tfKf1SCY7R5ArysvrdRjbh5YtlWcHzB73prKR4hRj/Zo2ZzjgXMcS/e5wdgIgvLijwyeT4Df6ASOQdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTdDZxGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E175C4CECE;
	Thu, 12 Dec 2024 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734019865;
	bh=E3D+QdYMi6KPEAa20JW+O8s3X1NXZNoBuZGpQsgzv5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MTdDZxGMvTGy5Rixu8oSqPZCkipy0ww8L0PGvT1Z0+/rqGo4J1Z/P3ZR1w+PENGP0
	 EN42oMM81rv4Bl14F41VpbTJSEXQA7j+AcLfsngWTAFaySvMTDEWhU59X9IhAc64ez
	 4bnhLsECiAs/luE1zJuyH3xtgYLw88KBrAjKVDTTUyAhyPhCZJ9EoupO4MxeNEAQ/1
	 gSN7jyyUUPTnS/fC7JBLo5MN+u5f+LstSePVweqpUGAjWnml/hK41jIIWe2SXSfApQ
	 72K450oYA5c+AabSX+xGk1eWiyJj5IZRauvKO5kOCajz9bgoBeotxK9peY/XC879cz
	 hoS3jiehTa/Ng==
Date: Thu, 12 Dec 2024 10:11:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
Message-ID: <20241212161103.GA3345227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>

On Thu, Dec 12, 2024 at 09:56:16AM +0100, Lukas Wunner wrote:
> The Supported Link Speeds Vector in the Link Capabilities 2 Register
> indicates the *supported* link speeds.  The Max Link Speed field in
> the Link Capabilities Register indicates the *maximum* of those speeds.
> 
> Niklas reports that the Intel JHL7540 "Titan Ridge 2018" Thunderbolt
> controller supports 2.5-8 GT/s speeds, but indicates 2.5 GT/s as maximum.
> Ilpo recalls seeing this inconsistency on more devices.
> 
> pcie_get_supported_speeds() neglects to honor the Max Link Speed field
> and will thus incorrectly deem higher speeds as supported.  Fix it.
> 
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Looks like you want this in v6.13?  Can we make commit log more
explicit as to why we need it there?  Is this change enough to resolve
the boot hang Niklas reported?

> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35dc9f2..b730560 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
>  	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
>  
> +	/* Ignore speeds higher than Max Link Speed */
> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +	speeds &= GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
> +
>  	/* PCIe r3.0-compliant */
>  	if (speeds)
>  		return speeds;
>  
> -	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> -
>  	/* Synthesize from the Max Link Speed field */
>  	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
>  		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
> -- 
> 2.43.0
> 

