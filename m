Return-Path: <linux-pci+bounces-39710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C32C1CBF0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24D15836F7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C842F8BD9;
	Wed, 29 Oct 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzK6rvVX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F92261588
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761125; cv=none; b=kzRjeTWJfPJtUnoz0p36h69up/chuNhbowwbzI6sr9y2C2Ad2nUWz6oYjUGQVpcBlO0IygTg5Bocy4lF3KB/UxXvdg0R5A4hOqSdaNxnKQdYyp6JKWxkR9t5dnuLYaOEZOfoqm/mmmNPhLocBSX3FqY7ts8ftNwbei8ulQRogc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761125; c=relaxed/simple;
	bh=aab43vnKM1ss0I9X3ZkZ8BKt0Ft4cLo8wB19nB+wzAE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QtPLnkwTIM4TY6LFFBeydb19x0+o9+m+bj1yGZrV7K3KQBRVUFlDDuPpB4Te0B/ggZjDX/4aMbnJ3MXR/ro/xG7b6cNgL9l3MiEiw3nVp0BwNCH8kb/txgnrzu6xDdovv46rZ7J8E7UOVa/XH+eyh2NiHad8Kc8bHaRwsZWHqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzK6rvVX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761761122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNxXxUzXoqQQT9w5Yf9S20ddLNixsnFzdxWTN/CN8Uk=;
	b=CzK6rvVXkHLPs7sH+Hs7gaX+eOZgHfh505gYz7jLU19UnA6WTL5TNrE/vVDQwDy+Gg3b+w
	o+RaIoH53mI6VMFQfViqwYhri6xex71+J3fg2vyXMdasWSkM4QVvk0avDOzjcliKUeeadE
	OOLOTjlM3EoGxJBgSowNNFQtBRMBYOc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Fot2ApprPVK18AxPUno8NA-1; Wed, 29 Oct 2025 14:05:21 -0400
X-MC-Unique: Fot2ApprPVK18AxPUno8NA-1
X-Mimecast-MFC-AGG-ID: Fot2ApprPVK18AxPUno8NA_1761761120
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-890801794b9so35015185a.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761120; x=1762365920;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNxXxUzXoqQQT9w5Yf9S20ddLNixsnFzdxWTN/CN8Uk=;
        b=GkNoQTbLZewGEw+nWBFqzJ0GZVCWe0e+ZuIAKlOGFm4AXlgek/kmOWoc28CiTYZ/GU
         j54JUgBboKrNHxO4SggOZ1ClU21w4TuoDVhFgpNixvWxX1Sc4+GnlMh/IzZn9VdeeOGV
         AF4of5DDXxrrkwj56ebzJi4Ms7VJwgYQKtNPuPsjS59jGkdECqwy4UkQZFGeLBS+PQiZ
         RVLk3vgbrwVQWcVV4tbs6trEGRi4vYilc8/NePAhI17N9ubnzFdou+inNfK1f30RokLZ
         04wmhrJekdVk84T5kJHxxAHERgD/mBDyUQn3cE41p7Cx906wveRNfw/aruCPTpZ2V4Rl
         KM8w==
X-Forwarded-Encrypted: i=1; AJvYcCU1cRdS0cfBkuESlLyneamYV4WPM004BAWWvwiU0gO6vVZHKrauGyrhB+WGuteXtuglS+6DPBKQ/Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Mx337oomHpPSwgfQ1ky7sRue0V9n511diClH3Oa+/uPBODgL
	f3/10tnErf8rMN9zYdlTf0d7RaPXEGzTjBaAd7WjxgyJvh+kMexDm3bz+PAtPyUlBOCPi4RLdOe
	Dx5iNkvfcz9XmlInHykV/g16f5Zoz/xsuguS+8r5pCfqoqgqvWqs+lbAWLSc2JQ==
X-Gm-Gg: ASbGncsK6EP7yDfHb4/rsJcDtobG5bqX6NphGnzICduz1pQk2UNaOmrI3zMvJAWXqyj
	kOvleF9RlhNGp9BmvMcoyYmsg3S9qUl2NppMqoYiRNB1Fqs7bWznyxoVK5II+hVzfc83aGnpzFD
	XXd7BYFhqQC5hRTd09yMus75TcXACZEEcDAy22hOnU1kEph7byY47v+W5J0GvgLVexIo4FivhLI
	k78ru89yGfKPiPFxazBLrC5ihXfylEPBuLAKs/kpi/V6FFPdnQRQaqfX0amH3mU3LicXJkEIxBs
	5LxR460pt7K2eIy2/2TvuDHkUVup8bovmxaRRXjHyJChH+5wlbJiFxFNrzx+xOmV9R8xO40jM/K
	pXwm1R9c/h9TzTFbFL2x4mbmATSy2J3xOkTjj/MWaFlRMNw==
X-Received: by 2002:a05:620a:29cd:b0:8a6:92d1:2db5 with SMTP id af79cd13be357-8a8e473a6e6mr573645285a.24.1761761120507;
        Wed, 29 Oct 2025 11:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE6iTF4BqCkm725oJpB//2W/KjYfs5LBPrMdbtexGrXjP/dhJ17Z6sn/BKCKYXRH3K32fmkA==
X-Received: by 2002:a05:620a:29cd:b0:8a6:92d1:2db5 with SMTP id af79cd13be357-8a8e473a6e6mr573635985a.24.1761761119960;
        Wed, 29 Oct 2025 11:05:19 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421f6a5sm1111574885a.5.2025.10.29.11.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 11:05:19 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7821fb40-5082-4d11-b539-4c5abc2e572c@redhat.com>
Date: Wed, 29 Oct 2025 14:05:17 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] cpuset: Remove cpuset_cpu_is_isolated()
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
 <20251013203146.10162-19-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-19-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The set of cpuset isolated CPUs is now included in HK_TYPE_DOMAIN
> housekeeping cpumask. There is no usecase left interested in just
> checking what is isolated by cpuset and not by the isolcpus= kernel
> boot parameter.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/cpuset.h          |  6 ------
>   include/linux/sched/isolation.h |  3 +--
>   kernel/cgroup/cpuset.c          | 12 ------------
>   3 files changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 051d36fec578..a10775a4f702 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -78,7 +78,6 @@ extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> -extern bool cpuset_cpu_is_isolated(int cpu);
>   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>   #define cpuset_current_mems_allowed (current->mems_allowed)
>   void cpuset_init_current_mems_allowed(void);
> @@ -208,11 +207,6 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
>   	return false;
>   }
>   
> -static inline bool cpuset_cpu_is_isolated(int cpu)
> -{
> -	return false;
> -}
> -
>   static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
>   {
>   	return node_possible_map;
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 94d5c835121b..0f50c152cf68 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -76,8 +76,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   static inline bool cpu_is_isolated(int cpu)
>   {
>   	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
> -	       cpuset_cpu_is_isolated(cpu);
> +	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
>   }
>   

You can also remove the "<linux/cpuset.h>" include from isolation.h 
which was added by commit 3232e7aad11e5 ("cgroup/cpuset: Include 
isolated cpuset CPUs in cpu_is_isolated() check") which introduces 
cpuset_cpu_is_isolated().

Cheers,
Longman



