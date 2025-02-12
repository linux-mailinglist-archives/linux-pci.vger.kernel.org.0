Return-Path: <linux-pci+bounces-21277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80227A31E5A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 06:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1583A8566
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F71FAC57;
	Wed, 12 Feb 2025 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OLz/jlMq"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545EB2B9BC;
	Wed, 12 Feb 2025 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339826; cv=none; b=m1zo0sP/KKMw6Akqzrsj4ORCOummCsbvUC8YUfLUVaL9vVlW2ytdRytitdRe/MX9j6ZpUI1DmGh8aOkXhIgbgTL1q/ZfWXIAMf/kXAUKsCMq4Mb0br5ePers1WcJWqbw9FIRQ5bGXPGxBHCPnW2wTwjrM9OW8Y4FozXXv3I6gv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339826; c=relaxed/simple;
	bh=ZwCnMCj3UIdPDy3oeREeeSS2FtGVAdmTHB52TJ5R+MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rrxalabq5LmKpyk0ZliBeAc6emBwxoJfCmKK1C4wZRvSX/mhJuUgAm6uyarEbjtEr6fzYrOxNhKk/w4a5D4tlqinwEgXNKwtFlCuC4lHuyY7VKdekPUU6A6kCUSnD/qY41yPb5yyEr2DG3HEwJvpEJ1WqaXWNkHYXA/t+x8yUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OLz/jlMq; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739339821; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KvRmoe/zsC7m2wXD5OYDHglu/jPFjgfHTsdUpjdqzNE=;
	b=OLz/jlMqIuXSmsfprApWU42ES8U05RWJo2qJh2PThNoh5VdJBXjgsYup8zcYY8FF5g5+gGGRLAQTpEZpMVzti/sO4Pqi6NBacj6BGOVpCj56hdl4859tn6UPSVQ2huuukqfyR+2AWILVShauRHUa3sPWHQCiCVp+eO7uXou9sOA=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPIso2v_1739339502 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 13:51:42 +0800
Message-ID: <a89b973e-a168-49f1-8a82-2e9280cc08b6@linux.alibaba.com>
Date: Wed, 12 Feb 2025 13:51:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI/DPC: Run recovery on device that detected the
 error
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com
References: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
 <20250207093500.70885-4-xueshuai@linux.alibaba.com>
 <c1837324-98b0-4548-893f-b14e89ced9db@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <c1837324-98b0-4548-893f-b14e89ced9db@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/12 05:23, Sathyanarayanan Kuppuswamy 写道:
> 
> On 2/7/25 1:34 AM, Shuai Xue wrote:
>> The current implementation of pcie_do_recovery() assumes that the
>> recovery process is executed on the device that detected the error.
>> However, the DPC driver currently passes the error port that experienced
>> the DPC event to pcie_do_recovery().
>>
>> Use the SOURCE ID register to correctly identify the device that detected the
>> error. By passing this error device to pcie_do_recovery(), subsequent
>> patches will be able to accurately access AER status of the error device.
> 
> I also recommend adding info about the fact that pcie_do_recovery() finds
> upstream bridge to run the recovery process and hence should not observe
> any functional changes (compared to previous version)

Got it.  Will add it.
> 
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/pci/pci.h      |  2 +-
>>   drivers/pci/pcie/dpc.c | 25 +++++++++++++++++++++----
>>   drivers/pci/pcie/edr.c |  7 ++++---
>>   3 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 01e51db8d285..870d2fbd6ff2 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -572,7 +572,7 @@ struct rcec_ea {
>>   void pci_save_dpc_state(struct pci_dev *dev);
>>   void pci_restore_dpc_state(struct pci_dev *dev);
>>   void pci_dpc_init(struct pci_dev *pdev);
>> -void dpc_process_error(struct pci_dev *pdev);
>> +struct pci_dev *dpc_process_error(struct pci_dev *pdev);
>>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>>   bool pci_dpc_recovered(struct pci_dev *pdev);
>>   unsigned int dpc_tlp_log_len(struct pci_dev *dev);
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 1a54a0b657ae..a91440f3b118 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -253,10 +253,17 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>>       return 1;
>>   }
>> -void dpc_process_error(struct pci_dev *pdev)
>> +/**
>> + * dpc_process_error - handle the DPC error status
>> + * @pdev: the port that experienced the containment event
>> + *
>> + * Return the device that detected the error.
>> + */
> 
> Add a note about calling pci_dev_put() after using this function.

Will add it in next version.

Thanks.
Shuai



