Return-Path: <linux-pci+bounces-43740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BABECDF138
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C7D43007947
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1C0258CED;
	Fri, 26 Dec 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLlGyUwt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRhC2VIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B11E520A
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787214; cv=none; b=P2dI/xZmWEPkwIAnJnCocYiAA5lbsgub1k3k+9fOeA8emr4Cg3sTxm7vRYwMVQHJCqKoXzhqiYfCOJivPD441L8//7IogIb6tABcsouo8XMJszeD+bCmX/eeAaNWO69HDoq9eEREB/zEJfFtk7fXjwLMstGoSHmW2Wp+p0fvvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787214; c=relaxed/simple;
	bh=38SETu3HZwoc8bpPyvY57PyJDti9cAF1uQy2Al3c77g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CK24cPC6JzNvh78MeQSWEmxQu9T3L7H5mM66SUQX4RFwHcVhXlVvMNMbtgkFLjtmAZc6XLpcRxJcbsLQMCEcsCXz11efxdIl7NnksqttQ9/yH9cIG3l/0kHyqDX+9Mbsh09ARvPYkLvc53yXWNEMm77nXvhQR+1Vyp9WL+D8kdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLlGyUwt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRhC2VIt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766787212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
	b=RLlGyUwtYevISZY2BzXkC+HU2I13BJVJnZfdig3vmf1eRamCR6Z5+pBqr9wf1y5Gh76d8l
	uwjAfSZrC3YEokcCIZU7r+bV0UqYuQdTPhGNAe+phYMbNYerhjryR/wEpLw/JAvgPLwK24
	/1qDKqfSCVpV5gLipzIhB33e1BMKU+Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-bM7_98IZPFCq53NDNWCq1A-1; Fri, 26 Dec 2025 17:13:31 -0500
X-MC-Unique: bM7_98IZPFCq53NDNWCq1A-1
X-Mimecast-MFC-AGG-ID: bM7_98IZPFCq53NDNWCq1A_1766787210
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a360b8086so182216556d6.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766787210; x=1767392010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
        b=FRhC2VItRuJvOg2H7zCbbHgRrbqiQs7UhLao4Y5EJob/ZLXo7HRhCK0SFMQHx9oylD
         Et5xRRYE8wpnraa7C4PoZT79EZvfYkJlCpn7o+yGMGqQkQqS/Sd1uAfLsrcQpwp0Rdfj
         nHaNosZwd/L3bxQawUw66njcan+mTievdwuVyj966FFivyOzGn5UHw7h9avcAdnC2lA1
         a0qM2HhshEGXRGzm4/V6XEnhiwKBnSALZHK+HfFbAje8h9rFpjUsgqSXf6PG0pdKOMU9
         1l+EOVPwigSiRKDsy2rYt3bQ6a5v4aqnFDum2zbORqxcV7sqsOqQ7GbTByuAt8LSEPrW
         kb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766787210; x=1767392010;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
        b=ddGjMbjePzvUpkgqCCKND/5ULDVMbIiDeL5+Pz9NOp6IeGDeH4QUWPH9t4lzPgKyYb
         K3scwi26vlhScXG2VY1sLECesXzDkON1W0eWg6WjZiffsqwhsvCThfSKKtHpDDfKFG9V
         FzVZgAh7tghBk3OwOUW/an9uzyawo8K/IMLIoY50U9w5RC4zsyLRPTfQ8dXVbiLJtyeO
         /CfzYl7jgCygHHOy18j18eT+aMpyWhV03QhWBIaNQ5uk5G5HX0kS5sW6DhaFDemzlT8x
         ef/2Vt51NKE1QqUy5ZhxPmN5M+JoGPfb5hnuG4Jb8kzVrCrbJp5vvpSncpEVMfZdS10Q
         w1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3/zR1/yftYioDJasJGOnxxJL0JGLtd3ejDWy7Gj/pqq4cFn1S9rVVdQkeIhcBFxdyTeTX1ypS3lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGB4Ph14S6vrNYiBS3mkWuEGHPpNWmChimMUaF0VQ440tM2Ex0
	gafzHbNCSFRmc26WJrzKPeoSiAgMOdhhLwT+I4E+BaRkavvXSWlPzfKkFev7gYenuBkR4ECBQ1N
	aX6VVPtpgYFuG0/r4JB2bJ70hukA4nUADqQs+huLEytUU968ggpub4321SxiZXw==
X-Gm-Gg: AY/fxX7H2mXJvZ75oET/4RMU5BPu62DPli6w8Km6+2L3d7ucyJ5i1O1RQRKknu9yIV7
	cqE4ccjJQgZeBzelhaSt94UCRfdb9w81ShvHT+wPo4lHiUg9B9tf8WXkIfBuWVPsomQVolVSxOJ
	JLFoSHO/feczQX1PpuTVw1j8C0EVL/B7uqyMd0hqjLfCl7H3wNP1vX8eRa4lub43dJPSntUO8ID
	DbmcuckSkCiP/AmLL1hhEomotaGY6TTNeZBXwxwhm9RTzwM9n3F66JEqSMmVVtMWIS87eRQ2H27
	4GctQf0t6wO8DtLOaebU994GnUU5Vcap6xsK1BlMu84vTmC9KttiljvHDs8xsjXT3GEERilfFfN
	COgj+cdCrQTE66qwdtKHGAY3BZBbmT8+NAAU1ejjcujhL4T5b3ohFLeIO
X-Received: by 2002:a05:6214:c2e:b0:888:8047:e514 with SMTP id 6a1803df08f44-88d81278a7bmr406254576d6.5.1766787210453;
        Fri, 26 Dec 2025 14:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYVLwcCzEd9vRQ5ZAiqiA7WVLjHHO5Pqc++xoxQfNciNGScOhGispLouTYQ6DDT3yyTzTvrQ==
X-Received: by 2002:a05:6214:c2e:b0:888:8047:e514 with SMTP id 6a1803df08f44-88d81278a7bmr406253916d6.5.1766787209977;
        Fri, 26 Dec 2025 14:13:29 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4d5b4c975sm115870181cf.1.2025.12.26.14.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 14:13:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <48f8bff9-178c-4ab7-a8ef-7edba9b0e7bb@redhat.com>
Date: Fri, 26 Dec 2025 17:13:25 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] kthread: Include kthreadd to the managed affinity
 list
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
 <20251224134520.33231-27-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-27-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> The unbound kthreads affinity management performed by cpuset is going to
> be imported to the kthread core code for consolidation purposes.
>
> Treat kthreadd just like any other kthread.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 51c0908d3d02..85ccf5bb17c9 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -818,12 +818,13 @@ int kthreadd(void *unused)
>   	/* Setup a clean context for our children to inherit. */
>   	set_task_comm(tsk, comm);
>   	ignore_signals(tsk);
> -	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KTHREAD));
>   	set_mems_allowed(node_states[N_MEMORY]);
>   
>   	current->flags |= PF_NOFREEZE;
>   	cgroup_init_kthreadd();
>   
> +	kthread_affine_node();
> +
>   	for (;;) {
>   		set_current_state(TASK_INTERRUPTIBLE);
>   		if (list_empty(&kthread_create_list))
Reviewed-by: Waiman Long <longman@redhat.com>


