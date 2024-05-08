Return-Path: <linux-pci+bounces-7268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DD18C0566
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 22:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC4C1C21028
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7E130E2C;
	Wed,  8 May 2024 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlVzvJsU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB412BF23;
	Wed,  8 May 2024 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199273; cv=none; b=NR0LI2zlaXZv3soC6vAn360pP/Gwm2VydNIqxIQ3bqS9qar2i/QlYjKB4lzWHEcKjSVASPG3glB2HjX4bzYjmUe8cpjzLpKgwwh7jBHImMREaKi2V8jLN6Y324p2iU9tR9K/6Yc1jU+LRGke1Psx4+XPjnuqzvHbZv2EY4W6rA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199273; c=relaxed/simple;
	bh=cSANn1r02z11GW7siTDbWe0wORQUwoGGbSwqIt0FLcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KwwWzE8+Pi+0tt59wcLxnRcWZh7vE8Ek5GOryShYZ2+kVuzuLqty9au5pUvIvdLT8Spe+CtwNGxoa33SsyVtz5XHO/UYam/8Edta8BhzZgHitwQCYTTuqlaQItlFYoxtpQAh+Tp4Ts9EcvixHX92/VmYRdeM9rbJb/SuEN9dpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlVzvJsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00BEC32782;
	Wed,  8 May 2024 20:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715199272;
	bh=cSANn1r02z11GW7siTDbWe0wORQUwoGGbSwqIt0FLcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FlVzvJsUILIQP0KBq+N5hgAJgaHSXEMjXDcyqpJy1EieK7aG4r4vxhyX+8s9lTAYe
	 +kDKa0nFoVnCntiwWxP6gMq9KBuVU0yL8HYWytPYOeezCtn4LvInsgL65QIPKi82bH
	 prq0oq6yOmrHQAPxBi9Hr/524Ro4hZVTVTnsB+ZRtYHlbeBtJ7HQPby697zmNUoL+X
	 HA8bKH8Xg6cVKjGU9FbPJKH8DDnNgvT6l2oruCaKoBjidQkIhYveJuEt11ZT0OVOgE
	 plvu/3bhbWj2hxv7fEYMcegNkHa77rPSIbIDh8YUBlAZ4a325ItEDJ4VMJmvbw8Z0m
	 SVUXjjo0hJD0Q==
Date: Wed, 8 May 2024 15:14:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thatchanamurthy Satish <Satish.Thatchanamurt@dell.com>
Subject: Re: [PATCH v1] PCI/EDR: Align EDR implementation with PCI firmware
 r3.3 spec
Message-ID: <20240508201430.GA1785648@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501022543.1626025-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Wed, May 01, 2024 at 02:25:43AM +0000, Kuppuswamy Sathyanarayanan wrote:
> During the Error Disconnect Recover (EDR) spec transition from r3.2 ECN
> to PCI firmware spec r3.3, improvements were made to definitions of
> EDR_PORT_DPC_ENABLE_DSM (0x0C) and EDR_PORT_LOCATE_DSM(0x0D) _DSMs.
> 
> Specifically,
> 
> * EDR_PORT_DPC_ENABLE_DSM _DSM version changed from 5 to 6, and
>   arg4 is now a package type instead of an integer in version 5.
> * EDR_PORT_LOCATE_DSM _DSM uses BIT(31) to return the status of the
>   operation.
> 
> Ensure _DSM implementation aligns with PCI firmware r3.3 spec
> recommendation. More details about the EDR_PORT_DPC_ENABLE_DSM and
> EDR_PORT_LOCATE_DSM _DSMs can be found in PCI firmware specification,
> r3.3, sec 4.6.12 and sec 4.6.13.
> 
> While at it, fix a typo in EDR_PORT_LOCATE_DSM comments.
> 
> Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

I split this into two patches and applied them to pci/edr for v6.10,
thanks!

Take a look here:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=edr
and make sure I didn't mess it up (only differences are comments and
commit logs).

> ---
>  drivers/pci/pcie/edr.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index 5f4914d313a1..fea098e22e3e 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>  	 * Behavior when calling unsupported _DSM functions is undefined,
>  	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>  	 */
> -	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
>  			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
>  		return 0;
>  
> @@ -47,11 +47,11 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>  	argv4.package.elements = &req;
>  
>  	/*
> -	 * Per Downstream Port Containment Related Enhancements ECN to PCI
> -	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
> -	 * optional.  Return success if it's not implemented.
> +	 * Per PCI Firmware Specification r3.3, sec 4.6.12,
> +	 * EDR_PORT_DPC_ENABLE_DSM is optional. Return success if it's not
> +	 * implemented.
>  	 */
> -	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
>  				EDR_PORT_DPC_ENABLE_DSM, &argv4);
>  	if (!obj)
>  		return 0;
> @@ -86,7 +86,7 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>  
>  	/*
>  	 * Behavior when calling unsupported _DSM functions is undefined,
> -	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
> +	 * so check whether EDR_PORT_LOCATE_DSM is supported.
>  	 */
>  	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>  			    1ULL << EDR_PORT_LOCATE_DSM))
> @@ -103,6 +103,17 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>  		return NULL;
>  	}
>  
> +	/*
> +	 * Per PCI Firmware Specification r3.3, sec 4.6.13, bit 31 represents
> +	 * the success/failure of the operation. If bit 31 is set, the operation
> +	 * is failed.
> +	 */
> +	if (obj->integer.value & BIT(31)) {
> +		ACPI_FREE(obj);
> +		pci_err(pdev, "Locate Port _DSM failed\n");
> +		return NULL;
> +	}
> +
>  	/*
>  	 * Firmware returns DPC port BDF details in following format:
>  	 *	15:8 = bus
> -- 
> 2.25.1
> 

