Return-Path: <linux-pci+bounces-39360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F7C0C3E4
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3ED189B6A1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB342DF706;
	Mon, 27 Oct 2025 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQIwRJB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017F19D065
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552617; cv=none; b=G0KeqaWHI6ULnGQDi3o376/EAMxzL+8q0kuEeTgD5ZRfBi1sj9G7mcWX6Pnt8iwv+SC5fjYeiAqBh2pp5EewzHJoGMUSwGpRaeD6+6yT+8snb7cPlFaRIug16SAUrWSbkmHP7x3AoTJH7/pKNACpJ6BOjX9qVTjmM+Fm+FI1WPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552617; c=relaxed/simple;
	bh=VoRUY3ins21uu8jjVMczNJwbivQ26l6F68stddKtneg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTrAtadVZO9LvhuN6wEswTNr2IsHPSV+5KAM4EeqxeFTb5Y1TOTAYa/Fv1ahwEjD4HI9iwMoFnZ3jLERDbm6Y3tPnZMvAl5yZjf9P8UOMhn2i/He+8vhH/tHla/O6SShLkUkE+iiCj4Kytg+v5QmDLaqrZjGFXE0sFQiXEPsOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQIwRJB7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-794e300e20dso4704416b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 01:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552615; x=1762157415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6n3f7H9R5Wq242yxZtuIsFjuAPFB3rb7ibQPNdRdRM=;
        b=IQIwRJB7rJnAcNxe4gr9gE7yNFSLcnYfNcnkQI0otJzvUJTLgXb2Zm4X9o3jebmdVe
         e3ppbd6cKFZFNGbsNoWt0xX7YnDnyiZ3puEg+jAo1HCVb6qeQ8JTda8fq/tl6ivIHZeL
         Y3NexpP3631424VR+/6pMhud/JurwOmC6rMCxQQHJzmZjRYCK8BK7veUEm3ZqzuzZCh3
         MVtoe9PIGMnagrDKpoFuv23Pvy5Mmqb2vKpBPInnMul9AQkh0viREW4CIjfjkj0cOE/R
         cfDiKufZbGOKKJFt2NmWog5Ycpvap5zHEcDIVkE1K8CXOjfQ9D2HIhac/soD1NXj5+q0
         mV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552615; x=1762157415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6n3f7H9R5Wq242yxZtuIsFjuAPFB3rb7ibQPNdRdRM=;
        b=EkeFnKGfqxY00FFxBitDqziVjN7oNXWqQLYIe2BM4CyeIsKW2O46rmzzOKkSn1q9AB
         fbhO6o5HnNv4ycSaPKVYMBtpc1PV/XxiebH520hNq83WyncoC1vxD1MX94Q5SAYHOucI
         /PHd5N6xzZrdYr9zGX/lPvpYfVMij6TR8F//TGKiphwSXyX+4oZMvAG0BWqoRZO2PqDR
         I7lV5HAzGVr6hpXEBD4x1CfHb/q7Ku7Jq2w+cljn10G+48L4NKP/j08fLVq9gshSrEtZ
         Gu6L43Kfn13SNmTX6an/qBBCtoESj/+Myg9ZcisOvd9UZEsNYru3pV9hNxY/A8JTTR8w
         goZw==
X-Forwarded-Encrypted: i=1; AJvYcCWFtaFv2cneX8CktPF36ZX4LvILUkkf1ygIyTRCCCFWg1hD4SW3KbFcpWGqp41v+XNyGdgEbAIy2hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtobXo/SYRwE/cMbUp8pZRg+T04t9EO3VAMQbgQc8XxaetTHP
	XpFJUillPd5SvSWt0zyU3g/gCJMAFRSRGFfXN+hdX7cGlpC+rx0PVNB0
X-Gm-Gg: ASbGnctUUrzfTMjnvGqGNx/nSK3tQrYPE4tW++2E75wYpLvjgYAqHgQh9weyCX67TPd
	YXKzjNMh2smMEPTgbQOQbnl9IgjEreLTCZRkYbtNcW53Wjmx5Nc2D01AvaHKNsphlnMjGL8T3CA
	pfDGRs4c/2OwFlGgYSkZy/ZvUEk6t6PaOaYhG8stvojpNeGCB9RCg5Gh84yy44qh90V/+Q4UJHY
	a8k19qtRkechHeZwAh2HPHw0p5tssMbZgXO61btS46/HUTSq1pUMATY4J4NZFueJf8v+ALjDA+M
	pkQUsi62Iy62YaRS4wjAHw4mbkKZVnjtCAMGYBgz2PaWECcDshRrBn9IKN0E3NArD72JikwF7vn
	48ma45Tb8SsxHUVr6tUQ5UFc+QoYrc1Fii7VYsBum6UGCPLZ+pn/0su+UQCL5je4gTQesTvvAPA
	/yvnkcRbh2HwvVQRHaPROFxl6mBEB1WEY=
X-Google-Smtp-Source: AGHT+IHSSd9fMAjmKfXljkXTyT2XUXCuCGrceY39YLK9TJKqTw964TmCldXcS6Vik91n8EMyB4Xofw==
X-Received: by 2002:a17:902:f712:b0:294:880e:7ab6 with SMTP id d9443c01a7336-29489db6cfemr114974275ad.1.1761552614877;
        Mon, 27 Oct 2025 01:10:14 -0700 (PDT)
Received: from [10.0.2.15] ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d274aasm71715025ad.56.2025.10.27.01.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:10:14 -0700 (PDT)
Message-ID: <81fd91f2-638c-466d-9b27-705a44632713@gmail.com>
Date: Mon, 27 Oct 2025 13:40:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, kw@linux.com,
 LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
 lucas.demarchi@intel.com, rafael.j.wysocki@intel.com,
 Manivannan Sadhasivam <mani@kernel.org>, bhanuseshukumar@gmail.com
References: <20251017185246.GA1040948@bhelgaas>
 <702c4ad7-508b-42de-9dc3-40e4a0fe7bd7@gmail.com>
 <b3a49920-1cff-4ea2-519a-318030ba8797@linux.intel.com>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <b3a49920-1cff-4ea2-519a-318030ba8797@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/10/25 00:16, Ilpo Järvinen wrote:
> On Sat, 18 Oct 2025, Bhanu Seshu Kumar Valluri wrote:
> 
>> On 18/10/25 00:22, Bjorn Helgaas wrote:
>>> On Fri, Oct 17, 2025 at 11:52:58PM +0530, Bhanu Seshu Kumar Valluri wrote:
>>>>
>>>> I want to report that this PATCH also break PCI RC port on TI-AM64-EVM.
>>>>
>>>> I did git bisect and it pointed to the a43ac325c7cb ("PCI: Set up bridge resources earlier")
>>>>
>>>> Happy to help if any testing or logs are required.
>>>
>>> Thanks for the report!  Can you test this patch?
>>>
>>>   https://patch.msgid.link/20251014163602.17138-1-ilpo.jarvinen@linux.intel.com
>>>
>>> That patch is queued up as
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=469276c06aff
>>> and should appear in v6.18-rc2 on Sunday if all goes well.
>>>
>>> If that doesn't work, let us know and we'll debug this further.
>>
>> I applied above patch on top of commit f406055cb18c ("Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")
>>
>> Did pci rescan and run kselftest (pci_endpoint_test). It is working.
>>
>> Thanks for the patch.
> 
> Thanks for testing the revert.
> 
>> Happy to help if any testing or logs are required.
> 
> I'd be interested to understand what goes wrong with the change I was 
> trying to make as I want to attempt the same change later, but with all 
> known issues solved by supporting changes, obviously :-).
> 
> The log snippets you provided are unfortunately too short to contain all 
> the necessary information (missing e.g. root bus resources and possibly 
> other helpful details).
> 
> So if you could provide dmesg and /proc/iomem contents from broken and
> working (with the revert) cases to let me easily compare them, that would 
> help. Please take the dmesg with dyndbg="file drivers/pci/*.c +p" on 
> kernel's cmdline.
> 
> No further actions needed beyond that until later if I need to test some 
> of those supporting changes before retrying all this in the mainline. It 
> may take some time, even more than one kernel cycle as there have been 
> quite many regressions.
> 
> 
Hi

I captured logs with dyndbg="file drivers/pci/*.c +p. See the links below.

Working kernel logs
https://github.com/bhanuseshukumar/kernel_logs/blob/main/working_log

Non Working kernel logs
https://github.com/bhanuseshukumar/kernel_logs/blob/main/not_working_log

Happy to help if any testing or logs are required.

Regards,
Bhanu Seshu Kumvar Valluri



