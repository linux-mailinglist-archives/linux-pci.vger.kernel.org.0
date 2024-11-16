Return-Path: <linux-pci+bounces-16966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654549CFED8
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B911F211AA
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2451A193419;
	Sat, 16 Nov 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MPc66hNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD3194A65;
	Sat, 16 Nov 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731761100; cv=none; b=WxQU99ehTRMxZu/r9M8cOBoI1aI8nFaEC3I1H1UR+VczSJwB55lHG8KC4SN7WVbF5rh8765aD5Vzm+DXD0YCILOzW3+AGFJsxNVFHvIiN22dQDAzxJu+sFrMrFLGy003Q9LtoqJKzH0vR+K/coGosiSEtFKrxGuLVf7ZeaTcRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731761100; c=relaxed/simple;
	bh=01R6kCl32Rbc6gmDjQT6oBUa9YpvvlmRpA5saXtpNKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EF+66FDKN5g5mBBkv2x8THqbdf7WY2/ODDToVyuXVJmbOK6rRwRpkX/aU+qD3k4bydo4IU75LGwOuFJwhuAdnnzxhOVxh39Uc5qQ55nRTVREoxn0zMmtVz9Mqi/JktZZ70/WULW4rMZcp7ki1M0qeY3F7NtmIY2c43avgbH8yqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MPc66hNV; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731761092; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vLuh1y2Va46zhl794h3M3rkZHy9DSRfMER9AY/fhJDQ=;
	b=MPc66hNV9TWD1uFbjGkertIrwu4ISCvg9krgHKfl1ieL6f2CFGNO/4nsYizrjar2eWzF6yQib1mYq0hv6twWAQIDwqXGO1MStPShk4IVvKEUtt8fLCBb8DeFfIe9/DoXU55hS9m6Hw40aub3EaQa7oULaz4QEybUY6zUuIr4a+U=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJWh6vw_1731761090 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 16 Nov 2024 20:44:51 +0800
Message-ID: <22d27575-fc68-4a7f-9bce-45b91c7dfb98@linux.alibaba.com>
Date: Sat, 16 Nov 2024 20:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org, Lukas Wunner <lukas@wunner.de>
Cc: mahesh@linux.ibm.com, oohall@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
 <20241112135419.59491-3-xueshuai@linux.alibaba.com>
 <a76394c4-8746-46c0-9cb5-bf0e2e0aa9b5@amd.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <a76394c4-8746-46c0-9cb5-bf0e2e0aa9b5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/16 04:20, Bowman, Terry 写道:
> Hi Shuai,
> 
> 
> On 11/12/2024 7:54 AM, Shuai Xue wrote:
>> The AER driver has historically avoided reading the configuration space of
>> an endpoint or RCiEP that reported a fatal error, considering the link to
>> that device unreliable. Consequently, when a fatal error occurs, the AER
>> and DPC drivers do not report specific error types, resulting in logs like:
>>
>>    pcieport 0000:30:03.0: EDR: EDR event received
>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>    nvme nvme0: frozen state error detected, reset controller
>>    nvme 0000:34:00.0: ready 0ms after DPC
>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>
>> AER status registers are sticky and Write-1-to-clear. If the link recovered
>> after hot reset, we can still safely access AER status of the error device.
>> In such case, report fatal errors which helps to figure out the error root
>> case.
>>
>> After this patch, the logs like:
>>
>>    pcieport 0000:30:03.0: EDR: EDR event received
>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>    nvme nvme0: frozen state error detected, reset controller
>>    pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
>>    nvme 0000:34:00.0: ready 0ms after DPC
>>    nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
>>    nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
>>    nvme 0000:34:00.0:    [ 4] DLP                    (First)
>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/pci/pci.h      |  3 ++-
>>   drivers/pci/pcie/aer.c | 11 +++++++----
>>   drivers/pci/pcie/dpc.c |  2 +-
>>   drivers/pci/pcie/err.c |  9 +++++++++
>>   4 files changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 0866f79aec54..6f827c313639 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -504,7 +504,8 @@ struct aer_err_info {
>>   	struct pcie_tlp_log tlp;	/* TLP Header */
>>   };
>>   
>> -int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>> +int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info,
>> +			      bool link_healthy);
>>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>>   #endif	/* CONFIG_PCIEAER */
>>   
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 13b8586924ea..97ec1c17b6f4 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1200,12 +1200,14 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
>>    * aer_get_device_error_info - read error status from dev and store it to info
>>    * @dev: pointer to the device expected to have a error record
>>    * @info: pointer to structure to store the error record
>> + * @link_healthy: link is healthy or not
>>    *
>>    * Return 1 on success, 0 on error.
>>    *
>>    * Note that @info is reused among all error devices. Clear fields properly.
>>    */
>> -int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>> +int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info,
>> +			      bool link_healthy)
>>   {
>>   	int type = pci_pcie_type(dev);
>>   	int aer = dev->aer_cap;
>> @@ -1229,7 +1231,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>   	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>   		   type == PCI_EXP_TYPE_RC_EC ||
>>   		   type == PCI_EXP_TYPE_DOWNSTREAM ||
>> -		   info->severity == AER_NONFATAL) {
>> +		   info->severity == AER_NONFATAL ||
>> +		   (info->severity == AER_FATAL && link_healthy)) {
>>   
>>   		/* Link is still healthy for IO reads */
>>   		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
>> @@ -1258,11 +1261,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>>   
>>   	/* Report all before handle them, not to lost records by reset etc. */
>>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>> -		if (aer_get_device_error_info(e_info->dev[i], e_info))
>> +		if (aer_get_device_error_info(e_info->dev[i], e_info, false))
>>   			aer_print_error(e_info->dev[i], e_info);
>>   	}
> 
> Would it be reasonable to detect if the link is intact and set the aer_get_device_error_info()
> function's 'link_healthy' parameter accordingly? I was thinking the port upstream capability
> link status register could be used to indicate the link viability.
> 
> Regards,
> Terry

Good idea. I think pciehp_check_link_active is a good implementation to check
link_healthy in aer_get_device_error_info().

   int pciehp_check_link_active(struct controller *ctrl)
   {
   	struct pci_dev *pdev = ctrl_dev(ctrl);
   	u16 lnk_status;
   	int ret;
   
   	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
   	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
   		return -ENODEV;
   
   	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
   	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
   
   	return ret;
   }

Thank you for valuable comments.

Best Regards
Shuai

