Return-Path: <linux-pci+bounces-16191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0B9BFB70
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 02:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932F8282F34
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA17485;
	Thu,  7 Nov 2024 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E5mgeaAQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6BBE4A;
	Thu,  7 Nov 2024 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942829; cv=none; b=GaP4R5Uoxa+GsUpIsOfTTEM6/zEK+IeuCY/mherAEXvttnTO3qsOyIa2Od5cKbyP6RKVfPuh0CrDlxd1GgR49y9iw7umLyGHR5lKan2KWQA3/4wqYiCXSrUh4PtTkYRF7V4VBaMWkntECtu2fIV0VecbngCK/MSs8s+UZOOMzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942829; c=relaxed/simple;
	bh=Lp5OTyWSzwrB7KaLwAMLtFxSqxfxPnlOsTHpKaatHEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjJovtWLxcb3Wx++fOa0WPlAGd+Rs++Rk0pL+DsCiWDZMHCbopN7geXqM06pyBnh1UyIywEgrYlt4LK3UPAXjGOrWqrecIETxdfDoayeaSvjUYQJxjNSKwKvIaYWM/jM1MAkQ3QB4uHjnXShJolcPxVbd3CdXe31Wt86Wa32rRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E5mgeaAQ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730942824; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7QNN7aZqhxMw37PStTVFSWANIXY78tjXFWsam9auhZE=;
	b=E5mgeaAQ1rBHQ7Ydndwz0qmtuqvR919vzdPyh5OwYpYHIGyFK51YEHhSh6XZ7qPDpvJWfag+Exlv2iOgvt4/5/gcUJ3nurOCb6RnV+Z2s0PFKTPG7oSBr3KqNZwbjDHXwjlzPKhsGmDCL5fQvfsTUaWtjQbx7c5AvbkBJacbG2k=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIthnFt_1730942823 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 09:27:04 +0800
Message-ID: <736d94be-fad9-445e-acce-81cae1a05d46@linux.alibaba.com>
Date: Thu, 7 Nov 2024 09:27:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] PCI/AER: report fatal errors of RCiEP and EP
 if link recoverd
To: Keith Busch <kbusch@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20241106090339.24920-1-xueshuai@linux.alibaba.com>
 <20241106090339.24920-3-xueshuai@linux.alibaba.com>
 <ZyubxGBL7TvchZI_@kbusch-mbp>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ZyubxGBL7TvchZI_@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/7 00:39, Keith Busch 写道:
> On Wed, Nov 06, 2024 at 05:03:39PM +0800, Shuai Xue wrote:
>> +int aer_get_device_fatal_error_info(struct pci_dev *dev, struct aer_err_info *info)
>> +{
>> +	int type = pci_pcie_type(dev);
>> +	int aer = dev->aer_cap;
>> +	u32 aercc;
>> +
>> +	pci_info(dev, "type :%d\n", type);
>> +
>> +	/* Must reset in this function */
>> +	info->status = 0;
>> +	info->tlp_header_valid = 0;
>> +	info->severity = AER_FATAL;
>> +
>> +	/* The device might not support AER */
>> +	if (!aer)
>> +		return 0;
>> +
>> +
>> +	if (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END) {
>> +		/* Link is healthy for IO reads now */
>> +		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
>> +			&info->status);
>> +		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
>> +			&info->mask);
>> +		if (!(info->status & ~info->mask))
>> +			return 0;
>> +
>> +		/* Get First Error Pointer */
>> +		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
>> +		info->first_error = PCI_ERR_CAP_FEP(aercc);
>> +
>> +		if (info->status & AER_LOG_TLP_MASKS) {
>> +			info->tlp_header_valid = 1;
>> +			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG, &info->tlp);
>> +		}
> 
> This matches the uncorrectable handling in aer_get_device_error_info, so
> perhaps a helper to reduce duplication.

Yes, will do.

> 
>> +	}
>> +
>> +	return 1;
>> +}
> 
> Returning '1' even if type is root or downstream port?
> 
>>   static inline void aer_process_err_devices(struct aer_err_info *e_info)
>>   {
>>   	int i;
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 31090770fffc..a74ae6a55064 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -196,6 +196,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	struct pci_dev *bridge;
>>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>   	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>> +	struct aer_err_info info;
>>   
>>   	/*
>>   	 * If the error was detected by a Root Port, Downstream Port, RCEC,
>> @@ -223,6 +224,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   			pci_warn(bridge, "subordinate device reset failed\n");
>>   			goto failed;
>>   		}
>> +
>> +		/* Link recovered, report fatal errors on RCiEP or EP */
>> +		if (aer_get_device_fatal_error_info(dev, &info))
>> +			aer_print_error(dev, &info);
> 
> This will always print the error info even for root and downstream
> ports, but you initialize "info" status and mask only if it's an EP or
> RCiEP.

Got it. Will fix it.

Thank you for valuable comments.

Best Regards,
Shuai


