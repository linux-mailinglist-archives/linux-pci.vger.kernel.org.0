Return-Path: <linux-pci+bounces-43716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C1CDE21E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 23:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF7C3008E88
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB613D891;
	Thu, 25 Dec 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjneIoF7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q7aHiHAh"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4CC29C326
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766701693; cv=none; b=ohZScOgJIeEm/Q1CwZJU2PURuFBPTcdST/v7uTwSwa7JwaYkJOcG3cGJz+E+w9+5GUC+SmSVJcHXlswJLweZ79ZAWbMYMux0Fw9V6hBgx4Cuvsy4fdGwsNRKBxmed11O3AFjRtBnchIPrGnueAwFppcUC0I9+j2DE1Wrs1SrlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766701693; c=relaxed/simple;
	bh=ly8xlAcwEq5AylEYJRI18D+dCgZKx0t1PbpMqP7W2Io=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kc8k9EsGj94TWn14skQGnoq8K3LQMR+djN6eHtNj7Qkw0VASGreIW8PoPpRqG64mVvEpcocfkVComEkMkqO6zBmDJAoOWfN37L5aZM0NHe9cIw/1SgQg83ASAIw6fnfk2wRIjRx8PQwTTU1uTKUzqj2Ej77tKR6BiTPplFWGgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjneIoF7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q7aHiHAh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766701689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
	b=IjneIoF7fXqKFukcTsSrBKhm2n1FMnyAkcwwagOMdup07ESAof89M7UfNbZPJto7RERYqd
	P0EUF3NtkAVQ98NnfnSYIDP7Dp7mOXJWberpsem3zNRd6zoUMRg4C20y6RnH4HoD/V6+sf
	SaZLQ7Wke3jp1IJEN7VVB8fWByIH6sc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-ahRkV7FYMFy3Db1i8kaH9A-1; Thu, 25 Dec 2025 17:28:02 -0500
X-MC-Unique: ahRkV7FYMFy3Db1i8kaH9A-1
X-Mimecast-MFC-AGG-ID: ahRkV7FYMFy3Db1i8kaH9A_1766701680
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22ab98226so2376230585a.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 14:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766701680; x=1767306480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
        b=q7aHiHAhKiDFctYhmJS8WvOtJaLGJJEUm41lj1/1YVBLxmzbbIDbpp1MWcUFgJGuEw
         2/EMTXdVNHQYo0PqfBqjIPv9eBwmHTUegV+Y98OtcB8cdlCbGOSQzFdIQ3HZ2/aCWKGB
         iCTtxpM2oQThBS5VplpTT0UkLMGVYf0pSZpZkPkCVHg9CEcEUjt+AZ01K8hMCwY09ZIY
         bhe3xukhHvsQ/06yaEwMhpILaP4JSKuwPo5iu7iRW+kUzuUQxkJlwVo0cfQT/loVNRe9
         IcbgVKJN9brswEY9XFv4jEV95MdxoPFneV5GYiiRKRPDJioBQCBE++lCpNVRhQGmXz3X
         RAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766701680; x=1767306480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
        b=dFyuInPxoiZ6kBFpPMRUj7VUQ515V335WcKk1AAXm0mB3hvKUHSVAuSkawtZfRMAZk
         7J+QMC+TS4msYqF9I8D4v4EgULg4CU7SCRM1stdFVaJCP/eHgS0asnIsaBjx46vCyN2D
         NBjbT4E7+YmzUbGMV6PjkK2CXm8p9PlKvFhSmMK78mPKVi/BQCZgi5wZHjneJUt4ylYR
         H7DsWX5IucTk4SXK8JMjDknlFGRkh2Nf2dpFqycnmbXd/jXzaDtJltjgwtXb6fv5+7St
         ZKwywxwmLSjfOA8/QGlTbd6uOJO5Xkge262l496UNM9gEZi8DhKZjCnAqe1YdxkIpbrL
         vt1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7+bMQlWaHA5ydOI0BovmQG4g0ShWScaKXpex+/XEa8FiNrOHSqpwjGD1t/eFwsfxRRsm7DLgdnyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqfQ67Q7x+8ILsXGwSmyTur4wZvWRbDR7zSaK+ujSr6iWCOYO
	fBsmzA3m3y3UUz7/tO56Uou8VW4bz68OPcMCX0yuqFhB2eDtu5w67JOXfzWArCG/jKcYnmXLzle
	3ePbuV9B15Dd9RtdR4Aflq1Z2PZQAvxnXamDm1Pg7nYi/Bq63RhwCSeeTHj+apw==
X-Gm-Gg: AY/fxX5alVAe2orCll1FDPJ+UckWXmC69cNyMzIW215NT3x0pfsZdUNEnQOxqYWhvqq
	Mv4kWKqxnj8ix8NCBYrpIBbGdJWuJt1KAMAaNfkam1jxan4arTiPTpiaJG2i+xc0qdFCvClGTyq
	GWdjeBiEOm90BsppS7XeeXmPJCCejzkEOctCmPaO1fVaLYCLt3kULRvagHh8v90rj7F8l0hSd1v
	er2+6JxzvNQ+fPmWXdw8ZPAT159oL2zyIMRfwkLNeiyZapZ+uE/QCWgYZE1uwSN3xhduXciBs91
	9YWpP76iUxnH164PiUDE9xzbRAE1x7lmv+EVIFg6GS7ZlpslEmB7cZNq4zK98b6y0S7LQ0P4wT8
	etqe7GktqGE02w3jvqC+Qq/mP0Q3Cu4rCoJhIWCL7OSdFbjrnipP8NkRK
X-Received: by 2002:a05:620a:414c:b0:8bb:26db:e22f with SMTP id af79cd13be357-8c08fbb5432mr3197587185a.30.1766701679935;
        Thu, 25 Dec 2025 14:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkk34PfoZDZVXHOsdvaSoOtEJlSomrI6NhnO1ciZ/uaqISBnHAQBKZ+i37TxyEDRNXrTUZhA==
X-Received: by 2002:a05:620a:414c:b0:8bb:26db:e22f with SMTP id af79cd13be357-8c08fbb5432mr3197585085a.30.1766701679541;
        Thu, 25 Dec 2025 14:27:59 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fdasm1605628285a.35.2025.12.25.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 14:27:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <04708b57-7ffe-4a97-925f-926d577061a6@redhat.com>
Date: Thu, 25 Dec 2025 17:27:54 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
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
 <20251224134520.33231-6-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-6-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:44 AM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
>
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
>
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>   include/linux/sched/isolation.h | 4 ++++
>   kernel/sched/isolation.c        | 5 +++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..109a2149e21a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,8 +7,12 @@
>   #include <linux/tick.h>
>   
>   enum hk_type {
> +	/* Revert of boot-time isolcpus= argument */
> +	HK_TYPE_DOMAIN_BOOT,
>   	HK_TYPE_DOMAIN,
> +	/* Revert of boot-time isolcpus=managed_irq argument */
>   	HK_TYPE_MANAGED_IRQ,
> +	/* Revert of boot-time nohz_full= or isolcpus=nohz arguments */
>   	HK_TYPE_KERNEL_NOISE,
>   	HK_TYPE_MAX,
>   

"Revert" is a verb. The term "Revert of" sound strange to me. I think 
using "Inverse of" will sound better.

Cheers,
Longman


