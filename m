Return-Path: <linux-pci+bounces-44122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7150CFAD70
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 20:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A11130161A1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732212D7DDE;
	Tue,  6 Jan 2026 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EetX678P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191339FCE;
	Tue,  6 Jan 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729274; cv=none; b=Fvsp6Sq9xjO+b8H7KRg8Pv+FzgZFgNLVN3L2nJ3WqbyTED+xPZEhu1sXa1GVfro2lJzvFuBgiZFelIGn65+xA0u7ZlyRk5h+chYip+B9A+BYL/1ZqHgIfJpVW9rViZlF0apVPFUyVJPJBGwQgD0bk8r/6hZm5uLoRk4niOQ7A7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729274; c=relaxed/simple;
	bh=+ehCdvM918DHgRZEhnTs3e5gEArOuQeQI7h/2OCzBTY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GJmw6rCm1pwwm+CSphpxPwkuLgqSg/x+i0UQC2xBer03I5mBn6zQDq9pxdy0WvpZV9Jn1ddXmGU4rRezuNqhSHBNkC9t1HB/AWL6KdPJeZ9R5i2DKgB8mt5gmaKJBxgrWC8M3n0ypYYRFaXn0PtNsVty1gIrQLCzDQlSWRIy5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EetX678P; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767729273; x=1799265273;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=+ehCdvM918DHgRZEhnTs3e5gEArOuQeQI7h/2OCzBTY=;
  b=EetX678PWIdRorgQUk8k5agQHz4YasNG6scIJCWW8MMKBY8BE9YQ0tHp
   Duki8U4SmOgY2pA+KsSguwln6HOISwGMjMp/bVJ1X0m2ipW+oSabkTYYf
   YoVV0Z7ROHI7dtIF5P7UZ76HnUGscdGL6YSFoQK6Yup3aC5hhr2psYsMB
   SMIW7eo0sI69B7XsWnNm/lVYcXHsnPP5R+NitAYVUnJZuFdkhborP7xEm
   cFMFRHd4citeDONcHMbOYUBGN8Klc534v4VpPx+rGmuG/EhLeFf/hNorz
   F1od+T9atW4e0mLGjOMviwdIumCTJ+qn+Jq3YR20wpSvLU/JFFky4Fsgg
   A==;
X-CSE-ConnectionGUID: 3XIkeYaMRcew2l6O1QAItg==
X-CSE-MsgGUID: kDiMwZtOTKuhkSUUofKtyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="79403561"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="79403561"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 11:54:32 -0800
X-CSE-ConnectionGUID: S+CYa0F6Q+qbFWQlBZEqEw==
X-CSE-MsgGUID: tuj79mnMR4iZmh2f/3OACA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="201957195"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 11:54:31 -0800
Message-ID: <749cf4e3-ce0d-4620-8c4f-dea1c9fb85e7@linux.intel.com>
Date: Tue, 6 Jan 2026 11:54:31 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Dave Jiang <dave.jiang@intel.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260106182025.1398-1-atharvatiwarilinuxdev@gmail.com>
 <e45f4544-7ff4-4e75-b8d0-3ec3480b1444@linux.intel.com>
Content-Language: en-US
In-Reply-To: <e45f4544-7ff4-4e75-b8d0-3ec3480b1444@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/6/2026 11:00 AM, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 1/6/2026 10:20 AM, Atharva Tiwari wrote:
>> Disable AER for Intel Titan Ridge 4C 2018
>> (used in T2 iMacs, where the warnings appear)
>> that generates continuous pcieport warnings. such as:
>>
>> pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
>> pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
>> pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
>> pcieport 0000:07:00.0:    [ 7] BadDLLP
>>
>> (see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)
>>
>> macOS also disables AER for Thunderbolt devices and controllers in their drivers.
>>
> 
> Why not disable it in BIOS or use noaer command line option?

As per the bugzilla report, this looks like a regression. Did you bisect
to find which commit introduced this warning?

Before disabling AER, please investigate the root cause:

Does this occur on all T2 iMacs or specific configurations?
Have you tested different PCIe link speeds?
Is this a cable/connection issue or firmware problem?

The device range (0x15EA-0x15EC) needs justification. Which specific
Titan Ridge variants have this issue?

Before fixing it, try to identify the root cause.

If it needs kernel fix, you need to use quirks (since BIOS
change does not work for you).

> 
>> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
>> ---
>>  drivers/pci/pcie/portdrv.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index 38a41ccf79b9..5330a679fcff 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -240,7 +240,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>>  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>>               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>>  	    dev->aer_cap && pci_aer_available() &&
>> -	    (pcie_ports_native || host->native_aer))
>> +	    (pcie_ports_native || host->native_aer) &&
>> +	    !(dev->vendor == PCI_VENDOR_ID_INTEL &&
>> +		    (dev->device >= 0x15EA && dev->device <= 0x15EC)))
>>  		services |= PCIE_PORT_SERVICE_AER;
>>  #endif
>>  
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


