Return-Path: <linux-pci+bounces-19633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC4A09490
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991EC3A6C51
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD420DD79;
	Fri, 10 Jan 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JFXUDb0T"
X-Original-To: linux-pci@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53176204C38;
	Fri, 10 Jan 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521363; cv=none; b=Epuqlq/2FWw9Bc5fepuR7F79Hne9N9sUUd8CbnzljW6oDk5Y9iDXNFVpjjljMaPOxOlyyMg3guoxCsX4ssI0/IFOpt+egfvLbb4VQgAFlLohgNvQNxIaKQKnokAYWpLptcfAArCc+nGHi6tFj7zCC+p9B1FRk5lU9l/GcULJ14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521363; c=relaxed/simple;
	bh=hbTLAwap1ERaUj61vRQjfmkIkdglH9vCpT3rmte63VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjXpNfITVTtQarlrwW/ZeTRT+hib53It9uOzsANLoDg9nRuo3ZWgjm6Tv4Jht09GFI87dHdq6Ye82HRDZsnZlDGcbesCJlquFpzm/zM7QQycwwHVHoS7kE+z2ySEeB+q15voxCPYAcFAdVHcxtHSx32iTR/hpJ7TB2SHTTeSZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JFXUDb0T; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736521012; bh=9cG6NxmaDJfrUJLD4LYO3WW0HhNZZL7z1s8zjnItsTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JFXUDb0TfkfE6tlaJBn33MD8jbob77Womn+MnYA3G/lR2zFBjafpKfMJtSGGpEXlm
	 DYvtHW8aZ9/tGSfW+f+DvkKVks2U7vRoSv34iD8Z1WgG6DwULNFkDNNXTeG9POsqY/
	 liH9owyoyMTS4tQ8ft4wELLRKJSv7zgSnJUmjqIQ=
Received: from [192.168.31.193] ([120.244.62.107])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id E31A24AD; Fri, 10 Jan 2025 22:56:49 +0800
X-QQ-mid: xmsmtpt1736521009tzqcsf8pm
Message-ID: <tencent_4C4084D8BFF745FD0B5FA028F820F4F50609@qq.com>
X-QQ-XMAILINFO: NV9lVvsB36OpCcUeJqb5PZj3j3BXx7aCcO4ZSoRT9oObZaasmz/TWJCTX5e5FP
	 G48klItuM//o0SQtl4GkP55BzaoxpP1dLHwoTec1cdGGNVgsoI6L36u8MyrTqcc8/vDQWXbYg6eX
	 SG5+klPUI6i02Hzx37QFSv+NjejfhVqQsfy3Z3EnwEMW7vOvMr/mwDC2HFEGZcxnS/bRHzmgwtH9
	 iqflFUEJXPzELziumtEMmjr2U0ah5zFO+OV2xts/IPOhSxF2sfjA/6bUEG+rpLQArLWfIoAKbtxX
	 SZN02LxVWYxwMYDeOuiweR9RdyPsNEWuk7xHHc6voFKshDrk4O0Ud4vSpT214h1bBTRJww5GBMiQ
	 YVu9Yem3ysMyt7tZUQZSQZSllj1weD9ZKN9jL4Hrra1OfEXFZ0EONlsQ3cafht6RSl9bfd1ze10E
	 5ZOGqTo43vLdjI3uo6Gl0sGosi/wS3Zcxc2pK9Jeytos3DZPlkZ4mwBqe1wuD5v05t6gMeTFhbAH
	 GPArAJF410m8x/UcMTNrd9MD0QQgnmcgpDRTcMHAheYwbWsHBIKG0DEuwHXX2kHOLi0N2BK92Er1
	 si+2m1CSGj+HxQ2bj4v35ftM+c9ZzSN8gum9WfIsLG5XobKs7h0Y+g6P9rC4e8ngUVE87slis/ho
	 2fVweQSvS1OTEAagAD0cx3YaBPvrFQ62KGwyCob6XjNZAxLeBQFOQmjImXSNvSyRNS5zL8V0xjKz
	 fGC7Ncl+zT9DfsQRCN6wSuh1YyCp5S4UqN+C+doU8g0g5nXJFfIbjak3M6rk9Sa7ghKfQkW+JD1c
	 y6xrUrzBs62epTbLlXlV1s1KDqvDU3LrDo1hBaOgMvW6YJ09tjBNIo1sbjFlfCVE77tvdtJn7hB3
	 R6Iq4ktaGtwRnKKJBZCDcyPU6Dyj5FNAavEf0rMh1catV5lQ1U1k6llc50u7NIoTzL/Fduw1QD6c
	 udbVXQNS8sP00ugUJe4EJJybHjMWZ7j8EsYOCYG0gCVTUCT+PTFxAPmWBjU0OQo5+rLtvW59QYoo
	 PBY2g50Ugi89Ckongi2iJiErBFH1V1yISdl/MhNg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <6613905d-aa40-4718-8786-5a94044ee487@qq.com>
Date: Fri, 10 Jan 2025 22:56:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: Fix the wrong reading of register fields
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 macro@orcam.me.uk
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, guojinhui.liam@bytedance.com,
 helgaas@kernel.org, Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com,
 sunjw10@lenovo.com
References: <tencent_753C9F9DFEC140A750F2778E6879E1049406@qq.com>
 <d3129f85-eeb4-021c-09d2-5877c9671a8d@linux.intel.com>
Content-Language: en-US
From: Jiwei <jiwei.sun.bj@qq.com>
In-Reply-To: <d3129f85-eeb4-021c-09d2-5877c9671a8d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/10/25 22:06, Ilpo Järvinen wrote:
> On Fri, 10 Jan 2025, Jiwei Sun wrote:
> 
>> From: Jiwei Sun <sunjw10@lenovo.com>
>>
>> Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
>> PCIe Link Speed"), there are two potential issues in the function
>> pcie_failed_link_retrain().
>>
>> (1) The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just
>> uses the link speed field of the registers. However, there are many other
>> different function fields in the Link Control 2 Register or the Link
>> Capabilities Register. If the register value is directly used by the two
>> macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).
>>
>> (2) In the pcie_failed_link_retrain(), the local variable lnkctl2 is not
>> changed after reading from PCI_EXP_LNKCTL2. It might cause that the
>> removing 2.5GT/s downstream link speed restriction codes are not executed.
> 
> Thanks for finding these issues and coming up with a patch.
> 
> These cases seem two different problems to me so I'd put them into
> different patches, which would also make it easeir focus on
> describing the issue in case 2 which is currently a bit vague (when
> looking how de9a6c8d5dbf managed to break it by removing the lnkctl2
> change prior to writing into the reg).

Thanks for your suggestion. I will divide them into different patches.

> 
>> In order to avoid the above-mentioned potential issues, only keep link
>> speed field of the two registers before using by pcie_set_target_speed()
>> and reread the Link Control 2 Register before using.
>>
>> Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
>> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
>> ---
>>   drivers/pci/quirks.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 76f4df75b08a..605628c810a5 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -118,11 +118,13 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>   		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
>>   		if (ret) {
>>   			pci_info(dev, "retraining failed\n");
>> +			oldlnkctl2 &= PCI_EXP_LNKCTL2_TLS;
>>   			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
>>   					      true);
> 
> I'd prefer these get fixed inside the macros so that the callers don't
> need to take handle what seem something that is always needed.


It is a good idea,  I will do that in the following patch.


Thanks,
Regards,
Jiwei

> 
>>   			return ret;
>>   		}
>>   
>> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>>   		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>>   	}
>>   
>> @@ -133,6 +135,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>   
>>   		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
>>   		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>> +		lnkcap &= PCI_EXP_LNKCAP_SLS;
>>   		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
> 


