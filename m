Return-Path: <linux-pci+bounces-43736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4667BCDF0AD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 22:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F2853000B06
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 21:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E39215F5C;
	Fri, 26 Dec 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK9qEbZ1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaeVBzda"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273E487BE
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766784425; cv=none; b=K5OVzR0a1Dljvs+Z14/a86R1OdFSshvRUhK7Iy2ihpHhjr0at++hpRBa+GfAsXfGDATA+zCVcEbFeFbrTX/DmnZHkPz8UZd4PPCC2wkmSF5BfpMGM3WTSFgwZu1fmsy0CfrXIZqZYZ4QTw+PC0oU3TotpRP7qbypC/EXa5O5i0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766784425; c=relaxed/simple;
	bh=EVYVJsyRRz0shMqFnKsULoSUbGZk5zLkzZoCXi8IKXU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jjXYT8occMTXHlofhz3OmbLOzLG5HsgPdwS0XPVKwwzdRjdZmVM69R0XN/3Hj9z5dd2UMgGMWntsEC9AzolRP6XytAtV6/OGVuaRr3CElW71uUIUr0EhkIfytrInUEsx6zhOnCkb42DS/DeZuPRJIE0EByXNjw15QJEqJG8r+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK9qEbZ1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaeVBzda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766784422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
	b=dK9qEbZ1EOkXSDnsFlpLv/nhmy10vJX+UZmjZO8Ndo83KfSQj8qEUINl2F8hMX5V/5EWeE
	VtdBHHLBS/04hkXtRvML6XpjPyl3aWg8GEDFGB0nneS3pPEt+sqrqW9o2kTp6jflYP1orR
	dRXnzWbhzhgp79Nrgim124m6Rt/7cQo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-u-90r0OmOQeyHTzmUAVQlA-1; Fri, 26 Dec 2025 16:27:01 -0500
X-MC-Unique: u-90r0OmOQeyHTzmUAVQlA-1
X-Mimecast-MFC-AGG-ID: u-90r0OmOQeyHTzmUAVQlA_1766784421
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8887c0d3074so192935796d6.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766784421; x=1767389221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
        b=FaeVBzdam3yTjkRXFFvifhDtPNljjImA33hHnQmiEDX1zd8E0DJNrY8JMgRFaE8MXf
         HiOnCjJW0umymCr2Si/STRTaGPcDsBaAVPnZsWNp2FRrmK+skMY2tNL8C9ObYFVhqpCV
         mcm3WGJ5V8R45Un6bk/3NovUPjswl3E7x4bo7sdSGM/JzEWbIlrWliNSYztCmrtNhRCv
         GL04Bk3HDy2VRc7rZ+vRU4yxftmGgZJ4+e3uVhrTwcOu8NcEQlt1V6WVLsqsczoHB1jx
         lcgFIa/hoUUvBZYU+QkRHDD6e7NgURgMQ2k+UHoWrfKSZ5GtBdxySacFtk2uqNxp09iQ
         tn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766784421; x=1767389221;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hl0E323tW0AxgEnWj1OLKxpboSYa7xNjNvCKjrDAdIc=;
        b=GrHcGn0gYmKyz0zsR3NJbxR3Ut1L7OB7ZycNWkN1P82kzmil4Lbtj9yCUBZCMxSDKj
         PpbstiKOeVtxs7IWr4zr4KyIy4QskexDrvMsbuDjkuv+0TH61C83YAEII7VjpSqtg+hk
         i3XyUAZ9fU52dKDDGKf6rD+92ipn75bKQAoYSbzg4rA581PSs0dCbhUSFcUUzLNq0dLJ
         1/w/v1ALdJBGYqKovpIeYy9qKnzdSXCfbD4dfcUBl35wbtab1WuVsnsBjJki5Cold78K
         Cvo2xf2bB4shqbctftiVzA1ixj+eWB57QrKolv4Sn/EiGKHUJI6FTyj/lngOypX4srXv
         v0OA==
X-Forwarded-Encrypted: i=1; AJvYcCU0EjGAVEXn+WJS51sT89RyQ2qARIt1Ujmy2sDVdMwB2zU71Nz18JCqiQdgMkoZaW+7jaaiNqm4koI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/z7jlvGZsZ7no9jvBtH/sOkMgbLNH2LsDvU1Bf2TS6x9xm8LR
	a0WM5QvidANVJ+AhuD+xZn0jGXWEbnCGwWZezChzXzUPa9iSeWv1I0xqhtBONfcy6sHBFLF4e0O
	q1v2KFeJTlHhtQITUs1UZRnfSGyPXp9k5xFXuRFl5l25mtCcmnYY1FdtQTbjI3g==
X-Gm-Gg: AY/fxX7KqS3FN970R8aiRs+yQTc+e16tmLx1ssFdl3ArFKl+gaoDXNJQ+kOmVB6G2O7
	zEBoFdT3lxgDMbGB6nfY609QKDXzKGrRHX5uGOVGBj+/r/S89+ZDO6hy2ukYwtGXlFcXt/SJW7l
	L+O/10O6Hy8BOkHIM0WlrjmdR53czdNTm3LoFOE6qFWrQUtVFSJ1wJcgm6C7R28DKVxSvntj/pO
	J7fdFFSwIC29jvkfDdB22BnjtOQAMNfGvmLV7WCETeVG/s7lRNr7x1aEQIc3xETYi8NsWHZVxQC
	TMG/ZW2JhWwOL1pwLAYpM+aO9CZIhCUOpmEW6KDuAjBGRnU0qiKnGraEYVWZwQ/MyVk/c1pMy9E
	3bhitC2VKgYpTKUOmCwt4Erj9yuQNrz9kwVj/unUV0pideadI4FaSSGOB
X-Received: by 2002:a0c:fb45:0:b0:88a:529a:a530 with SMTP id 6a1803df08f44-88d82041773mr328947786d6.23.1766784420879;
        Fri, 26 Dec 2025 13:27:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfZAYYIQ2fUbZyPMB45iQArY9ihsQ/fJKmBvKtaCb5+ZXeC6tWw3vCNx5szpnr8D6LkXzAiQ==
X-Received: by 2002:a0c:fb45:0:b0:88a:529a:a530 with SMTP id 6a1803df08f44-88d82041773mr328947536d6.23.1766784420468;
        Fri, 26 Dec 2025 13:27:00 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa3ac8fsm175993226d6.56.2025.12.26.13.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 13:26:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bc573163-c5a8-4bb9-a280-45ca48431999@redhat.com>
Date: Fri, 26 Dec 2025 16:26:55 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] sched/isolation: Remove HK_TYPE_TICK test from
 cpu_is_isolated()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-23-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-23-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> It doesn't make sense to use nohz_full without also isolating the
> related CPUs from the domain topology, either through the use of
> isolcpus= or cpuset isolated partitions.
>
> And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
>
> This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
> alias) should always be a subset of HK_TYPE_DOMAIN.
>
> Therefore if a CPU is not HK_TYPE_DOMAIN, it shouldn't be
> HK_TYPE_KERNEL_NOISE either. Testing the former is then enough.
>
> Simplify cpu_is_isolated() accordingly.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/sched/isolation.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 19905adbb705..cbb1d30f699a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -82,8 +82,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   
>   static inline bool cpu_is_isolated(int cpu)
>   {
> -	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
> +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
>   }
>   
>   #endif /* _LINUX_SCHED_ISOLATION_H */
Acked-by: Waiman Long <longman@redhat.com>


