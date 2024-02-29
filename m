Return-Path: <linux-pci+bounces-4219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F886BC67
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 01:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CDC28A657
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380E367;
	Thu, 29 Feb 2024 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfyjDQ15"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808E13D2FD;
	Thu, 29 Feb 2024 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164812; cv=none; b=OO6DW+krpYRFRZaGqyRHR+gUwJEjgpT1JScFbUwiuXr5dOzqG7+ZAbQaAUl+WZZkn+AHjMKsoRqTbfg92D9gfGW0Cgu9ix+ZlL7sKtgyLMSMljX8JHx3n8CxRU5CBb9G9b29c1KnwhokhoH4wKLbAvYPIo+R5w7lglVXglVHZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164812; c=relaxed/simple;
	bh=qo1L9+mSe0yIWvvN760Et2xlAvVq2979ZfEn++Kk//I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdsnoCBy1alguecqQcIlRrS4FTRAgd0rqnvL2e/DhZbkscogV3M/kTqeQJrJE8pxRIRX/FhkzW4gXbUO+b9GNZlpd8DR7+XFcSt2LCcxpeMvTSdfKcI4zTC8CSc5FzN2a0AnR+OJ5/ViRanX9TaTrlcwABslRl1Pvtqo9CxjSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfyjDQ15; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709164811; x=1740700811;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qo1L9+mSe0yIWvvN760Et2xlAvVq2979ZfEn++Kk//I=;
  b=CfyjDQ15YM1r2TiNytL9Kwhx0Nh12ohOTMYYeLUBJA3uBAXm31o5KmIV
   Maa/fIJy5y5IrjpP4Hhyl+QXRCscKIaH86qaXCQ4bzwlnL/5o5AVLSzgO
   jCryq4Ve/mxtnmxCErY1IjZQIjpAveAjsqi3F8fr1zR5SiwYsnqJkZqrf
   lzv/Kvvzd9qGtib7q0YE1ZbeuVKA05EspzkJOQ1FAza8E4lRq6NjAl4TV
   EZ/+K/LJmNK+S5d2ahMlJPuLXG7oDY1CvYLTJ6HaQn96f8DPiV66sRvav
   7vFm6sIWUbHvJG2NZQ8Nvin2ucH61ztd5Mw/DXdurud2ilmkfU71YTH42
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="4183220"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="4183220"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:00:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="30785492"
Received: from smitpat1-mobl.amr.corp.intel.com (HELO [10.209.30.182]) ([10.209.30.182])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:00:06 -0800
Message-ID: <f446dfda-53e1-4e65-bbe5-0488028f55ad@linux.intel.com>
Date: Wed, 28 Feb 2024 16:00:06 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCI/DPC: Clean up DPC vs AER/EDR ownership and
 Kconfig
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew W Carlis <mattc@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240222221521.32159-1-helgaas@kernel.org>
 <89984f11-b84e-4da0-ab5b-f2048461aae0@linux.intel.com>
 <52245cb8-879e-4997-a1b5-cdfbd702dee7@linux.intel.com>
 <81f2dfa4-14c6-423c-96ee-b11b8a4670ed@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <81f2dfa4-14c6-423c-96ee-b11b8a4670ed@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/26/24 11:12 PM, Ethan Zhao wrote:
> On 2/27/2024 2:35 PM, Kuppuswamy Sathyanarayanan wrote:
>> Hi,
>>
>> On 2/26/24 10:18 PM, Ethan Zhao wrote:
>>> On 2/23/2024 6:15 AM, Bjorn Helgaas wrote:
>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> Previously we could request control of DPC without AER, which is illegal
>>>> per spec.  Also, we could enable CONFIG_PCIE_DPC without CONFIG_PCIE_EDR,
>>>> which is also illegal.  This series addresses both.
>>> I have a question here, how to understand the relationship EDR & AER ?
>>> somewhere EDR touches AER status without checking _OSC granted bits,
>>> such as
>>>     pci_aer_raw_clear_status(edev);
>>
>> Which_OSC bits?
>>
>> EDR code will only get triggered if OS advertises the EDR support (which
>> also means OS supports AER and DPC), and both AER and DPC is owned by
>> the firmware. During the EDR notification, the OS is allowed to touch AER
>
> Means no need to check if host->native_aer ? why checked in
> pcie_do_recovery() ?

pcie_do_recovery() can be called form EDR (FF) or native path. That check is used
to skip device status clearing in FF mode. You can find details about it in

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/pcie/err.c?id=068c29a248b6ddbfdf7bb150b547569759620d36



>
> Thanks,
> Ethan
>
>> and DPC registers. So there is no problem with EDR code using AER routines.
>>
>>
>>> sometimes EDR calling AER with host->native_aer checked, like
>>>
>>> pcie_do_recovery()
>>> {
>>>   ...
>>>   if (host->native_aer || pcie_ports_native) {
>>>          pcie_clear_device_status(dev);
>>>          pci_aer_clear_nonfatal_status(dev);
>>>      }
>>>   ...
>>> }
>>>
>>> That is really confusing. could we do some cleanup to eliminate it ?
>>> such as seperate AER code into common code and runtime part.
>>>
>>>
>>> Thanks,
>>> Ethan
>>>  
>>>> Bjorn Helgaas (3):
>>>>     PCI/DPC: Request DPC only if also requesting AER
>>>>     PCI/DPC: Remove CONFIG_PCIE_EDR
>>>>     PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
>>>>
>>>>    drivers/acpi/pci_root.c   | 22 ++++++++++++----------
>>>>    drivers/pci/pci.h         |  4 ++++
>>>>    drivers/pci/pcie/Kconfig  | 14 ++++----------
>>>>    drivers/pci/pcie/Makefile |  5 ++++-
>>>>    drivers/pci/pcie/dpc.c    | 10 ----------
>>>>    include/linux/pci-acpi.h  |  8 --------
>>>>    6 files changed, 24 insertions(+), 39 deletions(-)
>>>>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


