Return-Path: <linux-pci+bounces-38900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F877BF6D49
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D1F3B6A42
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C013385A4;
	Tue, 21 Oct 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fm52bYlP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B22E6CAC
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053961; cv=none; b=vFlGoaJCx1UMmunl4Db1by8ibu3VKwGvu5qHYFMRe4ZVTf6FmWUQkFXtj44M+/hbIXwmrR1U3gzbBjz0NAYyucUfJD1TTVMop1x2XXFO15B62VEUjEB/7J0pcehbEDlM95VvNhRzMpyLDEUDCG8buzL5Wh7/gB6x9UQ+7mShqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053961; c=relaxed/simple;
	bh=A2vdq3fjCx6AIl2BDZIfxhOwGIe9UlrZ+Owl/fdNpyU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sPr8sJr2GrSkYmU3fFLRBJPtmbJXYcxHQtS4zItxUG9m8Xy82MD0kb8A1ep4xXter1hTk4dh0G1At+4GVYvxBCh3RaAKUl9eBtGsYB90EmTFbVaUqStbyie46xqzjuFXrxwlqe3EWn8x6NWFvCf37R9mLHh6T2ZkOOIlRCJQ8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fm52bYlP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761053958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3KJELQ+1zBaV6zsfBpuZG8t84lL3xkiKid35BQ9x2E=;
	b=Fm52bYlPGqZSpzR3cdtOjdEXeelUUsG5PHSGjAV/zjQEyENbmo2PQWPbX2fn9uyy3WRoZD
	NU6v78EOuATTjK8j3laFDDcanzU/poGe8X5JCfmBhX7zYW+ZAWfbs8CLH7IUXq7OXU9kWq
	Y78ybsBF4i7aGyYe/wp+KDsEzeI0IOQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-AbuCPLdTO1uHh1PavM6CEg-1; Tue, 21 Oct 2025 09:39:16 -0400
X-MC-Unique: AbuCPLdTO1uHh1PavM6CEg-1
X-Mimecast-MFC-AGG-ID: AbuCPLdTO1uHh1PavM6CEg_1761053956
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c08308d26so200072806d6.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 06:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053956; x=1761658756;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3KJELQ+1zBaV6zsfBpuZG8t84lL3xkiKid35BQ9x2E=;
        b=bVpjcwrwvAq51v5EmbUqSxdz7PA8JF742h7IDiC5d3wHIlBN/6E8pimbemi3NILl/3
         s0BP+3JEW6P4GFct3Zt141BAnpwIegDo9hBcWGi+IhzP0oIyoPQUts4mfHBkfpekpXRU
         YR2CjXvA3cz7d1a+makDAhymnmMNZZU0xZWjoJyrqG+cn2b10T9RC+88WF57bkzzMKBh
         QycYIRQ4432R5fLImLWA2m0o5VEqj1E0Q/NVHzC4Yc+f/VDtFJq29V5KRyaBldKO9syj
         oLV05a+WkHl/DTNbCXHfXQ5ev8GfMPRvUFNEnBHkx8OWfXSrevxLxb/60m2GXYtJesz6
         t1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXkbEUW+bMK0aMkhHMqHxrYvOpkEpzvvQ4mw8SnIERCKYkPF+xEd8VtavsWkEIka9/Xyxcpqi5qjIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqkUj4vYqduezUYfVqxd+irArBAcXWcaylYt9z/Pm64FkDG932
	UBkEwaEheBFINqC1zhWhNi9IbD8CYTj89MgKJBo4JOHNAFsPc+OglmVThsLg02Ty2UEExMk8O4e
	ek2TuQLE98tnULtRZUhmVrwRue1XTqqDtTIRERHMf+HZjA183qcDvkVzDgOVGjQ==
X-Gm-Gg: ASbGncup0uK4TyVYbx68iJUdUFF7DeMH738do7Pysc5gy0VGIxVKQR3kFBztA1ebi5b
	BrrYjBCYgb2FMaSIDP8AIRdjyuHbYwGObN12oQFuXrGipfUFWULTrTs8NT15XwoQCtY/go8gMVr
	iVyOmJdPLP81dORo5ISb8qKWMUgSgu9egMrpXW53Jv0jl0K5hjn/SI1jpd0dBDrpja15sIQlCcg
	y4yi+k9wGADTDLaMWXS6CKMBbmUWwotpx8cUl0lyQpIvvGj3GbH4oi5DVxC/mgJCdGjTjpfy4WD
	5Kv53CoS/sfwkufwoIFSzKz8c+FXGzsiAGsgPqehx1L+iM3Y3zvuopsboZ8uaC96F3zlssAAQ0U
	C6nncg8sfEHDoYdMSJlNjn1AUUtN0Cxknh4pndvf+oPMRQg==
X-Received: by 2002:ac8:7d8a:0:b0:4e8:a6c3:4322 with SMTP id d75a77b69052e-4e8a6c343dbmr147838251cf.68.1761053955803;
        Tue, 21 Oct 2025 06:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz7AKLLzN2UNU/guKrJvkpbFnggCrMTTSh4yWUy38aXqbwBFVcdBvCw2i1DLngSoeAJ3ah8Q==
X-Received: by 2002:ac8:7d8a:0:b0:4e8:a6c3:4322 with SMTP id d75a77b69052e-4e8a6c343dbmr147838031cf.68.1761053955419;
        Tue, 21 Oct 2025 06:39:15 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3370fsm74330521cf.3.2025.10.21.06.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:39:14 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ea2d3e0e-b1ee-4b58-a93a-b9d127258e75@redhat.com>
Date: Tue, 21 Oct 2025 09:39:10 -0400
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
> @@ -80,12 +110,45 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
>   
>   bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   {
> -	if (housekeeping.flags & BIT(type))
> +	if (READ_ONCE(housekeeping.flags) & BIT(type))
>   		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>   	return true;
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>   
> +int housekeeping_update(struct cpumask *mask, enum hk_type type)
> +{
> +	struct cpumask *trial, *old = NULL;
> +
> +	if (type != HK_TYPE_DOMAIN)
> +		return -ENOTSUPP;
> +
> +	trial = kmalloc(sizeof(*trial), GFP_KERNEL);
Should you use cpumask_size() instead of sizeof(*trial) as the latter 
can be much bigger?
> +	if (!trial)
> +		return -ENOMEM;
> +
> +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
> +	if (!cpumask_intersects(trial, cpu_online_mask)) {
> +		kfree(trial);
> +		return -EINVAL;
> +	}
> +
> +	if (!housekeeping.flags)
> +		static_branch_enable(&housekeeping_overridden);
> +
> +	if (!(housekeeping.flags & BIT(type)))
> +		old = housekeeping_cpumask_dereference(type);
> +	else
> +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
> +	rcu_assign_pointer(housekeeping.cpumasks[type], trial);
> +
> +	synchronize_rcu();
> +
> +	kfree(old);

If "isolcpus" boot command line option is set, old can be a pointer to 
the boot time memblock area which isn't a pointer that can be handled by 
the slab allocator AFAIU. I don't know the exact consequence, but it may 
not be good. One possible solution I can think of is to make 
HK_TYPE_DOMAIN and HK_TYPE_DOMAIN_ROOT point to the same memblock 
pointer and don't pass the old HK_TYPE_DOMAIN pointer to kfree() if it 
matches HK_TYPE_DOMAIN_BOOT one. Alternatively, we can just set the 
HK_TYPE_DOMAIN_BOOT pointer at boot and make HK_TYPE_DOMAIN falls back 
to HK_TYPE_DOMAIN_BOOT if not set.

Cheers,
Longman


