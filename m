Return-Path: <linux-pci+bounces-1598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3AC821EF8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 16:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153A72812CC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836114293;
	Tue,  2 Jan 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DH5Qk1hm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138A14A82
	for <linux-pci@vger.kernel.org>; Tue,  2 Jan 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704210109; x=1735746109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ROU17/gHk/KKPn7C1mTKOCOEF1KQDZX6LP4S7lTeaFU=;
  b=DH5Qk1hm2ktx4Uf2FglNFZVvkip21K9Fjo+N8k4krFbFg8wHA83fU7dY
   LY3H7k9Xt/GM7LJt5w9EfSAzmmEXP7pR+qCOd6szzzsdvD/fVfeoxrqkj
   APyF7cHXrerdPGUY+mpPDbtEIvydG2Q9acQIFR7xypf2Yt0/2fxaJYGku
   C/3QNJslC+wad5ksuXuhMx8g0WiRKOs9PL/EqOVroFCVggwuRMP3gD343
   WLRvJwC/RLp2bS2w3aEV9Ui1K/5IPXN+p+xYwiQEbHpEuZMhRQn7DErUw
   KWnmNv8hZ+roRu82HFCHuR5vOd+9w0Iq2HUHSre6Pc0drNXO/7YZXqT+z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="381849627"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="381849627"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 07:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1026808255"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="1026808255"
Received: from mgaona-t14.amr.corp.intel.com (HELO [10.209.62.145]) ([10.209.62.145])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 07:41:48 -0800
Message-ID: <ed47c116-78eb-40d7-a5e7-0c23e1e6712f@linux.intel.com>
Date: Tue, 2 Jan 2024 07:41:49 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
To: Bjorn Helgaas <helgaas@kernel.org>,
 Matthew W Carlis <mattc@purestorage.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 mika.westerberg@linux.intel.com, Keith Busch <kbusch@kernel.org>,
 Lukas Wunner <lukas@wunner.de>
References: <20231228212340.GA1553749@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231228212340.GA1553749@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/28/2023 1:23 PM, Bjorn Helgaas wrote:
> [+cc Keith, Lukas]
> 
> Hi Matthew, thanks for your work and the patch.
> 
> On Sat, Dec 23, 2023 at 02:22:35PM -0700, Matthew W Carlis wrote:
>> This change ensures the kernel will use DPC on a supporting device if
>> the kernel will also control AER on the Root Ports & RCECs.
>>
>> The rules around controlling DPC/AER are somewhat clear in PCIe/ACPI
>> specifications. It is recommended to always link control of both to the
>> same entity, being the OS or system firmware. The kernel wants to be
>> flexible by first having a default policy, but also by providing command
>> line parameters to enable us all to do what we want even if it might
>> violate the recommendations.
>>
>> The following mentioned patch brought the kernels default behavior
>> more in line with the specification around AER, but changed its behavior
>> around DPC on PCIe Downstream Switch Ports; preventing the kernel from
>> controlling DPC on them unless using pcie_ports=dpc-native.
>>     * "PCI/portdrv: Allow AER service only for Root Ports & RCECs"
>> After this change the behavior around using DPC on PCIe switch ports
>> and Root Ports should be as it was before.
>>
>> Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
>> ---
>>  drivers/pci/pcie/portdrv.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index 14a4b89a3b83..8e023aa97672 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -257,12 +257,19 @@ static int get_port_device_capability(struct pci_dev *dev)
>>  	}
>>  
>>  	/*
>> +	 * _OSC AER Control is required by the OS & requires OS to control AER,
>> +	 * but _OSC DPC Control isn't required by the OS to control DPC; however
>> +	 * it does require the OS to control DPC. _OSC DPC Control also requres
>> +	 * _OSC EDR Control (Error Disconnect Recovery) (PCI Firmware - DPC ECN rev3.2)
>> +	 * PCI_Express_Base 6.1, 6.2.11 Determination of DPC Control recommends
>> +	 * platform fw or OS always link control of DPC to AER.
>> +	 *
>>  	 * With dpc-native, allow Linux to use DPC even if it doesn't have
>>  	 * permission to use AER.
>>  	 */
>>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>> -	    pci_aer_available() &&
>> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>> +	    pci_aer_available() && (pcie_ports_dpc_native ||
>> +	    (dev->aer_cap && host->native_aer)))
>>  		services |= PCIE_PORT_SERVICE_DPC;
> 
> This is easier to read if we retain the original line breaks, i.e.,
> 
>   -     (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>   +     (pcie_ports_dpc_native || (dev->aer_cap && host->native_aer)))
> 
> Prior to d8d2b65a940b, we set PCIE_PORT_SERVICE_AER for a device
> whenever it had an AER Capability.  If it had a DPC Capability, we
> also set PCIE_PORT_SERVICE_DPC so DPC would work on it.
> 
> After d8d2b65a940b, we only set PCIE_PORT_SERVICE_AER for Root Ports
> and RCECs because the AER driver only binds to those devices.  We no
> longer set PCIE_PORT_SERVICE_DPC for Switch Downstream Ports because
> they don't have PCIE_PORT_SERVICE_AER set.
> 
> The result is that you need "pcie_ports=dpc-native" to make DPC work
> on those devices when you didn't need it before d8d2b65a940b.
> 
> That's a regression that we need to fix:
> #regzbot introduced: d8d2b65a940b ("PCI/portdrv: Allow AER service only for Root Ports & RCECs")
> 
> _OSC directly supports negotiation of DPC ownership, and I think we
> should pay attention to what it tell us.  We already request DPC
> control and set native_dpc accordingly, but we don't use it here;
> currently we only look at it in the unrelated pciehp_ist() path.
> 
> Can you try the patch below and see if it resolves the problem?
> 
> I don't think we need to complicate this by trying to enforce the
> AER/DPC dependencies in the OS.  The firmware spec already requires
> platforms to either retain ownership of both AER and DPC, or grant
> ownership of both to the OS.

Change looks fine to me. Once concern is, what if we are dealing with
a buggy firmware which give DPC native control, but retains AER? Do
you think it makes sense to have a sanity check to make sure this
does not happen?

> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..423dadd6727e 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -262,7 +262,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>  	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    (pcie_ports_dpc_native || host->native_dpc))
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

