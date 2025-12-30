Return-Path: <linux-pci+bounces-43822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1CCE86CB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 01:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7224C3002144
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B32DCF41;
	Tue, 30 Dec 2025 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b75GFGci"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE12DA742
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055059; cv=none; b=cHlyn4hKnO17STjOP/7epElOo2zwexiwJxHAphouo4qg7fFKeDXOFegRO6vbIm8SrvHcuUdNrgQK8FD/+C+Xd8vOPUjMXcsx6eaG+/GoqlQJpc0cESoNwYzHuOC5TVDx6E22/TrZSo2c3HJsjhBq4pmSNytMsQ94QEaAnslgMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055059; c=relaxed/simple;
	bh=Eu/0MvqtXzKZbDhFka3bibWxt0bbXBOC90Q2iECgF+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBq4UqFTvLUKla6pG9+Br57w2hOcJYNu76I6owVldiT/0Evazv0oQu3L0QJK0sVRB9Kc/gPj+0EyI6xbaimlFA7R0w5nJmHy1Elf8+UBhLYXCfsaHmTcuvS2wm2U/2wctGpC7tI3CfQhmMm9oWCFnjplLVmhtLDyvWia7JPLneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b75GFGci; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c7aee74dceso3708664a34.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 16:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767055052; x=1767659852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IheJhIQLOL+uGWt6XQ0zIC5UxYwT55m5ifEVRi78ko8=;
        b=b75GFGciNFmZMA1pAddG/IJyk0M4t8bjXViGqRPJUtlIXNSocJ3qCuRdzql4roVBtZ
         Qrdqe8iYz7Gqxf7ywr3VQyWONwdpO/lDW9ksNyJh+w7vmT1izd2arvO0pJy3QYropwn/
         A878rasRxsLtm+n5QK7MVcxyJlV40ig9KrV5JxxKyw8D0H+0TEIhgGsjCLH95Z0hiE7N
         8RWNwEm1HWyVBonRBhvnnUCwchniJf2BQPG5K6oxn0ODRncyVibOZ2qJcE15PPfMUrMk
         gB59gvD00SHa7wjiux9LcA7lI81kBy2sSg0xT3VH7QaujB/0Qbq9W14ydND7Y6Xw/Eft
         sQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767055052; x=1767659852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IheJhIQLOL+uGWt6XQ0zIC5UxYwT55m5ifEVRi78ko8=;
        b=DAv0NrkCVM5qvjLjpUWza6dh1a6Gdy/YPFHYeib9w4re6DjOhSDNB/KlVdU7r7u61V
         d9INY72S9+znjL/EO22L3BTR5rHsm1ycBh3IUpeaC+ms2i411VlwfBa3mHMvHCBweTcn
         xYAk6CWsktAhWcnksPYgz3Q1m03cE2esPetVta97+/VfN7ifZhDqLZpgo3DQ41bl8ah/
         SszfbkHMbB+f0nQBgQv1jEjYLNEPqEU6lfNELm4CC7qD56TAHAEMEYq1wHrK10zuTP0h
         9oYkTRwRSAEZKTKxWzWSfcoQ7KwgteW2wf5uVhZ4cuMwLGcm6sj4n1w9Hc0qArfICmBw
         t8qg==
X-Forwarded-Encrypted: i=1; AJvYcCUcS1RyUoabWaqKg8t7mqUgULhJx8hq9LVIfvQq2UpPWNRWhzAcinItXoOUI5OT8MGUJ7Bg34/EKqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyayeTioW77csAVXesjTUIov03zHVCYNIwhfwWMS2K7ejMIYWxI
	ASRdr75M6uVNGcXsrjz7uf1jhE45gT4eR4dUQfS9I6wjFrkqlfYgXhg2i1t/LWM0GPo=
X-Gm-Gg: AY/fxX7XpkmMUb6gxAue9/JZ51tyZDo+TQ5xSMrl3Pm7NjY7QaeEaLma7Sf5THa+Ph+
	TZZkI0tzTJekJ27GCuIuF3Z4RlBiNRq3mkjk1pGoR5F1RViRztn5W8JQWGPK/9PszhXoR4a/Dzj
	I2SAEFnn49Jbk8MOPgzhW4o5pG6kUMiBAxw9ODp5kBAD+H/p4J+3Bo6jagcMdH4/Z3gioB2Bvdh
	sf1mUknuOZT8TopsPtfT71meku4NhsjnZ5bCliLQdl6Qut7wGlOk8Z7u7Kp9+CbaInFN2Wl7UME
	zDz6L/lCyebgEKagWogqQnamOg4oKjAF50itf2HbuhGEk5El4geXTK7vhQhS9OP6TxJTKeBMp4k
	eq2EBaN4555Qynz5LihuqRTj9xATimq8m8HPSt+KgsR3MhYgdmYavVcUcNwtGCHQMK63v79Sjvz
	xEs4rg8ZOm
X-Google-Smtp-Source: AGHT+IFl9yxlJpaq7sZYozgWoQTaTewr4cBUOiverIAjbR/CmqFwp/DL9X0O2bEGHsivPH5Emtcv9g==
X-Received: by 2002:a05:6830:2642:b0:7c7:6217:5c60 with SMTP id 46e09a7af769-7cc66a603d6mr14529090a34.25.1767055052471;
        Mon, 29 Dec 2025 16:37:32 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d4f62sm21773347a34.19.2025.12.29.16.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 16:37:31 -0800 (PST)
Message-ID: <0f65c4fe-8b10-403d-b5b6-ed33fc4eb69c@kernel.dk>
Date: Mon, 29 Dec 2025 17:37:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] block: Protect against concurrent isolated cpuset
 change
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
 Johannes Weiner <hannes@cmpxchg.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-10-frederic@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251224134520.33231-10-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 6:44 AM, Frederic Weisbecker wrote:
> The block subsystem prevents running the workqueue to isolated CPUs,
> including those defined by cpuset isolated partitions. Since
> HK_TYPE_DOMAIN will soon contain both and be subject to runtime
> modifications, synchronize against housekeeping using the relevant lock.
> 
> For full support of cpuset changes, the block subsystem may need to
> propagate changes to isolated cpumask through the workqueue in the
> future.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  block/blk-mq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1978eef95dca..0037af1216f3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4257,12 +4257,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  
>  		/*
>  		 * Rule out isolated CPUs from hctx->cpumask to avoid
> -		 * running block kworker on isolated CPUs
> +		 * running block kworker on isolated CPUs.
> +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> +		 * here.
>  		 */
> +		rcu_read_lock();
>  		for_each_cpu(cpu, hctx->cpumask) {
>  			if (cpu_is_isolated(cpu))
>  				cpumask_clear_cpu(cpu, hctx->cpumask);
>  		}
> +		rcu_read_unlock();

Want me to just take this one separately and get it out of your hair?
Doesn't seem to have any dependencies.

-- 
Jens Axboe

