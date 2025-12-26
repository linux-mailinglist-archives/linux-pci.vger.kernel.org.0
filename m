Return-Path: <linux-pci+bounces-43747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBACDF1ED
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 00:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0674B3007616
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C02264B8;
	Fri, 26 Dec 2025 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKwYdPMq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckdywsSY"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFB33993
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766792773; cv=none; b=WRq0RUeDlJefx5bL0/wa957pFb0enSoWZTYtCHZuVRrwOHtfrjqIX75rN2WIFZX+9HpQwkJ/tK0S9rIda3GGtdxzTF3rmjcn6pY2g9uTRPERQyUTab5kXvi4yeJqRZfKM7x8fF9maixZosGlSonCM1VKUbOKYeExtHmX3Gp3BdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766792773; c=relaxed/simple;
	bh=0v3xmUYZaueJUsk7e1yfwE8JR+n/4CdwFxRmBxTEGsA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H8ZUAcx+DNGEZ3a+zkCaZ7hoXg/w0sSr1HQnaf9KwvPy4Y+O97bcCzMcDLO7tZsEY9ocRyF7qt10I5zItEYfHLycL/ayPeVwSVQ8T/duvPbnMMVRBceQkJX1LAHpNqJdJnLPYNgbDSFHlUTnGqSjpoIu2KeaKwlObrZtVFuHSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKwYdPMq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckdywsSY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766792770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShTe7n4oL4bSFMstIf8qKgFQ8pgH2Te4INGSKID7CCk=;
	b=cKwYdPMqZ2MM+yIjTgjpTd1iSU1wPS9Culb5UI23RoeP5XUVQPkxFHgpgSgAOsybtztsNI
	LcXko/ZhqI5Vgef6/QqhcJ7X3YtojNdxb0dTHtRKrVmN6RTuI54MbG1JGoUXxaUXD9hlV0
	eKeI4vIwHxmxl5br/d88JMfCBaVK9/g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-zyuvXee8Pi2eBBePpMcB5A-1; Fri, 26 Dec 2025 18:46:08 -0500
X-MC-Unique: zyuvXee8Pi2eBBePpMcB5A-1
X-Mimecast-MFC-AGG-ID: zyuvXee8Pi2eBBePpMcB5A_1766792768
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a47331c39so201028436d6.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 15:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766792768; x=1767397568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ShTe7n4oL4bSFMstIf8qKgFQ8pgH2Te4INGSKID7CCk=;
        b=ckdywsSY//9wN5RWAh9nIX4rLdJriDENrU/gJ3OW5OX6ZnOuvMOOJCrDGPQnZ4cw5O
         PM4V8PoBO/nbtAawDVcwWwAfac6dFiC6exIAvZYy+ZANOhRD+BfjmvuxqGSZVayOd/oj
         +VQoZHkas/RDmOOxu9+Tx3wt0QE59lwC6cvFekLl5VHkvKSS7uBd4w3wKn+A1l92hJky
         yqaQCpSxum4zLvK2jE1fritizNhA+cqfSn1eyIvKo4RTJiBemt3R2IBqKtSrRrrUW+4v
         u7AxcWlMSXCj0B5UpnOw5unvL54oJz+8rryOFpFRy95Nv/7vml3TaHK4pAVaJBjs7AhU
         hqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766792768; x=1767397568;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShTe7n4oL4bSFMstIf8qKgFQ8pgH2Te4INGSKID7CCk=;
        b=sY94wFkLhju558Hg/b1nZi5EulxCSTjUf6hxXlPUxriskJzW1xvs6JKrdGAFqUjgl0
         ObfWDMvv1KzSkp2AFxXu2HIJEkSvS0sbZM4Mfm2ZXaOtoX9P2ot3ixGoQglpCVJvH8Z2
         UaaWQCKvRqcvgcU2LXHZQ5oL0oyHLAzsC/ZBuNGaCvCzY1LqUvsTHVT0lQ5zagtdB8u6
         AZsxdsMurazmQZp/HfD7/0bgHJn1W2qPlyswOX0v0PDeh3trRWw0FmyQ2Mnexad7SG61
         i65as9pqVd3F4OfA/2Kpohr9Zn8lP5eik9Bbtau+uPM9OsQSOwqqyNaH6EnF71sr2i2F
         Pyvg==
X-Forwarded-Encrypted: i=1; AJvYcCU4G9xXsReGLBRwm/KU9QJH2JwPSeP0ofUtZbVTR0Cd1PNvm5bq5PqhDyIQd0gWMbP5YzxJRmh3bzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+KGa13ANTxpuGEqOHpPffX28tEdp5Uiqxg6jLvnFoXgxIik40
	BMztM2EXU0J13CpfrMC139cd09dDIk5vm4QwdE2XH6/vvP6rCHCh9VmVXuxmEN5ACmRwxjOophn
	x7Mqri21j/BCHD7SRW5lVO4BFyLMw1RLfMKsAbvIL/KnaDN4kU9lclOWuRgNbpw==
X-Gm-Gg: AY/fxX4dh5BCUzsRRFNBQv8FdX8q8cbXBY01zg0KgxpLA2Ftc0xd0MbbeqAvjoNfBTH
	wW/MV7mt1dLjEiTRIhwjpkPmge/UJxDXM+GkpwbaeYyyyjC67JCBGUnyz+gu0kusw38UA4wroQY
	2YzYkjyDzHsoYr2YtwkakQNz967h4tFnlK0moRdwtUSLKDFWlIZatiFLBR6g6F9VbOolge8rDlz
	WtvSw8oejNeiPGx9SIZaTZmrVDAlZ2SDjD3Dd9ei8hX35hXdEEXUg5LgQ77LEaCBWF4Dmgs7U/C
	RgmD47LM9zNRFdLaLCLLSFaEAL2SKCz2dT9ae+pxOVmWHuTJTpnIQdm17iY8wiiNoGFFWjGnkfe
	yavTRhKHYCVLXFfWaG3l8ZnQn2NhfVhIrz3IeMLV4Y0TYZ+SMvsMG3S3v
X-Received: by 2002:a0c:d783:0:b0:88a:28b0:9192 with SMTP id 6a1803df08f44-88d8379509fmr260894056d6.33.1766792768270;
        Fri, 26 Dec 2025 15:46:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI+6C/nsqBk+pm7eqUDmS5eTPjEpCYiybmbNsgHAySbpZ0KGnAPETFvs9s0xhCfd6CKDIFSA==
X-Received: by 2002:a0c:d783:0:b0:88a:28b0:9192 with SMTP id 6a1803df08f44-88d8379509fmr260893766d6.33.1766792767734;
        Fri, 26 Dec 2025 15:46:07 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aedafsm176932106d6.31.2025.12.26.15.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 15:46:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <19b001a4-0696-4efd-aaa3-902ffa42ff9e@redhat.com>
Date: Fri, 26 Dec 2025 18:46:02 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/33] sched/arm64: Move fallback task cpumask to
 HK_TYPE_DOMAIN
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
 <20251224134520.33231-30-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-30-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> When none of the allowed CPUs of a task are online, it gets migrated
> to the fallback cpumask which is all the non nohz_full CPUs.
>
> However just like nohz_full CPUs, domain isolated CPUs don't want to be
> disturbed by tasks that have lost their CPU affinities.
>
> And since nohz_full rely on domain isolation to work correctly, the
> housekeeping mask of domain isolated CPUs should always be a superset of
> the housekeeping mask of nohz_full CPUs (there can be CPUs that are
> domain isolated but not nohz_full, OTOH there shouldn't be nohz_full
> CPUs that are not domain isolated):
>
> 	HK_TYPE_DOMAIN | HK_TYPE_KERNEL_NOISE == HK_TYPE_DOMAIN
>
> Therefore use HK_TYPE_DOMAIN as the appropriate fallback target for
> tasks and since this cpumask can be modified at runtime, make sure
> that 32 bits support CPUs on ARM64 mismatched systems are not isolated
> by cpusets.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   arch/arm64/kernel/cpufeature.c | 18 +++++++++++++++---
>   include/linux/cpu.h            |  4 ++++
>   kernel/cgroup/cpuset.c         | 17 ++++++++++++++---
>   3 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c840a93b9ef9..70b0e45e299a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1656,6 +1656,18 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
>   	return feature_matches(val, entry);
>   }
>   
> +/*
> + * 32 bits support CPUs can't be isolated because tasks may be
> + * arbitrarily affine to them, defeating the purpose of isolation.
> + */
> +bool arch_isolated_cpus_can_update(struct cpumask *new_cpus)
> +{
> +	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
> +		return !cpumask_intersects(cpu_32bit_el0_mask, new_cpus);
> +	else
> +		return true;
> +}
> +
>   const struct cpumask *system_32bit_el0_cpumask(void)
>   {
>   	if (!system_supports_32bit_el0())
> @@ -1669,7 +1681,7 @@ const struct cpumask *system_32bit_el0_cpumask(void)
>   
>   const struct cpumask *task_cpu_fallback_mask(struct task_struct *p)
>   {
> -	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_TICK));
> +	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_DOMAIN));
>   }
>   
>   static int __init parse_32bit_el0_param(char *str)
> @@ -3987,8 +3999,8 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
>   	bool cpu_32bit = false;
>   
>   	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
> -		if (!housekeeping_cpu(cpu, HK_TYPE_TICK))
> -			pr_info("Treating adaptive-ticks CPU %u as 64-bit only\n", cpu);
> +		if (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN))
> +			pr_info("Treating domain isolated CPU %u as 64-bit only\n", cpu);
>   		else
>   			cpu_32bit = true;
>   	}
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 487b3bf2e1ea..0b48af25ab5c 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -229,4 +229,8 @@ static inline bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v)
>   #define smt_mitigations SMT_MITIGATIONS_OFF
>   #endif
>   
> +struct cpumask;
> +
> +bool arch_isolated_cpus_can_update(struct cpumask *new_cpus);
> +
>   #endif /* _LINUX_CPU_H_ */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index cd6119c02beb..1cc83a3c25f6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1408,14 +1408,22 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
>   	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
>   }
>   
> +bool __weak arch_isolated_cpus_can_update(struct cpumask *new_cpus)
> +{
> +	return true;
> +}
> +
>   /*
> - * isolated_cpus_can_update - check for isolated & nohz_full conflicts
> + * isolated_cpus_can_update - check for conflicts against housekeeping and
> + *                            CPUs capabilities.
>    * @add_cpus: cpu mask for cpus that are going to be isolated
>    * @del_cpus: cpu mask for cpus that are no longer isolated, can be NULL
>    * Return: false if there is conflict, true otherwise
>    *
> - * If nohz_full is enabled and we have isolated CPUs, their combination must
> - * still leave housekeeping CPUs.
> + * Check for conflicts:
> + * - If nohz_full is enabled and there are isolated CPUs, their combination must
> + *   still leave housekeeping CPUs.
> + * - Architecture has CPU capabilities incompatible with being isolated
>    *
>    * TBD: Should consider merging this function into
>    *      prstate_housekeeping_conflict().
> @@ -1426,6 +1434,9 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
>   	cpumask_var_t full_hk_cpus;
>   	int res = true;
>   
> +	if (!arch_isolated_cpus_can_update(add_cpus))
> +		return false;
> +
>   	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
>   		return true;
>   
Reviewed-by: Waiman Long <longman@redhat.com>


