Return-Path: <linux-pci+bounces-3803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8A85CE3C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 03:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72FF2823CD
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 02:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B3E2556F;
	Wed, 21 Feb 2024 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo8+X5x2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533B2B9CC;
	Wed, 21 Feb 2024 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483537; cv=none; b=GJvoszCR+XQjklVZ+BTbD+rFOlrepmAheObMpUUPICvRquPCDgHzdipVLFfBBG7xmSd0GukfZrSYC/FBZVp7Ny9m9rtcApsHcCyMv80oHo84nvwDa4KAyq+80f6zUY0/gxU5RbvHFbE+GNY7IcUbfNapZHUV9j1cP6x7iNNrL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483537; c=relaxed/simple;
	bh=obtYbZZ9g4Ih4ksC+MZPfSTGjvsL7/Xd7/k5rk/le/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUZIeEPG8wYA9Cjj4Ajv9Y/Pu3o4Z5kD3NdM+m7H90LnCPCrwrN3ev4sMSZFeHoXfmJhDLnOLphFrzKxfWFh4tILZKHrtNVRix7uHrEnAbXYHIUTV563hzxTAHWTohCMSjowEObv2NL+mduI+0NPhLBKurraxHrAkGVV5X9oc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo8+X5x2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708483535; x=1740019535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=obtYbZZ9g4Ih4ksC+MZPfSTGjvsL7/Xd7/k5rk/le/s=;
  b=Fo8+X5x29Zw3DZ3UZcHSyPA9nijTRjbT3KxZyP+Pqt24FQB+KK0nk6NE
   c1dodl1U2EJ2iCW31H3bYM3EeRkvj/U5rkOx4Oxcvnl+qd7vdolW8O8g5
   1ltG9rD+agUbOjh6LsBSFSOH7GGw10Qiy7kPEyk/8pkjfFnzDVatqa9CA
   hUtjt0zGN/3vxkVzXUAzHtzbIZCEcTwDLP8l28DAlllRWMBMEyRoTDw6b
   cnu3mQtJvY51IJi6G2YIroGUobsTvnQ06llJl2DlC9xSDiPqaHAtY8Vtb
   9sO4K+afOtpMz3nToiuRhKj12ruBOII5T8Pv8nSiJ0jMOLSVsaQS86Mw5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13247242"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13247242"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:45:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5349724"
Received: from msbabaa-mobl.amr.corp.intel.com (HELO [10.209.28.248]) ([10.209.28.248])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:45:34 -0800
Message-ID: <39ef1387-609c-45ca-9bfa-e01b72cacaaa@linux.intel.com>
Date: Tue, 20 Feb 2024 18:45:32 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Request DPC only if also requesting AER
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 stable@vger.kernel.org, Matthew W Carlis <mattc@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240220235520.1514548-1-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240220235520.1514548-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/20/24 3:55 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> When booting with "pci=noaer", we don't request control of AER, but we
> previously *did* request control of DPC, as in the dmesg log attached at
> the bugzilla below:
>
>   Command line: ... pci=noaer
>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
>
> That's illegal per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, which
> says:
>
>   If the operating system sets this bit [OSC_PCI_EXPRESS_DPC_CONTROL], it
>   must also set bit 7 of the Support field (indicating support for Error
>   Disconnect Recover notifications) and bits 3 and 4 of the Control field
>   (requesting control of PCI Express Advanced Error Reporting and the PCI
>   Express Capability Structure).
>
> Request DPC control only if we have also requested AER control.

Can you also add similar check in calculate_support call?

        if (pci_aer_available() && IS_ENABLED(CONFIG_PCIE_EDR))
                support |= OSC_PCI_EDR_SUPPORT;


>
> Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218491#c12
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <stable@vger.kernel.org>	# v5.7+
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Matthew W Carlis <mattc@purestorage.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/acpi/pci_root.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 58b89b8d950e..1c16965427b3 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -518,17 +518,19 @@ static u32 calculate_control(void)
>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
>  		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>  
> -	if (pci_aer_available())
> +	if (pci_aer_available()) {
>  		control |= OSC_PCI_EXPRESS_AER_CONTROL;
>  
> -	/*
> -	 * Per the Downstream Port Containment Related Enhancements ECN to
> -	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> -	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> -	 * and EDR.
> -	 */
> -	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> -		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +		/*
> +		 * Per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, the
> +		 * OS can request DPC control only if it has advertised
> +		 * OSC_PCI_EDR_SUPPORT and requested both
> +		 * OSC_PCI_EXPRESS_CAPABILITY_CONTROL and
I think you mean OSC_PCI_EXPRESS_DPC_CONTROL.
> +		 * OSC_PCI_EXPRESS_AER_CONTROL.
> +		 */
> +		if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> +			control |= OSC_PCI_EXPRESS_DPC_CONTROL;

Since you are cleaning up this part, why not add a patch to remove
CONFIG_PCIE_EDR?


> +	}
>  
>  	return control;
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


