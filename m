Return-Path: <linux-pci+bounces-43730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9DCDEFBF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 21:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31E39300C0D6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FFC2857F1;
	Fri, 26 Dec 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWXKu/Y9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5gRcwVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6C128816
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766781098; cv=none; b=a3868Ozdy1YcoqFzzZ8JJQ3Og2ZTV4kV+5T85JQVwmUVsp8tiWpo5FJZkW/tLU0fotegVFX8YZcaPqyy5rAXKLJW0SQgGaY+/V+IY/bGEOkvG9KFHiUqUJJ50nEUwBWUqy5yk7WjaPABjsJb0MeVn3KimGa8eEMbCpoUp00WQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766781098; c=relaxed/simple;
	bh=DgzMo+TzwckbGrVo4bke0QnFTjGI9tNbb9d6/VfjWyw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=glB4IP/aoAFHBkj6vGmTe5FHvdVeplyntgfyVNnnWK9UHdz8gGzlqZDQNzDEkvuRXpVE4YaZMVKxX1UTLsU5BviNH9sqx+pf1YF5hIw4sPW78V5UrIkrLi0dcdzLe8mA8uBGmlVM4gkktnaIjkPa75z1qtvt+7MfwVwcEtNBGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWXKu/Y9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5gRcwVV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766781095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4Pa3h61jDk0Wr5hXqPBHwFAVT2TML944c0BxtSWzHU=;
	b=RWXKu/Y9W8D4LntEoXwgv89QOeggZ6JD8fpTQwOsg8Bdvf7hx2Z6MldAJ3z1hGZKBZn5u+
	GmY2gQzEr9mzfRAZegJ1cw+f5qh5wM+5zAnyjBvV6Vk2sMGG2/Q2KtuY5iwz+WBVO4Bb2Y
	raqkoPMBzFeN/5vcbPxcNMALZ0PFNMg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-XylIgvWGNh2RzwtqmaBMdQ-1; Fri, 26 Dec 2025 15:31:34 -0500
X-MC-Unique: XylIgvWGNh2RzwtqmaBMdQ-1
X-Mimecast-MFC-AGG-ID: XylIgvWGNh2RzwtqmaBMdQ_1766781093
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bb6a7fea4dso1708962085a.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 12:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766781093; x=1767385893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w4Pa3h61jDk0Wr5hXqPBHwFAVT2TML944c0BxtSWzHU=;
        b=S5gRcwVVKYh+lZDXd0wl1/TFQ1cz2oTitCcmMfy1tJJ7/BycJxASVo2hLt9Q5fRs9E
         pubrNJXR+aTZ7x+Duz/lSKq5QNPu+kTmIkzMctgzXCj5NACGZFeIts1nFbhuMRtFIMdd
         qE//pQpmgD/wzHh2w1iBYzFTEMXRxBglQBhuLKJSP5STMvmAaRYP7//wPrMeXRNuiJ+3
         7rWvTJ8Iq4rw+xu7DBs8G1wTxG5BUVY7sH8qfpVy7xxg5lJtYzrsj+F2jwsz8YJc0KBZ
         ofaRAf3iANYFr53E/4IK4BtQglY1m1uG02wGJ0dPlnnAi2YJT1tR2c5SNbY89pFrPnUP
         Zjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766781093; x=1767385893;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4Pa3h61jDk0Wr5hXqPBHwFAVT2TML944c0BxtSWzHU=;
        b=feQqztL1fdj/1XIEtC3tQSH6qoJfc1DI0XSAMqgZRH51CUd6NU7FbKIJBr3Sl+WdRD
         Ywkrn7fnIBAxRNvvXAel8y85mm8nUlwJsw4fDe5Lfxeh6L6Dw4gvMKfL24S1Q+TKdNQV
         6aP7pOhlZ28fsYdFlbWpfSR9eFCOvwW4Nu5uiGOyPj7sTbXx26IYvxpd8dJPH/oHnT+i
         mmYyXtMMk2/M4lCQtyMjfxd2Ce6mSJb27WUp4ptawUIJoO5h1rB15ifdmxdI6GKx0qJw
         1klgoVLi6cuxtp8e28Pq5KRu1pVlDTIsTiHVvfqbUtjce73rv5eA4z2vRTV4GvpUPr4S
         mVUA==
X-Forwarded-Encrypted: i=1; AJvYcCUbHwtMIRNGATT3zp9aLsRGTjjNEvUt72qvLzUX6UD9y/npHdTw/lqBvQKIwD7mnK07qyWoVz6TGnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjV6qYdXveP3k6uWIAazMaQu6eal64Saq1eo00+UNRLW3FOrUY
	CcheIbfbl7G8sTMaNWBCGCfd+jDI86qPJ10JaMwrJwvDCLKnm7+IV+sDhr/nFm5rsrCPgy63UAf
	XZ3rIRcwmZCm65FzEdqmag54I/ejQ1kz20Q+9YOLe7jeIobwnEhhuLmF/mJt/Ww==
X-Gm-Gg: AY/fxX7HiSsDiLssNFI4qsnYLzwyZhhZYbRpQvk6kZKGooG+wCSJ4ezmNkWsXc8x+c1
	0gERiYlte+TWfBRXqPbS9ytwMttTlPb/1IoYwWqtX/PSZZP8cIm4MCuYi6y00Xhe2hnUrUMl+VY
	hFyCUEgOn5vw1bCaoVDBqFuTqzfcR44bkd5S1JbaXzo3c6vDk4Aekw64zy163WjkD86CZFyhuO7
	XI4RepIPs+5DpPKGb3jzB6lhDtKoKWrs8yxHdENrXm+Q+yJlr0bc+4uAwu8gaRRvTb/g1frNd8+
	zhfLqA9ZwkhWx/yVqmEGjGzeMbVm+YhrkWK5L2f0CAP6ggE5sOYRfICtsnxgqc73JsmKjrfokf4
	eF9te/BFIDc1FDCBApFA/cj9Wr5N+c7pCiFFhlMrDl5RAHx+WZeFb+pjP
X-Received: by 2002:a05:620a:269c:b0:8c0:d341:9cef with SMTP id af79cd13be357-8c0d341a826mr2546755285a.73.1766781093467;
        Fri, 26 Dec 2025 12:31:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNP3JRzuVA9e5lA05jSGh3cLVd3H4bpw8DYevvFoq9EfnIojwqlL0tzjDHUY8cAliBoVsvtA==
X-Received: by 2002:a05:620a:269c:b0:8c0:d341:9cef with SMTP id af79cd13be357-8c0d341a826mr2546753385a.73.1766781092994;
        Fri, 26 Dec 2025 12:31:32 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fa6sm1797460785a.28.2025.12.26.12.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 12:31:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a9aa92b5-5e5a-4e9f-bfa3-31033d190457@redhat.com>
Date: Fri, 26 Dec 2025 15:31:26 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] cpuset: Propagate cpuset isolation update to
 workqueue through housekeeping
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
 <20251224134520.33231-19-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-19-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Until now, cpuset would propagate isolated partition changes to
> workqueues so that unbound workers get properly reaffined.
>
> Since housekeeping now centralizes, synchronize and propagates isolation
> cpumask changes, perform the work from that subsystem for consolidation
> and consistency purposes.
>
> For simplification purpose, the target function is adapted to take the
> new housekeeping mask instead of the isolated mask.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/workqueue.h |  2 +-
>   init/Kconfig              |  1 +
>   kernel/cgroup/cpuset.c    |  9 +++------
>   kernel/sched/isolation.c  |  4 +++-
>   kernel/workqueue.c        | 17 ++++++++++-------
>   5 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index dabc351cc127..a4749f56398f 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -588,7 +588,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void);
>   void free_workqueue_attrs(struct workqueue_attrs *attrs);
>   int apply_workqueue_attrs(struct workqueue_struct *wq,
>   			  const struct workqueue_attrs *attrs);
> -extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
> +extern int workqueue_unbound_housekeeping_update(const struct cpumask *hk);
>   
>   extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
>   			struct work_struct *work);
> diff --git a/init/Kconfig b/init/Kconfig
> index fa79feb8fe57..518830fb812f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1254,6 +1254,7 @@ config CPUSETS
>   	bool "Cpuset controller"
>   	depends on SMP
>   	select UNION_FIND
> +	select CPU_ISOLATION
>   	help
>   	  This option will let you create and manage CPUSETs which
>   	  allow dynamically partitioning a system into sets of CPUs and
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e13e32491ebf..a492d23dd622 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1484,15 +1484,12 @@ static void update_isolation_cpumasks(void)
>   
>   	lockdep_assert_cpus_held();
>   
> -	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
> -	WARN_ON_ONCE(ret < 0);
> -
> -	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
> -	WARN_ON_ONCE(ret < 0);
> -
>   	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
>   	WARN_ON_ONCE(ret < 0);
>   
> +	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
> +	WARN_ON_ONCE(ret < 0);
> +
>   	isolated_cpus_updating = false;
>   }
>   
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 7dbe037ea8df..d224bca299ed 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -121,6 +121,7 @@ EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>   int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
>   {
>   	struct cpumask *trial, *old = NULL;
> +	int err;
>   
>   	if (type != HK_TYPE_DOMAIN)
>   		return -ENOTSUPP;
> @@ -149,10 +150,11 @@ int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
>   	pci_probe_flush_workqueue();
>   	mem_cgroup_flush_workqueue();
>   	vmstat_flush_workqueue();
> +	err = workqueue_unbound_housekeeping_update(housekeeping_cpumask(type));
>   
>   	kfree(old);
>   
> -	return 0;
> +	return err;
>   }
>   
>   void __init housekeeping_init(void)
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 253311af47c6..eb5660013222 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -6959,13 +6959,16 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
>   }
>   
>   /**
> - * workqueue_unbound_exclude_cpumask - Exclude given CPUs from unbound cpumask
> - * @exclude_cpumask: the cpumask to be excluded from wq_unbound_cpumask
> + * workqueue_unbound_housekeeping_update - Propagate housekeeping cpumask update
> + * @hk: the new housekeeping cpumask
>    *
> - * This function can be called from cpuset code to provide a set of isolated
> - * CPUs that should be excluded from wq_unbound_cpumask.
> + * Update the unbound workqueue cpumask on top of the new housekeeping cpumask such
> + * that the effective unbound affinity is the intersection of the new housekeeping
> + * with the requested affinity set via nohz_full=/isolcpus= or sysfs.
> + *
> + * Return: 0 on success and -errno on failure.
>    */
> -int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
> +int workqueue_unbound_housekeeping_update(const struct cpumask *hk)
>   {
>   	cpumask_var_t cpumask;
>   	int ret = 0;
> @@ -6981,14 +6984,14 @@ int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
>   	 * (HK_TYPE_WQ ∩ HK_TYPE_DOMAIN) house keeping mask and rewritten
>   	 * by any subsequent write to workqueue/cpumask sysfs file.
>   	 */
> -	if (!cpumask_andnot(cpumask, wq_requested_unbound_cpumask, exclude_cpumask))
> +	if (!cpumask_and(cpumask, wq_requested_unbound_cpumask, hk))
>   		cpumask_copy(cpumask, wq_requested_unbound_cpumask);
>   	if (!cpumask_equal(cpumask, wq_unbound_cpumask))
>   		ret = workqueue_apply_unbound_cpumask(cpumask);
>   
>   	/* Save the current isolated cpumask & export it via sysfs */
>   	if (!ret)
> -		cpumask_copy(wq_isolated_cpumask, exclude_cpumask);
> +		cpumask_andnot(wq_isolated_cpumask, cpu_possible_mask, hk);
>   
>   	mutex_unlock(&wq_pool_mutex);
>   	free_cpumask_var(cpumask);
Reviewed-by: Waiman Long <longman@redhat.com>


