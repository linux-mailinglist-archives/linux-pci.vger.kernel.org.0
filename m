Return-Path: <linux-pci+bounces-34143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C4B29408
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA42D16D51B
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83723875D;
	Sun, 17 Aug 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pv0bs+a7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E83176F5
	for <linux-pci@vger.kernel.org>; Sun, 17 Aug 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755447069; cv=none; b=ICwacu21RZU+ADfOxdqZ8boRb61hsNeRzA3T4pQEE0Xj8gCXFIaqcP7D3kau68lAeXQm1JeQedvSdRZb5PRoltmpNaZ77jzTn+VYntRGyeDxh6+n2ZTRp0xle3yqqQs2piYayX1Uid7LYBZinB7FZfYHsk31N53xxq2m8jm9oAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755447069; c=relaxed/simple;
	bh=apMkriidILsPEdSgGrXH1i3rii3g+uQH+fXccMC8Aio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSuMaq1//4nx693C4bqtZGdDu/+WzOwi83L7YrfS5DfEn+3UqAIC5F7WgAUYFGvyCEBDq7HPGra4vib0LqF0IjW9m+ZMIOcrU1vAjs1kV2+nJBKynyagsll+TQXvPSevF8WvxZPxfAQVKiNX0e2zHD/Y5HA6BygKY8nxf4qjm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pv0bs+a7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755447066; x=1786983066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=apMkriidILsPEdSgGrXH1i3rii3g+uQH+fXccMC8Aio=;
  b=Pv0bs+a7zAyWnZD2726q2UI/Dx55Flog6638mmROfFXjeh4xj1jn2o5l
   AQNu3t54H95p8IWecOLbGZVBgalxeV/g40OZCFq0wfo683druSv1/KSFr
   PTJugAeVqSDvgISgeQ5m3JudD+wY0Dj2SSWjeMlPxcN7Rwx/BH02cEKvK
   NJ5X82M3qtQtZhMj/rSiqXO5QKnn5lKDYP1bs5aHp5F8P2RpE/xh9TdqC
   LaVBdH91u+cZzgGyxBQMsayYk/dts2AfrU2vjelUiDlwVqv2FaM7Ck5m7
   ke/n39zAoViXOjxRaPkcNfIrvrzouxSfSDSV5zvtCaBOxMthgmJU61g5U
   A==;
X-CSE-ConnectionGUID: VZsPiRRxTyGm/yxEtrmsAg==
X-CSE-MsgGUID: ID5NOjNdShaGPCiDTw22Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57832455"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57832455"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 09:11:06 -0700
X-CSE-ConnectionGUID: uHSKJj/lR36Z2yr8ZKYuJg==
X-CSE-MsgGUID: MqeFIOlYR3eOQbIiNHsXIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171610974"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 09:11:05 -0700
Received: from [10.124.223.240] (unknown [10.124.223.240])
	by linux.intel.com (Postfix) with ESMTP id 2ADB120B571C;
	Sun, 17 Aug 2025 09:11:04 -0700 (PDT)
Message-ID: <cba69372-1ba1-4a9c-8aa1-5126314d6890@linux.intel.com>
Date: Sun, 17 Aug 2025 09:10:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] PCI/AER: Allow drivers to opt in to Bus Reset on
 Non-Fatal Errors
To: Lukas Wunner <lukas@wunner.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Riana Tauro <riana.tauro@intel.com>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 "Sean C. Dardis" <sean.c.dardis@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Linas Vepstas <linasvepstas@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
References: <cover.1755008151.git.lukas@wunner.de>
 <28fd805043bb57af390168d05abb30898cf4fc58.1755008151.git.lukas@wunner.de>
 <7c545fff40629b612267501c0c74bc40c3df29e2.camel@linux.ibm.com>
 <aJ2uE6v46Zib30Jh@wunner.de>
 <eec85830-e024-4801-bbc8-5cfa60048932@linux.intel.com>
 <aKHWf3L0NCl_CET5@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aKHWf3L0NCl_CET5@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/17/25 6:17 AM, Lukas Wunner wrote:
> On Thu, Aug 14, 2025 at 12:29:25PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 8/14/25 2:36 AM, Lukas Wunner wrote:
>>> On Thu, Aug 14, 2025 at 09:56:09AM +0200, Niklas Schnelle wrote:
>>>> On Wed, 2025-08-13 at 07:11 +0200, Lukas Wunner wrote:
>>>>> @@ -233,6 +228,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>>    		pci_walk_bridge(bridge, report_mmio_enabled, &status);
>>>>>    	}
>>>>> +	if (status == PCI_ERS_RESULT_NEED_RESET ||
>>>>> +	    state == pci_channel_io_frozen) {
>>>>> +		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
>>>>> +			pci_warn(bridge, "subordinate device reset failed\n");
>>>>> +			goto failed;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>>    	if (status == PCI_ERS_RESULT_NEED_RESET) {
>>>>>    		/*
>>>>>    		 * TODO: Should call platform-specific
>>>> I wonder if it might make sense to merge the reset into the above
>>>> existing if.
>>> There are drivers such as drivers/bus/mhi/host/pci_generic.c which
>>> return PCI_ERS_RESULT_RECOVERED from ->error_detected().  So they
>>> fall through directly to the ->resume() stage.  They're doing this
>>> even in the pci_channel_io_frozen case (i.e. for Fatal Errors).
>>>
>>> But for DPC we must call reset_subordinates() to bring the link back up.
>>> And for Fatal Errors, Documentation/PCI/pcieaer-howto.rst suggests that
>>> we must likewise call it because the link may be unreliable.
>> For fatal errors, since we already ignore the value returned by
>> ->error_detected() (by calling reset_subordinates() unconditionally), why
>> not update status accordingly in report_frozen_detected() and notify the
>> driver about the reset?
>>
>> That way, the reset logic could be unified under a single if
>> (status == PCI_ERS_RESULT_NEED_RESET) condition.
>>
>> Checking the drivers/bus/mhi/host/pci_generic.c implementation, it looks
>> like calling slot_reset callback looks harmless.
> Unfortunately it's not harmless:
>
> mhi_pci_slot_reset() calls pci_enable_device().  But a corresponding
> call to pci_disable_device() is only performed before in
> mhi_pci_error_detected() if that function returns
> PCI_ERS_RESULT_NEED_RESET.
>
> So there would be an enable_cnt imbalance if I'd change the logic to
> overwrite the driver's vote with PCI_ERS_RESULT_NEED_RESET in the
> pci_channel_io_frozen case and call its ->slot_reset() callback.
>
> The approach taken by this patch is to minimize risk, avoid any changes
> to drivers, make do with minimal changes to pcie_do_recovery() and
> limit the behavioral change.
>
> I think overriding status = PCI_ERS_RESULT_NEED_RESET and calling drivers'
> ->slot_reset() would have to be done in a separate patch on top and would
> require going through all drivers again to see which ones need to be
> amended.
>
> Also, note that report_frozen_detected() is too early to set
> "status = PCI_ERS_RESULT_NEED_RESET".  That needs to happen after the
> ->mmio_enabled() step, so that drivers get a chance to examine the
> device even in the pci_channel_io_frozen case before a reset is
> performed.  (The ->mmio_enabled() step is only performed if "status" is
> PCI_ERS_RESULT_CAN_RECOVER.)
>
> So then the code would look like this:
>
> 	if (state == pci_channel_io_frozen)
> 		status = PCI_ERS_RESULT_NEED_RESET;
>
> 	if (status == PCI_ERS_RESULT_NEED_RESET) {
> 		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
> 			pci_warn(bridge, "subordinate device reset failed\n");
> 			goto failed;
> 		}
>
> 		status = PCI_ERS_RESULT_RECOVERED;
> 		pci_dbg(bridge, "broadcast slot_reset message\n");
> 		pci_walk_bridge(bridge, report_slot_reset, &status);
> 	}
>
> ... which isn't very different from the present patch:
>
>          if (status == PCI_ERS_RESULT_NEED_RESET ||
>              state == pci_channel_io_frozen) {
>                  if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
>                          pci_warn(bridge, "subordinate device reset failed\n");
>                          goto failed;
>                  }
>          }
>
>          if (status == PCI_ERS_RESULT_NEED_RESET) {
>                  status = PCI_ERS_RESULT_RECOVERED;
>                  pci_dbg(bridge, "broadcast slot_reset message\n");
>                  pci_walk_bridge(bridge, report_slot_reset, &status);
>          }
>
> ... except that this patch avoids touching any drivers.


Makes sense. Thanks for the clarification.


>
> Thanks,
>
> Lukas
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


