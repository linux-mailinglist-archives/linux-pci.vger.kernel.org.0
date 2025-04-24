Return-Path: <linux-pci+bounces-26679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F7A9AC6D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 13:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F285A6E97
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089B422DF9F;
	Thu, 24 Apr 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BLIegG1s"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4322D793;
	Thu, 24 Apr 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495351; cv=none; b=KeUr4EGrzpVf6mC2xOtH9T67qJnGSWzaxFj2M52edobqRsEU0qT2+ORasrXXQIftcAyxlMWNraEVGY97k0LvyP2gY48bg61XbuwZurvBT1y4H4a3RL6x8txDgH52PWkPCjsI9h7ZvtWlnmBHwpNXvtM3TD0Qi1Ock1ZSHBHPolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495351; c=relaxed/simple;
	bh=+b3iW2ysAZx8jNrvMtsp4DTDofLqBwY1FfDTQqqkE/w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j4VhdLbiHZgtZFCPLUV5h3KiPCDr2Grjq+pPIM+UClRTUdwJ5vTD2Nxeyixbgnv05i/GkdZwmtBRPhWBGnKCQV5kdKxXMNC1koo02PSGzQT3Ml0Djsd0KAXTeEMA+MC3NdKhAf1eZrmSIjSM+0rEnaSdoNKIE9wATAy2Gox9fQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BLIegG1s; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745495339; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=qs4/QnFg9rNhrfOh3L9B6LkK0j0hm6vYUMcuTxooLVc=;
	b=BLIegG1sS3L5UgRQ3YukmLaki7gcEhOR6mX8dL7TUGPWTmoYrmXdflbuXnBmEDqomQZ9B6DnIGQ/FZXL+dUmN3VhPBfyCeG27MWVcdT7RLEj+Qwm6IubwUxfrFm/WLL1i4fh6mRsmFFgxZ7ttCR8P1z7Pzo9DwyM7l193zgk6OA=
Received: from 30.246.162.65(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WXzJaco_1745495338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 19:48:59 +0800
Message-ID: <7f6c49d5-e11e-488b-bb67-4051abcb02f4@linux.alibaba.com>
Date: Thu, 24 Apr 2025 19:48:57 +0800
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
 <362fcb01-8d9c-49e6-be83-5a784c1e5f3e@linux.alibaba.com>
In-Reply-To: <362fcb01-8d9c-49e6-be83-5a784c1e5f3e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/17 14:02, Shuai Xue 写道:
> 
> 
> 在 2025/3/3 12:33, Shuai Xue 写道:
>>
>>
>> 在 2025/3/3 11:43, Sathyanarayanan Kuppuswamy 写道:
>>>
>>> On 2/16/25 6:42 PM, Shuai Xue wrote:
>>>> The AER driver has historically avoided reading the configuration space of
>>>> an endpoint or RCiEP that reported a fatal error, considering the link to
>>>> that device unreliable. Consequently, when a fatal error occurs, the AER
>>>> and DPC drivers do not report specific error types, resulting in logs like:
>>>>
>>>>    pcieport 0000:30:03.0: EDR: EDR event received
>>>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>>>    nvme nvme0: frozen state error detected, reset controller
>>>>    nvme 0000:34:00.0: ready 0ms after DPC
>>>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>>>
>>>> AER status registers are sticky and Write-1-to-clear. If the link recovered
>>>> after hot reset, we can still safely access AER status of the error device.
>>>> In such case, report fatal errors which helps to figure out the error root
>>>> case.
>>>>
>>>> After this patch, the logs like:
>>>>
>>>>    pcieport 0000:30:03.0: EDR: EDR event received
>>>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>>>    nvme nvme0: frozen state error detected, reset controller
>>>>    pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
>>>>    nvme 0000:34:00.0: ready 0ms after DPC
>>>>    nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
>>>>    nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
>>>>    nvme 0000:34:00.0:    [ 4] DLP                    (First)
>>>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>>
>>> IMO, above info about device error details is more of a debug info. Since the
>>> main use of this info use to understand more details about the recovered
>>> DPC error. So I think is better to print with debug tag. Lets see what others
>>> think.
>>>
>>> Code wise, looks fine to me.
>>
>> thanks, looking forward to more feedback.
>>>
>>>
> 
> Hi, all,
> 
> Gentle ping.
> 
> Thanks.
> Shuai
> 


Hi, all,
  
Gentle ping.
  
Thanks.
Shuai

