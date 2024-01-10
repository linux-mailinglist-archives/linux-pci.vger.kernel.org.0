Return-Path: <linux-pci+bounces-2004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588B829EE8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 18:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77456B21185
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D3495D1;
	Wed, 10 Jan 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEyQSReo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539F4CDFF
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704906792; x=1736442792;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=e7X7FVIdNqrId6dslFXT97oFA8hTV+sz5JnU2r8moCQ=;
  b=nEyQSReocZLOueBlG0UFGaKgxRx6S7DqAb3d0T5p7rbBRMOuMuWmqTV9
   ukJQg6uffnzLkofc+NpwoDmY3JPlg42igjAUWOAg3Wb+qy02gQoKMNAC/
   OYupJUSLgq6oWVVWQ49XCNpA+C6rD2r+eiC6Qyza43bGUe7TchagUYYXH
   DFk4zb+i5tIuF9mV7kOfaTG+sEKi7wEOaQ4caykSb7N/MEPLrO1UYU9Ap
   FkyXgvoBiFG9LZx6hGXdOMtptPUd66dMBnTrWiAiFXXPrCsddy+jD3YBb
   sz0xs8fieJtpDkgadYL5LXkLz8dNzINkKCdTtgtKAjVHXIzETeVEe4+n3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="17176564"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="17176564"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 09:13:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="731905512"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="731905512"
Received: from unknown (HELO [10.125.225.30]) ([10.125.225.30])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 09:13:10 -0800
Message-ID: <3c02a6d6-917e-486c-ad41-bdf176639ff2@linux.intel.com>
Date: Wed, 10 Jan 2024 09:13:10 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, kbusch@kernel.org,
 linux-pci@vger.kernel.org, lukas@wunner.de, mika.westerberg@linux.intel.com
References: <aac66e30-4b3f-4b08-83bd-d50472007212@linux.intel.com>
 <20240109001508.32359-1-mattc@purestorage.com>
 <65c81900-cec6-4d3a-b2fe-bb8169ee701c@linux.intel.com>
In-Reply-To: <65c81900-cec6-4d3a-b2fe-bb8169ee701c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/2024 8:41 AM, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 1/8/2024 4:15 PM, Matthew W Carlis wrote:
>> A small part is probably historical; we've been using DPC on PCIe switches
>> since before there was any EDR support in the kernel. It looks like there
>> was a PCIe DPC ECN as early as Feb 2012, but this EDR/DPC fw ECN didn't come in
>> till Jan 2019 & kernel support for ECN was even later. Its not immediately
>> clear I would want to use EDR in my newer architecures & then there are also
>> the older architecures still requiring support. When I submitted this patch I
>> came at it with the approach of trying to keep the old behavior & still support
>> the newer EDR behavior. Bjorns patch from Dec 28 2023 would seem to change
> 
> Just advertising the support for EDR in OS should not change any functional
> behavior. EDR will be used only if your firmware take DPC control and sends
> EDR notification. Since your kernel has EDR source support, why not enable
> the relevant config? or did I not understand the issue correctly?
> 

Hi Bjorn,

Since requesting DPC control needs both EDR and DPC support in kernel, I am
wondering whether we need two different configs for it. IMO, it makes sense to
merge them under one config. I don't see EDR working without DPC support. Since
DPC control also need support for EDR, I think we don't need to differentiate
them. What you think?

file: drivers/acpi/pci_root.c
+       /*
+        * Per the Downstream Port Containment Related Enhancements ECN to
+        * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
+        * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
+        * and EDR.
+        */
+       if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
+               control |= OSC_PCI_EXPRESS_DPC_CONTROL;


>> the behavior for both root ports & switch ports, requiring them to set
>> _OSC Control Field bit 7 (DPC) and _OSC Support Field bit 7 (EDR) or a kernel
>> command line value. I think no matter what, we want to ensure that PCIe Root
>> Ports and PCIe switches arrive at the same policy here.
>>
>> Should we consider CONFIG_PCIEAER or CONFIG_PCIEDPC as any amount of directive
>> for the OS to use AER/DPC? In addition we have kernel command line arguments
> 
> No, I don't think we should use CONFIG options in actual support check.
> 
>> for pcieports=(compat/native/dpc-native) and pci=noaer. There are perhaps some
>> others I'm not aware of. Then, there are the PCIe capabilities of the devies
>> & bios settings for AER FW/OS controls, etc. I'm not sure if it strikes me as the
>> right thing to now require users to specify additional fields to use DPC when
>> they had been using it happily before.
>>
>> Perhaps the condition should be:
>>>         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>>> -           pci_aer_available() &&
>>> -           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>>> +           pci_aer_available() && (pcie_ports_dpc_native ||
>>> +           (host->native_aer && !IS_ENABLED(CONFIG_PCIE_EDR))))
>>
>> i.e: Use DPC if we set the command line argument or use DPC if we are are using
>> EDR's _OSC DPC field, or use DPC if we have AER & there isn't EDR support?
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

