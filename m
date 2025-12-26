Return-Path: <linux-pci+bounces-43739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED3CDF12C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D4C300CBA1
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 22:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD7279DB6;
	Fri, 26 Dec 2025 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmuGXbKl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPbIAMey"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693878F20
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787097; cv=none; b=AvVZIAcSooCsWBNClzuwimv2Svf0xEiRZT9lR9z9mAY6slPQmvIMIUT2EQjIUgJgmJ6II3CaaDtnCHgB0LpW8MHr8XlAIqYEQZ+c9fsicRNEnFnizeNfx0eMVNtI7f1obqfhTHadKt9XZARcGHrdwoKNbWhetErQKVYHJq1Fh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787097; c=relaxed/simple;
	bh=R9tnImEFZzIwnpkj2WDVfVzgbrkCYG/lZwE4VsztwgI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hKJft+k/8ICqFTWIFxR+kyvdjUy4SfUGvSch6rJtT2do/kwyOnLOQe7B8sEOPHLsfdAyvvPcqZVHbStcPNTNcswaY7+QBttyVvBAG8tKVj6tQiv4E3GklDLSVzLf0IsjZHy3dBiUlYjiUgbRQPrm5HTtFh2ONGDl7+ESVvBXoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmuGXbKl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPbIAMey; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766787094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
	b=NmuGXbKl1ddvCuhKhxYwRYtD+C4NAzkzwuBr/1DcPLAc4jjeTMZppqy2rfz5esB7I1riKM
	4m6yKfs54E9JSGnMou1Qhod0XJ2kO/y4t4L9UJImTE8DtXprSQDXMRDRykFlcHbuMiia3n
	QgFVX8jLgXZekhhbVAMjOIsqb9EbEjg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-krf4chCSOZKazC7vsI205w-1; Fri, 26 Dec 2025 17:11:33 -0500
X-MC-Unique: krf4chCSOZKazC7vsI205w-1
X-Mimecast-MFC-AGG-ID: krf4chCSOZKazC7vsI205w_1766787093
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f183e4cc7bso140246301cf.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 14:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766787093; x=1767391893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
        b=tPbIAMey/ZNz5LMg4o4DgE1ev5QvyeU+UomcG6YLkSsjPKqS/yy3nhIx1PkE2q0JjB
         ImnKfNT/43YFo/M3rKRXAcgRJAghtaOEtd7jxE3X/RVxSkOabgUgDb4mOiS3AHEVwBXe
         sXkxwX6qnunybW5GxPAnx/I/4KqYtp7R4SmbarrGU8D+Rgb7sAx8fUiz2g5jZPWm93N1
         Ij8Kv1K8Lm7xxEKUBCJqlZ+sDZ4gYH8gtdJt1im5lKNIPl7NmJeBeZKc3KqZjevcGNaH
         CDTWrNrVcim8MP4eIxG1BKFmv39Nq/vDA3hVOIc++cwauM5feqWB8Lnvk4v0+3rcrYr0
         KKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766787093; x=1767391893;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
        b=Ffa6gxMP/2lJXnatdkkgxY4lkLP/2SHmCr5FAJHMgwK7rgy3mv68+zno0ulsRoWVX2
         zMq40MBnS6rjoVdNX/oFDVY0c8JQet6cSAuyrfGG0uUBjnlehY2WPnA7P+cDNN+/3LQG
         k90fb/Xafi2znan7U4eEi26lht3ckIG2t78GSC55maqi5kgGbVSWvdYUD/3i38NkYYj6
         uhNwSCQOebdP3MIVmcWF0V8NkvZIkeOetos9+yZKvcfF3zhLDL9JXi4tH8hvu8EA2pbZ
         fuZHx83ut7W3KetuUGPSRAVl/699WGGkhRLIrFQKkkmwZ4lEvNVVnNzPm8lWviHeAKdX
         0+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwJciwKYyDFZmI1IrWUSnlfmIYHrtbFcKAmHZBuelEeDRUF+uooHR2Oi5l01sSGz7wdYXaoQYvVq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/l7YJLzJxZ0LkW3XnM4IFU4Gl0Z8v14jyowu/3HTjQfpje+4
	TQ3ZUQgQ4Bw2AtvqmkNNtpQmAWYrjOTP6PQndf2wrQTMos5x/U8tL9IoJ9kx8vXhp0jNsNQRGEI
	Qbbha5GmjGF/uX8CfQrJiYkzzT0diuJ6y9iYKuQPhC6YYnUetZvAzHjFPczRMzw==
X-Gm-Gg: AY/fxX6uRlNYCI26vmlyrwQmWvnq/uxqCikXgUOGf53Se5jiRZUUJYgu9djvaLpk7ic
	Z6l/XX9l+Vk7upV4kCu46cmpffXMtT7villwyDeWdhhaRpS+VsxzXixKzP2ojyJwUzjlFN0vBVm
	jEHfAGy8KKG7VBI/cl7tQML/G1oS3MzOcwHtWgIFh+BJ5RLTpaXrY48lig+FmaoeUSC1d/dD/y1
	ZEM58RVY7kmrCFYkqt3OnrXxHycnVrFr7fqwhUBwZ9AzeEomSogdghwcsxpbFvce55TtlGkFbsQ
	UcEjOYBBe+0MPKay8EDx+hbNhZJz8HJDr7hGSBqTuXFP702InM16KHLpzr+3KIK32Zufc5VgnUu
	doZRmtuhIsoEE4kN6d6xFTSD5ebrL5qt9i/lLUcoTx7UcP/JOfYSQJ2Q3
X-Received: by 2002:a05:622a:4a09:b0:4ee:2510:198a with SMTP id d75a77b69052e-4f4abd75629mr345582921cf.39.1766787092693;
        Fri, 26 Dec 2025 14:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfAC0mMAvBMTtIg0HnYR5V/3qz64S5XCvmCWe5yr1a0y1ZiMQUT11GI7YF+lRu7HFhzwx/CQ==
X-Received: by 2002:a05:622a:4a09:b0:4ee:2510:198a with SMTP id d75a77b69052e-4f4abd75629mr345581701cf.39.1766787091473;
        Fri, 26 Dec 2025 14:11:31 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fd37sm176347436d6.3.2025.12.26.14.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 14:11:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1e530c72-75d7-4c7e-96e7-329056d6baf5@redhat.com>
Date: Fri, 26 Dec 2025 17:11:26 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/33] kthread: Include unbound kthreads in the managed
 affinity list
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
 <20251224134520.33231-26-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-26-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> The managed affinity list currently contains only unbound kthreads that
> have affinity preferences. Unbound kthreads globally affine by default
> are outside of the list because their affinity is automatically managed
> by the scheduler (through the fallback housekeeping mask) and by cpuset.
>
> However in order to preserve the preferred affinity of kthreads, cpuset
> will delegate the isolated partition update propagation to the
> housekeeping and kthread code.
>
> Prepare for that with including all unbound kthreads in the managed
> affinity list.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 70 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f1e4f1f35cae..51c0908d3d02 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -365,9 +365,10 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
>   	if (kthread->preferred_affinity) {
>   		pref = kthread->preferred_affinity;
>   	} else {
> -		if (WARN_ON_ONCE(kthread->node == NUMA_NO_NODE))
> -			return;
> -		pref = cpumask_of_node(kthread->node);
> +		if (kthread->node == NUMA_NO_NODE)
> +			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
> +		else
> +			pref = cpumask_of_node(kthread->node);
>   	}
>   
>   	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
> @@ -380,32 +381,29 @@ static void kthread_affine_node(void)
>   	struct kthread *kthread = to_kthread(current);
>   	cpumask_var_t affinity;
>   
> -	WARN_ON_ONCE(kthread_is_per_cpu(current));
> +	if (WARN_ON_ONCE(kthread_is_per_cpu(current)))
> +		return;
>   
> -	if (kthread->node == NUMA_NO_NODE) {
> -		housekeeping_affine(current, HK_TYPE_KTHREAD);
> -	} else {
> -		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> -			WARN_ON_ONCE(1);
> -			return;
> -		}
> -
> -		mutex_lock(&kthread_affinity_lock);
> -		WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> -		list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> -		/*
> -		 * The node cpumask is racy when read from kthread() but:
> -		 * - a racing CPU going down will either fail on the subsequent
> -		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> -		 *   afterwards by the scheduler.
> -		 * - a racing CPU going up will be handled by kthreads_online_cpu()
> -		 */
> -		kthread_fetch_affinity(kthread, affinity);
> -		set_cpus_allowed_ptr(current, affinity);
> -		mutex_unlock(&kthread_affinity_lock);
> -
> -		free_cpumask_var(affinity);
> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> +		WARN_ON_ONCE(1);
> +		return;
>   	}
> +
> +	mutex_lock(&kthread_affinity_lock);
> +	WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> +	list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> +	/*
> +	 * The node cpumask is racy when read from kthread() but:
> +	 * - a racing CPU going down will either fail on the subsequent
> +	 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> +	 *   afterwards by the scheduler.
> +	 * - a racing CPU going up will be handled by kthreads_online_cpu()
> +	 */
> +	kthread_fetch_affinity(kthread, affinity);
> +	set_cpus_allowed_ptr(current, affinity);
> +	mutex_unlock(&kthread_affinity_lock);
> +
> +	free_cpumask_var(affinity);
>   }
>   
>   static int kthread(void *_create)
> @@ -919,8 +917,22 @@ static int kthreads_online_cpu(unsigned int cpu)
>   			ret = -EINVAL;
>   			continue;
>   		}
> -		kthread_fetch_affinity(k, affinity);
> -		set_cpus_allowed_ptr(k->task, affinity);
> +
> +		/*
> +		 * Unbound kthreads without preferred affinity are already affine
> +		 * to housekeeping, whether those CPUs are online or not. So no need
> +		 * to handle newly online CPUs for them.
> +		 *
> +		 * But kthreads with a preferred affinity or node are different:
> +		 * if none of their preferred CPUs are online and part of
> +		 * housekeeping at the same time, they must be affine to housekeeping.
> +		 * But as soon as one of their preferred CPU becomes online, they must
> +		 * be affine to them.
> +		 */
> +		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> +			kthread_fetch_affinity(k, affinity);
> +			set_cpus_allowed_ptr(k->task, affinity);
> +		}
>   	}
>   
>   	free_cpumask_var(affinity);
Reviewed-by: Waiman Long <longman@redhat.com>


