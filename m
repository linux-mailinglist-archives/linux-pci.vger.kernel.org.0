Return-Path: <linux-pci+bounces-38938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1681BF837C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC4619A79CA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5734A3AF;
	Tue, 21 Oct 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOetQZWr"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4E23815B
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074216; cv=none; b=s/O/8lQiabi6TrVrMJNmxkyRi3DmDPYy/mFXvb6i47zBc1bQbxkqgd/p5lhUphlYaqAAJJAMf/YAJ9sgdYzxVUsLR1dhXH1Icz+xCLOIr1asQ5d718bemTZegO2qwO3/mhuRKOSCzGQuL3faQOP+vQzmOQNOA8ZZjHHiWQBMsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074216; c=relaxed/simple;
	bh=WfFPtDMJOslnO8xd96RYBPFjxdDxPv7APLMtkSd5nII=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C0xXGNBJYKbqiYqt0cSsLHkartyIRaLu2UccjsU3dkAJNMUVPO0SLM3hQ1suJS6onbZZCfVkrRZZfCY6+J6jnchB0uz1ZUCITCEYxiUPCK2JkiYHdTwB5hEpDJgvQFoiBZjeT5hkEuCaUHv9sZAiffKFvrY4zZKSxLFBlJuRup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOetQZWr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761074214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av2zs3MEbcbLC7aMwacLFVSODjPRb5hpuHHxAZIybWo=;
	b=fOetQZWrqdnwAKsRVWEzaHukC2X7Bg/HFcDNqttp55v5Nod+YeSym7auuEzPAxurPr5zfm
	tLypG/W8i4LBN7kDJmis1AXqnzl/9RV6kPEqickeRGw/KhD+Tbyy9AfwshrBNtbjqI5OZO
	L2BQxvG50RH7kTdd5+1M9xC850aEmb0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-o1I3vGgOMDKT4Ft6Q6MDbQ-1; Tue, 21 Oct 2025 15:16:51 -0400
X-MC-Unique: o1I3vGgOMDKT4Ft6Q6MDbQ-1
X-Mimecast-MFC-AGG-ID: o1I3vGgOMDKT4Ft6Q6MDbQ_1761074211
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1cc5a75dso312149776d6.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074211; x=1761679011;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Av2zs3MEbcbLC7aMwacLFVSODjPRb5hpuHHxAZIybWo=;
        b=XyKpcggWZUOP2ByRH5/hQzVLkCvcQCysUuTa8JrNfazHZ/9sa0a/k48WHO/x5ztpwK
         iT65IwS/7eziU6lpm8WBcwUgn8kGMr/lYKxtjXOr1xA+9VlIFcdGBQzxipMjOuh9gQst
         EObNYoYI/yqcFlRTT6ZrYs6+gz7BySJWP0eS/aWlKV4mqFAbFuSSm9O6xgBD7kxUfF0G
         VjzLRMCttrmL9ehhhpSQWAeIRFd8M+jnB+UXYiyWNgK2/0JF65D9IppWI5ORKT66O6M5
         YnPEy1cKwvADSdQ7ANHaTKi/Lh1RYIB7IaJzvBwCGmmTKdO1Zn9qAuRW3kF7jBulF46F
         F+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXolhKMm/dtwJ3F87yxYbZxBY5OAze1+VpZhQe10/4HDJUncsPM2gkUBq92se5riIG4TcOWSQM+2Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbRtht/BBUgBBScfgdLAXJmuOVehH7rPrpp73DO+M3jWO1gbf
	LbNL9IrScgYBxR+a0pcSuSH9mnzwjSIUbQXo+f5Bare78zDQ3mV/HFzmeIdZiL38f8+4j1i8zbh
	gu7groH63bBr2ZoweyXpaMaW1eQsDRIdbZMlS2U/8RkMBM11lRu0GInj5bzQWJQ==
X-Gm-Gg: ASbGncubOhK7MClWyQLzstaQ+Abakgw25Ni/3TzdCfNXl7VXbpaKEikHa79z2cfXLHG
	svMSratLRWem5QD4I/QPjte/UWCptGJxxABO4OOAha/93tSCQDwjlEu4CPBfomNvfE/kGjHXTYt
	QPv47u89m+6fjW+SF7C00iuSjjorSt39sjvLQxlzrFKfGzrT8lvpzY+sPs0liRnOcB0MqHvPwQR
	PRri+PeZfIcFaoWK8zf4Ok+FV1dHb1EDe3NLSjQ8YyGPwkD/hI/VIUJQY4izgY8WXLZqJ0Ovuuw
	dh7UkDmF7XxUN2sp1zefO3l8XmbBzLRAfPwoqfUulNlKVz7TmO5cA7RgOrigndxA2HslZZJ2+mY
	I6hid2wxT5/BnLehxxKr14FjW+gSCW6Z5JePvLOZofz4foQ==
X-Received: by 2002:a05:6214:4012:b0:87d:8fa7:d29e with SMTP id 6a1803df08f44-87d8fa7d3a7mr172807816d6.35.1761074211066;
        Tue, 21 Oct 2025 12:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMN3DCL5z77zrF4an/kPQngsHh4Dl7HI0jLtCtPSfq0EP/4XoCKRGCEKlYnjWxZgcz1y0y9w==
X-Received: by 2002:a05:6214:4012:b0:87d:8fa7:d29e with SMTP id 6a1803df08f44-87d8fa7d3a7mr172807136d6.35.1761074210482;
        Tue, 21 Oct 2025 12:16:50 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521c2c7sm74369666d6.19.2025.10.21.12.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 12:16:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <364e084a-ef37-42ab-a2ae-5f103f1eb212@redhat.com>
Date: Tue, 21 Oct 2025 15:16:45 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] sched/isolation: Flush memcg workqueues on cpuset
 isolated partition change
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
 <20251013203146.10162-15-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-15-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
> order to synchronize against memcg workqueue to make sure that no
> asynchronous draining is still pending or executing on a newly made
> isolated CPU, the housekeeping susbsystem must flush the memcg
> workqueues.
>
> However the memcg workqueues can't be flushed easily since they are
> queued to the main per-CPU workqueue pool.
>
> Solve this with creating a memcg specific pool and provide and use the
> appropriate flushing API.
>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/memcontrol.h |  4 ++++
>   kernel/sched/isolation.c   |  2 ++
>   kernel/sched/sched.h       |  1 +
>   mm/memcontrol.c            | 12 +++++++++++-
>   4 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..001200df63cf 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1074,6 +1074,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
>   	return id;
>   }
>   
> +void mem_cgroup_flush_workqueue(void);
> +
>   extern int mem_cgroup_init(void);
>   #else /* CONFIG_MEMCG */
>   
> @@ -1481,6 +1483,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
>   	return 0;
>   }
>   
> +static inline void mem_cgroup_flush_workqueue(void) { }
> +
>   static inline int mem_cgroup_init(void) { return 0; }
>   #endif /* CONFIG_MEMCG */
>   
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 95d69c2102f6..9ec365dea921 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -144,6 +144,8 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
>   
>   	synchronize_rcu();
>   
> +	mem_cgroup_flush_workqueue();
> +
>   	kfree(old);
>   
>   	return 0;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8fac8aa451c6..8bfc0b4b133f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -44,6 +44,7 @@
>   #include <linux/lockdep_api.h>
>   #include <linux/lockdep.h>
>   #include <linux/memblock.h>
> +#include <linux/memcontrol.h>
>   #include <linux/minmax.h>
>   #include <linux/mm.h>
>   #include <linux/module.h>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1033e52ab6cf..1aa14e543f35 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -95,6 +95,8 @@ static bool cgroup_memory_nokmem __ro_after_init;
>   /* BPF memory accounting disabled? */
>   static bool cgroup_memory_nobpf __ro_after_init;
>   
> +static struct workqueue_struct *memcg_wq __ro_after_init;
> +
>   static struct kmem_cache *memcg_cachep;
>   static struct kmem_cache *memcg_pn_cachep;
>   
> @@ -1975,7 +1977,7 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>   {
>   	guard(rcu)();
>   	if (!cpu_is_isolated(cpu))
> -		schedule_work_on(cpu, work);
> +		queue_work_on(cpu, memcg_wq, work);
>   }
>   
>   /*
> @@ -5092,6 +5094,11 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
>   	refill_stock(memcg, nr_pages);
>   }
>   
> +void mem_cgroup_flush_workqueue(void)
> +{
> +	flush_workqueue(memcg_wq);
> +}
> +
>   static int __init cgroup_memory(char *s)
>   {
>   	char *token;
> @@ -5134,6 +5141,9 @@ int __init mem_cgroup_init(void)
>   	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
>   				  memcg_hotplug_cpu_dead);
>   
> +	memcg_wq = alloc_workqueue("memcg", 0, 0);

Should we explicitly mark the memcg_wq as WQ_PERCPU even though I think 
percpu is the default. The schedule_work_on() schedules work on the 
system_percpu_wq.

Cheers,
Longman

> +	WARN_ON(!memcg_wq);
> +
>   	for_each_possible_cpu(cpu) {
>   		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
>   			  drain_local_memcg_stock);


