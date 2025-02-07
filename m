Return-Path: <linux-pci+bounces-20856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF705A2BA3C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 05:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78743A8539
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 04:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B36023315C;
	Fri,  7 Feb 2025 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLc9Q8XW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064B23314C;
	Fri,  7 Feb 2025 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902398; cv=none; b=hIPnKEpxGpX4XeaXrtOineST+SgpoTnvsygdluFkBdrF5poGUME6a2rMlpx7QLB7SJv+rHdPOZy5i9rhyj/1z9lflO0HkyWVA/F0va2zjpOwj3vxuNBareClfxofosSTkOuYcEh+vPVJYJZFRJUwEFuSlQqQyy9+N3/dwLFZWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902398; c=relaxed/simple;
	bh=bvUTrvucvs5c6M56j9ZGAdxIOpEL2m1FSJrsxdyZvQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwjvBQVKgeeT5m8Vi/Gc7+95Z/TWgp4Wnsy/USDQSSxzw4RdQLp1zDDQYDwnSbX76zZ4DrGILeMiTOYsqvU+l0oRYETDX5xMdK8Ey9Y3xxheQU6LGf2kvNJSO4mAN0GXTO8v2cXp55g970Umokppk7VOIKpPX2air8ydWe0Hidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLc9Q8XW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738902397; x=1770438397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bvUTrvucvs5c6M56j9ZGAdxIOpEL2m1FSJrsxdyZvQY=;
  b=aLc9Q8XW750LWM8YEyNoLaGEw+JquPXHN/FgYTT1kdDx69uOw4KHPWUE
   c2/Ucw9q9VBY/3IWcawR+dMpWiDhDsZAqbIY2i9Jt9gy5o1nCWNZB4mVT
   8ndJ0xN4BLS+HwGDA0WL9AcYnbx0MI4k1ksSL7s2EAF82Y7+jJh5d9K+2
   54Q9BQamShAyuJ0T9hW5ZWXXDlCeXC3fNTXR0GFsbCeg3yaR6JVVwPlyT
   EXf43rEbhCWltDYsmcti3T7XDQn3x9bTwrHXULjtAC1SUZUgV0lzKi4CP
   kjwBJ3icFzLD8eSvFFMyyrtDK1zU805HrLTaYZoJ+Y1SKP07zZ1r8Slaa
   Q==;
X-CSE-ConnectionGUID: ZnWcwr34T4y9hzCzCRyVEw==
X-CSE-MsgGUID: FM3HTGU+Tdyuqh+WkSm/EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64890418"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="64890418"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 20:26:36 -0800
X-CSE-ConnectionGUID: mVrsykd+TE+M291dW6o8BA==
X-CSE-MsgGUID: ImXfyL7TT7ORswdEbiQVRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111271026"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO [10.124.220.221]) ([10.124.220.221])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 20:26:34 -0800
Message-ID: <11a01c9b-5e52-46b8-ab13-e68ae79083ff@linux.intel.com>
Date: Thu, 6 Feb 2025 20:26:13 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling
 hotplug events
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <Jonthan.Cameron@huawei.com>,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <7e5e9bad-b66b-4a7f-8868-af5f1ab2fda1@linux.intel.com>
 <Z6QqGRNQ0UQZSKBB@U-2FWC9VHC-2323.local>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Z6QqGRNQ0UQZSKBB@U-2FWC9VHC-2323.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/5/25 7:18 PM, Feng Tang wrote:
> Hi Sathyanarayanan,
>
> On Wed, Feb 05, 2025 at 10:26:59AM -0800, Sathyanarayanan Kuppuswamy wrote:
>> On 2/3/25 9:37 PM, Feng Tang wrote:
>>> According to PCIe 6.1 spec, section 6.7.3.2, software need to wait at
>>> least 1 second for the command-complete event, before resending the cmd
>>> or sending a new cmd.
>>>
>>> Currently get_port_device_capability() sends slot control cmd to disable
>>> PCIe hotplug interrupts without waiting for its completion and there was
>>> real problem reported for the lack of waiting.
>> Can you include the error log associated with this issue? What is the
>> actual issue you are seeing and in which hardware?
> For this one, we don't have specific log, as it was raised by firmware
> developer, as in https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/
>
> When handling PCI hotplug problem, they hit issue and found their state
> machine corrupted , and back traced to OS. They didn't expect to receive
> 2 link control commands at almost the same time, which doesn't comply to

Which 2 commands from OS? Did you identify both commands?

> pcie spec, and normally the handling of one command will take some time
> in BIOS, though not as long as 1 second. The HW is an ARM server.
>
> I will try to add these info to commit log in next version.

Ok. Please include it.

>
>>> Add the necessary wait to comply with PCIe spec. The waiting logic refers
>>> existing pcie_poll_cmd().
>>>
>>> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
>>> ---
>>>    drivers/pci/pci.h          |  2 ++
>>>    drivers/pci/pcie/portdrv.c | 33 +++++++++++++++++++++++++++++++--
>>>    2 files changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 01e51db8d285..c1e234d1b81d 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -759,12 +759,14 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>>>    #ifdef CONFIG_PCIEPORTBUS
>>>    void pcie_reset_lbms_count(struct pci_dev *port);
>>>    int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
>>> +void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
>>>    #else
>>>    static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
>>>    static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
>>>    {
>>>    	return -EOPNOTSUPP;
>>>    }
>>> +static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
>>>    #endif
>>>    struct pci_dev_reset_methods {
>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>> index 02e73099bad0..16010973bfe2 100644
>>> --- a/drivers/pci/pcie/portdrv.c
>>> +++ b/drivers/pci/pcie/portdrv.c
>>> @@ -18,6 +18,7 @@
>>>    #include <linux/string.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/aer.h>
>>> +#include <linux/delay.h>
>>>    #include "../pci.h"
>>>    #include "portdrv.h"
>>> @@ -205,6 +206,35 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>>>    	return 0;
>>>    }
>>> +static int pcie_wait_sltctl_cmd_raw(struct pci_dev *pdev)
>>> +{
>>> +	u16 slot_status;
>>> +	/* 1000 ms, according toPCIe spec 6.1, section 6.7.3.2 */
>>> +	int timeout = 1000;
>>> +
>>> +	do {
>>> +		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>>> +		if (slot_status & PCI_EXP_SLTSTA_CC) {
>>> +			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>>> +						   PCI_EXP_SLTSTA_CC);
>>> +			return 0;
>>> +		}
>>> +		msleep(10);
>>> +		timeout -= 10;
>>> +	} while (timeout);
>>> +
>>> +	/* Timeout */
>>> +	return  -1;
>>> +}
>> May be this logic can be simplified using readl_poll_timeout()?
> Seems this is what exactly I needed :) Many thanks for the suggestion!
>
> - Feng

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


