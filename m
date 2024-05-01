Return-Path: <linux-pci+bounces-6976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888018B912A
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA75A1C23173
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D790165FAA;
	Wed,  1 May 2024 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2XI3Aqr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79294D5BF;
	Wed,  1 May 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600212; cv=none; b=AU3ktb2A50CfV76tFvmDdig/NQtj2wv0+EzDt8kc9ZKGZLxfAG0UQtRisxYL2MZsAJAv9p58oF/8U6XnZ0HiKFPgZ074JTsxkFAQ5JpK+sHCJP8bW9rOl4oUPqHu7a/fxRDXRfn3x51ek7GkZF64s5/Xj63jRXLL8N2sizAF85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600212; c=relaxed/simple;
	bh=pcEtMp9KIjl5HwjSdfzFcU8G7IUQM5kmByyI59bmh78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EZFTCbFaC+Svd6l804yczIh3IQmxm5h/5TUnGY/ealGjXEMBUS9yIALL9LB+VKW6Q7ic08jeBv2uslW9BmOWISAC63Vv+iTJcF2SOzdRR/zlnnPHZwrkGfqJvD/FZxr7emskJ6iZuX1moJ8Kwm0nW9QOBh23jNva3QR7EQ1KqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2XI3Aqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9D2C072AA;
	Wed,  1 May 2024 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714600211;
	bh=pcEtMp9KIjl5HwjSdfzFcU8G7IUQM5kmByyI59bmh78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a2XI3AqrZE+c4PfLpNkS3DVRHX69WeR8DfKh9dfh2+rLOw4e4jgz/XiRTLn5VEXlJ
	 p7ZYKrpnIMstghUlbT9S4HwMjGfF4ru0HB2Fx4r+FW+ZDhjN0BcLEuhCZqyKdTCDAh
	 X1bH0zST764gXfP3Gi3CkJQHC7J+3QSFXEuc8uL94qpprjhkER3cG1yQ92kj0Fe0mS
	 Q3D4Y1EOviK1gTKwEvb5pm1f4EW8vOFe5GzDGsvawGTp8QQHbQlUI74eSCOT2xn8gD
	 1Wa3qDaXvn7s6k12RBZ2fwrfs78eCflFWbkyuINAmo7dFA1YYzgWHv20KX8NV0Utmi
	 qVfDlMY4p/4Hg==
Date: Wed, 1 May 2024 16:50:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thatchanamurthy Satish <Satish.Thatchanamurt@dell.com>
Subject: Re: [PATCH v1] PCI/EDR: Align EDR implementation with PCI firmware
 r3.3 spec
Message-ID: <20240501215009.GA1497134@bhelgaas>
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

How confident are we that this won't break any existing platforms?
Any idea how many platforms implement EDR_PORT_DPC_ENABLE_DSM and what
Revision IDs they support?

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

This changes two _DSMs, and I think it should be two patches.

Same question here: we now depend on functionality we didn't depend on
before.  How confident are we in this?

>  	/*
>  	 * Firmware returns DPC port BDF details in following format:
>  	 *	15:8 = bus
> -- 
> 2.25.1
> 

