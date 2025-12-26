Return-Path: <linux-pci+bounces-43731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 143EDCDEFF3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 21:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F252F30184C3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C656308F35;
	Fri, 26 Dec 2025 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAk3eD6d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="To4PyOlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C5306491
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766781925; cv=none; b=ceCszK/VJNvEEAemwqdTsx/HixUhAqcB+XFFoVJKeJjkffbfxKWdnjYYGd5yTHGLIM6nduCEMODc6TYiUeTwxo0UydXQfQ8fvwAm2TkEfYfXqiZKt4JpKqXedhAtYfmnfT9HFDlCQ+F88BI5ETaJVtBXz7ff6LShhZsJxfXAFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766781925; c=relaxed/simple;
	bh=vj2ixsyycj6S5A1zLEL/RQ+pdJrAF0mx54PTAW+DzIM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZdiJ2/XrihZ40TKpdtiDUFuEC3s2jmhVEiSVo/6cwZprhxPxRLDV4kvDn9EDXNGlHQ8IrrzDhxZTq/t8319BAujg2QCtMlhOxtKrk3GhbpS+a2HT5lPBmPERK/ErNfcF32LayjCHocTJBUJOja6941ySIjzBzMWW+TM2MA7Ezz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAk3eD6d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=To4PyOlS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766781922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TeXICaWTl/KfVZ8H31EGm2TJnHW3xapz5vNb0Sw/RM=;
	b=JAk3eD6dgOwEponfkJo4IdGzBnt5EavnVoO72KvnfPKzyAJgVoP+KIbeXhdum+HT1G6Y0e
	mlLey0Aw2NDg+AzRl9h9v+NtBrFfcGmHgaejozSSSn10qY+s6yQlwoy2r/fjjYbnAuZ2/8
	040eSiH9vhGCtKaPUCNI5aX8Fn90ff0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-O4WmLrQLNHiCpwngRlACxw-1; Fri, 26 Dec 2025 15:45:18 -0500
X-MC-Unique: O4WmLrQLNHiCpwngRlACxw-1
X-Mimecast-MFC-AGG-ID: O4WmLrQLNHiCpwngRlACxw_1766781918
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b51db8ebd9so2409203185a.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 12:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766781918; x=1767386718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3TeXICaWTl/KfVZ8H31EGm2TJnHW3xapz5vNb0Sw/RM=;
        b=To4PyOlSk3bG39KS3qaPLY/QIUerQXqjT955zkSZ0fI3qaTGXDWAwcEIvObkGvfY+G
         08X576NUsSCY3BGo3/CqK9mWuR7zRObNrCICrBv4yjmYehhlkaNaGALEbP8HywHObp8b
         MvmffUqNXFl+fpinNxMIIj7HFE+N7pHGsY8EMF8GzglkRbYi3LN3+xVEBfInVz36XS45
         zHuhlRFriIzpuE8jMHU6JiOPMjRyTnYpggl1z/7DduM4WSCc4FB0KNlrdactCIhetwu5
         JgL/GcQC+vP5znktw+ewHQ81oyu2YBZ8SSJ4I9UAE1Rg2Rk+z+hLbH3OiJpXTDLghZKg
         qK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766781918; x=1767386718;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TeXICaWTl/KfVZ8H31EGm2TJnHW3xapz5vNb0Sw/RM=;
        b=Q9BjIQoESgXGlvNn/0Y51QhY17xDW6+DTXwClNWHcQhKcRieXmY0/CBvNlllJxpWlb
         n49dZxlY22srg30SGIDGJLwsdBWMopqfOyXSz8JQFGIfZnRpoWL0qBJLwm74Br2eXBOu
         +N54TCkt1hS2wd47vaSmg6smYQzPOAWcQ2qlTxMNn66yIW6vFzpRQBU2Swkn18NjDp7M
         nCz+bk8r1tapBTkxinSqUzypR11hBkOlonVAt9S7ujkqEW6mKCaPXvj04Unep+t/8cjb
         Lj44qiirF71mf11A4letK2VRUZ0iD4ktG91T6T6gsjwj7PcFcjLAYlg8EKzPGlMHGImV
         NgUg==
X-Forwarded-Encrypted: i=1; AJvYcCVJVLbe51ZaY+KXpRvG8Eae3dZek40H5EgNaA1BVzAFn5/cqhJ+r8UIbGSjCNipprH8DZ6Dt15Z2WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZW0OCPt5/oi2M7hMFtcGrMjB8v/f4Prlv6o98RLP+d96Gn0Y8
	JDTJSs0nAyl709ARjpppOvchq8d4oH1UYHlLnnDavBqpaRXgIF3N8Vg39lAjVU1GxAwTW7/Ul+K
	r7cC7B/yf+q1PC7OAJpca7D9QbEw6cBLgJgXOgwf3YiY6hGYsLeXi23UHAf2/AA==
X-Gm-Gg: AY/fxX6C+ViYcYb/m01x1Nwa8fa1ctsj0hAObzKiTiCXPagFK6wMAZaIfEiYDgV3lOk
	eCyxU0H/43qz6AOlcQdDBa03t48bZ/iZaTAFFxgGLwIJgEZKNgKkV2HjTU0sDH9ytm70cFhpIYN
	Y35/1jWvPV9KPmElgck8YARYzGddge0hNBr0FhBI2vjEozUna1W+Z0jE8OFvXYBqsbuChfJlfFH
	1GefY0PZHZzB7wJv3uqj7JsMt4w+hDPsiKS4HYrW+IejwOTYYBFchh4B16GZWXXTmMYu9WScSNL
	BOPeggTHHgFSxgVi0N5xSuMtELXFDXFy3C7Xf/mlc/G6ZnEJ/lPPrLfo6KaVlkRKra1sTjJ+MpW
	2I64yDnZTESc9kAz5/KSEsbOhitxR3jKuza7VHReIMS7DtBpBMnzPyAUf
X-Received: by 2002:a05:620a:29c5:b0:8b2:dec7:d756 with SMTP id af79cd13be357-8c08fab88a2mr3620501385a.66.1766781918239;
        Fri, 26 Dec 2025 12:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXv60plEpPy2fU+PATnpKAA1Y80YGBXC1cy+B1fIWSmCaoTRFPW7/kxK6mjum3QMoJNZ6o1Q==
X-Received: by 2002:a05:620a:29c5:b0:8b2:dec7:d756 with SMTP id af79cd13be357-8c08fab88a2mr3620496685a.66.1766781917751;
        Fri, 26 Dec 2025 12:45:17 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09689153asm1727228085a.17.2025.12.26.12.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 12:45:17 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8282d85f-37b6-4f39-a70a-de5e6c77fb0b@redhat.com>
Date: Fri, 26 Dec 2025 15:45:12 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] timers/migration: Remove superfluous cpuset
 isolation test
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
 <20251224134520.33231-21-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-21-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Cpuset isolated partitions are now included in HK_TYPE_DOMAIN. Testing
> if a CPU is part of an isolated partition alone is now useless.
>
> Remove the superflous test.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/time/timer_migration.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 3879575a4975..6da9cd562b20 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -466,9 +466,8 @@ static inline bool tmigr_is_isolated(int cpu)
>   {
>   	if (!static_branch_unlikely(&tmigr_exclude_isolated))
>   		return false;
> -	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
> -		cpuset_cpu_is_isolated(cpu)) &&
> -	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
> +	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) &&
> +		housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE));
>   }
>   
>   /*
Reviewed-by: Waiman Long <longman@redhat.com>


