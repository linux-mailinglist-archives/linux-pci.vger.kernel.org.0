Return-Path: <linux-pci+bounces-20735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBDA28B10
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07BE188149D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2055FB95;
	Wed,  5 Feb 2025 12:57:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F510F507;
	Wed,  5 Feb 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760250; cv=none; b=tIhXt9ur00hY/luXx1Gyx8Iddj4bzxgJe+Cq2FuVCBJFk+cU8OeeqZLpwpQoOV/Fu8ixKJiRwts/jrUqz8ueQTun16xTW7lbgngxmfEt0KWOw+kXUdGFoPVZgaDNpQ6tnTNzFNgOkPTq/D2YkeZiBEFLf8UTFH4XOTp7/JImKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760250; c=relaxed/simple;
	bh=gx24NkCwpwV9AcPPbFrtwlbx9niJwvD4f0qfvasEhoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWGFsPj09tkbIbsvMNIZ0ZF+3bbpMKJOeamTng0xMBq5vi2OU/2n1FbHhLmBsElrwqgINwc+V0f0RmUKUs/St1v0qq6X9h/s1T3Pl5ZwX9UyhDX0BZi6mfZvWEGABgsCMcJRbI4+r+enCMCthmsIa4Hhg5nVV1Uf9tesIRjy05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D01471007;
	Wed,  5 Feb 2025 04:57:50 -0800 (PST)
Received: from [10.57.35.21] (unknown [10.57.35.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01ABF3F63F;
	Wed,  5 Feb 2025 04:57:22 -0800 (PST)
Message-ID: <4294edaf-8621-41b2-9009-7f5f3bb6c7f8@arm.com>
Date: Wed, 5 Feb 2025 12:57:21 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/5] PCI/TPH: Add Steering Tag support
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20241002165954.128085-1-wei.huang2@amd.com>
 <20241002165954.128085-3-wei.huang2@amd.com>
 <a373416b-bf00-4cf7-9b46-bd95599d114c@arm.com>
 <f6b34f2e-31c9-4997-abfe-38d7e774b4fa@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <f6b34f2e-31c9-4997-abfe-38d7e774b4fa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-04 8:18 pm, Wei Huang wrote:
> 
> 
> On 2/4/25 12:33 PM, Robin Murphy wrote:
>> On 2024-10-02 5:59 pm, Wei Huang wrote:
>> [...]
>>> +
>>> +    if (err) {
>>> +        pcie_disable_tph(pdev);
>>> +        return err;
>>> +    }
>>> +
>>> +    set_ctrl_reg_req_en(pdev, pdev->tph_mode);
>>
>> Just looking at this code in mainline, and I don't trust my
>> understanding quite enough to send a patch myself, but doesn't this want
>> to be pdev->tph_req_type, rather than tph_mode?
> 
> Yeah, you are right - this is supposed to be pdev->tph_req_type instead 
> of tph_mode. We disable TPH first by clearing (zero) the "TPH Requester 
> Enable" field and needs to set it back using tph_req_type.
> 
> Do you want to send in a fix? I can ACK it. Thanks for spotting it.

Done[1] - cheers for confirming!

Robin.


[1] 
https://lore.kernel.org/linux-pci/13118098116d7bce07aa20b8c52e28c7d1847246.1738759933.git.robin.murphy@arm.com/

> 
> -Wei
> 
>>
>> Thanks,
>> Robin.
>>


