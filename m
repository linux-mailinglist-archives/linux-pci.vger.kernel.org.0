Return-Path: <linux-pci+bounces-43717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D472CDE227
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 23:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2B0F3000EB2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916D2BE644;
	Thu, 25 Dec 2025 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3SB6ibX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBq+4AV6"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B623315A
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766701873; cv=none; b=i9aZ0bI5nymNxMFEKi7/5JcDF9Q962t2khtUjZfzspCCU1/1OkcEDp1gFGDoOVCYPwUvhXdf6rqczzEPpRBINP/NUakkDUvhmPkdHChe+Ou1u58XH70j3RJzHvPCaIQ1lEdtR1c8IQYgTDfuA8Yt3BAqcCJKnh8ME36OydIgiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766701873; c=relaxed/simple;
	bh=pWxufWESdVpjSVMoJonasFKWulN2V2omt68lqo3uzG8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nlHbV6l5rl8aR72BTjYktFQsWdfDTKBHHDRRYfCHHH2qSNYftAOb+HzdE265i5PCMUSe9BtmBuDRqQnES0UVYgdC7kpft/dLGWfDNZALGiWZJPzyt9UEr2s8/UWnPI3WRkN/KZOCa6hmWFv9TOyJQPyU91IGDfRjW6tmy/8pTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3SB6ibX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBq+4AV6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766701869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ab+MnheIVRKoBcmzrgSbvk3S4ufWNXWYr9CVeGGgh3o=;
	b=E3SB6ibXHefP/sYpOnOQ9NEEhL5aHbkO7ZEMJ4ULCi3lIHoMbCtHetgy8I1CwFsaWQXWbs
	Hs69ZWOLNGPY2/gIcOT6be3bm1qxCNiJQm7uarCrp1rtIVOJB+ENElLrF5+5q8LqkgYKMI
	A9HAM5G7ZR/rVQe/9+c0uMTQT3pkGE4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-g-X25UZQNAmS2MzhdQbXbA-1; Thu, 25 Dec 2025 17:31:08 -0500
X-MC-Unique: g-X25UZQNAmS2MzhdQbXbA-1
X-Mimecast-MFC-AGG-ID: g-X25UZQNAmS2MzhdQbXbA_1766701868
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a344b86f7so247904746d6.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766701868; x=1767306668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ab+MnheIVRKoBcmzrgSbvk3S4ufWNXWYr9CVeGGgh3o=;
        b=HBq+4AV66DNfZOvb0tfvWKOYgl0rajg9KIchs5xk+rSIeXZvzmx0sBkqkIN8dgqRP0
         nOj8o6GMap/8h7EEYWrvRp9vzn0a6EoNrpL9BV/rmsDhrVpVlRo9ZNRCdz2m5d4lobfM
         3Zv0XAzfJae01+2Y5jEpoSC+4IMsiBdmIFMzxnMiMjJQmahrj4H1Mq+yFvCl893bLvcW
         V3WWdMVzaHhRfhPSGns0krIJweh/wd/+RaXc3tTe580D5PiIa30hzWEdHtzTDqrsBKnx
         F2wk97RQWTCzaiQ2QGrCH+unYL3S7ngkgL00XgL8oK781OyI2JLcI7/J7KmYTsNFf1+Q
         izyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766701868; x=1767306668;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ab+MnheIVRKoBcmzrgSbvk3S4ufWNXWYr9CVeGGgh3o=;
        b=pp00seJCACeDGLDm4gJ/NAp+zOv4jtZZF6Fg8Og89Asm74kiQY0eXYN3ZZwJitf5fB
         CIzol3v4T/OQHHI/SucxTzF3fc9QIgcORbNUb6CX0R2NSutGbtDXv2biJevGWTrowHXT
         tdWnhopOJH7JjSlMnXfOZLLZr/9qphJ742giY6rKY4qZGzlYUN2W+4rj+ars8pZQ6fnG
         8mQnAy7QRc/+sYaF7zDNDzDFiRimvGNJ3NWKojPL+Tq2jlGYytsOT7/zFNmAPScv6Ejb
         S2WrdEiILkW76o4TwZm1fKhhLROs4A5tjXP2OSPSaDqE/lkxTpprehYq5T7jJh5/bp82
         VG/w==
X-Forwarded-Encrypted: i=1; AJvYcCVOcPUG8/w8KUhtbqe/6nAfq99jn44IjUrgZPZFQZMaFkdyCWZfmc0XoWjpuS9ZJHPsO0v16oA010U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLte7XW0YexQCahJsrDFDsklBr6Ht8N/E5DTDpe6YTo17CjPQm
	P/Oe5gF/rWz5MHjUs1zyu5saTCjjPfo/VyDwZw9PIitNNXbHutfWUes7I8vldaZgXToYEG2qe4K
	+LdOy+lNVtkHPxECscgFJGYQDLewAsSVYLQUeF9f9Tufll5TDmuir6wKYmlkeuQ==
X-Gm-Gg: AY/fxX5RxB/nwOS1XJ2/fAvuG4AFikODdvV32GFuXA7ZKLuZrzIgwRXKvfA/KbXvCAW
	pH9SrpipKXBBf1++OqLb6quoqrPYwTYsMg8MnJOePYVlruvOxHznCtvbGXCfUueAsBb6BN2qheM
	WX5ACXFvGJxB1umAULB5tfxeuraIWNeWffP2qKdB/23LoKKDhPtQAXjHEn67DndHVQHhbGAXU5Q
	6U9eOpYsAeR1aO6Lr01qqg5ntkvXdR8jRXRgWbVuyJ+JX5HMGmct+zPVifYffia5wJLUio5KENX
	eNtc/CmijkdmOPyaz2Bg9QmHmzqzOaNumLlYo9GSOjdfiZManCUVMG5OMnGvUfRs5hZNnI2hx2q
	qA9UAG1e5R3I5T8uNFMf7mLgMkZQIT8L6ZcDBlgzoawW4xx2By852vngH
X-Received: by 2002:a05:622a:341:b0:4ee:24fc:be81 with SMTP id d75a77b69052e-4f4abd400d4mr330935941cf.36.1766701867897;
        Thu, 25 Dec 2025 14:31:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHthnytoNkit4+7wP+txqxK1npOqoQN/ulutuPL/gqwE7YXGTzVApXUK7yM3kp5hfoASbcRLg==
X-Received: by 2002:a05:622a:341:b0:4ee:24fc:be81 with SMTP id d75a77b69052e-4f4abd400d4mr330935421cf.36.1766701867385;
        Thu, 25 Dec 2025 14:31:07 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac65344bsm146923311cf.28.2025.12.25.14.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 14:31:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <006b00ab-c8b4-4a2d-aa38-94a41eadd238@redhat.com>
Date: Thu, 25 Dec 2025 17:31:02 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] cpuset: Convert boot_hk_cpus to use
 HK_TYPE_DOMAIN_BOOT
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
 <20251224134520.33231-7-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-7-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:44 AM, Frederic Weisbecker wrote:
> boot_hk_cpus is an ad-hoc copy of HK_TYPE_DOMAIN_BOOT. Remove it and use
> the official version.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6e6eb09b8db6..3afa72f8d579 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -88,12 +88,6 @@ static cpumask_var_t	isolated_cpus;
>    */
>   static bool isolated_cpus_updating;
>   
> -/*
> - * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
> - */
> -static cpumask_var_t	boot_hk_cpus;
> -static bool		have_boot_isolcpus;
> -
>   /*
>    * A flag to force sched domain rebuild at the end of an operation.
>    * It can be set in
> @@ -1453,15 +1447,16 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
>    * @new_cpus: cpu mask
>    * Return: true if there is conflict, false otherwise
>    *
> - * CPUs outside of boot_hk_cpus, if defined, can only be used in an
> + * CPUs outside of HK_TYPE_DOMAIN_BOOT, if defined, can only be used in an
>    * isolated partition.
>    */
>   static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>   {
> -	if (!have_boot_isolcpus)
> +	if (!housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
>   		return false;
>   
> -	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
> +	if ((prstate != PRS_ISOLATED) &&
> +	    !cpumask_subset(new_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT)))
>   		return true;
>   
>   	return false;
> @@ -3892,12 +3887,9 @@ int __init cpuset_init(void)
>   
>   	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>   
> -	have_boot_isolcpus = housekeeping_enabled(HK_TYPE_DOMAIN);
> -	if (have_boot_isolcpus) {
> -		BUG_ON(!alloc_cpumask_var(&boot_hk_cpus, GFP_KERNEL));
> -		cpumask_copy(boot_hk_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
> -		cpumask_andnot(isolated_cpus, cpu_possible_mask, boot_hk_cpus);
> -	}
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
> +		cpumask_andnot(isolated_cpus, cpu_possible_mask,
> +			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
>   
>   	return 0;
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


