Return-Path: <linux-pci+bounces-3982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FEB862C9D
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 20:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA07E28163D
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464FD18E27;
	Sun, 25 Feb 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkMg9EZx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E21367;
	Sun, 25 Feb 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708890371; cv=none; b=pFNVcsrk3xnsNTS0zYWdsM1M5HD9uLK8+Jh1OPL99V8IXS8L0elOA9PKWSffA9qXK3McMc7FnK8hEW20qm+hnQvdT9gBnhUE0U15PayO+oRELDaTA7lAp9sh8kNGix2sJaJLDROGD3bUc510roUWGpxejWdTCFNo6TD+y8q+A8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708890371; c=relaxed/simple;
	bh=XCasjtMWxULI0q12pSVTKCODcbYjr1nwdvbMM85j5iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4iWfqFFdFTX2gyy/VwuneYJ6egk8ATmHeaqkzBPXYtE2KcghDtfmMaaGzgBDfOdB5sZVa36RwY17/kdyGZ9gYK40NGnUlRoTYIPR8lStIGL5qQlCCqU0mV9G7httACNpgF8ZOrW+vJ8EyuocWuxNMbLqrMLRtvdEfSuIYOhm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkMg9EZx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708890369; x=1740426369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XCasjtMWxULI0q12pSVTKCODcbYjr1nwdvbMM85j5iU=;
  b=RkMg9EZxKUYxzX52B5bj5IZkaa7OkWQPwhmP8Dr9vT749wD07O+DZDoe
   VSsTg/lwJ90ULgkhecjE1fp0X0EWG4nq4H0aYYKukodOsTBGZ+pMn2FPw
   RcpUB1Q69bo1pyuiMam2qELmcYDCYd8PwiKCIfx43KtNt/N6M/B1dp9Ev
   D00pShMBtcrgC0ZzBe3X7f2eh51qXGD5M4xYhQ5M07nKDcKX/sU0exAfn
   groY8cvYTazzUUYQyRMQwFcLfTInvo92rWsV73kwdhLpcuvV956BPkiW1
   j2jYP+22tQMfrohhhbFe/Fmy43HGZnHgMxh1kmZIr8jNENtQMFiMkl4HO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3321159"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3321159"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 11:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11048625"
Received: from gcsargen-mobl1.amr.corp.intel.com (HELO [10.255.228.214]) ([10.255.228.214])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 11:46:08 -0800
Message-ID: <b81b1e5b-81fa-4df0-926d-1d75323cf47b@linux.intel.com>
Date: Sun, 25 Feb 2024 11:46:07 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI/DPC: Request DPC only if also requesting AER
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew W Carlis <mattc@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
References: <20240222221521.32159-1-helgaas@kernel.org>
 <20240222221521.32159-2-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240222221521.32159-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
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

IIUC, this dependency is discussed in sec 4.5.2.4. "Dependencies Between
_OSC Control Bits".

Because handling of Downstream Port Containment has a dependency on Advanced Error
Reporting, the operating system is required to request control over Advanced Error Reporting (bit 3
of the Control field) while requesting control over Downstream Port Containment Configuration
(bit 7 of the Control field). If the operating system attempts to claim control of Downstream Port
Containment Configuration without also claiming control over Advanced Error Reporting, firmware
is required to refuse control of the feature being illegally claimed and mask the corresponding bit.
Firmware is required to maintain ownership of Advanced Error Reporting if it retains ownership of
Downstream Port Containment Configuration.
If the operating system sets bit 7 of the Control field, it must set bit 7 of the Support field, indicating
support for the Error Disconnect Recover event.

>
> Request DPC control only if we have also requested AER control.
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
Code wise it looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/acpi/pci_root.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 58b89b8d950e..efc292b6214e 100644
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
> +		 * OSC_PCI_EXPRESS_AER_CONTROL.
> +		 */
> +		if (IS_ENABLED(CONFIG_PCIE_DPC))
> +			control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +	}
>  
>  	return control;
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


