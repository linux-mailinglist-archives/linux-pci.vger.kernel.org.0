Return-Path: <linux-pci+bounces-23904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75857A64090
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 07:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766D33A9748
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 06:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FABA146D6A;
	Mon, 17 Mar 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a12kam4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26C2E3373;
	Mon, 17 Mar 2025 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191362; cv=none; b=J6t4q0yFcxLMS6Rz8JHiMaif8Gpo1D1pHGXIQ8mCezGtmHrbhxooCJQ0sqV+3hW45/fFVa6QY59JMY7zIZzgi5STOhUaYDmeZVkpcPfafzKOfdJfrlLciTFqrGZC+BzBdt5teNw5S/R1UP5C7gjoQAMiNMG4dXw86y2iCRLDlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191362; c=relaxed/simple;
	bh=sOig/ORpClWPiiaToPGJq5t+0VEGnCE5ZesaAcaMFAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qiSz6m3eHG8XZE9O8lvqf2cDY/P4sjTHUwAs6OLKstOSBhE0X9wWG2XlAnAehbldaFmfplCqoXCFnQol70StHk7RCL8mxIbXqLpvRFZHtNSen6r+MW27zli5PA9FYiAORIqoxkZP58NWcEVWjQox1J8uvg2AmyIKO8fyZPNL168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a12kam4p; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742191349; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=b5GxWT6HNGG5WO59UC9kgPZf/Ys/EEvS9UccUUiRohs=;
	b=a12kam4pxZPBeTjI5STZtSuyYYN6uCVjFR2GQYStNAAFsywgQdwHIR70nnEr9AD43HHwpWULwBG2Baoi+cvajiz6TmJ8ip/n92cNkhKjGEXgQ6ZxocGPjjVt7rA6UxqVHuNy6xdUb2nzIZRYAthpPCNjsm2oKoymhBSVFl+/1/M=
Received: from 30.246.160.93(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WRZvNEt_1742191346 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 14:02:27 +0800
Message-ID: <362fcb01-8d9c-49e6-be83-5a784c1e5f3e@linux.alibaba.com>
Date: Mon, 17 Mar 2025 14:02:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com
References: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
 <20250217024218.1681-4-xueshuai@linux.alibaba.com>
 <8a833aaf-53aa-4e56-a560-2b84a6e9c28c@linux.intel.com>
 <1dea64ef-3c9f-4bff-820f-34d8f3a6a1d4@linux.alibaba.com>
In-Reply-To: <1dea64ef-3c9f-4bff-820f-34d8f3a6a1d4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/3 12:33, Shuai Xue 写道:
> 
> 
> 在 2025/3/3 11:43, Sathyanarayanan Kuppuswamy 写道:
>>
>> On 2/16/25 6:42 PM, Shuai Xue wrote:
>>> The AER driver has historically avoided reading the configuration space of
>>> an endpoint or RCiEP that reported a fatal error, considering the link to
>>> that device unreliable. Consequently, when a fatal error occurs, the AER
>>> and DPC drivers do not report specific error types, resulting in logs like:
>>>
>>>    pcieport 0000:30:03.0: EDR: EDR event received
>>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>>    nvme nvme0: frozen state error detected, reset controller
>>>    nvme 0000:34:00.0: ready 0ms after DPC
>>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>>
>>> AER status registers are sticky and Write-1-to-clear. If the link recovered
>>> after hot reset, we can still safely access AER status of the error device.
>>> In such case, report fatal errors which helps to figure out the error root
>>> case.
>>>
>>> After this patch, the logs like:
>>>
>>>    pcieport 0000:30:03.0: EDR: EDR event received
>>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>>    nvme nvme0: frozen state error detected, reset controller
>>>    pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
>>>    nvme 0000:34:00.0: ready 0ms after DPC
>>>    nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
>>>    nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
>>>    nvme 0000:34:00.0:    [ 4] DLP                    (First)
>>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>
>> IMO, above info about device error details is more of a debug info. Since the
>> main use of this info use to understand more details about the recovered
>> DPC error. So I think is better to print with debug tag. Lets see what others
>> think.
>>
>> Code wise, looks fine to me.
> 
> thanks, looking forward to more feedback.
>>
>>

Hi, all,

Gentle ping.

Thanks.
Shuai


