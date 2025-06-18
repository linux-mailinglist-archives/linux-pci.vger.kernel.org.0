Return-Path: <linux-pci+bounces-30072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57FADF109
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0D51893027
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FBF2EF297;
	Wed, 18 Jun 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qJOXrnFW"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0B2EE99E;
	Wed, 18 Jun 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260032; cv=none; b=iXg9vGBqM1u5d4U7JY3kfikOFrGfVLBdcZBWCWg7TJJiHI0fqM7EILOOZQ+81ST/VOdppnxTOXoLKR6CEP1Q3/+q5X55z6xD6QKE3KBOgRNDkBJRxvv5HfIt+eedIWZ1zcqD6UI3T4dBU/L67PNEOZnrzBL0duPJmLhjuu0PITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260032; c=relaxed/simple;
	bh=dBMetiDqRwuA7EYSG1BxFLtDf2bO5RsAThvIYbtXxoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQPSK16OkKgY2aj72H/EiZ77kUXn1cM+LBl3XLuhlY5fQEbOdDOu5OT22AvhSlX6vHSlh19E+3VifgSCgzKAqvaxOvCtZmca8TKJirXcHz4yZy/YXhJK6AiHIid8bdtFewhFnGeviCiVdyZV+zb2CQhsqX4Er2e3jXQeKeT7Kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qJOXrnFW; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=eZXPwb9W2kal/+I9MYTP/YSPhsVDBv6emckwljPlJ/g=;
	b=qJOXrnFW88lIR1+4/5aE//cQL5bJBvIeY0OkeSwSsC/soyYMWhZdNXghqZnTPv
	ipJFgM13II3OATtyQxGgHvT+rdM/EdmJCIvrYuRw/uzXsAQYSGOwiDvewqgAvga6
	hlFwHrYIC7TfAvEwx9QGfNmGoGvRZuyg13dvKQnnZcsZM=
Received: from [IPV6:240e:b8f:919b:3100:8440:da7c:be7e:927f] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnT_IR2VJooCEIAQ--.14627S2;
	Wed, 18 Jun 2025 23:19:46 +0800 (CST)
Message-ID: <927e3030-756c-4b1b-a797-5f556ba2b101@163.com>
Date: Wed, 18 Jun 2025 23:19:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] PCI: dwc: Refactor register access with
 dw_pcie_clear_and_set_dword helper
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
 bhelgaas@google.com, mani@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250611204011.GA868320@bhelgaas>
 <c31c3834-247d-4a28-bd2c-4a39ea719625@163.com> <aFLTwWG5lOTunEq3@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aFLTwWG5lOTunEq3@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnT_IR2VJooCEIAQ--.14627S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy7Ar1rKw4xXrWrJw1DJrb_yoW8Zry5pa
	yYqa1Yka1DJFWUKF4Iyw15ZFyjq3s3t3sIqrn8J34Utrn8ZrWYgr9ayF4jkr97GrnI9w4a
	v3yYqas5Ca4YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UrnYwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwlwo2hS1QJYCQAFs4



On 2025/6/18 22:57, Niklas Cassel wrote:
> Hello Hans,
> 
> On Thu, Jun 12, 2025 at 09:07:40AM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/6/12 04:40, Bjorn Helgaas wrote:
>>> On Thu, Jun 12, 2025 at 12:30:47AM +0800, Hans Zhang wrote:
>>>> Register bit manipulation in DesignWare PCIe controllers currently
>>>> uses repetitive read-modify-write sequences across multiple drivers.
>>>> This pattern leads to code duplication and increases maintenance
>>>> complexity as each driver implements similar logic with minor variations.
>>>
>>> When you repost this, can you fix whatever is keeping this series from
>>> being threaded?  All the patches should be responses to the 00/13
>>> cover letter.  Don't repost until at least a couple of days have
>>> elapsed and you make non-trivial changes.
>>>
>>
>> Dear Bjorn,
>>
>> Every time I send an email to the PCI main list, I will send it to myself
>> first, but I have encountered the following problems:
>> Whether I send my personal 163 email, Outlook email, or my company's cixtech
>> email, only 10 patches can be sent. So in the end, I sent each patch
>> separately.
>>
>> This is the first time I have sent an email with a series of more than 10
>> patches. My configuration is as follows:
>> smtpserver = smtp.163.com
>> smtpserverport = 25
>> smtpenablestarttlsauto = true
>> smtpuser = 18255117159@163.com
>> smtppass = xxx
>>
>> I suspect it's a problem with China's 163 email. Next, I will try to send it
>> using the company's environment. Or when I send this series of patches next
>> time, I will paste the web link address of each patch in by replying
>> 0000-cover-letter.patch.
> 
> Perhaps the git-send-email options --batch-size and --relogin-delay can be
> of help to you:
> https://git-scm.com/docs/git-send-email#Documentation/git-send-email.txt---batch-sizenum
> 
> 

Dear Niklas,

Wow! Thank you very much for your help. My local test is normal.

Best regards,
Hans

> Kind regards,
> Niklas


