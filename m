Return-Path: <linux-pci+bounces-38848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092DBF494E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 06:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4FA84F5EE8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF06257452;
	Tue, 21 Oct 2025 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgDFTdq9"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB12517AF
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019829; cv=none; b=jqhXJRZ0XXGWVB5oDnRokdmvPx262toXEOPlCYTlD5JSk+5q9xbZN3B3zNWT9JnhdU7iWJHLvryGsFuwTmA6afVlqz9EhlKgIYDX4cMl5Nweufa+SIvkY67qzWV3h1i4PYaaUaRMBUuJ9blPE+K5K2ewcrBPO3STCvTJomNv6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019829; c=relaxed/simple;
	bh=m6Ygrj9CfSu9M6zL1BkSWa/FjgjlVS2hjqfbAo77jSE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kH+4Gls6R77UtwGt47czdybav2CTbLHFNvviJ4GIVTv6Imzj84V8ArCiCCGtDPbJ2wVUUGk2VyM3eCKtXBlgPhoUOe1vdCz038hqqQwiwF3shLTdkfIW00aWZd8t8Za+ykTqgCnyJQQ9qFa+3aJWljXHPupACUCNnMFFnapzm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgDFTdq9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761019826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9OupL1guxMQZzERaZQ5HIFJ+HTh+MX5SgUIo3LTaUY=;
	b=UgDFTdq9xiA/jpmFBHPbg55ggHfU2PbmAFgJ2llLYx2gz9+aI2+R69tiBZHbGcHF8zg7jK
	kX3jkpEmSaLc/3rqIO8nrVVCT0+9BMha/dK+CJ4Uem2e/671KKWVF5tnoOfQdvdcdnR0GR
	OQlCpAD3/GhGgUG6jKA5BFM4MP2GdYI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-O-6ZE1C5NKGIFtWmFkSVCg-1; Tue, 21 Oct 2025 00:10:24 -0400
X-MC-Unique: O-6ZE1C5NKGIFtWmFkSVCg-1
X-Mimecast-MFC-AGG-ID: O-6ZE1C5NKGIFtWmFkSVCg_1761019822
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c146f81cdso129018646d6.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 21:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761019822; x=1761624622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9OupL1guxMQZzERaZQ5HIFJ+HTh+MX5SgUIo3LTaUY=;
        b=u1peyuviNrbPPg5DWt3wl6qa/x5kwVtSBVGWnWQkFLM+FlX6CqN7uEyJ0v7Ruz00GJ
         8hs98wi0zg0bSBWv4yim1Gju+k128SK0031HPc2TTnNBfjZQa7MVnESFM35ipDDo6bL7
         p1axpWxIOj7fBlXzyTCwUI8Rdedm7Glg9gNOO136kmMLmaC9IQrB8Xr7vKzs85SFHf2L
         r4tNMzMwtea7LhCG/evWhBUZYMD7cF9kHsrZFhu5Zxoj4hw7IeCL5LVPyZsoD4mJrpbh
         fIdBr+9d9C8oxSHBTyfA++AXFtIqqRwzDAvzYJs3rvbMdenBAJCRdJ7p5GolpGXxL+Uk
         jPTg==
X-Forwarded-Encrypted: i=1; AJvYcCXFslwvErxGWik1eM+gs8AAXMtc115pJa1PC7tQHcxxUP190MTomP1aADah1wr48Yo8Pyx1ggVHkRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+PaCPqxK5+S9aN+y6vXog2BrsWFHKJBZUjdi9q52a7//DFyX
	olmcTbxxq0EJWh3ecy1Bs+MsS2suJNYOsnt+LDqSgtiApDS8IgNFy90sMZJXU2wa+cI3IhKCRMI
	DtKKk3fU+GNdyZPH6UyERUOVmVePxNdwgL1BJy0oucDeF1zJ1vU5Rcfk5vVc9FA==
X-Gm-Gg: ASbGncv9MvejL+ECktdevcv3FB6mdtRzCgIjUUxxXfGGSz3SJm75UDpgWmB8lRnaiVx
	Qm6Zpa91JAk2Dqcpu3iAjoSyRcvNilz6lGfxPy6Zf2xUSF4WklJa60WCsisjYbm7HD1yggtiVBV
	l+NtqjCFDBhiW96L29Q7wuR8MGKq+RLq3+1TH5y35GX8PCji1BdpxbDgcE/mPOG9iL0EaND9K0C
	Zs6Lre4BiI5XBAwlMp2/AP9f2Aiyz15Qjd1qz4+6aJZu83dKyIdTRBH3ng07lvm5uBcaLZ1IwD0
	UKdDXISlWuhBkDYS4VZ9n2klXNCt11/exB5hSWaiyBB1hG/Ej7r60dMxhXjZN7i2Lf5MVqvuUvQ
	qInK1M2Q6pHVqReOVQQcCZiNNdNWnqWyqs3aiNuh4Zr340Q==
X-Received: by 2002:a05:6214:808f:b0:87c:223c:c5c8 with SMTP id 6a1803df08f44-87c223cc6b8mr152673896d6.20.1761019821867;
        Mon, 20 Oct 2025 21:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdm2hwRLRcjdAJaN67gocvEQv/ytDjJvvxgQlCm7/W761K2ldQ2/8L5ftdru4g+9p/5t/b/A==
X-Received: by 2002:a05:6214:808f:b0:87c:223c:c5c8 with SMTP id 6a1803df08f44-87c223cc6b8mr152673626d6.20.1761019821460;
        Mon, 20 Oct 2025 21:10:21 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028af525sm62600596d6.51.2025.10.20.21.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 21:10:20 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0e02915f-bde7-4b04-b760-89f34fb0a436@redhat.com>
Date: Tue, 21 Oct 2025 00:10:16 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
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
 <20251013203146.10162-14-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-14-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
> CPUs passed through isolcpus= boot option. Users interested in also
> knowing the runtime defined isolated CPUs through cpuset must use
> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
>
> There are many drawbacks to that approach:
>
> 1) Most interested subsystems want to know about all isolated CPUs, not
>    just those defined on boot time.
>
> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
>    concurrent cpuset changes.
>
> 3) Further cpuset modifications are not propagated to subsystems
>
> Solve 1) and 2) and centralize all isolated CPUs within the
> HK_TYPE_DOMAIN housekeeping cpumask.
>
> Subsystems can rely on RCU to synchronize against concurrent changes.
>
> The propagation mentioned in 3) will be handled in further patches.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/sched/isolation.h |  2 +
>   kernel/cgroup/cpuset.c          |  2 +
>   kernel/sched/isolation.c        | 75 ++++++++++++++++++++++++++++++---
>   kernel/sched/sched.h            |  1 +
>   4 files changed, 74 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index da22b038942a..94d5c835121b 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -32,6 +32,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>   extern bool housekeeping_enabled(enum hk_type type);
>   extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +extern int housekeeping_update(struct cpumask *mask, enum hk_type type);
>   extern void __init housekeeping_init(void);
>   
>   #else
> @@ -59,6 +60,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   	return true;
>   }
>   
> +static inline int housekeeping_update(struct cpumask *mask, enum hk_type type) { return 0; }
>   static inline void housekeeping_init(void) { }
>   #endif /* CONFIG_CPU_ISOLATION */
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aa1ac7bcf2ea..b04a4242f2fa 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1403,6 +1403,8 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
>   
>   	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
>   	WARN_ON_ONCE(ret < 0);
> +	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
> +	WARN_ON_ONCE(ret < 0);
>   }
>   
>   /**
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index b46c20b5437f..95d69c2102f6 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
>   
>   bool housekeeping_enabled(enum hk_type type)
>   {
> -	return !!(housekeeping.flags & BIT(type));
> +	return !!(READ_ONCE(housekeeping.flags) & BIT(type));
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>   
> +static bool housekeeping_dereference_check(enum hk_type type)
> +{
> +	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
> +		/* Cpuset isn't even writable yet? */
> +		if (system_state <= SYSTEM_SCHEDULING)
> +			return true;
> +
> +		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
> +			return true;
> +
> +		/* Cpuset lock held, partitions not writable */
> +		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
> +			return true;

I have some doubt about this condition as the cpuset_mutex may be held 
in the process of making changes to an isolated partition that will 
impact HK_TYPE_DOMAIN cpumask.

Cheers,
Longman


