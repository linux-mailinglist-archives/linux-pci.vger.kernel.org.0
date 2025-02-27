Return-Path: <linux-pci+bounces-22589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EDDA487F7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 19:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9045A16476F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A31EB5DD;
	Thu, 27 Feb 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/N4Oe7t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D71E0E13;
	Thu, 27 Feb 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681655; cv=none; b=HpywpFzZ/k5VwB4WW0Ewz6XO033NQorogG/JwiT8MK+VZEefA2BOS7Ka953vs+kh9bdDloS7SMG7xF1+1g3x9RHZoa7rKjZJ0wRjC0X+jV0jidlD/PMfhs1kij55mx0h+vmXXvjSPJ1bS1MeJ6/XuHXLNAGF9QmuJ5vDNnjF/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681655; c=relaxed/simple;
	bh=vIiOrfEhLsagNIxyFmXo7VnTxM/KF0Q81OADteh7vHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AQ82zcM1jmrdYjij4oj6oR3ogLvb8/DyhESkxwgvy4IPzU1kkBksXQqufdVX736UPPvmuwL6oYsNcFvg2k1aInpxDW+NZ1XnbNgI8ZtCXLV9sr/T3EMvE0+GC6m939QFdcOHM97URXoMWH4JnzefNblDUCJQGWchGyVSMz+f22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/N4Oe7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB3DC4CEE4;
	Thu, 27 Feb 2025 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740681654;
	bh=vIiOrfEhLsagNIxyFmXo7VnTxM/KF0Q81OADteh7vHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g/N4Oe7theyxINQUAaSoVJbRB99oTPw8aKnUURXcvkJKcOTqZDisbu5T1lfFupipx
	 ZcCz5t9bbOoWRrcim82hDpxCKZmJ7QE4Gde+4j0oH3ByU+h0X7eu6Kliu2EO9OgKX1
	 GIIIroYjrmwE+BtS9AR2BLVx3/BMWw2k+AF+9RAeV8S7+U0hYevV7rxUUlBPImuRbV
	 XbvbYmXmS+l+AYhd+hy5R4QzZD7dgVfVhe+Jdq2k0jU8Q5T8IxP8BV3ZeHQeShVYZe
	 cOcCacIfhAelWFlt/2YTEYKYgOOyMXoJ1Y1Cjr1zMf9glmU3syBMLwtbMc+D4Nuevy
	 7TAe6onKvQKLQ==
Date: Thu, 27 Feb 2025 12:40:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id
 doesn't match with spec
Message-ID: <20250227184053.GA609152@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216052751.5460-1-zhoushengqing@ttyinfo.com>

On Mon, Dec 16, 2024 at 05:27:51AM +0000, Zhou Shengqing wrote:
> Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> for PCI. Preserve PCI Boot Configuration Initial Revision ID changed to 2.
> But the code remains unchanged, still 1.
> 
> v4:Initialize *obj to NULL.
> v3:try revision id 1 first, then try revision id 2.
> v2:add Fixes tag.

Thanks for working on this issue.

  - Thanks for the revision history.  For future posts, put it below
    the "---" line so it's in the email but not part of the commit log.

  - I think there's a leak in pci_acpi_preserve_config() because it
    doesn't free "obj" before it returns true.  If you agree, add a
    preparatory patch to fix this.

  - Add a preparatory patch to return false early in
    pci_acpi_preserve_config() if !ACPI_HANDLE(&host_bridge->dev) so
    the body of the function is unindented, similar to what
    acpi_pci_add_bus() does.

  - Add another preparatory patch that adds acpi_check_dsm() of the
    desired function/rev ID for DSM_PCI_PRESERVE_BOOT_CONFIG,
    DSM_PCI_POWER_ON_RESET_DELAY, DSM_PCI_DEVICE_READINESS_DURATIONS.
    Move the "Evaluate PCI Boot Configuration" comment above the
    acpi_check_dsm() since it applies to the whole function, not just
    the rev 1 code in this patch.

  - Rework this patch so it only adds acpi_check_dsm() and
    acpi_evaluate_dsm_typed() for rev 2.

  - Throughout, wrap code and comments to fit in 80 columns because
    that's the convention for the rest of the file.

  - You can use "BIT(DSM_PCI_PRESERVE_BOOT_CONFIG)" and similar
    instead of "1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG" when calling
    acpi_check_dsm().

  - Add a [0/n] cover letter when posting the series.  Each patch
    should be a response to the cover letter.  "git format-patch" and
    "git send-email" will do that for you automatically.

> Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
> 
> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> ---
>  drivers/pci/pci-acpi.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..f805cd134019 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -123,19 +123,41 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>  bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
>  {
>  	if (ACPI_HANDLE(&host_bridge->dev)) {
> -		union acpi_object *obj;
> +		union acpi_object *obj = NULL;
>  
>  		/*
> -		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> -		 * exists and returns 0, we must preserve any PCI resource
> -		 * assignments made by firmware for this host bridge.
> +		 * Per PCI Firmware r3.2, released Jan 26, 2015,
> +		 * DSM_PCI_PRESERVE_BOOT_CONFIG Revision ID is 1.
> +		 * But PCI Firmware r3.3, released Jan 20, 2021,
> +		 * changed sec 4.6.5 to say
> +		 * "lowest valid Revision ID value: 2". So try revision 1
> +		 * first for old platform, then try revision 2.
>  		 */
> -		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
> -					      &pci_acpi_dsm_guid,
> -					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
> -					      NULL, ACPI_TYPE_INTEGER);
> -		if (obj && obj->integer.value == 0)
> -			return true;
> +		if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 1,
> +				   1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG)) {
> +			/*
> +			 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> +			 * exists and returns 0, we must preserve any PCI resource
> +			 * assignments made by firmware for this host bridge.
> +			 */
> +			obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
> +						      &pci_acpi_dsm_guid,
> +						      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
> +						      NULL, ACPI_TYPE_INTEGER);
> +			if (obj && obj->integer.value == 0)
> +				return true;
> +		}
> +
> +		if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 2,
> +				   1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG)) {
> +			obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
> +						      &pci_acpi_dsm_guid,
> +						      2, DSM_PCI_PRESERVE_BOOT_CONFIG,
> +						      NULL, ACPI_TYPE_INTEGER);
> +			if (obj && obj->integer.value == 0)
> +				return true;
> +		}
> +
>  		ACPI_FREE(obj);
>  	}
>  
> -- 
> 2.39.2
> 

