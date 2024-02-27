Return-Path: <linux-pci+bounces-4078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC6786890F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37FC2842BE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DFE37145;
	Tue, 27 Feb 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5jqAP5L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851B2209D;
	Tue, 27 Feb 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015837; cv=none; b=mhPzwe+mJJIiBcxaV8xPi7q57lGwxLzhvhUvYroZ8gYks+xKkirIlFEPHiK8cNV1Kwe/Rc6pkQSUU+ILmXKKGH+7MvUrvyAxfYr/mh56GdtlUCMnOmLf+LYUGeo5W4Y76FcJFMPNZZfEyF93Y9mv9CBzm3pEjvsWhzfLPd+Vlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015837; c=relaxed/simple;
	bh=GgqC8yGFPkFK5zoal5SlVamupeuum7BGj7tEfPkQM/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLv19XfI8MZjxnwpF3FgLngdx4UgtlG/kD2TUrGBoPC7IRKbPj261t+YVyOJcZbd3GiiHJNhMAseKmVX0gjJB/YTDPsNoFyHDs+lyUX/Vb/ahhQ1ej7RLRdAHEFjNCz73Lfrw9KKBZbDp5NYKW3bYeAZxcLCN+rfbECJr3CoCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5jqAP5L; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709015836; x=1740551836;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GgqC8yGFPkFK5zoal5SlVamupeuum7BGj7tEfPkQM/I=;
  b=I5jqAP5LCHVnaM4OWZmpsZlsrx4y2f48uUFDRTE3gujq9zosKVKrYzW/
   6FQnGWRDySKwuhcLzlsAC6DOe2RgVEkRtV7MkYBYgoDGCSdm1Bc44peYb
   kGV7R/dt/P75Xn38Bft/V2Xn418Gwqpe2YC+4UQxeFZX0VnkQQk+fJRXv
   Rj7mLsSlR7GEhycANVRzEXD3f94s0MEBm9M3H90mC4rq1pnAcI44LyeYy
   da/a38g5fcctdDD3XUR5i2bstrkHe8usw/BBCXmq1HPpE1EGI8+ORwKXb
   9TTz0QtiQBH0/bwuB+kvs04QJxHhW+o46n7hDH1e6fRrRcPTTgkymWNv0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3499217"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3499217"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:35:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11666179"
Received: from tvereenx-mobl.amr.corp.intel.com (HELO [10.251.5.170]) ([10.251.5.170])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:35:24 -0800
Message-ID: <52245cb8-879e-4997-a1b5-cdfbd702dee7@linux.intel.com>
Date: Mon, 26 Feb 2024 22:35:22 -0800
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
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <89984f11-b84e-4da0-ab5b-f2048461aae0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/26/24 10:18 PM, Ethan Zhao wrote:
> On 2/23/2024 6:15 AM, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Previously we could request control of DPC without AER, which is illegal
>> per spec.  Also, we could enable CONFIG_PCIE_DPC without CONFIG_PCIE_EDR,
>> which is also illegal.  This series addresses both.
>
> I have a question here, how to understand the relationship EDR & AER ?
> somewhere EDR touches AER status without checking _OSC granted bits,
> such as
>    pci_aer_raw_clear_status(edev);


Which_OSC bits?

EDR code will only get triggered if OS advertises the EDR support (which
also means OS supports AER and DPC), and both AER and DPC is owned by
the firmware. During the EDR notification, the OS is allowed to touch AER
and DPC registers. So there is no problem with EDR code using AER routines.


>
> sometimes EDR calling AER with host->native_aer checked, like
>
> pcie_do_recovery()
> {
>  ...
>  if (host->native_aer || pcie_ports_native) {
>         pcie_clear_device_status(dev);
>         pci_aer_clear_nonfatal_status(dev);
>     }
>  ...
> }
>
> That is really confusing. could we do some cleanup to eliminate it ?
> such as seperate AER code into common code and runtime part.
>
>
> Thanks,
> Ethan
>  
>
>>
>> Bjorn Helgaas (3):
>>    PCI/DPC: Request DPC only if also requesting AER
>>    PCI/DPC: Remove CONFIG_PCIE_EDR
>>    PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
>>
>>   drivers/acpi/pci_root.c   | 22 ++++++++++++----------
>>   drivers/pci/pci.h         |  4 ++++
>>   drivers/pci/pcie/Kconfig  | 14 ++++----------
>>   drivers/pci/pcie/Makefile |  5 ++++-
>>   drivers/pci/pcie/dpc.c    | 10 ----------
>>   include/linux/pci-acpi.h  |  8 --------
>>   6 files changed, 24 insertions(+), 39 deletions(-)
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


