Return-Path: <linux-pci+bounces-40126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E0DC2D232
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0E8188B7EF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B4031619B;
	Mon,  3 Nov 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiVIBWpk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7024C669;
	Mon,  3 Nov 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187231; cv=none; b=qwWB3X3tFSVLGKCK6IJ54QDO/48RKCXPiv4oL5N97j7Azwr+pIxWHu5XBkhqtc8yfdIjW5NIj8KFAjfg1ODsr4IftEYyUyvBm+VBAnAeyQFu21DusuY5n2/CJ3F1mYzTDj9O3JZ06roNMXDpmxuiAYqIGXwsn6nuHpJRGubBAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187231; c=relaxed/simple;
	bh=r5udqGJnIs75QfJoagt7ivSsh/QepXtOFVzwQXD+68o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D09BTPYyaBEK5a69Rkud1TpWru9nSopnbaxJ2dv/Wu26AuTysUdQhH5Um+QSlioydcfaEipr2FdkilEVkOA79fYVm0Mjb7rorZdcRnucw49BGtfqLlTbk7Ex7u4sdWklglwBh7euCEi1tAyI4g2CUVOzEhkHcmMysxiPjJD1rJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiVIBWpk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762187228; x=1793723228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r5udqGJnIs75QfJoagt7ivSsh/QepXtOFVzwQXD+68o=;
  b=iiVIBWpk08SjQlKNDOfPCzNTa3dlffusEloEJSJXKi6gY0XVU/4mt79u
   C9ZuZQJlt2P+jaq/o2rtL4TX3+Y/embYcLamD6Hs//OX7AJTeQqBwbMkB
   LEZ8Jmygrpl3XHd0QhEX4fV5+aXf1ut/n5qdVboaA3Uduu4h+ECAc6LJQ
   Pp4sxB65bYMHEk32J9C3grjUT9vnebeuBRZnMTORzyMAHuQYyeesiS1jB
   UrPDMWVBZJsVue8uNGXkOERRLvFvvXgz2Eh5me26lR38sPHzO4pmMWBEu
   BoHY9iKB3Q5k89l5RjEwq4NolIdRyS2/nPSesplUYrCGDzff/YQNVvWmU
   w==;
X-CSE-ConnectionGUID: TUQib+sbTViBp/4ctAkxfA==
X-CSE-MsgGUID: BWLiTLgERCKJxGL7OcUwSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="86891356"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="86891356"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 08:27:07 -0800
X-CSE-ConnectionGUID: tSELYBa6R+utBfspbjxVbw==
X-CSE-MsgGUID: XL6evxD/RE6mSx39dOyh/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186591798"
Received: from krybak-mobl1.ger.corp.intel.com (HELO [10.245.246.110]) ([10.245.246.110])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 08:27:03 -0800
Message-ID: <ef97aef3-e837-4c88-84e7-33afbc8ac150@linux.intel.com>
Date: Mon, 3 Nov 2025 18:27:16 +0200
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
References: <20251103160219.GA1806872@bhelgaas>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20251103160219.GA1806872@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/11/2025 18:02, Bjorn Helgaas wrote:
> On Mon, Nov 03, 2025 at 02:43:57PM +0200, Péter Ujfalusi wrote:
>> On 02/10/2025 11:42, Peter Ujfalusi wrote:
>>> Add Nova Lake S (NVL-S) audio Device ID
>>
>> Can you check this patch so Takashi-san can pick the series up?
> 
> We have a long history of adding these Intel audio device IDs that are
> only used once, which is not our usual practice per the comment at the
> top of the file:
> 
>  *      Do not add new entries to this file unless the definitions
>  *      are shared between multiple drivers.
> 
> Generally speaking, if an ID is used by only a single driver, we
> either use the plain hex ID or add the #define to the driver that uses
> it.

In this case the ID is used by two different driver stack, the legacy
HDA and SOF.
> Have we been operating under some special exception for the Intel
> audio IDs?  I see that I acked some of these additions in the past,
> but I don't remember why.

The HDA audio entries were moved here by v4 of this series:
https://www.spinics.net/lists/alsa-devel/msg161995.html

(I cannot find link to v4, only this:
https://patchwork.ozlabs.org/project/linux-pci/list/?series=364212)
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>>> ---
>>>  include/linux/pci_ids.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>> index 92ffc4373f6d..a9a089566b7c 100644
>>> --- a/include/linux/pci_ids.h
>>> +++ b/include/linux/pci_ids.h
>>> @@ -3075,6 +3075,7 @@
>>>  #define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
>>>  #define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
>>>  #define PCI_DEVICE_ID_INTEL_HDA_FCL	0x67a8
>>> +#define PCI_DEVICE_ID_INTEL_HDA_NVL_S	0x6e50
>>>  #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
>>>  #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
>>>  #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
>>
>>

-- 
Péter


