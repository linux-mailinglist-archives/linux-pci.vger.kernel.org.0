Return-Path: <linux-pci+bounces-30158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18DFADFDA4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 08:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400E817AA0D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30F2441AF;
	Thu, 19 Jun 2025 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="akQgVD+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6F1DDC3F;
	Thu, 19 Jun 2025 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750314541; cv=none; b=L5rAW0LcohT99U/k9Jzjhb0K64B/wJ98qzi+9bBngBpTVCiMn4uPf02S+snnKkNEH8iDA2IbUGzva1qVqUF/j5K0HmwTRb71XKyb1MKdW6iSw0AMIetAZzbBWZ1KdYdbuw/RNWKg6bbmct1fwOCzIgXCu9zWRIGCA6AV9r+yB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750314541; c=relaxed/simple;
	bh=7x6vTDxNZJIlw4uZfProIXl4+73k/I9mxR6rz0uW+Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/xlLJyDBS9td1cscOA8nyC19nSzvdchdRVBX16i1usH0Tqmnnqiu9h5ECWXlpYyLhTfi0uQpVHFHrg8OUgkfJ6iSTLKeTMICje2EcBDolDPAWdQJ6ZQ6066voFzfc9RC5bFHemOA7xsn46lui3bhCJUxPOwTCiY61HkMtI4z1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=akQgVD+3; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750314529; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LrUxquuV08mTQNkniPuw6NWVbLTKkOod1+c0DYOXFIE=;
	b=akQgVD+3vFY4xsF3AIruwr+3njYuefXkTN4X67ucP03r1/uApETHb1k58LcuNg9a2bL/pN/Fu0xvMn5YBUeG38oYV1E1RLK/ZzWWw+lhm95OP0gzg6HmqnwO2QNMlIjfTVudNNI5UWsZLH+pOJCDFODm8ReaugHlxj1+DfB6YAA=
Received: from 30.221.131.111(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WeGLlC3_1750314527 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Jun 2025 14:28:48 +0800
Message-ID: <7d8bd8d5-63bc-4a52-afa1-b6e3738a188e@linux.alibaba.com>
Date: Thu, 19 Jun 2025 14:28:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI/DPC: Run recovery on device that detected the
 error
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
 <20250217024218.1681-3-xueshuai@linux.alibaba.com>
 <qqixmrgqnba6hlt4fritlknfnbe6zm63qgxhoep4oriinbozyt@f6tzmjpyaf6d>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <qqixmrgqnba6hlt4fritlknfnbe6zm63qgxhoep4oriinbozyt@f6tzmjpyaf6d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/12 18:31, Manivannan Sadhasivam 写道:
> On Mon, Feb 17, 2025 at 10:42:17AM +0800, Shuai Xue wrote:
>> The current implementation of pcie_do_recovery() assumes that the
>> recovery process is executed on the device that detected the error.
> 
> s/on/for
> 
>> However, the DPC driver currently passes the error port that experienced
>> the DPC event to pcie_do_recovery().
>>
>> Use the SOURCE ID register to correctly identify the device that
>> detected the error. When passing the error device, the
>> pcie_do_recovery() will find the upstream bridge and walk bridges
>> potentially AER affected. And subsequent patches will be able to
> 
> s/patches/commits

Will fix the typos.
> 
>> accurately access AER status of the error device.
>>
>> Should not observe any functional changes.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/pci/pci.h      |  2 +-
>>   drivers/pci/pcie/dpc.c | 28 ++++++++++++++++++++++++----
>>   drivers/pci/pcie/edr.c |  7 ++++---
>>   3 files changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 01e51db8d285..870d2fbd6ff2 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -572,7 +572,7 @@ struct rcec_ea {
>>   void pci_save_dpc_state(struct pci_dev *dev);
>>   void pci_restore_dpc_state(struct pci_dev *dev);
>>   void pci_dpc_init(struct pci_dev *pdev);
>> -void dpc_process_error(struct pci_dev *pdev);
>> +struct pci_dev *dpc_process_error(struct pci_dev *pdev);
>>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>>   bool pci_dpc_recovered(struct pci_dev *pdev);
>>   unsigned int dpc_tlp_log_len(struct pci_dev *dev);
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 1a54a0b657ae..ea3ea989afa7 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -253,10 +253,20 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>>   	return 1;
>>   }
>>   
>> -void dpc_process_error(struct pci_dev *pdev)
>> +/**
>> + * dpc_process_error - handle the DPC error status
>> + * @pdev: the port that experienced the containment event
>> + *
>> + * Return the device that detected the error.
> 
> s/Return/Return:
> 
>> + *
>> + * NOTE: The device reference count is increased, the caller must decrement
>> + * the reference count by calling pci_dev_put().
>> + */
>> +struct pci_dev *dpc_process_error(struct pci_dev *pdev)
>>   {
>>   	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
>>   	struct aer_err_info info;
>> +	struct pci_dev *err_dev;
>>   
>>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
>> @@ -279,6 +289,13 @@ void dpc_process_error(struct pci_dev *pdev)
>>   		 "software trigger" :
>>   		 "reserved error");
>>   
>> +	if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE ||
>> +	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE)
>> +		err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
>> +					    PCI_BUS_NUM(source), source & 0xff);
>> +	else
>> +		err_dev = pci_dev_get(pdev);
>> +
>>   	/* show RP PIO error detail information */
>>   	if (pdev->dpc_rp_extensions &&
>>   	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT &&
>> @@ -291,6 +308,8 @@ void dpc_process_error(struct pci_dev *pdev)
>>   		pci_aer_clear_nonfatal_status(pdev);
>>   		pci_aer_clear_fatal_status(pdev);
>>   	}
>> +
>> +	return err_dev;
>>   }
>>   
>>   static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>> @@ -346,7 +365,7 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>>   
>>   static irqreturn_t dpc_handler(int irq, void *context)
>>   {
>> -	struct pci_dev *err_port = context;
>> +	struct pci_dev *err_port = context, *err_dev;
>>   
>>   	/*
>>   	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
>> @@ -357,10 +376,11 @@ static irqreturn_t dpc_handler(int irq, void *context)
>>   		return IRQ_HANDLED;
>>   	}
>>   
>> -	dpc_process_error(err_port);
>> +	err_dev = dpc_process_error(err_port);
>>   
>>   	/* We configure DPC so it only triggers on ERR_FATAL */
>> -	pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
>> +	pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
>> +	pci_dev_put(err_dev);
>>   
>>   	return IRQ_HANDLED;
>>   }
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index 521fca2f40cb..088f3e188f54 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -150,7 +150,7 @@ static int acpi_send_edr_status(struct pci_dev *pdev, struct pci_dev *edev,
>>   
>>   static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>   {
>> -	struct pci_dev *pdev = data, *err_port;
>> +	struct pci_dev *pdev = data, *err_port, *err_dev;
>>   	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
>>   	u16 status;
>>   
>> @@ -190,7 +190,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>   		goto send_ost;
>>   	}
>>   
>> -	dpc_process_error(err_port);
>> +	err_dev = dpc_process_error(err_port);
>>   	pci_aer_raw_clear_status(err_port);
>>   
>>   	/*
>> @@ -198,7 +198,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>   	 * or ERR_NONFATAL, since the link is already down, use the FATAL
>>   	 * error recovery path for both cases.
>>   	 */
>> -	estate = pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
>> +	estate = pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
>>   
>>   send_ost:
>>   
>> @@ -216,6 +216,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>   	}
>>   
>>   	pci_dev_put(err_port);
>> +	pci_dev_put(err_dev);
> 
> err_dev is not a valid pointer before calling dpc_process_error(). So either
> initialize it with NULL or only call it in error paths after
> dpc_process_error().
> 
> And btw, pci_dev_put(err_dev) should come before pci_dev_put(err_port).
> 
> - Mani
> 

You are right.

Will send a new patch to fix it.

Thanks.
Shuai

