Return-Path: <linux-pci+bounces-38845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D887BF48A5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 05:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341C8467D7C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 03:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B2C224245;
	Tue, 21 Oct 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvboJjdm"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975A1DED49
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018603; cv=none; b=KPvdL+S2lSXur4PjVDFZmIgqvQMQ+UPhJjzI9u72eEgqFV5Hn7alwo51JnV0Iz04p51Rgv+oFt0KubFd84NwTy/MptiQG3tGcoIownduEq3vIpvj13uqH5YqV2rVEsNb9Kh2zr8agzmMbmgJOS+Ht0f2VKGz7DS4SV5x9Lohcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018603; c=relaxed/simple;
	bh=5wHRWII5YqV0H1234MXs40PJ+FJPQo2Fuwf1/Zu6dL8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zk7K0Gb633FywPnyCUwLlWpZo7H4Dbteoi2c1xoRccZdHzGnGRC60d4T/L/KNXnIpFBJ0NV5UWzFFgOq018yUWfd+qhW2aluFdtmzvPc6OggWZMj3VupKoZmwERVv7zV1l1/uvxF/1DSMqul+0u323U7KZRnYNBu6TrcOkFk0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvboJjdm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvtwqFSdwBIJ1DhFupvj6yUOG7znXFLvI8hL6gZ8038=;
	b=XvboJjdmIihWo7+/gD2ilhJTaBrTcn4A0qwoTl5RF4qI9zYm+3/je/YNW7YUIP2I34iRjn
	gDX6kL8qArUK7ieyziZVn0ntJsNbgeGbKQx/Kbu+rLA31+vX+22uC5dOACrdCRl2++un2c
	Ukw3O8ZRzLKCWRwaJEdFW91baLwkivI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-aQ8phOgYMRm6GMPPr0DMIQ-1; Mon, 20 Oct 2025 23:49:59 -0400
X-MC-Unique: aQ8phOgYMRm6GMPPr0DMIQ-1
X-Mimecast-MFC-AGG-ID: aQ8phOgYMRm6GMPPr0DMIQ_1761018599
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c1f435b6bso81354976d6.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 20:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018599; x=1761623399;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvtwqFSdwBIJ1DhFupvj6yUOG7znXFLvI8hL6gZ8038=;
        b=Zg7fFHLZM41AZ6xBQOFcBwnQ1gMmqzM/sbA9x62HyRphhYJ24r6yjQCMSb4zGeWD0Z
         lVev4grVXM5Lb+i9S6IUXScAs9klocHnNrjnTkrJYgKiBVbm6vzCg2TIawKLg6itktf3
         xm4MTD1uaEpB/VSdbc+ZEawyqa3niXnPle6QQV3UP3RC9K8RZNs8l2CI/vqeC6sBYX5F
         CX9QR8lEU0vMnOG+aIXHpagrnWqXqKDpEdE95xkzoUKwvosSPkzs/H2Bn3Ab7R9r1vpo
         owZmtm6Xnb+a/H1vA49s9dUAW2YuaiMwi4f5uYw+odKJvpzC0jD539OrQGCHroTSh9Sn
         Nf6g==
X-Forwarded-Encrypted: i=1; AJvYcCVw/eW52twt/epM2LBNNGcTPiLk964p4Tk+H2uS4oHHVduzlzRmEIQz0A1+n0OpkE3vdAwarfluCGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPYEqx6j7+gcLQkK1LdKmUkYuetzBirc6iBJFIVvolC//NJAs
	glZrAk01q2LpEur8uSM5vncpSNe2ZLo2H15PycGybVGMnc5zSOwRRPztw8Y6kfBR0e21FXzwace
	3dShpQv3UFLP0TnGEkL28Fp3PyH8Wx2Bj0WlBwO0sk+RHgBxnz6UsDsKVYDfAFA==
X-Gm-Gg: ASbGncsTzcYjShcidvM4YCHa3S6ybe/SBRF/TWPPXZZik4oYqyy2UHiaEkgurg+ovsV
	sN5pJMPcLvTxEj6iAIWd2Q42FRYRhHrOnLa/xqAH5pw/b45iiTWZVShLTNmJW5077kEg4gpXGzI
	f3DU34W4/0BsuMLJa38uI+apoc5EQfdUGOnTsh4+PiCnaq0K3NXCVNrzCrWkEUXw3UDrUVNavh1
	ghjYD50kr6FSx47xH9M5w9vBKYsCVmqv0X7+BaLFiWDNhc7JMRHotpC+IHvlCeIqDBRiy6HjW5U
	/yKpw5p4+/wVWPuBhvMsgxY967HBinPf/YBfNowXv9m4CLlF4hT4+1Rhsf1KTUfWu4ri0ldiXAH
	iHfMJ/FsEuHhvDoyqpaeKqK8zWV4Dwz5pljHSzUJ5CSCIWw==
X-Received: by 2002:a05:622a:14d1:b0:4e8:ac66:ee45 with SMTP id d75a77b69052e-4e8ac66f422mr138856391cf.43.1761018598791;
        Mon, 20 Oct 2025 20:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzYxTQpPj871EoIMw1y246oGNNWS2hGT92x0DCSyPVsnjuqhhKKjEAvaY7EAUAoH4h5eayPQ==
X-Received: by 2002:a05:622a:14d1:b0:4e8:ac66:ee45 with SMTP id d75a77b69052e-4e8ac66f422mr138856231cf.43.1761018598358;
        Mon, 20 Oct 2025 20:49:58 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd6717desm684147885a.26.2025.10.20.20.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 20:49:57 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <083388fb-3240-4329-ad49-b81cd89acffd@redhat.com>
Date: Mon, 20 Oct 2025 23:49:53 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
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
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-13-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-13-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN's cpumask will soon be made modifyable by cpuset.
> A synchronization mechanism is then needed to synchronize the updates
> with the housekeeping cpumask readers.
>
> Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
> cpumask will be modified, the update side will wait for an RCU grace
> period and propagate the change to interested subsystem when deemed
> necessary.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
>   kernel/sched/sched.h     |  1 +
>   2 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 8690fb705089..b46c20b5437f 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>   EXPORT_SYMBOL_GPL(housekeeping_overridden);
>   
>   struct housekeeping {
> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
>   	unsigned long flags;
>   };
>   
> @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>   
> +const struct cpumask *housekeeping_cpumask(enum hk_type type)
> +{
> +	if (static_branch_unlikely(&housekeeping_overridden)) {
> +		if (housekeeping.flags & BIT(type)) {
> +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
> +		}
> +	}
> +	return cpu_possible_mask;
> +}
> +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> +
>   int housekeeping_any_cpu(enum hk_type type)
>   {
>   	int cpu;
>   
>   	if (static_branch_unlikely(&housekeeping_overridden)) {
>   		if (housekeeping.flags & BIT(type)) {
> -			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
> +			cpu = sched_numa_find_closest(housekeeping_cpumask(type), smp_processor_id());
>   			if (cpu < nr_cpu_ids)
>   				return cpu;
>   
> -			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and_distribute(housekeeping_cpumask(type), cpu_online_mask);
>   			if (likely(cpu < nr_cpu_ids))
>   				return cpu;
>   			/*
> @@ -59,28 +70,18 @@ int housekeeping_any_cpu(enum hk_type type)
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>   
> -const struct cpumask *housekeeping_cpumask(enum hk_type type)
> -{
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return housekeeping.cpumasks[type];
> -	return cpu_possible_mask;
> -}
> -EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> -
>   void housekeeping_affine(struct task_struct *t, enum hk_type type)
>   {
>   	if (static_branch_unlikely(&housekeeping_overridden))
>   		if (housekeeping.flags & BIT(type))
> -			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
> +			set_cpus_allowed_ptr(t, housekeeping_cpumask(type));
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_affine);
>   
>   bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
> +	if (housekeeping.flags & BIT(type))
> +		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>   	return true;
>   }

The housekeeping_overridden static key check is kept in other places 
except this one. Should we keep it for consistency?

Cheers,
Longman


