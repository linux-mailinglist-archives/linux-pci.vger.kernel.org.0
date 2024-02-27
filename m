Return-Path: <linux-pci+bounces-4079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C88689A6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC441C218EE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70553E2D;
	Tue, 27 Feb 2024 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5RWbdMm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8954746;
	Tue, 27 Feb 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017958; cv=none; b=hGEezwmqOPJaRfo2C1Qzb2xAoNXtzri3XntAUF6XTP87u8U1STY5IJJ9o0W9EkHKOgwJ2y/cvw99HIO3e9h9divWyueD1boSiWx9XEa/4OQMYrXX8Wn2IB8K0AZflApJmOqog8V6o5jrO2LCQKvaQDrlnJUrKBRlW3wD8YkF0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017958; c=relaxed/simple;
	bh=JYd1+gvQmxdWC7GENXNwKzhJ4WIfgamBg/U20rCMJ0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hI7QYvz4wE5CSmeJub7Ls+N1kT8/kbE8o56iOZYAW2wWTLcYUrCPIT0L0LYbsUVzZ2mDNHWc1kpoXUFvwPwbjU5Xsd2f6f9RcTZvQLZdILwHdiMs9vpsFaF5iEojZxojyeSLHbjVFc23AwmkKzIhyLA0FR0MKD9oZNoSZfFW+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5RWbdMm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709017957; x=1740553957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JYd1+gvQmxdWC7GENXNwKzhJ4WIfgamBg/U20rCMJ0E=;
  b=P5RWbdMmyl3hBhuFclX5fQ7mTNirGw3ViI3Y9TiTJPPw/BFQoPCoRRDe
   7sSHnDdvNJ0IjcGIWVyTvAUu7lKV9W9P2FYdwEwp+qec8mr7eIIz8aV8z
   G//DU2/+WSr1em/dn8Pfwfqr8j1ePAOADGyer7ldw0OQxPs1EadL7Z5aA
   7pY8xuh3z3FMunsomoaZfVwnBwzwtb2fwJKsDO1gHSCNMVAiiblMdIAkl
   htCPAMt21Y7ROPwgZMQ8eRZfz+0PjB8m91+m5yZylB/P+n7KQtV+8OdPX
   V5THV4vt3kulfuEoNu07zCcxQpDlI0B01hezoas0gx76w6r9wBNWGWkNs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3503098"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3503098"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6909305"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:12:33 -0800
Message-ID: <81f2dfa4-14c6-423c-96ee-b11b8a4670ed@linux.intel.com>
Date: Tue, 27 Feb 2024 15:12:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCI/DPC: Clean up DPC vs AER/EDR ownership and
 Kconfig
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew W Carlis <mattc@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240222221521.32159-1-helgaas@kernel.org>
 <89984f11-b84e-4da0-ab5b-f2048461aae0@linux.intel.com>
 <52245cb8-879e-4997-a1b5-cdfbd702dee7@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <52245cb8-879e-4997-a1b5-cdfbd702dee7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/2024 2:35 PM, Kuppuswamy Sathyanarayanan wrote:
> Hi,
>
> On 2/26/24 10:18 PM, Ethan Zhao wrote:
>> On 2/23/2024 6:15 AM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Previously we could request control of DPC without AER, which is illegal
>>> per spec.  Also, we could enable CONFIG_PCIE_DPC without CONFIG_PCIE_EDR,
>>> which is also illegal.  This series addresses both.
>> I have a question here, how to understand the relationship EDR & AER ?
>> somewhere EDR touches AER status without checking _OSC granted bits,
>> such as
>>     pci_aer_raw_clear_status(edev);
>
> Which_OSC bits?
>
> EDR code will only get triggered if OS advertises the EDR support (which
> also means OS supports AER and DPC), and both AER and DPC is owned by
> the firmware. During the EDR notification, the OS is allowed to touch AER

Means no need to check if host->native_aer ? why checked in
pcie_do_recovery() ?

Thanks,
Ethan

> and DPC registers. So there is no problem with EDR code using AER routines.
>
>
>> sometimes EDR calling AER with host->native_aer checked, like
>>
>> pcie_do_recovery()
>> {
>>   ...
>>   if (host->native_aer || pcie_ports_native) {
>>          pcie_clear_device_status(dev);
>>          pci_aer_clear_nonfatal_status(dev);
>>      }
>>   ...
>> }
>>
>> That is really confusing. could we do some cleanup to eliminate it ?
>> such as seperate AER code into common code and runtime part.
>>
>>
>> Thanks,
>> Ethan
>>   
>>
>>> Bjorn Helgaas (3):
>>>     PCI/DPC: Request DPC only if also requesting AER
>>>     PCI/DPC: Remove CONFIG_PCIE_EDR
>>>     PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
>>>
>>>    drivers/acpi/pci_root.c   | 22 ++++++++++++----------
>>>    drivers/pci/pci.h         |  4 ++++
>>>    drivers/pci/pcie/Kconfig  | 14 ++++----------
>>>    drivers/pci/pcie/Makefile |  5 ++++-
>>>    drivers/pci/pcie/dpc.c    | 10 ----------
>>>    include/linux/pci-acpi.h  |  8 --------
>>>    6 files changed, 24 insertions(+), 39 deletions(-)
>>>

