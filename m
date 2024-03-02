Return-Path: <linux-pci+bounces-4368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBBE86EEF9
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 07:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F021F22AD8
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 06:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7323A0;
	Sat,  2 Mar 2024 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFAJcLZs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154E10A29;
	Sat,  2 Mar 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709361755; cv=none; b=Gw41KfWOnn3RsgttwsyFtC8XoLamh1QNHvHRq8DIF/RcHnzCG9MqkOwJjDdxc2M47CBq9eVFZv5FqQaDgRnCoSsYuxVts9S6fWj9cGcAi4HoXhWH0UwxYFGnmuwP6WtOeD6cqLXPZ00xMK87NrtwOuSGM15vI8tH4+7c23+fHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709361755; c=relaxed/simple;
	bh=WOrN/31hQS95FJ2zZMbYPpH4RM3lD/JLzm3qpLPy3YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmF6DVcHu+wLHjby3aXfy1H89b49HkpQoNQSe4b6J9IKt6AXVn6BSaiimYaizs3P3WH/TMk+9e2SHDWIm9yXB4XQkIH+Jg05peBOSrcFLkKxjL6IZSvuXWfvGlGFdi4Ch6gGpIgTvnjUlNjjo+35EaicKX5lHB7UJr8LBW7WBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFAJcLZs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709361754; x=1740897754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WOrN/31hQS95FJ2zZMbYPpH4RM3lD/JLzm3qpLPy3YU=;
  b=dFAJcLZsYWYRse+R69Cn6VxPlAVLYryvA66cvUUC1kUrWo65qM7sJ3p1
   Psj3un2HvZ3OKrU0KFzdQYcF+L+Zddd2RYf+FFfGlRJOqBAuKon27+Z55
   V/5h1MhXjSsoBFKyRlJ9D8m/XZ/RWSny1xKwuXZCqTKs35DrwYFDwMbjx
   CBtjvkTQ0xDGqBAX4etznJfhiziL0e1v9NECa8d+fDdoi7N9E7vGhzDfZ
   WtP/hI1tI4ch7ClcxX8p0yKfeKnrVA0vTajSlNtHzEMJYdDR9JvxChI8H
   zPzmD5z1Zdfe0RBx0SonXq5ve9nFYin5idsK8/ZDSc1so9CTNISaHKAKT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3839789"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3839789"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 22:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="39423969"
Received: from doney-mobl.amr.corp.intel.com (HELO [10.209.53.18]) ([10.209.53.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 22:42:32 -0800
Message-ID: <18564c1f-f676-4cb8-9549-a9b87f853a3e@linux.intel.com>
Date: Fri, 1 Mar 2024 22:42:31 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI/DPC: Remove CONFIG_PCIE_EDR
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew W Carlis <mattc@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240301230604.GA368825@bhelgaas>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240301230604.GA368825@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/1/24 3:06 PM, Bjorn Helgaas wrote:
> On Sun, Feb 25, 2024 at 12:05:12PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Previous Kconfig allowed the possibility of enabling CONFIG_PCIE_DPC
>>> without CONFIG_PCIE_EDR.  The PCI Firmware Spec, r3.3, sec 4.5.1,
>>> table 4-5, says an ACPI OS that requests control of DPC must also
>>> advertise support for EDR.
>>>
>>> Remove CONFIG_PCIE_EDR and enable the EDR code with CONFIG_PCIE_DPC so that
>>> enabling DPC also enables EDR for ACPI systems.  Since EDR is an ACPI
>>> feature, build edr.o only when CONFIG_ACPI is enabled.  Stubs cover the
>>> case when DPC is enabled without ACPI.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>  drivers/acpi/pci_root.c   |  2 +-
>>>  drivers/pci/pcie/Kconfig  | 14 ++++----------
>>>  drivers/pci/pcie/Makefile |  5 ++++-
>>>  drivers/pci/pcie/dpc.c    | 10 ----------
>>>  include/linux/pci-acpi.h  |  4 ++--
>>>  5 files changed, 11 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>> index efc292b6214e..bcaf3d3a5e05 100644
>>> --- a/drivers/acpi/pci_root.c
>>> +++ b/drivers/acpi/pci_root.c
>>> @@ -448,7 +448,7 @@ static u32 calculate_support(void)
>>>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>>>  	if (pci_msi_enabled())
>>>  		support |= OSC_PCI_MSI_SUPPORT;
>>> -	if (IS_ENABLED(CONFIG_PCIE_EDR))
>>> +	if (IS_ENABLED(CONFIG_PCIE_DPC))	/* DPC => EDR support */
>>>  		support |= OSC_PCI_EDR_SUPPORT;
>> Since EDR internally touches AER registers, I still think we should
>> make sure OS enables AER support before advertising the EDR support.
> I guess you're suggesting that we should make it look like this?
>
>   if (host_bridge->native_aer && IS_ENABLED(CONFIG_PCIE_DPC))
>
> That doesn't seem right to me because the implementation note in PCI
> Firmware r3.3, sec 4.6.12, shows the EDR flow when firmware maintains
> control of AER and DPC, i.e., "host_bridge->native_aer" would be
> false.

No, my idea is to check for something like below:

if (IS_ENABLED(CONFIG_PCIEAER) && IS_ENABLED(CONFIG_PCIE_DPC)) or if (pci_aer_available() && IS_ENABLED(CONFIG_PCIE_DPC) to ensure AER is not disabled by noaer command line option. Since EDR handler depends on AER routines (like pci_aer_raw_clear_status()) to |clear AER registers, we need to ensure AER is enabled in kernel before advertising suppor for EDR.


>
>>>  	return support;
>>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>>> index 8999fcebde6a..21e98289fbe9 100644
>>> --- a/drivers/pci/pcie/Kconfig
>>> +++ b/drivers/pci/pcie/Kconfig
>>> @@ -137,6 +137,10 @@ config PCIE_DPC
>>>  	  have this capability or you do not want to use this feature,
>>>  	  it is safe to answer N.
>>>  
>>> +	  On ACPI systems, this includes Error Disconnect Recover support,
>>> +	  the hybrid model that uses both firmware and OS to implement DPC,
>>> +	  as specified in the PCI Firmware Specification r3.3.
>> Nit: Include some section reference?
> I basically copied this from the PCIE_EDR help and updated the
> revision number.  But I don't think the firmware spec is a very good
> reference because EDR is defined by ACPI.  There's very little text in
> the ACPI spec about EDR, but the firmware spec does assume you know
> what *is* there.  And the ACPI spec is available to anybody, unlike
> the PCI firmware spec.
>
> +         On ACPI systems, this includes Error Disconnect Recover support,
> +         the hybrid model that uses both firmware and OS to implement DPC,
> +         as specified in ACPI r6.5, sec 5.6.6.
>
>>>  config PCIE_PTM
>>>  	bool "PCI Express Precision Time Measurement support"
>>>  	help
>>> @@ -145,13 +149,3 @@ config PCIE_PTM
>>>  
>>>  	  This is only useful if you have devices that support PTM, but it
>>>  	  is safe to enable even if you don't.
>>> -
>>> -config PCIE_EDR
>>> -	bool "PCI Express Error Disconnect Recover support"
>>> -	depends on PCIE_DPC && ACPI
>>> -	help
>>> -	  This option adds Error Disconnect Recover support as specified
>>> -	  in the Downstream Port Containment Related Enhancements ECN to
>>> -	  the PCI Firmware Specification r3.2.  Enable this if you want to
>>> -	  support hybrid DPC model which uses both firmware and OS to
>>> -	  implement DPC.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


