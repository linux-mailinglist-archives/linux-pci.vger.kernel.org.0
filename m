Return-Path: <linux-pci+bounces-37456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100ACBB4D85
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83577A6F3B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B68D274FDE;
	Thu,  2 Oct 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rb2pF6j+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057919D092;
	Thu,  2 Oct 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428638; cv=none; b=d/ALX/EWjjEvIOTHfXKjkaVX4b/rhZ4ncuFAYjuLJyvsG2A0crc8G4vnCJC0JN3EtCHRS8GognHlmFzQvi29R63Kh0DkX5Kc9z5/9Cl5jwlFD1GukM2N/1ROrGNQ2TrhBVbMh14EwfI9G6f420Gfus7n2orOzLPv4HiBunJ10Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428638; c=relaxed/simple;
	bh=O5wkUwnKgBzNkysEWRRXmGZptZAllZh7UoEkd0clsMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKtPiSgUj8zcQOvExRNQoqU3vSdniIVPni5ZjkRechslremAUClQ+LsPfSjbt5nnCFsYv6VxndP1KjuxptJPN0fKz5l3XK7h1tRR1IzgxuRSSKoUYOF5UtEPaipyOuT9Qx5EfCKUJx2wieIXWH2U6LcmOuMtw6euKRyJ9ktt5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rb2pF6j+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759428637; x=1790964637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O5wkUwnKgBzNkysEWRRXmGZptZAllZh7UoEkd0clsMk=;
  b=Rb2pF6j+o3I1wRWbRBubBFinjLabGqjdC1Cfl2jjIdRrwz1tAZQi56o0
   +t4GZ8y+yT358i4/D/L27tDzQreKGZWNZG57RBgHhMr4TlZXjdqjbG4zk
   BW6AyDBDeDmdGwTzk6enxtlCjMdv/jAcA83i+kvv9xsgBHetOhs1ZyX8v
   zygBqRRD2Nz+UFaCSXzqs3DR5GffwQqJYNSmwFQJcDNWVSwdPP6430CrH
   BmukVjc1qxv0Ueqe4kyXe7YivIyMZoiOnAYm3QyVbEhJBIKivkldZYbgK
   0tylx/DdYFI8vjLUAHU4Wf811XPJdIWJh12Zti57KtM4YrHDXjj4AMMx4
   A==;
X-CSE-ConnectionGUID: fwjC+wUmQ1GFaK7PZWlgSQ==
X-CSE-MsgGUID: EO0FG/QqRv2vk3smmdJbXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="84339496"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="84339496"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 11:10:36 -0700
X-CSE-ConnectionGUID: A7onqpwtRD2arq6ootLb8w==
X-CSE-MsgGUID: IW16ttgjTUiSWopAP8kd/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="184394495"
Received: from skuppusw-desk2.jf.intel.com (HELO [10.165.154.101]) ([10.165.154.101])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 11:10:34 -0700
Message-ID: <9c4e25e4-c6c7-4c56-ba0a-006b40e64d78@linux.intel.com>
Date: Thu, 2 Oct 2025 11:10:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Breno Leitao <leitao@debian.org>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jon Pan-Doh <pandoh@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
 <7b5c1235-df92-4f18-936c-3d7c0d3a6cb3@linux.intel.com>
 <a63012d4-0c98-4022-8183-5a3488ca66e9@csgroup.eu>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <a63012d4-0c98-4022-8183-5a3488ca66e9@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/2/25 03:06, Christophe Leroy wrote:
>
>
> Le 29/09/2025 à 17:10, Sathyanarayanan Kuppuswamy a écrit :
>>
>> On 9/29/25 2:15 AM, Breno Leitao wrote:
>>> Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
>>> when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
>>> calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
>>> does not rate limit, given this is fatal.
>>>
>>> This prevents a kernel crash triggered by dereferencing a NULL pointer
>>> in aer_ratelimit(), ensuring safer handling of PCI devices that lack
>>> AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
>>> which already performs this NULL check.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>> - This problem is still happening in upstream, and unfortunately no action
>>>    was done in the previous discussion.
>>> - Link to previous post:
>>>    https://eur01.safelinks.protection.outlook.com/? url=https%3A%2F%2Flore.kernel.org%2Fr%2F20250804-aer_crash_2-v1-1- fd06562c18a4%40debian.org&data=05%7C02%7Cchristophe.leroy2%40cs- soprasteria.com%7Cfd3d2f1b4e8448a8e67608ddff6a4e70%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638947554250805439%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=6yTN1%2Fq%2Fy0VKX%2BXpE%2BiKxBrn19AkY4IPj01N2ZdxEkg%3D&reserved=0
>>> ---
>>
>> Although we haven't identified the path that triggers this issue, adding this check is harmless.
>
> Is it really harmless ?
>
> The purpose of the function is to ratelimit logs. Here by returning 1 when dev->aer_info is NULL it says: don't ratelimit. Isn't it an opened door to Denial of Service by overloading with logs ?

We only skip rate limiting when dev->aer_info is NULL, which happens for
devices without AER capability. In that case, I think the trade-off is reasonable:
generating more logs is better than triggering a NULL pointer exception.

Also, this approach is consistent with other functions (for example, the stat
collection helpers) that already perform similar checks before accessing
aer_info. So extending the same safeguard here seems acceptable to me.

>
> Christophe
>
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>>
>>
>>>   drivers/pci/pcie/aer.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index e286c197d7167..55abc5e17b8b1 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>>>   static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
>>>   {
>>> +    if (!dev->aer_info)
>>> +        return 1;
>>> +
>>>       switch (severity) {
>>>       case AER_NONFATAL:
>>>           return __ratelimit(&dev->aer_info->nonfatal_ratelimit);
>>>
>>> ---
>>> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
>>> change-id: 20250801-aer_crash_2-b21cc2ef0d00
>>>
>>> Best regards,
>>> -- 
>>> Breno Leitao <leitao@debian.org>
>>>
>
>

