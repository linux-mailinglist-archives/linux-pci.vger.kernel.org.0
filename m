Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0247E36DE1D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbhD1RWD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 13:22:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:31875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhD1RWD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 13:22:03 -0400
IronPort-SDR: XWMHNS+wPjLie1H7hBz2NfTsDEJbeLaQDEl6YlivxlsW5VAmlKjLVIZty42WlftZQ1UmtT+gAe
 fdAkZRfcBULg==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="196358545"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="196358545"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 10:21:17 -0700
IronPort-SDR: cEvlCi3kOBH3dTkRN8SBpGaWOVoi90VfEqm9CSV9CtLns7T37tsTWnyFaetDwLqTl6FVw2AxIQ
 M7f0fLuWrMfQ==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="425680637"
Received: from turnerrx-desk.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.37.37])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 10:21:14 -0700
Subject: Re: [RFC PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
To:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
References: <20210428081857.10322-1-joro@8bytes.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d24893db-2c9e-dbb1-75d2-53b96760c80e@linux.intel.com>
Date:   Wed, 28 Apr 2021 10:21:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428081857.10322-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/28/21 1:18 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The acpi_pci_osc_support() does an _OSC query with _OSC supported set
> to what the OS supports but a zero _OSC control value. This is
> problematic on some platforms where the firmware allows to configure
> whether DPC is under OS or Firmware control.

Do we run acpi_pci_osc_support() only to check whether _OSC is
supported ? Or does it serve any other purpose.


> 
> When DPC is configured to be under OS control these platforms will
> issue a warning in the firmware log that the OS does not support DPC.

Also, is there any other benefit from this patch other than fixing
a warning message in firmware?

> 
> Avoid an _OSC query with _OSC control set to zero by moving the
> supported check into the acpi_pci_osc_control_set() path. This is
> still early enough to fail as nothing before that depends on the
> results of acpi_pci_osc_support().
> 
> As a result the acpi_pci_osc_support() function can be removed and
> acpi_pci_query_osc() be simplified because it no longer called with a
> NULL pointer for *control.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/acpi/pci_root.c | 50 ++++++++++++++++-------------------------
>   1 file changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index dcd593766a64..530ecf4970b1 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -199,16 +199,11 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>   
>   	support &= OSC_PCI_SUPPORT_MASKS;
>   	support |= root->osc_support_set;
> +	*control &= OSC_PCI_CONTROL_MASKS;
>   
>   	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
>   	capbuf[OSC_SUPPORT_DWORD] = support;
> -	if (control) {
> -		*control &= OSC_PCI_CONTROL_MASKS;
> -		capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
> -	} else {
> -		/* Run _OSC query only with existing controls. */
> -		capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
> -	}
> +	capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
>   
>   	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
>   	if (ACPI_SUCCESS(status)) {
> @@ -219,11 +214,6 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>   	return status;
>   }
>   
> -static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
> -{
> -	return acpi_pci_query_osc(root, flags, NULL);
> -}
> -
>   struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
>   {
>   	struct acpi_pci_root *root;
> @@ -346,7 +336,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>    * _OSC bits the BIOS has granted control of, but its contents are meaningless
>    * on failure.
>    **/
> -static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
> +static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32
> +					    *mask, u32 req, u32 support)
>   {
>   	struct acpi_pci_root *root;
>   	acpi_status status;
> @@ -370,7 +361,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
>   
>   	/* Need to check the available controls bits before requesting them. */
>   	while (*mask) {
> -		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
> +		status = acpi_pci_query_osc(root, support, mask);
>   		if (ACPI_FAILURE(status))
>   			return status;
>   		if (ctrl == *mask)
> @@ -433,18 +424,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>   		support |= OSC_PCI_EDR_SUPPORT;
>   
>   	decode_osc_support(root, "OS supports", support);
> -	status = acpi_pci_osc_support(root, support);
> -	if (ACPI_FAILURE(status)) {
> -		*no_aspm = 1;
> -
> -		/* _OSC is optional for PCI host bridges */
> -		if ((status == AE_NOT_FOUND) && !is_pcie)
> -			return;
> -
> -		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> -			 acpi_format_exception(status));
> -		return;
> -	}
>   
>   	if (pcie_ports_disabled) {
>   		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> @@ -483,7 +462,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>   
>   	requested = control;
>   	status = acpi_pci_osc_control_set(handle, &control,
> -					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> +					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL,
> +					  support);
>   	if (ACPI_SUCCESS(status)) {
>   		decode_osc_control(root, "OS now controls", control);
>   		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
> @@ -496,10 +476,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>   			*no_aspm = 1;
>   		}
>   	} else {
> -		decode_osc_control(root, "OS requested", requested);
> -		decode_osc_control(root, "platform willing to grant", control);
> -		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> -			acpi_format_exception(status));
> +		/* Platform wants to control PCIe features */
> +		root->osc_support_set = 0;
>   
>   		/*
>   		 * We want to disable ASPM here, but aspm_disabled
> @@ -509,6 +487,16 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>   		 * root scan.
>   		 */
>   		*no_aspm = 1;
> +
> +		/* _OSC is optional for PCI host bridges */
> +		if ((status == AE_NOT_FOUND) && !is_pcie)
> +			return;
> +
> +		decode_osc_control(root, "OS requested", requested);
> +		decode_osc_control(root, "platform willing to grant", control);
> +		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> +			acpi_format_exception(status));
> +
>   	}
>   }
>   
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
