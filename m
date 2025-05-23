Return-Path: <linux-pci+bounces-28353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C61AC2A83
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E323ABE2D
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8229551B;
	Fri, 23 May 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="UkZ97WFF"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226A1B4241;
	Fri, 23 May 2025 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029235; cv=none; b=tW73MEMQ4GjIn8RYx/KYehnGgW+wdtnZbVxdPH3RDJHxOf9n72mHcAbUgmQJaADZztZGhYPyctHaeLBMvOCuEag5GzhcumefaGvdF8Rz7M5KuaemzY1B0nUJD2AgW9aVWM0445eMaPKUkEFSG8YinNI4FHKhK0cRO0YJOvGakzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029235; c=relaxed/simple;
	bh=n3Sy0eg2ohtMgO9kJp2IH3bGKvErpWrOqCVwYxjs+MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUiVPTnD8c+Yee6ZBQYgXGGkwRE5GX4Gqpf9lQUp0MqDpGNMj9fCCU8uV2NKfzB6BRxa5Zcux5EE5ta03m+AHd6MMD60y7etwPQ3poo1N8U3UT65V8CMHvCwvw/FMGEkWMadk62zRS6NxBtmL9MUqL7kJAbzG6iGJ58XsQqFg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=UkZ97WFF; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4b3w555BQ9zDQ4;
	Fri, 23 May 2025 15:21:45 -0400 (EDT)
Received: from [10.50.4.32] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4b3w4w2kV1z4Ygl;
	Fri, 23 May 2025 15:21:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1748028097; bh=n3Sy0eg2ohtMgO9kJp2IH3bGKvErpWrOqCVwYxjs+MY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UkZ97WFFTXOp8NRJSfjbxjnR5M3exAOsIQAv3HePEZk8hhagZZsK8l9sWPBsHd+AO
	 2xKPPkJtaPUCeKEHvGlJSoE66Mlsd4+hi9yr94VLbIKmm0lV5kFJCCB6eyCsdnK2cD
	 5SA6bGhHSqDVTttuHqewvOvCnOT5pYA3UpVIdUPc=
Message-ID: <b52a2045-0b26-4287-80a4-e1b571d76a26@panix.com>
Date: Fri, 23 May 2025 12:21:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raphael, I'd like your help upstreaming this VMD power-saving
 patch, please
To: Russell Haley <yumpusamongus@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Vidya Sagar
 <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pci@vger.kernel.org,
 Sergey Dolgov <sergey.v.dolgov@gmail.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Jian-Hong Pan <jhp@endlessos.org>, "David E. Box"
 <david.e.box@linux.intel.com>
References: <20250512210938.GA1128238@bhelgaas>
 <7aedd720-c29a-4225-a79a-d44a3a9ca129@gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <7aedd720-c29a-4225-a79a-d44a3a9ca129@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Raphael, any input?

Thanks,

-Kenny

On 5/14/25 18:23, Russell Haley wrote:
> 
> 
> On 5/12/25 4:09 PM, Bjorn Helgaas wrote:
> 
>>>   static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>>   {
>>>   	struct pci_dev *child = link->downstream, *parent = link->pdev;
>>> @@ -866,7 +891,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>>   	}
>>>   
>>>   	/* Save default state */
>>> -	link->aspm_default = link->aspm_enabled;
>>> +	link->aspm_default = pci_fixup_vmd_bridge_enable_aspm(parent) ?
>>> +		PCIE_LINK_STATE_ASPM_ALL : link->aspm_enabled;
>>
>> PCIE_LINK_STATE_ASPM_ALL includes PCIE_LINK_STATE_L1_2, so I think
>> this potentially enables L1.2.  The L1.2 configuration depends on
>> T_POWER_ON and Common_Mode_Restore_Time, which depend on electrical
>> design and are not discoverable by the kernel.  See PCIe r6.0, sec
>> 5.5.4:
>>
>>    The TPOWER_ON and Common_Mode_Restore_Time fields must be programmed
>>    to the appropriate values based on the components and AC coupling
>>    capacitors used in the connection linking the two components. The
>>    determination of these values is design implementation specific.
> 
> Does that apply to VMD?  As far as I know it's not an actual physical
> PCIe device.
> 
> - Russell
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


