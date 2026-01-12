Return-Path: <linux-pci+bounces-44455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1AD10467
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 02:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7462E301F7D5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 01:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EB01E32D6;
	Mon, 12 Jan 2026 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h20AJA39";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM9c3APa"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E6632
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182215; cv=none; b=ikZ/LkhEBy4teeueBWkDs7opSsyffriWrfFIFlFL8JsjNmNPGVNVuRLBb++27wuAenBmOBg/hQvq2bdcJLYys/42N8Dmh0RfHeo7GhepreZdUcIjXCRtCBQ8OiArN16VTiR7m32rdWeCvqftWfDbXoY7DpGdrvkrMMqHgnZukgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182215; c=relaxed/simple;
	bh=hS5M2IBt+XDf18Gy4ts4vK0v+84GrMVmqYQzF/J1aLY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oxEz/D+xKsy6o9FIgnmOJKAogvT0dDywclCAb7gah48CiQl/JXjojxJ3nVFimu3exGwGl/s5rjEDo9zoFekZTknQXm2u572Tgi0kSumbg/n1CRfM/lriypr5X37BBvom6JSGWGWbCb/WCtZsmMn2zYdeQ7IXxU07FULhldtwtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h20AJA39; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fM9c3APa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768182213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g0eqFZw+saooIdmg9NsoPWVUWAMnQL8vdrqEmKZ9zg=;
	b=h20AJA39iueWpUfsWHIyMbWOwGr8njJH8B4VH6UaX9OhjXt+tovB3b7LQHHY5qVQKl6Eei
	xDpOBfFhSoOh9al/I60XBM719p4XDmEPiDT0H+lkx2j3j7ldZmy1lijmYRRAgUHxUZSg36
	uwZz3emhbIMqwGSSDShzUQS6iDs908A=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-H1a--oH1M7SoHX9nXt6cVQ-1; Sun, 11 Jan 2026 20:43:31 -0500
X-MC-Unique: H1a--oH1M7SoHX9nXt6cVQ-1
X-Mimecast-MFC-AGG-ID: H1a--oH1M7SoHX9nXt6cVQ_1768182211
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-563662e2266so6993435e0c.0
        for <linux-pci@vger.kernel.org>; Sun, 11 Jan 2026 17:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768182211; x=1768787011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5g0eqFZw+saooIdmg9NsoPWVUWAMnQL8vdrqEmKZ9zg=;
        b=fM9c3APaS9aJm3sKodkftW12rE+dqCrcvZJlQSwfYYp7KL3/Y/xN4jk/jSEVwDnpaz
         7bBln+Xh0dI9j3tuBh9QKGmDbyt0E7wP9SE2I9OJUvkdbdErxkUlN16ucy4/k9W7bPGN
         AZFMFIN6EPk7/I19Ka2sf+rhZC5iD8DvAjrppEKF6Oks8qFP3kypCAFrnqFct6/rdaJt
         fjQaHZ+oOsSQhcEt+ZTjCmHL678zidC4VAnb6VlC5JjLQMWznEsiMlboBmzxowUWNCEg
         DJlLBUab+MHi4Svpsy2LvKLAh5qnh4YxIziY4jgK787VXKkpe1LeRiL2JGkhyZv1iPAG
         Znzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768182211; x=1768787011;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g0eqFZw+saooIdmg9NsoPWVUWAMnQL8vdrqEmKZ9zg=;
        b=r7YOjaYPnhvuG4WZnybl3e0eJGFGtiUJ+r0sWi82AK7ycCkcFc/ysTnEEPhkSoWagb
         osMsHTx8dtb+iM1x04SxVdVLDA9+zSXeAcdoxY/4taICG7BmuQ3ewy7CBWinaxnS25NA
         21S5MdSnaiA3GHFt82isrr+kxmhsT/NKKwO9jXCxio2IlfIa54A/b2QArTrN0MTqs4ec
         w6JY79yNkRyxPOHMnJFMKnxZHfkbtOZ5FI79NyZ4mpzI3s0rb1s8kRB5QK84ZC+iW3Ft
         WJDTPMeLazYwvqEnUakyRskN/MmAYXlcCrPItGVNieLrzvaRfRxZzQLwETClOtJVADkm
         gkVw==
X-Forwarded-Encrypted: i=1; AJvYcCWjf9Mp74WfbEMcb6vSRA7tx4UCeNJ483m+ZO4SO6qYwuNf+YCw0AKTlnL84C9/7HRh1NiZjDE0Yts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1mYULFTIJaG1Pvqrxoxb4sjqI6mMmH6HkEejw5Zz+77DCx0+U
	qiPuQJGCSYvOfyh6ygfhWo4Rdlg0oLcDZGh8l3XeGjR/sNMTbqtfyBymDpBbXtD8bZUhLM9ljRe
	0frh2YNE5QMpGpaCLVC+zsJKWvC7GSjMHS4NKayRcEXkH7oS7M3nWdHTc73SjHA==
X-Gm-Gg: AY/fxX4MO6EGmgLCe/uRbHaCVQJIvpmFk0PnXAifu2y5aPnkbWqWtw8W9ylg/r9rsmS
	r7dn8wnQFDVtutndxWC3u5MP2tY70moQG3o2oU+b7ZTphieGHbJvBsH8rAC+2ItAV2+0bDrJ08g
	3071FVSjgIQzLRS3IVbpGFTAH4YPd6ACsv0ZlNHbfTakbhixtxf18tqHZ0+NIcCJOfiVT7nlfjK
	i/SQpO1xpQBetI9NrG/+YCH06ZEXZ19CI1aMZ1Wy5hsjtnBKRIwUXqMqVnsAIBYifLwhY1qAci6
	UJyQ1A6SJTMkRvlUUP7158oPxSS6T5qCRkwDDAlEAwwHdDaWHgkFuIeOyXvV9PUpUEXd6zSclQ3
	o4aBN7VWqi6fcWB6dW9frExQJoCmr5YJt/FvrtFNOmc2dAcWYtPRjObUI
X-Received: by 2002:a05:6122:3383:b0:55e:82c3:e1fb with SMTP id 71dfb90a1353d-563466b1471mr6360630e0c.10.1768182211341;
        Sun, 11 Jan 2026 17:43:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV+QUILwqeHqopifLZI0TMkyTSwUxskEqEsydIK3wu+6ViPTcpBZklzMvbaEYb1jKTIvUBCg==
X-Received: by 2002:a05:6122:3383:b0:55e:82c3:e1fb with SMTP id 71dfb90a1353d-563466b1471mr6360599e0c.10.1768182210967;
        Sun, 11 Jan 2026 17:43:30 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56375cd7cd6sm4961512e0c.10.2026.01.11.17.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 17:43:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e97d96fc-cbdf-4c03-aa1a-b0cde5419681@redhat.com>
Date: Sun, 11 Jan 2026 20:43:16 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] cpuset: Provide lockdep check for cpuset lock held
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
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-13-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20260101221359.22298-13-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
> cpuset modifies partitions, including isolated, while holding the cpuset
> mutex.
>
> This means that holding the cpuset mutex is safe to synchronize against
> housekeeping cpumask changes.
>
> Provide a lockdep check to validate that.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/cpuset.h | 2 ++
>   kernel/cgroup/cpuset.c | 7 +++++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index a98d3330385c..1c49ffd2ca9b 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -18,6 +18,8 @@
>   #include <linux/mmu_context.h>
>   #include <linux/jump_label.h>
>   
> +extern bool lockdep_is_cpuset_held(void);
> +
>   #ifdef CONFIG_CPUSETS
>   
>   /*
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3afa72f8d579..5e2e3514c22e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -283,6 +283,13 @@ void cpuset_full_unlock(void)
>   	cpus_read_unlock();
>   }
>   
> +#ifdef CONFIG_LOCKDEP
> +bool lockdep_is_cpuset_held(void)
> +{
> +	return lockdep_is_held(&cpuset_mutex);
> +}
> +#endif
> +
>   static DEFINE_SPINLOCK(callback_lock);
>   
>   void cpuset_callback_lock_irq(void)

The cgroup/for-next tree already have a similar 
lockdep_assert_cpuset_lock_held() defined. So you can drop this patch if 
this series won't land in the next merge window.

Cheers,
Longman


