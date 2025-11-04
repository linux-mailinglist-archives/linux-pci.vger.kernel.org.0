Return-Path: <linux-pci+bounces-40186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FDFC2F6B8
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 07:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE0E189B98F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7C22652A2;
	Tue,  4 Nov 2025 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRpYpsdo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA0259C92;
	Tue,  4 Nov 2025 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762236846; cv=none; b=Y1G+hN7e5wOsDeBs1xDlCXE0Fk+4ztC1TuS0Oqna7UU0V947KfEhRXbflutO393e0I08XgaictUuqdA+IXBzG+JSzUZ7EmhuAcyX2Of4ytrMwyBJFGGa7mDqkIthRi+m3Ob0NIEFMkmPRfO0z0SZGmT3z0rW2RX8baUjs+kFV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762236846; c=relaxed/simple;
	bh=MTTJxnJOzAFblsCLCicYO+NoSmzettjWWeMThjL9T6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTghhehr6Se7aW/jzn9EIH6A1M3J28TDgW/0gPEKkSxPkV17iU9crhGyasyEDdd0YGcJUj7+OvlKszSRBpHNPfPSdWQsg9lZhdL4WDczlbwAXEi9YONPGTv3UHLdONGMRUZAMA+HpyV7Lkn4u6JgZ1pstr1vEsoxuigJ+8Bqy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRpYpsdo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762236844; x=1793772844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MTTJxnJOzAFblsCLCicYO+NoSmzettjWWeMThjL9T6w=;
  b=NRpYpsdowODnvZHtT09TzweFYpXhBCtlQ/SPbA14SGtSfo/r+vMHWT63
   coBXfAtxtSUBcksOJQdjrZcdhEe7r375MhPSe9hTPFZsK8U1FJDYXiyP4
   RBpr/wXDQDBxj2DTqP+bqgd/L7XxuorEfBRCdD3I1S1L4PXIYWGadYCCQ
   zLJYs0Qhav+oXKDt0wCoCqe7LYNrl4ffejN1siAFbkzG9DS4PwDMWcOri
   fLbLyK5iItCk/DohtYv68iRJx8haH+ZlpUnZPfMAnJzVD32532P8RMvs5
   ljOJzuL9bofi2qY58J6NOow37pmz1Se4OcmrnO3lN2zr/SKDHwBRisVpn
   w==;
X-CSE-ConnectionGUID: cJ/0REzpRYahiwBf8aV1jw==
X-CSE-MsgGUID: InWCLchNQJqR2ESQ2boCFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64421121"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="64421121"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 22:14:03 -0800
X-CSE-ConnectionGUID: vHqrMOK5Tv+sZl8YoBogqQ==
X-CSE-MsgGUID: ib5z9bsqQj6M6wDv4amMcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="224319107"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO [10.245.246.166]) ([10.245.246.166])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 22:13:59 -0800
Message-ID: <ac7202f4-e5c8-477b-b805-685f573d179a@linux.intel.com>
Date: Tue, 4 Nov 2025 08:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] PCI: Add Intel Nova Lake S audio Device ID
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kw@linux.com
References: <20251103173312.GA1811842@bhelgaas>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20251103173312.GA1811842@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/11/2025 19:33, Bjorn Helgaas wrote:
> On Mon, Nov 03, 2025 at 06:27:16PM +0200, Péter Ujfalusi wrote:
>> On 03/11/2025 18:02, Bjorn Helgaas wrote:
>>> On Mon, Nov 03, 2025 at 02:43:57PM +0200, Péter Ujfalusi wrote:
>>>> On 02/10/2025 11:42, Peter Ujfalusi wrote:
>>>>> Add Nova Lake S (NVL-S) audio Device ID
>>>>
>>>> Can you check this patch so Takashi-san can pick the series up?
>>>
>>> We have a long history of adding these Intel audio device IDs that are
>>> only used once, which is not our usual practice per the comment at the
>>> top of the file:
>>>
>>>  *      Do not add new entries to this file unless the definitions
>>>  *      are shared between multiple drivers.
>>>
>>> Generally speaking, if an ID is used by only a single driver, we
>>> either use the plain hex ID or add the #define to the driver that uses
>>> it.
>>
>> In this case the ID is used by two different driver stack, the
>> legacy HDA and SOF.
> 
> Sigh.  I looked through the patch series, searching for
> PCI_DEVICE_ID_INTEL_HDA_NVL_S, but of course there's only one instance
> of *that*, but two others constructed via PCI_DEVICE_DATA() where only
> "HDA_NVL_S" is mentioned.

I'm not sure if it would be better, but should we move the HDA PCI IDs
to an audio specific header?
Like include/sound/hda_pci_ids.h
It looks to me that mostly if not only these are Intel IDs.

Not in this series, but as a separate one.
> Can you include some hint about that in the commit log so I don't have
> to go through this whole exercise every time?  I want pci_ids.h
> changes to mention the multiple places a new ID is used so I know that
> the "multiple uses" rule has been observed.
> 
> With that:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you, I will send v2 with this update.>
>>> Have we been operating under some special exception for the Intel
>>> audio IDs?  I see that I acked some of these additions in the past,
>>> but I don't remember why.
>>
>> The HDA audio entries were moved here by v4 of this series:
>> https://www.spinics.net/lists/alsa-devel/msg161995.html
>>
>> (I cannot find link to v4, only this:
>> https://patchwork.ozlabs.org/project/linux-pci/list/?series=364212)
>>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>>>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>>>>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>>>>> ---
>>>>>  include/linux/pci_ids.h | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>>>> index 92ffc4373f6d..a9a089566b7c 100644
>>>>> --- a/include/linux/pci_ids.h
>>>>> +++ b/include/linux/pci_ids.h
>>>>> @@ -3075,6 +3075,7 @@
>>>>>  #define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
>>>>>  #define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
>>>>>  #define PCI_DEVICE_ID_INTEL_HDA_FCL	0x67a8
>>>>> +#define PCI_DEVICE_ID_INTEL_HDA_NVL_S	0x6e50
>>>>>  #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
>>>>>  #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
>>>>>  #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
>>>>
>>>>
>>
>> -- 
>> Péter
>>

-- 
Péter


