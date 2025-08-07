Return-Path: <linux-pci+bounces-33501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC1B1CFDB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 02:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0D8722C1C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 00:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297B1F95C;
	Thu,  7 Aug 2025 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fovr11XA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66CE2E36E2;
	Thu,  7 Aug 2025 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754527580; cv=none; b=a14sAhgBdhz7ysOk0uTw9EW3ZW1mV8FF22hCmZa2swNoDOdVHG91RfNUYRwtVTwyyoDsAYy2ERtQVQhSyDCsbv/DUh9Khsz6ehdgQrkUZPF74ygMpEzB/QmyhjXS05KOXujG06Pd9NrhMr91uBh0FekByuqfvNU+68vEVLanWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754527580; c=relaxed/simple;
	bh=8ARsvRmbGTr1c/flMy85gwIvw4VsWQIgMoVqfGy7IJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIio/6Nae9xf/Ff/9sKvkSe58vJNbOVyVhcusi6NEbkIv3CWGsWPgiz4meOPGBstJHYtTOvhiSncT4gEYv1aMuDVMmazW1cxOoOrIl5Y2SEzeu6Lg9sGaieeqp/l6G9PVLlaDbDm2FF2zpRSDD6x3J6Rt07ySdO9u/dlrQEOiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fovr11XA; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-53960818e9fso392263e0c.0;
        Wed, 06 Aug 2025 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754527578; x=1755132378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rmc1rEtWWDIvM/pd+dlvLBSfFeCnTebznounEkESmm8=;
        b=Fovr11XArDmAvhVpKdNRkzg5KadIwumYeacJ0ECX2j+m9bAbrL/E54+w3U40Kv3mzS
         TxIYuA+lru/mMLpTe4E0CJ5gkBDpKfxSH8aM7wPqVDCdg8nvxiqcc5kyMgXr6wjglzZI
         eUSL++hkzDr23UuU2fgjoHNGPewksdO/vWBKEtAvavMV1kKOtpfZhcD7TbwNwqXHX1dg
         p7gByIGJY/sLC7Y2W9XjEyIuBkIXUsfdjasbC3WKSPhIriefXzg/uCEMtpUV5M3p8/s6
         OWFMsaT2J6q+AVTs2j68BqREV0DcUT98ndcprDcE0mHZ4iba41yjNO3Ys0jEgSY5E30h
         WP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754527578; x=1755132378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rmc1rEtWWDIvM/pd+dlvLBSfFeCnTebznounEkESmm8=;
        b=cqlbbvTOkivVmrxcRIUlGZ6bFuXShxmHqPeO40+f2UkY14UqqMiiFOomg5uELu/Fit
         5lFnP4OZ6Y/D+hKTj6jnwuErjKsurNMaOums87DyqYj8IXQ0Ln/NOzY2ksPSsZn/EGs2
         JOtLEztvg7rwoUy4Sr+jBAlYUndBv5QL4GNjT3T6EFsOqHBRhMuuSf9uyU7LqURG7yI9
         /dJQQYQsAEdqSaGa7JxH4QFD+c2L2V+Z008XSoyWLRYLvUcrMXH+/DVUYNo8MU9wGRd9
         qM31gVrzyY6UOWJsf3myTrg6XM5szxD179qKy88Gt/WjoHwoflggsntdo20e8AEmv0MN
         NYiw==
X-Forwarded-Encrypted: i=1; AJvYcCU2LVD/SSXC0GdogMavyjYcUd0OyPzhFGetEeH8lnVBTjJaXAp9SRedH3FeiNjmrx2GxHTDcHkeYVGW@vger.kernel.org, AJvYcCW5Y/QdO67n5DFvixzcZ8NHbvkAgFzQHSqceVfpMUto5QS9J/DaHPjALAKCh/Semw2hw/HlJUZh1VSSDV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwA5nlXFBzQOscfMYws+Zv0m7qY51UsB+AlKridTw6+o1VESK
	XAsrDuGCbCpz0BS3H2nDeWSZEZiGK6QQK0yPGBN33G3La1Sec85hSrwF
X-Gm-Gg: ASbGnctvWTFqfVXZo3L7v0JM0KvrQp5ublM9RHptqogrz3uBpI5FyfOEPyjunXcJVfo
	gYBDZ5wuKS6AVIfoof5XUB2UAFX2Z4v1SotaUvBadZm9+aKuxdk26lthpmt/dPb8ZM6ol/cF5pp
	BpMcccNJGhU9MtWX2C1KjsEqDb+OhH4+lZufHUyiQnR2/mk2kI3glTLaQe9WpgBWDa9K5SxUs3J
	gQhEDlR7QQxF2RLfs0kv1/StGSEbFT0Tf1zq+/isK/FHLjurasXYcc48xfCGHNm+ExwOe/jFhYu
	AvOt7PA6k6ZnRF+tYCNRk1TT1xbhd6Ru3E7jiJnXeQsNK8En0qYI6qjiBBtm53KGf8d+Qvshld/
	OswbRF0B+9ecMMBevnyuap7AYErQXklgev6Nrw1FEDqG9O9D09sv8Zcq70sUVBPHgNWpbYpS1wl
	sLjC9spKvPJTWypF0AyA==
X-Google-Smtp-Source: AGHT+IFZepYERxh2hTblseaMPrVinVFDPj77BmHfxlgef5ZJVdCxI3Rs/9/yOXAWQqnIRxoRQr+uHg==
X-Received: by 2002:a05:6122:2020:b0:539:4e00:dba0 with SMTP id 71dfb90a1353d-539a03d5349mr2625544e0c.4.1754527577649;
        Wed, 06 Aug 2025 17:46:17 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b02b2113sm121074e0c.31.2025.08.06.17.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 17:46:17 -0700 (PDT)
Message-ID: <3eca0594-ebe4-4b34-8463-555136199dc1@gmail.com>
Date: Thu, 7 Aug 2025 08:46:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
To: Breno Leitao <leitao@debian.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
 <50f6c23f-1f46-4be1-813a-c11f2db3ec4f@gmail.com>
 <umpfhbh2eufgryjzngc7kyvjlqf3d6fgzftgeb44yf4bbtizb6@x7iqbksbbcot>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <umpfhbh2eufgryjzngc7kyvjlqf3d6fgzftgeb44yf4bbtizb6@x7iqbksbbcot>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/6/2025 4:45 PM, Breno Leitao wrote:
> Hello Ethan,
> 
> On Wed, Aug 06, 2025 at 09:55:05AM +0800, Ethan Zhao wrote:
>> On 8/4/2025 5:17 PM, Breno Leitao wrote:
>>> Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
>>> when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
>>> calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
>>> does not rate limit, given this is fatal.
>>>
>>> This prevents a kernel crash triggered by dereferencing a NULL pointer
>>> in aer_ratelimit(), ensuring safer handling of PCI devices that lack
>>> AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
>>> which already performs this NULL check.
>>>
>> The enqueue side has lock to protect the ring, but the dequeue side no lock
>> held.
>>
>> The kfifo_get in
>> static void aer_recover_work_func(struct work_struct *work)
>> {
>> ...
>> while (kfifo_get(&aer_recover_ring, &entry)) {
>> ...
>> }
>> should be replaced by
>> kfifo_out_spinlocked()
> 
> The design seems not to need the lock on the reader side. There is just
> one reader, which is the aer_recover_work. aer_recover_work runs
> aer_recover_work_func(). So, if we just have one reader, we do not need
> to protect the kfifo by spinlock, right?

Not exactly,
If the writer and reader are serialized, no lock is needed. However, 
here the writer kfifo_in_spinlocked() and the system work queue task 
aer_recover_work() cannot guarantee serialized execution.

@Bjorn, help to check it out.


Thanks,
Ethan>
> In fact, the code documents it in the aer_recover_ring_lock.
> 
> 	/*
> 	* Mutual exclusion for writers of aer_recover_ring, reader side don't
> 	* need lock, because there is only one reader and lock is not needed
> 	* between reader and writer.
> 	*/
> 	static DEFINE_SPINLOCK(aer_recover_ring_lock);


