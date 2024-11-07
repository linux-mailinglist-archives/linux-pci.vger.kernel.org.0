Return-Path: <linux-pci+bounces-16190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2D59BFB58
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 02:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675D5B21EE3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916CC747F;
	Thu,  7 Nov 2024 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d1bQCfiy"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64704A33;
	Thu,  7 Nov 2024 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942669; cv=none; b=I9ApBOVL6X5jT7pK4CU6/ZYIsbAhQRxIi32cPez4azNbEZl8xOOOkvKIvvMfkHssAS+1yAqZu2/bTuv5OwZYAk6c+87IGagD82LizjE5wVDiQ5zpYEwlfCjbN1IrTftwjX/Ob1zkLJUwxmR4KpdAg5CpXeSYc3Eey3xjLALov1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942669; c=relaxed/simple;
	bh=htiHliatHTk2YE2/OnPKeoGnmqV4FdrX4L3DO6Hh9dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEkDLPaYkXVSit8CiFN/GfOsxlHtcYqgdjiIqk683bZYU3mV5fBWkqmgo7PuQN//wKdRisgh9/rtNlZMMCTEgRKthJWK4Qulz6fhjtBaS9qPnWfMzMq1+7xXJ31e7cgBVWDRTc8bBNQLT7kurKN/yGta3c7EHF8Jr++bFkJYUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d1bQCfiy; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730942663; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Itk8OfYSM9GTNcP70yeJZDtysL1LQL3shaXCUP4B5XU=;
	b=d1bQCfiyVl3p31zdd2Ub8h8zVCYDeRD2MZKoUDpz42SXI3tqDDZ6/avsfU2itJSpFS6qihwrIzKjBrUGR/ZLHfrzZ48+VY3gq17tKsISji0sCfGwCF3hR4wF31c253OaSRp4OaSMVQ0KJtKWl8NCa9rb5C6fI1STM4tXFlWAcTU=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIthmGp_1730942661 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 09:24:22 +0800
Message-ID: <3460223b-a57b-4ca4-9d34-2b520cfa1f42@linux.alibaba.com>
Date: Thu, 7 Nov 2024 09:24:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] PCI/AER: report fatal errors of RCiEP and EP
 if link recoverd
To: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20241106160238.GA1526691@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241106160238.GA1526691@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/7 00:02, Bjorn Helgaas 写道:
> On Wed, Nov 06, 2024 at 05:03:39PM +0800, Shuai Xue wrote:
>> The AER driver has historically avoided reading the configuration space of an
>> endpoint or RCiEP that reported a fatal error, considering the link to that
>> device unreliable. Consequently, when a fatal error occurs, the AER and DPC
>> drivers do not report specific error types, resulting in logs like:
>>
>> [  245.281980] pcieport 0000:30:03.0: EDR: EDR event received
>> [  245.287466] pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>> [  245.295372] pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>> [  245.300849] pcieport 0000:30:03.0: AER: broadcast error_detected message
>> [  245.307540] nvme nvme0: frozen state error detected, reset controller
>> [  245.722582] nvme 0000:34:00.0: ready 0ms after DPC
>> [  245.727365] pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>
>> But, if the link recovered after hot reset, we can safely access AER status of
>> the error device. In such case, report fatal error which helps to figure out the
>> error root case.
> 
> Explain why we can access these registers after reset.  I think it's
> important that these registers are sticky ("RW1CS" per spec).

Yes, AER error status registers are Sticky and Write-1-to-clear. If we 
does not read them after reset_subordinates, the registers will be 
cleared in pci_error_handlers, e.g. nvme_err_handler

   slot_reset() => nvme_slot_reset()
     pci_restore_state()
       pci_aer_clear_status()

Will add the reason in commit log.

> 
>> After this patch, the logs like:
>>
>> [  414.356755] pcieport 0000:30:03.0: EDR: EDR event received
>> [  414.362240] pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>> [  414.370148] pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>> [  414.375642] pcieport 0000:30:03.0: AER: broadcast error_detected message
>> [  414.382335] nvme nvme0: frozen state error detected, reset controller
>> [  414.645413] pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
>> [  414.788016] nvme 0000:34:00.0: ready 0ms after DPC
>> [  414.796975] nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
>> [  414.807312] nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
>> [  414.815305] nvme 0000:34:00.0:    [ 4] DLP                    (First)
>> [  414.821768] pcieport 0000:30:03.0: AER: broadcast slot_reset message
> 
> Capitalize subject lines to match history (use "git log --oneline
> drivers/pci/pcie/aer.c" to see it).
> 
> Remove timestamps since they don't help understand the problem.
> 
> Indent the quoted material two spaces.
> 
> Wrap commit log to fit in 75 columns (except the quoted material;
> don't insert line breaks there).

Will do.

> 
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/pci/pci.h      |  1 +
>>   drivers/pci/pcie/aer.c | 50 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pcie/err.c |  6 +++++
>>   3 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 0866f79aec54..143f960a813d 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -505,6 +505,7 @@ struct aer_err_info {
>>   };
>>   
>>   int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>> +int aer_get_device_fatal_error_info(struct pci_dev *dev, struct aer_err_info *info);
>>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>>   #endif	/* CONFIG_PCIEAER */
>>   
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 13b8586924ea..0c1e382ce117 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1252,6 +1252,56 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>   	return 1;
>>   }
>>   
>> +/**
>> + * aer_get_device_fatal_error_info - read fatal error status from EP or RCiEP
>> + * and store it to info
>> + * @dev: pointer to the device expected to have a error record
>> + * @info: pointer to structure to store the error record
>> + *
>> + * Return 1 on success, 0 on error.
> 
> Backwards from the usual return value convention.

Yes. As @Keith pointed, aer_get_device_fatal_error_info() is copied from 
  aer_get_device_error_info(), I will try to add a helper to reduce 
duplication.

> 
>> + * Note that @info is reused among all error devices. Clear fields properly.
>> + */
>> +int aer_get_device_fatal_error_info(struct pci_dev *dev, struct aer_err_info *info)
>> +{
>> +	int type = pci_pcie_type(dev);
>> +	int aer = dev->aer_cap;
>> +	u32 aercc;
>> +
>> +	pci_info(dev, "type :%d\n", type);
> 
> I don't see this line in the sample output in the commit log.  Is this
> debug that you intended to remove?


Sorry, I missed this line, will remove it.

> 
>> +	/* Must reset in this function */
>> +	info->status = 0;
>> +	info->tlp_header_valid = 0;
>> +	info->severity = AER_FATAL;
>> +
>> +	/* The device might not support AER */
> 
> Unnecessary comment.

Will remove it.

Thank you for valuable comments.

Best Regards,
Shuai



