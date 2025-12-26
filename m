Return-Path: <linux-pci+bounces-43744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFBFCDF1B0
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 00:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2CCA3000935
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6694C298CB2;
	Fri, 26 Dec 2025 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5ULQChj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGMgwsnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FE1391
	for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766790536; cv=none; b=Is7KdWEhlKD+0rFQ1XQQ2mZExXY9BhOYUcdrhVH+U+fmCvRYQI6Fd+mHfyfhSS17Xc+QeWh16VqxTd/2C6jclkRw4jirBf39WJ325FLboJ2xUWFEsjrZ2IyuCJ6vb8auLr/8ePpLUNkMsA4NGi+RZZlTF1/Sv03K6RHZkQVHCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766790536; c=relaxed/simple;
	bh=oghaDqCtoGuDQNAmtHfUkftbTAQMnzWTPNUYgFydFis=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZrBnakCq37b4/KGN9dAOoQRsUrm9EQJ4sK0xWaztCVdr8gMPnMdDCzV08AsaMlcn8N6rUtID2dnJIBChhEuckeEkeNllDoXST9gEx/7mx5gu/xmVMggUx9RcqKF1EGHo/nXVf76ZRL63ku7W96OJ0C8px77o5c0TZgOdu1KBBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5ULQChj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGMgwsnv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766790533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
	b=N5ULQChj3waHbp5JqOilPGouwqSvFnriOeVsIcIceHVuRNFf+tQ3+oRsuiOqgBXlJ//H94
	vAKxXsupdXBy363SM/u6u7X9NWKbGjvZozmeJjg3GksuMzqVFkFx130Oz0j/ViDgIlTSdx
	PNe3kVV9U2QuHVm3T1ndtjdTyNW8Dqw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-1rz7yuKcMtG-FtySthIkOg-1; Fri, 26 Dec 2025 18:08:52 -0500
X-MC-Unique: 1rz7yuKcMtG-FtySthIkOg-1
X-Mimecast-MFC-AGG-ID: 1rz7yuKcMtG-FtySthIkOg_1766790532
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8804b991976so182733926d6.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Dec 2025 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766790532; x=1767395332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
        b=dGMgwsnv0ChuiXtLIILgLtrBDzrl/8rCZlKeDtFn6vlyqKI3A3ulUNtS4MJEaWzGJg
         g253MNP+/r7OZjMZIm0KBgWZH1cfclKY+IUasqv9Uuk7rFAIL36uc/l4Y5ehbzQGX1B5
         H2iE79XQnxOH+ji2ExBkeq8tYKRabhSoKIpg9HnWYySn3GCv1GxDtBhGdY1Lbh++GizH
         o0gWSAqGxns5+2l/VtkIm01L4g5jaNxedVoqr1jEby4WlEQDO/A7WTBL7v9Gy5oF4XvO
         rUfmrTyQxddn2AI0+5Zzs7k42xgj7UoqHOXPIkx2TvSAX91bX3dx7cChlqz53Fz++WLN
         n/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766790532; x=1767395332;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
        b=CRakfKZ5UcnEUb0Yl3YbQnj3ar14FUn9CiI5f/IuJv+PxKjRBNVfKR0/MRXOZIbFf5
         SLp3aoZt2NUbn0qGx5kp6M39pxostvmkYiphXoC26x0kFk1m9HInHsxrbAR+rOyOD+FV
         W9olPNet0S/37OhsfE6bGiS4hQUYsoN6rl1UqWyoyYiVc/TDK1izt408Qiln8QaWtrKa
         arH+TjaMKwRmZV4Crr7Jp7RZHzKtCms9lPADF+OIxksLZFQ1551TpooolEGpaJv1j/cx
         sBWqHLTC1weJjgGQ4Z1uG/MfqdLthSf7ypwOz6WTx2xYhxG7+ykGiRzpYxwSUXaw1IcP
         IvNw==
X-Forwarded-Encrypted: i=1; AJvYcCUxd2wWsE5vAwSiLFKpnWhJJXPBorDEXllMI2gJmBon31VlZkwSa2Nrgujo6B+QS0LlmDmcxbR4G4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LLhwFZZswJPkeNCxC+YgYzgjlC+MJEZfZiWZmF//sPpm4lo4
	Wht0TssboPzyhoM1MZqKkqiVJODUkLpJZQYizVhZrXuVYYLeNXWS3iUYLdXvxQsEolmDjEvggfa
	MqsXisl6Dh2OMNGog7KCjREOrlVpoSjAnl1fK+egZZklPLv3ri7YiRurKuqy7Hg==
X-Gm-Gg: AY/fxX7DsKiGh8ieZ38XB8u+jOfHA2yrJ6cD4nKwHmMLsWK+OeTa7NtwSeEG5UNR/RD
	mIRtQzt47iqbCCQC7YIWkgl2NHmuNUapNajbWBCkXtVTbYwWtTO2UhzmsCJ3TvTb03V+uFTuQ6w
	EBNfyqXsk7EsaREEW44iXPVv8laHAo1R2fAl5FZA6Avvg4GPdQmRKihKdovkjfS8uxCH5UVUbYs
	McsFLlQYTre8iY0DJl55SKjdeC1HpPS92En1MEpsWHzuhJu+PvJh5IB1XNTAr/IEHIC7JUWSczD
	1gSp170WBGjXtvNk8Ke8cSgWhuHMQqqH+TZZdI1MenWGnFYo2cEJUN18JCv6eFRw/ohhr+xWjTg
	syS1Yetu9w93qjscdAbGItr8wXMVImGTd2hOrTV5hROcDl0MOgi1AEd6A
X-Received: by 2002:a05:6214:48b:b0:890:e31:9685 with SMTP id 6a1803df08f44-8900e319a28mr37823556d6.69.1766790532037;
        Fri, 26 Dec 2025 15:08:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpv55vF+vDJeT6imxDEvVCM6zgRYx4B3T4/k2S1vjNooJ5kJOtFWemCi2nC+rcnjO9pXNW8Q==
X-Received: by 2002:a05:6214:48b:b0:890:e31:9685 with SMTP id 6a1803df08f44-8900e319a28mr37823076d6.69.1766790531561;
        Fri, 26 Dec 2025 15:08:51 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7dc1esm173664886d6.39.2025.12.26.15.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 15:08:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2f892ef9-1965-486d-beab-eacf0b6b0386@redhat.com>
Date: Fri, 26 Dec 2025 18:08:43 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] sched: Switch the fallback task allowed cpumask to
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
 <20251224134520.33231-29-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-29-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Tasks that have all their allowed CPUs offline don't want their affinity
> to fallback on either nohz_full CPUs or on domain isolated CPUs. And
> since nohz_full implies domain isolation, checking the latter is enough
> to verify both.
>
> Therefore exclude domain isolation from fallback task affinity.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/mmu_context.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
> index ac01dc4eb2ce..ed3dd0f3fe19 100644
> --- a/include/linux/mmu_context.h
> +++ b/include/linux/mmu_context.h
> @@ -24,7 +24,7 @@ static inline void leave_mm(void) { }
>   #ifndef task_cpu_possible_mask
>   # define task_cpu_possible_mask(p)	cpu_possible_mask
>   # define task_cpu_possible(cpu, p)	true
> -# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK)
> +# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_DOMAIN)
>   #else
>   # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
>   #endif
Acked-by: Waiman Long <longman@redhat.com>


