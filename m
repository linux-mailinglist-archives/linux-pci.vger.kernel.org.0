Return-Path: <linux-pci+bounces-20266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08613A19EAB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A801624EA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 07:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F420B20A;
	Thu, 23 Jan 2025 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M7WjAk5j"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8B1C1F0C;
	Thu, 23 Jan 2025 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615798; cv=none; b=WOqEHcx2u+KlND7bTWPksgrLwlpBhtCS+gjI0EzmvR237deHSdnrys+9+5hQww8zFiD+xbQQg8CNBNizIoRIuS+qdL9mBzP3Y31GWnLAmF5/LEfxhsGDZ5xyr+/oCogYUdPsRM1E5dGHwoX1+gswrkwatQjMnt0rPk2Gg5UHBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615798; c=relaxed/simple;
	bh=8Dn29LZ9Oyr9Bztea4nHr1DZ24nI1+Mg4Ve3shUi25M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVZOhYjApZXcayx/PLkiglcdAsvjo5Zheb+ckRlpKryWdpvlNJBiGSrv0H1iLeHvADOA0j/rD9LZqdN3Y06CKUECujdmPvz90nMV9vFP0e2zJbSOCCY7x97/oTqRfVLqCj2SsCtJ4nXf+IN6GtkiUolfD+dUYKta3sw4ktmoK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M7WjAk5j; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737615786; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5C8aHaYEcDBY6Hou9Ze7bldqFBZdSLiEfzvyyxIGjzc=;
	b=M7WjAk5j6XUzdQ6PgukhQ6W6oLu+AgplZSA3OnubmuRVT49t0RPrV3SzH4SKGxsuITB04Qbl6lR3NKNrvshX92F3wHXEZIaBQ+cBXd4c8R52Qw4YMCa5tjUC161/eSFdsyuwLn+vk8nnKMAweqbkZYB/ko1iaW8+sYeXHOHGg2g=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WOAkbLF_1737615785 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 15:03:05 +0800
Message-ID: <3199a681-a31c-40c9-8a05-89cf38cd6eb8@linux.alibaba.com>
Date: Thu, 23 Jan 2025 15:03:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/DPC: Run recovery on device that detected the
 error
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
 <20241112135419.59491-2-xueshuai@linux.alibaba.com>
 <b109aca6-1eb2-43d2-b9c9-fb014d00bf7d@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <b109aca6-1eb2-43d2-b9c9-fb014d00bf7d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/23 12:53, Sathyanarayanan Kuppuswamy 写道:
> 
> On 11/12/24 5:54 AM, Shuai Xue wrote:
>> The current implementation of pcie_do_recovery() assumes that the
>> recovery process is executed on the device that detected the error.
>> However, the DPC driver currently passes the error port that experienced
>> the DPC event to pcie_do_recovery().
>>
>> Use the SOURCE ID register to correctly identify the device that detected the
>> error. By passing this error device to pcie_do_recovery(), subsequent
>> patches will be able to accurately access AER status of the error device.
> 
> When passing the error device, I assume pcie_do_recovery() will find the
> upstream bride and run the recovery logic .
> 

Yes, the pcie_do_recovery() will find the upstream bridge and walk bridges
potentially AER affected.

>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
> 
> IMO, moving the "err_port" rename to a separate patch will make this change
> more clear.  But it is up to you.

I see, I will add a separate patch.

> 
>>   drivers/pci/pci.h      |  2 +-
>>   drivers/pci/pcie/dpc.c | 30 ++++++++++++++++++++++++------
>>   drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
>>   3 files changed, 43 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 14d00ce45bfa..0866f79aec54 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -521,7 +521,7 @@ struct rcec_ea {
>>   void pci_save_dpc_state(struct pci_dev *dev);
>>   void pci_restore_dpc_state(struct pci_dev *dev);
>>   void pci_dpc_init(struct pci_dev *pdev);
>> -void dpc_process_error(struct pci_dev *pdev);
>> +struct pci_dev *dpc_process_error(struct pci_dev *pdev);
>>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>>   bool pci_dpc_recovered(struct pci_dev *pdev);
>>   #else
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 2b6ef7efa3c1..62a68cde4364 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -257,10 +257,17 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>>       return 1;
>>   }
>> -void dpc_process_error(struct pci_dev *pdev)
>> +/**
>> + * dpc_process_error - handle the DPC error status
> 
> Handling the DPC error status has nothing to do with finding
> the error source. Why not add a new helper function?

As PCIe Spec,

     DPC Error Source ID - When the DPC Trigger Reason field indicates that DPC
     was triggered due to the reception of an ERR_NONFATAL or ERR_FATAL, this
     register contains the Requester ID of the received Message. Otherwise, the
     value of this register is undefined.

To find the error source, we need to

   - check the error reason from PCI_EXP_DPC_STATUS,
   - Identify the error device by PCI_EXP_DPC_SOURCE_ID for ERR_NONFATAL and
     ERR_FATAL reason.

The code will duplicate with dpc_process_error. Therefore, I directly reused
dpc_process_error.

> 
>> + * @pdev: the port that experienced the containment event
>> + *
>> + * Return the device that experienced the error.
> detected the error?

Will change it.

>> + */
>> +struct pci_dev *dpc_process_error(struct pci_dev *pdev)
>>   {
>>       u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
>>       struct aer_err_info info;
>> +    struct pci_dev *err_dev = NULL;
> 
> I don't think you need NULL initialization here.

Will remove it.

> 
>>       pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>>       pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
>> @@ -283,6 +290,13 @@ void dpc_process_error(struct pci_dev *pdev)
>>            "software trigger" :
>>            "reserved error");
>> +    if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE ||
>> +        reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE)
>> +        err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
>> +                        PCI_BUS_NUM(source), source & 0xff);
>> +    else
>> +        err_dev = pci_dev_get(pdev);
>> +
>>       /* show RP PIO error detail information */
>>       if (pdev->dpc_rp_extensions &&
>>           reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT &&
>> @@ -295,6 +309,8 @@ void dpc_process_error(struct pci_dev *pdev)
>>           pci_aer_clear_nonfatal_status(pdev);
>>           pci_aer_clear_fatal_status(pdev);
>>       }
>> +
>> +    return err_dev;
>>   }
>>   static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>> @@ -350,21 +366,23 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>>   static irqreturn_t dpc_handler(int irq, void *context)
>>   {
>> -    struct pci_dev *pdev = context;
>> +    struct pci_dev *err_port = context, *err_dev = NULL;
> 
> NULL initialization is not needed.

Will remove it.

Thanks for valuable comments.

Best Regards,
Shuai

