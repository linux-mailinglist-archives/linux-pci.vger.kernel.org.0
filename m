Return-Path: <linux-pci+bounces-43785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26545CE5E51
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 04:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88AE30124D1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 03:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9725F98A;
	Mon, 29 Dec 2025 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCtlTqKH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jn0E/HQE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEC260566
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980442; cv=none; b=l8Hup25DX1wYiXANyGO3NGmCIZORh7mHhdru7V/hSV3l4JR/txWcOmUG4lwoUDANarqtktxFs0kLKLcgU2em/yP9alKceiE76TagF581NUNsip79saSZFZ16O15APdk+RtR90sn5wNJvNxS2qwd9rSZSAnsldgNhtYLmLUruHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980442; c=relaxed/simple;
	bh=i/2pV3I6wfGKU/F6zki7C+oop7j6XFoO7cS1k967DAI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Iw0LOmhH1PIAkE5dUt8fq2tRrKwHt9Kr5S4jvl9ozMkkdskuHQ+skrTrqZ1pwOAqsqyCfCXs1aeaYiHk9IXSGF2CNwpL1tSzZHMvyVUC5rUxK7vffZWOvtuDR0aPFPr8SBO3buyb6xOqFrrNn6+lir0cSGfb4pN5IC4LZrHJEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCtlTqKH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jn0E/HQE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766980438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
	b=HCtlTqKHCWpuLpTEmpjiR7Sq7HBpV063dko44Alv2Xt6LT9kOovD7L7yU1qGUbsHJNuXH4
	N5VhrXivjxS9mco4QetyNkvbrnRRFIU5UWxx7pgrBaDgURUBskMCjEnDMitTkipPe9snun
	Tq45oBVZ4j+0xFY3MA7mkGzHNYSQ/h0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-cR57gHArNNy4Eljw3YPN5Q-1; Sun, 28 Dec 2025 22:53:56 -0500
X-MC-Unique: cR57gHArNNy4Eljw3YPN5Q-1
X-Mimecast-MFC-AGG-ID: cR57gHArNNy4Eljw3YPN5Q_1766980435
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9d73d57328so9065384a12.1
        for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 19:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766980435; x=1767585235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
        b=jn0E/HQEL51glzKt+wZtdjjFDVWwxAGNh3v9us6I5CG4JFyJNtHCQJ3i76bQ3KHYsv
         Vf8S9deBnwXNPbq4E97AO7jxQW/P6gxnjM18vxqW5b/aHvRsdhnqXmmS3t28wgUu8YA5
         2C/l3VBgsP1uxbgCToxgYKSFvfHQRBGtqRZgo9YoXuaMX8pwhdBzl2MJbC4rjt2lJBka
         q9n4LZmIwcRgxoqzwA6xK79HL/jKpN4wdjPYHcTUfHTR/+qlYK9G4Sd3acpRdkOh1Pnm
         YK4kD5PLD9Fm+55Mvmr74ECseG55VoY+8vA0sJ313X4AbpLVtM2zZy/BRumT54k5ghJA
         kt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766980435; x=1767585235;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
        b=YfXtcB6p5Fp2S8iCkMS1Bk8cJCJ0+IJmwW0mO4m9gXetKiqW70Wid9nxKCW7FuEHOc
         dl3VHsfwF7sYpAdR233MV337G6A+wSXo3sO9SNEDP6IXCieKtz5hhqTQa5ZviJxD4vgR
         +3qwmLqxSKNEZTJoisgvVbFb5YUegCK0gIwlsBpxJVQs4A0vECgxTGhCJ/LGRuYptxRH
         5bKeB2IZywRDm/lTiIG2rZrhVnl0/y3b0utrlyj3ob/eH6QSn5he0BcSLZQN8a54dixN
         7e5OORAya8Y0k1mROQt31jQqVU5NDFUiY+c4jfB84DgL+25eMzYR9dHbTiVdMAl+JWda
         lLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAxR9ii6yoA9eOlwbD+OcQTV96kPfszBfdxogtp3KpX6CekdMoLIQJ+Iu8bzmNYqRjC/Z9ZmYyb1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVkh39dmQFeHHv4lV1Qrmrr6VSE9gWE+8l18C8kPnB0PLd3zV
	leeVe8qDcjZZh6kV4Eqsh8A/quKSXkms6eG8dtC1t+wCvhmgLgcRNewUKzTWQ9/IST6zyr7zSk0
	OxHmH+zzBhedLp0gy0rt1qKOZ/UoQr9aahnDPdiv3Oc4AlPeuEd2HRVKWuMisRw==
X-Gm-Gg: AY/fxX5q8JeC9Bp9YGk0Y45KYAy+2B4KR1KxlYGlCMqDdd2HXsCCAY2DoFJYcVW6Zab
	UoyHHgd2vwtI0iPAr8nk2WwA3slCrM0n4QLb54aSQ18EmEbaHtd8QOp8XB/GTJgu7rYhIiSllMo
	e/V7ln91i30Uj72SMs2RGmaFthXoCjGz0HQy2hbFpxJGrSLmN9hrjJdRckSJakGsYtps/wZVNh6
	VbC29pFpSes+JupVPXAzWDCZe9zODy9aWveMe07Ej5fGeGIx3S/NFuqPGk/HfQ4gvMrPDkv49FN
	gsONVwjAOKJB9zMqxbj1/ho4SRBf/2SicuS5sCursQIDhF4j+W1qdGgC1/D4VpU2ZKHQswjhZzU
	YLLgt1RWL4+6HVzWW5/OyoxPbWCODsi7+RlPE3ppS1adJqhes5jArnbTp
X-Received: by 2002:a05:7301:508a:b0:2af:7429:e53d with SMTP id 5a478bee46e88-2b05ebf88e5mr14193627eec.10.1766980435156;
        Sun, 28 Dec 2025 19:53:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwUgAvkgKwyfAg/XY7OmY8/35HtixZhtufU5RpA+DoSNpJWPgIxTe0gLEz02J7RhXsL5qbsA==
X-Received: by 2002:a05:7301:508a:b0:2af:7429:e53d with SMTP id 5a478bee46e88-2b05ebf88e5mr14193600eec.10.1766980434676;
        Sun, 28 Dec 2025 19:53:54 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm69342683eec.3.2025.12.28.19.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 19:53:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <81f201cc-395a-48d7-a1b0-db8c62b93c9e@redhat.com>
Date: Sun, 28 Dec 2025 22:53:41 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent isolated
 cpuset change
To: Zhang Qiao <zhangqiao22@huawei.com>,
 Frederic Weisbecker <frederic@kernel.org>,
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
 <20251224134520.33231-2-frederic@kernel.org>
 <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
Content-Language: en-US
In-Reply-To: <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/28/25 10:23 PM, Zhang Qiao wrote:
> Hi, Weisbecker，
>
> 在 2025/12/24 21:44, Frederic Weisbecker 写道:
>> HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
>> therefore be made modifiable at runtime. Synchronize against the cpumask
>> update using RCU.
>>
>> The RCU locked section includes both the housekeeping CPU target
>> election for the PCI probe work and the work enqueue.
>>
>> This way the housekeeping update side will simply need to flush the
>> pending related works after updating the housekeeping mask in order to
>> make sure that no PCI work ever executes on an isolated CPU. This part
>> will be handled in a subsequent patch.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   drivers/pci/pci-driver.c | 47 ++++++++++++++++++++++++++++++++--------
>>   1 file changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 7c2d9d596258..786d6ce40999 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -302,9 +302,8 @@ struct drv_dev_and_id {
>>   	const struct pci_device_id *id;
>>   };
>>   
>> -static long local_pci_probe(void *_ddi)
>> +static int local_pci_probe(struct drv_dev_and_id *ddi)
>>   {
>> -	struct drv_dev_and_id *ddi = _ddi;
>>   	struct pci_dev *pci_dev = ddi->dev;
>>   	struct pci_driver *pci_drv = ddi->drv;
>>   	struct device *dev = &pci_dev->dev;
>> @@ -338,6 +337,19 @@ static long local_pci_probe(void *_ddi)
>>   	return 0;
>>   }
>>   
>> +struct pci_probe_arg {
>> +	struct drv_dev_and_id *ddi;
>> +	struct work_struct work;
>> +	int ret;
>> +};
>> +
>> +static void local_pci_probe_callback(struct work_struct *work)
>> +{
>> +	struct pci_probe_arg *arg = container_of(work, struct pci_probe_arg, work);
>> +
>> +	arg->ret = local_pci_probe(arg->ddi);
>> +}
>> +
>>   static bool pci_physfn_is_probed(struct pci_dev *dev)
>>   {
>>   #ifdef CONFIG_PCI_IOV
>> @@ -362,34 +374,51 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>>   	dev->is_probed = 1;
>>   
>>   	cpu_hotplug_disable();
>> -
>>   	/*
>>   	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
>>   	 * device is probed from work_on_cpu() of the Physical device.
>>   	 */
>>   	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>>   	    pci_physfn_is_probed(dev)) {
>> -		cpu = nr_cpu_ids;
>> +		error = local_pci_probe(&ddi);
>>   	} else {
>>   		cpumask_var_t wq_domain_mask;
>> +		struct pci_probe_arg arg = { .ddi = &ddi };
>> +
>> +		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
>>   
>>   		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
>>   			error = -ENOMEM;
> If we return from here, arg.work will not be destroyed.
>
>
Right. INIT_WORK_ONSTACK() should be called after successful 
cpumask_var_t allocation.

Cheers,
Longman

>>   			goto out;
>>   		}
>> +
>> +		/*
>> +		 * The target election and the enqueue of the work must be within
>> +		 * the same RCU read side section so that when the workqueue pool
>> +		 * is flushed after a housekeeping cpumask update, further readers
>> +		 * are guaranteed to queue the probing work to the appropriate
>> +		 * targets.
>> +		 */
>> +		rcu_read_lock();
>>   		cpumask_and(wq_domain_mask,
>>   			    housekeeping_cpumask(HK_TYPE_WQ),
>>   			    housekeeping_cpumask(HK_TYPE_DOMAIN));
>>   
>>   		cpu = cpumask_any_and(cpumask_of_node(node),
>>   				      wq_domain_mask);
>> +		if (cpu < nr_cpu_ids) {
>> +			schedule_work_on(cpu, &arg.work);
>> +			rcu_read_unlock();
>> +			flush_work(&arg.work);
>> +			error = arg.ret;
>> +		} else {
>> +			rcu_read_unlock();
>> +			error = local_pci_probe(&ddi);
>> +		}
>> +
>>   		free_cpumask_var(wq_domain_mask);
>> +		destroy_work_on_stack(&arg.work);
>>   	}
>> -
>> -	if (cpu < nr_cpu_ids)
>> -		error = work_on_cpu(cpu, local_pci_probe, &ddi);
>> -	else
>> -		error = local_pci_probe(&ddi);
>>   out:
>>   	dev->is_probed = 0;
>>   	cpu_hotplug_enable();
>>


